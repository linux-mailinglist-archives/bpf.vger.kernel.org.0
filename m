Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E253930ADBF
	for <lists+bpf@lfdr.de>; Mon,  1 Feb 2021 18:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbhBAR0p (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Feb 2021 12:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbhBAR0l (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Feb 2021 12:26:41 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA09C061786
        for <bpf@vger.kernel.org>; Mon,  1 Feb 2021 09:26:01 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id v13so1145363qtq.18
        for <bpf@vger.kernel.org>; Mon, 01 Feb 2021 09:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=TfWRYi9hxejy8NpU6fXU34oPw27hyyY5z9BCAPqd/v0=;
        b=Wyv3LLjAmessGhQSIy4qCE/rDzqXGuhA/CWvBeQkZu5lVuuoyiBJ91EE4YnZS+AmBF
         3u5+Iot5gYRGEeHoHUjMFVdbN1IRpEwpEVCzJF56F6wR0MJmyQHisyDZzRts7b00Vl17
         wMLF/nUW6vLLTQYdF74xVFVyGGCAjbdbMH/j+YQOrcJJR1EvBdaeYZmEHDh3rfZnYywT
         xsgRCf6HhfyXKDGc0iIxUvBzl/0hDRXSWoJmRHmkOClLcLz6upbEFlclUqXMiifvUmIP
         md45DN77fqRD7U/ANwrhJKvw/ElMfuu97SHC24tfsEcJbi9/ElXinDL7k9WfNzF9FrLt
         q0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TfWRYi9hxejy8NpU6fXU34oPw27hyyY5z9BCAPqd/v0=;
        b=ot357uNai9f67YHMqKxTwnpiYei4Ljqf7Uf5KTdihuZgL0KziMRHmywOjfeQWCzYtG
         qXGHccrL6gPuWry6Q35hsz7PkVm/fFBWstEqnIkr/lBaGHkhdVTZxflK7fB2oG4QUjHD
         GvGbgOAUQGPe7hYBouxVdqdjuV1BywpPRYvcFf277P1QC4xzSpbq7c9tFRXGn0kqt1Cy
         RD7hRHYS+p6N+YZs3ql0RqW7ikO5AhFfx+LRIHYhxzN/Dd4Kgiws88S0hcdvaFZpjo7x
         GUKlUO17iqlzwAWbx8RUM5ice2il8dmpy+Xh7HTW2UmIyr2gpuXqifh5BCrFSmWXZ+Zn
         LHKA==
X-Gm-Message-State: AOAM531Scpg9alSR4637nrlO08iTxJUOwBV8Dtn8AkWDQGkmxDJr5AEG
        F093QbWNBqu+Wy75Y9wwokZ07D8RzMFwzA==
X-Google-Smtp-Source: ABdhPJzWt/rbL1FTsJQCGX9jKuXIoAGGUeAPJ4rWxNzOXJrxIvWHKg2h3oXa5LFASidKJ+gWfnByhyzh84qaAQ==
Sender: "gprocida via sendgmr" <gprocida@tef.lon.corp.google.com>
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:210:6893:b158:d9db:277c])
 (user=gprocida job=sendgmr) by 2002:a05:6214:1110:: with SMTP id
 e16mr16097805qvs.62.1612200360663; Mon, 01 Feb 2021 09:26:00 -0800 (PST)
Date:   Mon,  1 Feb 2021 17:25:27 +0000
In-Reply-To: <20210201172530.1141087-1-gprocida@google.com>
Message-Id: <20210201172530.1141087-2-gprocida@google.com>
Mime-Version: 1.0
References: <87a83353155506cc02141e6e4108d89aa4e7d284> <20210201172530.1141087-1-gprocida@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH dwarves v2 1/4] btf_encoder: Add .BTF section using libelf
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

In this initial version layout is left completely up to libelf and
indeed offsets of existing sections are likely to change.

Signed-off-by: Giuliano Procida <gprocida@google.com>
---
 libbtf.c | 134 ++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 88 insertions(+), 46 deletions(-)

diff --git a/libbtf.c b/libbtf.c
index 81b1b36..5b91d3a 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -698,6 +698,7 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 	uint32_t raw_btf_size;
 	int fd, err = -1;
 	size_t strndx;
+	void *str_table = NULL;
 
 	fd = open(filename, O_RDWR);
 	if (fd < 0) {
@@ -740,74 +741,115 @@ static int btf_elf__write(const char *filename, struct btf *btf)
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
 		}
+	}
 
-		err = 0;
-	unlink:
-		unlink(tmp_fn);
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
+	btf_shdr->sh_flags = SHF_ALLOC;
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
2.30.0.365.g02bc693789-goog

