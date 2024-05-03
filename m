Return-Path: <bpf+bounces-28519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD858BB083
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 18:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DE7B282DD0
	for <lists+bpf@lfdr.de>; Fri,  3 May 2024 16:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDF915531C;
	Fri,  3 May 2024 16:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2D8k96I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02783152DFE
	for <bpf@vger.kernel.org>; Fri,  3 May 2024 16:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714752304; cv=none; b=BQby4Vi9oh2OhEMVes4e34QWF1WL3XCthmH2alezKtYZYLtuBknrRV6/5WtEuu6fF4wIWHXdK7ZoyT/Vlsrg3csx4Yiq9l5kyOhzxv9IXHg7n7YQTkLKXgc5sfX1fqp1Z+rsggastVU+JLRt+vqZiUgafgB4YbaijB/A4a1VkH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714752304; c=relaxed/simple;
	bh=PCF5zlmzfu75XCdLaZC4e+XIh+lc01+D6uyrdSNRP9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yrg0RvX2MxuWHguKBU2Xe23GQMVS1JDz+srRwQ43YB+TlQqwHyapz9qcnyJgoOeT/E8w1GOWTq4GEvhNAEzS77xP/q1X03qZCYtj2v5aA23boLtSZd5q53rDwigB+o5Z5ruUeaj1RDAegBKj+q0x86kMM3biNXBVU6QDt7gKnV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2D8k96I; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41bab13ca80so54754975e9.0
        for <bpf@vger.kernel.org>; Fri, 03 May 2024 09:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714752301; x=1715357101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=df8T08pObf2YEBLZmaNGwhxyjnduSb3dSs26ktTfxkk=;
        b=m2D8k96I92mPTrpr+61qx+W68SN/9U+corj/YDMW8qmHus46kuZv9deF40opl1s2nm
         XHKhTt5NxQLT0hXJ27fPhSyYfgTcZr3SqC7PzD11hFRoNQanAauLg0iaJprn8vBh/7kF
         tJtPW4zs1olKWKO0WyQg7Fvg2WVyeQYqPPFRl+CCg4t55oBwI4h/CkQQYHIHGs52YMAq
         R7NXV1GG9rjVFiMXzmZjzKjPQ5Vi1z25GxUiKrrOfwu4SkHHrUNnz3QfoIHQ0e696JWV
         al50/W3K5Or5/60pvJFfKbJFj15b1ksLjDVOcwJd2x1p5hscFAdn0UWJ2bNpeIlHK2Ze
         mKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714752301; x=1715357101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=df8T08pObf2YEBLZmaNGwhxyjnduSb3dSs26ktTfxkk=;
        b=mGTjo3yIfm8ay2XDGGEoUgF0t+4nGNBlPirqdpVbCCoq6rPmKX17oI6RhO9sGYMp4w
         VeClBFKAV9pGhrqjM+Bt5CLDB/4JSB5lPdXiVpEwjxzEzk4kQNvfxdXojnDrXu+p2nfG
         I4LZeJU+VxPaKq//WIBMJzMukbIfx6dIGGevO+TSGnwerGQ8a69fcWYOGB7BZwf2xutP
         Tu0eHYN4GTgTcVzBVWQ/PhDytUcBe1ic4UlDZhq3pCpE5rYLeXdnysvZmIXxkENlyOLi
         I2xjrx+6zNEkkTSZQklBjpeImdHr09aXl52Vq4BnwadXpo41blgkz40Djusso06BLuA9
         lj9w==
X-Forwarded-Encrypted: i=1; AJvYcCUvqUQX517CG8khflLV/GRS+4IbHU8YOWlP9OKqPIcGUDTiy8ZYbAJp3GLm04e8qa0lZyDge6WMbnbzy6HHtPP9S99v
X-Gm-Message-State: AOJu0YyE29ii4vz5tcD2Vga4tbxI5rLEYsA8aGwl8NOUCSHhlGZgArcu
	5dAjCofLFP8zxi+mXH+TsPE0ltkPQIqnPn9u1LjJ9z/refCXlPnzTfpLKEhFc5sS2TCxlsW/fWI
	/DxRa3WbRfPL28xm8gHBoJbdESs8=
