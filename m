Return-Path: <bpf+bounces-39584-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 873B1974AA4
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 08:52:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 294401F276BB
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 06:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046D281AC8;
	Wed, 11 Sep 2024 06:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvY69Lem"
X-Original-To: bpf@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABEB7D3F4
	for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 06:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726037528; cv=none; b=HKiSSlO7tEu5grfGaHH2FLboUwQpUZ7G3Iw94IXxyEhpV0OZQVIxPDq03slgYfXXqOaTTTEOGQXTeVTyr92PHJDxhkU/GgozerKTn9WQpGO4C3OSpigEODoHdWDWPF0z8of5Ky43pEtfT0UsDEqFtPfeUxrizI8dkUXLTjWeIro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726037528; c=relaxed/simple;
	bh=2NuXo2FT4Sp+yvR8HX71hB5YvzfQ6J8TfwfJqZhgp/I=;
	h=From:To:Cc:Subject:Date:Message-Id; b=BQv19IaUtuh/Z9mpWUn58V0BWNflyhe5fvlL8Jj2j160QwcXN+thqsxkbDiawKtkFcUv2EtCqk4EqZkA15RyAeeJKdDhb48CzZh9qDUpfVxZnynKbpyURRzDrS/Qe4pCDkjbe39P0tNM+HY0m1xs/HVAz48igDfjUP6yeUEXu9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PvY69Lem; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-82cd93a6617so152021139f.3
        for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 23:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726037525; x=1726642325; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zI7WJNSR9E+kvX52inSPOsy/SS/y4nRHtkueFnoss50=;
        b=PvY69Lemdr71/0pkjqt6/P6MYHUTbnQFnMetCVRiEq78ivR/ZUeLcNnVIbWhp1QX56
         cmzO00FFPHmqsfZqrOhfpBwpDi8alZT0JQHW34C85Y6aaqDasY/lPEMlMcuENzEXLf28
         N4tgl9JeSA8uyzuIUR0CfoGDtYcKy/JulJq/HHzAJC/+UZBIjrqrfmZ6t6GZRButGlZ+
         Nk/nuzd6TStJG8e0wS0m4YA6aXsboy27j+7Bs+yl9nt4ITzxYAQGTaCHpip6nRgnlhZB
         oIYd/52ZA3r+Vmno4KdFSp0a4izFRJVa9pCvrzJ3p+62KT+lwqvr4ntgPJfW2wV6I+ho
         AEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726037525; x=1726642325;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zI7WJNSR9E+kvX52inSPOsy/SS/y4nRHtkueFnoss50=;
        b=Uxc4i5ubkr3p5elHEECY9g8PdKfDa175F/E48xyfwrONT2BKpU7DPnvTW7t5M9Tanf
         eD89nEpcgHBWjrUHduser/XsqriZwDz+VK8tDCtbooIBz1wLuogiOhrNrWXcW/KDMmN8
         vJ6DNfougikbyp7nF/eu8J+oPBkql3qOPN750HlkZ+Twh1+H44LMWAWw6+tWn0We1Vir
         AakMGihl3xqDspapEVdBVqwFEM77ad/b8ZEUx2TIordDyIXkBkim1LVZFnvWg0F0EhUN
         cvyMNaetD5vLa1KhmDbH0esXZHNJIkHbif6+banFildHYH+w62DECZAcbpHAw6v5gNxn
         KFGg==
X-Gm-Message-State: AOJu0Ywma8nClGC2Yq5jtmauiUA1sB6XjYgkq1R+dw7xR2z6X9u4t/3M
	+5LSHuYDMFugLuquOg6SlWE5fF/C7KvFBK7YD7MOvkBjzSByzdm2dEwjNQOk
X-Google-Smtp-Source: AGHT+IF6GgaqxRsDjReqS2O/bHsV1FPgmQzcOZJsbozrJ4b6I4+8b3ZIvT5mo1aAST3haEDuKYsKsQ==
X-Received: by 2002:a05:6602:2dc5:b0:82c:ed3d:3a4c with SMTP id ca18e2360f4ac-82ced3d3c29mr1076468439f.11.1726037525177;
        Tue, 10 Sep 2024 23:52:05 -0700 (PDT)
Received: from localhost.localdomain ([149.129.99.104])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d8241be7c2sm6709758a12.40.2024.09.10.23.52.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Sep 2024 23:52:04 -0700 (PDT)
From: lonial con <kongln9170@gmail.com>
To: bpf@vger.kernel.org
Cc: lonial con <kongln9170@gmail.com>
Subject: [PATCH] Fix a bug in ebpf verifier
Date: Wed, 11 Sep 2024 14:52:01 +0800
Message-Id: <1726037521-18232-1-git-send-email-kongln9170@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

In find_equal_scalars(), it should not copy the reg->subreg_def, otherwise a bug will occur when the program flag has BPF_F_TEST_RND_HI32.

Reported-by: Lonial Con <kongln9170@gmail.com>
Signed-off-by: Lonial Con <kongln9170@gmail.com>
---
 kernel/bpf/verifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d852009..1e01b7f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15101,7 +15101,9 @@ static void find_equal_scalars(struct bpf_verifier_state *vstate,
 			continue;
 		if ((!(reg->id & BPF_ADD_CONST) && !(known_reg->id & BPF_ADD_CONST)) ||
 		    reg->off == known_reg->off) {
+			s32 subreg_def = reg->subreg_def;
 			copy_register_state(reg, known_reg);
+			reg->subreg_def = subreg_def;
 		} else {
 			s32 saved_off = reg->off;
 
@@ -15109,7 +15111,9 @@ static void find_equal_scalars(struct bpf_verifier_state *vstate,
 			__mark_reg_known(&fake_reg, (s32)reg->off - (s32)known_reg->off);
 
 			/* reg = known_reg; reg += delta */
+			s32 subreg_def = reg->subreg_def;
 			copy_register_state(reg, known_reg);
+			reg->subreg_def = subreg_def;
 			/*
 			 * Must preserve off, id and add_const flag,
 			 * otherwise another find_equal_scalars() will be incorrect.
-- 
2.7.4


