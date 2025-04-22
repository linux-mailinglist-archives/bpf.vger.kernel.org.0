Return-Path: <bpf+bounces-56366-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA43A95C21
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 04:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46357169026
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 02:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BF5EED6;
	Tue, 22 Apr 2025 02:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CtOP+/aV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE236DCE1
	for <bpf@vger.kernel.org>; Tue, 22 Apr 2025 02:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745289079; cv=none; b=poADjNFU1cYsWy+O2Lz+9JDs+xy/Rfx7T6FBDenOXlDvrVMmS3zUhv6dgKokEFQpZ2AIIdqpQWM2IuZwYAeUWC/iztzHdgqTSPCyKqN/SM2J0REvI+AAYCGi3i1WxBY4DgnHG4TlY3TWgz808xK7r/lVhCKI3jYokDGFDFFwOdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745289079; c=relaxed/simple;
	bh=K0l5Abxa4mYn6gl/1HABqFv4gsbm7nqrV9/JQ3+Mu4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ktBBe5SkrIuICPIH8xP0llJde2jLCrVUETezQDWdSbwGRraz+OqhfmvDufrXlcOYkfP1UyZ5vG13uuPP61AMMOzhawZ8ernmfWzxH3PU8BCvhaGFxvCXInyA4o+aHMKATPeb4Fqnfcf9ojvrYICAoAOK16T89P++znC8FI92kKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CtOP+/aV; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5f6222c6c4cso6183145a12.1
        for <bpf@vger.kernel.org>; Mon, 21 Apr 2025 19:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745289075; x=1745893875; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OPch3wKHDxa1XG+X2Q5ONzr4pc6DEqnWKKmMgHkHiQg=;
        b=CtOP+/aVUwOUG4740bgqRV0NQ+XhFcMCqj0jOGFPsT7gL3juerBhKoP0p3dIwe1GPf
         UxH+yqhZyIb59IRDPiNjYJA2Q3RiZglZe4qpw81OiZ+gBC9MPO1MDyECHnCCJxJZ4Ypi
         s7FsTolLIsomH8N9WVy2c1x6yjK/H8bMx3IOiVTNNazSROSe0yle3UhhZn+WMjXMST3Y
         yMm44LbL1LY2vUUPD5P+6Za6ouTFkMUdH9Uhi4d7cemSZd/iPfQgoNRlOsyPohSBT0cY
         MkBUUECaQW9HfHUO2b9QtnLhQ+HTr2hwep4xCfVIAb8REqzLdujW4TOhnTJnhf2FPELz
         CcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745289075; x=1745893875;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OPch3wKHDxa1XG+X2Q5ONzr4pc6DEqnWKKmMgHkHiQg=;
        b=dfvFSGIU1jjLZKHIMTb/5T8yJvXQom+tkqpeHtMh1WFeItKa59nYpRVSapGDQ7JfyU
         KW6dXrc4ZJ1nm6maqz6WSzFfh1rJS16E3L7El9OT9KoKwf9JLkcevnWKwzEA2YbBXACd
         o0fzxYr4WjrVjDeVfk2p+8Q02REyyfuX4MiNGU1kbbDPlr15eHZN8yYDjaIFEqcaZi1A
         hXe4fta0n3zXxjpzlimmAoPs6dZ9+i2Bd5G+O4RkAQtiN7eeU4q59bx+/SfUk0QaJ1x+
         CzpwEDZ6brVGhPSJJ6Cryl0xvXIn/7Pm0nTvJb2L3i5C/Wh0c4Vxsbh3NmGhPuRD9grt
         tCkw==
X-Forwarded-Encrypted: i=1; AJvYcCXKXCYep5itsYybyGzJRMbraQ1QqqhfmFz9mb9z3GQ6QRvlpr4JmA/VrzsA0ApSqVs6gvA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzclFHj4brAQbCl9alkuhWCnqguEGkhcNs1RH/3XArUosUrPt0+
	Y693f33TE8OjIwxH3nGzPVjeuSi7UM5SlXELIbWiyzVNnnjZefpSeIA9oN1F7ipboX90PZaeTv8
	r6tgrrGeCcXsowWUIFb023SDx3QEmMq3zYLc=
X-Gm-Gg: ASbGncu14N/GvSBSYPCvpHjMhNpQx+STSRKFJvHF6xW2eeEGsd81GJlCOCUGaOt+AFa
	mHpfIHAKonAiWH8d6OToDp8FWdspObOevrhxgnBCMFbfpCFUVSQJ4Uo++duc8avmuarGpIvs0Mu
	eNuPSzX8WWhXqLKNz8uQBExd3MEjSJBbe+THha5wD8Y2o=
