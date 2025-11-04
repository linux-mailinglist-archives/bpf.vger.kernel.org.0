Return-Path: <bpf+bounces-73419-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 448BEC2FDBF
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 09:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADD96424E18
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 08:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9939311972;
	Tue,  4 Nov 2025 08:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E1uEMldG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A984311958
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 08:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762244308; cv=none; b=g2V2BQTxX0t+HJz0bdtiTOzkIp6nzMf6hTr72df8AEJIZZlNYAvHnjHC3VaNe7Nu5Dw8F8NdZwLBrVbKVDe+FAyC6LMt/ayFCb1OAqjjn8FtJNgUzNiAmOmEfAmQU50DBAVBUlhLHiN2t2y6/ekAZUhDTOjtdksuCKq2C30lKnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762244308; c=relaxed/simple;
	bh=y1H0J8xShtW8C86BhW+X8QqScD8LGdJ12xq4p3MILSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkMgLtXYo52M1TJTFICNYYzeE5Si5/PKwL2Tf+i5x7e1vEH1SO1uCUIK4bWy/DMpBu3FJhVtLpO3/ecX5MpQFgeNZpfpRXsbk3sdd1657Wx8dhAN7VxgFQn+eWpk44JiFSfEU3yTboFY3dmAWoHM7PH9vH8QExY0oUY3JuHNPX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E1uEMldG; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-429c2f6a580so186333f8f.1
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 00:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762244304; x=1762849104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HDGrwGIAe+HNiwkyvFhP/kp5qQx4Bemq/CCgC2+MOGE=;
        b=E1uEMldGmpryX7F87XkuxTRDtdwDgdHX1+Ghb8cr9Y+KDJ084RLi5KHRRsc9uMWuZ2
         si/J3mlAwe6fCyi35LOCST0p2smFYFBlJDjAdr3DuhcX08k0b0aNWmC0KtcLQyr4CPMU
         qEQJQUlI3YSd2twL/M9XEGogCnLBxCBkjm8MSRVhj1EDdA9P9/Zk3vcqEsial8zOaA1r
         iSoALBkdeI+ve9EVjjS63MNaxxeWZsQjamPCEn9CaW2QhkLMioynSBZd93yQg2NXqniq
         UhyqlI9cgPmXfJvXzCE6dNDBtyO64WoEaFZukUXORJGwCC4FdNVSjFDIBfVJozzpfI9X
         AvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762244304; x=1762849104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDGrwGIAe+HNiwkyvFhP/kp5qQx4Bemq/CCgC2+MOGE=;
        b=Tt4pKZ4fMkDwZzFWXl/ZygiyPuUEoV9WuIXdD101+XJXbq40PLQPCf25tZGaWf4xj3
         f08CyQO7M72QbKLMyJHAPwiANwOc84BtpDKX+tOJZdsMLhOds7FFIrjcRoheRqB85Q9Q
         9XVviRGUe/9ODlepSodmtNOQU7T2Yi+Lpgkj3DVdb5wvU6xdjO7b/wvkvzwcKQ0pxtc4
         Jw4VRFmNpH25unBII4ZrH6/KpIvPSoVktcvgmWRdjfUackfzXbp11zowprqMmCpujTOJ
         EZrxCDH1KE9ygftIOtanghHyOxZgJL2wP+GtFHWZ/jhXmGykbLHEa0MoKsJLV22Gy2td
         QQLg==
X-Forwarded-Encrypted: i=1; AJvYcCUSimTpjA21aJkz6tAeyMhyrR1CsT1Z3F5XImVHdZOrSJaSksXulw338xRtQcytMQcOV94=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHCF+6olhl1tk1uBSedSHMa9WslEshUcPXIWbBr6bChVWsizIx
	dOGbtXctfTCO8f5g/7h5cNb39htkvnHUcYVdhzlThdFzU2bbdOTmYlIyivhYuzqozsQ=
X-Gm-Gg: ASbGncsL+UEupgk9H/xQ5ACAICINkq3GhcVC/zJeU4nv4DzO5VLv846pp7afZBtOc5G
	jm2mO+GmHGvxr9yvjBF9XWg+0j7GY6mVY3qzlRwUIuuQNNKsYq18V32+bn2lnpgSN5/btyWeWVY
	O0sWPer1Re5fTmkJ4JFxeGKQistEhRKL6KvtGXpETpPHKnIqsg69ZCGvX6HAZA9SCgOsG+UQ8RN
	4eO/iWaGy6RJqfQrg2uXIexkRz2as7HBUSX9OCYPyYrVsrMIPuOo8VUboBQCQa4/li4stZ417NJ
	iSVkOCYKU1yta2AGri7CdCR1MFPCWTCOjW2khrofZQJFpn+qJCjYr5icdgpdY3XrQUk6mNprErl
	L9ETW4JKknDxyZflQwpKmQm+GuiitvOrTQqDesE5dxyhNNZuw96iKMlpdkKGmDeiKfaL3jA1Afr
	oEe5Zt3ds7Mfcd/o9Ktp4=
