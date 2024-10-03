Return-Path: <bpf+bounces-40847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5B598F4F6
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 19:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37F97B21CC2
	for <lists+bpf@lfdr.de>; Thu,  3 Oct 2024 17:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687391A7240;
	Thu,  3 Oct 2024 17:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1vykL0c"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD296199FC1;
	Thu,  3 Oct 2024 17:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727975902; cv=none; b=sFLqe4ri6GXKJ8Xw6zTWtcEZMCrjlaIp0hdhmkrb5Vp8fbU1NFHQDHixil0rYAEAOX02KouriQGIpgLbPqtydmb0LRgZoffBbFUCgn9QRX8Du9eAk08HtvsgZXQ+z7b3g0+8Tc3+VB+4XRGz0CdCs0amNTGDCIlq/En3pRSanwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727975902; c=relaxed/simple;
	bh=ZN46coR1KGzjO6OJhcaq8EC9WBwVwWIxPK85Gge3eZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmVAJDLCwT65V+aOAmn97xtSIuZa7Rtl3fzdzkAu2QvQKspscgWrlCTXjlg+c/NleIn5mAhLypElOFYJjnO2xf1CTP3eYY5oaMhI9zlr2wBAWWn/ypsj3dGWyGCCxHGtwF3PH7Q1P26fgIzYSiLV+zJrh4ravVVolZpfqIBHwP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1vykL0c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2594C4CEC5;
	Thu,  3 Oct 2024 17:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727975901;
	bh=ZN46coR1KGzjO6OJhcaq8EC9WBwVwWIxPK85Gge3eZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X1vykL0cYWZvlaQLcv6WUwJvfXOGKNL3yQkdf8DeymBs2QGRcO6q8PaXfcZzwQ5cb
	 tmEVMQNJOHjLCHpqVvnLoEa14h8UoO6EF8hHnTbBl+hOCtudRvS+PH+mcgyVdnpnnE
	 q96mYlRVbO41GXOTVoSfLv7pgdC3c6FPj3mh93kk2wSneM7zSFvcspOLkCthO7cyoI
	 fkk1g0bJFi/YDEIr9oDBwxakxu3LXAWzSYM8tI/dnjRQUVrDl0zKDwoLky+RO5FLP4
	 yx4HXuBak9fAFPEPWX+KKvC19Uuqse4Mk7wv/SZAerAhLe6yvHKfUxDgKZWKN6DA3Q
	 9LOqMurFZ26dw==
Date: Thu, 3 Oct 2024 14:18:17 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>, bpf@vger.kernel.org,
	dwarves@vger.kernel.org, linux-debuggers@vger.kernel.org
Subject: Re: [PATCH dwarves v3 5/5] pahole: add global_var BTF feature
Message-ID: <Zv7R2RcFRqMPLB5K@x1>
References: <20241002235253.487251-1-stephen.s.brennan@oracle.com>
 <20241002235253.487251-6-stephen.s.brennan@oracle.com>
 <22da229b-86d0-4a0c-b5d6-4883b64669f2@oracle.com>
 <Zv6v0WdEBg4dEJAP@x1>
 <9cda0821-4b25-498e-acf3-cd8055d82ca5@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cda0821-4b25-498e-acf3-cd8055d82ca5@oracle.com>

On Thu, Oct 03, 2024 at 04:21:07PM +0100, Alan Maguire wrote:
> On 03/10/2024 15:53, Arnaldo Carvalho de Melo wrote:
> > On Thu, Oct 03, 2024 at 03:40:35PM +0100, Alan Maguire wrote:
> >> On 03/10/2024 00:52, Stephen Brennan wrote:
> >>> So far, pahole has only encoded type information for percpu variables.
> >>> However, there are several reasons why type information for all global
> >>> variables would be useful in the kernel:
> > 
> >>> 1. Runtime kernel debuggers like drgn could use the BTF to introspect
> >>> kernel data structures without needing to install heavyweight DWARF.
> > 
> >>> 2. BPF programs using the "__ksym" annotation could declare the
> >>> variables using the correct type, rather than "void".
> > 
> >>> It makes sense to introduce a feature for this in pahole so that these
> >>> capabilities can be explored in the kernel. The feature is non-default:
> >>> when using "--btf-features=default", it is disabled. It must be
> >>> explicitly requested, e.g. with "--btf-features=+global_var".
> >  
> >> I'm not totally sure switching global_var to a non-default feature is
> >> the right answer here.
> >  
> >> The --btf_features "default" set of options are meant to closely mirror
> >> the upstream kernel options we enable when doing BTF encoding. However,
> >> in scripts/Makefile.btf we don't use "default"; we explicitly call out
> >> the set of features we want. We can't just use "default" in that context
> >> since the meaning of "default" varies based upon whatever version of
> >> pahole you have.
> >  
> >> So "default" is simply a convenient shorthand for pahole testing which
> >> corresponds to "give me the set of features that upstream kernels use".
> >> It could have a better name that reflects that more clearly I suppose.
> >  
> >> When we do switch this on in-kernel, we'll add the explicit "global_var"
> >> to the list of features in scripts/Makefile.btf.
> >  
> >> So with all this said, do we make global_vars a default or non-default
> >> feature? It would seem to make sense to specify non-default, since it is
> >> not switched on for the kernel yet, but looking ahead, what if the 1.28
> >> pahole release is used to build vmlinux BTF and we add global_var to the
> >> list of features? In such a case, our "default" set of values would be
> >> out of step with the kernel. So it's not a huge deal, but I would
> >> consider keeping this a default feature to facilitate testing; this
> >> won't change what the kernel does, but it makes testing with full
> >> variable generation easier (I can just do "--btf_features=default").
> > 
> > This "default" really is confusing, as you spelled out above :-\ When to
> > add something to it so that it reflects what the kernel has is tricky,
> > perhaps we should instead have a ~/.config/pahole file where developers
> > can add BTF features to add to --btf_features=default in the period
> > where something new was _really_ added to the kernel and before the next
> > version when it _have been added to the kernel set of BTF features_ thus
> > should be set into stone in the pahole sources?
 
> it's a nice idea; I suppose once we have more automated tests, this will
> be less of an issue too. I'm looking at adding a BTF variable test
> shortly, would be good to have coverage there too, especially since
> we're growing the amount of info we encode in this area.

Sure thing, the more tests, the better!
 
> > So I think we should do as Stephen did, keep it out of
> > --btf_features=default, as it is not yet in the kernel set of options,
> > and have the config file, starting with being able to set those
> > features, i.e. we would have:

> > $ cat ~/.config/pahole
> > [btf_encoder]
> > 	btf_features=+global_var

> > wdyt?
 
> I think that makes perfect sense, great idea!

I was looking for a library to do that to avoid "stealing" the
perf-config code, but perhaps we should use an env var for that?

PAHOLE_BTF_FEATURES='+global_var'

To keep things simple?

- Arnaldo

