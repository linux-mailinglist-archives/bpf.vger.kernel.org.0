Return-Path: <bpf+bounces-45905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E709DF262
	for <lists+bpf@lfdr.de>; Sat, 30 Nov 2024 18:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F05B1B21548
	for <lists+bpf@lfdr.de>; Sat, 30 Nov 2024 17:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DED21A7261;
	Sat, 30 Nov 2024 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBsojZUS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CCD43AA1
	for <bpf@vger.kernel.org>; Sat, 30 Nov 2024 17:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732989030; cv=none; b=RcIeM8PEb/QOIU5lIAH/f5maoUuhEK7+2oCGfo9u/iq461YMaogmR88Q2EWIFV7kekhJs6pr1FiRwoix25HV7fcctC9xdgeAcCC7dDOfq8ORL/m9fAQ1IsexAkl115jJMcmYXAwVZhItL3vDU+xrjrcnAMbT7JtT6SUgkjqxf2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732989030; c=relaxed/simple;
	bh=EQ9TZKt6FwbZf2WuonS0Lh/do9XhBXhf1sX+D/K/33Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DgaN/HQpQqgsDAYLmHX0hCFOWw+vf5g9BDzI1QdzgdcY1dfFWGso4yOou1RLEmCc82uCGDuL9BtifVFGVaDO0G0yoc5fdola9DvW1golcJFBiT4+p1I3KwHOvnYW6B2gAV1Ce71ixqEY8VxC1ZHyfEtcS+w2vC2zzHSAKO1ByjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBsojZUS; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-aa54adcb894so364033866b.0
        for <bpf@vger.kernel.org>; Sat, 30 Nov 2024 09:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732989025; x=1733593825; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3FMWYSOnZt30o+m8GN41SnaPJZ4ZgchB6VAT5N7zQMU=;
        b=eBsojZUS0KqW9dM3vRtqK2nAdS6Isgo3Oem61oGuzgYU5bBoF6L7hbsf/M1/vaODOS
         qQ+CgaSerfKn3ZZsvWuKeaqyRWJP0pa19ljBzoB4Qd6OdWjrbk4wRGCG7JNK3iZBhDS5
         RAU366B6FJvGJ0FCdppOx3oM1Wmau/99ssdrmZo+dmS2ruYxLUA5qdOEgh3QNMUpqJRP
         jAXZBkqCv8qaf4rR07YBeU2wE4L7NJ0nFcLHFNawpKrfsaT4kna+Vbx3uICHZON/FQ80
         6iXzSNOJ8Qs7jNXeRfD1Qwu1xyXdfiieEt7ND9wILPgFhg4qYI25H1m6CsO2dOKbiBpx
         SBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732989025; x=1733593825;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3FMWYSOnZt30o+m8GN41SnaPJZ4ZgchB6VAT5N7zQMU=;
        b=jWXivtWSEJ3ObIu8l4OEqM/xJzRI6Y63VC1Dy5IAucMJ3lCMsX5VyPIpdFrqt8Ut5r
         HJwBkDZGZQYoZt2uycwMckUfcCxkvpGZeSd5YFLwsheIvYngXG+bCAlCIWuJBhnFYqh+
         3OXKSKrwJcEDLdxrljAZwpXetVfVQMbskA2CFD1vUlmRkO150dBrrNc9qZQt5OkjbaJg
         rP2JQLe++V7nx4liD3vrV8yicI7UIaQgs5iFAmy37f6WUeksepK883YKQBYIlQGa4boR
         ad/pzmBonDu1ny4H0r/Czx6Aubj1UphWQmS43mDSNZfk79FN1YOIaChSppAdxEoNsmN8
         bNPQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3rfEzgpOF7vv6MmzXqsWzMN/x/hc6TybVgabnh0WfhSMRTp0e3V3DrQkFETE0MegWuss=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV3CNuX4YUSaiSUQ9o6nWFrCyeRqQlYLfGofCaSUQXJvR3YujN
	3mHPc5huH7wm6+Re74M15+ii3p+wa+XKWLo9QfQYVVfb9Au0A1UtAtZqf5ydtdrjdZkf98AC0vu
	uM/ErVB4vBoF3kMoQpe1OZq6XvrQ=
X-Gm-Gg: ASbGncvl5QKJbNzuqUIvJbmCoMJdQTWAiKehg9jIgKU29xBySgTktQrqLDXjKxiQ9//
	OzrLYegsY8mF3LSfV/2vYEpCYK6l0ysAozfWGvmv7ExUIU+LP0r6J6WPpQbPD5Rfr
X-Google-Smtp-Source: AGHT+IGf7tbezrlNV5UoXee8Mdkg0KSKlM3UaHPb6oC17dJzVKzwqFGhEjq9qNsd4mWbb7GHFjIwrAtNa7Mb+MTsNUY=
X-Received: by 2002:a17:906:bfea:b0:a9a:7f84:940b with SMTP id
 a640c23a62f3a-aa580ee2f7dmr1243400566b.10.1732989024732; Sat, 30 Nov 2024
 09:50:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <51338.1732985814@localhost>
