Return-Path: <bpf+bounces-1320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D14712B29
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 18:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 767941C20FD8
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 16:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DD5D27736;
	Fri, 26 May 2023 16:55:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59D62CA6
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 16:55:17 +0000 (UTC)
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49783135
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 09:55:15 -0700 (PDT)
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-625482282e0so9808416d6.3
        for <bpf@vger.kernel.org>; Fri, 26 May 2023 09:55:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685120114; x=1687712114;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pej7uehq1a3dcas91hkYMfaWRaQPKZANl+3z417trqg=;
        b=V9gtyz1fybVTEtFO0Q0XGEQWQ9hoxtu9MXUI5kOw1s8O39VO4pJdqqE06oLseuX3ap
         sjT4nRnSnhxx7vAgpLwVfAMgeRzsWoiJptPHthNCJ0py4EStlaKLvUE26tg9vhSuf91a
         rDcYGZ89Ba5m5EnLCtXE0ZgfRHpdCLFENlwWL8lJcoezYJ1NGfzX4Hhin/guhETpUEK7
         pg5M3qa0ciERUZdwbf72VfdKn1of2p4yEzS3BgMlxrAt3iQ6Zc2NolZ0iN6xJ3g83XZx
         b+/r8RNPVMg2RZxAsAh3rMBJ1TjDeNeYUmMIbN6f+qqBTfg/PK61//A8saqBr59cBsSs
         Nnkw==
X-Gm-Message-State: AC+VfDxQ8pS+cq+RI/6XvssVToDfr9Y82oDhw84txUqSY4BhVxR+XcYy
	eCTOJzA+ErtGjTPn2x4gqlE=
X-Google-Smtp-Source: ACHHUZ5vZ6/iOJX7UeJhg3o+iDqe5yIPEzR7DYFr7+R0jvn8qvwOopxyyFEVylnXtwfvSZ8U8ePWzQ==
X-Received: by 2002:a05:6214:20ae:b0:5e9:2d8c:9a21 with SMTP id 14-20020a05621420ae00b005e92d8c9a21mr2219631qvd.32.1685120114151;
        Fri, 26 May 2023 09:55:14 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:5368])
        by smtp.gmail.com with ESMTPSA id d3-20020a0cf6c3000000b00625b2f59d3fsm1327407qvo.96.2023.05.26.09.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 09:55:13 -0700 (PDT)
Date: Fri, 26 May 2023 11:55:11 -0500
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler@microsoft.com>
Cc: "Jose E. Marchesi" <jemarch@gnu.org>,
	Christoph Hellwig <hch@infradead.org>,
	Michael Richardson <mcr+ietf@sandelman.ca>,
	"bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>, Erik Kline <ek.ietf@gmail.com>,
	"Suresh Krishnan (sureshk)" <sureshk@cisco.com>
Subject: Re: [Bpf] IETF BPF working group draft charter
Message-ID: <20230526165511.GA1209625@maniforge>
References: <87v8grkn67.fsf@gnu.org>
 <PH7PR21MB3878BCFA99C1585203982670A37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
 <87r0rdy26o.fsf@gnu.org>
 <PH7PR21MB3878B869D69FD35FA718AF5DA37FA@PH7PR21MB3878.namprd21.prod.outlook.com>
 <20230523163200.GD20100@maniforge>
 <18272.1684864698@localhost>
 <20230523202827.GA33347@maniforge>
 <ZG8R3JgOPHo7xn61@infradead.org>
 <87y1lclnui.fsf@gnu.org>
 <PH7PR21MB38781A9FBC44A275FDF3D5F6A347A@PH7PR21MB3878.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR21MB38781A9FBC44A275FDF3D5F6A347A@PH7PR21MB3878.namprd21.prod.outlook.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, May 26, 2023 at 04:02:46PM +0000, Dave Thaler wrote:
