Return-Path: <bpf+bounces-50261-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E75A246D9
	for <lists+bpf@lfdr.de>; Sat,  1 Feb 2025 03:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E5EF3A7CDA
	for <lists+bpf@lfdr.de>; Sat,  1 Feb 2025 02:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2C33597C;
	Sat,  1 Feb 2025 02:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="dLCFwTsV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009EA17BA5
	for <bpf@vger.kernel.org>; Sat,  1 Feb 2025 02:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738377631; cv=none; b=eRzLtNJbmiLLI1e7r20+RFUUF+BaISw3lhxqQrEiaKNRd5PdVJ5NUC5CdtGONKWt44xDCI8BtQSMciNegSZNWTYf+que9WI5ZxmzNw0BfXPSpHQrCLqwcGuKv8giYZOJEgDYctVv9gdTeqgbaiVBdHRO/DJwHPEsbN6QFGkWqEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738377631; c=relaxed/simple;
	bh=/dv4+GttZhpTJ2CzJBjOv18JfM7+BBIHZUbLyLrRIT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q6tUVAwTKeTm92vef5roT/PCrO049Xf2ZUfL2YUWefr1zZlrWmwD+sziBMJc/d0hv2QcOsHyqky7L7mOFegTccDJftr0NVB3sq5vKYfhIdb+8u4XNh8qG2QBGIrECx+Gecr/RU/oOGWPaKo1QByPfnALPZ/T2Op9Z2HqbrrHqO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=dLCFwTsV; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d3e6f6cf69so4397781a12.1
        for <bpf@vger.kernel.org>; Fri, 31 Jan 2025 18:40:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1738377628; x=1738982428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/xIvqIdTuqvz4rm72M/KSoYWBJYwgsIKoY9Nxn3PhQ=;
        b=dLCFwTsVj/zuMaSsy7FLKdoD2XRzrME/Ao3fO5x1gv04xhjlnv/QOq1CmdLSGQOO9n
         OIupBnf8xIuSbi72g0DcxAAZBN1RQX6XJqS0DaGPAUnQONDZEe3T1Ym84YMOWEwlqLoq
         huqF+2Ru6MDyhm/6PkwGcrCp5jxlM0hqWNRcIvxPg6oYk2J7COHHh9DpJAz4wBcDfxFh
         ASjpn4QUygVbTO4fRspxGoQ9fT/Q4ezZMBodfGtdzxIBnufS28UqOdram1/hyctTBYvS
         koKnhBtyMJzaO3h3VBE0V74C3Uf2yzJkOwE/I1gKL9SzfDgTyG+tR71mAaxuUBdBa16W
         isDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738377628; x=1738982428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v/xIvqIdTuqvz4rm72M/KSoYWBJYwgsIKoY9Nxn3PhQ=;
        b=KMgxvSie6rJakpXFcnVr+h6U2KHZb8PzNiGgyhEujUWTy1GneCWEE+wMPbBd/1PjZw
         VqJOh4n1CRdKM0DXUvlOTl9KPiqEjJ4dbV/FBGvedNT1eOHxHO4zAcQvwHo8xQI46qPo
         83gqaEB/n88HSu8jEhYBYBkESOuD3Pz1ED6mSBjOJ73HvIYAi7+DAncqQmZEJHfTKUaX
         KFj2LY9HWplg5lHBMcCBC3cVIWOShL/Xp8rWcjjyULdi3AtOTwYVUmRkIzRUJTK7bJYd
         QHwGv95WV/GYCxtaBD1fMEIwBkr81RzEUI/oIj13BcJcTBcyZ61UesygArn+oEgLcl4+
         b0Wg==
X-Forwarded-Encrypted: i=1; AJvYcCVRw1ywF0IkRugNcXUMvhAaELEZ3clhWSZPll/nmRrDOIBQCWxL8e7tccYakHH3U4tKEjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXwqYEGfZU9sd46e7VLiLe02jTO1j01PhVjTKmEeKzNiJqohnQ
	bDILVRueEPngj7Sj43hSnV8+dy17TLUI2eQ1hAGFDD2FS+A4mbnYnLU0MhJZAtbVymimWflgjWu
	OlUC0LJcQZmgfLATOFq2H2PNHOfV4sIfZqeSHbw==
