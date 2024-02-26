Return-Path: <bpf+bounces-22742-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A39A9868381
	for <lists+bpf@lfdr.de>; Mon, 26 Feb 2024 23:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B2A5B22043
	for <lists+bpf@lfdr.de>; Mon, 26 Feb 2024 22:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEAF131E36;
	Mon, 26 Feb 2024 22:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvwaOlfF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F1E131750
	for <bpf@vger.kernel.org>; Mon, 26 Feb 2024 22:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708985571; cv=none; b=Wjumwj8tFilWLkNo1fouY6KTW5CLi6SpPtj3yLwb6YN5oM3+39E6FRMclLxzM7X4WbkDqqnebhPHtRPKpozSAgu5wDABVQc3V7N39CSMY1Yk72Dw5mrJZy0N1dO/V/GJqmIOYJD9w8lCkSQ/EkGL7s60CcEZWeTg5MDGcb4v6RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708985571; c=relaxed/simple;
	bh=H1/yfNFI0NR2PKgv56uZDYH5zRjWKqIypFSsBNQ2rWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UtEbzpCcC8g2tyddAEvpNRm2E5NS3HAtsLsa50DdNAJtmCzwqBG5dWFRsOZNji+mM260z2KA34x2ry1h5LhuwZo43Kf7SZcZIJgiM6/vTKXAewj6Ric9zG87BslIjuNcn3Wj/mcIXpBL8lXoN85kakVNeAJaPVbOB1LGu+49zQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RvwaOlfF; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3392b12dd21so3008591f8f.0
        for <bpf@vger.kernel.org>; Mon, 26 Feb 2024 14:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708985568; x=1709590368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pupusZzlymZN+10QyurQ+JGTvWI5bdCz+D1o7cstoNI=;
        b=RvwaOlfFRxFG16lZCLnKR+o5ht6Iflpbs6Oe5bST2iJQaYf89epePQNZGgk/hcZYwl
         j+zxp2XooqDfpXfyAjrDRuOO3mcNHEbFT+Wq9+Cg7SXqMgdClIyyDtZxkSmrIQw/FA25
         UdYRKM0buljG5vnBH8+iL8todvX9mRW7hV5YnX2AR+QjfzNXvcRLKH7QOhR6kn9dg9Y6
         vc/ZhGSGRjQ4gds8/Jol+5U2lIiO9uZI0h/1gk2kzlWGbIT5vYCGORu/7QAy08TZI394
         6H0QGWnwnIGJvz1aFsFKvhlMHXv58sAiHMPNvy0UKnEllihqRYOHdOAUEJHjcQTWnPTp
         /xvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708985568; x=1709590368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pupusZzlymZN+10QyurQ+JGTvWI5bdCz+D1o7cstoNI=;
        b=M30MO1hJh+NeN3uNDe/nyt1pqM+PunrGech1uxay66r1Ts8jEYqvGhKSZjUoz2yqVm
         6vE1asbHcAXTdNepxkYdJt5v7JnWykjsBXHSlIO6RGMb6gMHFxtTNP7EmGWf68hoqTNL
         EiATDEqy20GV/lsdTQL3szYTIOuCkkFMeu6CrJShzPO06NfSd59x3lWeV6I8BJ+N9Ctd
         vyHQ4XILztqXVG2e8nKNvmeF2AhT6oU6q8iR8z1O5AnUB/3rGBbuP3uAtZoUQgENDS7p
         GvGw7l0kq6KPk7gN9mGtHyHY9r9gYo2qHUx6mEdIG1RBj2w455w58ew/tw+JwEl2pVwM
         2MGA==
X-Forwarded-Encrypted: i=1; AJvYcCW6kiXdfW0Nxw3ZmtS6tMWNibj9JzNF8ZYUcWLyC3+aaxU5c4v3f8HYtzu4sh0+Z+759bDS+lI4rZNvuXvR3KNUd9Rr
X-Gm-Message-State: AOJu0YxHOBafIbvVnnAJCd8V5GfaMxBhQUAasDPCe3eNyNpvHwLScKop
	0WxNofhKcHDmrq2vwNdAPHrNhHyg0j16do/P1wOxXU2AjSlm7C7HzoJiaOvzodwQfHC25taiArT
	sISLDRGnlllhJaIgypck5ZrY0rTs=
X-Google-Smtp-Source: AGHT+IG7dvcC5Uh45LBVAnaKBgB6ri7Uqs/1kBry9/ibL2eCqtytn2Ip918YX3/f6DXyIokmeo+NpBdtaxxcjgXpO2Q=
X-Received: by 2002:adf:cf05:0:b0:33c:df47:cae with SMTP id
 o5-20020adfcf05000000b0033cdf470caemr5479259wrj.60.1708985567741; Mon, 26 Feb
 2024 14:12:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222085232.62483-1-hffilwlqm@gmail.com> <20240222085232.62483-2-hffilwlqm@gmail.com>
 <8a3111a0-b190-437f-979e-393f0c890bf1@huawei.com> <1fdb4ba0-5b91-419a-960c-a26de0e51c25@gmail.com>
 <CAADnVQ+yzkAxCK=L9qVUzSEmj72CH=9kqe25=Risj_BdaLDA=A@mail.gmail.com> <c43e82e2-7a23-44fc-b841-b3ace7dc6bcf@gmail.com>
