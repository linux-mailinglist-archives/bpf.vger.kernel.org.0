Return-Path: <bpf+bounces-21871-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 483218539C7
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 19:21:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F323B2877B4
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 18:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1892F605CA;
	Tue, 13 Feb 2024 18:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBHGHG5D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9AC605C6
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 18:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707848460; cv=none; b=BXHnezcYb2aYKpYypSKSFpf69Lj/Q78k7NsHbszJVspBsgrpaPJaRfYLlk8JB1ShWo7F2f0xVTGJBGgU3+uaS2k89RMVmuVosRDFOoDEu4IJGoNYw/g92lxMQR82BygDJyLUu6Ybff/jFL95yJ5pn8ZmXlMFyUe2NhL+qkDB5sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707848460; c=relaxed/simple;
	bh=E4+Qpd4UVeL2w77Lfx1HvMKeezapOPAJPg0poUrdtT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u6tV7/aicx6aiXyGPJTegDay7AT1q3X44v6EhEPBoiw+RIqNBuow2u9kA1SB4QTwdMzA4YawM7oxOEqIHUP0OKglq0vQkMcfQhqDt1DjAMmHBwknisTGY5DCpcjqjhv6bUM6ZHEjYcdO1tD5XLQNDpDQcGl2MzteZdlHBxqh0pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBHGHG5D; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5d8df34835aso13053a12.0
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 10:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707848458; x=1708453258; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMCDWe4nTrur1kVGwJ31A6yxxlrw9DIaTAO8cCqFrxo=;
        b=LBHGHG5D8DWkW7UH19Le9dEBng3fSfaUjDThgn/QrKY6CoF1GoTsGDQXdTtMYOjMXa
         tjjYhxfFM4ITcQkfzklycryO1IAMmE5t/TkPA+wojMCHyDKifySM4dYdVT1sKVpNOJ5V
         gWIieQfGR1OIbkI9VoO+bSXfeKGzlZtOkOsidTUE4JgxLTUDeHmQU8GrNuf6xrDOCVSp
         PfDjp3QootEYuLALdxza6Q1O6FrAO4FC0Ntov+x9nbHA0EwwnaG5XlM1ZjNyu7vv5vBK
         ORL7cmv6v67qKPniIBO4hQNV5u3udQSVW0eBQQo9p2PcZZkSpMp9OpSvfCgDghckvh9U
         7+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707848458; x=1708453258;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WMCDWe4nTrur1kVGwJ31A6yxxlrw9DIaTAO8cCqFrxo=;
        b=VhSvDwAcNXOVss8q9b7rQ4Ax0PMM1OoyfP7w6SFKEOQFb00pSL41SsNOCwy9jFksKf
         U5ICZEd3bNHkIsnp/X657m0OSdAqk000jo7V0R/Y9qC2Rz5fDtGHIaITOz7qj0umEpf3
         OyXnt0tnxmdbG2EGOH32XkPzdwBzM6vRxHa/xUnsMnE9VaBx2PutoWSkdIw84Ese/tH6
         2VObc2CevvcOAZuGEDTCibQg2unovFCUKFXXGwmXn6doo4J4ZtC/f4DYfkF/SFH8vbNp
         om7DkNH0z6rLoqvSiIDrdrlNk0ZFSuAW9oahSpjavtQPXcBFP7GI8wwLB0DXcjpHZ5yz
         Zfvw==
X-Forwarded-Encrypted: i=1; AJvYcCVVzAU7eQ3bOwBQ7/X9txRbQQFnAjOXVt95iQr7hPX8Q0Zou3xdehbIkq6gIcAP58so0JHpHPJRl9thfeUv/fV+Vk1M
X-Gm-Message-State: AOJu0Yz19NRloeZJmndwnJ4yVRdYJGl5navweK45IKyNmZfU7u3oppUb
	DBpqBZbz8Sy/Eq/Ze2CR58yqoYY4zptHGSNWfOz7eT51S4wRSb6KHNkqVC6dSjt+g21XZB7Mdlu
	8UECsKM8llTAtL/ZxJT07o1SqI6ism03n
X-Google-Smtp-Source: AGHT+IEX67UJ4DpBnqQCJzmzzZGrGhQsU2226gA02Y/LATUfMVay9lSFkqzm0KZx1sqAX8+44nWkPXUj0nSVsvkVxa8=
X-Received: by 2002:a17:90a:6c22:b0:296:c2a1:d05e with SMTP id
 x31-20020a17090a6c2200b00296c2a1d05emr343980pjj.2.1707848458195; Tue, 13 Feb
 2024 10:20:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207153550.856536-1-jolsa@kernel.org> <CAEf4BzZdPJWUiu9yNMsecB-tq0tHCLhrSF47b=w23fPevg=EWg@mail.gmail.com>
 <ZceWuIgsmiLYyCxQ@krava> <CAEf4Bzb6sPXAtDVke=CtCXev0mxhfgEG_O-xUA-e9-8NnbBtJQ@mail.gmail.com>
 <ZctcEpz3fHK4RqUX@krava>
