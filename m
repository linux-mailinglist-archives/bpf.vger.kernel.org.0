Return-Path: <bpf+bounces-1321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EC9712B2A
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 18:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72E501C21018
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 16:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB2F2773F;
	Fri, 26 May 2023 16:55:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5470B2CA6
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 16:55:22 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732A9D9
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 09:55:20 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 58184C151B0A
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 09:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1685120120; bh=O76se+Uie5VRyimTA4YtQJcGVJ6uHPLPmqsV2l9QcBc=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=r3bNxNfkzOhJc8I2h6DDffihqcxYINbHuWDJ8p4OUJFjX2rt5iGnUqyNPoVjdXMd6
	 qxlygXll9lCZhmZyX2fJbrYwYMTUt3w9xGzu7NnfmU5e22HL5lDmtWNsq5rGQQjAxB
	 K7RH9GNdvSpdNdWAC40YV3F6AG6LKF2GBFeEQQSs=
X-Mailbox-Line: From bpf-bounces@ietf.org  Fri May 26 09:55:20 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 2BEA9C151545;
	Fri, 26 May 2023 09:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1685120120; bh=O76se+Uie5VRyimTA4YtQJcGVJ6uHPLPmqsV2l9QcBc=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=r3bNxNfkzOhJc8I2h6DDffihqcxYINbHuWDJ8p4OUJFjX2rt5iGnUqyNPoVjdXMd6
	 qxlygXll9lCZhmZyX2fJbrYwYMTUt3w9xGzu7NnfmU5e22HL5lDmtWNsq5rGQQjAxB
	 K7RH9GNdvSpdNdWAC40YV3F6AG6LKF2GBFeEQQSs=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 4CCCBC151545
 for <bpf@ietfa.amsl.com>; Fri, 26 May 2023 09:55:19 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -6.55
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sp7ldOvSF1pZ for <bpf@ietfa.amsl.com>;
 Fri, 26 May 2023 09:55:15 -0700 (PDT)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com
 [209.85.219.43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 7CB64C151540
 for <bpf@ietf.org>; Fri, 26 May 2023 09:55:15 -0700 (PDT)
Received: by mail-qv1-f43.google.com with SMTP id
 6a1803df08f44-625482282e0so9808406d6.3
 for <bpf@ietf.org>; Fri, 26 May 2023 09:55:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685120114; x=1687712114;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pej7uehq1a3dcas91hkYMfaWRaQPKZANl+3z417trqg=;
 b=RUBy371L6Uv+wtYnzEdg3leINi2PD2/nmpFz0FLTDIQzmN9MlNvkO3gO7QtIQemubk
 y88DtY0M6T7HlNSuyl5aHrK2TBtQIJE0alvqYCkM/thLMi4InjMW6l6w+ViY9wBAqJfz
 HCtkLkmhlu9XpSGakKNWCFjfeSyllp4dM7wG+4A3+xCtTycSqZz1R2xDA7nuTwVLHrGx
 c5ZP5yH8NkljmiFwC++ELORL+L9r5g55VEECCDqZKkcyMNwBKvUzDHabObMj9FNWU7Jl
 +mAYXL2RezbmhqzW1g0yb6GicpcQ0oDqS2eKDkEoJ6fmryC/pq7qzelGk1gmNhrnKx3p
 v5ag==
X-Gm-Message-State: AC+VfDxMB7nWtBa47hf4AMXn7km820zBIVPyX4ieb1pRtc5eI9U6kc6s
 F8Y2q4D+ofRqrjwdRIueAA4=
X-Google-Smtp-Source: ACHHUZ5vZ6/iOJX7UeJhg3o+iDqe5yIPEzR7DYFr7+R0jvn8qvwOopxyyFEVylnXtwfvSZ8U8ePWzQ==
X-Received: by 2002:a05:6214:20ae:b0:5e9:2d8c:9a21 with SMTP id
 14-20020a05621420ae00b005e92d8c9a21mr2219631qvd.32.1685120114151; 
 Fri, 26 May 2023 09:55:14 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:5368])
 by smtp.gmail.com with ESMTPSA id
 d3-20020a0cf6c3000000b00625b2f59d3fsm1327407qvo.96.2023.05.26.09.55.13
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
Message-ID: <20230526165511.GA1209625@maniforge>
References: <87v8grkn67.fsf@gnu.org>
 <PH7PR21MB3878BCFA99C1585203982670A37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
 <87r0rdy26o.fsf@gnu.org>
 <PH7PR21MB3878B869D69FD35FA718AF5DA37FA@PH7PR21MB3878.namprd21.prod.outlook.com>
 <20230523163200.GD20100@maniforge> <18272.1684864698@localhost>
 <20230523202827.GA33347@maniforge> <ZG8R3JgOPHo7xn61@infradead.org>
 <87y1lclnui.fsf@gnu.org>
 <PH7PR21MB38781A9FBC44A275FDF3D5F6A347A@PH7PR21MB3878.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <PH7PR21MB38781A9FBC44A275FDF3D5F6A347A@PH7PR21MB3878.namprd21.prod.outlook.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/trZXC9WWzsTXSsal_hiphfoG2oY>
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

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

