Return-Path: <bpf+bounces-21841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BC9853039
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 13:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B2FE28A6FE
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 12:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B7D3D966;
	Tue, 13 Feb 2024 12:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KgY2LAi2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71B438DD5
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 12:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707826200; cv=none; b=oOQLyXaU72VIun9kFWgHd7ixiiUgm3jmqyA03kBGFugpWT7wQ6f8fBstXW3Cgu5URkE5BjIHbt2L59+KTTw6vh70Ya7H/GkIyvLOwi5XUeVO0lthz/mZA3zHF7QX3kuSb6nqW5Tz3sRov8cOOAwoUhgQvDlvf1T3KNJn3y9j6tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707826200; c=relaxed/simple;
	bh=57Flo6mvELkrEZ2ywjnspRj1AcLIzpcQ9r5zowshJ5c=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RzvsfEX8wdncBxUeYJxsjFs674H91O981LXhT7GuxFpEQ9W0z/xZG8okWntQKwBYPOetdqQh6Nc/glyUmoNw/OQjl8r1VMOLxFUr20u/m1DCTx/MyIe12NMTYrfYy/Qfb9XKkmSWysFaFhK0famSkoVpld6dcTXjS20sDVKGnv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KgY2LAi2; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3566c0309fso518704066b.1
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 04:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707826197; x=1708430997; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TcED3Do+9sfLY5n+pZWyKVSZZ/thd5xao6sle07KKgc=;
        b=KgY2LAi2+ORAfuqbqRPAVdf41dTJgjTeuVngjb6xTvvFhqw5ijk0WrT8gdpaaIoKCI
         xiturfbhIeMmjeZEHY9YhjI/0htsZAMb9sxZm4BWNG1vaJM/Uu7saJhlg9jG13DRp5w8
         oh7MOz36Iktyp6D+ZgHq5uwO4y6WYnPGEWMaZHoS1OZYr4+ds0bCq0kvhR+WkP/Ugwe1
         O+rdo0odiNrjZ/VcNLWyPWQOyg7BRQI3D194fuBcx+OkJJWdbnfpcjfneRo1sUPNAGa5
         QBo7z0QeE/9OCrhlo5VmyRZ+jsLBjfwdQcaY2Wq7lTzmkD4U/aipf0GjxRjnhsJ/b4jS
         haVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707826197; x=1708430997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcED3Do+9sfLY5n+pZWyKVSZZ/thd5xao6sle07KKgc=;
        b=mGL595PEVrYKooI23XhgR0TirG1iBHr5fBn0wnrOqghWxgVtad4A0SMksh2L3Pujeu
         yYakD0IejOMkvh2J7doM6HOp6NAbxuBiBxaiddFGU0VS1BOMUxs43zOZFf2yVTOgUZsw
         1OePoq/73aJkl6qyG8zo7g7vKN/axUkZaPvxy8ahfgL3VVSFHH7dmgUprOz6W56lUlm8
         kLoNQ83hAUmSSnm/fMWaAfOv9G75CrXfQI7xWNHrN1Lh+2ABKSgPA5FcypY+3wG0v/QX
         5dvioBRRae8LrgK1JVDVIPXbMZ+JATQiI4WsJ46uNjvV2RSpbiq2S2ZzPjmOqjfD9Ozw
         rpEg==
X-Forwarded-Encrypted: i=1; AJvYcCWMGIfqtUGW3c+UPU3xUgL+VSXierUKfoAHvrnPoVBrjoHPzWFKUoVqIOHSyMjxh0BInw5NAT/ntpGhgtxNXl1U3CIA
X-Gm-Message-State: AOJu0YyhIh4q0WJa2uIPD/b7FsEZZWowi4YXLOOJWgAFy2YA4DhgiiuI
	nnYklnFlhYsdg8MTU0DLgbhTw8E7hY8xo9xt4gXEehWhLVsJ14Jl
