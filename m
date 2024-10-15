Return-Path: <bpf+bounces-42028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2255D99EEC1
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 16:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D160A288EA2
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 14:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD851B21B4;
	Tue, 15 Oct 2024 14:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QH0a1BVa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2D514D283;
	Tue, 15 Oct 2024 14:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729001297; cv=none; b=HPvtrGd38SJ7sdnIlUUb/0JdhID9yse9KMLlbXtj4apseNIVyh810U/sWAmwkeSXTflsJ4Z7WXXBtTVNyUA5MfpB/tdYf3cou38R7J/D2j5IKENbuSIcQ7wFhAUjLhBpr82DznsG0+0gYZus0x93T1LAbFz+aF4HJYuFfl0B1As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729001297; c=relaxed/simple;
	bh=SdRhUPPHFHXC1xpfQuq0g1vtB4NUTL+nVKsz52Zeais=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rn07vENTrNFnvCo1B56n5Gv0TtIhFYGw826nJFIyd90sxCRDolCDVocipof1wc2/QSID8lED6LhAR3OiBsHuzwKsda4zCPU/NIqZI87O8mY/Ppi9dVJha45Mhu2YUIIDHocZa2SDz0AhVf2tgRbp8og6X0N4NxbPo0sHD2gniZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QH0a1BVa; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-20ca388d242so28633385ad.2;
        Tue, 15 Oct 2024 07:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729001295; x=1729606095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=59OjeE70KMfAYYXX4g/s1D5SKLpH3DxcgTnqpspojAE=;
        b=QH0a1BVazLTHNevSjOwlRww7Zgt3f2jKPCSsYR1/BLQwmBnt1t4lmRlI2d/thMlJOD
         7FfbSWXzujlTokantV/hiEvWFQ0Xo6pSFOZ7X/vh14a7G8+hAf/WHqG7MzRO8bhNYFcP
         wQnITlK/OsiJ02ON1y1JNjZFSL6PgkXu7w14tbeAOOkvbPLwb2GbOdsZkSW4d+V3YaPl
         db1y772DAQsXlLEnZZF345sl4Zts4Ix3K1rP2pdx2w32GdHiD3nvUlb9V6dvXZbE/NOX
         f+9yg13bv7NzHsQ4c3x+w5zErL49tHhkrgcWcnft06LOEyutDNDIu8XIiepBixfBCtm6
         YCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729001295; x=1729606095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=59OjeE70KMfAYYXX4g/s1D5SKLpH3DxcgTnqpspojAE=;
        b=qTNBo73rIgtWuRDpwunjjRw6fK+YCVC7aE6yf8jOZHWbRuqC3wQO8WoRGQNA/Vs6/I
         ZffuOSZMTz2icxeBFRww/IKQYKov6Sq2mp0WNsNv/kS2Na4hJJ2SYVZ2/PervIb7XWOU
         wQNgDjqzz/8RKku3Zg3BCwH9usipJgVpmRtzDm78G1WorDY4FCxdgTapzxhl/ZDilSD+
         V1e7LBYZ0UHjuQJe9HQ2ejpXhXkehvkIK4ZE3OOn6UY993yrffBVJdgtxNq94SNfyk7I
         kt1eG3mSFZ3JwO08nJYc9hJLVo389vjwwBsX7JMfYh24w4kOqO8Vit3z/pc/0/pWxS5a
         qgMg==
X-Forwarded-Encrypted: i=1; AJvYcCUHiAXBzDs/SFrjd31CCEntvI2UhX8nQRcRIE+k4n2jka0hRnWE5f4soORInEOXfayJ6wEfUDq4pUifDzci@vger.kernel.org, AJvYcCWwcE8Y2WnxrFdjjkXA5JefHUXcq81ZCJDqMV2+hMJjAaY45ifcA6KUSTNUEqMJRSjDYHzZZQEJUBxWcGSzlHvD@vger.kernel.org, AJvYcCX9lE9fEdtZoCW3UrN/6OH3ARC13IBARHzyQUIruzV6k+L9O70auE97g4Iz0glZ5sQx7n6+3NNK@vger.kernel.org, AJvYcCXN8UDv7fV3+mKThI8gDgGXZOCYDe2cxhX8D8ZlrslVthWryNYQFP/1XYnBVnCh9c4gCGo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz485Vt07rvuM+FAH0qM1mJ9dYtHT7Mn7dzNaJM+Si/wcB/6YYC
	enuEFYjzaxt0WjhJE42rJyLj+DTby+lkwu+WIkiHxZkL3Rhw+Fae
