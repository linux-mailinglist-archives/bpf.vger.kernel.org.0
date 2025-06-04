Return-Path: <bpf+bounces-59642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4663ACE1E6
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 18:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04E26166FDD
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 16:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A811CB518;
	Wed,  4 Jun 2025 16:04:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dediextern.your-server.de (dediextern.your-server.de [85.10.215.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD0018E1F;
	Wed,  4 Jun 2025 16:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.215.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749053046; cv=none; b=s1wAFkeK2R2FZyIgeA13q75UY43xGOZB2OJG3Th5z9PYX5xVc8PqWjCRUJbWgBkVh0MpXNc014ESlYyLZprjSeN0tXublBF3AstzbRrqYVAdXs8ColRI6LImhe0WQxvvfCbsEJMHogsPmlwHIQju0SMr3CH0CU8GAgtf4mqhxjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749053046; c=relaxed/simple;
	bh=Vbss+hkHN6igBHYC0QfKfg2uSLdRpUecKqmMSm0PGo8=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=ZbAFKeOVvve15XtFfmS4tYFQ51oZUmvfig+WPCwM3qpFKryuB/NyyrCpw8nF1byjyMWhCNi1NRb9jDWOPcKhvHbUWMQz7yiM64kgVg8MXxYpZMc40XhatDQnOlD1KzgaZK3o8ivSdEat8kxmdITyIdfYCXCtmxNevxSQmGTrhdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de; spf=pass smtp.mailfrom=hetzner-cloud.de; arc=none smtp.client-ip=85.10.215.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hetzner-cloud.de
Received: from sslproxy08.your-server.de ([78.47.166.52])
	by dediextern.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1uMq7W-000Q0d-RO; Wed, 04 Jun 2025 17:33:39 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy08.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1uMq7W-000E76-2k;
	Wed, 04 Jun 2025 17:33:39 +0200
Message-ID: <9da42688-bfaa-4364-8797-e9271f3bdaef@hetzner-cloud.de>
Date: Wed, 4 Jun 2025 17:33:36 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Autocrypt: addr=marcus.wichelmann@hetzner-cloud.de; keydata=
 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
 wySmewx3h/yfMh0aFxHhvLPxrO2IEQ==
To: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, linux-kernel@vger.kernel.org
Subject: [BUG] veth: TX drops with NAPI enabled and crash in combination with
 qdisc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: marcus.wichelmann@hetzner-cloud.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27658/Wed Jun  4 10:36:16 2025)

Hi,

while experimenting with XDP_REDIRECT from a veth-pair to another interface, I
noticed that the veth-pair looses lots of packets when multiple TCP streams go
through it, resulting in stalling TCP connections and noticeable instabilities.

This doesn't seem to be an issue with just XDP but rather occurs whenever the
NAPI mode of the veth driver is active.
I managed to reproduce the same behavior just by bringing the veth-pair into
NAPI mode (see commit d3256efd8e8b ("veth: allow enabling NAPI even without
XDP")) and running multiple TCP streams through it using a network namespace.

Here is how I reproduced it:

  ip netns add lb
  ip link add dev to-lb type veth peer name in-lb netns lb

  # Enable NAPI
  ethtool -K to-lb gro on
  ethtool -K to-lb tso off
  ip netns exec lb ethtool -K in-lb gro on
  ip netns exec lb ethtool -K in-lb tso off

  ip link set dev to-lb up
  ip -netns lb link set dev in-lb up

Then run a HTTP server inside the "lb" namespace that serves a large file:

  fallocate -l 10G testfiles/10GB.bin
  caddy file-server --root testfiles/

Download this file from within the root namespace multiple times in parallel:

  curl http://[fe80::...%to-lb]/10GB.bin -o /dev/null

In my tests, I ran four parallel curls at the same time and after just a few
seconds, three of them stalled while the other one "won" over the full bandwidth
and completed the download.

This is probably a result of the veth's ptr_ring running full, causing many
packet drops on TX, and the TCP congestion control reacting to that.

In this context, I also took notice of Jesper's patch which describes a very
similar issue and should help to resolve this:
  commit dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to
  reduce TX drops")

But when repeating the above test with latest mainline, which includes this
patch, and enabling qdisc via
  tc qdisc add dev in-lb root sfq perturb 10
the Kernel crashed just after starting the second TCP stream (see output below).

So I have two questions:
- Is my understanding of the described issue correct and is Jesper's patch
  sufficient to solve this?
- Is my qdisc configuration to make use of this patch correct and the kernel
  crash is likely a bug?

------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in net/sched/sch_sfq.c:203:12
index 65535 is out of range for type 'sfq_head [128]'
CPU: 1 UID: 0 PID: 24 Comm: ksoftirqd/1 Not tainted 6.15.0+ #1 PREEMPT(voluntary) 
Hardware name: GIGABYTE MP32-AR1-SW-HZ-001/MP32-AR1-00, BIOS F31n (SCP: 2.10.20220810) 09/30/2022
Call trace:
 show_stack+0x24/0x50 (C)
 dump_stack_lvl+0x80/0x140
 dump_stack+0x1c/0x38
 __ubsan_handle_out_of_bounds+0xd0/0x128
 sfq_dequeue+0x37c/0x3e0 [sch_sfq]
 __qdisc_run+0x90/0x760
 net_tx_action+0x1b8/0x3b0
 handle_softirqs+0x13c/0x418
 run_ksoftirqd+0x9c/0xe8
 smpboot_thread_fn+0x1c0/0x2e0
 kthread+0x150/0x230
 ret_from_fork+0x10/0x20
---[ end trace ]---
------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in net/sched/sch_sfq.c:208:8
index 65535 is out of range for type 'sfq_head [128]'
CPU: 1 UID: 0 PID: 24 Comm: ksoftirqd/1 Not tainted 6.15.0+ #1 PREEMPT(voluntary) 
Hardware name: GIGABYTE MP32-AR1-SW-HZ-001/MP32-AR1-00, BIOS F31n (SCP: 2.10.20220810) 09/30/2022
Call trace:
 show_stack+0x24/0x50 (C)
 dump_stack_lvl+0x80/0x140
 dump_stack+0x1c/0x38
 __ubsan_handle_out_of_bounds+0xd0/0x128
 sfq_dequeue+0x394/0x3e0 [sch_sfq]
 __qdisc_run+0x90/0x760
 net_tx_action+0x1b8/0x3b0
 handle_softirqs+0x13c/0x418
 run_ksoftirqd+0x9c/0xe8
 smpboot_thread_fn+0x1c0/0x2e0
 kthread+0x150/0x230
 ret_from_fork+0x10/0x20
---[ end trace ]---
Unable to handle kernel NULL pointer dereference at virtual address 0000000000000005
Mem abort info:
  ESR = 0x0000000096000004
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
user pgtable: 4k pages, 48-bit VAs, pgdp=000008002ad67000
[0000000000000005] pgd=0000000000000000, p4d=0000000000000000
Internal error: Oops: 0000000096000004 [#1]  SMP

CPU: Ampere(R) Altra(R) Processor Q80-30 CPU @ 3.0GHz

# tc qdisc
qdisc sfq 8001: dev in-lb root refcnt 81 limit 127p quantum 1514b depth 127 divisor 1024 perturb 10sec 

Thanks,
Marcus

