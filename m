Return-Path: <bpf+bounces-31847-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD289904010
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 17:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B5D3284FFD
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 15:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B90D2E417;
	Tue, 11 Jun 2024 15:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iS/73RUV"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BF71E531;
	Tue, 11 Jun 2024 15:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718119994; cv=none; b=bktztNhDpvarM9KFSZ5OF/bT67a+3ow0kFTy+6wkNUHA590uk/LT9PzeLMYIRlkWKLWfjOV6BHyNuWWCFe2RiWjVHC1UFAnYpfZDS8eLfv8ElPV3wf6MUFk53N+/gWN8vyYrKow+XSQAP8Fak0zmIx2PErbVaTwjTo4PeQJa5nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718119994; c=relaxed/simple;
	bh=7c/3fzXwXu3tHa6Ldvlr4BSWvlNfTy9/XdOSafpSntk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZNTakYKoaDYeuuigTj7mbVqlxmYPG5Hn+G/qf3FyxADDX3ZIxVTV/32jpUGAvF2f/+dtjjUPkPxJvWgTDALWlooxA8OHBAHLeY9SZnuaOGACClb3MsqFsosFG1JfjPEoGydJQsX8Bc2ymBK+sPK+LQy5rmTlOYKWyS+yxWb922g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iS/73RUV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C486C2BD10;
	Tue, 11 Jun 2024 15:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718119993;
	bh=7c/3fzXwXu3tHa6Ldvlr4BSWvlNfTy9/XdOSafpSntk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iS/73RUVqWAIRwGTClV2e31QxDzfeYNDzl7SBAwUweI7cKXtCUaMtWDcBU2nONNSU
	 rqKUanQW86j4r9IaixTia/PAohXIo/9ia3xbYOpbrjugScCFn/sA0NksOyQTLv/DXH
	 jVY9LjC3on9ObIdB6f3HNBIHyWkQnWmaw27p4zXiB2S0Y318KFxqYOcYm2XXiZvfLa
	 I0qmYa1cpNOyytv8we/SCWYvMARHNZSZKV2dxoNn6+sTOGkvgOMVivyQisAq1Dhomy
	 btCBFOwO6LwZAX+Gsb9kE/tJCvBoD7lDvBcgj/ab/LB3tBXqyBrkMyEcQOV2UdACjX
	 m+toR3/Hz60Dw==
Date: Tue, 11 Jun 2024 08:33:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal P4 Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com,
 anjali.singhai@intel.com, namrata.limaye@intel.com, tom@sipanda.io,
 mleitner@redhat.com, Mahesh.Shirshyad@amd.com, tomasz.osinski@intel.com,
 jiri@resnulli.us, xiyou.wangcong@gmail.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, vladbu@nvidia.com,
 horms@kernel.org, khalidm@nvidia.com, toke@redhat.com, victor@mojatatu.com,
 pctammela@mojatatu.com, Vipin.Jain@amd.com, dan.daly@intel.com,
 andy.fingerhut@gmail.com, chris.sommers@keysight.com, mattyk@nvidia.com,
 bpf@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH net-next v16 00/15] Introducing P4TC (series 1)
Message-ID: <20240611083312.3f3522dd@kernel.org>
In-Reply-To: <CAM0EoMkAQH+zNp3mJMfiszmcpwR3NHnEVr8SN_ysZhukc=vt8A@mail.gmail.com>
References: <20240410140141.495384-1-jhs@mojatatu.com>
	<20240611072107.5a4d4594@kernel.org>
	<CAM0EoMkAQH+zNp3mJMfiszmcpwR3NHnEVr8SN_ysZhukc=vt8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 11:10:35 -0400 Jamal Hadi Salim wrote:
> > Before the tin foil hats gather - we have no use for any of this at
> > Meta, I'm not trying to twist the design to fit the use cases of big
> > bad hyperscalers.  
> 
> The scope is much bigger than just parsers though, it is about P4 in
> which the parser is but one object.

For me it's very much not "about P4". I don't care what DSL user prefers
and whether the device the offloads targets is built by a P4 vendor.

> Limiting what we can do just to fit a narrow definition of "offload"
> is not the right direction.

This is how Linux development works. You implement small, useful slice
which helps the overall project. Then you implement the next, and
another.

On the technical level, putting the code into devlink rather than TC
does not impose any meaningful limitations. But I really don't want
you to lift and shift the entire pile of code at once.

> P4 is well understood, hardware exists for P4 and is used to specify
> hardware specs and is deployed(See Vipin's comment).

"Hardware exists for P4" is about as meaningful as "hardware exists
for C++".

