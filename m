Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF67A342F84
	for <lists+bpf@lfdr.de>; Sat, 20 Mar 2021 21:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbhCTU2k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 20 Mar 2021 16:28:40 -0400
Received: from mail-qk1-f171.google.com ([209.85.222.171]:35524 "EHLO
        mail-qk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbhCTU20 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 20 Mar 2021 16:28:26 -0400
Received: by mail-qk1-f171.google.com with SMTP id i9so6643996qka.2
        for <bpf@vger.kernel.org>; Sat, 20 Mar 2021 13:28:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P9DDMbJINT3gpciaWjJ6aXUjz+8PArxXPMNONo4sVgo=;
        b=rD6e8xCGWBs48w7R3Fw/p1Aod9l2AUrPqj3HWCWxiZRAedNz9pRS2bpjc4jKkxcLnx
         iuVlG5qRQT1KIESc8pj7nzGZv3Xj86+XrUIGQYZ6yEO+6df/vKFoMQw17LboYG9UrjNw
         edW/8iU4rBJISDO4Wvnsdk1W3wsMvGtKVhIKR9NIFr0k/OFqRsNWFyFdcAHe2enStHtp
         PneHM7I8Vi+OENW3IlKq7ezukh0gD46qO5D3jnE8CnvNPgBiHyAqo/OhiJZOPHIIX/w4
         bpRTYc3uHqYEeQqTo3mvKRVqOzMncvsGfa5R3YF6oNj11pHmKmtr5SucDvhvrZ5DvCkn
         myxg==
X-Gm-Message-State: AOAM533gKCWL04sAoBAPXsOY0MU0uO+e2t9IV81SNRr1FOIes254T108
        GPBiBIz4xqHkMXb/HfR0Fdx1PQivL5Ka
X-Google-Smtp-Source: ABdhPJyEO1iwaO6xq10aK5slzQfixTeSogY72ONC4Y1/cB8yAa/mUx4mtaZnHOHpAiSdVtt2Rj7wZg==
X-Received: by 2002:a37:bd7:: with SMTP id 206mr4554612qkl.284.1616272105355;
        Sat, 20 Mar 2021 13:28:25 -0700 (PDT)
Received: from fujitsu.celeiro.cu ([138.204.26.16])
        by smtp.gmail.com with ESMTPSA id 46sm6248019qte.7.2021.03.20.13.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 13:28:24 -0700 (PDT)
From:   Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
To:     bpf@vger.kernel.org, rafaeldtinoco@ubuntu.com
Cc:     andrii.nakryiko@gmail.com, daniel@iogearbox.net
Subject: [PATCH v2 bpf-next] libbpf: add bpf object kern_version attribute setter
Date:   Sat, 20 Mar 2021 17:28:21 -0300
Message-Id: <20210320202821.3165030-1-rafaeldtinoco@ubuntu.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Unfortunately some distros don't have their kernel version defined
accurately in <linux/version.h> due to different long term support
reasons.

It is important to have a way to override the bpf kern_version
attribute during runtime: some old kernels might still check for
kern_version attribute during bpf_prog_load().

Signed-off-by: Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
---
 src/libbpf.c | 10 ++++++++++
 src/libbpf.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/src/libbpf.c b/src/libbpf.c
index 2f351d3..3b1c79f 100644
--- a/src/libbpf.c
+++ b/src/libbpf.c
@@ -8278,6 +8278,16 @@ int bpf_object__btf_fd(const struct bpf_object *obj)
 	return obj->btf ? btf__fd(obj->btf) : -1;
 }
 
+int bpf_object__set_kversion(struct bpf_object *obj, __u32 kern_version)
+{
+	if (obj->loaded)
+		return -1;
+
+	obj->kern_version = kern_version;
+
+	return 0;
+}
+
 int bpf_object__set_priv(struct bpf_object *obj, void *priv,
 			 bpf_object_clear_priv_t clear_priv)
 {
diff --git a/src/libbpf.h b/src/libbpf.h
index 3c35eb4..f73ec5b 100644
--- a/src/libbpf.h
+++ b/src/libbpf.h
@@ -143,6 +143,7 @@ LIBBPF_API int bpf_object__unload(struct bpf_object *obj);
 
 LIBBPF_API const char *bpf_object__name(const struct bpf_object *obj);
 LIBBPF_API unsigned int bpf_object__kversion(const struct bpf_object *obj);
+LIBBPF_API int bpf_object__set_kversion(struct bpf_object *obj, __u32 kern_version);
 
 struct btf;
 LIBBPF_API struct btf *bpf_object__btf(const struct bpf_object *obj);
-- 
2.27.0

