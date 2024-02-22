Return-Path: <bpf+bounces-22500-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CDA985FBC8
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 16:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50B5E1F24A52
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 15:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1661487EA;
	Thu, 22 Feb 2024 15:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDwQ2Gq2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B0A1474C2
	for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 15:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708614211; cv=none; b=LR0DGqrXPQ/8lq3X1AGX94kiyy69t5SB7FCrSoiYF+Y0levVe4C+uhcnF08frVf62fmrkEJwoz3tdd5vENisIJqsHe+vkjMDGEWZ6WfitIUdMJlT/gx+gsocln7RqJG1+8QKhL26UnC4oQWa1m37sktyVpDUbtW7sfzCfbwEmfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708614211; c=relaxed/simple;
	bh=5wZLpoBNjJCSPmwWhvPunTLvS/0mePLtMUHAi4QL2+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tfywuPE1iDvnP6rbLUtccDjh7zXiXpN+cmL/hNTRcfClUb+HaDpae/iKFk4p/6QpYHxD5w24ILz82PSSnNMIsqIcdZX/QxP43i8Nwubj8jOJaQVCYyJKzi+fDa9W+QzEC0FJyPs+ebhgpvMHGvSQ0JnUhxG072M+I7U7XK3wCV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDwQ2Gq2; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a3e8c1e4aa7so241835866b.2
        for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 07:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708614208; x=1709219008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+VDwSdWvpsp9rCsAdzOadN10OTvfKz4e4CfyujRHrdk=;
        b=KDwQ2Gq2PAXUUqIR4a0MEUDuiIupCDwdiQQdsOvf3PmhwdCB1a2nZLJ8VkXRLhODAr
         pHmP3IHnXP3Zd989M+CFYCg/BkrEgcz0S2yqe45bvKjFrUQ1xXzAM+zEKrOh2FwZhwLE
         2b9h0MPihLdOYjBX6Yxl92qYNjMdcoZh0IpaR3XjZJRLO3AXsXyxPOMNUunrQiLm8prg
         J/bA5wUg73Ck9HWK/SufYzCdRAr1VoxlfpMll9DAwXwXV+agyttvCYUF03jgC41MCezK
         U5qLbhKol4H5OwSzHj+MqtLNvx+xGB30RyqTqWc5rMYGNfuU4nCEztrxNDtsICJ2ndJA
         gsog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708614208; x=1709219008;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+VDwSdWvpsp9rCsAdzOadN10OTvfKz4e4CfyujRHrdk=;
        b=AFEQQu5o34uKuED8jA+fj4aypwOXSOtDihczlEfVenVhgtXbwXtTF23ejiueHmCgXT
         9BJiXI/TrHS+0opXVJ+nwO4Bu58TXJ2p3B3P1Fv2nMV4Tm/eJfGDW/xMGREYvejoAMXQ
         jun6KhFwV/nl2rild0fl21+8x7BSyZd679UsUaMFlqD9IZJriA4ZWEQ165NaIQNNr+sL
         4pjyCUC45Cg9pQZAz7+RbA7q9kGvOgxCfgIT47rOIEgPhQWKZIY+jlCcddKYsRLYEEzc
         tvmNTpMf/9jT4Pla+CUnMS+ksuJaFKbNgq+kLWFocL+Wy9PgICazQo/5Xbh8nXSC3dqf
         /TiQ==
X-Gm-Message-State: AOJu0YxPK4B0E4DoQeL92KodyHhk7HpwyI9Uk02iUqIf2DXuVBZ8s3yW
	SH1zJ7zAsTCbyNH+t3wuSUpN2INAifUDN8HPR5C3McpAzyn16T3nFinjUjGR
X-Google-Smtp-Source: AGHT+IGfimm4rTTE7BTLtRMuAIpunU2wDb7MFoYXp/QaVQqoc+D6GL/45k/hqAAC4ESviQou4Q0DPw==
X-Received: by 2002:a17:906:4ecf:b0:a3f:583c:b00c with SMTP id i15-20020a1709064ecf00b00a3f583cb00cmr2529906ejv.43.1708614207634;
        Thu, 22 Feb 2024 07:03:27 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id rf20-20020a1709076a1400b00a3f2bf468b9sm1869059ejc.173.2024.02.22.07.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 07:03:27 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	kuniyu@amazon.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 0/1] selftests/bpf: reduce tcp_custom_syncookie verification complexity
Date: Thu, 22 Feb 2024 17:02:59 +0200
Message-ID: <20240222150300.14909-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thread [0] discusses a fix for bpf_loop() handling bug.
That change makes tcp_custom_syncookie test too complex to verify.
The fix discussed in [0] would be sent via 'bpf' tree,
tcp_custom_syncookie test is not in 'bpf' tree yet.
As agreed in [0] I'm sending syncookie test update separately.

[0] https://lore.kernel.org/bpf/20240216150334.31937-1-eddyz87@gmail.com/

Eduard Zingerman (1):
  selftests/bpf: update tcp_custom_syncookie to use scalar packet offset

 .../bpf/progs/test_tcp_custom_syncookie.c     | 83 ++++++++++++-------
 1 file changed, 53 insertions(+), 30 deletions(-)

-- 
2.43.0


