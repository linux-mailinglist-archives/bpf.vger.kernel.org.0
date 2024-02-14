Return-Path: <bpf+bounces-22029-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DFA5855466
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 21:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11528286EF3
	for <lists+bpf@lfdr.de>; Wed, 14 Feb 2024 20:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564E313B799;
	Wed, 14 Feb 2024 20:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+Mq+9tD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10686128831
	for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 20:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707944109; cv=none; b=sU4q68r601y5k5QkWaUh7fvdisHoYFSE57/uGby/yD/o5f+cbCsjYGkbtl3CsCXHVOi0DyEroCALs9SygqzIG/H4bhG8e/HbGo5gP1RK9xXDUivfnTQMc7fNaUTr0kXDemKrEkCiubQ/73TWCgdPf7/ZRCjkVZWxhNTUfSVzo58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707944109; c=relaxed/simple;
	bh=/V758drMFZu9Sk75i+SBWIUZ8OvfO1icI5PzUHeoDxs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAooD+wqOVxzsY6uputPD6vUv7utB8wbvKUukmcs2YSRvWgN7OtMpuX5hCb6yduIs6/dOYAY3Nt+7nflvoucaPiKAlYGPa5SBzXC9gDq8OHMJ/49xl2ON+RaWhIOd5b3Ed77oWabfQimdTf5s6MccqfwFhFd9oOqOdBOmUALUS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+Mq+9tD; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d0e520362cso1342731fa.2
        for <bpf@vger.kernel.org>; Wed, 14 Feb 2024 12:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707944106; x=1708548906; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+VxutaxV2hgIlhtVIdq8IVZJxuuaug+2RSfkwoBrzis=;
        b=i+Mq+9tDsaHbJWhZh357ZLRMxqdTvq4i1Ri+V2gctobVqFGmHbElHEQzl3WjbPZ55A
         afUisXsv81hwbY9oVa4rbdX1sFS9uxwXOYrAvqAdFunWM0zfBJpSNGcRUI2r7IgYBch9
         /QXuA052CqM40U9ICRGiyfVPTnxAPwEftbYmhf05O2SSnYiBZkGnr4sReAhwCDVkpI7a
         nNO8+Y7rWiW4As42iIORrluawp6A4Pva28sNnNX35EfZgoQjHJDXT7RO2lZc0MXKrmbH
         8Hnc1HliX4y9uA7KM50IYfiVlnZpWHN+kctMUt/RY5ia/vjnDrMfRW0yOHrPiKvZDhtt
         P/ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707944106; x=1708548906;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+VxutaxV2hgIlhtVIdq8IVZJxuuaug+2RSfkwoBrzis=;
        b=fodfeEjsJDM4kf7wXt3JPOfXBS3HnRF1Prrx+yqV28ZAxgHrguppXAMuHlY6UUAkoy
         7HD/nFEaXbPmbl6YDFPrTH7y+sYYwxEa0cVNC8m5XQv2IX2+l8K8/KpsUnIXiAdDjgiu
         DqycC4NiUa9gngo2wsTi9l3543pDDSazeSDsowbELzP0ErUmEBpsBeSiOru6MmBkzcc8
         um6U1G92mf9aPS9vdUFOripqBfpLOch6CuGr1SDZRbwe0pvY44jQ6ORUg8oSTU/MSdBs
         CxFNJRJIEQZwL7qtQn3IZzVBi/ZDmYZqvpqaFxub7AL4dAE7CJZcbI72W/XbTzI9fh2B
         pjww==
X-Forwarded-Encrypted: i=1; AJvYcCVohL8TrpbjT0MFabZToUux+JowtBkz02xgX4WJwwy1T3S8vNxQLdG88oRjCvxwfSqNGvcxElrWdhNHTHHzHxHUrVeT
X-Gm-Message-State: AOJu0Yx7rUzBIYnpk2M3w1GeVIksWCtfSL42gqCpvQ+IOO0LosndRh8o
	X0M6U5N5EdMvweVJiTSXdhZg6MmkPXa+hw+L5KNIkiYBAXJULfSR
