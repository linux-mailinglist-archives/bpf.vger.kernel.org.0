Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24FC52EFD28
	for <lists+bpf@lfdr.de>; Sat,  9 Jan 2021 03:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbhAIChD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Jan 2021 21:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbhAIChD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Jan 2021 21:37:03 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49319C061573
        for <bpf@vger.kernel.org>; Fri,  8 Jan 2021 18:36:23 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id n10so8798725pgl.10
        for <bpf@vger.kernel.org>; Fri, 08 Jan 2021 18:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=araalinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=Ib3QpoJ447ggRwcylWma7BQpa/3Z/Z8dLysHF3i/CMc=;
        b=keqyvGxC+M7Lepx67W1uAHPQ/3LCc6aD3K2/1DiJ4W8R+CE1N4nphrvw/NIiLE5cT2
         qH7O/JymAJPrvKET2WaoF8WTXly/t5KNfMB1W2fb0nCL+MF+XQQFt9EPMR7erzhOX0zL
         WK2QbBM3aYQOtMYbKg5w4MBqBezolz0zX24R8crfiPl6TxbQuFa7zXbbHPbkoBoPMGXP
         mLxznzdkk30f2dNd4GY2q9ktZi7uQr6aD7eQ+7s0DzBiPlQ3NLeCbg1EVCRRzsfz3c0h
         bLbMzQkcLtTFFrS/X4UJDehE9FPBxMeFcaYvcKCIBGNumvbQzZgM5KQB4K+AJ1HuDZkh
         7d6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=Ib3QpoJ447ggRwcylWma7BQpa/3Z/Z8dLysHF3i/CMc=;
        b=KFBLL/UPsh/LDp9Lyc4+m0t/vfsqPUmNo4G71UgDqcVEFTb4LZiytrzMtVhxNqfbfl
         wK3mSy3NyWzNwAOoR1KExF2cbLX6Ke7fNZa596+CaFQXpUV0rplTGGwjM5ke1RwSKfg6
         tePJ7Eb1V85FMUt8Rjl2e7vAgWAhH/riPOGOVGVN+NxQA67xOsg86BGCpDnle2RG2xq1
         uDBtWf3AiMbg5dIBhZXXdLM9W5JPs+beB3j97UiQeC8rXrRgmDCu0Pbr2lhvbkwjzFp0
         /WOaxR6s3apOsxn/8XAFlWK8Fv61aKMFZMdwJrH4q9Ft9FzpTkxQAfzot70DQyE+SwEj
         xMrQ==
X-Gm-Message-State: AOAM533AKCTtdKTwEmY8R1bflNjJnCtuToRRSWClptxzw2bsMqN4YKRE
        vONfZCOrjt27htQAK3pFIAA4KodHFLnqlT3A
X-Google-Smtp-Source: ABdhPJwos9BSf0bIGiv90z1ibjMwhRDSkoGSdtbMTbFGkMjYOMwa2qzKBEImd1F7RyXLWMGDPOc4jA==
X-Received: by 2002:a63:c207:: with SMTP id b7mr9799705pgd.184.1610159782187;
        Fri, 08 Jan 2021 18:36:22 -0800 (PST)
Received: from vamsis-mbp.lan ([24.6.74.54])
        by smtp.gmail.com with ESMTPSA id t4sm2248449pfe.212.2021.01.08.18.36.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jan 2021 18:36:21 -0800 (PST)
From:   Vamsi Kodavanty <vamsi@araalinetworks.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: [PATCH bpf v1] Add `core_btf_path` to `bpf_object_open_opts` to pass
 BTF path from skeleton program
Message-Id: <B8801F77-37E8-4EF8-8994-D366D48169A3@araalinetworks.com>
Date:   Fri, 8 Jan 2021 18:36:19 -0800
To:     bpf@vger.kernel.org, andrii.nakryiko@gmail.com
X-Mailer: Apple Mail (2.3445.104.11)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii,
     I have made the following changes as discussed to add an option to =
the `open_opts`
to take in the BTF.
     Please do take a look. Also, I am not sure what the procedure is =
for submitting patches/reviews.=20
If anyone has any pointers to a webpage where this is described I can go =
through it. But, below are
the proposed changes.

Best Regards,
Vamsi.

---
 src/libbpf.c | 56 +++++++++++++++++++++++++++++++++++++---------------
 src/libbpf.h |  4 +++-
 2 files changed, 43 insertions(+), 17 deletions(-)

diff --git a/src/libbpf.c b/src/libbpf.c
index 6ae748f..35d7254 100644
--- a/src/libbpf.c
+++ b/src/libbpf.c
@@ -2538,9 +2538,12 @@ static bool obj_needs_vmlinux_btf(const struct =
bpf_object *obj)
 	struct bpf_program *prog;
 	int i;
=20
-	/* CO-RE relocations need kernel BTF */
+	/* CO-RE relocations need kernel BTF or an override BTF.
+	 * If override BTF present CO-RE can use it.
+	 */
 	if (obj->btf_ext && obj->btf_ext->core_relo_info.len)
-		return true;
+		if (!obj->btf_vmlinux_override)
+			return true;
=20
 	/* Support for typed ksyms needs kernel BTF */
 	for (i =3D 0; i < obj->nr_extern; i++) {
@@ -2561,6 +2564,27 @@ static bool obj_needs_vmlinux_btf(const struct =
bpf_object *obj)
 	return false;
 }
=20
+static int bpf_object__load_override_btf(struct bpf_object *obj,
+										=
 const char *targ_btf_path)
