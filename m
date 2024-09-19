Return-Path: <bpf+bounces-40086-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF8997C73E
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 11:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FF171C26734
	for <lists+bpf@lfdr.de>; Thu, 19 Sep 2024 09:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA6719D8B5;
	Thu, 19 Sep 2024 09:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcqknQbZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665FE19D086;
	Thu, 19 Sep 2024 09:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726738981; cv=none; b=Ie4Zm8Hr3BkpBrPSJBq0dvYX60bz6RgxImBEPW07EieucSeIEDqpbEKiE/nnuy7Qn9rQxu90b4OoaSwwgp2E2Kihe5LdwzMfiTuU5Jj4oMp4TSoMbeogj4eguwiVY6B5FgN1lLEdXWZtm4cf3MBmg+RL7nO7WzMEmKGtGpXCUbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726738981; c=relaxed/simple;
	bh=celzY8OV4GMmy/RwTNyebjUESHinD4fwKxA7pGOfvoU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qd6SgVy4gbTlOBhS5Q45LBlxeVJmm1UQzVEoGfC3uzlgsUK5AIVpoe5Dqst7U11KD4wYKPUvot9qtZ+nA6oVMc9FeZR4VmQO1A4amXa7dSQ8TyOEUX9F3cCCu7iu0a6Xsz55lWUKmtgiAqMcfQpzuKJ7qXqXkg4FNsRo/Q3lK58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcqknQbZ; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-7d50e865b7aso499580a12.0;
        Thu, 19 Sep 2024 02:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726738963; x=1727343763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KYn484j8l4FCD86Dl+kKDGHdgRbar+9TjSd1oUL2FFI=;
        b=CcqknQbZJzeGD0S2dDUJFD0044+Ut9MwErZ06m0awwAIDxY2xM+m9hg6q+Ig+r8oRq
         2bxbBkFa95qriOlCR4xGNSM9D+CVBFwTI+4z8b1OQ4bWjQtX7JACquePrBb/DH4Rio/h
         m/YGkv0L+ukgpSvjjGevCOYyVZWWjdwJD57MB54nh6O/dJqiog2PIVU1wnxwAeY2qVJ8
         TdoRNJJPmmsC9vzvwgJICkoF0xLdrH6ZlBEO/PqMDACEaN5AWF0UDn+ob8atDhs3usFc
         YxI3Nzx3LUnoanJgn1f7qRHU1WBpgJjb5v7q76M4R8bVPNJjGB8pDH3JjpxMi71kmtiv
         U6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726738963; x=1727343763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KYn484j8l4FCD86Dl+kKDGHdgRbar+9TjSd1oUL2FFI=;
        b=C7M1p8p15fcox8urxPTl2/v6QaINqlYgtwDUjcs5IX9P2odZ08vHjFF6toK5qU6pdO
         oFWGS76Z23hqURWOAh3CLszByXR9r1JSGE1/XVj/uvq93fuIp54/l3P1TRD6cxMQcnw1
         IOTTJyakkBM8KW2Rk+Id1x6ACKPtnuP0DqkF1qco5NTB6qgyKBOEKtlUbhDOnyNJ3LUu
         N22lg1to34ueO4OiXorDL5sUpAxHOFEWHuRzliBGYBMI6o0xHAIqwal+K4LDz+MZgv3a
         joo2k6+ZkANR4sbNjmWSRkn2fBtQSQSo1ebC8Kc06QPIDcSuAMlCkdPw4I0/yFcTMF03
         8Qtw==
X-Forwarded-Encrypted: i=1; AJvYcCWKKe7cmywuhMYdYmxDLiUJ07zi0hxRrIYWhhvmg1UDtTWfZtIpms+uKqE6IV3VRbLh4us=@vger.kernel.org, AJvYcCWob41+jFDV9DUUqTpMAGiz1OgkR/bwmNrpgsx9XrtWfohxo3Sod/BysYZkpWM7/Ri3QZcWvwihkvVjVkkH@vger.kernel.org, AJvYcCWzdKv4F09P8hIzY8S68/FMtVotytIzGFpknZdSVFvzYzudVoZ81Dbcr5HCuIB+5DhtANpiEIDk@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2n22WI8cL4YHcFnQ6tFqbtwvnDIomn40JdrOac8AgsAIKWVpb
	B2zDJ3QG2xXIZuPKCDKUmAfGO8aU6MuBlcUA86vV5qbx8c1to9Cb
X-Google-Smtp-Source: AGHT+IGb5ZU6hI8x7OU7TGOVzz/mHBUwDrNmLwrlL6zCEh9MoU1jeUCZWXuDESCdHl3IaNx99lX7vQ==
X-Received: by 2002:a05:6a21:a24c:b0:1d2:eb9d:9973 with SMTP id adf61e73a8af0-1d2eb9d9d4dmr10157500637.39.1726738963469;
        Thu, 19 Sep 2024 02:42:43 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944ab4b36sm7927086b3a.47.2024.09.19.02.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 02:42:43 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: edumazet@google.com
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
Subject: [RFC PATCH net-next 0/7] net: ip: add drop reasons to input route
Date: Thu, 19 Sep 2024 17:41:40 +0800
Message-Id: <20240919094147.328737-1-dongml2@chinatelecom.cn>
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


