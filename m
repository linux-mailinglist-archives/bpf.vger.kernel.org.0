Return-Path: <bpf+bounces-9169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF94791017
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 04:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF7F21C20825
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 02:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01F1649;
	Mon,  4 Sep 2023 02:25:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7949D62E
	for <bpf@vger.kernel.org>; Mon,  4 Sep 2023 02:25:21 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29770BB
	for <bpf@vger.kernel.org>; Sun,  3 Sep 2023 19:25:18 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68a402c1fcdso459346b3a.1
        for <bpf@vger.kernel.org>; Sun, 03 Sep 2023 19:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693794317; x=1694399117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gF7/Mv26j2ElH3FHD3Izef9TwVrk9XW4w41JIrMztg=;
        b=X/lp/k1Rn9WlrP+o1cDZzAXIywSj59uzbI9Exiwtv8wfyZ1+iLLDZwyvDi0XaQY8yD
         1sx4MbCgh8uWdwJwBQNDPxhmbyNGSQtVTWly1KOy8AC1d2oprqcweawb+5MAFxAbweQR
         6kqIBiTr0yP+X0GqqqxeIN5374ibiyRNS3Iakf0ISuEwAol9avzIsxy5WK0nqRuKQ031
         Tt5okuuqSk+dOk8hP0qMxnkDxTVl6zMGhCJ2Gs+YbuW+zqohPnLRvj3z5P4SXY2NtQXD
         ZHt51UfZ5zljH2PBhMd9pvi3pKJhMwPYCal/MgaQczCL4eJ/egipqnN5K4Molf26qOi2
         SlpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693794317; x=1694399117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2gF7/Mv26j2ElH3FHD3Izef9TwVrk9XW4w41JIrMztg=;
        b=FaAT9wvW/YwVKcpPtae/dC/lo6IIvNeO96u8pcDtumNkEunKAHiosRh1PUikuzZGys
         OwnizRjQ4ghmAJfPhCasFHicsDYZfgMAjznd+W05btGUxBFhWVZ7UQaPT4lFUG4KxH8Y
         grAyeKMnzeQ9+eYDNZ09cKwwfCeEkhwM9lT0wbnkf9yPCihWCYvXjQ8CPkBVQO58FX1c
         jkkuuY91530MQ0iKQWOyc3kX4ckkrLEagdND8rayyOxSsIivxIjn1xsFFfhaPn9z+3K6
         9vx692YAu0XdhZbHHbhjc+juI+62EhM5DgxQdRjnLMWR5CJwBYMW367ox0s7ZdvT/G+H
         QxZg==
X-Gm-Message-State: AOJu0YyNkiIc1bJA0wMtmu2aZms25dQ8E13fgtRQa9NbN8lQf7SJpRkZ
	p4wco9cXpUOcdq8A1dSTe0DPdjTYfKIKNKGX
X-Google-Smtp-Source: AGHT+IFmXGudIzIkPORKQNFGuOVf0+uOKNghQto8lzgYueZOnbcPrHtRn9RRZRmC5j7al1OcsDhflQ==
X-Received: by 2002:a05:6a20:734b:b0:14c:5dc2:659c with SMTP id v11-20020a056a20734b00b0014c5dc2659cmr8988886pzc.22.1693794317338;
        Sun, 03 Sep 2023 19:25:17 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.34])
        by smtp.gmail.com with ESMTPSA id h9-20020a170902748900b001c3267ae314sm3041636pll.156.2023.09.03.19.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Sep 2023 19:25:17 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	hengqi.chen@gmail.com
Subject: [PATCH bpf-next 1/2] libbpf: Resolve ambiguous matches at the same offset for uprobe
Date: Mon,  4 Sep 2023 02:24:43 +0000
Message-Id: <20230904022444.1695820-2-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230904022444.1695820-1-hengqi.chen@gmail.com>
References: <20230904022444.1695820-1-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Dynamic symbols in shared library may have the same name, for example:

    $ nm -D /lib/x86_64-linux-gnu/libc.so.6 | grep rwlock_wrlock
    000000000009b1a0 T __pthread_rwlock_wrlock@GLIBC_2.2.5
    000000000009b1a0 T pthread_rwlock_wrlock@@GLIBC_2.34
    000000000009b1a0 T pthread_rwlock_wrlock@GLIBC_2.2.5

    $ readelf -W --dyn-syms /lib/x86_64-linux-gnu/libc.so.6 | grep rwlock_wrlock
     706: 000000000009b1a0   878 FUNC    GLOBAL DEFAULT   15 __pthread_rwlock_wrlock@GLIBC_2.2.5
    2568: 000000000009b1a0   878 FUNC    GLOBAL DEFAULT   15 pthread_rwlock_wrlock@@GLIBC_2.34
    2571: 000000000009b1a0   878 FUNC    GLOBAL DEFAULT   15 pthread_rwlock_wrlock@GLIBC_2.2.5

Currently, we can't attach a uprobe to pthread_rwlock_wrlock because
both symbols are global bind. Since both of them are at the same offset
we could accept one of them harmlessly.

Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 tools/lib/bpf/elf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
index 9d0296c1726a..5c9e588b17da 100644
--- a/tools/lib/bpf/elf.c
+++ b/tools/lib/bpf/elf.c
@@ -214,7 +214,10 @@ long elf_find_func_offset(Elf *elf, const char *binary_path, const char *name)

 			if (ret > 0) {
 				/* handle multiple matches */
-				if (last_bind != STB_WEAK && cur_bind != STB_WEAK) {
+				if (elf_sym_offset(sym) == ret) {
+					/* same offset, no problem */
+					continue;
+				} else if (last_bind != STB_WEAK && cur_bind != STB_WEAK) {
 					/* Only accept one non-weak bind. */
 					pr_warn("elf: ambiguous match for '%s', '%s' in '%s'\n",
 						sym->name, name, binary_path);
--
2.39.3

