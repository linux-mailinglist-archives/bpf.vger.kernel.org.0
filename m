Return-Path: <bpf+bounces-56438-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEF8A973DD
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 19:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D95111887E23
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 17:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38C21DE3D1;
	Tue, 22 Apr 2025 17:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oa7hBmyV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2181D5ADE
	for <bpf@vger.kernel.org>; Tue, 22 Apr 2025 17:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745343870; cv=none; b=O5O+uspaMH/cjpyQJVb+kOSyMcjhwD4c3ZBwtWCnvldVktA5BS64k9465rTWAzLebxHpqGIo1kg83Q8hQ+sMYkHf2cRs8tOZmyRdV/mqecqJu0c+CTLGkbdQSEu+Ih3tHJP5W/p4qAqCTteGOTPpM+9KH1vARG0L09MluwYemp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745343870; c=relaxed/simple;
	bh=1Tsgz89hxqVmLPnJOKAv5NnQC9xuLx8jVrNAv46vY9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CGUCy2Frp/EWXYNk7yEFEItYycOqn8R/WBggnKpAPjJRYo7jUvtvIJdKsgOBMQ0kGgf0ND2IFJhm0w17+xEwqovB3Wsxob/VS93N9FJaQJ79sHs6J/z7clKYYpu4XXzGix05tMhZktfTvppRgqhN/+QV9c5d/hga8uJN+Y27J1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oa7hBmyV; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39ac56756f6so5423364f8f.2
        for <bpf@vger.kernel.org>; Tue, 22 Apr 2025 10:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745343867; x=1745948667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpNk9CBsF4w5uVhr7TPE4gAF+ybJur+aULImNz2EYAI=;
        b=Oa7hBmyVqNlej4OPl0y+4LTQr6DGc5sXaeyBvW3CtFzBPgtX9b5glaCl42mDLgS5A7
         tYNCX+Twmdfac2BjsDAfypWgQVGE4ku5adMuXEDOIEqPzuKm1I1Gx5pqlmuNsWf6bw4E
         YDh4LhPlEMVZbLwBlfPZ7P6HeC2wugnt4KOkzLpuxbXSxUVYT6G2JACDxU43oxW/V76n
         ZnqXbkFp1QA9xS8e8tVolSjeV6IvVzovqo2GIq8ouXhW/23PUfb6F9B4ZwKONibjFuat
         q3TzRs/NnJeoH+pQ3X0YXaVTcTu1nehmYMEzurkUwM2e7BAr9MoRpQGgh6lc4BX2PTCY
         2fKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745343867; x=1745948667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zpNk9CBsF4w5uVhr7TPE4gAF+ybJur+aULImNz2EYAI=;
        b=Z9lW8fas2q7iNwWZcswlcJwz+Rq0yNKkRU8RwTm4PEMe2HKYIjCv7vNvFu3j6RtuE4
         d9BC083YeMwvODYCkUwPvGzgWVqM47KsrObPMQOSl9bBq9zncF8XgkxGTXeRTYCcy5I1
         m0Ghrg3B8CnJOVKcTUdX952fZ2b9TIdUcRngADmF4YD5UsTxNUEqeUnDtC1sMjP+QAU2
         0KfR548n5zwWJOhrhAeuhraUN61bvHRt4tZMF8tiJW129ofwJy4KqPoC41vuybDwbanI
         B/t9CVDz/M3ohX34x9k9+af37QaO0Bk34hveAZLFpSjA9CDvTdtOZW0jm/BZVi4qHucq
         qNGw==
X-Forwarded-Encrypted: i=1; AJvYcCVGLDxjckzaTmHQ8DiQOBzTmJr/2Lk8z0dOnrZ5vuosXv7XZ/PdiOk9fJcco1bUqY4iSgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxctNLKCoWt5y6SGGtq/pI4pHM/ZgWWqnZee1HBYsZO68Js3PUW
	FPWd+3BNJz2VL+m60PZF15pS3isLYy7NItxhpaZ5/DrnxESl60f4AEUFoBCVZbUi1ll9BKrt4kc
	OcoRU1YOpi6QO80s/60XIh9W9NC4=
X-Gm-Gg: ASbGncszSYpNLYj01ZZLcJTlKnGn8smHfbbdWju0RWHod0PugRfPUlXLOG2c2DD5E17
	8C+WqJtSFx2JW0IFrAE6dDdB++1yYKYVkPwFN0cMZagLka0WN5LcPHLJlDQt+g5xLJJYDqC0HV/
	fTDEVDur8dqWBlUUPc1wr9QT11rn7Zm6a8zPFPGA==
X-Google-Smtp-Source: AGHT+IFp49OEeJKn5lA03WIOY9thAApc/quMDQh6NoQemsoE9laZw2xpjwLgl5NFqH/0kGKxCs6nG4tGSWYVTUAa9Rs=
X-Received: by 2002:a05:6000:2911:b0:39a:c9d9:8f95 with SMTP id
 ffacd0b85a97d-39efbb05554mr12620481f8f.52.1745343866866; Tue, 22 Apr 2025
 10:44:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414161443.1146103-1-memxor@gmail.com> <20250414161443.1146103-8-memxor@gmail.com>
 <m2plhbu68v.fsf@gmail.com> <CAP01T77jqjoO3pc-V7qvsck1A9KJ-1u60ryouLL68ctHz2M=mQ@mail.gmail.com>
 <CAADnVQKGxPb4OjT0mNcKzUzs=_gtKmNFy77zEn2qJ7vaVnmRBA@mail.gmail.com> <CAP01T77CSZN28Fde9DH43CBZw0kf=LiWMcOTixbbLfFz21vRFw@mail.gmail.com>
