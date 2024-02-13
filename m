Return-Path: <bpf+bounces-21896-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1F5853CFB
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 22:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 809F6B287A6
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 21:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D30061695;
	Tue, 13 Feb 2024 21:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eF624UXc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F166166D
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 21:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858554; cv=none; b=kB/LuUJNAWB1CAyDaNQniFA+LYs+65nDpg+4ashIq/yzf5npNvarA2NM4w/pLTD+J4EbVvVWtPuEIt+hLxcgnyp34pAs5DVFjXu2ok9FzRZmQ8eixQNWI4/i6iEDteuL5dqyT3Q82jDsJMqbjtmuLd2dHIULtoghg2r7PHnDga8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858554; c=relaxed/simple;
	bh=uXJ3VW6ttGBp/pbdABPLWM7AHvh+V1BMPzxn4kHehDc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcZFmWq1W8lfhgWdDrUfPOu2nr6/MFb/dXCinRM7Gmq4uNXPYeNKT3O9OoXrPW0l4mkAEH/lrWEtCeccYWywP+axJ0i8GJ2WEzzmzTkzHRqLwXFo4sC/Ms82oJZfDgX0nz05lBCOF/SqgDfWOmPLv4Px0GDXHPiL9J+T6BnEdl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eF624UXc; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41102f140b4so10074735e9.2
        for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 13:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707858551; x=1708463351; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PzfoaM1567Bb0GBaOzj52WBx64hNw7OtSaaNo8rx5Ag=;
        b=eF624UXcwuAexhlFyfPwBN+DgDUGQsWE+qiTKPdOXQUIAXuVo80sCDiqS8SbwTQX59
         YoJee/DG6wmhYxXSHOkdxNPXmQNHegJB0Xkjc/NRT8r4LajoBQq5TehBqbPXa8Drms7k
         b6mLhYvCEA2Mk/Ni2J01WsYr9XmsFN1uodSan0FPh4tiSgunydFL8SO+llM93mAovwFF
         o2pRPFkFt7nwdcp0EvLIAbLfTlqSSBi9193gitnmhPXRkJI/8093B6R1ZwhpAMCVsZvw
         XcDZypfF2HClN6MOdD6IMchgAiw7WWI8EPMeKeO3jsoMrNJBsJmoQbyHsTEnf4ChNyGe
         24zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707858551; x=1708463351;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PzfoaM1567Bb0GBaOzj52WBx64hNw7OtSaaNo8rx5Ag=;
        b=em15VxHIekOALIFRUcxBmsNgPNpSbTyA5HeByeoxCqtAMpn24NfLHvxCkiJssgBGyp
         S/mLx1C3kriiXgaEVupk5qIrYXa6poMSVyqszWjLKsC7aTOj7qtjiJs9To6YSLw9BAZ2
         28SDpxEay9Z1pqR43lPCy+aYZXarapdR39nK2AKrxb+NPFLx5L/7MQxUtRRUl5RwdkKV
         2Bnhgeo0r7oTUWuYQSLLwGrjNZm0ByP4K5ROP5kFhFMkESbY+4nn5aHmFvs+Kmot/C1T
         oZpTk0WWeHVjqlYJY/NgoEnhN3cv2pSdENWZQbzLJ0BpxPhbtOwCu5AfVK7RAgSsDdMl
         ZL6w==
X-Forwarded-Encrypted: i=1; AJvYcCV+9BfWfoN7ii+k6bY6wxfNWdgydKbclPhnHNgQV+pHOR9O+OwOhzDp3hbIAwzdhvrYGpZekrVcBcSiliYD8A0pNMOt
X-Gm-Message-State: AOJu0Yz1wcLjMDz8Ci5d3RSF6OSRlnj4ljmj00/WbbCjlqM75igOsLWI
	OfhX9W5bFuR3ATm5213rQp05QabiEQstHln9QFQXxLkMPM3CQeU0
X-Google-Smtp-Source: AGHT+IEZcPC1DfnInxMapP28osmHBF8t8aouiXMxPYRUPAart9QvK96TogUmxQKFwNxUC2zH0JH0BQ==
X-Received: by 2002:a05:600c:190a:b0:410:1da3:2ccf with SMTP id j10-20020a05600c190a00b004101da32ccfmr652122wmq.21.1707858551068;
        Tue, 13 Feb 2024 13:09:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVijdxkZMwA/TAXAqqxtHlQPf3wmgIMG1qnl3gyDna7WaCR1dh+JVEZjn5k1yW4VDe8LMi4PaPuNqOx7uTKNKhyViam2+Zxo9fI+OzsPRlmSe8jPnBzCcMxE8SmqGFQlnTJy4tN+juBuY18bqnpVXfvODyZRp/iNuiUYeg3J4PDSz+L9WAWFU9tNZxMyYbUFlcxQ96J4AuEkKEV7y0KDD1B+MdiqlcYgIGnnhni7xFx95JVvuuOKPnxsCGldExkytFTsTxM06ViUxsSgIWhn6QZJPDc6L+p5wmVAH38+T6EpLUZi+kkvTiFQiEUYGJLAby3IrSc+oM+90+oxazR+FNingxR7HssuisuTctZ7FSN+3uSI48gCyKaCc5stEiP0zf2BDvESLiZrA==
