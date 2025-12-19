Return-Path: <bpf+bounces-77176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB11CD1526
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 19:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA0C6306CF54
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 18:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955543446C5;
	Fri, 19 Dec 2025 18:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uk0rt2Zg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942FB342500
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 18:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766167615; cv=none; b=j/QDb1jd7tgULzxxb3Gqb3TccRAO30eRd/b9AdSVDOUj3J+ck+8OlnD/Sl6srysJP9eD4Jr6OfbO63MRtunxhIbIxUHFFYPeJK39XpQG1tSqIUMBSae4E4XMARO493zWjrJJIorf6NLPfPdjZi6J69VUZJx+JJPE5dUjypOAOnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766167615; c=relaxed/simple;
	bh=PS8aGS8n4f9EImCnV1QjgnkEZHFhk5ur7LAQFVS43QM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IyUW5UMbr6aGY1e+BflwM5H63EE9LCyZnSxL/eHM2Ix+lyFGo1GslM4R26+K2tmsOD8wA9Wk0ARalJ0hknhtDHlohyITtNbsUQxpFJacyjNvKxkM8IcJDnP3DHpVvaxvYwGziZ9KqhOon+Zz0eDR4K0M2fVhqgdGbCncpZ/lHCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uk0rt2Zg; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-34ccb7ad166so2036922a91.2
        for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 10:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766167610; x=1766772410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qosZakFhYdG6X2ZBYTzKS7NaacVY3QraRYdC9vadgS0=;
        b=Uk0rt2ZgXo60F+CQE8HbUR1VnbWgOcMZ9nVidBWXkmK2efS58v5kCgzT+6PStZPQUU
         S9yd1KpE6g0JcwyE+D/5+aaRKvuoosf879jGluMhiuFl71nWGi18Wf5C/39a2yu57Gsy
         xOVoh7OPWnfOnVRPQQh72nAqEekfRph0d6b9nidRAEtH/8hSa6ubMj4vGh/LskBvz8PZ
         beWmu7fzDe6AA7ojYCmc6XWEDqvhrrtkRHCxKpX4vpZ5j9nfR2Bh5BXznoNPy4soIyj3
         EjZuxvWAjNyvxSD9CV7GUduWtxdl6rzBXxb3tV1CJAWL5n4EdehaWQ/NKpgQPEntDh8q
         pEDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766167610; x=1766772410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qosZakFhYdG6X2ZBYTzKS7NaacVY3QraRYdC9vadgS0=;
        b=wMlI8xoGune8xKgrWgXvUMSY8Nma4CPCp79oZNJacaOc1jVNLDWEEA39W9oj7drHSv
         0Ymd2qoolTJFPOyoJImMD3MidVj3uYT/46vBYwW1mdIMlDTbm/TFTom8tiRyklUnPljL
         5iiMRNXWJI/3i8oa6eni4QFtnJ37Zd0uqfILerXfuRj8Z+878luNRUVwAB+vzbc3RIVd
         MR4gbCnQVye1VZr4cObhSQ5bEG7D00EzyNP9PnNmBBh4j5TD+oZ2kz9DwSZNx/bwD3zi
         X9iymudk0PNnSnT2IXikk0UT+Gz5xQX5k+zGMBJy8jkJwRvASfE6NBBocgmWd+S42sLo
         UF9w==
X-Forwarded-Encrypted: i=1; AJvYcCXSa8kUrtxUbkQGqRwyV9+WSp+TVyjC2fFbbJEIuV6f7UCI5sNrNOga+ty9Y5DpBLh3Mak=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXvBCit/NLdHtF9OYf4IMN+OdGi4RDq9g9QTYn1wngZQB+gAWZ
	bnZFIxkf0DipufAcn7QwFQtow0+aM87OEyq/PCM/eKpraXABOQOmnG3I1RERBvfVDn1AHm7ODPd
	+AZnU//yPF5MFHCUdlLX8PARNdVmIyAE=
X-Gm-Gg: AY/fxX49zi02l0Kbt0zM3ect5SvaR6xCjIt9lRP52523cXrek4sUOQ2E8OitK4mq3mG
	xddBTEvla9vG5DslDLaHpT/8xH9m7DXw5ZTRzMEgitlDtW88vSpsEK4n14gdFKWdB9IqXOZh/7t
	h/Nw/1za0zRYLRcYJ5VvILZr49Yl9aWoe+Cu5je7C9rOo7g4ATOs6k49RtqjC991lcIGC9doAU0
	PhJGnq31oD1D3OkxxhRrdmEUfT1c9ZIAt9Zn3dMr+b01hzURZfhkHIBjrH89vepA7e2DcfSwVAc
	P3GKIA==
X-Google-Smtp-Source: AGHT+IELkvg9hwjjD1NgKcyOGFac7K1VtSkXFLfkRXFpfI1tYbR+cyHadC0UQJGbH/ohsYwpBSb27DvI3ZXGvLSDXXE=
X-Received: by 2002:a17:90b:4a52:b0:343:6611:f21 with SMTP id
 98e67ed59e1d1-34e92137b5dmr3035036a91.1.1766167609589; Fri, 19 Dec 2025
 10:06:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251219124748.81133-1-dongml2@chinatelecom.cn>
