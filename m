Return-Path: <bpf+bounces-2164-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51161728AE0
	for <lists+bpf@lfdr.de>; Fri,  9 Jun 2023 00:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A67DF1C20B49
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 22:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3E134D7F;
	Thu,  8 Jun 2023 22:05:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC78B7464
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 22:05:50 +0000 (UTC)
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76C52D78
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 15:05:47 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id A56643E0E94
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 22:05:43 +0000 (UTC)
Received: from pdx1-sub0-mail-a238.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 44CE03E1DF8
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 22:05:43 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1686261943; a=rsa-sha256;
	cv=none;
	b=R3duyHErAGUzTo2L+kPtRHPAmELCvwmfkbf7JACPCZSoU3Km4R6mN9qIoQIi2FNguWUvOp
	czParjxJDJSZl2XQ6h/Uz4DerjCPSZO4G0svvwDKXRICag7JXUgzLrvsD084uj7uqPUXGE
	hoAkTHsNWg03/2DPsLFrt1simwL+49CUVvbozlivFD+a+wwOjaM4BiM3iGZrj3VRaAZwZu
	CdfF/uH/BQrDey/xPLPlBJI8a95LNZUO78/9RN4T+oIM4icjp0sI0Htbsgbr18DXrUBMqy
	ErniffNgqQUWj3xObQCyFAFyEAYKyBtPj7dQXQu/aSYnTKcSrVQpSBZ4tElU5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1686261943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=6VFcr740ClHDgfooQ+FLHb4V9tJxfdRe/N7zQ7funAE=;
	b=R/eu2UYbnNC4peOZJCqsMZ+CrN6OXtZJ141cA0+30q7cxMER/qq6qpYj0kZTCrv4Cmc6y+
	aojBP7w7zpaG9O5H2A1FLPwq+rlOUODgxQJRnvT3KOVluB+w640lge1pD+X+QwnQIjTrsB
	/zXHN9fn5oGbDdhEbqU7bHLW3LabtTOPKZq5a7oSv/mRyD4rVy50Bd0Pybmaf6VOkof2Hq
	I9ayC1LO8GpqeDu3Qgoh13bkYZLrSP/N5ay/HJF/sAeTEoeNFtNgCphtjaHCkS7nWUrACe
	DFyQB2hkYlj3JlbA7LtAxD24I+LMrpFwT+hE8xqNF3HH1u1N+lMaam6kYFJ1cA==
ARC-Authentication-Results: i=1;
	rspamd-fcb9f4dcf-p8fq4;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Tangy-Shelf: 39032e8645051458_1686261943507_2877274266
X-MC-Loop-Signature: 1686261943507:914936670
X-MC-Ingress-Time: 1686261943507
Received: from pdx1-sub0-mail-a238.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.123.193.172 (trex/6.8.1);
	Thu, 08 Jun 2023 22:05:43 +0000
Received: from kmjvbox (c-73-93-64-36.hsd1.ca.comcast.net [73.93.64.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a238.dreamhost.com (Postfix) with ESMTPSA id 4QcdZH0TJ2z3K
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 15:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1686261943;
	bh=6VFcr740ClHDgfooQ+FLHb4V9tJxfdRe/N7zQ7funAE=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=fcWyME1PTxbcYwVPtejuIEGcMXGEkL8T6ddygN281e8u+RFnlTxdv4vSPPJtIhu3G
	 qx3B8C5XxtwKHUse6/Utr33nINbAXeENOMcXU5ZX2q3A0IQreZZomJupaWTqr5WrN/
	 LWi0PaiU7QyHVgI2H8zkDd6/3NWY8p2GZTFI67bo=
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e0042
	by kmjvbox (DragonFly Mail Agent v0.12);
	Thu, 08 Jun 2023 15:05:42 -0700
Date: Thu, 8 Jun 2023 15:05:42 -0700
From: Krister Johansen <kjlx@templeofstupid.com>
To: Yonghong Song <yhs@meta.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH bpf v2 2/2] bpf: ensure main program has an extable
Message-ID: <20230608220542.GA2057@templeofstupid.com>
References: <cover.1686166633.git.kjlx@templeofstupid.com>
 <de425e99876dc6c344e1a4254894a3c81e71a2ec.1686166633.git.kjlx@templeofstupid.com>
 <33c52b4c-2a16-7578-f782-51267deff750@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33c52b4c-2a16-7578-f782-51267deff750@meta.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 08, 2023 at 10:38:12AM -0700, Yonghong Song wrote:
> 
> 
> On 6/7/23 2:04 PM, Krister Johansen wrote:
> > When bpf subprograms are in use, the main program is not jit'd after the
> > subprograms because jit_subprogs sets a value for prog->bpf_func upon
> > success.  Subsequent calls to the JIT are bypassed when this value is
> > non-NULL.  This leads to a situation where the main program and its
> > func[0] counterpart are both in the bpf kallsyms tree, but only func[0]
> > has an extable.  Extables are only created during JIT.  Now there are
> > two nearly identical program ksym entries in the tree, but only one has
> > an extable.  Depending upon how the entries are placed, there's a chance
> > that a fault will call search_extable on the aux with the NULL entry.
> > 
> > Since jit_subprogs already copies state from func[0] to the main
> > program, include the extable pointer in this state duplication.  The
> > alternative is to skip adding the main program to the bpf_kallsyms
> > table, but that would mean adding a check for subprograms into the
> > middle of bpf_prog_load.
> 
> I think having two early identical program ksym entries is bad.
> When people 'cat /proc/kallsyms | grep <their program name>',
> they will find two programs with identical kernel address but different
> hash value. This is just very confusing. I think removing the
> duplicate in kallsyms is better from user's perspective.

Thanks for all the feedback.

In terms of resolving this confusion my inclination is to use the main
program. That way users see in kallsyms the same tag that is reported by
bpftool.  On the other hand, the tag in kallsyms won't match the sha1 of
that actual chunk of code.  Is anything relying on the hash in the tag
and the digest of the code agreeing?

-K

