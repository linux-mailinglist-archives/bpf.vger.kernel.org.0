Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B96C530ADC9
	for <lists+bpf@lfdr.de>; Mon,  1 Feb 2021 18:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbhBAR1I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Feb 2021 12:27:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbhBAR0o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Feb 2021 12:26:44 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C577C06178A
        for <bpf@vger.kernel.org>; Mon,  1 Feb 2021 09:26:04 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id n14so10807704wru.6
        for <bpf@vger.kernel.org>; Mon, 01 Feb 2021 09:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=YDxToULhiLjuBex0deTClM4Ud7mf2JtShhU/pcWFbzY=;
        b=WNS8a5ZnSlcq7C7ERfxNj7fFFK1TEpNiP9RKtYX3XWZI+KQwmWFBnlnKYMVg2OWRiQ
         brEM50ab1ooN7wgIBVoE37UqX13dR2N+pE+RAnxNV0ycDxV7a39kC/EgLmM5Mlj6YoUs
         KNTAW/XWOgSFG5PPf3bOuzN9bxFQ8fxwbVg1gDRErJKWnLupbvdL31IRKRZ9pRlkSHOk
         UTEAcH4Sqts+sYagSqWVd5XvVo9LqfBKeYnZDEa8wbkTY/L1JWAAGrYjjoIiDa6InNtd
         6v01jNBfaNYXLGtmyDZPgcGlt/cNLITKvD92mO/gzVDXH3+QbpvNSDQQcxej3XUVRR+Y
         JN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YDxToULhiLjuBex0deTClM4Ud7mf2JtShhU/pcWFbzY=;
        b=tGtQaONUcxIafRBDe/b6vWj7fm5IxZmGdBt5D+SFDfwk2PFlyNjCWG30njjnXjAKOk
         Q5WamQP6RBVDtaOX09UHnhPMKaKHFQhIaybv6oT9sWytbd6ucN+fa7XxwRSokKnQ6TYs
         7oaLWDthoum7TTCe43U6I3Fdh0ncujuRUR7+o2bL33Un80SYcG8EGkVnqq2GgUvkHgkE
         nacKhrL7egqgozOEpaH63Yu4Ieq+ZGL/BepPszKJR591qG2BfpIXW1VfX/4zYEWWr+BS
         j4Fg25+kNiRADS2Cx3IEr8GCSzvjSK5ppXPIugaYgzjx9PZV0DI9h4Fa9TfqrOcu+GRd
         9B8Q==
X-Gm-Message-State: AOAM530VJ4P62aakJAhF5BstTGX83UNHciYo+MwyJzSFAfZmyf7F2QHs
        cifpDCif6DrSJuxc4pSdGwpfnbTtsCvjcw==
X-Google-Smtp-Source: ABdhPJzrbXIdfE7y90Snjx52gZc+gdOyBkufbbsfFR/XzO3U/FHYpXSbDVsV9ABShiiwSsJ1VO+AQHEXF5RNhA==
Sender: "gprocida via sendgmr" <gprocida@tef.lon.corp.google.com>
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:210:6893:b158:d9db:277c])
 (user=gprocida job=sendgmr) by 2002:a7b:c044:: with SMTP id
 u4mr87442wmc.1.1612200362886; Mon, 01 Feb 2021 09:26:02 -0800 (PST)
Date:   Mon,  1 Feb 2021 17:25:28 +0000
In-Reply-To: <20210201172530.1141087-1-gprocida@google.com>
Message-Id: <20210201172530.1141087-3-gprocida@google.com>
Mime-Version: 1.0
References: <87a83353155506cc02141e6e4108d89aa4e7d284> <20210201172530.1141087-1-gprocida@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH dwarves v2 2/4] btf_encoder: Manually lay out updated ELF sections
From:   Giuliano Procida <gprocida@google.com>
To:     dwarves@vger.kernel.org
Cc:     acme@kernel.org, andrii@kernel.org, ast@kernel.org,
        gprocida@google.com, maennich@google.com, kernel-team@android.com,
        kernel-team@fb.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

pahole -J needs to do the following to an ELF file:

* add or update the ".BTF" section
* maybe update the section name string table
* update the Section Header Table (SHT)

libelf either takes full control of layout or requires the user to
specify offset, size and alignment of all new and updated sections and
headers.

To avoid libelf moving program segments in particular, we position the
".BTF" and section name string table (typically named ".shstrtab")
sections after all others. The SHT always lives at the end of the file.

Note that the last section in an ELF file is normally the section name
string table and any ".BTF" section will normally be second last.
However, if these sections appear earlier, then we'll waste some space
in the ELF file when we rewrite them.

Signed-off-by: Giuliano Procida <gprocida@google.com>
---
 libbtf.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/libbtf.c b/libbtf.c