X-Google-Smtp-Source: AGHT+IGtt1LLbuCv7cK460NDnv0S4mfyWQMSEGLSSYd7pjNrTr7zGuqOHxFojEuxJg49jE74RyHtzw==
X-Received: by 2002:a17:906:5ad8:b0:a3c:9bc7:7a0e with SMTP id x24-20020a1709065ad800b00a3c9bc77a0emr4055577ejs.9.1707826196723;
        Tue, 13 Feb 2024 04:09:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVWuakFXi/8hkQW/GkTX1XYHvHR05Cw6gOU81JIwnru3KCark/M98EGoH+QQo1unltO5RNbnHN/BcxU0EXPji6gl1AVIjFFCLkOIJekjFjpT+Tv+jzyFbxQKqB9IxuRTUFannWArCT93iuSdszzT6Ip3pOY960QiXw8YRmeq+TJQ2MHk+bJPByUeP+cfpw01icqpP6KUovBSR9DLu1xUYzAS6fzhYyN2un/d1wUu69hdOZ+h1ce1dEDzPPC/JDv/jTfyBmjS5uShlcavc/P/V6PaK7KWWJOKAgTeZih3Nhtu/BZWLkBHWPvALuXapdpR7XWFzlSYMrJXsmGMfoW/IYiGlAMabBFjp+jGWAET2DnB0SeYnEZZmxLQVM9NL1PupTlkFMYLipzTw==
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id hu18-20020a170907a09200b00a3d1cce7c6fsm144780ejc.62.2024.02.13.04.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 04:09:56 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 13 Feb 2024 13:09:54 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH RFC bpf-next 0/4] bpf: Add support to attach return prog
 in kprobe multi
Message-ID: <ZctcEpz3fHK4RqUX@krava>
References: <20240207153550.856536-1-jolsa@kernel.org>
 <CAEf4BzZdPJWUiu9yNMsecB-tq0tHCLhrSF47b=w23fPevg=EWg@mail.gmail.com>
 <ZceWuIgsmiLYyCxQ@krava>
 <CAEf4Bzb6sPXAtDVke=CtCXev0mxhfgEG_O-xUA-e9-8NnbBtJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzb6sPXAtDVke=CtCXev0mxhfgEG_O-xUA-e9-8NnbBtJQ@mail.gmail.com>

On Mon, Feb 12, 2024 at 08:06:06PM -0800, Andrii Nakryiko wrote:

SNIP

> > > But the way you implement it with extra flag and extra fd parameter
> > > makes it harder to have a nice high-level support in libbpf (and
> > > presumably other BPF loader libraries) for this.
> > >
> > > When I was thinking about doing something like this, I was considering
> > > adding a new program type, actually. That way it's possible to define
> > > this "let's skip return probe" protocol without backwards
> > > compatibility concerns. It's easier to use it declaratively in libbpf.
> >
> > ok, that seems cleaner.. but we need to use current kprobe programs,
> > so not sure at the moment how would that fit in.. did you mean new
> > link type?
> 
> It's kind of a less important detail, actually. New program type would
> allow us to have an entirely different context type, but I think we
> can make do with the existing kprobe program type. We can have a
> separate attach_type and link type, just like multi-kprobe and
> multi-uprobe are still kprobe programs.

ok, having new attach type on top of kprobe_multi link makes sense

> 
> >
> > > You just declare SEC("kprobe.wrap/...") (or whatever the name,
> > > something to designate that it's both entry and exit probe) as one
> > > program and in the code there would be some way to determine whether
> > > we are in entry mode or exit mode (helper or field in the custom
> > > context type, the latter being faster and more usable, but it's
> > > probably not critical).
> >
> > hum, so the single program would be for both entry and exit probe,
> > I'll need to check how bad it'd be for us, but it'd probably mean
> > just one extra tail call, so it's likely ok
> 
> I guess, I don't know what you are doing there :) I'd recommend
> looking at utilizing BPF global subprogs instead of tail calls, if
> your kernel allows for that, as that's a saner way to scale BPF
> verification.

ok, we should probably do that.. given this enhancement will be
available on latest kernel anyway, we could use global subprogs
as well

the related bpftrace might be bit more challenging.. will have to
generate program calling entry or return program now, but seems
doable of course

> 
> >
> > >
> > > Another frequently requested feature and a very common use case is to
> > > measure duration of the function, so if we have a custom type, we can
> > > have a field to record entry timestamp and let user calculate
> >
> > you mean bpf program context right?
> 
> Yes, when I was writing that I was imagining a new context type with new fields.
> 
> But thinking about this a bit more, I like a slightly different
> approach now. Instead of having a new context type, kernel capturing
> timestamps, etc, what if we introduce a concept of "a session". This
> paired kprobe+kretprobe (and same for uprobe+uretprobe) share a common
> session. So, say, if we are tracing kernel function abc() and we have
> our kwrapper (let's call it that for now, kwrapper and uwrapper?)
> program attached to abc, we have something like this:
> 
> 1) abc() is called
> 2) we intercept it at its entry, initialize "session"
> 3) call our kwrapper program in entry mode
> 4) abc() proceeds, until return
> 5) our kwrapper program is called in exit mode
> 6) at this point the session has ended
> 
> If abc() is called again or in parallel on another CPU, each such
> abc() invocation (with kwrapper prog) has its own session state.
> 
> Now, it all sounds scary, but a session could be really just a 8 byte
> value that has to last for the duration of a single kprobe+kretprobe
> execution.
> 
> Imagine we introduce just one new kfunc that would be usable from
> kwrapper and uwrapper programs:
> 
> u64 *bpf_get_session_cookie(void);
> 
> It returns a pointer to an 8-byte slot which initially is set to zero
> by kernel (before kprobe/entry part). And then the program can put
> anything into it. Either from entry (kprobe/uprobe) or exit
> (kretprobe/uretprobe) executions. Whatever value was stored in entry
> mode will still be there in exit mode as well.
> 
> This gives a lot of flexibility without requiring the kernel to do
> anything expensive.
> 
> E.g., it's easy to detect if kwrapper program is an entry call or exit call:
> 
> u64 *cookie = bpf_get_session_cookie();
> if (*cookie == 0) {
>   /* entry mode */
>   *cookie = 1;
> } else {
>   /* exit mode */
> }
> 
> Or if we wanted to measure function duration/latency:
> 
> u64 *cookie = bpf_get_session_cookie();
> if (*cookie == 0) {
>   *cookie = bpf_get_ktime_ns();
> } else {
>   u64 duration = bpf_get_ktime_ns() - *cookie;
>   /* output duration somehow */
> }
> 
> Yes, I realize special-casing zero might be a bit inconvenient, but I
> think simplicity trumps a potential for zero to be a valid value (and
> there are always ways to work around zero as a meaningful value).
> 
> Now, in more complicated cases 8 bytes of temporary session state
> isn't enough, just like BPF cookie being 8 byte (read-only) value
> might not be enough. But the solution is the same as with the BPF
> cookie. You just use those 8 bytes as a key into ARRAY/HASHMAP/whatnot
> storage. It's simple and fast enough for pretty much any case.

