Return-Path: <bpf+bounces-21828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3848527EA
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 05:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6778EB2368C
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 04:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E82BA92E;
	Tue, 13 Feb 2024 04:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GriTrCrg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E9915CC
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 04:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707797181; cv=none; b=MUQCeRbcgTPQP3QEC3oBN9FpFDzvlNCfwWH3MgUpvydsNhWkfeR79JWgi2kG9aVQ2E6j3PDVtNpAmB7NC2ldOZNmioRpGN6dn2siNGcrZXUcPoQQMhoHw2AgslmpLmnEQCOXw5sl2VlcSUVCgWspk38wZ7AJ1nnUMhxKWFHqxec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707797181; c=relaxed/simple;
	bh=QSRZrMgXrYAh+oyC+6liJnnDctZ3hBciAcSb2hT/a4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YvZccKj+yoBH7kfJTBA1wmDZKxjLtVIazDscpYdkxGsZpqHCPxzgNPBG/iz5Ex2AU2slnU6LOxx+qeIxATRVO7K/iabXFDNcV3VYqpCCIhMJoEX7+bvHQuSTY2hxJOW82b3Scr6f2eAt9vVP86P5GSzN2hhpx92JWdsEjXjcu3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GriTrCrg; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e0eacc5078so795979b3a.0
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 20:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707797178; x=1708401978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7xHDs2qhDh3noqWDEYCdw06CL601S2uA5IGFDOqJyU=;
        b=GriTrCrg4LVyxCyTOvtrDQ9vxOzNw1wzrXFdZjGsdRMZEL7DQixta5I8N1d8KlYAfg
         scq8+n0PyB8rj64Y/FgadTyHs8XXZnSETPgucT8P1wtxdJbM4AYasePeyRZYjd/AN++z
         2kwjuyzkEpk5YGO7U3zUWYjP10vRPyKwzKiaip5/YJWx5df7dR8YFNWKxfFXpIzqQKxq
         pmMcbCV0qK7tIpAQ7+k7xMP/nd3yX4B2G1qmA2mMZrwwTkR6beQSEr5cFtxGwJB3Ro/X
         ChGgOOEGd1tUsbZHOr60N/Pp3pYGg9cpu+uDMECo/jwNLxlq9nejN9fE0KQ66HGGz+pV
         eMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707797178; x=1708401978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S7xHDs2qhDh3noqWDEYCdw06CL601S2uA5IGFDOqJyU=;
        b=iIIYXnZ4Ifh+pBNo7DpYHDUJ9dJGv7Cppv5msQbwUb3zd7mBXoVDUgStd9PzDt4lGr
         S9hyNMdmPFcLEOwEHNbQGhgfhsh9xdWSmd1xZwswhbGZoLfjYDB3KaMfVcgtW2PxaMz9
         8SD2WDX1vZR2LbKlSdjTeoti301V/vtw76762BJvCpmXbYzvSfBIGZnNCthu3jPMJTVK
         DPb+HyryY1/7qaKQeNF2B/FikRzJ9kh8gUTtq/rDuPhqb9ZHZiv+614dpWOkTceBFqkh
         Y6jkT8ELxndlwx953Pp/UyRBkIAUbBMWSDUoz87iONZ9hq/i0mmfwBoPEz7UA1DgBsfu
         iS0A==
X-Gm-Message-State: AOJu0YwRyR9C+WfwRWhTgGUrUP1Y3Tj7zkVs6PK3kBkUQd1BCWwRrdqp
	7qmNhi4I6w/3S1OdHkWABTQPUakf7KH+N1xdNi6ljgdgSSQ5rzkW/5MRNeieG3M9oD1Thzfz98M
	4qEUbQkv0dj/J+MwRbyVZ0GkpqPU=
