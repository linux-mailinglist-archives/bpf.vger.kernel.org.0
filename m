Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD04231D7F6
	for <lists+bpf@lfdr.de>; Wed, 17 Feb 2021 12:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbhBQLJo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Feb 2021 06:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbhBQLJS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Feb 2021 06:09:18 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55481C061794
        for <bpf@vger.kernel.org>; Wed, 17 Feb 2021 03:08:24 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id d10so16821598wrq.17
        for <bpf@vger.kernel.org>; Wed, 17 Feb 2021 03:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=/jlrrw//5EBw0HxItehu19/zul9u1dKvK5phINfjwEk=;
        b=s13SxwqbF6VEmAgB0MOMVRv/Qo0IFrsZCbK/vRUoK1110OmI0lfLOl87udU+/ECgHi
         2TZTX9Y1VzOMZJRXiCuo503jWsCvZvfeZ94iYkfNIwVW5giC5/V2Uos5NFneM+FjJfn2
         yUfzuTvs1/wAyUQ8FIedv1v4Q4uJyLz+u5j2eHAnPIdsLJF436zqRHE/T0QAWNgZbypU
         G22K9d++X/SUaMT8ghhdxRBvtGjQuCerHzB3Sg/kNR0WNubRXUxpKSL1sEvAxpufW8Jl
         oPq234NoTsmcjUBzmcMmvxiT0EaF2odqXzGzh8pJ6fMy8IUL61MVZtgmK7UCVa+Sr2s+
         0elw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/jlrrw//5EBw0HxItehu19/zul9u1dKvK5phINfjwEk=;
        b=t+Tlz2L94D1zq+wjk0aaU/FUoUX/P2RJJ6OVIK9tp4lbnC6wPwAve/+DeBuu6yu2b9
         ePxqOR8NH05WCPQviOb0kYPseyzaXSZ+UsH6rV3IaOCyQ4M/JZLlxH6YC90/gm1flLZ0
         vZOP2hx1XW/e3YdytEvk68Eb2JRtjt8ijU1jteE9U8Bm0e6NYzM27MM6qlfydKX6mgU4
         VsgO9tbpCTaKAHV3MJeNI9AYFu56FBejktOMOieZxDwTZd0AAf5NU4hBNgzPnPT7JMgj
         SQkcIjLKOt2ENmpYgs14Fy34QM5Ie38JHQrg+vRpuNcf0Op/GJP7FG+1VVDdRENvnd17
         QcKg==
X-Gm-Message-State: AOAM530NSE2kqUgseMOMUp2tqJu9tpZoKkweZfFv24YGsU/Ag2kanAvc
        oDRDst3vNPktD8L75HCrC19S9TPnFNn3gg==
X-Google-Smtp-Source: ABdhPJx1JLkbNWtWhwyTxH9S+q24GjVOq5lYO+EjG/IBH4jQH5Xb+2PfqDArpk3BaNPsDuZHEEXnCfAdmtcMYQ==
Sender: "gprocida via sendgmr" <gprocida@tef.lon.corp.google.com>
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:110:61b3:1cb2:c180:c3f])
 (user=gprocida job=sendgmr) by 2002:a7b:ce12:: with SMTP id
 m18mr6895587wmc.148.1613560103057; Wed, 17 Feb 2021 03:08:23 -0800 (PST)
Date:   Wed, 17 Feb 2021 11:08:03 +0000
In-Reply-To: <20210217110804.75923-1-gprocida@google.com>
Message-Id: <20210217110804.75923-5-gprocida@google.com>
Mime-Version: 1.0
References: <20210205134221.2953163-1-gprocida@google.com> <20210217110804.75923-1-gprocida@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH dwarves v4 4/5] btf_encoder: Add .BTF section using libelf
From:   Giuliano Procida <gprocida@google.com>
To:     dwarves@vger.kernel.org, acme@kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, gprocida@google.com,
        maennich@google.com, kernel-team@android.com, kernel-team@fb.com,
        bpf@vger.kernel.org
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

Layout is left completely up to libelf and existing section offsets
are likely to change.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Giuliano Procida <gprocida@google.com>
---
 libbtf.c | 127 +++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 81 insertions(+), 46 deletions(-)