I was recently asked for a way to have function arguments available
in the return kprobe as it is in fexit programs (which was not an
option to use, because we don't have fast multi attach for it)

using the hash map to store arguments and storing its key in the
session data might be solution for this

> 
> 
> Now, how do we implement this storage session? I recently looked into
> uprobe/uretprobe implementation, and I know that for uretprobes there
> is a dynamically allocated uretprobe_instance (or whatever the name)
> allocated for each runtime invocation of uretprobe. We can use that.
> We'll need to allocate this instance a bit earlier, before uprobe part
> of uwrapper BPF program has to be executed, initialize session cookie
> to zero, and store pointer to this memory in bpf_run_ctx (just like we
> do for BPF cookie).

I think you refer to the return_instance and it seems like we could use it,
I'll check on that

> 
> I bet there is something similar in the kretprobe case, where we can
> carve out 8 bytes and pass it to both entry and exit parts of kwrapper
> program.

for kprobes.. both kprobe and kprobe_multi/fprobe use rethook to invoke
return probes, so I guess we could use it and store that shared data
in there

btw Masami is in process of removing rethook from kprobe_multi/fprobe,
as part of migrating fprobe on top of ftrace [0]

but instead the rethook I think there'll be some sort of shadow stack/data
area accessible from both entry and return probes, that we could use

jirka


[0] https://lore.kernel.org/bpf/170723204881.502590.11906735097521170661.stgit@devnote2/

> 
> So anyways, might need some internal refactoring, but seems very
> doable and will give a lot of power and flexibility for tracing use
> cases.
> 
> It would be cool to also have a similar fentry/fexit combo with "BPF
> session cookie", but that's something we can think about separately,
> probably.
> 
> 
> >
> > > duration, if necessary. Without this users have to pay a bunch of
> > > extra overhead to record timestamp and put it into hashmap (keyed by
> > > thread id) or thread local storage (even if they have no other use for
> > > thread local storage).
> >
> > sounds good
> >
> > >
> > > Also, consider that a similar concept is applicable to uprobes and we
> > > should do that as well, in similar fashion. And the above approach
> > > works for both kprobe/kretprobe and uprobe/uretprobe cases, because
> > > they have the same pt_regs data structure as a context (even if for
> > > exit probes most of the values of pt_regs are not that meaningful).
> >
> > ok, that seems useful for uprobes as well
> 
> yes, absolutely
> 
> >
> > btw I have another unrelated change in stash that that let you choose
> > the bpf_prog_active or prog->active re-entry check before program is
> > executed in krobe_multi link.. I also added extra flag, and it still
> > seems like good idea to me, thoughts? ;-)
> >
> 
> no specific opinion on this from my side, I guess
> 
> > >
> > > So anyways, great feature, but let's discuss end-to-end usability
> > > story before we finalize the implementation?
> >
> > yep, it does say RFC in the subject ;-)
> >
> > >
> > >
> 
> [...]

