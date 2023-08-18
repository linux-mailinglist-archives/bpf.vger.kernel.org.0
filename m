Return-Path: <bpf+bounces-8103-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC3A781403
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 22:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 693BA1C21600
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 20:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E5E1BEF5;
	Fri, 18 Aug 2023 19:59:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A561BEE8
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 19:59:42 +0000 (UTC)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1461706
	for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 12:59:41 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4103c8157ccso8483491cf.1
        for <bpf@vger.kernel.org>; Fri, 18 Aug 2023 12:59:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692388780; x=1692993580;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M5ErGUEjSwHR/cJmJEzPuQ1g6S7P90KrVs1EyxEQC0A=;
        b=AEsL3x5ghHxpni3SlJizZ+8IKdJY14AHeecGhGfznirwoLojwWHIXtgjWA739xeaAf
         u0snuyj6+ZZo3IR/Q04ha8jFuy9Ze5oAikjyrXuG61a/GjZr/twni67G2WmKMQWZ8whP
         KCiBcXNf9WLuhOAhdfqgss2oWwHlZ4a2ScP6inPrs4H0F2kj4HY9ARcsbLSgM1GAJ3EU
         zDkDBIQNWHMm6138My7RFLytn0YgrP2rBXLP735RyNedTgx7mkylJmH6wK+wfr7mtUUK
         eWrHKmr4GtKTCG/jbkHVMsv7MHiwIwwpv6wozB20YbHmjYznKNlHdIGJs321wwCWz7Tv
         W5vA==
X-Gm-Message-State: AOJu0Yzhq3ZtNMJFyIsoH6v0RKF1qoQIX3rKT5JK39/ehBW+ZsFNiSMN
	hnZeCZnfhjXyWSb8WePIfWM=
X-Google-Smtp-Source: AGHT+IGlTobRFipdflEDnn3F0R+nnnGnNW+QTnFleu/xwvSbjEeINuMRXcx0ve7txYygJ69WUYwKRQ==
X-Received: by 2002:ac8:5f11:0:b0:40f:fe6b:6b5b with SMTP id x17-20020ac85f11000000b0040ffe6b6b5bmr149436qta.66.1692388780036;
        Fri, 18 Aug 2023 12:59:40 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:13f7])
        by smtp.gmail.com with ESMTPSA id hz6-20020a05622a678600b0040f8ac751a5sm717656qtb.96.2023.08.18.12.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 12:59:39 -0700 (PDT)
Date: Fri, 18 Aug 2023 14:59:37 -0500
From: David Vernet <void@manifault.com>
To: Watson Ladd <watsonbladd@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Dave Thaler <dthaler@microsoft.com>,
	Christoph Hellwig <hch@infradead.org>,
	"bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [Bpf] Review of draft-thaler-bpf-isa-01
Message-ID: <20230818195937.GD14411@maniforge>
References: <CACsn0ckZO+b5bRgMZhOvx+Jn-sa0g8cBD+ug1CJEdtYxSm_hgA@mail.gmail.com>
 <PH7PR21MB3878D8DCEF24A5F8E52BA59DA303A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <CAADnVQJ1fKXcsTXdCijwQzf0OVF0md-ATN5RbB3g10geyofNzA@mail.gmail.com>
 <CACsn0cmf22zEN9AduiRiFnQ7XhY1ABRL=SwAwmmFgxJvVZAOsg@mail.gmail.com>
 <CAADnVQ+O0CZQ1-5+dBiPWgZig3MVRX92PWPwNCrL7rG+4Xrbag@mail.gmail.com>
 <CACsn0cmvuGBKd3erDQKugygZfhT-Cu8xYBJ3hCETp6a-1HNbYw@mail.gmail.com>
 <20230811172116.GC542801@maniforge>
 <CACsn0cmbDGpj8R98=DF00-hhjAKph+kHofAs3LF=KKonFYZeuA@mail.gmail.com>
 <20230814161759.GF542801@maniforge>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814161759.GF542801@maniforge>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 14, 2023 at 11:17:59AM -0500, David Vernet wrote:
> On Fri, Aug 11, 2023 at 02:36:04PM -0700, Watson Ladd wrote:
> > Dear David,
> 
> Hi Watson,

Hi everyone,

Watson and I discussed this today in more detail over a call. I think
we're now on the same page, and I want to update the lists with where we
landed so others can weigh in. The TL;DR is that the ISA document as it
exists today is trying to toe the line between being two different types
of ISA documents:

1. An ARM/x86-esque ISA document that exists somewhat in isolation, and
   just defines the encodings and high-level semantics of instructions.
   For example, if you look at the ARM A64 Instruction Set Architecture
   for Armv8 and Armv8-A document, it literally just jumps straight into
   encodings and high-level semantics of the instructions. There's
   literally zero information about the ARM memory model, execution
   environment, etc. All of that is captured in separate architecture
   documents.

2. The RISC-V ISA model, which goes into significantly more detail on
   the architecture of RISC-V, and formalizes not just the instructions,
   but the execution and memory models, memory consistency model, etc.

I am (and I believe Watson is as well following our discussion) of the
opinion that our ISA document belongs squarely in the first category,
and shouldn't try to also fit into the second. We're defining the
instruction encodings, and describing their semantics at a high level
without much formality. This is intentional -- our WG charter specifies
many more documents that cover all of these details (some of which will
likely be contentious and require a lot of thought and discussion) in
the proper scopes. For example, our planned documents include but are
not limited to:

- [I] an architecture and framework document

- one or more documents that recommend conventions and guidelines
  for producing portable BPF program binaries

- [PS] cross-platform map types allowing native data structure access
  from BPF programs

- [PS] cross-platform helper functions, e.g., for manipulation of maps

- [PS] cross-platform BPF program types that define the higher level
  execution environment for BPF programs

With all that said, I think our ISA document would improve a lot with
the following changes:

1. Removing all the ABI-specific stuff from the ISA document.  For
   example, calling conventions need to go. This was discussed at IETF
   117, so should hopefully be non-controversial. I'll send a patch
   later that moves this to a separate abi.rst document that we can then
   fold into Will's work.

2. This wasn't discussed at IETF 117, but also removing extraneous
   verbiage such as the "Helper functions" and "Maps" paragraphs, and
   maybe more such as "Platform Variables". These blurbs are useful for
   giving some context on the actual instructions in the ISA, but
   they're insufficient on their own to be of practical use.

So the TL;DR is: let's make the ISA document just an ISA document.
We're in it for the long haul, and the time to properly introduce,
define, and explain all of these concepts is when we write the documents
that are meant to capture all of that information.

Watson -- please let me know if I've misrepresented anything. It would
be great to get others' thoughts as well.

Thanks,
David