> Jose E. Marchesi wrote: 
> > > I'm really lost in this discussion.  All aspects of the ABI are a
> > > required part of interoperability.  And one of the promises of this
> > > IETF eBPF project is to provide for this interoperability.
> > >
> > > This is a very different situation from the binary ABI for Linux or
> > > Windows, which has traditionally never been interoperable between
> > > vendors, odd examples like iBCS2 [1] notwithstanding.
> > 
> > The situation is not that different from the perspective of the producers of the
> > programs.  Even within the context of a single system the different vendors of
> > compilers, assemblers, linkers, libc, and other tools need to coordinate and
> > agree on conventions so they all produce compatible programs which are able
> > to interoperate and run on the system.
> > 
> > The psABI is what provides for this interoperability, and it works just fine.
> > 
> > None of these psABI are maintained as standards in the strong and strict sense
> > (ISO, ANSI, IETF, whatever) and I am just wondering about the convenience of
> > doing so for the BPF ABI, given the nature of these.
> 
> The RISC-V calling convention is indeed maintained as a standard.
> https://riscv.org/wp-content/uploads/2015/01/riscv-calling.pdf is the relevant
> document by RISC-V International which per https://riscv.org/about/ is a standards
> organization.  (I haven't participated in it, via the Confidential Computing Consortium I have interacted with some people who have.)

Dave,

The following is a quote from version 1.0 of the RISC-V ABI
Specification [0]:

[0]: https://github.com/riscv-non-isa/riscv-elf-psabi-doc/releases/download/v1.0/riscv-abi.pdf

> This specification is written in collaboration with the development
> communities of the major opensource toolchain and operating system
> communities, and as such specifies what has been agreed upon and
> implemented. As a result, any changes to this specification that are
> not backwards compatible would break ABI compatibility for those
> toolchains, which is not permitted unless for features explicitly
> marked as experimental, and so will not be made unless absolutely
> necessary, regardless of whether the specification is a pre-release
> version, ratified version or anything in between. This means any
> version of this specification published at the above link can be
> regarded as stable in the technical sense of the word (but not
> necessarily in the official RISC-V International specification state
> meaning), with the official specification state being an indicator of
> the completeness, clarity and general editorial quality of the
> specification.

I'd like to highlight this line in particular:

> This means any version of this specification published at the above
> link can be regarded as stable in the technical sense of the word (but
> not necessarily in the official RISC-V International specification
> state meaning), with the official specification state being an
> indicator of the completeness, clarity and general editorial quality
> of the specification.

To my reading, this sounds a lot more like a (strongly advised)
informational document, than a formal standard.

> The eBPF Foundation could publish the equivalent of the riscv-calling.pdf document
> above, but we (the IETF and BPF communities) decided the IETF was the best place
> to publish such documents.  As such, I envision an IETF RFC for the BPF calling
> convention that is very similar to the RISC-V standard one above.
> 
> Given the precedent, and the need in BPF, I don't see a problem.

Just to make sure we're all on the same page here: Are you proposing
that we publish a formal standard for psABI specifications, or are you
proposing we publish an informationl document?

Thanks,
David

> > I reckon the perspective from the system side may be different.
> > No more binary program solipsism :)
> > 
> > Example:
> > 
> > If I understood correctly from the thread, an IETF standard document is not
> > supposed to be updated regularly.  Instead, it is expected to be carefully
> > designed to rely on "codepoints" so all additions are optional and are released
> > in their own document or supplement.
> > 
> > As someone who uses ABIs on the toolchain side, and who contributes to some
> > of them, I am personally skeptical that schema can actually accomodate the
> > reality of an alive and evolving ABI, especially one as young as BPF.  The
> > resulting "authoritative" documents risk to be outdated more often than not,
> > and end being a curiosity that nobody actually uses.
> > 
> > I would be happy to be proved wrong, and of course the WG is free to not share
> > my concerns, but I have to voice them.
> 
> See the RISC-V document above.
> 
> Dave
> 