In-Reply-To: <CAP01T77CSZN28Fde9DH43CBZw0kf=LiWMcOTixbbLfFz21vRFw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 22 Apr 2025 10:44:15 -0700
X-Gm-Features: ATxdqUGDrPaUvewKt0aXIRz5sHnFS8kVCrXiZazmE72kUTon3MhEdoVfNGjs_fQ
Message-ID: <CAADnVQJouV-9E5cT67aJ_6nu2TL1pLjYLQjUq923L9wf+Sdgug@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next/net v1 07/13] bpf: Introduce per-prog
 stdout/stderr streams
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, kkd@meta.com, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 7:31=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Tue, 22 Apr 2025 at 03:42, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > > > > +BTF_KFUNCS_START(stream_consumer_kfunc_set)
> > > > > +BTF_ID_FLAGS(func, bpf_stream_next_elem_batch, KF_ACQUIRE | KF_R=
ET_NULL | KF_TRUSTED_ARGS)
> > > > > +BTF_ID_FLAGS(func, bpf_stream_free_elem_batch, KF_RELEASE)
> > > > > +BTF_ID_FLAGS(func, bpf_stream_next_elem, KF_ACQUIRE | KF_RET_NUL=
L | KF_TRUSTED_ARGS)
> > > > > +BTF_ID_FLAGS(func, bpf_stream_free_elem, KF_RELEASE)
> > > > > +BTF_ID_FLAGS(func, bpf_prog_stream_get, KF_ACQUIRE | KF_RET_NULL=
)
> > > > > +BTF_ID_FLAGS(func, bpf_prog_stream_put, KF_RELEASE)
> > > > > +BTF_KFUNCS_END(stream_consumer_kfunc_set)
> > > >
> > > > This is a complicated API.
> > > > If we anticipate that users intend to write this info to ring buffe=
rs
> > > > maybe just provide a function doing that and do not expose complete=
 API?
> > >
> > > I don't think anyone will use these functions directly, though they
> > > can if they want to.
> > > It's meant to be hidden behind bpftool, and macros to print stuff lik=
e
> > > bpf_printk().
> >
> > I have to agree with Eduard here.
> > The api feels overdesigned. I don't see how it can be reused
> > anywhere outside of bpftool.
>
> Can you explain why?

Because I don't see a second user for these bpf_stream_* fetchers.
A special prog embedded in bpftool will be the only one afaict.

> Apart from syscall prog requirement which is easy to lift (but didn't
> bother for RFC).
>
> > Instead of introducing mem_slice concept and above kfuncs,
> > let's have one special kfunc that will take prog_id, stream_id
> > and will move things into dynptr returning EAGAIN/ENOENT when necessary=
.
> > EFAULT shouldn't be possible when the whole
> >   SEC("syscall")
> >   int bpftool_dump_prog_stream(void *ctx) {..}
> > will be one kfunc.
> > bpf_stream_dtor_ids won't be needed either.
> > Hard coding such a big logic into one kfunc is not pretty,
> > and smaller kfuncs/building blocks would be preferred any day,
> > but these stream_consumer_kfunc_set just don't look reusable.
>
> I don't follow. How is "shove all messages into ringbuf" more reusable?
> I can sympathize with the complexity argument Eduard made, ideally
> we'd have one pop() operation to pull out things.

That's exactly what I'm proposing. One pop-like kfunc
with prog_id, stream_id arguments.

> We can discuss how to make things simpler.
>
> With some documentation, it is not hard to follow:
> Everytime you consume something from a stream, you splice out a batch
> of N messages, you can then splice out each message individually from
> a batch.
> Both the batch and individual elements need to be freed. You can keep
> processing the batch until it's finished, but the better idea is to
> pace oneself and do N at a time.

Sure. These details can be hidden in pop() kfunc.

> In user space, you usually fill up your buffer's length (say
> PAGE_SIZE) when reading something, then delimit and parse and draw
> message boundaries when parsing.
>
> You can flip the API in this patch around and use it to stream things
> into the program.
> We just need to add one more element in prog->aux->stream[BPF_STDIN =3D 0=
].
> Even without that, you can make it work on stdout. The writing is bidirec=
tional.

Hmm. I don't see the writing part here.
Currently it only consumes llist.
There is bpf_stream_vprintk() to write into it from bpf prog.
That part makes sense.
bpf_stream_push_str() can also be a kfunc, but the operation
here is _push_.
imo it makes sense to pair it with single _pop_,
instead of next_elem, free_elem

> User space side can obtain the stream of a prog and printk to it.
> Kernel side can pop and parse messages.
> Probably not a bright idea to do so when in the fast path of the
> kernel to read strings, but in other cases, why not?

One bpf prog does bpf_stream_vprintk() while another pop-like.
That makes sense.
The manual iterator over messages that requires kptr_xchg
to be correct is what I see as overdesign.

> But anyway, I will not push back too much. If everyone thinks "stream
> data to ringbuf kfunc" is the way to go, I'll make the change in v2.

That's not what I'm suggesting. stream is a concept makes sense.
bpf_stream_vprintk() also makes sense, and it will work to push
things from "user space bpf prog" into stdin of other bpf prog,
and to print into stdout from that other bpf prog.

