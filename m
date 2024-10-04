Return-Path: <bpf+bounces-40906-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF45998FBE6
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 03:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BA151F20F8F
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 01:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF4510A24;
	Fri,  4 Oct 2024 01:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BWVnt93N"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C6A1870;
	Fri,  4 Oct 2024 01:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728004463; cv=none; b=aRFf+MetZ78fody3tiaSI4AcYxf4QW2qz23gpQv5dZ3/YlpSiil93nEfXelTj3aF7rWgoeoCfEl13U3nQHTya6QImlvWYvGaWFbxKDf0qKi8y+mR4QvWaArfleOgBYnyd4xYno14ssgeFdwtPawQVEyRNfiFOjtWAemeDyUwiLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728004463; c=relaxed/simple;
	bh=m7Oas5tvrHfupQwzAwy/sYVnzVi8o8tPjsW++fKGZL0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=E7/DI2JpyldVY7Qx+vDyaKKixej33AgNajnBmcpYEIwHx9ETp1GqZVvwKkOZ4e21uZHZ6WgtzXRb48L/ri/ywYgufVpXMAXDWUBNnDOv4UgsujtU3xaexMJgGzUjDWdMOzevCV9pPuh9jjVNKMxSBwhHODv/HIWkz1KRpetpeeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BWVnt93N; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <eb6684d0-ffd9-4bdc-9196-33f690c25824@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728004458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=X2Ow6n9yG7Zu5N96hb8gmL3PUFGycoog6CmimF35atI=;
	b=BWVnt93N3EPPLiO1TlE05Wy0X2IhGKF7RMvy6pif6m+Ioo6lW/EisEsNtDJWVhV6+7gR8H
	1hpdM5bIAdBOpcelh6LrXjO7OiSaiPvtLaO6ZdNq/YV6ixg4zfH9PMSHFwKN3slH7P+N2l
	FLbNSSyEM9WMLuvLmbDFam5Y1PfCJJ8=
Date: Thu, 3 Oct 2024 18:14:09 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Subject: [Question]: A non NULL req->sk in tcp_rtx_synack. Not a fastopen
 connection.
To: Network Development <netdev@vger.kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, bpf <bpf@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi,

We are seeing a use-after-free from a bpf prog attached to 
trace_tcp_retransmit_synack. The program passes the req->sk to the 
bpf_sk_storage_get_tracing kernel helper which does check for null before using it.

fastopen is not used.

We got a kfence report on use-after-free (pasted at the end). It is running with 
an older 6.4 kernel and we hardly hit this in production.

 From the upstream code, del_timer_sync() should have been done by 
inet_csk_reqsk_queue_drop() before "req->sk = child;" is assigned in 
inet_csk_reqsk_queue_add(). My understanding is the req->rsk_timer should have 
been stopped before the "req->sk = child;" assignment.

or there are cases that req->sk is not NULL in the reqsk_timer_handler()?

BUG: KFENCE: use-after-free read in bpf_sk_storage_get_tracing+0x2e/0x1b0

Use-after-free read at 0x00000000a891fb3a (in kfence-#1):
bpf_sk_storage_get_tracing+0x2e/0x1b0
bpf_prog_5ea3e95db6da0438_tcp_retransmit_synack+0x1d20/0x1dda
bpf_trace_run2+0x4c/0xc0
tcp_rtx_synack+0xf9/0x100
reqsk_timer_handler+0xda/0x3d0
run_timer_softirq+0x292/0x8a0
irq_exit_rcu+0xf5/0x320
sysvec_apic_timer_interrupt+0x6d/0x80
asm_sysvec_apic_timer_interrupt+0x16/0x20
intel_idle_irq+0x5a/0xa0
cpuidle_enter_state+0x94/0x273
cpu_startup_entry+0x15e/0x260
start_secondary+0x8a/0x90
secondary_startup_64_no_verify+0xfa/0xfb

kfence-#1: 0x00000000a72cc7b6-0x00000000d97616d9, size=2376, cache=TCPv6

allocated by task 0 on cpu 9 at 260507.901592s:
sk_prot_alloc+0x35/0x140
sk_clone_lock+0x1f/0x3f0
inet_csk_clone_lock+0x15/0x160
tcp_create_openreq_child+0x1f/0x410
tcp_v6_syn_recv_sock+0x1da/0x700
tcp_check_req+0x1fb/0x510
tcp_v6_rcv+0x98b/0x1420
ipv6_list_rcv+0x2258/0x26e0
napi_complete_done+0x5b1/0x2990
mlx5e_napi_poll+0x2ae/0x8d0
net_rx_action+0x13e/0x590
irq_exit_rcu+0xf5/0x320
common_interrupt+0x80/0x90
asm_common_interrupt+0x22/0x40
cpuidle_enter_state+0xfb/0x273
cpu_startup_entry+0x15e/0x260
start_secondary+0x8a/0x90
secondary_startup_64_no_verify+0xfa/0xfb

freed by task 0 on cpu 9 at 260507.927527s:
rcu_core_si+0x4ff/0xf10
irq_exit_rcu+0xf5/0x320
sysvec_apic_timer_interrupt+0x6d/0x80
asm_sysvec_apic_timer_interrupt+0x16/0x20
cpuidle_enter_state+0xfb/0x273
cpu_startup_entry+0x15e/0x260
start_secondary+0x8a/0x90
secondary_startup_64_no_verify+0xfa/0xfb

Thanks,
Martin

