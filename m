Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA07D30ADC7
	for <lists+bpf@lfdr.de>; Mon,  1 Feb 2021 18:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbhBAR1H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Feb 2021 12:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbhBAR0s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Feb 2021 12:26:48 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE8DC061794
        for <bpf@vger.kernel.org>; Mon,  1 Feb 2021 09:26:08 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id q37so11175265qvf.14
        for <bpf@vger.kernel.org>; Mon, 01 Feb 2021 09:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=SzX/76WK1bIQFSNZsX1p6vCVFi30KIn33vpgS3dU+T4=;
        b=LgqnBPeuMxz96fcoXG5DtjiqfY9PVITepDTqOVFxBLdnxBITpfBBXmBUSK/htFJHnG
         bKCJd0W/eJYdHdh2AnWlGmPwWjsJbYyzGLyi1vlxuFT/mY34ToAzjyKnFxVJMPOYQvgF
         HXjv6vtnMEMvtMqrCoM2KU6O8aBI35VDgKW2axvFXZ8gYSnh8k87bDhG2roNzPvHMY4f
         pm5f5kGmdHGO5bg5z+LwoQ+zJGATppRQvM9Qilfg9BmuOS1HKbX7O3AWiQ3e4TSZTx+H
         8sypdPBmmqkhbZ3Aw5j5nfjW8e4EoxFJvnMr4gADe0XZ7/kR6cKEDSq3JlQgR9Rfm9vy
         O95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SzX/76WK1bIQFSNZsX1p6vCVFi30KIn33vpgS3dU+T4=;
        b=KGIBu6Fu/ZX9XsLho+cUucF5hR1sQGBPwug7tARRhCY8+RdUFAUVndolrwCHo8tma+
         saxG58QljsnY9329zKiYLIBWYeyUuelj5ezEPEzWf+yV8FlwlyngYfb3sg3gc7I/r0qa
         GEBo8wBNV1w4B7JW1HqHvIu+tKMkZ1F5VfXwYbParG4lyCFazTI/zhewj/kI4FCqbIhA
         JSAkyxfPjRttUUBBCJZgb2IaWA7spbV9LcuCBcbLxUTSUtjUZ39mrYeWTAUB8fZrh9co
         21R7jzf00WNkq6A2XHcw/QpYULApr2U4v3aiJnd2UGBPHoYvyt72lmsnP0hOc/P4Zo+I
         pepg==
X-Gm-Message-State: AOAM530EFs8xwc9mZDFzYBp4RSH43rbUDllHIaQ4FQsgK01oq+lhl8Aw
        /lpT3yrWZFkhpyGbt5Lb1sfUDRQrghgqJQ==
X-Google-Smtp-Source: ABdhPJz0qDqRzI0ZwKQCmtohyB/H8S7feCG8hVcGtdHRrP+L16/1OtQntX4HRlG2xd8+QNlrmI8qzLWasj94hg==
Sender: "gprocida via sendgmr" <gprocida@tef.lon.corp.google.com>
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:210:6893:b158:d9db:277c])
 (user=gprocida job=sendgmr) by 2002:a05:6214:ce:: with SMTP id
 f14mr12876974qvs.25.1612200367896; Mon, 01 Feb 2021 09:26:07 -0800 (PST)
Date:   Mon,  1 Feb 2021 17:25:30 +0000
In-Reply-To: <20210201172530.1141087-1-gprocida@google.com>
Message-Id: <20210201172530.1141087-5-gprocida@google.com>
Mime-Version: 1.0
References: <87a83353155506cc02141e6e4108d89aa4e7d284> <20210201172530.1141087-1-gprocida@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH dwarves v2 4/4] btf_encoder: Align .BTF section/segment to 8 bytes
From:   Giuliano Procida <gprocida@google.com>
To:     dwarves@vger.kernel.org
Cc:     acme@kernel.org, andrii@kernel.org, ast@kernel.org,
        gprocida@google.com, maennich@google.com, kernel-team@android.com,
        kernel-team@fb.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is to avoid misaligned access to BTF type structs when
memory-mapping ELF sections.

Signed-off-by: Giuliano Procida <gprocida@google.com>
---
 libbtf.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/libbtf.c b/libbtf.c
index 048a873..ae99a93 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -755,7 +755,13 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 	 * This actually happens in practice with vmlinux which has .strtab
 	 * after .shstrtab, resulting in a (small) hole the size of the original
 	 * .shstrtab.
+	 *
+	 * We'll align .BTF to 8 bytes to cater for all architectures. It'd be
+	 * nice if we could fetch this value from somewhere. The BTF
+	 * specification does not discuss alignment and its trailing string
+	 * table is not currently padded to any particular alignment.
 	 */
+	const size_t btf_alignment = 8;
 
 	/*
 	 * First we look if there was already a .BTF section present and
@@ -847,8 +853,8 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 	elf_flagdata(btf_data, ELF_C_SET, ELF_F_DIRTY);
 
 	/* Update .BTF section in the SHT */
-	size_t new_btf_offset = high_water_mark;
-	size_t new_btf_size = raw_btf_size;
+	size_t new_btf_offset = roundup(high_water_mark, btf_alignment);
+	size_t new_btf_size = roundup(raw_btf_size, btf_alignment);
 	GElf_Shdr btf_shdr_mem;
 	GElf_Shdr *btf_shdr = gelf_getshdr(btf_scn, &btf_shdr_mem);
 	if (!btf_shdr) {
@@ -856,6 +862,7 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 			__func__, elf_errmsg(elf_errno()));
 		goto out;
 	}
+	btf_shdr->sh_addralign = btf_alignment;
 	btf_shdr->sh_entsize = 0;
 	btf_shdr->sh_flags = SHF_ALLOC;
 	if (dot_btf_offset)
@@ -926,6 +933,7 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 		pht[phnum].p_memsz = pht[phnum].p_filesz = btf_shdr->sh_size;
 		pht[phnum].p_vaddr = pht[phnum].p_paddr = 0;
 		pht[phnum].p_flags = PF_R;
+		pht[phnum].p_align = btf_alignment;
 		void *phdr = gelf_newphdr(elf, phnum+1);
 		if (!phdr) {
 			fprintf(stderr, "%s: gelf_newphdr failed: %s\n",
-- 
2.30.0.365.g02bc693789-goog

