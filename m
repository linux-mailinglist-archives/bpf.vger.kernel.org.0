Return-Path: <bpf+bounces-11045-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF967B1B6F
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 13:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 67992282220
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 11:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF8A37CA4;
	Thu, 28 Sep 2023 11:54:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F7B18622
	for <bpf@vger.kernel.org>; Thu, 28 Sep 2023 11:54:09 +0000 (UTC)
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AF5F5;
	Thu, 28 Sep 2023 04:54:07 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1qlpah-0004NV-5c; Thu, 28 Sep 2023 13:53:59 +0200
Date: Thu, 28 Sep 2023 13:53:59 +0200
From: Florian Westphal <fw@strlen.de>
To: David Wang <00107082@163.com>
Cc: Daniel Xu <dxu@dxuuu.xyz>, Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH] uapi/netfilter: Change netfilter hook verdict code
 definition from macro to enum
Message-ID: <20230928115359.GB27208@breakpoint.cc>
References: <20230904130201.14632-1-00107082@163.com>
 <cc6e3tukgqhi5y4uhepntrpf272o652pytuynj4nijsf5bkgjq@rgnbhckr3p4w>
 <19d2362f.5c85.18a6647817b.Coremail.00107082@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19d2362f.5c85.18a6647817b.Coremail.00107082@163.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

David Wang <00107082@163.com> wrote:

Hello,

> At 2023-09-06 00:38:02, "Daniel Xu" <dxu@dxuuu.xyz> wrote:
> >Hi David,
> >
> >On Mon, Sep 04, 2023 at 09:02:02PM +0800, David Wang wrote:
> 
> >>  #include <linux/in6.h>
> >>  
> >>  /* Responses from hook functions. */
> >> -#define NF_DROP 0
> >> -#define NF_ACCEPT 1
> >> -#define NF_STOLEN 2
> >> -#define NF_QUEUE 3
> >> -#define NF_REPEAT 4
> >> -#define NF_STOP 5	/* Deprecated, for userspace nf_queue compatibility. */
> >> -#define NF_MAX_VERDICT NF_STOP
> >> +enum {
> >> +	NF_DROP        = 0,
> >> +	NF_ACCEPT      = 1,
> >> +	NF_STOLEN      = 2,
> >> +	NF_QUEUE       = 3,
> >> +	NF_REPEAT      = 4,
> >> +	NF_STOP        = 5,	/* Deprecated, for userspace nf_queue compatibility. */
> >> +	NF_MAX_VERDICT = NF_STOP,
> >> +};
> >
> >Switching from macro to enum works for almost all use cases, but not
> >all. If someone if #ifdefing the symbols (which is plausible) this
> >change would break them.
> >
> >I think I've seen some other networking code define both enums and
> >macros. But it was a little ugly. Not sure if that is acceptable here or
> >not.
> >
> >[...]
> >
> >Thanks,
> >Daniel
> 
> 
> Thanks for the review~
> I do not have a strong reasoning to deny the possibility of breaking unexpected usage of this macros,
> 
> but I also agree that it is ugly to use both enum and macro at the same time.
> 
> Kind of don't know how to proceed from here now...

I was about to apply this as-is, but Pablo Neira would prefer to
keep the defines as well.

So, as a compromise, I would suggest to just *add*

/* verdicts available to BPF are exported via vmlinux.h */
enum {
	NF_DROP = 0,
	NF_ACCEPT = 1,
};

#define NF_DROP 0
...

This way BTF won't have the other verdicts, but ATM those
cannot be used in BPF programs anyway.

Would you mind making a new version of the patch?
Otherwise I can mangle it locally here as needed.

