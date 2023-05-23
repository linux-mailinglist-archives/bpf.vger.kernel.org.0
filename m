Return-Path: <bpf+bounces-1115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D0570E2AA
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 19:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 138E11C20D35
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 17:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300132099F;
	Tue, 23 May 2023 17:15:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78334C91
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 17:15:56 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB04CDD
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 10:15:41 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 90B4BC151B20
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 10:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1684862141; bh=8AvN9bP+cMZNbmC2tyPE16eT9Qa+0IFz1x2lbQvZoFc=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=tuvagT/y4NEPp01GI+CfoeAsRQVQyBVEOVDAND6vE67bk7sOxwkpLCfIGyN4k7x7y
	 F8eEiJRhdAEuzInQDWH0MDDhG7BAvzeLgejunFystx3z9cC/LJIF5wU9taw1e5lgQt
	 fwL517LSfV/25XTuGBrvfpW/+nqzDttTVCpoEAmg=
X-Mailbox-Line: From bpf-bounces@ietf.org  Tue May 23 10:15:41 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 58019C151B19;
	Tue, 23 May 2023 10:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1684862141; bh=8AvN9bP+cMZNbmC2tyPE16eT9Qa+0IFz1x2lbQvZoFc=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=tuvagT/y4NEPp01GI+CfoeAsRQVQyBVEOVDAND6vE67bk7sOxwkpLCfIGyN4k7x7y
	 F8eEiJRhdAEuzInQDWH0MDDhG7BAvzeLgejunFystx3z9cC/LJIF5wU9taw1e5lgQt
	 fwL517LSfV/25XTuGBrvfpW/+nqzDttTVCpoEAmg=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 83267C151B19
 for <bpf@ietfa.amsl.com>; Tue, 23 May 2023 10:15:39 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -1.553
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6f20wMzLF2rC for <bpf@ietfa.amsl.com>;
 Tue, 23 May 2023 10:15:38 -0700 (PDT)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com
 [209.85.219.53])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id EE8D2C151B17
 for <bpf@ietf.org>; Tue, 23 May 2023 10:15:38 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id
 6a1803df08f44-62384e391e3so30880146d6.3
 for <bpf@ietf.org>; Tue, 23 May 2023 10:15:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684862138; x=1687454138;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jzwX9lPQLzVau85MHTcJvwi6e1QE4E+Sz4jt90QBFJU=;
 b=Qw30z0FqrMkz8EMrp7HclPLzl3j88UxVTXHq9ZaVFNjYBhG4ObB9krX73wI6cbuhm7
 MJ4Q9zgKyv0FGthOtnE45VbdWNGzejsBdAZE7Y+cyJd273GEQlcXrqlbqY6qsGlAE1CL
 qE6nA6cbdwUJgrE9TbIHL543BdRIxF6lQ6n9PeEbMxXRykUn3pPnKyLcmfmjUUb27HB9
 qB0W/LgGESyZ8YRlwNEs1rlrB+FvTlqfcu+ci5RJ+wtAKx8ULVtD/SzVUJyrE+emYuuo
 cO7vQPDZfiWRKhbhg5qwQxEEuYd3Db3BTTmwefF8Thv0IctGTWhY8FWW/CuL+d4/MthQ
 bnEg==
X-Gm-Message-State: AC+VfDzTUCEt+/WYd66lYYL0C5G81yab5Z/pbGBjpXCgG/NoLTCPqxAY
 WIz6woLBCajm4nbvmyxi8ao=
X-Google-Smtp-Source: ACHHUZ50iymqn6UihTef6RNDumL+R778PP8NJCVSfPLjpJaFThtS7qiZhhOVNA1+/kCL5MrvCuWtJw==
X-Received: by 2002:a05:6214:27ea:b0:619:a7e3:99e2 with SMTP id
 jt10-20020a05621427ea00b00619a7e399e2mr25165559qvb.17.1684862137745; 
 Tue, 23 May 2023 10:15:37 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:5c45])
 by smtp.gmail.com with ESMTPSA id
 v19-20020ad448d3000000b0061b698e2acesm2923417qvx.18.2023.05.23.10.15.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 10:15:37 -0700 (PDT)
Date: Tue, 23 May 2023 12:15:35 -0500
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler@microsoft.com>
Cc: "Jose E. Marchesi" <jemarch@gnu.org>, "bpf@ietf.org" <bpf@ietf.org>,
 bpf <bpf@vger.kernel.org>, Erik Kline <ek.ietf@gmail.com>,
 "Suresh Krishnan (sureshk)" <sureshk@cisco.com>,
 Christoph Hellwig <hch@infradead.org>, Alexei Starovoitov <ast@kernel.org>
