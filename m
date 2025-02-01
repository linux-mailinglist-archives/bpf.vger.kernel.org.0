Return-Path: <bpf+bounces-50264-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 064C0A246E5
	for <lists+bpf@lfdr.de>; Sat,  1 Feb 2025 04:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F03AA18885A9
	for <lists+bpf@lfdr.de>; Sat,  1 Feb 2025 03:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A399045C14;
	Sat,  1 Feb 2025 03:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Hls9IWr7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5728826296
	for <bpf@vger.kernel.org>; Sat,  1 Feb 2025 03:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738379805; cv=none; b=Zl7WWne/pbgRPNGmiks5S1MrONe9Krotdel9CzDQL7gl5TZ6/m3u417ZnD/T3tKdqPcEESyfNRyDXxD0Z1r4w59x3DlDhF3fWaLjqNmBy3/YuRhoOGR873PZlQEYNpDlDnNL8tFZLqUZ6KVvnfVgxrDcP03OVcViTVqrafdpLmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738379805; c=relaxed/simple;
	bh=nhkCtDPXWDUTu2rXwU6w/MYsK4emOA5Sm22cBRg+xE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aPbTrzDoRvkZhyFj0h3QpQMb/8Vuuky5KnrMa2jtRpfyeiAvzGoHdvGVADBTE49Fg/uscLniWDSyQHqsjkL1a2uzrCC42Cd0PSnuJkGVaCzqYBiMniExnww9Q6dyfIejfuH0gr2mdlrpaT4MQvMiYUI/1fdpxW4ltQF142XDOD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Hls9IWr7; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5dc149e14fcso4844361a12.2
        for <bpf@vger.kernel.org>; Fri, 31 Jan 2025 19:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1738379801; x=1738984601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jiD2T0QMduLVWoDYaNNJ3R+C+Xproe66e7kGxD89ZXM=;
        b=Hls9IWr7l91dWiFAs6tybTjSlgwaIJ9zBIKN9PULAOxlHWX5GtgEM7ar2qhNuf28ZR
         GhBLN0cOBT1pK7NBJ9vTezXz1YE3aKSSt1J02TmfgMJH6Z59y8xE00q5yX+PlLU+pmTH
         p7X/+qvF4ga8Vb4ERExiFU4qzGaaWCUXv2fFJSUbmECoy2OVeioqpRwk6igesx2HIqPB
         8d2hkv3QqaTgMQXfQLLvyqFT/iPuyfSdcOdaht0hkFnQgtKARoYbVsef0+/doEfeWy3j
         sXP0hvebv1jcvblFzIIpT2UDXZth+A+RjomGnTUOz3LYpPTIvTxPATINdFFbU9N6baUR
         lz4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738379801; x=1738984601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jiD2T0QMduLVWoDYaNNJ3R+C+Xproe66e7kGxD89ZXM=;
        b=HPzyMjLcxIqEIAvgej+ACd0A5qu5IKSZhTQ65p4xYetA01ioFT/zrzAVKdq0CiwEhE
         liDEH0cYCB2t8/6SoQHOCtPJgXus5tfo97dSekmR3LKUUBwqnlAkxE1muVExVepu3Jz9
         HQWAvOjvBFV5KttOEVtP/xJzNQGRdqCsUZrgPDv7EaciN+/vu2B2VLHIzV9uqNXyvtK/
         65QIgh5vcIBCaQYHD9wJdsEcuVVGYL5QXZ6r9nELZPXxXMw3+gl5VM4uULhMJQvqYQRs
         scfgOMcj5bQtU8s/5exk2KMOpa/Jyh92VnMLgwjIwEyHPMPqSazdcQoznMu72aGpC9sa
         BB1w==
X-Forwarded-Encrypted: i=1; AJvYcCVNfSfEsO7I1tFyNfagIW9r5uSawfJDsIUbj6oAex92pHvnZ2WpNxcEHAmApUrGAKgtVuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtIDHq2MgxkoFT9y8fMcD3yDy6kJ4eq2nOyuKrDAsjgwFfvP3p
	WkVuQtYjO9MMwS8aA0/Ov4ko+oiT2oLObP3aFy+OSgHj76fQUQplbjRt3DHLmWzA42DS3KXggYp
	dyd9GAAS6WsRgXAX9lY2QJltb8nBnS8IhHhjRaA==
X-Gm-Gg: ASbGncvgnObIFc6WM/jJ8A90TJOWnOGnT8VIEkJ/N7hGpilzHR5yWiXuF7KZMLnTYF5
	Eke7oVsW8tZ9MIDtU3AXaWLEUCzELBnN//zkEswaTlcG5qYgX6k6GGS2sDhfi1RuoqGdaFrHodE
	AxmgIqnkPb89A=
X-Google-Smtp-Source: AGHT+IFAnPSCz64iVhRFrWBiPpTdzvGW2q5JbNhQ7vDdTlNUdboFGK/LaAhgws34G5uJxuU8uaPtnkq4T6iuruDXItI=
X-Received: by 2002:a05:6402:2807:b0:5d0:c801:560 with SMTP id
 4fb4d7f45d1cf-5dc5efe27edmr13951811a12.20.1738379801494; Fri, 31 Jan 2025
 19:16:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250201030142.62703-1-kuniyu@amazon.com>
In-Reply-To: <20250201030142.62703-1-kuniyu@amazon.com>
From: Yan Zhai <yan@cloudflare.com>
Date: Fri, 31 Jan 2025 21:16:30 -0600
X-Gm-Features: AWEUYZkNR8jPhiEo1lnXD69T0rExy2s8AfrqENLzR887_voyN2v1KaqSXOAAvuw
Message-ID: <CAO3-Pbqwz=j2_=xi1tTArO9Fa1xn5sj2QkkzwoeVM-8r6-_uyQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf] net: Add rx_skb of kfree_skb to raw_tp_null_args[].
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 31, 2025 at 9:02=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> Yan Zhai reported a BPF prog could trigger a null-ptr-deref [0]
> in trace_kfree_skb if the prog does not check if rx_sk is NULL.
>
> Commit c53795d48ee8 ("net: add rx_sk to trace_kfree_skb") added
> rx_sk to trace_kfree_skb, but rx_sk is optional and could be NULL.
>
> Let's add kfree_skb to raw_tp_null_args[] to let the BPF verifier
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
> Note this fix requires commit 838a10bd2ebf ("bpf: Augment raw_tp
> arguments with PTR_MAYBE_NULL").
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

Tested-by: Yan Zhai <yan@cloudflare.com>


> ---
> v2:
>   * Add kfree_skb to raw_tp_null_args[] instead of annotating
>     rx_skb with __nullable
>
> v1: https://lore.kernel.org/bpf/20250201001425.42377-1-kuniyu@amazon.com/
> ---
>  kernel/bpf/btf.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 9de6acddd479..c3223e0db2f5 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6507,6 +6507,8 @@ static const struct bpf_raw_tp_null_args raw_tp_nul=
l_args[] =3D {
>         /* rxrpc */
>         { "rxrpc_recvdata", 0x1 },
>         { "rxrpc_resend", 0x10 },
> +       /* skb */
> +       {"kfree_skb", 0x1000},
>         /* sunrpc */
>         { "xs_stream_read_data", 0x1 },
>         /* ... from xprt_cong_event event class */
> --
> 2.39.5 (Apple Git-154)
>

