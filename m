Return-Path: <bpf+bounces-45904-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 675DE9DF228
	for <lists+bpf@lfdr.de>; Sat, 30 Nov 2024 18:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7104B21592
	for <lists+bpf@lfdr.de>; Sat, 30 Nov 2024 17:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C161A2C19;
	Sat, 30 Nov 2024 17:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.b="RB+zEYfZ"
X-Original-To: bpf@vger.kernel.org
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2B98468
	for <bpf@vger.kernel.org>; Sat, 30 Nov 2024 17:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.30.2.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732986607; cv=none; b=WtN88mQw+Bvjv/CIah7ybjvI6B/jtv/AriuGAORHze/Fequ3N0kLOYX450aWrGesuicCSu3T4sar17Gj6uWCJBsnr4E0KAGfohJFb/jGTSUdXJUq+4GZJykhy72/ClzcOepDxeL7267IUS1yrjHBc4KiqZTOkQTk4Ndp65j3CiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732986607; c=relaxed/simple;
	bh=SGTfb7+KIB0s1VPDOlKlTpz8ZJkaIBv/etr9NZCZZOE=;
	h=To:cc:From:Subject:Date:Message-ID; b=X0xS3i0mtawSCAFLyToWA44ujkbv2kZavYcLWRC/nXcQzI7xPj41W9x38LhuMItAXFt193GMSQx/24bT1OMMcojXrfCX8CsVzZ3XjbjEO0rRCGJ8hiG39WVRzRbSClvkzeHQj/ZbMx7WPSJ6/FcRXcEtjp3kIIU7SJ9uKEOC4YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu; spf=pass smtp.mailfrom=csail.mit.edu; dkim=pass (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.b=RB+zEYfZ; arc=none smtp.client-ip=128.30.2.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=outgoing.csail.mit.edu; s=test20231205; h=Message-ID:Date:Subject:Reply-To:
	From:cc:To:Sender:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oMmsesdarysUAUJI8R3uFGUbrqhSw6ohLBKyFVyo22g=; t=1732986605; x=1733850605; 
	b=RB+zEYfZG0Kc48Jmmstscz0jkRtsQqULSpJiEH9Z786jNy8t2fMT2BM9PwfykJhddlyqe0it4bg
	8Wy5UqOS3Is5Ug+VPNRzqYXnI78FacIRBSXBy0YH7uHH1SBXGhCDk71OsQ7crUZi5d79IFitk+xQ6
	iSHYqzc/bcnsvlmfsT3eC/Rl7oH5MCIY5NehQIjZG75V0DJxr4QKuRJZyYlfDQh/f0+Fx65SIrS9t
	IlxNwxgD4gyytdIXBb4LW1CmDx0oQlLheB1j5PmExbqVw70h7wZHNfXPBXv1bpOaWcyVUeCtqUZ2t
	+FTmAU0NED7cykeUF3FqBLVn9kfCnja/Hg4w==;
Received: from c-71-235-5-26.hsd1.ma.comcast.net ([71.235.5.26] helo=crash.local)
	by outgoing2021.csail.mit.edu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <rtm@csail.mit.edu>)
	id 1tHQm6-005WoA-TL;
	Sat, 30 Nov 2024 11:56:54 -0500
Received: from localhost (localhost [127.0.0.1])
	by crash.local (Postfix) with ESMTP id 661791773565;
	Sat, 30 Nov 2024 11:56:54 -0500 (EST)
To: Alexei Starovoitov <ast@kernel.org>,
    Daniel Borkmann <daniel@iogearbox.net>,
    Martin KaFai Lau <martin.lau@linux.dev>,
    John Fastabend <john.fastabend@gmail.com>
cc: bpf@vger.kernel.org
From: rtm@csail.mit.edu
Reply-To: rtm@csail.mit.edu
Subject: ebpf can allow sub-word load results to be used as 64-bit pointers
Date: Sat, 30 Nov 2024 11:56:54 -0500
Message-ID: <51338.1732985814@localhost>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

When I modify the bpf_cubic_init() function from

  https://github.com/aroodgar/bpf-tcp-congestion-control-algorithm

to read:

SEC("struct_ops/bpf_cubic_init")
void BPF_PROG(bpf_cubic_init, struct sock *sk) 
{
  asm volatile("r2 = *(u16*)(r1 + 0)");     // verifier should demand u64
  asm volatile("*(u32 *)(r2 +1504) = 0");   // 1280 in some configs
}

the verifier accepts it, but the second line crashes when it runs during
a TCP connect() because the "*(u16*)" in the load from context yields
only the low bits of the pointer.

Linux ubuntu66 6.12.0-11677-g2ba9f676d0a2 #10 SMP Sat Nov 30 11:28:09 EST 2024 x86_64 x86_64 x86_64 GNU/Linux

BUG: unable to handle page fault for address: 0000000000001020
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 0 P4D 0
Oops: Oops: 0002 [#1] SMP PTI
CPU: 6 UID: 0 PID: 1546 Comm: a.out Not tainted 6.12.0-11677-g2ba9f676d0a2 #10
Hardware name: FreeBSD BHYVE/BHYVE, BIOS 14.0 10/17/2021
RIP: 0010:bpf_prog_0e20ff5294b59096_bpf_cubic_init+0x19/0x25
Code: 00 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc f3 0f 1e fa 0f 1f 44 00
 00 0f 1f 00 55 48 89 e5 f3 0f 1e fa 48 0f b7 77 00 <c7> 86 e0 05 00 00 00 00 00
 00 c9 c3 cc cc cc cc cc cc cc cc cc cc
RSP: 0018:ffffc9000076bc58 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000a40 RDI: ffffc9000076bc88
RBP: ffffc9000076bc58 R08: ffffc9000076bc40 R09: ffffc9000076bc20
R10: ffffffff842f3200 R11: ffffffff827659c0 R12: 0000000000000004
R13: ffff888105493098 R14: 0000000000000000 R15: 00000000ffffff8d
FS:  00007fa5348d1740(0000) GS:ffff88842fb80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000001020 CR3: 000000010bbfa003 CR4: 00000000003706f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ? __die+0x1e/0x60
 ? page_fault_oops+0x157/0x450
 ? eth_header+0x25/0xb0
 ? exc_page_fault+0x66/0x140
 ? asm_exc_page_fault+0x26/0x30
 ? bpf_prog_0e20ff5294b59096_bpf_cubic_init+0x19/0x25
 ? __bpf_prog_enter+0x14/0x60
 bpf__tcp_congestion_ops_init+0x47/0xa3
 tcp_init_congestion_control+0x2a/0xe0
 tcp_init_transfer+0x2b2/0x2d0
 tcp_finish_connect+0x82/0x130
 tcp_rcv_state_process+0x352/0xf20
 tcp_v4_do_rcv+0xca/0x240
 __release_sock+0xc6/0xd0
 release_sock+0x2a/0x90
 __inet_stream_connect+0x208/0x3c0
 ? __pfx_woken_wake_function+0x10/0x10
 inet_stream_connect+0x35/0x50
 __sys_connect+0x93/0xb0
 ? ksys_write+0x67/0xe0
 __x64_sys_connect+0x13/0x20
 ? ksys_write+0x67/0xe0
 __x64_sys_connect+0x13/0x20
 do_syscall_64+0x3f/0xd0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Robert Morris
rtm@mit.edu