X-Google-Smtp-Source: AGHT+IHMosYl2706yB50E2cVy7jxbEaVao1FM6F2XI28wN/6Kq1FeAich0If9ySl03Yy/uaFHQHTB38opvc0XMXZGog=
X-Received: by 2002:a17:907:3cd5:b0:ac7:b368:b193 with SMTP id
 a640c23a62f3a-acb74b7e64bmr1163377166b.27.1745289074497; Mon, 21 Apr 2025
 19:31:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250414161443.1146103-1-memxor@gmail.com> <20250414161443.1146103-8-memxor@gmail.com>
 <m2plhbu68v.fsf@gmail.com> <CAP01T77jqjoO3pc-V7qvsck1A9KJ-1u60ryouLL68ctHz2M=mQ@mail.gmail.com>
 <CAADnVQKGxPb4OjT0mNcKzUzs=_gtKmNFy77zEn2qJ7vaVnmRBA@mail.gmail.com>
In-Reply-To: <CAADnVQKGxPb4OjT0mNcKzUzs=_gtKmNFy77zEn2qJ7vaVnmRBA@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 22 Apr 2025 04:30:37 +0200
X-Gm-Features: ATxdqUFaJu4WSuM9StbQuzsX4VdPkfw35ws1SN7mlZMpHR9bpkQ6np1cW860B2E
Message-ID: <CAP01T77CSZN28Fde9DH43CBZw0kf=LiWMcOTixbbLfFz21vRFw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next/net v1 07/13] bpf: Introduce per-prog
 stdout/stderr streams
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Barret Rhoden <brho@google.com>, kkd@meta.com, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Apr 2025 at 03:42, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> > > > +BTF_KFUNCS_START(stream_consumer_kfunc_set)
> > > > +BTF_ID_FLAGS(func, bpf_stream_next_elem_batch, KF_ACQUIRE | KF_RET_NULL | KF_TRUSTED_ARGS)
> > > > +BTF_ID_FLAGS(func, bpf_stream_free_elem_batch, KF_RELEASE)
> > > > +BTF_ID_FLAGS(func, bpf_stream_next_elem, KF_ACQUIRE | KF_RET_NULL | KF_TRUSTED_ARGS)
> > > > +BTF_ID_FLAGS(func, bpf_stream_free_elem, KF_RELEASE)
> > > > +BTF_ID_FLAGS(func, bpf_prog_stream_get, KF_ACQUIRE | KF_RET_NULL)
> > > > +BTF_ID_FLAGS(func, bpf_prog_stream_put, KF_RELEASE)
> > > > +BTF_KFUNCS_END(stream_consumer_kfunc_set)
> > >
> > > This is a complicated API.
> > > If we anticipate that users intend to write this info to ring buffers
> > > maybe just provide a function doing that and do not expose complete API?
> >
> > I don't think anyone will use these functions directly, though they
> > can if they want to.
> > It's meant to be hidden behind bpftool, and macros to print stuff like
> > bpf_printk().
>
> I have to agree with Eduard here.
> The api feels overdesigned. I don't see how it can be reused
> anywhere outside of bpftool.

Can you explain why?
Apart from syscall prog requirement which is easy to lift (but didn't
bother for RFC).

> Instead of introducing mem_slice concept and above kfuncs,
> let's have one special kfunc that will take prog_id, stream_id
> and will move things into dynptr returning EAGAIN/ENOENT when necessary.
> EFAULT shouldn't be possible when the whole
>   SEC("syscall")
>   int bpftool_dump_prog_stream(void *ctx) {..}
> will be one kfunc.
> bpf_stream_dtor_ids won't be needed either.
> Hard coding such a big logic into one kfunc is not pretty,
> and smaller kfuncs/building blocks would be preferred any day,
> but these stream_consumer_kfunc_set just don't look reusable.

I don't follow. How is "shove all messages into ringbuf" more reusable?
I can sympathize with the complexity argument Eduard made, ideally
we'd have one pop() operation to pull out things.
We can discuss how to make things simpler.

With some documentation, it is not hard to follow:
Everytime you consume something from a stream, you splice out a batch
of N messages, you can then splice out each message individually from
a batch.
Both the batch and individual elements need to be freed. You can keep
processing the batch until it's finished, but the better idea is to
pace oneself and do N at a time.

In user space, you usually fill up your buffer's length (say
PAGE_SIZE) when reading something, then delimit and parse and draw
message boundaries when parsing.

You can flip the API in this patch around and use it to stream things
into the program.
We just need to add one more element in prog->aux->stream[BPF_STDIN = 0].
Even without that, you can make it work on stdout. The writing is bidirectional.

User space side can obtain the stream of a prog and printk to it.
Kernel side can pop and parse messages.
Probably not a bright idea to do so when in the fast path of the
kernel to read strings, but in other cases, why not?
It can certainly make sense for self contained programs that want to
consume options from the cmdline generically.
The generic loader can just forward the string when invoked in user
space into the stream, and call some init/main function for the
program before attaching it.
Your BPF init/main gets either raw stream, or prepared argv, argc
blocks that the loader's infra can set up for you.

At that point all logic in the program can be self-contained, you can
probably just write everything in BPF C, including setting config
options etc.
There would be no need to put these strings into a ringbuf, it would
just be for the BPF side to parse and make sense of.

But anyway, I will not push back too much. If everyone thinks "stream
data to ringbuf kfunc" is the way to go, I'll make the change in v2.