index 5b91d3a..6e06a58 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -741,9 +741,28 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 	}
 
 	/*
-	 * First we check if there is already a .BTF section present.
+	 * The SHT is at the very end of the ELF and gets re-written in any case.
+	 *
+	 * We'll always add or update the .BTF section and when adding have to
+	 * re-write the section name string table (usually named .shstrtab). In
+	 * fact, as good citizens, we'll always leave the string table last, in
+	 * case someone else wants to add a section.
+	 *
+	 * However, if .BTF or the section name string table are followed by
+	 * further sections, we'll not try to be clever about shuffling
+	 * everything else in the ELF file, we'll just leave some dead space.
+	 * This actually happens in practice with vmlinux which has .strtab
+	 * after .shstrtab, resulting in a (small) hole the size of the original
+	 * .shstrtab.
+	 */
+
+	/*
+	 * First we look if there was already a .BTF section present and
+	 * determine the first usable offset in the ELF (for .BTF and the
+	 * section name table).
 	 */
 	elf_getshdrstrndx(elf, &strndx);
+	size_t high_water_mark = 0;
 	Elf_Scn *btf_scn = 0;
 	while ((scn = elf_nextscn(elf, scn)) != NULL) {
 		shdr = gelf_getshdr(scn, &shdr_mem);
@@ -752,7 +771,10 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 		char *secname = elf_strptr(elf, strndx, shdr->sh_name);
 		if (strcmp(secname, ".BTF") == 0) {
 			btf_scn = scn;
-			break;
+		} else if (elf_ndxscn(scn) != strndx) {
+			size_t limit = shdr->sh_offset + shdr->sh_size;
+			if (limit > high_water_mark)
+				high_water_mark = limit;
 		}
 	}
 
@@ -761,6 +783,12 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 		fprintf(stderr, "%s: elf_getscn(strndx) failed\n", __func__);
 		goto out;
 	}
+	GElf_Shdr str_shdr_mem;
+	GElf_Shdr *str_shdr = gelf_getshdr(str_scn, &str_shdr_mem);
+	if (!str_shdr) {
+		fprintf(stderr, "%s: elf_getshdr(str_scn) failed\n", __func__);
+		goto out;
+	}
 
 	size_t dot_btf_offset = 0;
 	if (btf_scn) {
@@ -791,6 +819,7 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 		str_data->d_buf = str_table;
 		str_data->d_size = new_str_size;
 		elf_flagdata(str_data, ELF_C_SET, ELF_F_DIRTY);
+		str_shdr->sh_size = new_str_size;
 
 		/* Create a new section */
 		btf_scn = elf_newscn(elf);
@@ -810,12 +839,15 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 	/* (Re)populate the BTF section data */
 	raw_btf_data = btf__get_raw_data(btf, &raw_btf_size);
 	btf_data->d_buf = (void *)raw_btf_data;
+	btf_data->d_off = 0;
 	btf_data->d_size = raw_btf_size;
 	btf_data->d_type = ELF_T_BYTE;
 	btf_data->d_version = EV_CURRENT;
 	elf_flagdata(btf_data, ELF_C_SET, ELF_F_DIRTY);
 
 	/* Update .BTF section in the SHT */
+	size_t new_btf_offset = high_water_mark;
+	size_t new_btf_size = raw_btf_size;
 	GElf_Shdr btf_shdr_mem;
 	GElf_Shdr *btf_shdr = gelf_getshdr(btf_scn, &btf_shdr_mem);
 	if (!btf_shdr) {
@@ -827,6 +859,8 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 	btf_shdr->sh_flags = SHF_ALLOC;
 	if (dot_btf_offset)
 		btf_shdr->sh_name = dot_btf_offset;
+	btf_shdr->sh_offset = new_btf_offset;
+	btf_shdr->sh_size = new_btf_size;
 	btf_shdr->sh_type = SHT_PROGBITS;
 	if (!gelf_update_shdr(btf_scn, btf_shdr)) {
 		fprintf(stderr, "%s: gelf_update_shdr failed: %s\n",
@@ -834,6 +868,32 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 		goto out;
 	}
 
+	/* Update section name string table */
+	size_t new_str_offset = new_btf_offset + new_btf_size;
+	str_shdr->sh_offset = new_str_offset;
+	if (!gelf_update_shdr(str_scn, str_shdr)) {
+		fprintf(stderr, "gelf_update_shdr failed\n");
+		goto out;
+	}
+
+	/* Update SHT, allowing for ELF64 alignment */
+	size_t sht_offset = roundup(new_str_offset + str_shdr->sh_size, 8);
+	ehdr->e_shoff = sht_offset;
+	if (!gelf_update_ehdr(elf, ehdr)) {
+		fprintf(stderr, "gelf_update_ehdr failed\n");
+		goto out;
+	}
+
+	if (btf_elf__verbose) {
+		fprintf(stderr, ".BTF [0x%lx, +0x%lx)\n",
+			btf_shdr->sh_offset, btf_shdr->sh_size);
+		fprintf(stderr, ".shstrtab [0x%lx, +0x%lx)\n",
+			str_shdr->sh_offset, str_shdr->sh_size);
+		fprintf(stderr, "SHT [0x%lx, +%d*0x%x)\n",
+			ehdr->e_shoff, ehdr->e_shnum, ehdr->e_shentsize);
+	}
+
+	elf_flagelf(elf, ELF_C_SET, ELF_F_LAYOUT);
 	if (elf_update(elf, ELF_C_NULL) < 0) {
 		fprintf(stderr, "%s: elf_update (layout) failed: %s\n",
 			__func__, elf_errmsg(elf_errno()));
-- 
2.30.0.365.g02bc693789-goog

