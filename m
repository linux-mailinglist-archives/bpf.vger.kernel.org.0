Return-Path: <bpf+bounces-39812-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC75977C5F
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 11:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 655FD1F22395
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 09:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D761D7E3F;
	Fri, 13 Sep 2024 09:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="XnvrSFCo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CB41D79BB
	for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 09:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726220368; cv=none; b=Zs0F4DC6O7YrWp+gUVtVMR/kFQj5RWPD6K7uY0ajRRxROVFSEJBefURbAW2QcjaN+fy/Lo+NdvV+jmMnckx8LGzkLCnPTjCUEpXGtGzCuncinQpV8wAgcik3EolsiUlOTeuECD8RMIwILrKIR8v9/bNBY9SmD+pq3h2JdGhFJDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726220368; c=relaxed/simple;
	bh=uTdW1iqIiDn+wO7I7YsjYEBx4QnkQuSJd6vyMZ1ORnk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=r37/jYEeSVBzC6opRHA9NgfpGrkze2Cf8jsNOhixdj0DE6WHTTm2e0ksumCSm6r13u2uISAePtSePagBvyfzO26vdkLsgQWuNaz4Z4oB2MdT4bd+OikrduoIQAtXIQAv+iamPWp4kB99yJWn96f8R7OM6BV6Aq+3eMendaUGctk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=XnvrSFCo; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42ca6ba750eso11989825e9.0
        for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 02:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1726220364; x=1726825164; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2ktgZ+uVe2s2bCAGH+md56ZRqREXdZWZhIaXzEz5gDY=;
        b=XnvrSFCo30qOngQ6SGBH04k9DqQ++O2DQhZ+KBSKyK2Dx8ZceuSg/dm0y2fcqsaVVk
         kD75SWT4C88ID3SAfmWH64JeJxewDMpQ60JEBb1JFRwf0brdlXfP63LcTyLy3H3lzZ4J
         OqAqjFkOGuEYU/tLnu1fLRfBSVX2VJrsbR78MuXaeNMRr9COfuH4G51Iqzj4tK1iqouJ
         iJzPGLPNxepv+aYsDHhhhflUFATPlTC2QAUazIf/ufLKHM5mj4TYGd4YcjQI2iA9Gfln
         t2SFYWcePoqpQ6h/IXyElvsgWjEFYd8XLRDuhk++HzcatAm4fOCtUeJAYNv/Qq96FyM3
         RVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726220364; x=1726825164;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ktgZ+uVe2s2bCAGH+md56ZRqREXdZWZhIaXzEz5gDY=;
        b=vSYd8i5TfCEUabvEApMUsWwMxy6gA8xtEYzJJJT/W0TvpduDX9x/bdj8Mn3fbV1O57
         Omo5FSNMPqJZxU5k8u2a/zoYzEcRGGj4evmBSW+jYoz+b38Qp8UsPnfpZV3Q1CCTRRh6
         ct/zXlSvzdM6ZSy5X4X2YR5zIu40rJtPeHsapX6hRYXs2BqZyz22qlq9QEmSTgF9oqtR
         gyQ6PLHZz+KgeAGIMbS/udPpgm0zL8c1oebcth8ef42xSi4SLOASU2WFrmkwPCvcpoZr
         +jhS35/cN3zmPHrT+0PvGtuBoMAL6BX3K96D6PU4MFvh62/KDg5zbl/nsKSWAQRH2Gev
         dsEw==
X-Forwarded-Encrypted: i=1; AJvYcCWmG3FkonyUY1NT5UAXjF5Y4CWnc21Cp9zAJ/+j6UPr8OAjm0QYh5TDnMtTLcgwsJ+ZPtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFaUII35kn7yRvIWQGbhtnqQSOQBdn9WJyJkKMCu7vX9JNRAd4
	nQDh+j5rAzatsC2hrta22IlDg/WHxXT2h/PN+LlMU8O1bNvKKN1HxRS2udQZOSE=
X-Google-Smtp-Source: AGHT+IHZfC/aJw81IO6e74EYkh4LyhabH3RNdDQSvhMnC+NzUSU87E3GIxcTKVjC2zaJeUs6LW+ONA==
X-Received: by 2002:a05:600c:4f8d:b0:42c:b8e5:34d5 with SMTP id 5b1f17b1804b1-42cdcbb8675mr35315495e9.15.1726220363650;
        Fri, 13 Sep 2024 02:39:23 -0700 (PDT)
