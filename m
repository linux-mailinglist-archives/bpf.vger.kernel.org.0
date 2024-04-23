Return-Path: <bpf+bounces-27553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 636798AE958
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 16:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFDCE2874A9
	for <lists+bpf@lfdr.de>; Tue, 23 Apr 2024 14:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA2613B583;
	Tue, 23 Apr 2024 14:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6cjBKtI"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1595813B2AC;
	Tue, 23 Apr 2024 14:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713882167; cv=none; b=fWVi0c56Y9rBN/Mx1/Outr520E1gy8Z+AlAW9S+MA1HIzgSHtf22j1mrYNAD07ys01S1txjkXbq9pJL34TBxYOz+rJ3hw4TMww98drGg3ZwMJ0WAjbRXx2DNXSEiOTX3EgN2S2JCNA2O0qyxA9VtPxSjCMHX7ESnWQVZj/hgVMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713882167; c=relaxed/simple;
	bh=5vwaJkqQ3t+2b5CR8g5b8L/yNWSgsRMLyy49G/Ln+q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjN81S4Xb5NOjWiAzfJ0qUjoAUthmEgWrD8wbjHTfTNx8CyP2FR0g0YW34+S9VF/GroqNnKGR0jMX3dsczDmsgmjmHJOJhPibfDec7ze/a151yBFuLZR2nrwdIyuYf3mUuTpdhrnNHJbbHjrmhsrFubazcqiE0BZTeHXnvvP6iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6cjBKtI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE93C116B1;
	Tue, 23 Apr 2024 14:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713882166;
	bh=5vwaJkqQ3t+2b5CR8g5b8L/yNWSgsRMLyy49G/Ln+q8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i6cjBKtIQjbhScHYFPRDrTBQ+eDoJVjJ08lfT/DF1I2QUwdvPTLotAm1aMmNIam4u
	 0V0xgTMrirH81+VHoqnjMevalQEeKmeXv40dzJ0t3hsmavMvJiiLKYCdDcmB9o+eQr
	 daiuZAhpCwzmhK9PViGfmms+aNuPv/wZcSiVXw9MmsgdfwuezcMQbZRj4AVLQ1spq7
	 Z3kHoQYgcmibKAcYOPqduAavaDQ3PJJgDZPtnOvUE5VX/kHji+KcXC7L0XrxLPpKAk
	 Owx3v6B1WCxA5mPOIoxBwBtv7XdF/BZe0WUFAss3wqwtvqZhBCt0mYsNN2ea2lXYxy
	 85L/VmzxGYNBw==
Date: Tue, 23 Apr 2024 11:22:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>, dwarves@vger.kernel.org,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>, Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>, bpf@vger.kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCHES 0/2] Introduce --btf_features=+extra_features syntax
Message-ID: <ZifEM28-o-1ziSAy@x1>
References: <20240419205747.1102933-1-acme@kernel.org>
 <uhpbft44tp3arrmvdryd23hfobndoubu3c33d6bntsuyovrtq3@r766mv2yfdqw>
 <95822772-34fb-4fa2-82b5-0e143e56f2f8@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <95822772-34fb-4fa2-82b5-0e143e56f2f8@oracle.com>

On Tue, Apr 23, 2024 at 10:02:29AM +0100, Alan Maguire wrote:
> On 23/04/2024 03:29, Daniel Xu wrote:
> > On Fri, Apr 19, 2024 at 05:57:43PM -0300, Arnaldo Carvalho de Melo wrote:
> >> 	Please take a look if you agree this is a more compact, less
> >> confusing way of asking for the set of standard BTF features + some
> >> extra features such as 'reproducible_build'.
> >>
> >> 	We have this in perf, for things like:
> >>
> >> ⬢[acme@toolbox pahole]$ perf report -h -F 
> >>
> >>  Usage: perf report [<options>]
> >>
> >>     -F, --fields <key[,keys...]>
> >>                           output field(s): overhead period sample  overhead overhead_sys
> >>                           overhead_us overhead_guest_sys overhead_guest_us overhead_children
> >>                           sample period weight1 weight2 weight3 ins_lat retire_lat
> >>                           p_stage_cyc pid comm dso symbol parent cpu socket
> >>                           srcline srcfile local_weight weight transaction trace
> >>                           symbol_size dso_size cgroup cgroup_id ipc_null time
> >>                           code_page_size local_ins_lat ins_lat local_p_stage_cyc
> >>                           p_stage_cyc addr local_retire_lat retire_lat simd
> >>                           type typeoff symoff dso_from dso_to symbol_from symbol_to
> >>                           mispredict abort in_tx cycles srcline_from srcline_to
> >>                           ipc_lbr addr_from addr_to symbol_daddr dso_daddr locked
> >>                           tlb mem snoop dcacheline symbol_iaddr phys_daddr data_page_size
> >>                           blocked
> >>
> >> ⬢[acme@toolbox pahole]$
> >>
> >> From the 'perf report' man page for '-F':
> >>
> >>         If the keys starts with a prefix '+', then it will append the specified
> >>         field(s) to the default field order. For example: perf report -F +period,sample.

> > I think for perf it makes sense to have compact representation b/c
> > folks might be doing a lot of ad-hoc work. But encoding BTF seems more
> > like a write-once, read mostly. So having `+` notation doesn't feel like

In the case where documentation style is prefered, i.e. a write once
read mostly, as you said, then use the most descriptive form.

> > it'd help that much.

> > As someone who's not seen that style of syntax before, it's not
> > immediately obvious what it does. But seeing `all`, I have a pretty
> > good idea.
 
> One thing we should probably bear in mind here is that for kernel builds
> we will always explicitly call out the set of features we want rather
> than use "all". So the "all" support is really more of a shortcut for
> developers who run pahole standalone for testing BTF encoding. It is
> still confusing though.

Agreed, multiple people agreed 'all' is confusing as not _all_ BTF
features are selected by it.
 
> The +/- approach seems fine to me especially if there are precedents in

Yeah, so we'll have a very compact way of adding (and removing, if we
feel the need, by prefixing a undesired feature that is present in the
'default' set with -) features, in addition to a more detailed way,
i.e. these will be equivalent:

	--btf_features=default,reproducible_build

and:

	--btf_features=+reproducible_build

> other tools; maybe we should also switch name to "default" instead of
> "all" at the same time tho? The notion of default values internal to

I'm ok with this, so please send a patch renaming 'all' to 'default', on
top of what is now in the 'next' branch.

- Arnaldo

> pahole (when BTF features aren't explicitly set) isn't exposed to the
> user, so I _think_ we can get away with using that term. We could
> probably do a bit of internal renaming - set_btf_features_default() ->
> set_btf_features_minimal() - to call these the minimal BTF features or
> something similar..