X-Google-Smtp-Source: AGHT+IER82dbwOAWSEGagB9JoBAQ4DFL/N85XJT6dQwU/F6NCVBuyJKblUAv95YkwnJ9rUbOTpPUNg==
X-Received: by 2002:a05:6000:40c7:b0:425:76e3:81c5 with SMTP id ffacd0b85a97d-429bd6827fcmr12672112f8f.17.1762244303953;
        Tue, 04 Nov 2025 00:18:23 -0800 (PST)
Received: from localhost (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc193e27sm3237804f8f.18.2025.11.04.00.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 00:18:23 -0800 (PST)
Date: Tue, 4 Nov 2025 09:18:22 +0100
From: Michal Hocko <mhocko@suse.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	JP Kobryn <inwardvessel@gmail.com>, linux-mm@kvack.org,
	cgroups@vger.kernel.org, bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Song Liu <song@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 06/23] mm: introduce BPF struct ops for OOM handling
Message-ID: <aQm2zqmD9mHE1psg@tiehlicka>
References: <20251027231727.472628-1-roman.gushchin@linux.dev>
 <20251027231727.472628-7-roman.gushchin@linux.dev>
 <aQR7HIiQ82Ye2UfA@tiehlicka>
 <875xbsglra.fsf@linux.dev>
 <aQj7uRjz668NNrm_@tiehlicka>
 <87a512muze.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a512muze.fsf@linux.dev>

On Mon 03-11-25 17:45:09, Roman Gushchin wrote:
> Michal Hocko <mhocko@suse.com> writes:
> 
> > On Sun 02-11-25 13:36:25, Roman Gushchin wrote:
> >> Michal Hocko <mhocko@suse.com> writes:
[...]
> > No, I do not feel strongly one way or the other but I would like to
> > understand thinking behind that. My slight preference would be to have a
> > single return status that clearly describe the intention. If you want to
> > have more flexible chaining semantic then an enum { IGNORED, HANDLED,
> > PASS_TO_PARENT, ...} would be both more flexible, extensible and easier
> > to understand.
> 
> The thinking is simple:
> 1) Most users will have a single global bpf oom policy, which basically
> replaces the in-kernel oom killer.
> 2) If there are standalone containers, they might want to do the same on
> their level. And the "host" system doesn't directly control it.
> 3) If for some reason the inner oom handler fails to free up some
> memory, there are two potential fallback options: call the in-kernel oom
> killer for that memory cgroup or call an upper level bpf oom killer, if
> there is one.
> 
> I think the latter is more logical and less surprising. Imagine you're
> running multiple containers and some of them implement their own bpf oom
> logic and some don't. Why would we treat them differently if their bpf
> logic fails?

I think both approaches are valid and it should be the actual handler to
tell what to do next. If the handler would prefer the in-kernel fallback
it should be able to enforce that rather than a potentially unknown bpf
handler up the chain.

> Re a single return value: I can absolutely specify return values as an
> enum, my point is that unlike the kernel code we can't fully trust the
> value returned from a bpf program, this is why the second check is in
> place.

I do not understand this. Could you elaborate? Why we cannot trust the
return value but we can trust a combination of the return value and a
state stored in a helper structure?

> Can we just ignore the returned value and rely on the freed_memory flag?

I do not think having a single freed_memory flag is more helpful. This
is just a number that cannot say much more than a memory has been freed.
It is not really important whether and how much memory bpf handler
believes it has freed. It is much more important to note whether it
believes it is done, it needs assistance from a different handler up the
chain or just pass over to the in-kernel implementation.

> Sure, but I don't think it bus us anything.
> 
> Also, I have to admit that I don't have an immediate production use case
> for nested oom handlers (I'm fine with a global one), but it was asked
> by Alexei Starovoitov. And I agree with him that the containerized case
> will come up soon, so it's better to think of it in advance.

I agree it is good to be prepared for that.

> >> >> The bpf_handle_out_of_memory() callback program is sleepable to enable
> >> >> using iterators, e.g. cgroup iterators. The callback receives struct
> >> >> oom_control as an argument, so it can determine the scope of the OOM
> >> >> event: if this is a memcg-wide or system-wide OOM.
> >> >
> >> > This could be tricky because it might introduce a subtle and hard to
> >> > debug lock dependency chain. lock(a); allocation() -> oom -> lock(a).
> >> > Sleepable locks should be only allowed in trylock mode.
> >> 
> >> Agree, but it's achieved by controlling the context where oom can be
> >> declared (e.g. in bpf_psi case it's done from a work context).
> >
> > but out_of_memory is any sleepable context. So this is a real problem.
> 
> We need to restrict both:
> 1) where from bpf_out_of_memory() can be called (already done, as of now
> only from bpf_psi callback, which is safe).
> 2) which kfuncs are available to bpf oom handlers (only those, which are
> not trying to grab unsafe locks) - I'll double check it in thenext version.

OK. All I am trying to say is that only safe sleepable locks are
trylocks and that should be documented because I do not think it can be
enforced

-- 
Michal Hocko
SUSE Labs

