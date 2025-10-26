Return-Path: <bpf+bounces-72216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 585EAC0A555
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 10:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62902189002C
	for <lists+bpf@lfdr.de>; Sun, 26 Oct 2025 09:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2539724A066;
	Sun, 26 Oct 2025 09:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ml0MAfpw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5186672628
	for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 09:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761470369; cv=none; b=g1e/17FoaSQ8LD9AFMNJaA/XwI7QLle/h7/DN4HpEGXt93BdqG1gRW4NMXVlhJgwRNBOMY6iF3b4SkeQXu0AzdFUYYayVfKrQMrJGMK8JftFkDZGOaqjkrYYOQdF85GiqOvXnvBC8MlQqF4bL2N1PqaESFuBHBlT1ci44SH0kqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761470369; c=relaxed/simple;
	bh=m5dBsLXxcjfd/Jg1/TXpqHofhyi2GbaizAwo22sE+Vo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nE+PusK6RaHO3xM/iTbY7nXgL3Ciqn5WtiIafyXRYdtZsUYh7U2YPPG0Trv5TLyk+xIDJb8Zj0skpY7KmGRQjW49NtVK1H5jgdOU9GRXFK7Lj1giYT4kj5rA0rOYm390bnMOAtFbqgArkzdStQT9Uzv65PkNGON2jw3PnealoMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ml0MAfpw; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-33bda2306c5so3309048a91.0
        for <bpf@vger.kernel.org>; Sun, 26 Oct 2025 02:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761470367; x=1762075167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=udg3CwQcBQ0BBJcZyhfktrzA11lxinS2ppEpd97MHiI=;
        b=Ml0MAfpwNv3AzOq4d0mscFCR4XbuUZTc5LaQIziZ3sXzatAdnA/iSDuLm6LfVqmHFR
         KGqYc6CM6Mc43M2cyXKmib4L/LsyAB5g7v83jjDFrvh2sgd4W8G0kFr6RHbwF9LF5hrR
         NLgDNhYpL09IvciYyQLgkIvB1Kj0DSS1p2P6D9bI5Rv65dGV7963YnrBfUZyHS0sCXUn
         lZusZ5ba/efn9DM0tV5AKCEmABeSA59u5ulEp4zSmIcyXuRcu8F3fSwmD+PebSs7alk+
         KbizxaRy9+h3qr8bSEJvyW64j/rDeFRpinfhsboK4Zq8poE5EHKAvTLxIHIMY8n8VNVO
         Ceew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761470367; x=1762075167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=udg3CwQcBQ0BBJcZyhfktrzA11lxinS2ppEpd97MHiI=;
        b=tykEGwN5wnfcIqAxbJCt67YCKgoDuphK4J+nU2uJxOzoAeRxwCMyMb2HyfT6tnPwsE
         lPtfS3aIS5xUPWNLdjURQG43lBt8T4S7Azq9ThHBInFlThrn+lRiefTZitcaqzwGiavj
         MzRNiDzqAVP9eH5b7a3rPl/0AyzFqIJNoXWT6TZ7ORNNdtHynsU5DCiLVBpaHhwNily7
         Brn1yks9Lot/QAFDwNTVEns2vCxdMyQWI1y5o0YoWJhVj6wL1D8TkH8g2VwbItoALIJ+
         gNeyettCsArDjfMtglSD6kw60Coky5hS0QAbyZI/rpCsGA90M/iYIVTKk1hjz8Dn4G18
         TNPg==
X-Forwarded-Encrypted: i=1; AJvYcCV9hL20cS8IvyFMdkZA7MgitSxJi61XzEsPJ4EnaEraKXmDpCxy1eNw1zlwtkmjAU6qGsY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr3RGsl/8UU9xmqspNptBFQhXfR9nFeO8Ns1JUFtDJ3j5KJONd
	mJlG6tVJdh1pYn1eshMD4FRCwRErP/Q8DhaDCiMCg2M7wZk4VEdY3cIX
X-Gm-Gg: ASbGncuCDqSILQnW6WefzlCbHBZY+6fNORF2yyKk2SpIWZotxDuduz+pQ4KUByerqZD
	aA9TWwRwl0oiWdnBqAogKB8qHxgczmxidGyC/bbS5wetqe8H0AbMSPcjccu5B5KjAQ2pHltvZrQ
	VzwAQHXwlfStxLQ7pH5dUaJLyChVTdQ/+W0bCBjWga622MkbmxlUJfXtmTTfwEMQmCle+XBN1i+
	cpq6+Ne9fysTnBOWnXdRZGBCwq6oCw7oJcS3CIxsPP8WNulMJ42c64ojb/wXQ9bc7yAMbg+btSf
	fMJmMMkoKQPVFDvmE0fyMxbBnai1O2i8POycapq03T7vpsSXj41KDZDqB7WjL+s1b5Y1fu6hZ9k
	QYKTQF+djGMWSOEi5gmtIyc2r9+7PtGqNEzs+O3qyIU3/oHOrNDVcxdEComwXjOpHmzONEU/6Cs
	1I0BfPPX2zBRR4ynPOnJtjdQ==
X-Google-Smtp-Source: AGHT+IH6eN+njVM8GBwTsi7fLGE3YNfCJKSism0LE4927eZ8Rab/oS7OTOf02WSA0mHpx2ydqTM/Bg==
X-Received: by 2002:a17:90b:4c48:b0:32e:936f:ad7 with SMTP id 98e67ed59e1d1-33bcf8f8737mr8845587a91.27.1761470367609;
        Sun, 26 Oct 2025 02:19:27 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-33fee418419sm1947131a91.12.2025.10.26.02.19.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Oct 2025 02:19:27 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Samuel Holland <samuel.holland@sifive.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] riscv: Fix memory leak in module_frob_arch_sections()
Date: Sun, 26 Oct 2025 17:19:08 +0800
Message-Id: <20251026091912.39727-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current code directly overwrites the scratch pointer with the
return value of kvrealloc(). If kvrealloc() fails and returns NULL,
the original buffer becomes unreachable, causing a memory leak.

Fix this by using a temporary variable to store kvrealloc()'s return
value and only update the scratch pointer on success.

Found via static anlaysis and this is similar to commit 42378a9ca553
("bpf, verifier: Fix memory leak in array reallocation for stack state")

Fixes: be17c0df6795 ("riscv: module: Optimize PLT/GOT entry counting")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/riscv/kernel/module-sections.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/module-sections.c b/arch/riscv/kernel/module-sections.c
index 75551ac6504c..1675cbad8619 100644
--- a/arch/riscv/kernel/module-sections.c
+++ b/arch/riscv/kernel/module-sections.c
@@ -119,6 +119,7 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 	unsigned int num_plts = 0;
 	unsigned int num_gots = 0;
 	Elf_Rela *scratch = NULL;
+	Elf_Rela *new_scratch;
 	size_t scratch_size = 0;
 	int i;
 
@@ -168,9 +169,12 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
 		scratch_size_needed = (num_scratch_relas + num_relas) * sizeof(*scratch);
 		if (scratch_size_needed > scratch_size) {
 			scratch_size = scratch_size_needed;
-			scratch = kvrealloc(scratch, scratch_size, GFP_KERNEL);
-			if (!scratch)
+			new_scratch = kvrealloc(scratch, scratch_size, GFP_KERNEL);
+			if (!new_scratch) {
+				kvfree(scratch);
 				return -ENOMEM;
+			}
+			scratch = new_scratch;
 		}
 
 		for (size_t j = 0; j < num_relas; j++)
-- 
2.39.5 (Apple Git-154)


