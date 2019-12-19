Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD831264B1
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2019 15:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfLSO3i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Dec 2019 09:29:38 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51574 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726779AbfLSO3i (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 19 Dec 2019 09:29:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576765776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B+YvWMgOsGoSjLyWhbRCH8SmTroo6sE60iit6KR/8Gk=;
        b=JPOWZZvv45ewNhcznKUNpW2gdYu8NTE7/SYst8M5xscirY1Q1gF+8zyEzyNPmFNEtKAtVw
        VeCseS7bc+jYav6bzmxMtoiDuIFolkQ9Zr5dSGeWvq7AcsnKgxw1AL9VG1nGBqruLgEaQ8
        5SjS/7OaBHMFQNAPkVpayM8v+iDn/Sk=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-7t2AoXDpNDOKdfj5fLilDQ-1; Thu, 19 Dec 2019 09:29:34 -0500
X-MC-Unique: 7t2AoXDpNDOKdfj5fLilDQ-1
Received: by mail-lj1-f199.google.com with SMTP id d14so271710ljg.17
        for <bpf@vger.kernel.org>; Thu, 19 Dec 2019 06:29:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=B+YvWMgOsGoSjLyWhbRCH8SmTroo6sE60iit6KR/8Gk=;
        b=j3kFynL8R7D9dj6W+kBBDwzqyxUmBLj5S/S/OwMTT+4l5Ed17ZLy0ACIvebuGJIY1Z
         rR368MHochsoBzFOPPwvW1ss/DsD246K3BL4Xzavv6A3V458e8MlqtX9xrWL2kWsVc1K
         8/x5290otewGk9PkQ82HbUad4BTCrg9nVMKKZj3zJ+naRju27gBbQbI5ghnnv3RTUyqC
         aiLlD1nrHnMZQDpXYDfAFxlJlzy05SG/bM6xkPn2hl7DDkyghzphJvQ3fRXc/vQgJGtr
         j2WsZq+b3qV7330RUCTFnZfT32QbkXh0BOeEUS76XEfgh5/wbZoEQ1Fuj9PmKdwhbD9D
         I4dg==
X-Gm-Message-State: APjAAAVAtV4Nw6zR00O4aGYPh+UybOSfxxaHTr7r59UBF/oqwr9Jou/t
        SlHP4ZdzcUqcdhdQ55poDPlDLW7X5vXLBOJxxMV4JJWHXiGB/j6u2e29Em2SHLDmJtHKyL5+TG6
        zBVTQXQWCrjlH
X-Received: by 2002:a2e:9544:: with SMTP id t4mr5989424ljh.219.1576765773414;
        Thu, 19 Dec 2019 06:29:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqzcVR08tUQoGciVvt1UDZly/e6RgnP9nmLymcv5uFnMocXz/89rtxFf96GyiPCfZYoiKR33Og==
X-Received: by 2002:a2e:9544:: with SMTP id t4mr5989407ljh.219.1576765773249;
        Thu, 19 Dec 2019 06:29:33 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id i4sm3636540lji.0.2019.12.19.06.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 06:29:32 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A2F4318096A; Thu, 19 Dec 2019 15:29:31 +0100 (CET)
Subject: [PATCH RFC bpf-next 1/3] libbpf: Add new bpf_object__load2() using
 new-style opts
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Thu, 19 Dec 2019 15:29:31 +0100
Message-ID: <157676577159.957277.7471130922810004500.stgit@toke.dk>
In-Reply-To: <157676577049.957277.3346427306600998172.stgit@toke.dk>
References: <157676577049.957277.3346427306600998172.stgit@toke.dk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

Since we introduced DECLARE_LIBBPF_OPTS and related macros for declaring
function options, that is now the preferred way to extend APIs. Introduce a
variant of the bpf_object__load() function that uses this function, and
deprecate the _xattr variant. Since all the good function names were taken,
the new function is unimaginatively called bpf_object__load2().

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/lib/bpf/libbpf.c   |   31 ++++++++++++++++++-------------
 tools/lib/bpf/libbpf.h   |   13 +++++++++++++
 tools/lib/bpf/libbpf.map |    1 +
 3 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index febbaac3daf4..266b725e444b 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4844,15 +4844,12 @@ static int bpf_object__resolve_externs(struct bpf_object *obj,
 	return 0;
 }
 
-int bpf_object__load_xattr(struct bpf_object_load_attr *attr)
+int bpf_object__load2(struct bpf_object *obj,
+		      const struct bpf_object_load_opts *opts)
 {
-	struct bpf_object *obj;
 	int err, i;
 
-	if (!attr)
-		return -EINVAL;
-	obj = attr->obj;
-	if (!obj)
+	if (!obj || !OPTS_VALID(opts, bpf_object_load_opts))
 		return -EINVAL;
 
 	if (obj->loaded) {
@@ -4867,8 +4864,10 @@ int bpf_object__load_xattr(struct bpf_object_load_attr *attr)
 	err = err ? : bpf_object__sanitize_and_load_btf(obj);
 	err = err ? : bpf_object__sanitize_maps(obj);
 	err = err ? : bpf_object__create_maps(obj);
-	err = err ? : bpf_object__relocate(obj, attr->target_btf_path);
-	err = err ? : bpf_object__load_progs(obj, attr->log_level);
+	err = err ? : bpf_object__relocate(obj,
+					   OPTS_GET(opts, target_btf_path, NULL));
+	err = err ? : bpf_object__load_progs(obj,
+					     OPTS_GET(opts, log_level, 0));
 	if (err)
 		goto out;
 
@@ -4884,13 +4883,19 @@ int bpf_object__load_xattr(struct bpf_object_load_attr *attr)
 	return err;
 }
 
-int bpf_object__load(struct bpf_object *obj)
+int bpf_object__load_xattr(struct bpf_object_load_attr *attr)
 {
-	struct bpf_object_load_attr attr = {
-		.obj = obj,
-	};
+	DECLARE_LIBBPF_OPTS(bpf_object_load_opts, opts,
+	    .log_level = attr->log_level,
+	    .target_btf_path = attr->target_btf_path,
+	);
+
+	return bpf_object__load2(attr->obj, &opts);
+}
 
-	return bpf_object__load_xattr(&attr);
+int bpf_object__load(struct bpf_object *obj)
+{
+	return bpf_object__load2(obj, NULL);
 }
 
 static int make_parent_dir(const char *path)
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index fe592ef48f1b..ce86277d7445 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -132,8 +132,21 @@ struct bpf_object_load_attr {
 	const char *target_btf_path;
 };
 
+struct bpf_object_load_opts {
+	/* size of this struct, for forward/backward compatiblity */
+	size_t sz;
+	/* log level on load */
+	int log_level;
+	/* BTF path (for CO-RE relocations) */
+	const char *target_btf_path;
+};
+#define bpf_object_load_opts__last_field target_btf_path
+
 /* Load/unload object into/from kernel */
 LIBBPF_API int bpf_object__load(struct bpf_object *obj);
+LIBBPF_API int bpf_object__load2(struct bpf_object *obj,
+				 const struct bpf_object_load_opts *opts);
+/* deprecated, use bpf_object__load2() instead */
 LIBBPF_API int bpf_object__load_xattr(struct bpf_object_load_attr *attr);
 LIBBPF_API int bpf_object__unload(struct bpf_object *obj);
 
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index e3a471f38a71..d6cb860763d1 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -217,6 +217,7 @@ LIBBPF_0.0.7 {
 		bpf_object__attach_skeleton;
 		bpf_object__destroy_skeleton;
 		bpf_object__detach_skeleton;
+		bpf_object__load2;
 		bpf_object__load_skeleton;
 		bpf_object__open_skeleton;
 		bpf_program__attach;