Received: from [127.0.1.1] ([2a09:bac5:3802:d2::15:37a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895665548sm16474484f8f.34.2024.09.13.02.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 02:39:23 -0700 (PDT)
From: Tiago Lam <tiagolam@cloudflare.com>
Subject: [RFC PATCH 0/3] Allow sk_lookup UDP return traffic to egress.
Date: Fri, 13 Sep 2024 10:39:18 +0100
Message-Id: <20240913-reverse-sk-lookup-v1-0-e721ea003d4c@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEYI5GYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDSwNLXaCi1KLiVN3ibN2c/Pzs0gLdNPOkNGMzI0ujpGQTJaC+gqLUtMw
 KsJnRSkFuziCxAMcQZw+l2NpaAIagDfdxAAAA
To: "David S. Miller" <davem@davemloft.net>, 
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Jakub Sitnicki <jakub@cloudflare.com>, Tiago Lam <tiagolam@cloudflare.com>, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.14.1

Currently, sk_lookup allows an ebpf program to run on the ingress socket
lookup path, and accept traffic not only on a range of addresses, but
also on a range of ports. At Cloudflare we use sk_lookup for two main
cases:
1. Sharing a single port between multiple services - i.e. two services
   (or more) use disjoint IP ranges but share the same port;
2. Receiving traffic on all ports - i.e. a service which accepts traffic
   on specific IP ranges but any port [1].

However, one main challenge we face while using sk_lookup for these use
cases is how to source return UDP traffic:
- On point 1. above, sometimes this range of addresses are not local
  (i.e. there's no local routes for these in the server), which means we
  need IP_TRANSPARENT set to be able to egress traffic from addresses
  we've received traffic on (or simply IP_FREEBIND in the case of IPv6);
- And on point 2. above, allowing traffic to a range of ports means a
  service could get traffic on multiple ports, but currently there's no
  way to set the source UDP port egress traffic should be sourced from -
  it's possible to receive the original destination port using the
  IP_ORIGDSTADDR ancilliary message in recvmsg, but not set it in
  sendmsg.

Both of these limitations can be worked around, but in a sub-optimal
way. Using IP_TRANSPARENT, for instance, requires special privileges.
And while one could use UDP connected sockets to send return traffic,
creating a connected socket for each different address a UDP traffic is
received on does have performance implications.

Given sk_lookup allows services to accept traffic on a range of
addresses or ports, it seems sensible to also allow return traffic to
proceed through as well, without needing extra configurations / set ups.

This patch set allows to do exactly this by performing a reverse socket
lookup on the egress path - where it looks to see if the egress socket
matches a socket in the attached sk_lookup ebpf program for the traffic
that's being sent. If it does, traffic is allowed to proceed.

The downsides to this is that this runs on the egress hot path, although
this work tries to minimise its impact by only performing the reverse
socket lookup when necessary. Further performance measurements are to be
taken, but we're reaching out early for feedback to see what the
technical concerns are and if we can address them.

[1] https://blog.cloudflare.com/how-we-built-spectrum/

Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Tiago Lam <tiagolam@cloudflare.com>
---
Tiago Lam (3):
      ipv4: Run a reverse sk_lookup on sendmsg.
      ipv6: Run a reverse sk_lookup on sendmsg.
      bpf: Add sk_lookup test to use ORIGDSTADDR cmsg.

 include/net/ip.h                                   |  1 +
 net/ipv4/ip_sockglue.c                             | 11 ++++
 net/ipv4/udp.c                                     | 33 +++++++++-
 net/ipv6/datagram.c                                | 76 ++++++++++++++++++++++
 net/ipv6/udp.c                                     |  8 ++-
 tools/testing/selftests/bpf/prog_tests/sk_lookup.c | 70 +++++++++++++-------
 6 files changed, 174 insertions(+), 25 deletions(-)
---
base-commit: da3ea35007d0af457a0afc87e84fddaebc4e0b63
change-id: 20240909-reverse-sk-lookup-f7bf36292bc4

Best regards,
-- 
Tiago Lam <tiagolam@cloudflare.com>