X-Google-Smtp-Source: AGHT+IEG5KeGSgW6hoHcHiUZgt8vAzqm1RvBHbzWDCquc9x7QPfPCGnEfb7PC8RvgNY1qj+bR7nGUi3vOkS5LCm9TP0=
X-Received: by 2002:a05:6000:1111:b0:34d:93a0:96b with SMTP id
 z17-20020a056000111100b0034d93a0096bmr2434960wrw.62.1714752301064; Fri, 03
 May 2024 09:05:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <mb61p1q6k869u.fsf@kernel.org> <CAEf4BzYPQ7QS+UUxYj=okGyKirkqkmT+48DiRQFZ_DeC+zo+cA@mail.gmail.com>
In-Reply-To: <CAEf4BzYPQ7QS+UUxYj=okGyKirkqkmT+48DiRQFZ_DeC+zo+cA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 3 May 2024 09:04:49 -0700
Message-ID: <CAADnVQ+rLCPBKNgSerzS8DKbdHEDgDyqUAjOYA-rP36oXwnY7A@mail.gmail.com>
Subject: Re: On inlining more helpers in the JITs or the verifier
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Puranjay Mohan <puranjay@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 2:22=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, May 2, 2024 at 10:37=E2=80=AFAM Puranjay Mohan <puranjay@kernel.o=
rg> wrote:
> >
> >
> > Hi Everyone,
> >
> > While working on inlining bpf_get_smp_processor_id() in the ARM64 and
> > RISCV JITs, I realized that these archs allow such optimizations becaus=
e
> > they keep some information like the per-cpu offset or the pointer to th=
e
> > task_struct in special system registers.
> >
> > So, I went through the list of all BPF helpers and made a list of
> > helpers that we can inline in these JITs to make their usage much more
> > optimized:
> >
> > I. ARM64 and RISC-V specific optimzations if inlined:
> >
> >     A) Because pointer to tast_struct is available in a register:
> >         1. bpf_get_current_pid_tgid()
> >         2. bpf_get_current_task()
>
> These two are used really frequently, so it might make sense to
> optimize them (and also bpf_get_current_task_btf(), of course), if
> others agree with me.
>
> >         3. bpf_set_retval()
> >         4. bpf_get_retval()
> >         5. bpf_task_pt_regs()
>
> I'm leaning towards saying that probably not, unless we have a really
> good reason to. Inlining is not free in terms of code maintenance and
> complexity, so I wouldn't go and inline everything possible. But maybe
> others have another opinion.
>
>
> >         6. bpf_get_attach_cookie()
>
> definitely no, there are multiple implementations depending on
> specific program type
>
> >
> >     B) Because per_cpu offset is available in a register:
> >         1. bpf_this_cpu_ptr()
>
> maybe, but I don't think we inline at BPF instruction level, so
> inlining in BPF JIT seems premature
>
>
> >         2. bpf_get_numa_node_id()
>
> I'm not sure how actively this is used, so I'd say no to this one as well=
.
>
> >
> >         These can be inlined in the verifier too using the newly
> >         introduced per-cpu instruction.
>
> yep, I'd start with doing BPF assembly inlining for
> bpf_this_cpu_ptr/bpf_per_cpu_ptr, tbh
>
> >
> > II. These are very basic writes, can be inlined in the verifier or the =
JIT:
> >     1. bpf_msg_apply_bytes()
> >     2. bpf_msg_cork_bytes()
> >     3. bpf_set_hash_invalid()
>
> I'd say this is also going overboard with inlining.

+1

simplicity of logic is not a reason to inline it.
I would only inline bpf_get_current_task[_btf]() and do it
in the verifier. JITs should inline only if perf delta
is really significant.
I hope bpf_get_smp_processor_id() will be the only such example.

