Return-Path: <bpf+bounces-60783-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D8CCADBE11
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 02:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73F543B7E03
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 00:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4C9139579;
	Tue, 17 Jun 2025 00:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkDCiaPT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94188632;
	Tue, 17 Jun 2025 00:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750119766; cv=none; b=sn+fDCSIsr4S2mrIM/GBFoBq3CYeat3GkDy37enLdEvqmL03QPibSe3JhHUZsrwnrhOs5X8QGiVcl3ts0ILMF8IooJ0u8gbSTN6Zhrnotz3dJ9iBctHz30Z8yj6pNNykcWJ7vuNWbvCI7Kbk8sHmavlODBD9e2B+LZ46ChCZLjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750119766; c=relaxed/simple;
	bh=ifiLdSFjQX7kMyQsUwUgAzWnIbStH9hCdkGLsh+DO9c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pL5m4KIvIAftZm18WPyGXiKfZyZaZujVU80pUZ6kpu5Zm7BsVYxoMPg+qN4AdgkvHuiuIS+hgZyL8gjVwfVPVL4CDK3iJ0BItR05koLRlbEXakbLNL1fbGx+QAf1fGGseE77o/FOOZRk4yHwI3RJ6ZYMHu+JUWAR2YANODnTq9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HkDCiaPT; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b2fd091f826so3701134a12.1;
        Mon, 16 Jun 2025 17:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750119764; x=1750724564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zBcG1Lt3BIKP4gpzl4o9hJZrLstu7vqeFH0eF9H4TZo=;
        b=HkDCiaPTY9ZjJ6PP4bQiPcZGQtVUIPh2eFjE5FV8yeAgpc07CE3J0PC9Ji/byPDCte
         FsYU8v2AnfwoC/bd0nanU5vcEhX9GeaEtPzQQDfeOAFNY+fWZu6Go/+jXSXS+zBXcJ5X
         AA2phW9mTj1K+MumhuwMxKW2N+amOBfOpDVM/thUwdrUjsC47f7nOsN85YfsZF1aImpE
         I4VGLj1vrwoxVEGZoL+Yv8gXYVziO2Bueq3R4L0BN/jC0PG5I/ce7DVDSns4l/2a146Q
         CtXoySm3sXSMuUKScF7nNzlpJ2EZItnbuVv+MXPtEv9aT3Jzp/6CXstePPLA3HXjfeUA
         JbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750119764; x=1750724564;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zBcG1Lt3BIKP4gpzl4o9hJZrLstu7vqeFH0eF9H4TZo=;
        b=RuhaIIxxAP1gkTPakR7qPY089NCzLSXr9Ri++MK9hQo0pXHK4UjFgXmAiputK6Tvhk
         WuIBQqImL2xnRaZzP3OtvBPdSO9vjF47BAXY2LioZd1U+yrCcEW8lfejGkkqsPB4eYdD
         5KxjGAQm1QzQJgHE4mXUryWdUKjPpMqVCMst9i9XJ4ms/oTBkiD5gb6baVOLsjO7bhZz
         prVsUD6cBwtX2PhxFk7BuPUSE55RjYhFyVL2iAEiQ2Ox7tRRAX2jVk4ifZT7VcihWkQr
         pSonmUgzWu6vLC0qZn9mLB2zJUSiOcptjHf1/B0BxCP4QIlWRgrEHxnHejH4mYoX+zJ0
         Vorw==
X-Forwarded-Encrypted: i=1; AJvYcCVyUl1s3Z/716I2gIl1TpcDHQN+k23nv8YZWrfHwnHrxjug5JQSADS0im7ykfAcGzZnecfoWjs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTP4/UXriqep+AYOCcU4b2+TsxFYQVhSfkzmeudcqg9YR/tWjR
	6d6ztyvbmslCpfHymRdpFg9Gbg/w8c/KegR7YgoA2//rbxw5jKTyIfjQ
X-Gm-Gg: ASbGncu7CUPwwAohHAhnWkp7dVhuSDSDvPupRl8obAvseHelUPDv2dLVsI9HHwg7xPf
	KWH6vcL1xuzcyaMxB3P2/PW97Fl6viUcJxobAVYfV2TFbj7ZbDK6kcNmJiGixfLX2iAi/ceGrMe
	JGS/CL0yQ10wvjiSZk3dtlQ2LmyALZLUHwpK3Dc0NFLdbz68Po/El7TEb3Zdn25+wLaSkzi5tP/
	tvH1+uXps+aN0y6zaEPBiwICIIpXuQ1gy129l3WRqpKHiZsEjDnWHpZJj1dJXn28DXUS8/gjbn1
	hDmGiGVISLzT8ok/47SsR8Hp55+3jO1zocgE0etKt1i/oh59Yy/yQLOKD84u8hryo6RL5r1tGNy
	k7nRT1SC7WgHspewNvXJo2cCI
X-Google-Smtp-Source: AGHT+IEAX6q6gUqRgz/XTf3j9LFKw9EdjMGao1J8jOiJcseh4OzFo4qy/hdYy4DRwjwmyWWeVCZEtQ==
X-Received: by 2002:a05:6a21:3294:b0:1f3:26ae:7792 with SMTP id adf61e73a8af0-21fbc7e6c47mr15909987637.18.1750119763742;
        Mon, 16 Jun 2025 17:22:43 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([111.201.27.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900d252esm7488606b3a.163.2025.06.16.17.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 17:22:43 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next 0/2] net: xsk: add two sysctl knobs
Date: Tue, 17 Jun 2025 08:22:34 +0800
Message-Id: <20250617002236.30557-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Introduce a control method in the xsk path to let users have the chance
to tune it manually.

Jason Xing (2):
  net: xsk: make MAX_PER_SOCKET_BUDGET tunable
  net: xsk: make xsk_tx_batch_size tunable

 include/net/hotdata.h      |  2 ++
 net/core/hotdata.c         |  4 +++-
 net/core/sysctl_net_core.c | 15 +++++++++++++++
 net/xdp/xsk.c              | 10 +++++-----
 4 files changed, 25 insertions(+), 6 deletions(-)

-- 
2.43.5


