Return-Path: <bpf+bounces-43029-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E31AE9AE0E0
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 11:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4330C1F21BEC
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 09:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EB21741D4;
	Thu, 24 Oct 2024 09:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQin8rmG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1293166F06;
	Thu, 24 Oct 2024 09:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729762483; cv=none; b=nNyhGUs9pDeAy8hobqIbD1qvtFKN8SFyUi9hsNa4zUS46jzemWhpc3RgeZXsX173w5y0ABQkeoYXa7kAyPdvyMQQFVTyAmjZOU36m0+ljqKLvRhjBn0a7jJTPjZO4cCzNvuED2csJlTSiVotPtoWh0x/2CKmEFfY9yUmYAHKaNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729762483; c=relaxed/simple;
	bh=N8rGFDTUThVhTEHIJIIJx0HReyP83ZUzy0Cx8KDZfW4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cRYzaWbGZQpkU9CMwGf2RM412PvIKWr+ogl1uI/9Q69xSPWlRMow/HBbATwlPR49z+A5MD5n/PcMz7J087Y83YHJsOhTU26bO6vdspM1n8ppnEJELDj151FX6LTF7MH8O3oDTG+xCp4nZyiK/j+HYOQ0q9ZmuXd3SlGuR1/W8Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQin8rmG; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-71ea2643545so539099b3a.3;
        Thu, 24 Oct 2024 02:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729762481; x=1730367281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Gq6+xdJlSauKVvYdMuUpgAyl8qNz5z/Asf+huhDS4l8=;
        b=aQin8rmGWXZsuMlMjrojgqkPG4rKbTpYP8aLXHnWUyXI8/zWUCGoVBHGJIk97odxjX
         44XWR3wQkwAIcAy9BdQTDbBsFBjo/ZnWDWHA5Ez2eWWqPTxJ24sN+DRp+9pdJu0MjThH
         ABxHYFGHCaysNiIC3x2Si5CF2ubtIRVH49ara+h/R+L1o1Jo12jIjo3Gr1uIFw9YQoq7
         aJCc7M9yzquWYaNKHaWvObWLHwTRRaOpGl+10aaLySiXFoNk9TeczXUOBdp8LzCBYgvA
         wyde//WpYak33S6OqaezzHk+swOEXJol9l79TFvNEaBSQxm3RWE2qBQBBzjyXjUL/K6p
         7vug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729762481; x=1730367281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gq6+xdJlSauKVvYdMuUpgAyl8qNz5z/Asf+huhDS4l8=;
        b=mj1/cvu1/crVadNxFIgmh0bQhq42m6Avqub5DJ/zDrwncTKi/MyyAPMBDbHEq/xM+l
         ZI7CWx59Uku1jVltB0yYISpLVjD4zpHg+kNVdD3vb16NGgJ5lK16cw+1hudmdNF2rlIF
         MvdsZSasmAyPWRJnxM21puk7LX6AexuVgMqHOM0Z22HjwnXp5FuX2gJjsZxSyFQm3ruT
         HAYV56vH9HwAw5i7mY7EJI/GUwwCr+diwizpPkeajhAZKaz1ZfHBrNun/7rERgR+AjGJ
         eCRB/jAZPdgh3Vu1UFsPOz4vJF7gg6L3HzsuzRRJEl4/gaoxBHl51vwaF2XG6CcCiRTq
         YWvQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/pfWGZVTRuIBOFMKzgnBT4CZdUGmzXULvWYoOPzrRiaLZqC3TQSrhdiDt9jUfhU2rH+s=@vger.kernel.org, AJvYcCVmRAzKOM1ZvAun2fxCdD2AwBlXaxZiEoVPV9aQrgbNnAgspPo/EUAKtZjL/PCE8UcJg6+9wsCkZj6pNtWw@vger.kernel.org, AJvYcCW5dPEp3yPIrOjlju+848YJDtoon5awLBbWvSc0dMZawZ+A7bOOxkTBlLxHN6OqdBzUtzwWR8KU@vger.kernel.org, AJvYcCWCGt2KLX7Q1NJhEkHSlhGUSXnT/U33140D3BI3uXv+21GVPF7YHNZ0+ffECOdoXg6Q596oqP8o2r3FOAt2rT3Z@vger.kernel.org
X-Gm-Message-State: AOJu0YwVVKlGZuAcSGVsrFtQAxpXNcPdaTuDVRiPlErMtvLZiubpnv0S
	TPUCZyONagd8u7dJbiwStep0MFJhWFvfyeLvCwqwG65H8jy2Dhs1
X-Google-Smtp-Source: AGHT+IEi9NPaVF8AmWnxXDS59//oyrACNXuZ9nb/Z22FGVjJuu34vBlUIeCF56L0MF4nThbztRGTAw==
X-Received: by 2002:a05:6a00:3d4d:b0:720:2dbf:9f60 with SMTP id d2e1a72fcca58-72045e78ef0mr1482957b3a.16.1729762481077;
        Thu, 24 Oct 2024 02:34:41 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec1415071sm7600287b3a.217.2024.10.24.02.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 02:34:40 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 0/9] net: ip: add drop reasons to input route
Date: Thu, 24 Oct 2024 17:33:39 +0800
Message-Id: <20241024093348.353245-1-dongml2@chinatelecom.cn>
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


