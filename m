Return-Path: <bpf+bounces-44065-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6C19BD4B0
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 19:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56FAE1F23447
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 18:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5004C1E8825;
	Tue,  5 Nov 2024 18:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Brk4009R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253A41E3DF2
	for <bpf@vger.kernel.org>; Tue,  5 Nov 2024 18:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730831755; cv=none; b=o3XxUKPJ0T0xdzjWCkMjJP0mvFrpBlc4uPBsK3MOcvkZtKWEAnkaSjrC0DxssEne6K/f0wGTjEJcXVabQ4wr1xB09NF5il2fHWJ7nlR7ne57awBQ7TuwjSp9akuW/ldtC9syEP/n5cUwfOOYaXw9f7cPR+ppiGVp13Guz4PLQRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730831755; c=relaxed/simple;
	bh=lkw9YVirJLLolukB2MHkQgDo2glpg3tP+JnD6+MTn0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HVqftzY3bJ86BT3ouVaSW0pVP7J94gWTeE2oijiRCEn2PgMZTOfwt9i+LVs7fbdtDb4gPSmI5c51DUfiX5zRgPaV3YoN81QWrMMzAwgUuI+Wn9u1A3woS909loODm1WKc5VI+Cdz4Kd2vZTaeLJCizdyh2SPtE5ipFE7osEX9is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Brk4009R; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d447de11dso4485672f8f.1
        for <bpf@vger.kernel.org>; Tue, 05 Nov 2024 10:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730831752; x=1731436552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J6jdlMMFuSCNYBlCJ7CX+a9e/y334JpPqQ4G7kze964=;
        b=Brk4009R41DjYDr77KLiOowfo3YI1W8mQi0slIscMjkbw9DzvCWk8ToAdWSDbL1nkr
         rQorBC8tKokQdH0LOIywRcW9NbAhsvsG77fuoaK9dUNq/AZLnqVGRCKZ5s0o8d6ZuPEH
         ETCa847bLCb/6MMtGTfgpxCjkpmmeCgJzT0+jZq5Wtmaom3QkNLPeW6Hri5BJGULe4JC
         4+68jZMXlWfrW7vbBCuNVpEXxrMwZUAouGhet4hhfvFDWNtQcCGF9Sh0Tuyb7hDTbSp+
         38wNpw1CRqcCTW4zMRfzViM+rO762xnecMF2X4ApLgkHZb7dtFflRM9BBMlM6VDUleaq
         nKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730831752; x=1731436552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J6jdlMMFuSCNYBlCJ7CX+a9e/y334JpPqQ4G7kze964=;
        b=goFAwlk259ycN7vZhvRNi3hITN9/YiDQ7TP24ekGJdOmrwxTm8rcLWa4VsHMS2bHAl
         5We+/1OsOfX66YVDIF6XdcZfh+kWiw5xyQAVbiJkIC97FRX6EKGwfjbSCSJ3Kv1V6Rm2
         evRmqn3Ory1dF7eoV3J5cFAni2BILtHQMh+FfYs4bXwMu76gEPTU0UZ6V8FQoH14vtUN
         Don8CgQfx2RV5EhOyWt4wkBvOXj7gfuv7Wymzy264sunMYxa5pc7vCW8wTt+o+yYh6yD
         GPAwQ3VpZJcLNloCXk/Yi3Wwf5sPeTkO+ltMP3BZPdcoN6gqf/uOMrru7jZmHbYVQD5g
         ZhWw==
X-Forwarded-Encrypted: i=1; AJvYcCVWjfosT6EbrH8538puVnc/e/7uEM96Q+wUc7TYdE7SU1o4xIEWZFL3HKpLoU6N6oOzaYk=@vger.kernel.org
X-Gm-Message-State: AOJu0YytPeKbeJOP4rWsOBfi8d5KwV7tpxqJTA+qE9z/riHxB9ozGp0g
	nBbarcbcSHsWP0HSX70V8C0hNF3l5VSZRi8I60twGwPXA5f3589wWwRbBOwaSHeia+rdMlIM7LW
	ZMa/xWGie90c4+iiyXQ9H5Qt5X/w=
X-Google-Smtp-Source: AGHT+IHyzSuoDicjnNJbGl7RJGem0XerEO6EzKNppGUtybeoQEN1F9Rr7/DeKnLWH4C5jRR/+dtciExihTQxcpQjwYY=
X-Received: by 2002:a05:6000:2805:b0:37d:5173:7a54 with SMTP id
 ffacd0b85a97d-381bea27660mr12097165f8f.52.1730831752145; Tue, 05 Nov 2024
 10:35:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241103193512.4076710-1-memxor@gmail.com> <20241103193512.4076710-3-memxor@gmail.com>
 <20241104195354.GA31782@noisy.programming.kicks-ass.net>
In-Reply-To: <20241104195354.GA31782@noisy.programming.kicks-ass.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 5 Nov 2024 10:35:40 -0800
Message-ID: <CAADnVQJwV6bg15qJjdHgzUM83V7t1XiM17Xjf+FSTKSZi445KQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] bpf, x86: Skip bounds checking for
 PROBE_MEM with SMAP
To: Peter Zijlstra <peterz@infradead.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, kkd@meta.com, 
	Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Rishabh Iyer <rishabh.iyer@berkeley.edu>, 
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>, X86 ML <x86@kernel.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 11:54=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Sun, Nov 03, 2024 at 11:35:12AM -0800, Kumar Kartikeya Dwivedi wrote:
> >  arch/x86/net/bpf_jit_comp.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index 06b080b61aa5..7e3bd589efc3 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -1954,8 +1954,8 @@ st:                     if (is_imm8(insn->off))
> >               case BPF_LDX | BPF_PROBE_MEMSX | BPF_W:
> >                       insn_off =3D insn->off;
> >
> > -                     if (BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEM ||
> > -                         BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEMSX) =
{
> > +                     if ((BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEM ||
> > +                          BPF_MODE(insn->code) =3D=3D BPF_PROBE_MEMSX)=
 && !cpu_feature_enabled(X86_FEATURE_SMAP)) {
> >                               /* Conservatively check that src_reg + in=
sn->off is a kernel address:
> >                                *   src_reg + insn->off > TASK_SIZE_MAX =
+ PAGE_SIZE
> >                                *   and
>
> Well, I can see why you'd want to get rid of that, that's quite
> dreadful code you generate there.
>
> Can't you do something like:
>
>   lea off(%src), %r10
>   mov %r10, %r11
>   inc %r10
>   sar $63, %r11
>   and %r11, %r10
>   dec %r10
>
>   mov (%r10), %rax

That's a Linus's hack for mask_user_address() and
earlier in valid_user_address().
I don't think it works because of
#define VSYSCALL_ADDR (-10UL << 20)

We had to filter out that range.

I don't understand why valid_user_address() is not broken,
since fault handler considers vsyscall address to be user addr
in fault_in_kernel_space().
And user addr faulting doesn't have extable handling logic.

> I realize that's not exactly pretty either, but no jumps. Not sure
> this'll help much if anything with the TDX thing though.

to clarify... this is not bpf specific. This bpf JIT logic is
nothing but inlined version of copy_from_kernel_nofault().
So if confidential computing has an issue lots of pieces are affected.

So this patch set is the preferred way to accelerate this
inlined copy_from_kernel_nofault().
If it lands we can follow up and optimize copy_from_kernel_nofault()
with cpu_feature_enabled(X86_FEATURE_SMAP) as well.
Though I'm not sure whether slab get_freepointer_safe() cares
that much about saving nanoseconds. But bpf does.

