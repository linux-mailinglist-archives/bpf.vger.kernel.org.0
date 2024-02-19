Return-Path: <bpf+bounces-22253-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D2885A3AC
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 13:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D5991F219ED
	for <lists+bpf@lfdr.de>; Mon, 19 Feb 2024 12:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7392E65B;
	Mon, 19 Feb 2024 12:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpbXgD5/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AFD2E642
	for <bpf@vger.kernel.org>; Mon, 19 Feb 2024 12:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708346591; cv=none; b=Km+Oo1GwK18PlF9zaHGrdAznjoXlGWCwgW7kkw6JRj2cM2Q5PDWLCq9+XYyQO54AQDssMYiN4zSlsf3uDojDLCnwZItgPVtzcS/AUTjQ4P2D9/V68VoMcxIZRNRNgziIA2ATgnvNUN8HyHBB4nG3chzx1BAHSY6wX2OHrc2ceeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708346591; c=relaxed/simple;
	bh=9jnLzehdqPRUogjZHMkSdP+ApJu6vTCDjTL1BtPXVlQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AnRoAGmgJWYuz76JLDzyaCyhboVjoKfVuraonYyPB6mv0n8ijkd3EwTkquzomTA2tncVXM93LLMV6if5ULjn8anXT5auK7vK+bTvA5zd3XQVvs2OUQHES8iwmgYeDan0jHAvz1PtGswBoXxgccBqfyvkqBFiKNb7jjSi9JxHHGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NpbXgD5/; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-56439b7c7a9so1829099a12.3
        for <bpf@vger.kernel.org>; Mon, 19 Feb 2024 04:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708346588; x=1708951388; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KnNx/WhxeG3mCBFe7VIsaygG+weRXcQsPY4A419Xyjg=;
        b=NpbXgD5/cWovX+VzIclG6E7DWxexxvKeNKjZC2+QJbdusiqgwhtS5QetAcPDbZgOmv
         jZJPfJ8Eplx0d9GYID5NeGVJwfzuJdxez6GpEW5wkD4bn1ar+M8CIKQ7LTV1E8eGWo9E
         1pof/OIsxKrhzz2jItJ87y9pVftwBx6FrV5d5f7AHxQkDRI6R3CQgJ/NFiwhaQzfOxiM
         IHEfCe+W4IGNI1hQfSzBOwJR7sNpRD920/3yHim3n32j5cgqnz9WEvTY9SGCYlzdU7wu
         lyd4BDqH8XbhcDInmL6XfmhsHr/s18ofKD4WeyKCjhOEWVxUKArAUNpcn5UclCwc0eOQ
         V9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708346588; x=1708951388;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KnNx/WhxeG3mCBFe7VIsaygG+weRXcQsPY4A419Xyjg=;
        b=lmQlAaCZioGtfYilLkvrTvoT8pD9+RCKDXmVYcyOZvJjBAnVaaLEhtFVNkxqw7cZ6O
         pdqPGsBLZsE/brKx/QxX2tNWHmnGA9+61gCRvXT/r0t7Jpf3xModVQAAwtyBHwhGRAvO
         nu/TGQKte/Q8ZfF3FHOhKB0VKe6xFZPjrGarxG4h2BDc3twOiQbLujeKi9CtirCJkkPR
         6Ld3TOIlbBdoy2m6a8j2TMT2WC9gooZKQB66yfJ1SP15MCTKMnQ5cnypo3jPmW+5b8vv
         YNGPpqTYWtIv6iTA/ujARvDWp8RbZFbOXh+So976jW/O6mSyuf4maMPB2voTAapHGzv6
         98gA==
X-Forwarded-Encrypted: i=1; AJvYcCX+RwHMBwtJAo8HJG4BzCu4Z73Jrl2EDxYYbLzluXGOuFob3nZVV6cbQPpsuKtW5X4nFSwBijqnOWgvGwp4O+HUv63l
X-Gm-Message-State: AOJu0YyUwxvw/8V+AmzC4OWDB65gT2tVGYpZu9pUCACP7164VQu2BXi0
	Ddv2TCPvPC1lUqEf20JhNJx5DSiNujt9Sfimay9K/B/ypz7MvayS
X-Google-Smtp-Source: AGHT+IFVfTZsq4GwxyLKH021a2NG/JcJ5Z3ogNCFa39n61vk61fyjBRMPbTQFQM1Pu38G0rfPBqz1w==
X-Received: by 2002:a17:906:ae8b:b0:a3e:d85d:4c15 with SMTP id md11-20020a170906ae8b00b00a3ed85d4c15mr318605ejb.56.1708346587792;
        Mon, 19 Feb 2024 04:43:07 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id dt14-20020a170907728e00b00a3cbbaf5981sm2902694ejc.51.2024.02.19.04.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 04:43:07 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 19 Feb 2024 13:43:05 +0100
