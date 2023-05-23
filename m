Return-Path: <bpf+bounces-1123-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6301370E51D
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 21:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DC31281473
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 19:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F41E21CD8;
	Tue, 23 May 2023 19:08:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282641F934
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 19:08:20 +0000 (UTC)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21B2119
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 12:08:17 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-3f38a7c5d45so24095851cf.0
        for <bpf@vger.kernel.org>; Tue, 23 May 2023 12:08:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684868897; x=1687460897;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0EI+fHLpUVZG+VmRk8r0zhzsqkYH9/xeBmWXrFfPfZc=;
        b=KRl8zz9ndL7w+tzYUohK9U04P0rHhwdqn304sushspGEbVVbl0/Dapo+vydEkQlV+F
         L+UFq96xqqag9z02XbkrnYc6jXO71YrGozP+vtA6726zmOS6IFK+NnyJ2AhkgIg7elMa
         PAbFNs8ZVLi8uqKfd2Ce/3MAnp/3oMjP73kgbcXmpRVEeafwm+4AlVHeGht0ofWF/vxM
         imD3rrP6OauGgxIQbxhG7XN78q2EZXoxn47CjdnW6i71bpg4x4fX38f+Kb7G1/xn3Byp
         ikqkfNgRMFjJj+8nCqzl9O3T6VU/gdKVgb4YNRpyZSPItSvmx1iodAIV0SlG+pm0pCLZ
         x/1A==
X-Gm-Message-State: AC+VfDx1wIb+nDgMM5a4ClDzEucUNinfJ1wxId6vfX/W/4dxlaaNnh7R
	F/NfsNDHamfBIU/EqMv9LaY=
X-Google-Smtp-Source: ACHHUZ7i0sk8I5bqxumTaC+wlvuZbNrQxFwEOP2VZcaSdwBg+SAzd8e8yPjuJNEeMGolzPXSZdFGag==
X-Received: by 2002:a05:6214:20ef:b0:623:7108:362d with SMTP id 15-20020a05621420ef00b006237108362dmr27558746qvk.9.1684868896779;
        Tue, 23 May 2023 12:08:16 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:5c45])
        by smtp.gmail.com with ESMTPSA id o8-20020a0ccb08000000b00621268e14efsm2973902qvk.55.2023.05.23.12.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 12:08:16 -0700 (PDT)
Date: Tue, 23 May 2023 14:08:14 -0500
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler@microsoft.com>
Cc: "Jose E. Marchesi" <jemarch@gnu.org>, "bpf@ietf.org" <bpf@ietf.org>,
	bpf <bpf@vger.kernel.org>, Erik Kline <ek.ietf@gmail.com>,
	"Suresh Krishnan (sureshk)" <sureshk@cisco.com>,
	Christoph Hellwig <hch@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>
Subject: Re: [Bpf] IETF BPF working group draft charter
Message-ID: <20230523190814.GA32582@maniforge>
References: <PH7PR21MB38780769D482CC5F83768D3CA37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
 <87v8grkn67.fsf@gnu.org>
 <PH7PR21MB3878BCFA99C1585203982670A37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
 <87r0rdy26o.fsf@gnu.org>
 <PH7PR21MB3878B869D69FD35FA718AF5DA37FA@PH7PR21MB3878.namprd21.prod.outlook.com>
 <20230523163200.GD20100@maniforge>
 <PH7PR21MB3878A4135C14B318DD43365CA340A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <20230523171535.GE20100@maniforge>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523171535.GE20100@maniforge>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, May 23, 2023 at 12:15:35PM -0500, David Vernet wrote:
