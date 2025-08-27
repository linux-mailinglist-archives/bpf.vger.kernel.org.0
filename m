Return-Path: <bpf+bounces-66647-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0A6B380B8
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 13:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2140A16D6FA
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 11:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4721A2398;
	Wed, 27 Aug 2025 11:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVWvSOY4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8E7281508
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 11:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756293583; cv=none; b=QYjiGyrbKXzmbDns6P0c09ntQQUK5C+URvdDY1Yq9a/RUeOsOtR8PFboXRiD1LzlRQ5J1vUoeQNojMAHETOl8zCMhsJBVbuUImR9rq5lJfjf/qmIGr/E8bgj6jeHKoo0vns8N0r0gc2NSq/TWz9kGXnzUd/6LKfMGBH3YScz+Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756293583; c=relaxed/simple;
	bh=B3IoHA5CU5Vhbudi+gAnvUlk1xOMZZA5ef7d4rvycy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AozCWJ5aPap9gPYxKdev5cyVUIymFXX02OHeHLAHsOvR2rK9Q/MXp+iYagrWUPN1BlNV63jckbGHznB1hHluBKcgZqRCllWyy/ZTXiwPugKjA/pVGWZJzxODwQMOLO4B4AUKy4uBpttLKpGztBpx1r8+ppaMtX1z3C2SDszzt7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVWvSOY4; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-771f69fd6feso2471013b3a.1
        for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 04:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756293581; x=1756898381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhGYyByMutM4bNKtp1mgwhdBo+AYNzVb7+uzUi0Q8fs=;
        b=cVWvSOY4Jr5Stnlm+3qjctpcSpV5OP5bRs18wRf4ik4FzE7Apn3kfTH1UhtWUtzNTu
         AZgQYsiAlpaiMkeEfqp4MXWrMv89b/ux28Axj2PxfhikGtOpL1zfd0OUNBnqRsGjmSt1
         m4XFAc7IDT/yNyT1Q6KaoIoXDS6QNMCVjweZGx4nzPgAHEdhctzFIqwbIyIwzzOeb3zA
         p7gtHFzSCL0iv9VpbVBkZClOLmMnMxco2UyHcVPGhGUCJ65s3UFEZ8x1c0fNYwjyT/Su
         RzGBwo7FWiNkb3TokKfw9hTyQg29pVl+XoruKkOyoihguX/VLm2rqJM2xHxyzN04OSP3
         aCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756293581; x=1756898381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vhGYyByMutM4bNKtp1mgwhdBo+AYNzVb7+uzUi0Q8fs=;
        b=HSN085a+vhn5TVU2oKPDSVR4JIdOLkUbEER+a3/nb9uoTvvC4pHTIrWES52gpNk+I5
         g9QnRW9bjsEWDbkg6OpbiIm4y6K0saW8LRnorJ47+J+EeCqeEDhan6ewBTsayJYBpjLn
         4yTRCoVCLv3InAVKXN4rPzds4WhW+0I5ckCFsEJZhvOPF7EKMbhw4VFa6ey2pX5DOUHP
         yofIvoKBJ8aScw8zpAN3ijkOtwA3OfjpD70nJq3C6WrbpNRwc9Vid04doDMBcgG8L2e0
         ZiNy4/rJW1mjKPN8l02EANT194hsChJvBW80M2b7gZBTPMTbEWOvOflrtGf4wni3yeed
         4Tiw==
X-Gm-Message-State: AOJu0Yw0+kQkeO4Xl/12MIg4knCoJe2j4PRxaEveoQLWwDGHshldptH4
	vndchl4Kn32tqZtc98higRxhm/HH7qBUFzvDN1hsmPvLIvKzQi/pDV1s
X-Gm-Gg: ASbGncsWd45c2zsWYoPUWvYMg/PDd3YgNHzugxicYUJ3Dtzvftr7hqLxdC7fsfPNP4o
	SGZbEQsMpqUm231AMrU9EnCnyh7ejUvNIHqRibMOKRySQVvydhPAOQLgbLh6Yb7PlWic7VLu2qu
	6yTRv/Ic/Qmt1sxMJPt03RaJD+GB85CynWDnDkyuKgltG3l9MFPR6b0tNvp+8XZztq2Dc3mHDT7
	1w5Af4KonX0o9ObGMFo0uSEHkoMp5emiK/f3aAbOvruqo0d5tVAQ+vAfF/f8F928jKV9E1Vmn4m
	+RZ2+tNPtI0KduyrZjWshUS2jcPb2jz/+DcFh2xpLH0GX4jlh5mUd2vjQeuEQ911YSQpzDetMJ5
	RKbsglnqg5XAZW3YqgS/W3ujoQ7eCRssHKavC+Sem
X-Google-Smtp-Source: AGHT+IFm9/bk92HhSMvH6AJXv5+SFfo/iMGcHmnhHa66QnomvkMmPxbBlOr4VfIVsDyy9RMTyQg56A==
X-Received: by 2002:a05:6a20:3f9e:b0:243:15b9:7657 with SMTP id adf61e73a8af0-24340d231f0mr23109694637.49.1756293580807;
        Wed, 27 Aug 2025 04:19:40 -0700 (PDT)
Received: from devbox.. ([43.132.141.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276f8a3335sm1829729a91.13.2025.08.27.04.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 04:19:40 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: chenhuacai@kernel.org,
	yangtiezhu@loongson.cn,
	jianghaoran@kylinos.cn,
	duanchenghao@kylinos.cn,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	vincent.mc.li@gmail.com
Cc: bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH v2 1/3] LoongArch: BPF: Remove duplicated flags check
Date: Wed, 27 Aug 2025 09:47:31 +0000
Message-ID: <20250827094733.426839-2-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827094733.426839-1-hengqi.chen@gmail.com>
References: <20250827094733.426839-1-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The check for (BPF_TRAMP_F_ORIG_STACK | BPF_TRAMP_F_SHARE_IPMODIFY)
is duplicated in __arch_prepare_bpf_trampoline(). Remove it.

Acked-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Tested-by: Vincent Li <vincent.mc.li@gmail.com>
Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 arch/loongarch/net/bpf_jit.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index abfdb6bb5c38..b646c6b73014 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1462,9 +1462,6 @@ static int __arch_prepare_bpf_trampoline(struct jit_ctx *ctx, struct bpf_tramp_i
 	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
 	u32 **branches = NULL;
 
-	if (flags & (BPF_TRAMP_F_ORIG_STACK | BPF_TRAMP_F_SHARE_IPMODIFY))
-		return -ENOTSUPP;
-
 	/*
 	 * FP + 8       [ RA to parent func ] return address to parent
 	 *                    function
-- 
2.43.5



