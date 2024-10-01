Return-Path: <bpf+bounces-40642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F79A98B3FC
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 08:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6137F283CC4
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 06:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0731BBBD9;
	Tue,  1 Oct 2024 06:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OA+RgESP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA10B3201;
	Tue,  1 Oct 2024 06:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727762447; cv=none; b=S3rgmk1NRUYbTK80pJEBHhoJeer/Vy00a1scr6uTYobTo7bvUiRFz3YHqolvjgxWfJTSxLSGZeW0NwEne2+t4hsIHwnFjeU9l8cCc7d3rFzqPnBvDUrj2a5UMmpsdT5okaQwwi+VS3oIznPlI1TVc56DXQu2gol63Ptc+4bCjtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727762447; c=relaxed/simple;
	bh=celzY8OV4GMmy/RwTNyebjUESHinD4fwKxA7pGOfvoU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nJkkX78gKrZP0lkql3lMSejC9OAGYS29ZQ6eugdA6cM76xP2OoVH1RncWT+wWLF5MB9F9qiwgD0N3loLQVTQ5HBz6xPXNSGx09hUybNJXOjtDROWlyy2EvkSaQPv450HjnvgXixSv6hnoOgqk6Gxh3bZcOzsNtr8cllumYXmP9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OA+RgESP; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-20ba9f3824fso5077795ad.0;
        Mon, 30 Sep 2024 23:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727762445; x=1728367245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KYn484j8l4FCD86Dl+kKDGHdgRbar+9TjSd1oUL2FFI=;
        b=OA+RgESPelSiZUnaRnTHjYdyF2QSeZ1buauOmlg2M9+/8vi7j/gXp7MeorCsU4YUyh
         jw85mc6gDaxOYX9EXoYFNnodSNJMNQvLBDnEhYo6EdEwVczRe06rjjF5dYpwmttgjwcY
         39ymBNxeOj86y9VqB/tdqT4qUx93i6vGsItE6O7Iq/6bof7gI28J+KnOralm06udR+kp
         esmb40QaW9JJwS/uVKIDkEbmTN7e4mfAODNMsNNdMVLgT+EKfX5PWzt0shRJhoP5p9si
         UJsl9XnUtlizoct0e/U1CFTGHzW2R19wZ5NaqEzT2jx2e6fNoGXo2RaZXVnU4Fa4M/kx
         BU1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727762445; x=1728367245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KYn484j8l4FCD86Dl+kKDGHdgRbar+9TjSd1oUL2FFI=;
        b=i6ci5fIP4VEOcp1Vk/NRHWrXck6E0VzU8yf74dPzhP/OGoDRL8qz4NGCb/nRv8Owh9
         g+vLzumweD6FdVK47TSP6WH03UDEbUlGS8hbQw+YgLWamAJWj3+cqhw4clW5VxWb9D68
         EJSU3K2dGlo14+AS0ibiK23CCwBluOxOZfJ2AAm+dJ6EXghxx+yCK5SGKrr2Sg09ZNqQ
         tThVdW4wm+Dlowxqn6zTQfAl/XETcU5FkIEvJzvV2cE1jDj3w3pC3h5eRr9c09QSEYI/
         2I4OkG0iIgAFA1P1eJrkSA0NBFwgxCt0mEQl6x7EbuHB8I+R+FHYuEteACCw7c1kFKD2
         5vYg==
X-Forwarded-Encrypted: i=1; AJvYcCVdfhcyirLMk6rrM+fE31XaYzfyvboGlt4YkGkjePqbkqsz1avBhd+zYpKgzF2YopefvIJYgyu6@vger.kernel.org, AJvYcCWQO//L+BacUNrSLzKMqzZII8rG4MAdJOrMb1TEgfaH8diTk9DEglIIHlfEVB8j2ZD/s/4=@vger.kernel.org, AJvYcCWTR1n9T6c4hmRTLPVIHy6FGzpM5vGKxUQV/LEsWxbe/5MB35U0Wow1q9liRwI10fL3a+/k11D+cITzlbNd@vger.kernel.org
X-Gm-Message-State: AOJu0YzFXM90SX8KuRIpuoC5RCW/GR4YIpM5F7ZqBJM+Jk43/gvt58S5
	XYnyvqAdpusqgNrnoNnpKXT461E0my9pS8yzfId1YAsGLWTQkyRU
X-Google-Smtp-Source: AGHT+IH1pKSJeJiEgVfFv68wIuaVvU4tg1Wi7Zm+7o/jsbQlnUC62A5cd4JrjlSUdWHwg83V4X9CWQ==
X-Received: by 2002:a17:903:947:b0:20b:5ea2:e04 with SMTP id d9443c01a7336-20b5ea21240mr139933675ad.27.1727762444940;
        Mon, 30 Sep 2024 23:00:44 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e0b6c4bc46sm9055950a91.7.2024.09.30.23.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 23:00:44 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: edumazet@google.com,
	atenart@kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	dongml2@chinatelecom.cn,
	bigeasy@linutronix.de,
	toke@redhat.com,
	idosch@nvidia.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next 0/7] net: ip: add drop reasons to input route
Date: Tue,  1 Oct 2024 13:59:58 +0800
Message-Id: <20241001060005.418231-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In this series, we mainly add some skb drop reasons to the input path of
ip routing.

The function ip_route_input_noref() is used commonly, and its return value
is used by the caller sometimes. So, it's not easy to make it return skb
drop reasons. Instead, we add the pointer of the drop reason to the
function arguments of it. And we do the same things to
ip_route_input_rcu() and ip_route_input_slow().

The errno from fib_validate_source() is -EINVAL or -EXDEV, and -EXDEV is
used in ip_rcv_finish_core() to increase the LINUX_MIB_IPRPFILTER. For
this case, we can check it by
"drop_reason == SKB_DROP_REASON_IP_RPFILTER" instead. Therefore, we can
make fib_validate_source() return -reason. Meanwhile, we make
ip_route_input_mc() and ip_mc_validate_source() return drop reason.

Following new skb drop reasons are added:

  SKB_DROP_REASON_IP_LOCAL_SOURCE
  SKB_DROP_REASON_IP_INVALID_SOURCE
  SKB_DROP_REASON_IP_INVALID_DEST
  SKB_DROP_REASON_IP_LOCALNET

Menglong Dong (7):
  net: ip: add drop reason to ip_route_input_noref()
  net: ip: add drop reason to ip_route_input_rcu()
  net: ip: add drop reason to ip_route_input_slow()
  net: ip: make fib_validate_source() return drop reason
  net: ip: make ip_route_input_mc() return drop reason
  net: ip: make ip_mc_validate_source() return drop reason
  net: ip: fix typo in the doc of SKB_DROP_REASON_IP_INNOROUTES

 drivers/net/ipvlan/ipvlan_l3s.c |   2 +-
 include/net/dropreason-core.h   |  21 +++++-
 include/net/route.h             |  12 ++--
 net/core/lwt_bpf.c              |   2 +-
 net/ipv4/arp.c                  |   2 +-
 net/ipv4/fib_frontend.c         |  19 ++++--
 net/ipv4/ip_fragment.c          |   2 +-
 net/ipv4/ip_input.c             |  11 ++--
 net/ipv4/route.c                | 111 +++++++++++++++++++++-----------
 net/ipv4/xfrm4_input.c          |   2 +-
 net/ipv4/xfrm4_protocol.c       |   2 +-
 11 files changed, 122 insertions(+), 64 deletions(-)

-- 
2.39.5


