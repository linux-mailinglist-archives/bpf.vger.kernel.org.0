Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B7C4260DB
	for <lists+bpf@lfdr.de>; Fri,  8 Oct 2021 02:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234235AbhJHAFS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Oct 2021 20:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234163AbhJHAFR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Oct 2021 20:05:17 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404F6C061570
        for <bpf@vger.kernel.org>; Thu,  7 Oct 2021 17:03:23 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id qe4-20020a17090b4f8400b0019f663cfcd1so8177583pjb.1
        for <bpf@vger.kernel.org>; Thu, 07 Oct 2021 17:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MaKolbiSIZFTAsWthjo8QGM6mKDE5A1qdREoJQwIN3w=;
        b=UNPn4p+O8xVSMpVXZGRR8jiqOUDte1UyqP1j3Q+CSYa5VQNTWa+j2b9UKgBVwQATld
         kIgjsLN/9GCkG/2MNbaGzp0UU4nXvzE5/mzVdIJdZj0Yw2fq1Jdv08KtZhf36d8NcLNW
         TSW+juF20OXjqmlvBLArfU7JD8t1jnUqfc4G3E12Md/wbjzmUZsdmOXIaKQQ3CuTgtLT
         E8np4Ho6G/4DP7CPW5S7jwE4kBwIFpE2D/O+l6PWJIVrGYQKTcjRJRUJyaDtUM9aNs2r
         x9EqwGuqK6ihmbnBDPmUxh9fmA48/miby8xJI0KKRFx2Q1N2bBDJNxiWABFORjYUF7/j
         Xzng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MaKolbiSIZFTAsWthjo8QGM6mKDE5A1qdREoJQwIN3w=;
        b=AgM4uj2K14B39cAd9X/92PkseDmHeQDynPcWEEvZUry/hJBsSApg5EBoRgh/Y+kMtY
         CUqhbm23Y4aqs8wy0KzBOmkp4BgOb1SCWAQZbE+kL5w4AEoKNJXbXg/BoVbpdTklCihG
         MLKLLb6mxJS2SYFIVf8l0vVmpoYwvjnKMItSZYb3KRamuEJMCkeaDTv24jAVKb5ShG/5
         x3yJFDx+VD92xD9JuOn4JlrXfB070KzHdHQxUj5eDkVYg2wSvtX+4m9U20n7ruAF//R0
         hcSBb6M8nyHbMdDQT7/VdsdScngdJm3t6PI/+Ezu+b7ZHx+obDKKAGDJAPD8FK9xnO67
         FDUA==
X-Gm-Message-State: AOAM533uzkZY3ZastvTOB4CQhE7Pi02EnqzIHItA9xIAKYVBg9YXogfE
        jAOHQmHX0h/BB4UXKx8vyeOvP0ZvTTaHmA==
X-Google-Smtp-Source: ABdhPJywUySXFB9ijXgY1Iqj6HFRycld6WVyeLfZLvM9gNHmAVHQBxZhlyVHCS/UPCO5BhKNIIdyCw==
X-Received: by 2002:a17:90a:8404:: with SMTP id j4mr8600272pjn.204.1633651402678;
        Thu, 07 Oct 2021 17:03:22 -0700 (PDT)
Received: from andriin-mbp.thefacebook.com ([2620:10d:c090:500::e050])
        by smtp.gmail.com with ESMTPSA id o2sm9397826pja.7.2021.10.07.17.03.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Oct 2021 17:03:22 -0700 (PDT)
From:   andrii.nakryiko@gmail.com
X-Google-Original-From: andrii@kernel.org
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     andrii@kernel.org, kernel-team@fb.com
Subject: [PATCH bpf-next 02/10] libbpf: extract ELF processing state into separate struct
Date:   Thu,  7 Oct 2021 17:03:01 -0700
Message-Id: <20211008000309.43274-3-andrii@kernel.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211008000309.43274-1-andrii@kernel.org>
References: <20211008000309.43274-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Andrii Nakryiko <andrii@kernel.org>