+{
+	/* Could have been be set via `bpf_object_open_opts` */
+	if (obj->btf_vmlinux_override)
+		return 0;
+
+	if (!targ_btf_path)
+		return 0;
+
+	obj->btf_vmlinux_override =3D btf__parse(targ_btf_path, NULL);
+	if (IS_ERR_OR_NULL(obj->btf_vmlinux_override)) {
+		int err =3D PTR_ERR(obj->btf_vmlinux_override);
+		obj->btf_vmlinux_override =3D NULL;
+		pr_warn("failed to parse target BTF: %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
 static int bpf_object__load_vmlinux_btf(struct bpf_object *obj, bool =
force)
 {
 	int err;
@@ -6031,7 +6055,7 @@ patch_insn:
 }
=20
 static int
-bpf_object__relocate_core(struct bpf_object *obj, const char =
*targ_btf_path)
+bpf_object__relocate_core(struct bpf_object *obj)
 {
 	const struct btf_ext_info_sec *sec;
 	const struct bpf_core_relo *rec;
@@ -6045,15 +6069,6 @@ bpf_object__relocate_core(struct bpf_object *obj, =
const char *targ_btf_path)
 	if (obj->btf_ext->core_relo_info.len =3D=3D 0)
 		return 0;
=20
-	if (targ_btf_path) {
-		obj->btf_vmlinux_override =3D btf__parse(targ_btf_path, =
NULL);
-		if (IS_ERR_OR_NULL(obj->btf_vmlinux_override)) {
-			err =3D PTR_ERR(obj->btf_vmlinux_override);
-			pr_warn("failed to parse target BTF: %d\n", =
err);
-			return err;
-		}
-	}
-
 	cand_cache =3D hashmap__new(bpf_core_hash_fn, bpf_core_equal_fn, =
NULL);
 	if (IS_ERR(cand_cache)) {
 		err =3D PTR_ERR(cand_cache);
@@ -6556,14 +6571,14 @@ bpf_object__relocate_calls(struct bpf_object =
*obj, struct bpf_program *prog)
 }
=20
 static int
-bpf_object__relocate(struct bpf_object *obj, const char *targ_btf_path)
+bpf_object__relocate(struct bpf_object *obj)
 {
 	struct bpf_program *prog;
 	size_t i;
 	int err;
=20
 	if (obj->btf_ext) {
-		err =3D bpf_object__relocate_core(obj, targ_btf_path);
+		err =3D bpf_object__relocate_core(obj);
 		if (err) {
 			pr_warn("failed to perform CO-RE relocations: =
%d\n",
 				err);
@@ -7088,7 +7103,7 @@ static struct bpf_object *
 __bpf_object__open(const char *path, const void *obj_buf, size_t =
obj_buf_sz,
 		   const struct bpf_object_open_opts *opts)
 {
-	const char *obj_name, *kconfig;
+	const char *obj_name, *kconfig, *core_btf_path;
 	struct bpf_program *prog;
 	struct bpf_object *obj;
 	char tmp_name[64];
@@ -7126,6 +7141,14 @@ __bpf_object__open(const char *path, const void =
*obj_buf, size_t obj_buf_sz,
 			return ERR_PTR(-ENOMEM);
 	}
=20
+	core_btf_path =3D OPTS_GET(opts, core_btf_path, NULL);
+	if (core_btf_path) {
+		pr_debug("parse btf '%s' for CO-RE relocations\n", =
core_btf_path);
+		obj->btf_vmlinux_override =3D btf__parse(core_btf_path, =
NULL);
+		if (IS_ERR_OR_NULL(obj->btf_vmlinux_override))
+			pr_warn("can't parse btf at '%s'\n", =
core_btf_path);
+	}
+
 	err =3D bpf_object__elf_init(obj);
 	err =3D err ? : bpf_object__check_endianness(obj);
 	err =3D err ? : bpf_object__elf_collect(obj);
@@ -7481,13 +7504,14 @@ int bpf_object__load_xattr(struct =
bpf_object_load_attr *attr)
 	}
=20
 	err =3D bpf_object__probe_loading(obj);
+	err =3D err ? : bpf_object__load_override_btf(obj, =
attr->target_btf_path);
 	err =3D err ? : bpf_object__load_vmlinux_btf(obj, false);
 	err =3D err ? : bpf_object__resolve_externs(obj, obj->kconfig);
 	err =3D err ? : bpf_object__sanitize_and_load_btf(obj);
 	err =3D err ? : bpf_object__sanitize_maps(obj);
 	err =3D err ? : bpf_object__init_kern_struct_ops_maps(obj);
 	err =3D err ? : bpf_object__create_maps(obj);
-	err =3D err ? : bpf_object__relocate(obj, =
attr->target_btf_path);
+	err =3D err ? : bpf_object__relocate(obj);
 	err =3D err ? : bpf_object__load_progs(obj, attr->log_level);
=20
 	/* clean up module BTFs */
diff --git a/src/libbpf.h b/src/libbpf.h
index 3c35eb4..40c4ee9 100644
--- a/src/libbpf.h
+++ b/src/libbpf.h
@@ -93,8 +93,10 @@ struct bpf_object_open_opts {
 	 * system Kconfig for CONFIG_xxx externs.
 	 */
 	const char *kconfig;
+	/* Path to ELF file with BTF section to be used for relocations. =
*/
+	const char *core_btf_path;
 };
-#define bpf_object_open_opts__last_field kconfig
+#define bpf_object_open_opts__last_field core_btf_path
=20
 LIBBPF_API struct bpf_object *bpf_object__open(const char *path);
 LIBBPF_API struct bpf_object *
--=20
2.23.3

