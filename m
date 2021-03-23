Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2A0345695
	for <lists+bpf@lfdr.de>; Tue, 23 Mar 2021 05:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbhCWEKa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Mar 2021 00:10:30 -0400
Received: from mail-qv1-f48.google.com ([209.85.219.48]:35686 "EHLO
        mail-qv1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhCWEJ5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Mar 2021 00:09:57 -0400
Received: by mail-qv1-f48.google.com with SMTP id x27so9833984qvd.2
        for <bpf@vger.kernel.org>; Mon, 22 Mar 2021 21:09:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CsOdICbi8MQGq4G/p39yeEh8wgcv3WoS8AesX08CIUs=;
        b=J3/cGaJeIjH+T5C8jm7Y9a7HVd4LmXOGR1glhLWldQR4/490XerjggTAdy7OMaeYKq
         VKuBYLP6lLGN5NORqynh/J/4doGu5nOvF2QDJnpncdltJrlpIJAXxzeLPXWIZDkxKhTt
         Pe8oyFC38Sf/BZqoliDe7r/kSZGlOoPe6Cbmvq7wKn2EKbRo6nEfcFHnxMkm9aPnMspD
         VCqKE18yLHfMKApdpKReYrXgAgtrV1hprq/JFAiStdEXmfhAarBMnIFFVQL6ofBsguP6
         vpswVch2sWeb/z4YnQOYcWqKP3EN1s7F8PGcZz73MujGeKFxaUmID7hdH/XtNz4xPyLK
         LCqw==
X-Gm-Message-State: AOAM531ARDZMhimTBdCP9UOb0tVpOjndaRFAkrJevUfgTEzc7n+dyqtC
        p92SAPA6g0g0CmShzHVePzyUoCDyXFTuuA8=
X-Google-Smtp-Source: ABdhPJzT5BQpcPNTcbsivyh5jpDp+zLJzN6+f2QkGFnc8A8LZDzMYDO6wfyxwZLvC0N8RS6DwbnUmg==
X-Received: by 2002:a05:6214:20ad:: with SMTP id 13mr2950717qvd.35.1616472596171;
        Mon, 22 Mar 2021 21:09:56 -0700 (PDT)
Received: from fujitsu.celeiro.cu ([138.204.26.16])
        by smtp.gmail.com with ESMTPSA id o7sm13007321qkb.104.2021.03.22.21.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 21:09:55 -0700 (PDT)
From:   Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
To:     bpf@vger.kernel.org
Cc:     andrii.nakryiko@gmail.com, rafaeldtinoco@ubuntu.com
Subject: [PATCH v3 bpf-next] libbpf: add bpf object kern_version attribute setter
Date:   Tue, 23 Mar 2021 01:09:52 -0300
Message-Id: <20210323040952.2118241-1-rafaeldtinoco@ubuntu.com>
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
 tools/lib/bpf/libbpf.c   | 10 ++++++++++
 tools/lib/bpf/libbpf.h   |  1 +
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 12 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 058b643cbcb1..3ac3d8dced7f 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8269,6 +8269,16 @@ int bpf_object__btf_fd(const struct bpf_object *obj)
 	return obj->btf ? btf__fd(obj->btf) : -1;
 }
 
+int bpf_object__set_kversion(struct bpf_object *obj, __u32 kern_version)
+{
+	if (obj->loaded)
+		return -EINVAL;
+
+	obj->kern_version = kern_version;
+
+	return 0;
+}
+
 int bpf_object__set_priv(struct bpf_object *obj, void *priv,
 			 bpf_object_clear_priv_t clear_priv)
 {
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index a1a424b9b8ff..cf9bc6f1f925 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -143,6 +143,7 @@ LIBBPF_API int bpf_object__unload(struct bpf_object *obj);
 
 LIBBPF_API const char *bpf_object__name(const struct bpf_object *obj);
 LIBBPF_API unsigned int bpf_object__kversion(const struct bpf_object *obj);
+LIBBPF_API int bpf_object__set_kversion(struct bpf_object *obj, __u32 kern_version);
 
 struct btf;
 LIBBPF_API struct btf *bpf_object__btf(const struct bpf_object *obj);
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 279ae861f568..f5990f7208ce 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -359,4 +359,5 @@ LIBBPF_0.4.0 {
 		bpf_linker__finalize;
 		bpf_linker__free;
 		bpf_linker__new;
+		bpf_object__set_kversion;
 } LIBBPF_0.3.0;
-- 
2.27.0