X-Google-Smtp-Source: AGHT+IHuZyCLIzTWRvWfCqwBL2LHNbLeK+xm/bpQdNVx7q0gy5JC5xAbFQM6Eh5o+P/Yka4vu8yY8Q==
X-Received: by 2002:a17:902:db0d:b0:20c:637e:b28 with SMTP id d9443c01a7336-20cbb23057bmr167155595ad.39.1729001295219;
        Tue, 15 Oct 2024 07:08:15 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f9d419sm12437625ad.93.2024.10.15.07.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 07:08:14 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: pabeni@redhat.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	dsahern@kernel.org,
	pablo@netfilter.org,
	kadlec@netfilter.org,
	roopa@nvidia.com,
	razor@blackwall.org,
	gnault@redhat.com,
	bigeasy@linutronix.de,
	idosch@nvidia.com,
	ast@kernel.org,
	dongml2@chinatelecom.cn,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH net-next v3 00/10] net: ip: add drop reasons to input route
Date: Tue, 15 Oct 2024 22:07:50 +0800
Message-Id: <20241015140800.159466-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this series, we mainly add some skb drop reasons to the input path of
ip routing, and we make the following functions return drop reasons:

  fib_validate_source()
  ip_route_input_mc()
  ip_mc_validate_source()
  ip_route_input_slow()
  ip_route_input_rcu()
  ip_route_input_noref()
  ip_route_input()
  ip_mkroute_input()
  __mkroute_input()
  ip_route_use_hint()

In order to make fib_validate_source() return drop reasons, we do some
refactoring to fib_validate_source() and __fib_validate_source(). The
main idea is to combine fib_validate_source() into __fib_validate_source()
and make fib_validate_source() an inline call to __fib_validate_source()
in the 1st patch.

And following new skb drop reasons are added:

  SKB_DROP_REASON_IP_LOCAL_SOURCE
  SKB_DROP_REASON_IP_INVALID_SOURCE
  SKB_DROP_REASON_IP_LOCALNET
  SKB_DROP_REASON_IP_INVALID_DEST

Changes since v2:
- refactor fib_validate_source and __fib_validate_source to make
  fib_validate_source return drop reasons
- add the 9th and 10th patches to make this series cover the input route
  code path

Changes since v1:
- make ip_route_input_noref/ip_route_input_rcu/ip_route_input_slow return
  drop reasons, instead of passing a local variable to their function
  arguments.

Menglong Dong (10):
  net: ip: refactor fib_validate_source/__fib_validate_source
  net: ip: make fib_validate_source() return drop reason
  net: ip: make ip_route_input_mc() return drop reason
  net: ip: make ip_mc_validate_source() return drop reason
  net: ip: make ip_route_input_slow() return drop reasons
  net: ip: make ip_route_input_rcu() return drop reasons
  net: ip: make ip_route_input_noref() return drop reasons
  net: ip: make ip_route_input() return drop reasons
  net: ip: make ip_mkroute_input/__mkroute_input return drop reasons
  net: ip: make ip_route_use_hint() return drop reasons

 include/net/dropreason-core.h   |  26 ++++
 include/net/ip_fib.h            |  18 ++-
 include/net/route.h             |  34 ++---
 net/bridge/br_netfilter_hooks.c |  11 +-
 net/core/lwt_bpf.c              |   1 +
 net/ipv4/fib_frontend.c         |  81 ++++++------
 net/ipv4/icmp.c                 |   1 +
 net/ipv4/ip_fragment.c          |  12 +-
 net/ipv4/ip_input.c             |  20 ++-
 net/ipv4/route.c                | 212 ++++++++++++++++++--------------
 10 files changed, 245 insertions(+), 171 deletions(-)

-- 
2.39.5