X-Google-Smtp-Source: AGHT+IHmh7M5Pk7VzErNgJ99HfbdfqbJiPFfgWOKR3ffl7gC9caxQ+qWLWT527LzT6bzGHMH7Po1SB+snNi3KV+IlJE=
X-Received: by 2002:a17:90b:38c1:b0:297:228a:fa6c with SMTP id
 nn1-20020a17090b38c100b00297228afa6cmr3989147pjb.3.1707797178520; Mon, 12 Feb
 2024 20:06:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207153550.856536-1-jolsa@kernel.org> <CAEf4BzZdPJWUiu9yNMsecB-tq0tHCLhrSF47b=w23fPevg=EWg@mail.gmail.com>
 <ZceWuIgsmiLYyCxQ@krava>
In-Reply-To: <ZceWuIgsmiLYyCxQ@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 12 Feb 2024 20:06:06 -0800
Message-ID: <CAEf4Bzb6sPXAtDVke=CtCXev0mxhfgEG_O-xUA-e9-8NnbBtJQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 0/4] bpf: Add support to attach return prog
 in kprobe multi
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Viktor Malik <vmalik@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 10, 2024 at 7:31=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Thu, Feb 08, 2024 at 11:35:18AM -0800, Andrii Nakryiko wrote:
> > On Wed, Feb 7, 2024 at 7:35=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wro=
te:
> > >
> > > hi,
> > > adding support to attach both entry and return bpf program on single
> > > kprobe multi link.
> > >
> > > Having entry together with return probe for given function is common
> > > use case for tetragon, bpftrace and most likely for others.
> > >
> > > At the moment if we want both entry and return probe to execute bpf
> > > program we need to create two (entry and return probe) links. The lin=
k
> > > for return probe creates extra entry probe to setup the return probe.
> > > The extra entry probe execution could be omitted if we had a way to
> > > use just single link for both entry and exit probe.
> > >
> > > In addition it's possible to control the execution of the return prob=
e
> > > with the return value of the entry bpf program. If the entry program
> > > returns 0 the return probe is installed and executed, otherwise it's
> > > skip.
> > >
> >
> > In general, I think this is a very useful ability to have a combined
> > entry/return program.
>
> great, thanks
>
> >
> > But the way you implement it with extra flag and extra fd parameter
> > makes it harder to have a nice high-level support in libbpf (and
> > presumably other BPF loader libraries) for this.
> >
> > When I was thinking about doing something like this, I was considering
> > adding a new program type, actually. That way it's possible to define
> > this "let's skip return probe" protocol without backwards
> > compatibility concerns. It's easier to use it declaratively in libbpf.
>
> ok, that seems cleaner.. but we need to use current kprobe programs,
> so not sure at the moment how would that fit in.. did you mean new
> link type?

It's kind of a less important detail, actually. New program type would
allow us to have an entirely different context type, but I think we
can make do with the existing kprobe program type. We can have a
separate attach_type and link type, just like multi-kprobe and
multi-uprobe are still kprobe programs.

>
> > You just declare SEC("kprobe.wrap/...") (or whatever the name,
> > something to designate that it's both entry and exit probe) as one
> > program and in the code there would be some way to determine whether
> > we are in entry mode or exit mode (helper or field in the custom
> > context type, the latter being faster and more usable, but it's
> > probably not critical).
>
> hum, so the single program would be for both entry and exit probe,
> I'll need to check how bad it'd be for us, but it'd probably mean
> just one extra tail call, so it's likely ok

I guess, I don't know what you are doing there :) I'd recommend
looking at utilizing BPF global subprogs instead of tail calls, if
your kernel allows for that, as that's a saner way to scale BPF
verification.

>
> >
> > Another frequently requested feature and a very common use case is to
> > measure duration of the function, so if we have a custom type, we can
> > have a field to record entry timestamp and let user calculate
>
> you mean bpf program context right?

Yes, when I was writing that I was imagining a new context type with new fi=
elds.

But thinking about this a bit more, I like a slightly different
approach now. Instead of having a new context type, kernel capturing
timestamps, etc, what if we introduce a concept of "a session". This
paired kprobe+kretprobe (and same for uprobe+uretprobe) share a common
session. So, say, if we are tracing kernel function abc() and we have
our kwrapper (let's call it that for now, kwrapper and uwrapper?)
program attached to abc, we have something like this:

1) abc() is called
2) we intercept it at its entry, initialize "session"
3) call our kwrapper program in entry mode
4) abc() proceeds, until return
5) our kwrapper program is called in exit mode
6) at this point the session has ended