In-Reply-To: <20251219124748.81133-1-dongml2@chinatelecom.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Dec 2025 10:06:37 -0800
X-Gm-Features: AQt7F2pzdwWAbVPseLvzkmUY4U2obagqdu1hJJyWZS-asVbN3Dd2foRZZL3Djcc
Message-ID: <CAEf4BzZBoHvB0yY740zyZWYKAgCeTXjLvfJUebq5FRWmq=WBZA@mail.gmail.com>
Subject: Re: [PATCH bpf] riscv, bpf: fix incorrect usage of BPF_TRAMP_F_ORIG_STACK
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bjorn@kernel.org, 
	pulehui@huawei.com, puranjay@kernel.org, pjw@kernel.org, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, jiang.biao@linux.dev, 
	bpf@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 6:43=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> The usage of BPF_TRAMP_F_ORIG_STACK in __arch_prepare_bpf_trampoline() is
> wrong, and it should be BPF_TRAMP_F_CALL_ORIG, which caused crash as
> Andreas reported:
>
>   Insufficient stack space to handle exception!
>   Task stack:     [0xff20000000010000..0xff20000000014000]
>   Overflow stack: [0xff600000ffdad070..0xff600000ffdae070]
>   CPU: 1 UID: 0 PID: 1 Comm: systemd Not tainted 6.18.0-rc5+ #15 PREEMPT(=
voluntary)
>   Hardware name: riscv-virtio qemu/qemu, BIOS 2025.10 10/01/2025
>   epc : copy_from_kernel_nofault+0xa/0x198
>    ra : bpf_probe_read_kernel+0x20/0x60
>   epc : ffffffff802b732a ra : ffffffff801e6070 sp : ff2000000000ffe0
>    gp : ffffffff82262ed0 tp : 0000000000000000 t0 : ffffffff80022320
>    t1 : ffffffff801e6056 t2 : 0000000000000000 s0 : ff20000000010040
>    s1 : 0000000000000008 a0 : ff20000000010050 a1 : ff60000083b3d320
>    a2 : 0000000000000008 a3 : 0000000000000097 a4 : 0000000000000000
>    a5 : 0000000000000000 a6 : 0000000000000021 a7 : 0000000000000003
>    s2 : ff20000000010050 s3 : ff6000008459fc18 s4 : ff60000083b3d340
>    s5 : ff20000000010060 s6 : 0000000000000000 s7 : ff20000000013aa8
>    s8 : 0000000000000000 s9 : 0000000000008000 s10: 000000000058dcb0
>    s11: 000000000058dca7 t3 : 000000006925116d t4 : ff6000008090f026
>    t5 : 00007fff9b0cbaa8 t6 : 0000000000000016
>   status: 0000000200000120 badaddr: 0000000000000000 cause: 8000000000000=
005
>   Kernel panic - not syncing: Kernel stack overflow
>   CPU: 1 UID: 0 PID: 1 Comm: systemd Not tainted 6.18.0-rc5+ #15 PREEMPT(=
voluntary)
>   Hardware name: riscv-virtio qemu/qemu, BIOS 2025.10 10/01/2025
>   Call Trace:
>   [<ffffffff8001a1f8>] dump_backtrace+0x28/0x38
>   [<ffffffff80002502>] show_stack+0x3a/0x50
>   [<ffffffff800122be>] dump_stack_lvl+0x56/0x80
>   [<ffffffff80012300>] dump_stack+0x18/0x22
>   [<ffffffff80002abe>] vpanic+0xf6/0x328
>   [<ffffffff80002d2e>] panic+0x3e/0x40
>   [<ffffffff80019ef0>] handle_bad_stack+0x98/0xa0
>   [<ffffffff801e6070>] bpf_probe_read_kernel+0x20/0x60
>
> Just fix it.
>
> Fixes: 47c9214dcbea ("bpf: fix the usage of BPF_TRAMP_F_SKIP_FRAME")
> Reported-by: Andreas Schwab <schwab@linux-m68k.org>
> Closes: https://lore.kernel.org/bpf/874ipnkfvt.fsf@igel.home/
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  arch/riscv/net/bpf_jit_comp64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_com=
p64.c
> index 5f9457e910e8..09b70bf362d3 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -1134,7 +1134,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im,
>         store_args(nr_arg_slots, args_off, ctx);
>
>         /* skip to actual body of traced function */
> -       if (flags & BPF_TRAMP_F_ORIG_STACK)
> +       if (flags & BPF_TRAMP_F_CALL_ORIG)
>                 orig_call +=3D RV_FENTRY_NINSNS * 4;
>
>         if (flags & BPF_TRAMP_F_CALL_ORIG) {

move orig_call here, it's the same flags & BPF_TRAMP_F_CALL_ORIG check, no?

> --
> 2.52.0
>
>