Received: from krava ([83.240.60.124])
        by smtp.gmail.com with ESMTPSA id m6-20020a7bcb86000000b00410df4bf22esm6314338wmi.38.2024.02.13.13.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 13:09:10 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 13 Feb 2024 22:09:09 +0100
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
Message-ID: <ZcvadcwSA37sfDk4@krava>
References: <20240207153550.856536-1-jolsa@kernel.org>
 <CAEf4BzZdPJWUiu9yNMsecB-tq0tHCLhrSF47b=w23fPevg=EWg@mail.gmail.com>
 <ZceWuIgsmiLYyCxQ@krava>
 <CAEf4Bzb6sPXAtDVke=CtCXev0mxhfgEG_O-xUA-e9-8NnbBtJQ@mail.gmail.com>
 <ZctcEpz3fHK4RqUX@krava>
 <CAEf4BzY_UBNe4ONqKGg5VtA-nY-ozgpQ=Du1+8ipQNnZ+JKCew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzY_UBNe4ONqKGg5VtA-nY-ozgpQ=Du1+8ipQNnZ+JKCew@mail.gmail.com>

On Tue, Feb 13, 2024 at 10:20:46AM -0800, Andrii Nakryiko wrote:
> On Tue, Feb 13, 2024 at 4:09 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Mon, Feb 12, 2024 at 08:06:06PM -0800, Andrii Nakryiko wrote:
> >
> > SNIP
> >
> > > > > But the way you implement it with extra flag and extra fd parameter
> > > > > makes it harder to have a nice high-level support in libbpf (and
> > > > > presumably other BPF loader libraries) for this.
> > > > >
> > > > > When I was thinking about doing something like this, I was considering
> > > > > adding a new program type, actually. That way it's possible to define
> > > > > this "let's skip return probe" protocol without backwards
> > > > > compatibility concerns. It's easier to use it declaratively in libbpf.
> > > >
> > > > ok, that seems cleaner.. but we need to use current kprobe programs,
> > > > so not sure at the moment how would that fit in.. did you mean new
> > > > link type?
> > >
> > > It's kind of a less important detail, actually. New program type would
> > > allow us to have an entirely different context type, but I think we
> > > can make do with the existing kprobe program type. We can have a
> > > separate attach_type and link type, just like multi-kprobe and
> > > multi-uprobe are still kprobe programs.
> >
> > ok, having new attach type on top of kprobe_multi link makes sense
> >
> > >
> > > >
> > > > > You just declare SEC("kprobe.wrap/...") (or whatever the name,
> > > > > something to designate that it's both entry and exit probe) as one
> > > > > program and in the code there would be some way to determine whether
> > > > > we are in entry mode or exit mode (helper or field in the custom
> > > > > context type, the latter being faster and more usable, but it's
> > > > > probably not critical).
> > > >
> > > > hum, so the single program would be for both entry and exit probe,
> > > > I'll need to check how bad it'd be for us, but it'd probably mean
> > > > just one extra tail call, so it's likely ok
> > >
> > > I guess, I don't know what you are doing there :) I'd recommend
> > > looking at utilizing BPF global subprogs instead of tail calls, if
> > > your kernel allows for that, as that's a saner way to scale BPF
> > > verification.
> >
> > ok, we should probably do that.. given this enhancement will be
> > available on latest kernel anyway, we could use global subprogs
> > as well
> >
> > the related bpftrace might be bit more challenging.. will have to
> > generate program calling entry or return program now, but seems
> > doable of course
> 
> So you want users to still have separate kprobe and kretprobe in
> bpftrace, but combine them into this kwrapper transparently? It does

no I meant I'd need to generate the wrapper program for the new
interface.. which is extra compared to current bpftrace changes

> seem doable, but hopefully we'll be able to write kwrapper programs in
> bpftrace directly as well.

yes, it should be fine

SNIP

> > >
> > > Yes, I realize special-casing zero might be a bit inconvenient, but I
> > > think simplicity trumps a potential for zero to be a valid value (and
> > > there are always ways to work around zero as a meaningful value).
> > >
> > > Now, in more complicated cases 8 bytes of temporary session state
> > > isn't enough, just like BPF cookie being 8 byte (read-only) value
> > > might not be enough. But the solution is the same as with the BPF
> > > cookie. You just use those 8 bytes as a key into ARRAY/HASHMAP/whatnot
> > > storage. It's simple and fast enough for pretty much any case.
> >
> > I was recently asked for a way to have function arguments available
> > in the return kprobe as it is in fexit programs (which was not an
> > option to use, because we don't have fast multi attach for it)
> >
> > using the hash map to store arguments and storing its key in the
> > session data might be solution for this
> 
> if you are ok using hashmap keyed by tid, you can do it today without
> any kernel changes. With session cookie you'll be able to utilize
> faster ARRAY map (by building a simple ID allocator to get a free slot
> in ARRAY map).

ok

SNIP

> > > I bet there is something similar in the kretprobe case, where we can
> > > carve out 8 bytes and pass it to both entry and exit parts of kwrapper
> > > program.
> >
> > for kprobes.. both kprobe and kprobe_multi/fprobe use rethook to invoke
> > return probes, so I guess we could use it and store that shared data
> > in there
> >
> > btw Masami is in process of removing rethook from kprobe_multi/fprobe,
> > as part of migrating fprobe on top of ftrace [0]
> >
> > but instead the rethook I think there'll be some sort of shadow stack/data
> > area accessible from both entry and return probes, that we could use
> 
> ok, cool. We also need to be careful to not share session cookie
> between unrelated programs. E.g., if two independent kwrapper programs
> are attached to the same function, they should each have their own
> cookie. Otherwise it's not clear how to build anything reliable on top
> of that, tbh. This might be a problem, though, right?

IIRC it's tracer specific data, the shadow stack data should be unique
for tracer and its called function, but I'll double check on that

jirka

