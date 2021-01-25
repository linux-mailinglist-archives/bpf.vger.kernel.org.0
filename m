Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB0F303530
	for <lists+bpf@lfdr.de>; Tue, 26 Jan 2021 06:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbhAZFhH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jan 2021 00:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728239AbhAYNJS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Jan 2021 08:09:18 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A13C06178A
        for <bpf@vger.kernel.org>; Mon, 25 Jan 2021 05:06:41 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id y9so6101107wmi.8
        for <bpf@vger.kernel.org>; Mon, 25 Jan 2021 05:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=F7AnyDl54dMT8pOE1ownSAAEiPW1w7lE/lQbqOo0kHk=;
        b=gEL1ZGEf6L6I9cex2xnE/t/vNl60tu9KjliGn4SahnLmh6CyGc/Lo+XIX8ZjtSUqeO
         1TfQA6qBxqMlBFW2RVP3Po39K+y8a8EvV9LyIjW582NWOYd4fBDtjrHP4IArCiCKpPKG
         yyQckg3gsbosC0cftj2QNTmGUXHK3KHriyb9LW/0HQGrVPgAfWugDiAFVrHBx/t+fKZO
         6vZKxI2/0KWze6DUnm6CzOcgyPHq5XSAQy4FfPOEwN8dkIT5e1G62pUY8ePXmBTKDwOc
         tpNEVZ7MqCVBd+7NQnDmmP/i7F5lDN6o/NH6Jt7691pwkKbw3/dRXlkuyirw7cg0PSN5
         wjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=F7AnyDl54dMT8pOE1ownSAAEiPW1w7lE/lQbqOo0kHk=;
        b=j3qWGdY6UYnKHS78SbJCgNmPqc+4K6kDCX2GV/51AYQrgEKGwXI3EWPRQFORQbzFBO
         2zOSfejWDfGcKEkTZfTl9mVIlTg+ybZAZ4dpHi/B2kmOpkoDCLkk4/kndsuPzgKWXf/f
         UrY9zRVjVfpilyu67asK5FXaf5qHBN+iX2ad2lejlXhMg7cmWNae7b8tF+UieCFr4ZHE
         FTO/oB2+rsGJpro1jXiFsC4CaDQfJzLaWP5xDkpbdeflY3MShpE2POQdCfQ04ppRnxLw
         rF3lXqo+vNhuwxkEIa+WNhJwXJtFLwELAbWPxsxIhaGLAHkZJZU4bXDUyxHl2DwjwBBu
         6WHQ==
X-Gm-Message-State: AOAM531qNhxjSvgb/pyNpLNkU8chyLXicRfvIZstno2MeLXPHfu2tbg1
        bKG9ezFU/za+B9OCJO//iiI80TAXdR6+gQ==
X-Google-Smtp-Source: ABdhPJyjiMlHb58uSEQ07K9Y2g0t6ehfwAR0BVHTzeyY324+46HvLumnWJtqRYMh7IzIGPVXnR8ZPTKoHd9LZA==
Sender: "gprocida via sendgmr" <gprocida@tef.lon.corp.google.com>
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:110:a6ae:11ff:fe11:4f04])
 (user=gprocida job=sendgmr) by 2002:a05:6000:188b:: with SMTP id
 a11mr848105wri.151.1611579999642; Mon, 25 Jan 2021 05:06:39 -0800 (PST)
Date:   Mon, 25 Jan 2021 13:06:23 +0000
In-Reply-To: <20210125130625.2030186-1-gprocida@google.com>
Message-Id: <20210125130625.2030186-3-gprocida@google.com>
Mime-Version: 1.0
References: <20210125130625.2030186-1-gprocida@google.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH dwarves 2/4] btf_encoder: Add .BTF section using libelf
From:   Giuliano Procida <gprocida@google.com>
To:     dwarves@vger.kernel.org
Cc:     acme@kernel.org, andrii@kernel.org, ast@kernel.org,
        gprocida@google.com, maennich@google.com, kernel-team@android.com,
        kernel-team@fb.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

pahole -J uses libelf directly when updating a .BTF section. However,
it uses llvm-objcopy to add .BTF sections. This commit switches to
using libelf for both cases.

