Return-Path: <bpf+bounces-40857-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B94098F62B
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 20:33:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F4101C216D9
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 18:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165F61AB530;
	Thu,  3 Oct 2024 18:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijDtx3a/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8229F6A33F;
	Thu,  3 Oct 2024 18:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727980397; cv=none; b=cadSRSKmSiQqzx2C0WOoEoUKE2wYdkBRgln4sVLrGljK7WSQpsl7u+Knhnv1GnkcagwaHWypBJUIwsjQ86tIS9MWe1ORhGtYVsVEM1zvdh1ahog4MI0aqewcylaOyVH/Hxg6JhG4jhYXbKTBN42+Zp1LFQU+vVnAbLZVBcSK/X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727980397; c=relaxed/simple;
	bh=qeKYzDR0ZzWVVmm6mUgb0da9cLC20051Tsv6ATTHuLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tlsgvi/dp+I4J+mx+fMZAI+4Ij4yDae3azngSa6986ukH39Tj1mTYT0rdIh8q08HSc5kF90C0gpaFvbzrF6l/DL3y25xf5FpnQXINN2Fy/HFAUGi6U03yTFvVneolPrAWF/9914ScAtuxc4BQW4lGbkUWWkWJkHv+Jf4FF/AUxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijDtx3a/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93555C4CEC5;
	Thu,  3 Oct 2024 18:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727980397;
	bh=qeKYzDR0ZzWVVmm6mUgb0da9cLC20051Tsv6ATTHuLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ijDtx3a/OrpwitT1cE66Sn7FpVdibUuLA2lltomzNY18HodbjyOCKyv+UrKSPsO01
	 3cRNWV3l3XHBA9CbZXwf85jV71yfAbY8jQY1NeG+WUtvNvLZa6MvXqg8jywMUvGPMS
	 CHXFVB5Ka7FciR5Osv0nyMq/CYeyzpuHTJdC7GfqUb/wW5WyREx+CBZN6teNvadxMW
	 h4Nx0r27ZJ1F9L0CNutScEkzBVP/RgtLSb0vDrG/GUd0OrmFQcstOP8D5U+I7Saes4
	 zG7W57ZS1ZmR4nhr+QjQb5JKwTJfEEX1g52j975ECtB7zTHlgd639O2yAfC9SE3rhD
	 rnhFuOAygzy4A==
Date: Thu, 3 Oct 2024 15:33:13 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Stephen Brennan <stephen.s.brennan@oracle.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, bpf@vger.kernel.org,
	dwarves@vger.kernel.org, linux-debuggers@vger.kernel.org
Subject: Re: [PATCH dwarves v3 5/5] pahole: add global_var BTF feature
Message-ID: <Zv7jaXiQ7Av0p6Hn@x1>
References: <20241002235253.487251-1-stephen.s.brennan@oracle.com>
 <20241002235253.487251-6-stephen.s.brennan@oracle.com>
 <22da229b-86d0-4a0c-b5d6-4883b64669f2@oracle.com>
 <Zv6v0WdEBg4dEJAP@x1>
 <9cda0821-4b25-498e-acf3-cd8055d82ca5@oracle.com>
 <Zv7R2RcFRqMPLB5K@x1>
 <87ttdtkrh4.fsf@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ttdtkrh4.fsf@oracle.com>