If abc() is called again or in parallel on another CPU, each such
abc() invocation (with kwrapper prog) has its own session state.

Now, it all sounds scary, but a session could be really just a 8 byte
value that has to last for the duration of a single kprobe+kretprobe
execution.

Imagine we introduce just one new kfunc that would be usable from
kwrapper and uwrapper programs:

u64 *bpf_get_session_cookie(void);

It returns a pointer to an 8-byte slot which initially is set to zero
by kernel (before kprobe/entry part). And then the program can put
anything into it. Either from entry (kprobe/uprobe) or exit
(kretprobe/uretprobe) executions. Whatever value was stored in entry
mode will still be there in exit mode as well.

This gives a lot of flexibility without requiring the kernel to do
anything expensive.

E.g., it's easy to detect if kwrapper program is an entry call or exit call=
:

u64 *cookie =3D bpf_get_session_cookie();
if (*cookie =3D=3D 0) {
  /* entry mode */
  *cookie =3D 1;
} else {
  /* exit mode */
}

Or if we wanted to measure function duration/latency:

u64 *cookie =3D bpf_get_session_cookie();
if (*cookie =3D=3D 0) {
  *cookie =3D bpf_get_ktime_ns();
} else {
  u64 duration =3D bpf_get_ktime_ns() - *cookie;
  /* output duration somehow */
}

Yes, I realize special-casing zero might be a bit inconvenient, but I
think simplicity trumps a potential for zero to be a valid value (and
there are always ways to work around zero as a meaningful value).

Now, in more complicated cases 8 bytes of temporary session state
isn't enough, just like BPF cookie being 8 byte (read-only) value
might not be enough. But the solution is the same as with the BPF
cookie. You just use those 8 bytes as a key into ARRAY/HASHMAP/whatnot
storage. It's simple and fast enough for pretty much any case.


Now, how do we implement this storage session? I recently looked into
uprobe/uretprobe implementation, and I know that for uretprobes there
is a dynamically allocated uretprobe_instance (or whatever the name)
allocated for each runtime invocation of uretprobe. We can use that.
We'll need to allocate this instance a bit earlier, before uprobe part
of uwrapper BPF program has to be executed, initialize session cookie
to zero, and store pointer to this memory in bpf_run_ctx (just like we
do for BPF cookie).

I bet there is something similar in the kretprobe case, where we can
carve out 8 bytes and pass it to both entry and exit parts of kwrapper
program.

So anyways, might need some internal refactoring, but seems very
doable and will give a lot of power and flexibility for tracing use
cases.

It would be cool to also have a similar fentry/fexit combo with "BPF
session cookie", but that's something we can think about separately,
probably.


>
> > duration, if necessary. Without this users have to pay a bunch of
> > extra overhead to record timestamp and put it into hashmap (keyed by
> > thread id) or thread local storage (even if they have no other use for
> > thread local storage).
>
> sounds good
>
> >
> > Also, consider that a similar concept is applicable to uprobes and we
> > should do that as well, in similar fashion. And the above approach
> > works for both kprobe/kretprobe and uprobe/uretprobe cases, because
> > they have the same pt_regs data structure as a context (even if for
> > exit probes most of the values of pt_regs are not that meaningful).
>
> ok, that seems useful for uprobes as well

yes, absolutely

>
> btw I have another unrelated change in stash that that let you choose
> the bpf_prog_active or prog->active re-entry check before program is
> executed in krobe_multi link.. I also added extra flag, and it still
> seems like good idea to me, thoughts? ;-)
>

no specific opinion on this from my side, I guess

> >
> > So anyways, great feature, but let's discuss end-to-end usability
> > story before we finalize the implementation?
>
> yep, it does say RFC in the subject ;-)
>
> >
> >

[...]

