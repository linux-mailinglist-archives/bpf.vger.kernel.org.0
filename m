Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611D5342A59
	for <lists+bpf@lfdr.de>; Sat, 20 Mar 2021 05:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhCTEQ2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 20 Mar 2021 00:16:28 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]:41689 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbhCTEQ2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 20 Mar 2021 00:16:28 -0400
Received: by mail-qt1-f173.google.com with SMTP id x9so8418666qto.8
        for <bpf@vger.kernel.org>; Fri, 19 Mar 2021 21:16:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=84nwH9LI3a5tYboxWSEAkYkd1DKjH4KTDYuiIiQRDlU=;
        b=Q32vcvlDkrsFhkrdUDZL3OCzH4CAjVSKY3DIWXOcz2zXVBnA+DDJfSe72O5mn0tUDn
         2LT3iwjX36kWtG+hAMOdf/mBuiEnuIkZ/BGQLWJHui7vNGZ7K9ck5ndfp0hMazeDmSJF
         RyjfSI9AlePkqBmifOSmY7UtW3mPEQA3clAzy9gEfRWkwUQrxGd+fQvW2D5jR5ehGsJk
         L+oweKRR4xV6nMUzp1tiJ0O9x1XHiwFmq0Cd2Nh+bRTllOd3QyPM8kkB52LRh6eku9yG
         kPk80Kh5yfPGhpxOAjuswN/fNjqT0imZtMhAdukFndu1MfpW5NBon/4R7+Gejm+gO/lK
         WkYQ==
X-Gm-Message-State: AOAM533K/tYUFZear75AJNic3gPQDTqLQqWs1+gKPsFRSnJSvLKQPmL7
        wOLPDY9ogBf27zQfAEHU8luPuHVwyN+8
X-Google-Smtp-Source: ABdhPJww/XF2Pvpx7viZjqNF3gbYw4wtrXNAswHpPq3rveEV0pwcGwYRyn0DEF5Grc+Y9FCzQ2vlMQ==
X-Received: by 2002:ac8:431e:: with SMTP id z30mr1631158qtm.216.1616213786797;
        Fri, 19 Mar 2021 21:16:26 -0700 (PDT)
Received: from fujitsu.celeiro.cu ([138.204.26.16])
        by smtp.gmail.com with ESMTPSA id j6sm6035363qkm.81.2021.03.19.21.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 21:16:26 -0700 (PDT)
From:   Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
To:     bpf@vger.kernel.org, rafaeldtinoco@ubuntu.com
Cc:     andrii.nakryiko@gmail.com, daniel@iogearbox.net
Subject: [PATCH] libbpf: add bpf object kern_version attribute setter
Date:   Sat, 20 Mar 2021 01:16:23 -0300
Message-Id: <20210320041623.2241647-1-rafaeldtinoco@ubuntu.com>
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
 src/libbpf.c | 15 +++++++++++++++
 src/libbpf.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/src/libbpf.c b/src/libbpf.c
index 0c4a386..7b52cd6 100644
--- a/src/libbpf.c
+++ b/src/libbpf.c
@@ -8278,6 +8278,21 @@ int bpf_object__btf_fd(const struct bpf_object *obj)
 	return obj->btf ? btf__fd(obj->btf) : -1;
 }
 
+int bpf_object__set_kversion(struct bpf_object *obj, char *kern_version)
+{
+	__u32 major, minor, patch;
+
+	if (!kern_version) {
+		obj->kern_version = 0;
+		return 0;
+	}
+	if (sscanf(kern_version, "%u.%u.%u", &major, &minor, &patch) != 3)
+		return -1;
+	obj->kern_version = KERNEL_VERSION(major, minor, patch);
+
+	return 0;
+}
+
 int bpf_object__set_priv(struct bpf_object *obj, void *priv,
 			 bpf_object_clear_priv_t clear_priv)
 {
diff --git a/src/libbpf.h b/src/libbpf.h
index 3c35eb4..3e14ae7 100644
--- a/src/libbpf.h
+++ b/src/libbpf.h
@@ -143,6 +143,7 @@ LIBBPF_API int bpf_object__unload(struct bpf_object *obj);
 
 LIBBPF_API const char *bpf_object__name(const struct bpf_object *obj);
 LIBBPF_API unsigned int bpf_object__kversion(const struct bpf_object *obj);
+LIBBPF_API int bpf_object__set_kversion(struct bpf_object *obj, char *kern_version);
 
 struct btf;
 LIBBPF_API struct btf *bpf_object__btf(const struct bpf_object *obj);
-- 
2.27.0