> On Tue, May 23, 2023 at 04:50:42PM +0000, Dave Thaler wrote:
> > > -----Original Message-----
> > > From: David Vernet <void@manifault.com>
> > > Sent: Tuesday, May 23, 2023 9:32 AM
> > > To: Dave Thaler <dthaler@microsoft.com>
> > > Cc: Jose E. Marchesi <jemarch@gnu.org>; bpf@ietf.org; bpf
> > > <bpf@vger.kernel.org>; Erik Kline <ek.ietf@gmail.com>; Suresh Krishnan
> > > (sureshk) <sureshk@cisco.com>; Christoph Hellwig <hch@infradead.org>;
> > > Alexei Starovoitov <ast@kernel.org>
> > > Subject: Re: [Bpf] IETF BPF working group draft charter
> > > 
> > > On Thu, May 18, 2023 at 07:42:11PM +0000, Dave Thaler wrote:
> > > > Jose E. Marchesi <jemarch@gnu.org> wrote:
> > > > > I would think that the way the x86_64, aarch64, risc-v, sparc, mips,
> > > > > powerpc architectures, along with their variants, handle their ELF
> > > > > extensions and psABI, ensures interoperability good enough for the
> > > problem at hand, but ok.
> > > > > I'm definitely not an expert in these matters.
> > > >
> > > > I am not familiar enough with those to make any comment about that.
> > > 
> > > Hi Dave,
> > > 
> > > Taking a step back here, perhaps we need to think about all of this more
> > > generically as "ABI", rather than ELF "extensions", "bindings", etc.  In my
> > > opinion this would include, at a minimum, the following items from the current
> > > proposed WG charter:
> > > 
> > > * the eBPF bindings for the ELF executable file format,
> > > 
> > > * the platform support ABI, including calling convention, linker
> > >   requirements, and relocations,
> > > 
> > > As far as I know (please correct me if I'm wrong), there isn't really a precedence
> > > for standardizing ABIs like this. For example, x86 calling conventions are not
> > > standardized.  Solaris, Linux, FreeBSD, macOS, etc all follow the System V
> > > AMD64 ABI, but Microsoft of course does not. As Jose pointed out, such
> > > standards extensions do not exist for psABI ELF extensions for various
> > > architectures either.
> > > 
> > > While it may be that we do end up needing to standardize these ABIs for BPF,
> > > I'm beginning to think that we should just remove them from the current WG
> > > charter, and consider standardizing them at a later time if it's clear that it's
> > > actually necessary. I think this is especially true given that we don't seem to be
> > > getting any closer to having consensus, and that we're very short on time given
> > > that Erik is going to be proposing the charter to the rest of the ADs in just two
> > > days on 5/25.
> > > 
> > > Thanks,
> > > David
> > 
> > I can tell you it's very important to those who work on the ebpf-for-windows project that the ELF format is common between Linux and Windows so that tools like
> > llvm-objdump and bpftool and other BPF-specific ELF parsing tools work for both
> > Linux and Windows.   We don't want Windows to diverge.
> 
> Be that as it may, as I said before, to my knowledge there's no
> precedence at all for standardizing ABI like this. Is there a reason
> that you think Windows would diverge if we didn't standardize the ABI?
> 
> I realize that I'm essentially saying, "Hey, pretend there's a standard
> and don't diverge", but if that's what the entire rest of the industry
> has done up until this point with all other psABIs, then it seems like a
> reasonable expectation.
> 
> > As such, I feel strongly that it is a requirement to be standardized right away.
> 
> I have to respectfully disagree. I think there are much bigger fish to
> fry, such as standardizing the ISA. Unless we really have a good reason
> for diverging from industry norms, standardizing on ABI now feels to me
> like we're putting the cart before the horse.

Hi Dave et al,

FYI, I just sent out a GitHub PR to remove these lines from the proposed
WG charter: https://github.com/ekline/bpf/pull/5/files. I thought it was
prudent to go ahead and open the PR now given how close we are to the
5/25 meeting, and that we don't seem to be any closer to getting
consensus here.

We can (and should) continue the discussion here, but my two cents is
that unless there's a strong reason to keep ABI standardization within
scope of the WG, that it makes sense to remove these bullets.

That said, if the discussion dies down and/or doesn't continue, IMHO it
would be prudent to merge the PR. I don't think our default position
should be to deviate from well-established industry-wide precedence,
with the onus being on those advocating for following industry norms to
prove that we don't need to discuss it. Again, I may be missing some
important context here, so apologies if that's the case.

Thanks,
David

> Just to be very clear: I could be totally wrong here, and it could be
> very important to deviate from industry norms and standardize ABI as
> part of the initial WG charter. However, IMHO, a positive claim like
> that needs to come with clear substantiation. The reality is that
> deviating from industry norms and standardizing on ABI will have its own
> costs and consequences.
> 
> > Hence I would not want this removed from the charter unless there's an effort
> > to do it somewhere else right away, which would seem to increase the coordination
> > burden.

