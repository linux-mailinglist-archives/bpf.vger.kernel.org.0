Return-Path: <bpf+bounces-40140-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4FB97D8C6
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 19:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12AFA1C21F27
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 17:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CC317F389;
	Fri, 20 Sep 2024 17:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="QBFjJ2+1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D04733997
	for <bpf@vger.kernel.org>; Fri, 20 Sep 2024 17:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726851760; cv=none; b=E/xbcsu8G24RUfmEFS4B0UHcUkrwRcXtskqtydak4dJl1DOrtBSXFAbUURKImTIzgNU1+X/5OaDFHLXKPoaFIcZxTf0YzQJ8srwHZRgpVR/zN3YafvJ1APCrktcZNriN5VE74HeztTXXOAVo7eT9cpeuyPQrGAEY+GZOv0q+k4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726851760; c=relaxed/simple;
	bh=/U+zlX7dEyDKa3Dp8FfdEffyRjrenUfcuc193gOz0Sw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=T6EGRlVGNzr0eeC7EZAhp99DMM2+XSWI02qbzgDWfYdPJvfAyZR+JJtTY07O0bPnSjJH6BIAOZD8F9UjW3VsHTDYgAA4UuTz3nEx+oNQ9AZJkE0ZevSVOiMaj//BFR1m0OdfFKwU9JcYhMInvEnqyenvNgzvjtYyuq/w7TfADQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=QBFjJ2+1; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4280ca0791bso20794685e9.1
        for <bpf@vger.kernel.org>; Fri, 20 Sep 2024 10:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1726851758; x=1727456558; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DKtDmkSCvbirKNZj+ZHOSlmw+X9DVZG2Qafk2mDwowU=;
        b=QBFjJ2+1PDLHAg4WYBWcWFImPULgGT2b0CwOtJX3l9mHXVOP0SYsD3mcQkO+HSyZzo
         AtDPFCsAL4v2Mc5XlilbhtfVIHXgHjICdAw88PYlsqJmw2dTFcZTUjQ4V7wp+uq16dnJ
         KiNHw7BDHprQovtbsESgAIehwOqqqUWNBezskCvoxu/UviKwyTRWCBwFaIWO6k25S1ah
         XxyE7mrz+2m05GySdFTq6QiW8qzPYDZ4hlvv9RZBadqE/BAu5P9sOpB6bImi/6+onNW/
         ZNMpLBi4LiBbDduEE1WIHk965ihdc4o+cABqk+A1FU07AbJ4RcZ8SCBtm2JcSDLnMJ3Q
         mdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726851758; x=1727456558;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DKtDmkSCvbirKNZj+ZHOSlmw+X9DVZG2Qafk2mDwowU=;
        b=KXTdFjoK1HowXXDdFKL0oNlTkgjF22WcF3I1DQH1VJFZAaOVW5jgsV2fQdRmRhWk8g
         xItiPtZRMXgDtie/Vf8aRuMitFsSx6/XVM3kvLm4Ry/5Krmjj3FxlGIc95rE6+6Iny0h
         fgh9s5ZaHuj/TyewboNP5gy0jjpF+4uAjtHw5ITPOnvro6Muqt+SIFsvLGgbZo0+5KlS
         sR7z5xP9CqU3r21NylNvaGj9Tgwf7HmjHjIpQQioI3rBmk7VLTQRxLtjs+k8K21dKIDm
         D2hMH0ZkWNLw56/Hc4sVBRgVzIxijKhcd/HbYWBxyU0M04taYaCLF0xLPL2wHYUaBWTK
         m6UA==
X-Forwarded-Encrypted: i=1; AJvYcCVulDdI3WBNARhb4UHM2wR8eCgHjGshNcDdAt4n9srRPi3vETbzqoVRdQNmrxTpjQwhwu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKtbvRdQtYdZWJ8afBcN3U+F8vAdA2BURORBs+MYFj+RZZJ7qT
	bU7kZL3aRcZoW+HkxNdHz71B8FPzc7Y6pCWJ4mnV+LzAZCWgXwF8iwfgMZOLWUM=