X-Google-Smtp-Source: AGHT+IEyIQMi2UmG2+0NgEsm5uNlvWOPjpMeMk0VtXyAK5GjY1JQ2dbdynpbS4Y6earXNJ09eLRrow==
X-Received: by 2002:a2e:a9a2:0:b0:2d1:1df8:9ddd with SMTP id x34-20020a2ea9a2000000b002d11df89dddmr1773063ljq.27.1707944105642;
        Wed, 14 Feb 2024 12:55:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVxqWwxUz2xVGrpLFayYDPqiRcqyUiV4f+JuDFgvUOhwRmVyOYliZrX2eHXU8bQ0xTq2iHJN5RG6FmjYm7Qc/LdM2B6+ZdB0Ya23r4VYnh+7g2mWQGgT3WcQXDZxB1M6GfGDk478tFoGiFuL2cdmS7EC5MJJNy8TTxvrO5GWNARuBS8D5gevoskc6wzm3ty/Vyq7spegBgAmdE3+VvcqWWBuxTbSQwli2m6JnsPJZUY+ULe9TQJUA5OQfrJPyvOvU8o1I11zjFyKlFSujsFXh+tXvEz+S2O8Ef8KqE/yZ0Yba8nU7zPGmmxEhjvr+OkFrUsXRfYY7HPUeVM8kIfJGNaW7jeRz2NKfp+SnKMmb3n1k1+/8BSSU0m0ngePtn2b57LdqpZ0EqQcG73INZo98nSK8aKbAA7Y81e1B3Q7w==
Received: from krava ([83.240.60.70])
        by smtp.gmail.com with ESMTPSA id p15-20020a05600c1d8f00b0040ecdd672fasm3078104wms.13.2024.02.14.12.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 12:55:05 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 14 Feb 2024 21:55:03 +0100
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Viktor Malik <vmalik@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC bpf-next 0/4] bpf: Add support to attach return prog
 in kprobe multi
Message-ID: <Zc0op6a3ZrI7JD9z@krava>
References: <20240207153550.856536-1-jolsa@kernel.org>
 <CAEf4BzZdPJWUiu9yNMsecB-tq0tHCLhrSF47b=w23fPevg=EWg@mail.gmail.com>
 <ZceWuIgsmiLYyCxQ@krava>
 <CAEf4Bzb6sPXAtDVke=CtCXev0mxhfgEG_O-xUA-e9-8NnbBtJQ@mail.gmail.com>
 <ZctcEpz3fHK4RqUX@krava>
 <CAEf4BzY_UBNe4ONqKGg5VtA-nY-ozgpQ=Du1+8ipQNnZ+JKCew@mail.gmail.com>
 <ZcvadcwSA37sfDk4@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZcvadcwSA37sfDk4@krava>