X-Gm-Gg: ASbGncttwJxWWTbNlbsZX0wsoWVedfF+zKcB19lelOpcQ0bqHIjCnbFP3b8LdMiDDJX
	0DDpFKF88haS2XdB7SvqviQ6nRGEGgfOrHBjot93YZ6XCgUqqoCcqrkUSsGSia6ugO+CVmb6fq4
	u8QL4lccfCAK4=
X-Google-Smtp-Source: AGHT+IGr8uNaU7itf4dHCwXq2nEicfs4LGfuNmhhIrv3VmF79zyoKkGiQ/q09wpkj9RKFRQeu6fJQDpMmPsMlSFIoCA=
X-Received: by 2002:a05:6402:5109:b0:5dc:5a34:1296 with SMTP id
 4fb4d7f45d1cf-5dc5efc5e1amr14143039a12.16.1738377628186; Fri, 31 Jan 2025
 18:40:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250201001425.42377-1-kuniyu@amazon.com>
In-Reply-To: <20250201001425.42377-1-kuniyu@amazon.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Fri, 31 Jan 2025 20:40:17 -0600
X-Gm-Features: AWEUYZkKO86hqMW2MrpI2NM4jEciVTpBFnzseSry4_TTpNksyTZLZX_dbXQZNkI
Message-ID: <CAO3-PbpS=YrWnFCr1K8vdD50pyBamHysRQfcZRBn1Q=icwCW8w@mail.gmail.com>
Subject: Re: [PATCH v1 bpf] net: Annotate rx_sk with __nullable for trace_kfree_skb.
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 6:14=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> Yan Zhai reported a BPF prog could trigger a null-ptr-deref [0]
> in trace_kfree_skb if the prog does not check if rx_sk is NULL.
>
> Commit c53795d48ee8 ("net: add rx_sk to trace_kfree_skb") added
> rx_sk to trace_kfree_skb, but rx_sk is optional and could be NULL.
>
> Let's add __nullable suffix to rx_sk to let the BPF verifier
> validate such a prog and prevent the issue.
>
> Now we fail to load such a prog:
>
>   libbpf: prog 'drop': -- BEGIN PROG LOAD LOG --
>   0: R1=3Dctx() R10=3Dfp0
>   ; int BPF_PROG(drop, struct sk_buff *skb, void *location, @ kfree_skb_s=
k_null.bpf.c:21
>   0: (79) r3 =3D *(u64 *)(r1 +24)
>   func 'kfree_skb' arg3 has btf_id 5253 type STRUCT 'sock'
>   1: R1=3Dctx() R3_w=3Dtrusted_ptr_or_null_sock(id=3D1)
>   ; bpf_printk("sk: %d, %d\n", sk, sk->__sk_common.skc_family); @ kfree_s=
kb_sk_null.bpf.c:24
>   1: (69) r4 =3D *(u16 *)(r3 +16)
>   R3 invalid mem access 'trusted_ptr_or_null_'
>   processed 2 insns (limit 1000000) max_states_per_insn 0 total_states 0 =
peak_states 0 mark_read 0
>   -- END PROG LOAD LOG --
>
> Note this fix requires commit 8aeaed21befc ("bpf: Support
> __nullable argument suffix for tp_btf").
>
> [0]:
> BUG: kernel NULL pointer dereference, address: 0000000000000010
>  PF: supervisor read access in kernel mode
>  PF: error_code(0x0000) - not-present page
> PGD 0 P4D 0
> PREEMPT SMP
> CPU: 6 UID: 0 PID: 348 Comm: sshd Not tainted 6.12.11 #206
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian=
-1.16.2-1 04/01/2014
> RIP: 0010:bpf_prog_5e21a6db8fcff1aa_drop+0x10/0x2d
> Code: cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc c=
c cc cc cc 0f 1f 44 00 00 0f 1f 00 55 48 89 e5 48 8b 57 18 <48> 0f b7 4a 10=
 48 bf 0c 4f e2 c1 ad 90 ff ff be 0c 00 00 00 e8 0f
> RSP: 0018:ffffa86640b53da8 EFLAGS: 00010202
> RAX: 0000000000000001 RBX: ffffa866402d1000 RCX: 0000000000000002
> RDX: 0000000000000000 RSI: ffffa866402d1048 RDI: ffffa86640b53dc8
> RBP: ffffa86640b53da8 R08: 0000000000000000 R09: 9c908cd09b9c8c91
> R10: ffff90adc056b540 R11: 0000000000000002 R12: 0000000000000000
> R13: ffffa86640b53e88 R14: 0000000000000800 R15: fffffffffffffffe
> FS:  00007f2a27c2b480(0000) GS:ffff90b0efd00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000010 CR3: 0000000100e69004 CR4: 00000000001726f0
> Call Trace:
>  <TASK>
>  ? __die+0x1f/0x60
>  ? page_fault_oops+0x148/0x420
>  ? search_bpf_extables+0x5b/0x70
>  ? fixup_exception+0x27/0x2c0
>  ? exc_page_fault+0x75/0x170
>  ? asm_exc_page_fault+0x22/0x30
>  ? bpf_prog_5e21a6db8fcff1aa_drop+0x10/0x2d
>  bpf_trace_run4+0x68/0xd0
>  ? unix_stream_connect+0x1f4/0x6f0
>  sk_skb_reason_drop+0x90/0x120
>  unix_stream_connect+0x1f4/0x6f0
>  __sys_connect+0x7f/0xb0
>  __x64_sys_connect+0x14/0x20
>  do_syscall_64+0x47/0xc30
>  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> RIP: 0033:0x7f2a27f296a0
> Code: 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1=
f 44 00 00 80 3d 41 ff 0c 00 00 74 17 b8 2a 00 00 00 0f 05 <48> 3d 00 f0 ff=
 ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 54
> RSP: 002b:00007ffe29274f58 EFLAGS: 00000202 ORIG_RAX: 000000000000002a
>
> Fixes: c53795d48ee8 ("net: add rx_sk to trace_kfree_skb")
> Reported-by: Yan Zhai <yan@cloudflare.com>
> Closes: https://lore.kernel.org/netdev/Z50zebTRzI962e6X@debian.debian/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  include/trace/events/skb.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/trace/events/skb.h b/include/trace/events/skb.h
> index b877133cd93a..8bf0e61b8549 100644
> --- a/include/trace/events/skb.h
> +++ b/include/trace/events/skb.h
> @@ -24,9 +24,9 @@ DEFINE_DROP_REASON(FN, FN)
>  TRACE_EVENT(kfree_skb,
>
>         TP_PROTO(struct sk_buff *skb, void *location,
> -                enum skb_drop_reason reason, struct sock *rx_sk),
> +                enum skb_drop_reason reason, struct sock *rx_sk__nullabl=
e),
>
> -       TP_ARGS(skb, location, reason, rx_sk),
> +       TP_ARGS(skb, location, reason, rx_sk__nullable),
>
>         TP_STRUCT__entry(
>                 __field(void *,         skbaddr)
> @@ -39,7 +39,7 @@ TRACE_EVENT(kfree_skb,
>         TP_fast_assign(
>                 __entry->skbaddr =3D skb;
>                 __entry->location =3D location;
> -               __entry->rx_sk =3D rx_sk;
> +               __entry->rx_sk =3D rx_sk__nullable;
>                 __entry->protocol =3D ntohs(skb->protocol);
>                 __entry->reason =3D reason;
>         ),
> --
> 2.39.5 (Apple Git-154)
>

Tested-by: Yan Zhai <yan@cloudflare.com>