On Thu, Oct 03, 2024 at 10:48:23AM -0700, Stephen Brennan wrote:
> Arnaldo Carvalho de Melo <acme@kernel.org> writes:
> > On Thu, Oct 03, 2024 at 04:21:07PM +0100, Alan Maguire wrote:
> >> On 03/10/2024 15:53, Arnaldo Carvalho de Melo wrote:
> >> > On Thu, Oct 03, 2024 at 03:40:35PM +0100, Alan Maguire wrote:
> >> >> On 03/10/2024 00:52, Stephen Brennan wrote:
> >> >>> So far, pahole has only encoded type information for percpu variables.
> >> >>> However, there are several reasons why type information for all global
> >> >>> variables would be useful in the kernel:
> >> > 
> >> >>> 1. Runtime kernel debuggers like drgn could use the BTF to introspect
> >> >>> kernel data structures without needing to install heavyweight DWARF.
> >> > 
> >> >>> 2. BPF programs using the "__ksym" annotation could declare the
> >> >>> variables using the correct type, rather than "void".
> >> > 
> >> >>> It makes sense to introduce a feature for this in pahole so that these
> >> >>> capabilities can be explored in the kernel. The feature is non-default:
> >> >>> when using "--btf-features=default", it is disabled. It must be
> >> >>> explicitly requested, e.g. with "--btf-features=+global_var".
> >> >  
> >> >> I'm not totally sure switching global_var to a non-default feature is
> >> >> the right answer here.
> >> >  
> >> >> The --btf_features "default" set of options are meant to closely mirror
> >> >> the upstream kernel options we enable when doing BTF encoding. However,
> >> >> in scripts/Makefile.btf we don't use "default"; we explicitly call out
> >> >> the set of features we want. We can't just use "default" in that context
> >> >> since the meaning of "default" varies based upon whatever version of
> >> >> pahole you have.
> >> >  
> >> >> So "default" is simply a convenient shorthand for pahole testing which
> >> >> corresponds to "give me the set of features that upstream kernels use".
> >> >> It could have a better name that reflects that more clearly I suppose.
> >> >  
> >> >> When we do switch this on in-kernel, we'll add the explicit "global_var"
> >> >> to the list of features in scripts/Makefile.btf.
> >> >  
> >> >> So with all this said, do we make global_vars a default or non-default
> >> >> feature? It would seem to make sense to specify non-default, since it is
> >> >> not switched on for the kernel yet, but looking ahead, what if the 1.28
> >> >> pahole release is used to build vmlinux BTF and we add global_var to the
> >> >> list of features? In such a case, our "default" set of values would be
> >> >> out of step with the kernel. So it's not a huge deal, but I would
> >> >> consider keeping this a default feature to facilitate testing; this
> >> >> won't change what the kernel does, but it makes testing with full
> >> >> variable generation easier (I can just do "--btf_features=default").
> >> > 
> >> > This "default" really is confusing, as you spelled out above :-\
> 
> Yeah, I spent a while staring at the comment and reading the code to
> understand the nuance between the initial and default values. I don't
> think I fully understood it until this v3 patch, and admittedly I still
> didn't have the full context of how "default" was used.
> 
> One interesting point of comparison is the "-M" argument to
> "qemu-system-$arch". For example:
> 
>   $ qemu-system-x86_64 -M ?
>   Supported machines are:
>   microvm              microvm (i386)
>   pc                   Standard PC (i440FX + PIIX, 1996) (alias of pc-i440fx-9.0)
>   pc-i440fx-9.0        Standard PC (i440FX + PIIX, 1996) (default)
>   pc-i440fx-8.2        Standard PC (i440FX + PIIX, 1996)
>   pc-i440fx-8.1        Standard PC (i440FX + PIIX, 1996)
>   pc-i440fx-8.0        Standard PC (i440FX + PIIX, 1996)
>   [...]
> 
> So the default "pc" machine is simply an alias that gets updated to the
> most recent machine (with potential new behaviors) every release, but
> you can always select a specific machine that you care about.
> 
> Maybe it would make sense if there were versioned defaults, so that
> "default" always picks whatever is relevant to the most recent upstream
> kernel, but you could also select the default as of an older pahole
> release.
> 
> That does sound like plenty of complexity added to an already somewhat
> confusing system, so I'm not sold on it. The flexibility for adjusting
> to new kernel defaults is appealing though.
> 
> >> >When to
> >> > add something to it so that it reflects what the kernel has is tricky,
> >> > perhaps we should instead have a ~/.config/pahole file where developers
> >> > can add BTF features to add to --btf_features=default in the period
> >> > where something new was _really_ added to the kernel and before the next
> >> > version when it _have been added to the kernel set of BTF features_ thus
> >> > should be set into stone in the pahole sources?
> >  
> >> it's a nice idea; I suppose once we have more automated tests, this will
> >> be less of an issue too. I'm looking at adding a BTF variable test
> >> shortly, would be good to have coverage there too, especially since
> >> we're growing the amount of info we encode in this area.
> >
> > Sure thing, the more tests, the better!
> >  
> >> > So I think we should do as Stephen did, keep it out of
> >> > --btf_features=default, as it is not yet in the kernel set of options,
> >> > and have the config file, starting with being able to set those
> >> > features, i.e. we would have:
> >
> >> > $ cat ~/.config/pahole
> >> > [btf_encoder]
> >> > 	btf_features=+global_var
> >
> >> > wdyt?
> >  
> >> I think that makes perfect sense, great idea!
> >
> > I was looking for a library to do that to avoid "stealing" the
> > perf-config code, but perhaps we should use an env var for that?
> >
> > PAHOLE_BTF_FEATURES='+global_var'
> >
> > To keep things simple?
> 
> One concern with configuration files is that (at least on my system)
> they tend to sit around and get forgotten, unless they're super well
> known configs like ~/.bashrc. So at some point, I could see myself
> setting a pahole config and then 6 months later wondering why pahole
> behaves differently on two different systems.
> 
> Env vars are easy to set permanently if you want, but are also more
> visible and centralized with your other configurations, so they're my
> preference.

Agreed, lets go with an env var.

And this one is even "ephemeral", i.e. as we get new versions of pahole
it should match the most recent set of kernel btf_features set and thus
become unneeded.

At some point we'll stop adding features, right? 8-)

- Arnaldo

