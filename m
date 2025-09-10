Return-Path: <bpf+bounces-67987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D22B50C5B
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 05:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43A721C62593
	for <lists+bpf@lfdr.de>; Wed, 10 Sep 2025 03:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C706C2652B4;
	Wed, 10 Sep 2025 03:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QW0TASYF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1DC36124;
	Wed, 10 Sep 2025 03:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757475667; cv=none; b=HqMolYJvHL8taKLvuYN1u7W0WFSS//eflgI2cZVe7oAeV4Zc2XZXNWzCMxERLRY7xnMeUC8e6iZmxFYz9SYDn8i9AVADTHnzlr+dw+GPJjvPPUlU+QKS/Sdwd7+pUPmMX1akDm/Z1BTsZOzuTE5rqxhI49wtrDXSCfcxzgQbjiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757475667; c=relaxed/simple;
	bh=RpSI/xWzBQygvW9ILf32By/3eFmtLqhCLZxvCQzMQU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Iczn6FILUo/A29pK1EsIE+Mq+kZPQ0NT/qMGw2urHwzNqyQChnp4axCxopQUTxt746VrZLcQ+o/49zxLyuWSl+zJW7oFbPu9B5dHHheP6rm6u0mIEm63lO6YopLjKFNFogRIaT07IzAGcEzMq0mxY77F4+xvrJY9CbL1upqx5fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QW0TASYF; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b52047b3f19so3779414a12.2;
        Tue, 09 Sep 2025 20:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757475665; x=1758080465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+e5cgywAX+BslFqDwivu8nMoqKltr5pUP40B5WR1v/Q=;
        b=QW0TASYFm/ILU8SKSKma/qPV0Eo5mh0ws2WzRAeSmCk+Zot4+eTvLsSnr8KvCYnJ4Z
         hej/A7Pwo4i1nrdQyw7NPvs5cQkPE31gVNJSEYbAeF1QW5RCYiymT21D+Ob/SsVG1Oc7
         /+xfx1J67LuxnZulCHcc3+pL2wiC7UbmlxoqsqyjxrVKPbpmf4bUiEOlPqlCrWTJcSvD
         sol4ZZ2b2dHeVgzB8wqXmlRPbP/oeFUjcynCjcJCVDnI7LfEaNar30EhBphIMM/OiavP
         TamTEgH1mvH1Pf4ZKqZncd9qEjCfDAq6Q4PARqwV5rDm6ruYsLMLSkK8yPsboDnME/0h
         pg0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757475665; x=1758080465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+e5cgywAX+BslFqDwivu8nMoqKltr5pUP40B5WR1v/Q=;
        b=OS2EYfjl/a28ZX9/dN2hHdxvYejWFvyLAwQ603kf9/MzN70ExAd2jrPqmSTKx9OdWa
         ar2bABQOxfex178BWPsKRByo1rFU3s6wd12+dTvSRXSwDBzDehtnpieY3WO42nF4fcdq
         HAUx6qilc9NHdDovQXNiUK2X6RqQLjbyPWZA6TUUVPhdVBojiNQuM8Zl7YvTANopkvbu
         +y8DEG8TQ/IAeoCrsDhSylZR0l6M7n4y4TLbfXDBXy9IzF5CIg0M59OZx/69JIBrtnrO
         Zgj/jirImSptwcLcBEto440DMemvsWnezM3uog3TPBn7/9xjhN5lrkPLUbj5E3UY61Gk
         IaYg==
X-Gm-Message-State: AOJu0Yx6mdTXMV5KcmcJYV5UQapOYrBKRYxRcY71rG3FbDXb7nRvFXvo
	mAERpUnhqcHPmhifU7AedmosYSVwk0BVjQ7+R+CBJhxtX0T7Pkx1xEWS9JUOoQ==
X-Gm-Gg: ASbGnctwyIqea406hFEgODJw1nCUOqC/WzeoEJ/FQfPc2CEWyVInoQXMgUoDCq16Nsz
	ZcHOlsDAvYslOI34Q9znuiFG01ecMncCd1SU00bSjEVwRi+s2afrAa2j2hdkxWqUQqd89is+u7e
	YEVQ0gDHDQ7TLg0xQAmMXg/K+nhPDxLu5wj5gC+UqxOE6tA5i15X8JQ0Hmenl/zauH8QAxzQkY/
	J/cl1rCzzHH0/sk0PAQJ0/AYkcTBishHNB7r3X+/Fu8v/Q3amHoZCJi2Vb2S+DYxT3TmKJozInr
	Ac3Fd+t3TzZOTx0d1TvhVPwXjyFxabCfOyhbSkGivnEXuHRAlK2TCZ0lGwSYu3ngNuYHQ8ILipA
	K3RQ9bNLh0O0JzQ==
X-Google-Smtp-Source: AGHT+IFis06sjltrvAf0fmR38H5K+p0ygqqIF7UsdKbCHMdbef62yX/3H3r0UIRR/ZRaueBRkUikNg==
X-Received: by 2002:a05:6a20:7f8f:b0:247:f6ab:69cc with SMTP id adf61e73a8af0-2534054a415mr17741054637.26.1757475664925;
        Tue, 09 Sep 2025 20:41:04 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4b::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dbb60f571sm745772a91.20.2025.09.09.20.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 20:41:04 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	martin.lau@kernel.org,
	noren@nvidia.com,
	dtatulea@nvidia.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	cpaasch@openai.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH net v1 0/2] Fix generating skb from non-linear xdp_buff for mlx5
Date: Tue,  9 Sep 2025 20:41:01 -0700
Message-ID: <20250910034103.650342-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v1
  - Separate the set from [0] (Dragos)
  - Split legacy RQ and striding RQ fixes (Dragos)
  - Drop conditional truesize and end frag ptr update (Dragos)
  - Fix truesize calculation in striding RQ (Dragos)
  - Fix the always zero headlen passed to __pskb_pull_tail() that
    causes kernel panic (Nimrod)


Hi all,

This patchset, separated from [0], contains fixes to mlx5 when handling
non-linear xdp_buff. The driver currently generates skb based on
information obtained before the XDP program runs, such as the number of
fragments and the size of the linear data. However, the XDP program can
actually change them through bpf_adjust_{head,tail}(). Fix the bugs
bygenerating skb according to xdp_buff after the XDP program runs.


[0] https://lore.kernel.org/bpf/20250905173352.3759457-1-ameryhung@gmail.com/

Amery Hung (2):
  net/mlx5e: RX, Fix generating skb from non-linear xdp_buff for legacy
    RQ
  net/mlx5e: RX, Fix generating skb from non-linear xdp_buff for
    striding RQ

 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 30 +++++++++++++++++--
 1 file changed, 27 insertions(+), 3 deletions(-)

-- 
2.47.3


