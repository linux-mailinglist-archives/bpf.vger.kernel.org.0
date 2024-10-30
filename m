Return-Path: <bpf+bounces-43468-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 171A69B594A
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 02:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C94E1F23FE5
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 01:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5CA1917F4;
	Wed, 30 Oct 2024 01:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P95P2GHB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com [209.85.167.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C86BE46;
	Wed, 30 Oct 2024 01:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730252577; cv=none; b=aUYzmwBKlVZOYY0SgkVU2oZZ5OMAQLyO6ldwvSdm3J1cQZaQI9cmK3SM+8cbqj7E91xtIv6x3OehFFgRULKKdl+Hn2gTRGgHIMRa9/+4dK8P3gVfk8ELYkJh7OUXDMfG9abZxVejVG6mchNYcP+DDJMrKNgm9KXMBunMt5/QPas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730252577; c=relaxed/simple;
	bh=N8rGFDTUThVhTEHIJIIJx0HReyP83ZUzy0Cx8KDZfW4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sA1gTeMlKbUZroDoGkKH5bLJCwi9jWbHDvvTlIfw8jztVd13u+iH8yw9WW5J4SFziMC5seZ0BhSLHmsMFfluB7vGZBvDO7Hzt+hozJYEOArbqDMqaJfJvYGFuiI0vqV204Pe4SKODGrUqDcWRbi5lYpgYCguyc+q6DIgHuUQvjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P95P2GHB; arc=none smtp.client-ip=209.85.167.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f194.google.com with SMTP id 5614622812f47-3e60fca5350so3772244b6e.2;
        Tue, 29 Oct 2024 18:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730252575; x=1730857375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gq6+xdJlSauKVvYdMuUpgAyl8qNz5z/Asf+huhDS4l8=;
        b=P95P2GHBZm0ywCNtLGCrwuwxGL3uyvPt7Mi1D47KslU/PyHMlslJ+eM4WmVtDdIXI5
         +4T0wBtj+HIQ1kr0AANQDGQFTjyArE8eWBLxfyVNkJu16oKab9RFVsss3kzzrsZqHb0P
         ix+RyP0IRVqIkMKqY7CAMkER/1loVocKSB85yb/SNrcxmEtWAmTz4bs8bNqR3gtXKO/T
         QDx/OA1T/bUf8pZX0UQZrweiY4A02IG9KoTCocDF8OVLYTn0TyfAYrtSJDGQY+QsT+yC
         WfDTxJNdHHYbYu2s7TuTFK2lo1cRZ5Qgv8FXOVJqeVESb0M53COhkBOVGrD2k/oADgMe
         Ygxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730252575; x=1730857375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gq6+xdJlSauKVvYdMuUpgAyl8qNz5z/Asf+huhDS4l8=;
        b=UZVUXnTiz5MLqCm8dPoCcukk8bNH/6bWQBRZdZdJ5CXOioI86jYX7fxsDY64shzxLS
         2fGYRIJw+jTuNCvyJF6KpmXvmgBH2Q9vkcbGDVFwOhHw2q6bzEySztmgSJ13Y1PqARxH
         IvDwfyqjvYSCnrDV0WR0ScnpsHIXnbZL1/G/yNEY06vmFABpDDsWwt6O6pTqEs1CzOYR
         hXSGo0MgOLlayH2PQ9bn4FirgLyDPYfMFwTABNgbcRcM05s2XVpbcmygI2AjPwiN2ITa
         CbDZg/21ma1XzGU+myzhMaWyAqWhNiuK1pDPCjEidvSBDQOXLbw23eT4ATZ/Hj1b4c7E
         S4WQ==
X-Forwarded-Encrypted: i=1; AJvYcCUH0XuBmXqlXV1GSGrr0XBf1o2Hp4W/+H3tIv55r/Z76M0Oli+hw1n3HbH57V6OaoJoK4IU1ECxKppMfTpM@vger.kernel.org, AJvYcCUZx0V/0Q42/17DoP9uVY2qAUWuiE3e55h+c/zwlOcgIfS8kbuQBuLg0Zv7h/m7RK0wzxc=@vger.kernel.org, AJvYcCWjzZE3xPVxPykuEKxA3yanfSSnZMbOV7nO9PeXu7AhsQXKnaw8HZXISDeg6Og4C+w2UEJKnbqr@vger.kernel.org, AJvYcCWtDONqknRM1RurtM3VtHTFFmdiEt6/zQzle/ZY9MWl87A6BHyzWVghNRULYvRrE3iVn3v8ez/VVELpvZao5YgC@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2keV03C+BK/imC451zCybcMOcrl1WhtfbeahLwlCxDkV05BoQ
	UIIgLlH2Dyytd/xNvDbL4W9p5eeLm55FKS7KDONbfi2g0/jxxftc
X-Google-Smtp-Source: AGHT+IGLH/hZZ7hWGWLxPfmagO461IIMSWoSWP+WCb8WxZ7ERpymRfaGRQY/xzyfibXkMEpby78vsA==
X-Received: by 2002:a05:6870:e0ca:b0:278:c6bf:fd34 with SMTP id 586e51a60fabf-29051bdaef8mr12039957fac.27.1730252574765;
        Tue, 29 Oct 2024 18:42:54 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc866906dsm8138407a12.10.2024.10.29.18.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 18:42:54 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: pabeni@redhat.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	horms@kernel.org,
	dsahern@kernel.org,
	pablo@netfilter.org,
	kadlec@netfilter.org,
	roopa@nvidia.com,
	razor@blackwall.org,
	gnault@redhat.com,
	bigeasy@linutronix.de,
	hawk@kernel.org,
	idosch@nvidia.com,
	dongml2@chinatelecom.cn,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	bridge@lists.linux.dev,
	bpf@vger.kernel.org
Subject: [PATCH RESEND net-next v4 0/9] net: ip: add drop reasons to input route
Date: Wed, 30 Oct 2024 09:41:36 +0800
Message-Id: <20241030014145.1409628-1-dongml2@chinatelecom.cn>
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

And following new skb drop reasons are added:

  SKB_DROP_REASON_IP_LOCAL_SOURCE
  SKB_DROP_REASON_IP_INVALID_SOURCE
  SKB_DROP_REASON_IP_LOCALNET
  SKB_DROP_REASON_IP_INVALID_DEST

Changes since v3:
- don't refactor fib_validate_source/__fib_validate_source, and introduce
  a wrapper for fib_validate_source() instead in the 1st patch.
- some small adjustment in the 4-7 patches

Changes since v2:
- refactor fib_validate_source and __fib_validate_source to make
  fib_validate_source return drop reasons
- add the 9th and 10th patches to make this series cover the input route
  code path

Changes since v1:
- make ip_route_input_noref/ip_route_input_rcu/ip_route_input_slow return
  drop reasons, instead of passing a local variable to their function
  arguments.

Menglong Dong (9):
  net: ip: make fib_validate_source() support drop reasons
  net: ip: make ip_route_input_mc() return drop reason
  net: ip: make ip_mc_validate_source() return drop reason
  net: ip: make ip_route_input_slow() return drop reasons
  net: ip: make ip_route_input_rcu() return drop reasons
  net: ip: make ip_route_input_noref() return drop reasons
  net: ip: make ip_route_input() return drop reasons
  net: ip: make ip_mkroute_input/__mkroute_input return drop reasons
  net: ip: make ip_route_use_hint() return drop reasons

 include/net/dropreason-core.h   |  26 ++++
 include/net/ip_fib.h            |  12 ++
 include/net/route.h             |  34 +++---
 net/bridge/br_netfilter_hooks.c |  11 +-
 net/core/lwt_bpf.c              |   6 +-
 net/ipv4/fib_frontend.c         |  17 ++-
 net/ipv4/icmp.c                 |   2 +-
 net/ipv4/ip_fragment.c          |  12 +-
 net/ipv4/ip_input.c             |  20 ++-
 net/ipv4/ip_options.c           |   2 +-
 net/ipv4/route.c                | 210 +++++++++++++++++++-------------
 net/ipv6/seg6_local.c           |  14 +--
 12 files changed, 226 insertions(+), 140 deletions(-)

-- 
2.39.5