X-Google-Smtp-Source: AGHT+IG7/IJmD1g4tZEVBuCZqUTIh3Wpxf4EhfjyDchF/uzZhzX7jOhudwq+E63B0EI69ZBRsT7ggw==
X-Received: by 2002:a05:600c:1e11:b0:42c:b750:1a1e with SMTP id 5b1f17b1804b1-42e7c01047dmr23546045e9.0.1726851757569;
        Fri, 20 Sep 2024 10:02:37 -0700 (PDT)
Received: from [127.0.1.1] ([2a09:bac5:50ca:432::6b:72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e75450ac2sm54237785e9.24.2024.09.20.10.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 10:02:37 -0700 (PDT)
From: Tiago Lam <tiagolam@cloudflare.com>
Subject: [RFC PATCH v2 0/3] Allow sk_lookup UDP return traffic to egress
 when setting src port/address.
Date: Fri, 20 Sep 2024 18:02:11 +0100
Message-Id: <20240920-reverse-sk-lookup-v2-0-916a48c47d56@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJSq7WYC/22NMQ+CMBSE/wp5s8+0hUhwkpAYR2PcDAOUV2mol
 LRCNIT/bsXV7e5y990MnpwmD/toBkeT9tr2wYhNBLKt+juhboIHwUTCMpZhKJHzhL5DY203Dqj
 SWsU7kYlaJhB2gyOlXyvzBpdj8c3O+bU4QRlUq/3Tuvd6OPG182Pz+A974siQUsGpYixuEnmQx
 o6NMpWjrbQPKJdl+QAejOllxQAAAA==
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

This patch sets out to fix both of this issues by:
1. Allowing users to set the src address/port egress traffic should be
   sent from, when calling sendmsg();
2. Validating that this egress traffic comes from a socket that matches
   an ingress socket in sk_lookup.
   - If it does, traffic is allowed to proceed;
   - Otherwise it falls back to the regular egress path.

The downsides to this is that this runs on the egress hot path, although
this work tries to minimise its impact by only performing the reverse
socket lookup when necessary (i.e. only when the src address/port are
modified). Further performance measurements are to be taken, but we're
reaching out early for feedback to see what the technical concerns are
and if we can address them.

[1] https://blog.cloudflare.com/how-we-built-spectrum/

Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Tiago Lam <tiagolam@cloudflare.com>
---
Changes in v2:
- Amended commit messages and cover letter to make the intent and
  implementation clearer (Willem de Bruijn);
- Fixed socket comparison by not using socket cookies and comparing them
  directly (Eric Dumazet);
- Fixed misspellings and checkpatch.pl warnings on line lengths (Simon
  Horman);
- Fixed usage of start_server_addr() and gcc compilation (Philo Lu);
- Link to v1: https://lore.kernel.org/r/20240913-reverse-sk-lookup-v1-0-e721ea003d4c@cloudflare.com

---
Tiago Lam (3):
      ipv4: Support setting src port in sendmsg().
      ipv6: Support setting src port in sendmsg().
      bpf: Add sk_lookup test to use ORIGDSTADDR cmsg.

 include/net/ip.h                                   |  1 +
 net/ipv4/ip_sockglue.c                             | 11 +++
 net/ipv4/udp.c                                     | 35 +++++++++-
 net/ipv6/datagram.c                                | 79 ++++++++++++++++++++++
 net/ipv6/udp.c                                     |  8 ++-
 tools/testing/selftests/bpf/prog_tests/sk_lookup.c | 67 ++++++++++++------
 6 files changed, 176 insertions(+), 25 deletions(-)
---
base-commit: 6562a89739bbefddb5495c09aaab67c1c3756f36
change-id: 20240909-reverse-sk-lookup-f7bf36292bc4

Best regards,
-- 
Tiago Lam <tiagolam@cloudflare.com>


