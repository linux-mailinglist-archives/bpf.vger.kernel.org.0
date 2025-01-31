Return-Path: <bpf+bounces-50242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9804A24420
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 21:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 727313A3446
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 20:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8971F3D35;
	Fri, 31 Jan 2025 20:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Bgz2hovL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D2D145A18
	for <bpf@vger.kernel.org>; Fri, 31 Jan 2025 20:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738355585; cv=none; b=iNWdgPcip9EvtR2K/pPqSohxDsOb1wK9RscTyQUumExGRvM8ec56oyLKMafqb+VjaMseg/mBlCrim+FE11HWMNfqsOHp3BPFIT0Ns9RyoZxnjELdRLkRy75CQrxWQ5LNAmZZKr8mOy81EvyZGeJDjG1tnkkWZ1sdUWmFX+6IilI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738355585; c=relaxed/simple;
	bh=6HQIl+pQmZwYtAJMEPZiyMRa7ufVFSc7Z2hzx46ZPK4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZFJukeGlfkIA5TisFvKscsjhp7xv5WY965HHc4sc9UQig5sD34lTg9NWXP9RSEuBrcuDPyJhAcRIrxfX3Dk37GHaxksO6Wz+qddrvoPS6lfqzguLIoCKzEsi5g1MqPzmAhe+nCJvYVsO/waaKvn0mf8R4Ii4wz3p3wl6UnM8Slc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Bgz2hovL; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-46fee2b9c7aso7885671cf.2
        for <bpf@vger.kernel.org>; Fri, 31 Jan 2025 12:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1738355582; x=1738960382; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fi0MwM3w9TjVgRiY2TxYN38tQCD7guButB+IM55g75Q=;
        b=Bgz2hovLDsnhXXp7pEP4JKGIfjB4kfkDEvQ8q9PSiZxW6vRH2t5qWwsmW6oe/ljW2C
         TQZZNU5m6b38b18cHjUiUCumnvyEoyx7LPTuTewHP7KsI/5f8tESb1/RxmcltpZQ2AIO
         SxpDz2IkTpxAc/uli5fn374n0egIVVeKfd7J/ReYSjuPdKLWVrVnS18HwteQQN+Nx4M4
         FoI0+4CTajR6x7XzCv3eXg3UqP7rTvv+kN6plmWYqt2Y+4ytPcG5ch5lD2WxoLhkf2KQ
         P4Bdelz34dFgS78V2kagfLGrbL+FmM47ATC13JWNnTU6DyfMFBERL1kLmIcEJaPByT/6
         Tqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738355582; x=1738960382;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fi0MwM3w9TjVgRiY2TxYN38tQCD7guButB+IM55g75Q=;
        b=b2BYuM+G1DKvDrRQxKjHAJVu7mqaB4LWPLEON0MqhA/p6GJt9n/Fq9UlgIbwnEcKur
         oucRT95KTFdQ3YXVqQ52ofQQQUh140+s1IjGXxqfOXzUSv0F5mjO2WuemyYEeUYUol/s
         fNQ7xqBaqXJXvEj7GJvOO8hk+wWwb5tuWIUVpEFoxqJmlpkoI6N20gisuYLtVqtvdsFH
         IjpqjMya03bsjZ5MJizrMVr90QrbDMdFmliwBF+crqjpARYBNf/ZSlW1QDZy5NIXiUxE
         Vhjv1seokb0RyfAVi2BiKJLQxnJeMDOewCKz1x9i6kwBKKbUFGgDkVqXBE9aitr0gtwX
         RcPw==
X-Gm-Message-State: AOJu0YyQjmhfENZGyp8h5IEme6IP50IVlIkP+v+k80zbHABCEagHOJnW
	c1dUBB2PvM+XCGL/8tdmVOgAqT7s3eI1Ye5eZswyvsDTo1gThg3j22VdX1QXZBoGo1tbXL+WlAY
	3
