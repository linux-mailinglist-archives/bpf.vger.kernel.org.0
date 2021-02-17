Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF0F31D7F3
	for <lists+bpf@lfdr.de>; Wed, 17 Feb 2021 12:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbhBQLJa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Feb 2021 06:09:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbhBQLJA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Feb 2021 06:09:00 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD9EC06178A
        for <bpf@vger.kernel.org>; Wed, 17 Feb 2021 03:08:20 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id b201so2064689wmb.9
        for <bpf@vger.kernel.org>; Wed, 17 Feb 2021 03:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=CtyPUVbXhc5CDRZLtdHVem+8lAgiUhAKNAjbcL0rPXE=;
        b=PoCIn0uyIl6lXycffqtFFJqz/msRd6zXJMEsOtAkL16xrfSuU9+ZDpyV+ggWH0OtgA
         XTAw5Ji/YiGGohzvGFcypyRxBytlHzM+oNqHyJsoN9WVPa3JH7nNQIaxy5UJBJczU+Pa
         xg2qksgjRVQIKqxEGacDNN1IyL9/T+xeb424GKaD9Ff8VcL4BW75zZl1GrGxKT7QM4EJ
         fjdrPXG10sqbEwHfvM6cG9XVX1dub0A71yBb5aD/rRKkI4bGaPRJwHxFUaKH0fE7rEgp
         vJf1vNlWSNiKRLN9vIxN9bwU+RPxjt2o5j9zBoLQyctVpwpzFMhsylEINxnR+NQw1NSP
         5nxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CtyPUVbXhc5CDRZLtdHVem+8lAgiUhAKNAjbcL0rPXE=;
        b=FBZyBe3r6YpXcjElctyNASspQiVfa2dg55HmCK3OX3roYmhfmm06KfiFw2p9wfmM+R
         aRc3IJaDxnkE3mqmqv31UvZEYsUPIElhLPWunh598SwIBMflkrV1ScZ0TJmt2NP1VlxT
         QyWaKUGaPC5ScOZnLkiO1dj5+YA9UkSyyHdBxw5Ebk5ASyoZF6EilLEq7JQPal8ETiYe
         zZKcqZomLofDQ+b9UqeJubxqG27wKsDxL10GDvihDOVmfLhAZ4V7xANuq5IAEjlpdy7H
         qKxiE8Qt2et1I8jUm62BTPPZc+PU0lm357NSX1RygaqVxIYUZjfjcmtvqEvIdaKQdHUx
         /tow==
X-Gm-Message-State: AOAM533o2ckLNIQew1u1PPn+ymxbIJI67zmNmIjv2WSjl9EqguFKs2JK
        W5d38SU+jqqymV9SVyAvDtyFQ5KUUY+5BA==
X-Google-Smtp-Source: ABdhPJym3p+zIhDoQ+3jBbV+a0GOC2AQpwjftZY+ZDQpPFM7fGDhIg3x/c2hdrCQkQttCGyodvElvcISkRuMUA==
Sender: "gprocida via sendgmr" <gprocida@tef.lon.corp.google.com>
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:110:61b3:1cb2:c180:c3f])
 (user=gprocida job=sendgmr) by 2002:a05:600c:2d44:: with SMTP id
 a4mr6563054wmg.95.1613560098890; Wed, 17 Feb 2021 03:08:18 -0800 (PST)
Date:   Wed, 17 Feb 2021 11:08:01 +0000
In-Reply-To: <20210217110804.75923-1-gprocida@google.com>
Message-Id: <20210217110804.75923-3-gprocida@google.com>
Mime-Version: 1.0
References: <20210205134221.2953163-1-gprocida@google.com> <20210217110804.75923-1-gprocida@google.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH dwarves v4 2/5] btf_encoder: Do not use both structs and
 pointers for the same data
From:   Giuliano Procida <gprocida@google.com>
To:     dwarves@vger.kernel.org, acme@kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, gprocida@google.com,
        maennich@google.com, kernel-team@android.com, kernel-team@fb.com,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Many operations in the libelf API return a pointer to a user-provided
struct (on success) or NULL (on failure).

There are a couple of places in btf_elf__write where both structs and
pointers to the same structs are used. Holding on to the pointers
raises ownership and lifetime issues unnecessarily and the code is
cleaner with only a single access path for these data.

The code now treats the returned pointers as booleans.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Giuliano Procida <gprocida@google.com>
---
 libbtf.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/libbtf.c b/libbtf.c
index 7bc49ba..ace8896 100644
--- a/libbtf.c
+++ b/libbtf.c
@@ -698,8 +698,7 @@ int32_t btf_elf__add_datasec_type(struct btf_elf *btfe, const char *section_name
 
 static int btf_elf__write(const char *filename, struct btf *btf)
 {
-	GElf_Shdr shdr_mem, *shdr;
-	GElf_Ehdr ehdr_mem, *ehdr;
+	GElf_Ehdr ehdr;
 	Elf_Data *btf_data = NULL;
 	Elf_Scn *scn = NULL;
 	Elf *elf = NULL;
@@ -727,13 +726,12 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 
 	elf_flagelf(elf, ELF_C_SET, ELF_F_DIRTY);
 
-	ehdr = gelf_getehdr(elf, &ehdr_mem);
-	if (ehdr == NULL) {
+	if (!gelf_getehdr(elf, &ehdr)) {
 		elf_error("elf_getehdr failed");
 		goto out;
 	}
 
-	switch (ehdr_mem.e_ident[EI_DATA]) {
+	switch (ehdr.e_ident[EI_DATA]) {
 	case ELFDATA2LSB:
 		btf__set_endianness(btf, BTF_LITTLE_ENDIAN);
 		break;
@@ -751,10 +749,10 @@ static int btf_elf__write(const char *filename, struct btf *btf)
 
 	elf_getshdrstrndx(elf, &strndx);
 	while ((scn = elf_nextscn(elf, scn)) != NULL) {
-		shdr = gelf_getshdr(scn, &shdr_mem);
-		if (shdr == NULL)
+		GElf_Shdr shdr;
+		if (!gelf_getshdr(scn, &shdr))
 			continue;
-		char *secname = elf_strptr(elf, strndx, shdr->sh_name);
+		char *secname = elf_strptr(elf, strndx, shdr.sh_name);
 		if (strcmp(secname, ".BTF") == 0) {
 			btf_data = elf_getdata(scn, btf_data);
 			break;
-- 
2.30.0.478.g8a0d178c01-goog

