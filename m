Return-Path: <bpf+bounces-53890-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 723A0A5E076
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 16:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A86651762E7
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 15:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A2D2505DE;
	Wed, 12 Mar 2025 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8VBYszX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F6A86349;
	Wed, 12 Mar 2025 15:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741793745; cv=none; b=Ruof8xTnZgmkSVvaFkgw4qMlEDDzs5iE2rFnprQXkOKW8nHAuOkq8prAbq3Y9fggXHlTWSeu30pD9XcpksB5BrmZrO7MTJApzuLrO5iFrUy1q0uPFWzi3eSrtTXm/J1Zs9Pdjz34sJyfHZsxefsvJCw2UrXYNDCk72War2pjjC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741793745; c=relaxed/simple;
	bh=iThYwK4EmPrRI4upTEGDvCQyHRBO9egb8OVxwSk38F8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BIJxVbFSiA7h5UG7I6OwOTc/rVzwxHnDEDz2TFOh0NEF7WUjzsntjaLOHXu6PfsoAD2pNtr0v3ihRE1WhzhcFEnytaFqFi3OwNOHMsoKe7AY21NcEEj45AcEGYS98gIlzdZgJzsIPrsbB5kq2qaaDfPdjm/8ROKZMQFdSb9GHs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8VBYszX; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22401f4d35aso123755525ad.2;
        Wed, 12 Mar 2025 08:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741793743; x=1742398543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FNfUJqGWs4LAvggfBraM7yEuGB5LY5AsYklblXk1ZPk=;
        b=f8VBYszX2iQ0jEGF1urW7kIB/XLry+Y04O5W+Px6tJRKNmU/j992IpWT1y/POr7bBl
         HjKO2pNYMhV7OHeiAuawZL2q+Y/y5tOTgcZnRy4a5ux6KFnVGY46q+WEj/J4uaZT51xE
         oYpxtll2LcL8zHjvL/gI69luMYSAC0GkSOJk/CtQUQEF+qx3eXsUbqMmKM5npesfMSzo
         eyGE6w3ISrgctCcg5khSIQfIFte1rgRxksmViP2x5bG6k2nyT0JOfQIYslbG4OZzEL99
         icuT2KjuuI0ojhIvrajicAWKu2P7wz/Tb9ntAOcaDw99lB3y6WgPJWrwCk6UywtFSMvK
         kAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741793743; x=1742398543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FNfUJqGWs4LAvggfBraM7yEuGB5LY5AsYklblXk1ZPk=;
        b=MOpF6gJ5jhrogecDjOU0crksgOwjJo7KnGOi9Xg8Ra71FM3DBBPqlv9Wm9OrFOWzuj
         MiOFtth88GN9oY6gY/uDA472YGdqcnFafBrtRO4z8GYidXRIrO3Thql5IErfoS4qUQFq
         xsG7/OoEsqHHF3Aqyb3rcQDt4CcW2jM265VysDulnkAHFNZ9qjqiZcm2/DpbkVeW8GL5
         GirVCpLiFOCeOI9C40k3+VSZTfeq7nX56ehDrXsB7/yvTDEpYpobcqTRVKD2+1e38gw9
         uvNdkmijGBBtcz5ws7hvmpvVEUKDi3rotc00YPK+sFudwOSFY4oK9S3hDmohN/vUB7g6
         /1sw==
X-Forwarded-Encrypted: i=1; AJvYcCV0mBXXnwU8+Vq8BXjbxDhPgXu1S0wB0P0BZhig7iTvhXzOMsHaC6Khtn8GPoRUkg+GUl6kXA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeMWclGAxY15k4Jgka4aLsFghWMrbAvzJX3i6zl0jL/CIcXbiV
	LiCr5MX1S2nDMYFUzu+3E8sAF7SZNGcE8ILCBgsoSQZscgQ8QsCJ
X-Gm-Gg: ASbGncsWHYFo8W1/SAdCBVGfiZNRqkHPzGavvwN0fdJcKcf5QZPvPbNu06tTA6JIbXr
	5dhlaoPTznlkl0aGzPrlElx+uYITYixGe9J3jKhXKBv24PGJBVLdBUB3387VeJbJL2EcJ6b4AHG
	d76jcA/7M4WFhFicUEjH1W/beFiHQcQY1sGBsKzt3FIX8Oh0gNzUrub0zGwSIQaFl0n1o+RKiRz
	+Eqw7RO7SxKWZxcrHHuF5el3za+lE7JBrZ2j579JkDOY14QYX0sOZRnhaFjmT7DfUFCR2iizi4j
	xQgfMmlTtguro5rztChyZ8QizvO58rQjS7+zUsbfHAhnlegY4euOizwyKNWjVra+8PLOmHfDb5/
	ddWy3h+l9v6nvNErKZecV
X-Google-Smtp-Source: AGHT+IHkFdOz/srO7lLUB5L1mV+lcmU7yjkSevsRXVCm0SlFt4xhgIdr9UFjY72/k6ZD32I6rmQi/w==
X-Received: by 2002:a17:902:dacf:b0:224:1c1:4aba with SMTP id d9443c01a7336-225931af109mr107569025ad.50.1741793743138;
        Wed, 12 Mar 2025 08:35:43 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([114.244.131.122])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736ab812cb0sm10813562b3a.164.2025.03.12.08.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 08:35:42 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	horms@kernel.org,
	kuniyu@amazon.com,
	ncardwell@google.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH bpf-next v3 0/4] tcp: add some RTO MIN and DELACK MAX {bpf_}set/getsockopt supports
Date: Wed, 12 Mar 2025 16:35:19 +0100
Message-Id: <20250312153523.9860-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce bpf_sol_tcp_getsockopt() helper.

Add bpf_getsockopt for RTO MIN and DELACK MAX.

Add corresponding selftests for bpf.

---
v3
Link: https://lore.kernel.org/all/20250311085437.14703-1-kerneljasonxing@gmail.com/
1. Remove 2 bpf unrelated patches which will be separately submitted
after the netdev conference. So this series is consist of pure BPF
modification.
2. Fix selftests by adjusting the test/expected value because some arch
configs use HZ=100. Now those two selftests can be used from HZ=100 to
HZ=1000.

v2
Link: https://lore.kernel.org/all/20250309123004.85612-1-kerneljasonxing@gmail.com/
1. add bpf getsockopt common helper
2. target bpf-next net branch

Jason Xing (4):
  tcp: bpf: introduce bpf_sol_tcp_getsockopt to support TCP_BPF flags
  tcp: bpf: support bpf_getsockopt for TCP_BPF_RTO_MIN
  tcp: bpf: support bpf_getsockopt for TCP_BPF_DELACK_MAX
  selftests: add bpf_set/getsockopt() for TCP_BPF_DELACK_MAX and
    TCP_BPF_RTO_MIN

 net/core/filter.c                             | 45 ++++++++++++++-----
 .../selftests/bpf/progs/setget_sockopt.c      |  2 +
 2 files changed, 35 insertions(+), 12 deletions(-)

-- 
2.43.5