X-Gm-Gg: ASbGncuBf1jgCBqQaNSd4ojnzs8nPEbWvqZopMhyRNDjVioJ/sNk9wPU8piDPRevWKo
	0c8hs4hCdmX4HZRXPAU1qMHdApGjrZRPK5pkzinpAcw1/7Sk5vF4V6e2Ys9yisXicoerYWtutEW
	ovPCeY6wt68wZCGjbbkqcFKRsZXr4HY7jUGmH1w6Zybbhhpvz4kOZ/55/iZZkJS8A8YXO+mVleM
	DghWaPGSIdvz8nu36Yzxe3LFM0DxqMQmc3vTEGPutHPgqp22sEPwDdd/kMxNalNmmHMLWavqLZp
	a0w=
X-Google-Smtp-Source: AGHT+IH2AcPhVqV8pp+FxoFEYodsDi6QjWt/uboIY/FehAjbO09w9dZEPJaKKEzNqikq40cLsv311A==
X-Received: by 2002:ac8:570e:0:b0:467:8651:40a2 with SMTP id d75a77b69052e-46fd0a6483emr197728091cf.13.1738355580870;
        Fri, 31 Jan 2025 12:33:00 -0800 (PST)
Received: from debian.debian ([2a09:bac5:79dd:25a5::3c0:2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46fdf0a72d4sm21072031cf.13.2025.01.31.12.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 12:32:59 -0800 (PST)
Date: Fri, 31 Jan 2025 12:32:57 -0800
From: Yan Zhai <yan@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com
Subject: Unchecked sock pointer causes panic in RAW_TP
Message-ID: <Z50zebTRzI962e6X@debian.debian>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

We encountered a panic when tracing kfree_skb with RAW_TP. The problematic
argument was introduced in commit ba8de796baf4 ("net: introduce
sk_skb_reason_drop function"). It turns out that the verifier still accepted
the program despite it didn't test sk == NULL. And this caused kernel panic. I
attached a small reproducer and panic trace at the end. It's stably
reproducible when packets are dropped without a receiver (e.g. run iperf2 UDP
test toward localhost), in both 6.12.11 release and a recent bpf-next master
snapshot (I was using commit c03320a6768c).

As a contrast, for another tracepoint like tcp_send_reset, if sk is not checked
before dereferencing, the verifier will complain and reject the program as
expected. So this feels like some annotation is missing? Appreciate if someone
could help me figure out.

thanks
Yan

----- Reproducer and panic trace ----
#include "vmlinux.h"
#include <bpf/bpf_helpers.h>
#include <bpf/bpf_tracing.h>

char _license[] SEC("license") = "GPL";

SEC("tp_btf/tcp_send_reset")
int BPF_PROG(tcp_send_reset, struct sock *sk, struct sk_buff *skb)
{
        if (skb && sk && sk->__sk_common.skc_state == TCP_LISTEN) {
                bpf_printk("sk: %d, %d\n", sk, sk->__sk_common.skc_family);
        }
        return 0;
}

SEC("tp_btf/kfree_skb")
int BPF_PROG(drop, struct sk_buff *skb, void *location,
             enum skb_drop_reason reason, struct sock *sk)
{
        bpf_printk("sk: %d, %d\n", sk, sk->__sk_common.skc_family);
        return 0;
}

Byte code:
int drop(unsigned long long * ctx):
; int BPF_PROG(drop, struct sk_buff *skb, void *location,
   0: (79) r3 = *(u64 *)(r1 +24)
; bpf_printk("sk: %d, %d\n", sk, sk->__sk_common.skc_family);
   1: (69) r4 = *(u16 *)(r3 +16)
   2: (18) r1 = map[id:7][0]+12
   4: (b7) r2 = 12
   5: (85) call bpf_trace_printk#-63104
; int BPF_PROG(drop, struct sk_buff *skb, void *location,
   6: (b7) r0 = 0
   7: (95) exit

Trace:
[   29.982295][  T348] BUG: kernel NULL pointer
dereference, address: 0000000000000010
[   29.983487][  T348] #PF: supervisor read access in kernel mode
[   29.984326][  T348] #PF: error_code(0x0000) - not-present page
[   29.985138][  T348] PGD 0 P4D 0
[   29.985654][  T348] Oops: Oops: 0000 [#1] PREEMPT SMP
[   29.986351][  T348] CPU: 6 UID: 0 PID: 348 Comm: sshd Not tainted
6.12.11 #206
[   29.987309][  T348] Hardware name: QEMU Standard PC (i440FX + PIIX,
1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   29.988678][  T348] RIP:
0010:bpf_prog_5e21a6db8fcff1aa_drop+0x10/0x2d
[   29.989553][  T348] Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc
cc cc cc cc cc cc cc cc cc cc cc cc 0f 1f 44 00 00 0f 1f 00 55 48 89
e5 48 8b 57 18 <48> 0f b7 4a 10 48 bf 0c 4f e2 c1 ad 90 ff ff be 0c 00
00 00 e8 0f
[   29.992008][  T348] RSP: 0018:ffffa86640b53da8 EFLAGS: 00010202
[   29.992811][  T348] RAX: 0000000000000001 RBX: ffffa866402d1000
RCX: 0000000000000002
[   29.993852][  T348] RDX: 0000000000000000 RSI: ffffa866402d1048
RDI: ffffa86640b53dc8
[   29.994929][  T348] RBP: ffffa86640b53da8 R08: 0000000000000000
R09: 9c908cd09b9c8c91
[   29.995991][  T348] R10: ffff90adc056b540 R11: 0000000000000002
R12: 0000000000000000
[   29.997043][  T348] R13: ffffa86640b53e88 R14: 0000000000000800
R15: fffffffffffffffe
[   29.998097][  T348] FS:  00007f2a27c2b480(0000)
GS:ffff90b0efd00000(0000) knlGS:0000000000000000
[   29.999279][  T348] CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
[   30.000161][  T348] CR2: 0000000000000010 CR3: 0000000100e69004
CR4: 00000000001726f0
[   30.001217][  T348] Call Trace:
[   30.001724][  T348]  <TASK>
[   30.002145][  T348]  ? __die+0x1f/0x60
[   30.002694][  T348]  ? page_fault_oops+0x148/0x420
[   30.003386][  T348]  ? search_bpf_extables+0x5b/0x70
[   30.004082][  T348]  ? fixup_exception+0x27/0x2c0
[   30.004748][  T348]  ? exc_page_fault+0x75/0x170
[   30.005416][  T348]  ? asm_exc_page_fault+0x22/0x30
[   30.006104][  T348]  ? bpf_prog_5e21a6db8fcff1aa_drop+0x10/0x2d
[   30.006923][  T348]  bpf_trace_run4+0x68/0xd0
[   30.007566][  T348]  ? unix_stream_connect+0x1f4/0x6f0
[   30.008274][  T348]  sk_skb_reason_drop+0x90/0x120
[   30.008960][  T348]  unix_stream_connect+0x1f4/0x6f0
[   30.009662][  T348]  __sys_connect+0x7f/0xb0
[   30.010267][  T348]  __x64_sys_connect+0x14/0x20
[   30.010927][  T348]  do_syscall_64+0x47/0xc30
[   30.011567][  T348]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[   30.012371][  T348] RIP: 0033:0x7f2a27f296a0
[   30.012998][  T348] Code: 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f
1f 84 00 00 00 00 00 0f 1f 44 00 00 80 3d 41 ff 0c 00 00 74 17 b8 2a
00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83
ec 18 89 54
[   30.015491][  T348] RSP: 002b:00007ffe29274f58 EFLAGS: 00000202
ORIG_RAX: 000000000000002a