Name currently anonymous internal struct that keeps ELF-related state
for bpf_object. Just a bit of clean up, no functional changes.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 70 ++++++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 36 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 994dd25e36cd..b88e3259edba 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -462,6 +462,35 @@ struct module_btf {
 	int fd_array_idx;
 };
 
+struct elf_state {
+	int fd;
+	const void *obj_buf;
+	size_t obj_buf_sz;
+	Elf *elf;
+	GElf_Ehdr ehdr;
+	Elf_Data *symbols;
+	Elf_Data *data;
+	Elf_Data *rodata;
+	Elf_Data *bss;
+	Elf_Data *st_ops_data;
+	size_t shstrndx; /* section index for section name strings */
+	size_t strtabidx;
+	struct {
+		GElf_Shdr shdr;
+		Elf_Data *data;
+	} *reloc_sects;
+	int nr_reloc_sects;
+	int maps_shndx;
+	int btf_maps_shndx;
+	__u32 btf_maps_sec_btf_id;
+	int text_shndx;
+	int symbols_shndx;
+	int data_shndx;
+	int rodata_shndx;
+	int bss_shndx;
+	int st_ops_shndx;
+};
+
 struct bpf_object {
 	char name[BPF_OBJ_NAME_LEN];
 	char license[64];
@@ -484,40 +513,10 @@ struct bpf_object {
 
 	struct bpf_gen *gen_loader;
 
+	/* Information when doing ELF related work. Only valid if efile.elf is not NULL */
+	struct elf_state efile;
 	/*
-	 * Information when doing elf related work. Only valid if fd
-	 * is valid.
-	 */
-	struct {
-		int fd;
-		const void *obj_buf;
-		size_t obj_buf_sz;
-		Elf *elf;
-		GElf_Ehdr ehdr;
-		Elf_Data *symbols;
-		Elf_Data *data;
-		Elf_Data *rodata;
-		Elf_Data *bss;
-		Elf_Data *st_ops_data;
-		size_t shstrndx; /* section index for section name strings */
-		size_t strtabidx;
-		struct {
-			GElf_Shdr shdr;
-			Elf_Data *data;
-		} *reloc_sects;
-		int nr_reloc_sects;
-		int maps_shndx;
-		int btf_maps_shndx;
-		__u32 btf_maps_sec_btf_id;
-		int text_shndx;
-		int symbols_shndx;
-		int data_shndx;
-		int rodata_shndx;
-		int bss_shndx;
-		int st_ops_shndx;
-	} efile;
-	/*
-	 * All loaded bpf_object is linked in a list, which is
+	 * All loaded bpf_object are linked in a list, which is
 	 * hidden to caller. bpf_objects__<func> handlers deal with
 	 * all objects.
 	 */
@@ -551,7 +550,6 @@ struct bpf_object {
 
 	char path[];
 };
-#define obj_elf_valid(o)	((o)->efile.elf)
 
 static const char *elf_sym_str(const struct bpf_object *obj, size_t off);
 static const char *elf_sec_str(const struct bpf_object *obj, size_t off);
@@ -1185,7 +1183,7 @@ static struct bpf_object *bpf_object__new(const char *path,
 
 static void bpf_object__elf_finish(struct bpf_object *obj)
 {
-	if (!obj_elf_valid(obj))
+	if (!obj->efile.elf)
 		return;
 
 	if (obj->efile.elf) {
@@ -1210,7 +1208,7 @@ static int bpf_object__elf_init(struct bpf_object *obj)
 	int err = 0;
 	GElf_Ehdr *ep;
 
-	if (obj_elf_valid(obj)) {
+	if (obj->efile.elf) {
 		pr_warn("elf: init internal error\n");
 		return -LIBBPF_ERRNO__LIBELF;
 	}
-- 
2.30.2

