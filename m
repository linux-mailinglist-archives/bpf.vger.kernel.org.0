Return-Path: <bpf+bounces-44230-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0269F9C068F
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 14:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 447ABB231DB
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 13:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D66F3212D0B;
	Thu,  7 Nov 2024 12:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwdYUcVX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F4B210198;
	Thu,  7 Nov 2024 12:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730984200; cv=none; b=MKnPT9zD7Jp64YoN2VAEY0DDCC1HUApOnYInvZqPbDX/uWklD4SLro9gZQzWSPPOcMATbtTxyR+NppXuscIMk1/HGf7GxnsEK2Ngu+A+6lON5q75hFyFSM5PAunpP687NrTxSabrx+1l0MsE52SVpKss24ts+CRzj/GpThGu15o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730984200; c=relaxed/simple;
	bh=90LuHD8laAu8s+2lzOXwrI1PNKvtP9Qf1hO/C06hHiA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=igUJF5Q7X/LpNwZdy58mY2JZBQq0Q1sOekR6TGcTQs+wzAwZ4Q+425RWvQc2whRhjwaKqCJtvGGrRcTMwgZwMhf+tizKKCW76cbiV15Kp96NBM9fJZsMfZYOKTC8ccFS2FXEKzZYgi+uSYjkKgO6kbq012F3r8r+nA16pV6yW3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwdYUcVX; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-71e5130832aso644958b3a.0;
        Thu, 07 Nov 2024 04:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730984197; x=1731588997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UdA7nsCFTrN7tSAJGLMrxfIWlfUIz0l1LxRNiQDm5GY=;
        b=SwdYUcVX7XCdGKsHHJ5fOVxauPK5ka2h8D6TkmIltEyfRVN3M8K+Fqgw8Y27F97Vfg
         utPCvIDDbKwRn83nJaiOvBy1oQkpMb2vLSWyBMMy2qN574+nTY13CThtQPHoh+a9HT/V
         aPAQtX3gaKWNA0AsPPz/ke6MmNq6TDwJe4D0owobgP/If3s4R+lwM4u9G6aH3g4GiVbU
         d+V2p1iNUDE2E54gCehJgIOR+wuWa9JOG2HwDeYRntjwb15N0vTOJoiaq7/KJydnmuoF
         LcfQ9K91nLRUrA00lLfr3qWYhq8/u7FUJp/JEPUeP6uydr62bp9iu4wFce2ypLdWsMZs
         NWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730984197; x=1731588997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UdA7nsCFTrN7tSAJGLMrxfIWlfUIz0l1LxRNiQDm5GY=;
        b=Q6lFo95I5HSSL1PNv1zmVYP0seFuv+G5WdZNqm7qr+EusN9/CHMbpEaxEMOA/6l0yd
         Fzdqcu2d6mETCRLbjwqpVxorGM82zcBqEXWFkosQSQmnhPnd8BXyiL6xrtmLEmlATZmk
         KK+YntoWe77PCDZj1YrQxG/CPvdQOJdNw2q4FPGobv+G+MlQZ+3rk/NpyE7i+mtbdrnI
         DyOuC0JZCMOpyESSI6bAUGzsPS8sl09sVCS86fW9NclvHBlIc7HVQFYQDpAw2jxd82S3
         1EkxcPGS6LYmELteo5SmmU9aRKaBAuwbZVDHqpQ9/KJfAEitMqXQmCyBxbAITZRDdg/D
         qelA==
X-Forwarded-Encrypted: i=1; AJvYcCUNMiwLDQrApEAmsFSUvACkp9xKeOXpBQOdnXG/myF6QCi/wdQHvPV+9QoA/ITGksh9WYSEfcgYBV0sJwaRF6yC@vger.kernel.org, AJvYcCURoJY6x6UqwSQuBqQx4I/UZnClVb8O1V20pepQjIPlmth9j8KwGyNHFACKx8UBOW2CX0z1gPvN@vger.kernel.org, AJvYcCUUnhHsJBOltsm38fiHwROBjOKZB6iHIuz0+3P6hixuRaOLhuU8JIgO4SOZp5eV31Vu7I4=@vger.kernel.org, AJvYcCXY1ir9jFN5NcJy0xy6rGCvFLW3WHUjSuOMXyZN8Ab+louiALklPJxcZUUE/b3o7CjWCdmQmdgDtShMvoBD@vger.kernel.org
X-Gm-Message-State: AOJu0YzNiLviUwnh/bQI1qxmKADlvJ30XAMkHn3snRNxEm7wwQtjMVRg
	35tbvzvc6Vn8qsh5hRDIY/wA41l0zXmP24orHorZT7k7CGZi4f4Z
X-Google-Smtp-Source: AGHT+IEzr1IifU6MMH+fx8wH4FyqoykSy74KB4WKiRH4KzZnH1+yiCSFlPrFXP4KUGKs3piToboQvA==
X-Received: by 2002:a05:6a00:987:b0:71e:6ed:9108 with SMTP id d2e1a72fcca58-720c9883499mr30639483b3a.2.1730984196934;
        Thu, 07 Nov 2024 04:56:36 -0800 (PST)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7240785ffeesm1441651b3a.3.2024.11.07.04.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 04:56:36 -0800 (PST)
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
Subject: [PATCH net-next v5 0/9] net: ip: add drop reasons to input route
Date: Thu,  7 Nov 2024 20:55:52 +0800
Message-Id: <20241107125601.1076814-1-dongml2@chinatelecom.cn>
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

Changes since v4:
- in the 6th patch: remove the unneeded "else" in ip_expire()
- in the 8th patch: delete the unneeded comment in __mkroute_input()
- in the 9th patch: replace "return 0" with "return SKB_NOT_DROPPED_YET"
  in ip_route_use_hint()

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
 include/net/route.h             |  34 ++---
 net/bridge/br_netfilter_hooks.c |  11 +-
 net/core/lwt_bpf.c              |   6 +-
 net/ipv4/fib_frontend.c         |  17 ++-
 net/ipv4/icmp.c                 |   2 +-
 net/ipv4/ip_fragment.c          |  11 +-
 net/ipv4/ip_input.c             |  20 ++-
 net/ipv4/ip_options.c           |   2 +-
 net/ipv4/route.c                | 211 ++++++++++++++++++--------------
 net/ipv6/seg6_local.c           |  14 +--
 12 files changed, 225 insertions(+), 141 deletions(-)

-- 
2.39.5