On Tue, Feb 13, 2024 at 10:09:09PM +0100, Jiri Olsa wrote:
> On Tue, Feb 13, 2024 at 10:20:46AM -0800, Andrii Nakryiko wrote:
> > On Tue, Feb 13, 2024 at 4:09 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > >
> > > On Mon, Feb 12, 2024 at 08:06:06PM -0800, Andrii Nakryiko wrote:
> > >
> > > SNIP
> > >
> > > > > > But the way you implement it with extra flag and extra fd parameter
> > > > > > makes it harder to have a nice high-level support in libbpf (and
> > > > > > presumably other BPF loader libraries) for this.
> > > > > >
> > > > > > When I was thinking about doing something like this, I was considering
> > > > > > adding a new program type, actually. That way it's possible to define
> > > > > > this "let's skip return probe" protocol without backwards
> > > > > > compatibility concerns. It's easier to use it declaratively in libbpf.
> > > > >
> > > > > ok, that seems cleaner.. but we need to use current kprobe programs,
> > > > > so not sure at the moment how would that fit in.. did you mean new
> > > > > link type?
> > > >
> > > > It's kind of a less important detail, actually. New program type would
> > > > allow us to have an entirely different context type, but I think we
> > > > can make do with the existing kprobe program type. We can have a
> > > > separate attach_type and link type, just like multi-kprobe and
> > > > multi-uprobe are still kprobe programs.
> > >
> > > ok, having new attach type on top of kprobe_multi link makes sense
> > >
> > > >
> > > > >
> > > > > > You just declare SEC("kprobe.wrap/...") (or whatever the name,
> > > > > > something to designate that it's both entry and exit probe) as one
> > > > > > program and in the code there would be some way to determine whether
> > > > > > we are in entry mode or exit mode (helper or field in the custom
> > > > > > context type, the latter being faster and more usable, but it's
> > > > > > probably not critical).
> > > > >
> > > > > hum, so the single program would be for both entry and exit probe,
> > > > > I'll need to check how bad it'd be for us, but it'd probably mean
> > > > > just one extra tail call, so it's likely ok
> > > >
> > > > I guess, I don't know what you are doing there :) I'd recommend
> > > > looking at utilizing BPF global subprogs instead of tail calls, if
> > > > your kernel allows for that, as that's a saner way to scale BPF
> > > > verification.
> > >
> > > ok, we should probably do that.. given this enhancement will be
> > > available on latest kernel anyway, we could use global subprogs
> > > as well
> > >
> > > the related bpftrace might be bit more challenging.. will have to
> > > generate program calling entry or return program now, but seems
> > > doable of course
> > 
> > So you want users to still have separate kprobe and kretprobe in
> > bpftrace, but combine them into this kwrapper transparently? It does
> 
> no I meant I'd need to generate the wrapper program for the new
> interface.. which is extra compared to current bpftrace changes
> 
> > seem doable, but hopefully we'll be able to write kwrapper programs in
> > bpftrace directly as well.
> 
> yes, it should be fine
> 
> SNIP
> 
> > > >
> > > > Yes, I realize special-casing zero might be a bit inconvenient, but I
> > > > think simplicity trumps a potential for zero to be a valid value (and
> > > > there are always ways to work around zero as a meaningful value).
> > > >
> > > > Now, in more complicated cases 8 bytes of temporary session state
> > > > isn't enough, just like BPF cookie being 8 byte (read-only) value
> > > > might not be enough. But the solution is the same as with the BPF
> > > > cookie. You just use those 8 bytes as a key into ARRAY/HASHMAP/whatnot
> > > > storage. It's simple and fast enough for pretty much any case.
> > >
> > > I was recently asked for a way to have function arguments available
> > > in the return kprobe as it is in fexit programs (which was not an
> > > option to use, because we don't have fast multi attach for it)
> > >
> > > using the hash map to store arguments and storing its key in the
> > > session data might be solution for this
> > 
> > if you are ok using hashmap keyed by tid, you can do it today without
> > any kernel changes. With session cookie you'll be able to utilize
> > faster ARRAY map (by building a simple ID allocator to get a free slot
> > in ARRAY map).
> 
> ok
> 
> SNIP
> 
> > > > I bet there is something similar in the kretprobe case, where we can
> > > > carve out 8 bytes and pass it to both entry and exit parts of kwrapper
> > > > program.
> > >
> > > for kprobes.. both kprobe and kprobe_multi/fprobe use rethook to invoke
> > > return probes, so I guess we could use it and store that shared data
> > > in there
> > >
> > > btw Masami is in process of removing rethook from kprobe_multi/fprobe,
> > > as part of migrating fprobe on top of ftrace [0]
> > >
> > > but instead the rethook I think there'll be some sort of shadow stack/data
> > > area accessible from both entry and return probes, that we could use
> > 
> > ok, cool. We also need to be careful to not share session cookie
> > between unrelated programs. E.g., if two independent kwrapper programs
> > are attached to the same function, they should each have their own
> > cookie. Otherwise it's not clear how to build anything reliable on top
> > of that, tbh. This might be a problem, though, right?
> 
> IIRC it's tracer specific data, the shadow stack data should be unique
> for tracer and its called function, but I'll double check on that

Masami,
we recently discussed the possibility to store data between entry/return probe,
IIUC your current patchset [0] allows that, but it seems to be shared across all
the tracers for the given function (__ftrace_return_to_handler).. is the plan to
make the shadow stack per tracer and function? /cc Steven

thanks,
jirka


[0] https://lore.kernel.org/bpf/170723204881.502590.11906735097521170661.stgit@devnote2/