Message-ID: <20230523171535.GE20100@maniforge>
References: <PH7PR21MB38780769D482CC5F83768D3CA37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
 <87v8grkn67.fsf@gnu.org>
 <PH7PR21MB3878BCFA99C1585203982670A37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
 <87r0rdy26o.fsf@gnu.org>
 <PH7PR21MB3878B869D69FD35FA718AF5DA37FA@PH7PR21MB3878.namprd21.prod.outlook.com>
 <20230523163200.GD20100@maniforge>
 <PH7PR21MB3878A4135C14B318DD43365CA340A@PH7PR21MB3878.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <PH7PR21MB3878A4135C14B318DD43365CA340A@PH7PR21MB3878.namprd21.prod.outlook.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/9wusDfZAxOWl_E-bTgl8X1v7JSU>
Subject: Re: [Bpf] IETF BPF working group draft charter
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: Discussion of BPF/eBPF standardization efforts within the IETF
 <bpf.ietf.org>
List-Unsubscribe: <https://www.ietf.org/mailman/options/bpf>,
 <mailto:bpf-request@ietf.org?subject=unsubscribe>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Subscribe: <https://www.ietf.org/mailman/listinfo/bpf>,
 <mailto:bpf-request@ietf.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, May 23, 2023 at 04:50:42PM +0000, Dave Thaler wrote:
> > -----Original Message-----
> > From: David Vernet <void@manifault.com>
> > Sent: Tuesday, May 23, 2023 9:32 AM
> > To: Dave Thaler <dthaler@microsoft.com>
> > Cc: Jose E. Marchesi <jemarch@gnu.org>; bpf@ietf.org; bpf
> > <bpf@vger.kernel.org>; Erik Kline <ek.ietf@gmail.com>; Suresh Krishnan
> > (sureshk) <sureshk@cisco.com>; Christoph Hellwig <hch@infradead.org>;
> > Alexei Starovoitov <ast@kernel.org>
> > Subject: Re: [Bpf] IETF BPF working group draft charter
> > 
> > On Thu, May 18, 2023 at 07:42:11PM +0000, Dave Thaler wrote:
> > > Jose E. Marchesi <jemarch@gnu.org> wrote:
> > > > I would think that the way the x86_64, aarch64, risc-v, sparc, mips,
> > > > powerpc architectures, along with their variants, handle their ELF
> > > > extensions and psABI, ensures interoperability good enough for the
> > problem at hand, but ok.
> > > > I'm definitely not an expert in these matters.
> > >
> > > I am not familiar enough with those to make any comment about that.
> > 
> > Hi Dave,
> > 
> > Taking a step back here, perhaps we need to think about all of this more
> > generically as "ABI", rather than ELF "extensions", "bindings", etc.  In my
> > opinion this would include, at a minimum, the following items from the current
> > proposed WG charter:
> > 
> > * the eBPF bindings for the ELF executable file format,
> > 
> > * the platform support ABI, including calling convention, linker
> >   requirements, and relocations,
> > 
> > As far as I know (please correct me if I'm wrong), there isn't really a precedence
> > for standardizing ABIs like this. For example, x86 calling conventions are not
> > standardized.  Solaris, Linux, FreeBSD, macOS, etc all follow the System V
> > AMD64 ABI, but Microsoft of course does not. As Jose pointed out, such
> > standards extensions do not exist for psABI ELF extensions for various
> > architectures either.
> > 
> > While it may be that we do end up needing to standardize these ABIs for BPF,
> > I'm beginning to think that we should just remove them from the current WG
> > charter, and consider standardizing them at a later time if it's clear that it's
> > actually necessary. I think this is especially true given that we don't seem to be
> > getting any closer to having consensus, and that we're very short on time given
> > that Erik is going to be proposing the charter to the rest of the ADs in just two
> > days on 5/25.
> > 
> > Thanks,
> > David
> 
> I can tell you it's very important to those who work on the ebpf-for-windows project that the ELF format is common between Linux and Windows so that tools like
> llvm-objdump and bpftool and other BPF-specific ELF parsing tools work for both
> Linux and Windows.   We don't want Windows to diverge.

Be that as it may, as I said before, to my knowledge there's no
precedence at all for standardizing ABI like this. Is there a reason
that you think Windows would diverge if we didn't standardize the ABI?

I realize that I'm essentially saying, "Hey, pretend there's a standard
and don't diverge", but if that's what the entire rest of the industry
has done up until this point with all other psABIs, then it seems like a
reasonable expectation.

> As such, I feel strongly that it is a requirement to be standardized right away.

I have to respectfully disagree. I think there are much bigger fish to
fry, such as standardizing the ISA. Unless we really have a good reason
for diverging from industry norms, standardizing on ABI now feels to me
like we're putting the cart before the horse.

Just to be very clear: I could be totally wrong here, and it could be
very important to deviate from industry norms and standardize ABI as
part of the initial WG charter. However, IMHO, a positive claim like
that needs to come with clear substantiation. The reality is that
deviating from industry norms and standardizing on ABI will have its own
costs and consequences.

> Hence I would not want this removed from the charter unless there's an effort
> to do it somewhere else right away, which would seem to increase the coordination
> burden.

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