In-Reply-To: <ZctcEpz3fHK4RqUX@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 13 Feb 2024 10:20:46 -0800
Message-ID: <CAEf4BzY_UBNe4ONqKGg5VtA-nY-ozgpQ=Du1+8ipQNnZ+JKCew@mail.gmail.com>
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

On Tue, Feb 13, 2024 at 4:09=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Mon, Feb 12, 2024 at 08:06:06PM -0800, Andrii Nakryiko wrote:
>
> SNIP
>
> > > > But the way you implement it with extra flag and extra fd parameter
> > > > makes it harder to have a nice high-level support in libbpf (and
> > > > presumably other BPF loader libraries) for this.
> > > >
> > > > When I was thinking about doing something like this, I was consider=
ing
> > > > adding a new program type, actually. That way it's possible to defi=
ne
> > > > this "let's skip return probe" protocol without backwards
> > > > compatibility concerns. It's easier to use it declaratively in libb=
pf.
> > >
> > > ok, that seems cleaner.. but we need to use current kprobe programs,
> > > so not sure at the moment how would that fit in.. did you mean new
> > > link type?
> >
> > It's kind of a less important detail, actually. New program type would
> > allow us to have an entirely different context type, but I think we
> > can make do with the existing kprobe program type. We can have a
> > separate attach_type and link type, just like multi-kprobe and
> > multi-uprobe are still kprobe programs.
>
> ok, having new attach type on top of kprobe_multi link makes sense
>
> >
> > >
> > > > You just declare SEC("kprobe.wrap/...") (or whatever the name,
> > > > something to designate that it's both entry and exit probe) as one
> > > > program and in the code there would be some way to determine whethe=
r
> > > > we are in entry mode or exit mode (helper or field in the custom
> > > > context type, the latter being faster and more usable, but it's
> > > > probably not critical).
> > >
> > > hum, so the single program would be for both entry and exit probe,
> > > I'll need to check how bad it'd be for us, but it'd probably mean
> > > just one extra tail call, so it's likely ok
> >
> > I guess, I don't know what you are doing there :) I'd recommend
> > looking at utilizing BPF global subprogs instead of tail calls, if
> > your kernel allows for that, as that's a saner way to scale BPF
> > verification.
>
> ok, we should probably do that.. given this enhancement will be
> available on latest kernel anyway, we could use global subprogs
> as well
>
> the related bpftrace might be bit more challenging.. will have to
> generate program calling entry or return program now, but seems
> doable of course

So you want users to still have separate kprobe and kretprobe in
bpftrace, but combine them into this kwrapper transparently? It does
seem doable, but hopefully we'll be able to write kwrapper programs in
bpftrace directly as well.

>
> >
> > >
> > > >
> > > > Another frequently requested feature and a very common use case is =
to
> > > > measure duration of the function, so if we have a custom type, we c=
an
> > > > have a field to record entry timestamp and let user calculate
> > >
> > > you mean bpf program context right?
> >
> > Yes, when I was writing that I was imagining a new context type with ne=
w fields.
> >
> > But thinking about this a bit more, I like a slightly different
> > approach now. Instead of having a new context type, kernel capturing
> > timestamps, etc, what if we introduce a concept of "a session". This
> > paired kprobe+kretprobe (and same for uprobe+uretprobe) share a common
> > session. So, say, if we are tracing kernel function abc() and we have
> > our kwrapper (let's call it that for now, kwrapper and uwrapper?)
> > program attached to abc, we have something like this:
> >
> > 1) abc() is called
> > 2) we intercept it at its entry, initialize "session"
> > 3) call our kwrapper program in entry mode
> > 4) abc() proceeds, until return
> > 5) our kwrapper program is called in exit mode
> > 6) at this point the session has ended
> >
> > If abc() is called again or in parallel on another CPU, each such
> > abc() invocation (with kwrapper prog) has its own session state.
> >
> > Now, it all sounds scary, but a session could be really just a 8 byte
> > value that has to last for the duration of a single kprobe+kretprobe
> > execution.
> >
> > Imagine we introduce just one new kfunc that would be usable from
> > kwrapper and uwrapper programs:
> >
> > u64 *bpf_get_session_cookie(void);
> >
> > It returns a pointer to an 8-byte slot which initially is set to zero
> > by kernel (before kprobe/entry part). And then the program can put
> > anything into it. Either from entry (kprobe/uprobe) or exit
> > (kretprobe/uretprobe) executions. Whatever value was stored in entry
> > mode will still be there in exit mode as well.
> >
> > This gives a lot of flexibility without requiring the kernel to do
> > anything expensive.
> >
> > E.g., it's easy to detect if kwrapper program is an entry call or exit =
call:
> >
> > u64 *cookie =3D bpf_get_session_cookie();
> > if (*cookie =3D=3D 0) {
> >   /* entry mode */
> >   *cookie =3D 1;
> > } else {
> >   /* exit mode */
> > }
> >
> > Or if we wanted to measure function duration/latency:
> >
> > u64 *cookie =3D bpf_get_session_cookie();
> > if (*cookie =3D=3D 0) {
> >   *cookie =3D bpf_get_ktime_ns();
> > } else {
> >   u64 duration =3D bpf_get_ktime_ns() - *cookie;
> >   /* output duration somehow */
> > }
> >
> > Yes, I realize special-casing zero might be a bit inconvenient, but I
> > think simplicity trumps a potential for zero to be a valid value (and
> > there are always ways to work around zero as a meaningful value).
> >
> > Now, in more complicated cases 8 bytes of temporary session state
> > isn't enough, just like BPF cookie being 8 byte (read-only) value
> > might not be enough. But the solution is the same as with the BPF
> > cookie. You just use those 8 bytes as a key into ARRAY/HASHMAP/whatnot
> > storage. It's simple and fast enough for pretty much any case.
>
> I was recently asked for a way to have function arguments available
> in the return kprobe as it is in fexit programs (which was not an
> option to use, because we don't have fast multi attach for it)
>
> using the hash map to store arguments and storing its key in the
> session data might be solution for this

if you are ok using hashmap keyed by tid, you can do it today without
any kernel changes. With session cookie you'll be able to utilize
faster ARRAY map (by building a simple ID allocator to get a free slot
in ARRAY map).

>
> >
> >
> > Now, how do we implement this storage session? I recently looked into
> > uprobe/uretprobe implementation, and I know that for uretprobes there
> > is a dynamically allocated uretprobe_instance (or whatever the name)
> > allocated for each runtime invocation of uretprobe. We can use that.
> > We'll need to allocate this instance a bit earlier, before uprobe part
> > of uwrapper BPF program has to be executed, initialize session cookie
> > to zero, and store pointer to this memory in bpf_run_ctx (just like we
> > do for BPF cookie).
>
> I think you refer to the return_instance and it seems like we could use i=
t,
> I'll check on that
>

yep, probably

> >
> > I bet there is something similar in the kretprobe case, where we can
> > carve out 8 bytes and pass it to both entry and exit parts of kwrapper
> > program.
>
> for kprobes.. both kprobe and kprobe_multi/fprobe use rethook to invoke
> return probes, so I guess we could use it and store that shared data
> in there
>
> btw Masami is in process of removing rethook from kprobe_multi/fprobe,
> as part of migrating fprobe on top of ftrace [0]
>
> but instead the rethook I think there'll be some sort of shadow stack/dat=
a
> area accessible from both entry and return probes, that we could use

ok, cool. We also need to be careful to not share session cookie
between unrelated programs. E.g., if two independent kwrapper programs
are attached to the same function, they should each have their own
cookie. Otherwise it's not clear how to build anything reliable on top
of that, tbh. This might be a problem, though, right?

>
> jirka
>
>
> [0] https://lore.kernel.org/bpf/170723204881.502590.11906735097521170661.=
stgit@devnote2/
>
> >
> > So anyways, might need some internal refactoring, but seems very
> > doable and will give a lot of power and flexibility for tracing use
> > cases.
> >
> > It would be cool to also have a similar fentry/fexit combo with "BPF
> > session cookie", but that's something we can think about separately,
> > probably.
> >
> >
> > >
> > > > duration, if necessary. Without this users have to pay a bunch of
> > > > extra overhead to record timestamp and put it into hashmap (keyed b=
y
> > > > thread id) or thread local storage (even if they have no other use =
for
> > > > thread local storage).
> > >
> > > sounds good
> > >
> > > >
> > > > Also, consider that a similar concept is applicable to uprobes and =
we
> > > > should do that as well, in similar fashion. And the above approach
> > > > works for both kprobe/kretprobe and uprobe/uretprobe cases, because
> > > > they have the same pt_regs data structure as a context (even if for
> > > > exit probes most of the values of pt_regs are not that meaningful).
> > >
> > > ok, that seems useful for uprobes as well
> >
> > yes, absolutely
> >
> > >
> > > btw I have another unrelated change in stash that that let you choose
> > > the bpf_prog_active or prog->active re-entry check before program is
> > > executed in krobe_multi link.. I also added extra flag, and it still
> > > seems like good idea to me, thoughts? ;-)
> > >
> >
> > no specific opinion on this from my side, I guess
> >
> > > >
> > > > So anyways, great feature, but let's discuss end-to-end usability
> > > > story before we finalize the implementation?
> > >
> > > yep, it does say RFC in the subject ;-)
> > >
> > > >
> > > >
> >
> > [...]

