Return-Path: <bpf+bounces-18275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56037818600
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 12:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68AE61C23691
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 11:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4256E14F79;
	Tue, 19 Dec 2023 11:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="ED7AnB+s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="028A4u2c"
X-Original-To: bpf@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F76E14F68
	for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 11:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 3C5055C01B7;
	Tue, 19 Dec 2023 06:04:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 19 Dec 2023 06:04:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1702983898; x=
	1703070298; bh=m4Z+VKHHsae02fFGB3BbUo/6jFQdJ2209z+YSIF4ZRw=; b=E
	D7AnB+sZornLD5hqzRjlx8HI3l7H727URpjX+XdjV7p7NTO6YLWUJAH0aGTaN49H
	0YKgrJ1bWj3+Gb0AdF8z7sVuCtXa6L7SBTy4h47rpsDQvfsxUNJ72C/tPEDtGtwW
	f4rj81GH7KKdQ2XldUVdzoCnBN+Ukjagjqkxe8O3ScPj7UYEQKwF101GuE8Zp8CK
	SYyujLEFtJXi8D8V/mg0MN+4FaT4IpVaIKE0TL0JkfZAcMQpknGx00lCrcAzuxPG
	21ljpEMnufa07GrCGL+PtG0Y6wihQkNqcqZph4nDzIqciy7Zl00vKd86VSpVszQJ
	oj8uTQyb5jfIgsc9++l1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1702983898; x=
	1703070298; bh=m4Z+VKHHsae02fFGB3BbUo/6jFQdJ2209z+YSIF4ZRw=; b=0
	28A4u2cDa+pbGXlqzGZunNlN5EsUg1//UpiHHdrwUbLnMa7Q74YNpgz6/XxVJlYi
	9CXNsBhfrUf//o3jBMkRZzcp+9x3hlIkH66AUK1B34VXIF9VsFM3PDrJqh9OZ+Uj
	Z4iqAc/DW2PSr5Dd22ey9RDMNiCl3q2sb2+MiGPx2rSESibzUmqv2nOGW0GeYjS5
	6J51Ei39bmka+QVoj2uIQF3+TbKxD2ZDXVsMaYv0xc8i8v0BolmLnx7TGItPes1E
	XX3ABaVJ+xpDGzt7IX1y1f1sjkQTdrTrU4aUN2hZNPPXvB9FdTnhKyyoddWAvLyy
	E/KZoNItcVLGZmyqAz1Zw==
X-ME-Sender: <xms:2XiBZTkpNqx8-N9AhuS_wwbDNHjhLtqG_VIL2bozwxzHN1_xtKyAug>
    <xme:2XiBZW3fmrIWQF2EI71Rrt5rCkxzo44JjkQB3w2Jv2TXWVCpLWqvuEI9YAoZ6AenJ
    50Kj0rNs4TAvdE88A>
X-ME-Received: <xmr:2XiBZZpniaYJATN0HNtVQzioRfxfz_fu-Kd7thw7YYr26of2Pk2DPmHF8TlFSvuIrd4Qwy7evcJkN8XpL4a4YNyVnznQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddutddgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheptehlhihs
    shgrucftohhsshcuoehhihesrghlhihsshgrrdhisheqnecuggftrfgrthhtvghrnhepve
    ejtefftdelgeffvefhheefkeefueevjefgjedvteeljeefkedvtefftdevudeunecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehhihesrghlhihsshgrrdhish
X-ME-Proxy: <xmx:2XiBZbnkcK5J5AJAbEOwn2vV8nVHPDMKuGb5vOjyxDcogRDrvDHFmg>
    <xmx:2XiBZR1dXzjqsRDBE6rf7XU-EId5c5sAFDqvZ1ooUR3JhbDTeWs21w>
    <xmx:2XiBZatP5StTGVQEyh8A7zmzAA-0dLTvJ6WcVKV4_-eGFXHihtRaXA>
    <xmx:2niBZfAQHLQ0z4RJa7W0Z7t2aHhpPlAcRHFCt9wXSm_7hCj7eJ-BnQ>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Dec 2023 06:04:57 -0500 (EST)
Received: by mbp.qyliss.net (Postfix, from userid 1000)
	id 90C6998D5; Tue, 19 Dec 2023 12:04:55 +0100 (CET)
From: Alyssa Ross <hi@alyssa.is>
To: bpf@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: patches@lists.linux.dev,
	Sergei Trofimovich <slyich@gmail.com>
Subject: [PATCH] libbpf: skip DWARF sections in linker sanity check
Date: Tue, 19 Dec 2023 12:03:24 +0100
Message-ID: <20231219110324.8989-1-hi@alyssa.is>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <CAEf4BzbN7cUVQgd7nUAsmAQMmCpz7O9v+r3iyiUfa_FK6WMY-w@mail.gmail.com>
References: <CAEf4BzbN7cUVQgd7nUAsmAQMmCpz7O9v+r3iyiUfa_FK6WMY-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clang can generate (with -g -Wa,--compress-debug-sections) 4-byte
aligned DWARF sections that declare themselves to be 8-byte aligned in
the section header.  Since DWARF sections are dropped during linking
anyway, just skip running the sanity checks on them.

Reported-by: Sergei Trofimovich <slyich@gmail.com>
Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Closes: https://lore.kernel.org/bpf/ZXcFRJVKbKxtEL5t@nz.home/
Signed-off-by: Alyssa Ross <hi@alyssa.is>
---
 tools/lib/bpf/linker.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 52a2901e8bd0..16bca56002ab 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -719,6 +719,9 @@ static int linker_sanity_check_elf(struct src_obj *obj)
 			return -EINVAL;
 		}
 
+		if (is_dwarf_sec_name(sec->sec_name))
+			continue;
+
 		if (sec->shdr->sh_addralign && !is_pow_of_2(sec->shdr->sh_addralign)) {
 			pr_warn("ELF section #%zu alignment %llu is non pow-of-2 alignment in %s\n",
 				sec->sec_idx, (long long unsigned)sec->shdr->sh_addralign,

base-commit: 733763285acfe8dffd6e39ad2ed3d1222b32a901
-- 
2.42.0