This eliminates pahole's dependency on llvm-objcopy. One unfortunate
side-effect is that vmlinux actually increases in size. It seems that
llvm-objcopy modifies the .strtab section, discarding many strings. I
speculate that is it discarding strings not referenced from .symtab
and updating the references therein.

In this initial version layout is left completely up to libelf which
may be OK for non-loadable object files, but is probably no good for
things like vmlinux where all the offsets may change. This is
addressed in a follow-up commit.

Signed-off-by: Giuliano Procida <gprocida@google.com>
---
 libbtf.c | 145 ++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 100 insertions(+), 45 deletions(-)

diff --git a/libbtf.c b/libbtf.c
index 9f76283..fb8e043 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -699,6 +699,7 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 	uint32_t raw_btf_size;
 	int fd, err = -1;
 	size_t strndx;
+	void *str_table = NULL;
 
 	fd = open(filename, O_RDWR);
 	if (fd < 0) {
@@ -741,74 +742,128 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 	}
 
 	/*
-	 * First we look if there was already a .BTF section to overwrite.
+	 * First we check if there is already a .BTF section present.
 	 */
-
 	elf_getshdrstrndx(elf, &strndx);
+	Elf_Scn *btf_scn = 0;
 	while ((scn = elf_nextscn(elf, scn)) != NULL) {
 		shdr = gelf_getshdr(scn, &shdr_mem);
 		if (shdr == NULL)
 			continue;
 		char *secname = elf_strptr(elf, strndx, shdr->sh_name);
 		if (strcmp(secname, ".BTF") == 0) {
-			btf_data = elf_getdata(scn, btf_data);
+			btf_scn = scn;
 			break;
 		}
 	}
 