In-Reply-To: <51338.1732985814@localhost>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 30 Nov 2024 18:49:48 +0100
Message-ID: <CAP01T762EPrCFd2XPFqPk5y6n99C4g7nQUsXwMkdEDjUq03_qg@mail.gmail.com>
Subject: Re: ebpf can allow sub-word load results to be used as 64-bit pointers
To: rtm@csail.mit.edu
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 30 Nov 2024 at 18:10, <rtm@csail.mit.edu> wrote:
>
> When I modify the bpf_cubic_init() function from
>
>   https://github.com/aroodgar/bpf-tcp-congestion-control-algorithm
>
> to read:
>
> SEC("struct_ops/bpf_cubic_init")
> void BPF_PROG(bpf_cubic_init, struct sock *sk)
> {
>   asm volatile("r2 = *(u16*)(r1 + 0)");     // verifier should demand u64
>   asm volatile("*(u32 *)(r2 +1504) = 0");   // 1280 in some configs
> }
>
> the verifier accepts it, but the second line crashes when it runs during
> a TCP connect() because the "*(u16*)" in the load from context yields
> only the low bits of the pointer.

Thanks for the bug report.

It is a missing check on "size" of the access in btf_ctx_access in
kernel/bpf/btf.c.
It is probably not seen in practice as desugaring of such arguments is
done by libbpf macros etc.
This won't just be limited to struct_ops, but many other program types
(tracing, etc.) which use this code.

I have prepared a fix here: https://github.com/kkdwivedi/linux/commits/sops

The relevant diff is:

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index e7a59e6462a9..f590cb792cf3 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6458,6 +6458,11 @@ bool btf_ctx_access(int off, int size, enum
bpf_access_type type,
                        tname, off);
                return false;
        }
+       if (size != sizeof(u64)) {
+               bpf_log(log, "func '%s' size %d is not multiple of 8\n",
+                       tname, size);
+               return false;
+       }
        arg = get_ctx_arg_idx(btf, t, off);
        args = (const struct btf_param *)(t + 1);
        /* if (t == NULL) Fall back to default BPF prog with


This is not the right 100% fix though, as fields may be u32 scalars
etc. so size needs to be checked against the member's type.
Right now this will reject some valid programs. But you get the idea.
The size of access needs to be checked.
Will test out in our CI before posting to the list.

May I ask how you happened to stumble upon this?

>
> Linux ubuntu66 6.12.0-11677-g2ba9f676d0a2 #10 SMP Sat Nov 30 11:28:09 EST 2024 x86_64 x86_64 x86_64 GNU/Linux
>
> BUG: unable to handle page fault for address: 0000000000001020
> #PF: supervisor write access in kernel mode
> #PF: error_code(0x0002) - not-present page
> PGD 0 P4D 0
> Oops: Oops: 0002 [#1] SMP PTI
> CPU: 6 UID: 0 PID: 1546 Comm: a.out Not tainted 6.12.0-11677-g2ba9f676d0a2 #10
> Hardware name: FreeBSD BHYVE/BHYVE, BIOS 14.0 10/17/2021
> RIP: 0010:bpf_prog_0e20ff5294b59096_bpf_cubic_init+0x19/0x25
> Code: 00 cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc f3 0f 1e fa 0f 1f 44 00
>  00 0f 1f 00 55 48 89 e5 f3 0f 1e fa 48 0f b7 77 00 <c7> 86 e0 05 00 00 00 00 00
>  00 c9 c3 cc cc cc cc cc cc cc cc cc cc
> RSP: 0018:ffffc9000076bc58 EFLAGS: 00010202
> RAX: 0000000000000001 RBX: 0000000000000001 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000a40 RDI: ffffc9000076bc88
> RBP: ffffc9000076bc58 R08: ffffc9000076bc40 R09: ffffc9000076bc20
> R10: ffffffff842f3200 R11: ffffffff827659c0 R12: 0000000000000004
> R13: ffff888105493098 R14: 0000000000000000 R15: 00000000ffffff8d
> FS:  00007fa5348d1740(0000) GS:ffff88842fb80000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000001020 CR3: 000000010bbfa003 CR4: 00000000003706f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  ? __die+0x1e/0x60
>  ? page_fault_oops+0x157/0x450
>  ? eth_header+0x25/0xb0
>  ? exc_page_fault+0x66/0x140
>  ? asm_exc_page_fault+0x26/0x30
>  ? bpf_prog_0e20ff5294b59096_bpf_cubic_init+0x19/0x25
>  ? __bpf_prog_enter+0x14/0x60
>  bpf__tcp_congestion_ops_init+0x47/0xa3
>  tcp_init_congestion_control+0x2a/0xe0
>  tcp_init_transfer+0x2b2/0x2d0
>  tcp_finish_connect+0x82/0x130
>  tcp_rcv_state_process+0x352/0xf20
>  tcp_v4_do_rcv+0xca/0x240
>  __release_sock+0xc6/0xd0
>  release_sock+0x2a/0x90
>  __inet_stream_connect+0x208/0x3c0
>  ? __pfx_woken_wake_function+0x10/0x10
>  inet_stream_connect+0x35/0x50
>  __sys_connect+0x93/0xb0
>  ? ksys_write+0x67/0xe0
>  __x64_sys_connect+0x13/0x20
>  ? ksys_write+0x67/0xe0
>  __x64_sys_connect+0x13/0x20
>  do_syscall_64+0x3f/0xd0
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> Robert Morris
> rtm@mit.edu
>
>