In-Reply-To: <c43e82e2-7a23-44fc-b841-b3ace7dc6bcf@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 26 Feb 2024 14:12:35 -0800
Message-ID: <CAADnVQ+Fr0k+28L=BLaXDxu=wDBwpiuCaXzEN3y6jEXj48zhUg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf, x64: Fix tailcall hierarchy
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: Pu Lehui <pulehui@huawei.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
	Hengqi Chen <hengqi.chen@gmail.com>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 7:32=E2=80=AFAM Leon Hwang <hffilwlqm@gmail.com> wr=
ote:
>
>
>
> On 2024/2/24 00:35, Alexei Starovoitov wrote:
> > On Fri, Feb 23, 2024 at 7:30=E2=80=AFAM Leon Hwang <hffilwlqm@gmail.com=
> wrote:
> >>
> >>
> >>
> >> On 2024/2/23 12:06, Pu Lehui wrote:
> >>>
> >>>
> >>> On 2024/2/22 16:52, Leon Hwang wrote:
> >>
> >> [SNIP]
> >>
> >>>>   }
> >>>>   @@ -575,6 +574,54 @@ static void emit_return(u8 **pprog, u8 *ip)
> >>>>       *pprog =3D prog;
> >>>>   }
> >>>>   +DEFINE_PER_CPU(u32, bpf_tail_call_cnt);
> >>>
> >>> Hi Leon, the solution is really simplifies complexity. If I understan=
d
> >>> correctly, this TAIL_CALL_CNT becomes the system global wise, not the
> >>> prog global wise, but before it was limiting the TCC of entry prog.
> >>>
> >>
> >> Correct. It becomes a PERCPU global variable.
> >>
> >> But, I think this solution is not robust enough.
> >>
> >> For example,
> >>
> >> time      prog1           prog1
> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>
> >> line              prog2
> >>
> >> this is a time-line on a CPU. If prog1 and prog2 have tailcalls to run=
,
> >> prog2 will reset the tail_call_cnt on current CPU, which is used by
> >> prog1. As a result, when the CPU schedules from prog2 to prog1,
> >> tail_call_cnt on current CPU has been reset to 0, no matter whether
> >> prog1 incremented it.
> >>
> >> The tail_call_cnt reset issue happens too, even if PERCPU tail_call_cn=
t
> >> moves to 'struct bpf_prog_aux', i.e. one kprobe bpf prog can be
> >> triggered on many functions e.g. cilium/pwru. However, this moving is
> >> better than this solution.
> >
> > kprobe progs are not preemptable.
> > There is bpf_prog_active that disallows any recursion.
> > Moving this percpu count to prog->aux should solve it.
> >
> >> I think, my previous POC of 'struct bpf_prog_run_ctx' would be better.
> >> I'll resend it later, with some improvements.
> >
> > percpu approach is still prefered, since it removes rax mess.
>
> It seems that we cannot remove rax.
>
> Let's take a look at tailcall3.c selftest:
>
> struct {
>         __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
>         __uint(max_entries, 1);
>         __uint(key_size, sizeof(__u32));
>         __uint(value_size, sizeof(__u32));
> } jmp_table SEC(".maps");
>
> int count =3D 0;
>
> SEC("tc")
> int classifier_0(struct __sk_buff *skb)
> {
>         count++;
>         bpf_tail_call_static(skb, &jmp_table, 0);
>         return 1;
> }
>
> SEC("tc")
> int entry(struct __sk_buff *skb)
> {
>         bpf_tail_call_static(skb, &jmp_table, 0);
>         return 0;
> }
>
> Here, classifier_0 is populated to jmp_table.
>
> Then, at classifier_0's prologue, when we 'move rax,
> classifier_0->tail_call_cnt' in order to use the PERCPU tail_call_cnt in
> 'struct bpf_prog' for current run-time, it fails to run selftests. It's
> because the tail_call_cnt is not from the entry bpf prog. The
> tail_call_cnt from the entry bpf prog is the expected one, even though
> classifier_0 bpf prog runs. (It seems that it's unnecessary to provide
> the diff of the exclusive approach with PERCPU tail_call_cnt.)

Not following.
With percpu tail_call_cnt, does classifier_0 loop forever ? I doubt it.
You mean expected 'count' value is different?
The test expected 33 and instead it's ... what?

> +               if (tail_call_reachable && !is_subprog) {
> +                       /* mov rax, entry->tail_call_cnt */
> +                       EMIT2_off64(0x48, 0xB8, (u64) entry->tail_call_cn=
t);
> +                       /* call bpf_tail_call_cnt_prepare */
> +                       emit_call(&prog, bpf_tail_call_cnt_prepare,
> +                                 ip + (prog - start));
> +               } else {
>                         /* Keep the same instruction layout. */
> -                       EMIT2(0x66, 0x90); /* nop2 */
> +                       emit_nops(&prog, 10 + X86_PATCH_SIZE);

As mentioned before... such "fix" is not acceptable.
We will not be penalizing all progs this way.

How about we make percpu tail_call_cnt per prog_array map,
then remove rax as this patch does,
but instead of zeroing tcc on entry, zero it on exit.
While processing bpf_exit add:
if (tail_call_reachable)
  emit_call(&prog, bpf_tail_call_cnt_prepare,...)

if prog that tailcalls get preempted on this cpu and
another prog starts that also tailcalls it won't zero the count.
This way we can remove nop5 from prologue too.

The preempted prog will eventually zero ttc on exit,
and earlier prog that uses the same prog_array can tail call more
than 32 times, but it cannot be abused reliably,
since preemption is non deterministic.