-	raw_btf_data = btf__get_raw_data(btf, &raw_btf_size);
-
-	if (btf_data) {
-		/* Exisiting .BTF section found */
-		btf_data->d_buf = (void *)raw_btf_data;
-		btf_data->d_size = raw_btf_size;
-		elf_flagdata(btf_data, ELF_C_SET, ELF_F_DIRTY);
+	Elf_Scn *str_scn = elf_getscn(elf, strndx);
+	if (!str_scn) {
+		fprintf(stderr, "%s: elf_getscn(strndx) failed\n", __func__);
+		goto out;
+	}
 
-		if (elf_update(elf, ELF_C_NULL) >= 0 &&
-		    elf_update(elf, ELF_C_WRITE) >= 0)
-			err = 0;
-		else
-			fprintf(stderr, "%s: elf_update failed: %s.\n",
-				__func__, elf_errmsg(elf_errno()));
+	size_t dot_btf_offset = 0;
+	if (btf_scn) {
+		/* Existing .BTF section found */
+		btf_data = elf_getdata(btf_scn, NULL);
+		if (!btf_data) {
+			fprintf(stderr, "%s: elf_getdata failed: %s\n", __func__,
+				elf_errmsg(elf_errno()));
+			goto out;
+		}
 	} else {
-		const char *llvm_objcopy;
-		char tmp_fn[PATH_MAX];
-		char cmd[PATH_MAX * 2];
-
-		llvm_objcopy = getenv("LLVM_OBJCOPY");
-		if (!llvm_objcopy)
-			llvm_objcopy = "llvm-objcopy";
-
-		/* Use objcopy to add a .BTF section */
-		snprintf(tmp_fn, sizeof(tmp_fn), "%s.btf", filename);
-		close(fd);
-		fd = creat(tmp_fn, S_IRUSR | S_IWUSR);
-		if (fd == -1) {
-			fprintf(stderr, "%s: open(%s) failed!\n", __func__,
-				tmp_fn);
+		/* Add ".BTF" to the section name string table */
+		Elf_Data *str_data = elf_getdata(str_scn, NULL);
+		if (!str_data) {
+			fprintf(stderr, "%s: elf_getdata(str_scn) failed: %s\n",
+				__func__, elf_errmsg(elf_errno()));
 			goto out;
 		}
-
-		if (write(fd, raw_btf_data, raw_btf_size) != raw_btf_size) {
-			fprintf(stderr, "%s: write of %d bytes to '%s' failed: %d!\n",
-				__func__, raw_btf_size, tmp_fn, errno);
-			goto unlink;
+		dot_btf_offset = str_data->d_size;
+		size_t new_str_size = dot_btf_offset + 5;
+		str_table = malloc(new_str_size);
+		if (!str_table) {
+			fprintf(stderr, "%s: malloc(%zu) failed: %s\n", __func__,
+				new_str_size, elf_errmsg(elf_errno()));
+			goto out;
 		}
+		memcpy(str_table, str_data->d_buf, dot_btf_offset);
+		memcpy(str_table + dot_btf_offset, ".BTF", 5);
+		str_data->d_buf = str_table;
+		str_data->d_size = new_str_size;
+		elf_flagdata(str_data, ELF_C_SET, ELF_F_DIRTY);
+
+		/* Create a new section */
+		btf_scn = elf_newscn(elf);
+		if (!btf_scn) {
+			fprintf(stderr, "%s: elf_newscn failed: %s\n",
+			__func__, elf_errmsg(elf_errno()));
+			goto out;
+		}
+		btf_data = elf_newdata(btf_scn);
+		if (!btf_data) {
+			fprintf(stderr, "%s: elf_newdata failed: %s\n",
+			__func__, elf_errmsg(elf_errno()));
+			goto out;
+		}
+	}
 
-		snprintf(cmd, sizeof(cmd), "%s --add-section .BTF=%s %s",
-			 llvm_objcopy, tmp_fn, filename);
-		if (system(cmd)) {
-			fprintf(stderr, "%s: failed to add .BTF section to '%s': %d!\n",
-				__func__, filename, errno);
-			goto unlink;
+	/* (Re)populate the BTF section data */
+	raw_btf_data = btf__get_raw_data(btf, &raw_btf_size);
+	btf_data->d_buf = (void *)raw_btf_data;
+	btf_data->d_size = raw_btf_size;
+	btf_data->d_type = ELF_T_BYTE;
+	btf_data->d_version = EV_CURRENT;
+	elf_flagdata(btf_data, ELF_C_SET, ELF_F_DIRTY);
+
+	/* Update .BTF section in the SHT */
+	GElf_Shdr btf_shdr_mem;
+	GElf_Shdr *btf_shdr = gelf_getshdr(btf_scn, &btf_shdr_mem);
+	if (!btf_shdr) {
+		fprintf(stderr, "%s: elf_getshdr(btf_scn) failed: %s\n",
+			__func__, elf_errmsg(elf_errno()));
+		goto out;
+	}
+	btf_shdr->sh_entsize = 0;
+	btf_shdr->sh_flags = 0;
+	if (dot_btf_offset)
+		btf_shdr->sh_name = dot_btf_offset;
+	btf_shdr->sh_type = SHT_PROGBITS;
+	if (!gelf_update_shdr(btf_scn, btf_shdr)) {
+		fprintf(stderr, "%s: gelf_update_shdr failed: %s\n",
+			__func__, elf_errmsg(elf_errno()));
+		goto out;
+	}
+
+	if (elf_update(elf, ELF_C_NULL) < 0) {
+		fprintf(stderr, "%s: elf_update (layout) failed: %s\n",
+			__func__, elf_errmsg(elf_errno()));
+		goto out;
+	}
+
+	size_t phnum = 0;
+	if (!elf_getphdrnum(elf, &phnum)) {
+		for (size_t ix = 0; ix < phnum; ++ix) {
+			GElf_Phdr phdr;
+			GElf_Phdr *elf_phdr = gelf_getphdr(elf, ix, &phdr);
+			size_t filesz = gelf_fsize(elf, ELF_T_PHDR, 1, EV_CURRENT);
+			fprintf(stderr, "type: %d %d\n", elf_phdr->p_type, PT_PHDR);
+			fprintf(stderr, "offset: %lu %lu\n", elf_phdr->p_offset, ehdr->e_phoff);
+			fprintf(stderr, "filesize: %lu %lu\n", elf_phdr->p_filesz, filesz);
 		}
+	}
 
-		err = 0;
-	unlink:
-		unlink(tmp_fn);
+	if (elf_update(elf, ELF_C_WRITE) < 0) {
+		fprintf(stderr, "%s: elf_update (write) failed: %s\n",
+			__func__, elf_errmsg(elf_errno()));
+		goto out;
 	}
+	err = 0;
 
 out:
+	if (str_table)
+		free(str_table);
 	if (fd != -1)
 		close(fd);
 	if (elf)
-- 
2.30.0.280.ga3ce27912f-goog