diff --git a/libbtf.c b/libbtf.c
index 4ae7150..9ff03ca 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -698,6 +698,7 @@ int32_t btf_elf__add_datasec_type(struct btf_elf *btfe, const char *section_name
 
 static int btf_elf__write(const char *filename, struct btf *btf)
 {
+	const char BTF_SEC_NAME[] = ".BTF";
 	GElf_Ehdr ehdr;
 	Elf_Data *btf_data = NULL;
 	Elf *elf = NULL;
@@ -705,6 +706,7 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 	uint32_t raw_btf_size;
 	int fd, err = -1;
 	size_t strndx;
+	void *str_table = NULL;
 
 	fd = open(filename, O_RDWR);
 	if (fd < 0) {
@@ -743,73 +745,106 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 	}
 
 	/*
-	 * First we look if there was already a .BTF section to overwrite.
+	 * First we check if there is already a .BTF section present.
 	 */
-
 	elf_getshdrstrndx(elf, &strndx);
+	Elf_Scn *btf_scn = NULL;
 	for (Elf_Scn *scn = elf_nextscn(elf, NULL); scn; scn = elf_nextscn(elf, scn)) {
 		GElf_Shdr shdr;
 		if (!gelf_getshdr(scn, &shdr))
 			continue;
 		char *secname = elf_strptr(elf, strndx, shdr.sh_name);
-		if (strcmp(secname, ".BTF") == 0) {
-			btf_data = elf_getdata(scn, btf_data);
+		if (strcmp(secname, BTF_SEC_NAME) == 0) {
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
+		elf_error("elf_getscn(strndx) failed");
+		goto out;
+	}
 
-		if (elf_update(elf, ELF_C_NULL) >= 0 &&
-		    elf_update(elf, ELF_C_WRITE) >= 0)
-			err = 0;
-		else
-			elf_error("elf_update failed");
+	size_t dot_btf_offset = 0;
+	if (btf_scn) {
+		/* Existing .BTF section found */
+		btf_data = elf_getdata(btf_scn, NULL);
+		if (!btf_data) {
+			elf_error("elf_getdata failed");
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
+			elf_error("elf_getdata(str_scn) failed");
 			goto out;
 		}
-
-		if (write(fd, raw_btf_data, raw_btf_size) != raw_btf_size) {
-			fprintf(stderr, "%s: write of %d bytes to '%s' failed: %d!\n",
-				__func__, raw_btf_size, tmp_fn, errno);
-			goto unlink;
+		dot_btf_offset = str_data->d_size;
+		size_t new_str_size = dot_btf_offset + sizeof(BTF_SEC_NAME);
+		str_table = malloc(new_str_size);
+		if (!str_table) {
+			fprintf(stderr, "%s: malloc (strtab) failed\n", __func__);
+			goto out;
 		}
-
-		snprintf(cmd, sizeof(cmd), "%s --add-section .BTF=%s %s",
-			 llvm_objcopy, tmp_fn, filename);
-		if (system(cmd)) {
-			fprintf(stderr, "%s: failed to add .BTF section to '%s': %d!\n",
-				__func__, filename, errno);
-			goto unlink;
+		memcpy(str_table, str_data->d_buf, dot_btf_offset);
+		memcpy(str_table + dot_btf_offset, BTF_SEC_NAME, sizeof(BTF_SEC_NAME));
+		str_data->d_buf = str_table;
+		str_data->d_size = new_str_size;
+		elf_flagdata(str_data, ELF_C_SET, ELF_F_DIRTY);
+
+		/* Create a new section */
+		btf_scn = elf_newscn(elf);
+		if (!btf_scn) {
+			elf_error("elf_newscn failed");
+			goto out;
+		}
+		btf_data = elf_newdata(btf_scn);
+		if (!btf_data) {
+			elf_error("elf_newdata failed");
+			goto out;
 		}
+	}
+
+	/* (Re)populate the BTF section data */
+	raw_btf_data = btf__get_raw_data(btf, &raw_btf_size);
+	btf_data->d_buf = (void *)raw_btf_data;
+	btf_data->d_size = raw_btf_size;
+	btf_data->d_type = ELF_T_BYTE;
+	btf_data->d_version = EV_CURRENT;
+	elf_flagdata(btf_data, ELF_C_SET, ELF_F_DIRTY);
+
+	/* Update .BTF section in the SHT */
+	GElf_Shdr btf_shdr;
+	if (!gelf_getshdr(btf_scn, &btf_shdr)) {
+		elf_error("elf_getshdr(btf_scn) failed");
+		goto out;
+	}
+	btf_shdr.sh_entsize = 0;
+	btf_shdr.sh_flags = 0;
+	if (dot_btf_offset)
+		btf_shdr.sh_name = dot_btf_offset;
+	btf_shdr.sh_type = SHT_PROGBITS;
+	if (!gelf_update_shdr(btf_scn, &btf_shdr)) {
+		elf_error("gelf_update_shdr failed");
+		goto out;
+	}
 
-		err = 0;
-	unlink:
-		unlink(tmp_fn);
+	if (elf_update(elf, ELF_C_NULL) < 0) {
+		elf_error("elf_update (layout) failed");
+		goto out;
+	}
+
+	if (elf_update(elf, ELF_C_WRITE) < 0) {
+		elf_error("elf_update (write) failed");
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
2.30.0.478.g8a0d178c01-goog

