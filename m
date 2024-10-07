Return-Path: <bpf+bounces-41087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4AC99263E
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 09:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBE831F229A4
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 07:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F71A185B56;
	Mon,  7 Oct 2024 07:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fyl/STzV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D4413E40F;
	Mon,  7 Oct 2024 07:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728287248; cv=none; b=iY6Xg3lq5a1ABZsQPmITpj994MuvOcrZzyqxCncG1BPVh+TzBeWz0KQ2pX1JankwtxYhFzN5Njciin1P6WeHy06UzatL7OcX7lov4TEvazk/duMYA3cWoXiI0/oGm6g4s4T+/ZzfLFD9Zh8T3TBzZxOjumJnUe0K8r4xTmgJNq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728287248; c=relaxed/simple;
	bh=l6LxMLWnUydVshX8ePxJZ1eAe93s5zGl9qgG7EZNIN4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ASh6iXQ/aZVDHIhMSqmhpGesHR8m+S4s1uYSswMTm8cyKd5YoeRGUjExVMjpRviDwUF7LOB+a9CQD9JdHsm2ZSCqV8xBuwgLwKvYUEqrmh/Vn9CXt0xlS6+kDLejL9mhyRXJY8djJBWIXOblEXNMrROCVUAAGch8WAOwqX5QgVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fyl/STzV; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-20b7463dd89so43439435ad.2;
        Mon, 07 Oct 2024 00:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728287245; x=1728892045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b2n6h9GSVtfbk6aFENoMm6c8J7saJajMVYq/4Q3177I=;
        b=Fyl/STzViKmPBzfehGcRBb4POB+g9Tm3UanGSLU/2oNyfMc9HJN/uX4ToeHN7nh7CN
         9DeHZndUn9hgQpJDmrXLpsD/HHMqqdN14eiQyKGJc5BFbgtOUNFhjBlXYvAMYyuAvkGQ
         6J/591RgDFd/CMS0x3OvjJIl5AyJzMK9Xkh/rHf2ZtCOSOvJmVM+R1GzmUCVTh9BRZcF
         vo0rBWZfhwD7HRuGwnExaet1k5FVr2kvOONWFP0RWK/KGTebYghJo72oUjhbbHt0PcK4
         2azGzrdmrGHnDcy9pJ1Nz3Z2rj9KBUTaNAaLCyw8G7rS69+8Sj+xfIs9UHiy0wKWbRJw
         8zUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728287245; x=1728892045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b2n6h9GSVtfbk6aFENoMm6c8J7saJajMVYq/4Q3177I=;
        b=raFbtA5QEvxhSiKrnLT4YLp3nsMY7jkpn2v0U3ToQ+pxavdcEKxuwnxq6u9afnjrY9
         +HxJj2Zg/peoDwNbgdRwMK2xWW0Nv8oRvwgxdtKO86ZxWe6E0df/3L8uNLjesXpESG8q
         sMmWwzGA2c2ZDLSUsoOLS+U71koR7J2IZe8ONkRQBrLkiZ9tLDu8rQUGExMM1v72Cddp
         jIZd60b9uFssabtUJsfeow4OsEy1Eq6k6I9j5j8uq5tRw3GrabREHFN2EmgmVoDEfE16
         ijQfJO7wLw2A7KJo3ZsMNBerubf0tVxJAAjx+l554r/ZLtsngX9jnkq46XG2OAXver3p
         4Y5w==
X-Forwarded-Encrypted: i=1; AJvYcCUOzw/AvHOxcxi6z47vvKvAT0KzQKM8I4Bb12KhL2nBMU8AIelP6S2WHFwPX3wNF5gdSN3Q+T2BLI6lsv9U@vger.kernel.org, AJvYcCW30NIdm6o5+WoqFSfRE1wW3equLwWE/KuG0Y1dDEJnIuaPY4joMNrGhzeqxivvB//XcKmaQl2N@vger.kernel.org, AJvYcCX5wwKUEY14xFmB63D6XP0foeWRAniuQ8UzUFYb9qFX+Zji5dll5Iz+ryeTJQtGNJjXZjs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3y+7OUJs6aVNWa2TzVJ/KxJyx5SGwUHDkZZzgIK0Xst/d3HmV
	kRXQJiLi5tIxQYI0obyVtTcMjEpLPspvaVkBk7kaxjSuIbrBRtNV
X-Google-Smtp-Source: AGHT+IGywFV7XyB9atwKKhhwERyHHj+BHxvDMPAsEVHcGvtH9zHJXy2sXCPBs3q3JJv4qkd64HLkzQ==
X-Received: by 2002:a17:903:1ca:b0:20b:9078:7092 with SMTP id d9443c01a7336-20bff178f13mr138379545ad.50.1728287244763;
        Mon, 07 Oct 2024 00:47:24 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c1393a15fsm34375395ad.121.2024.10.07.00.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 00:47:24 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: edumazet@google.com,
	kuba@kernel.org
Cc: davem@davemloft.net,
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
Subject: [PATCH net-next v2 0/7] net: ip: add drop reasons to input route
Date: Mon,  7 Oct 2024 15:46:55 +0800
Message-Id: <20241007074702.249543-1-dongml2@chinatelecom.cn>
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

The errno from fib_validate_source() is -EINVAL or -EXDEV, and -EXDEV is
used in ip_rcv_finish_core() to increase the LINUX_MIB_IPRPFILTER. For
this case, we can check it by
"drop_reason == SKB_DROP_REASON_IP_RPFILTER" instead. Therefore, we can
make fib_validate_source() return -reason.

Meanwhile, we make the following functions return drop reasons too:

  ip_route_input_mc()
  ip_mc_validate_source()
  ip_route_input_slow()
  ip_route_input_rcu()
  ip_route_input_noref()
  ip_route_input()

And following new skb drop reasons are added:

  SKB_DROP_REASON_IP_LOCAL_SOURCE
  SKB_DROP_REASON_IP_INVALID_SOURCE
  SKB_DROP_REASON_IP_LOCALNET
  SKB_DROP_REASON_IP_INVALID_DEST

Changes since v1:
- make ip_route_input_noref/ip_route_input_rcu/ip_route_input_slow return
  drop reasons, instead of passing a local variable to their function
  arguments.

Menglong Dong (7):
  net: ip: make fib_validate_source() return drop reason
  net: ip: make ip_route_input_mc() return drop reason
  net: ip: make ip_mc_validate_source() return drop reason
  net: ip: make ip_route_input_slow() return drop reasons
  net: ip: make ip_route_input_rcu() return drop reasons
  net: ip: make ip_route_input_noref() return drop reasons
  net: ip: make ip_route_input() return drop reasons

 include/net/dropreason-core.h   |  19 +++++
 include/net/route.h             |  27 ++++---
 net/bridge/br_netfilter_hooks.c |  11 +--
 net/core/lwt_bpf.c              |   1 +
 net/ipv4/fib_frontend.c         |  19 +++--
 net/ipv4/icmp.c                 |   1 +
 net/ipv4/ip_fragment.c          |  12 +--
 net/ipv4/ip_input.c             |  11 ++-
 net/ipv4/route.c                | 131 +++++++++++++++++++-------------
 9 files changed, 145 insertions(+), 87 deletions(-)

-- 
2.39.5