To: Viktor Malik <vmalik@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: Re: [PATCH RFC bpf-next 0/4] bpf: Add support to attach return prog
 in kprobe multi
Message-ID: <ZdNM2VhcOZBEc9K3@krava>
References: <20240207153550.856536-1-jolsa@kernel.org>
 <CAEf4BzZdPJWUiu9yNMsecB-tq0tHCLhrSF47b=w23fPevg=EWg@mail.gmail.com>
 <ZceWuIgsmiLYyCxQ@krava>
 <CAEf4Bzb6sPXAtDVke=CtCXev0mxhfgEG_O-xUA-e9-8NnbBtJQ@mail.gmail.com>
 <ZctcEpz3fHK4RqUX@krava>
 <CAEf4BzY_UBNe4ONqKGg5VtA-nY-ozgpQ=Du1+8ipQNnZ+JKCew@mail.gmail.com>
 <ZcvadcwSA37sfDk4@krava>
 <f00c784f-527b-4389-b301-b20ded02c5b4@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f00c784f-527b-4389-b301-b20ded02c5b4@redhat.com>

On Mon, Feb 19, 2024 at 12:20:08PM +0100, Viktor Malik wrote:
> On 2/13/24 22:09, Jiri Olsa wrote:
> > On Tue, Feb 13, 2024 at 10:20:46AM -0800, Andrii Nakryiko wrote:
> >> On Tue, Feb 13, 2024 at 4:09 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >>>
> >>> On Mon, Feb 12, 2024 at 08:06:06PM -0800, Andrii Nakryiko wrote:
> >>>
> >>> SNIP
> >>>
> >>>>>> But the way you implement it with extra flag and extra fd parameter
> >>>>>> makes it harder to have a nice high-level support in libbpf (and
> >>>>>> presumably other BPF loader libraries) for this.
> >>>>>>
> >>>>>> When I was thinking about doing something like this, I was considering
> >>>>>> adding a new program type, actually. That way it's possible to define
> >>>>>> this "let's skip return probe" protocol without backwards
> >>>>>> compatibility concerns. It's easier to use it declaratively in libbpf.
> >>>>>
> >>>>> ok, that seems cleaner.. but we need to use current kprobe programs,
> >>>>> so not sure at the moment how would that fit in.. did you mean new
> >>>>> link type?
> >>>>
> >>>> It's kind of a less important detail, actually. New program type would
> >>>> allow us to have an entirely different context type, but I think we
> >>>> can make do with the existing kprobe program type. We can have a
> >>>> separate attach_type and link type, just like multi-kprobe and
> >>>> multi-uprobe are still kprobe programs.
> >>>
> >>> ok, having new attach type on top of kprobe_multi link makes sense
> >>>
> >>>>
> >>>>>
> >>>>>> You just declare SEC("kprobe.wrap/...") (or whatever the name,
> >>>>>> something to designate that it's both entry and exit probe) as one
> >>>>>> program and in the code there would be some way to determine whether
> >>>>>> we are in entry mode or exit mode (helper or field in the custom
> >>>>>> context type, the latter being faster and more usable, but it's
> >>>>>> probably not critical).
> >>>>>
> >>>>> hum, so the single program would be for both entry and exit probe,
> >>>>> I'll need to check how bad it'd be for us, but it'd probably mean
> >>>>> just one extra tail call, so it's likely ok
> >>>>
> >>>> I guess, I don't know what you are doing there :) I'd recommend
> >>>> looking at utilizing BPF global subprogs instead of tail calls, if
> >>>> your kernel allows for that, as that's a saner way to scale BPF
> >>>> verification.
> >>>
> >>> ok, we should probably do that.. given this enhancement will be
> >>> available on latest kernel anyway, we could use global subprogs
> >>> as well
> >>>
> >>> the related bpftrace might be bit more challenging.. will have to
> >>> generate program calling entry or return program now, but seems
> >>> doable of course
> >>
> >> So you want users to still have separate kprobe and kretprobe in
> >> bpftrace, but combine them into this kwrapper transparently? It does
> > 
> > no I meant I'd need to generate the wrapper program for the new
> > interface.. which is extra compared to current bpftrace changes
> 
> If you end up introducing this new kwrapper program type in libbpf, I
> think that it'll make sense to have something similar in bpftrace, too.
> Allowing users to write separate kprobe and kretprobe programs and
> transparently combining them into kwrapper doesn't seem to bring much
> value to me.

I kind of liked the idea of not introducing new probe type and silently
making things faster ;-) but having wrapper probe type makes also sense

> 
> Jirka, if you need help with implementing bpftrace support for this, let
> me know. I'm very interested in having this capability there.

that'd be great, I'll send new version of kernel changes soon

thanks,
jirka

