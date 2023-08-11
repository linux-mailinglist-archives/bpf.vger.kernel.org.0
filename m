Return-Path: <bpf+bounces-7596-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 205F3779604
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 19:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE9D2282437
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 17:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CE2219D3;
	Fri, 11 Aug 2023 17:21:22 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E5E1172F
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 17:21:21 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAA930CD
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 10:21:19 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5841be7d15eso23775657b3.2
        for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 10:21:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691774479; x=1692379279;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pXPGMYl+Um9Suj2eKbpL2yH2IeMxL4HkaLB/aol2J90=;
        b=KxCOkDXGMJsnLw8DlceSma0udEay8DuN9xunThbzV++HGpT/fJ7nbIxevNnGTeCsgK
         iyyPILmr8qC46gpG1qnDIs2SZ7Za6rSGsxcsBmissnkVYlFbhB4g+bY55z4JuD4R4OnE
         MOYvKhKlTTPrC4XXGYr4KbGDy70HsMnLA/FdD1Q8W1BqOrpqYl30TW3rwzw3yfa7Qyim
         DC40va1gOfJjkkjiXW7fF1rZwIiCX6DMcGjjCQxbstz9IFMbt8bBxI5qYg2LhJvlkMzu
         oMjJxVn7TBz+iGmo1Bu/hviC9mTykNSUgjkoFTausOes+bQSKJDFG8X6F+E+CqljnowM
         Qphg==
X-Gm-Message-State: AOJu0Yyi4WAxlmC3PDkH1Hk61wPZ4+Aqo8aPnyVdxY0BS2XDstk1cK6e
	IsWRsH973bd+UXNPwGLbOTA=
X-Google-Smtp-Source: AGHT+IE/plexj042A4WnLi49Lo4hP8apDVXjeVpxS1ldybq3FVRtuoFYx6k7dWEAEyFf0OafvdLkFQ==
X-Received: by 2002:a05:690c:3389:b0:579:f5c2:b16e with SMTP id fl9-20020a05690c338900b00579f5c2b16emr2931672ywb.31.1691774478964;
        Fri, 11 Aug 2023 10:21:18 -0700 (PDT)
Received: from maniforge ([24.1.27.177])
        by smtp.gmail.com with ESMTPSA id g19-20020a815213000000b0057d24f8278bsm1100597ywb.104.2023.08.11.10.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 10:21:18 -0700 (PDT)
Date: Fri, 11 Aug 2023 12:21:16 -0500
From: David Vernet <void@manifault.com>
To: Watson Ladd <watsonbladd@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Dave Thaler <dthaler@microsoft.com>,
	Christoph Hellwig <hch@infradead.org>,
	"bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [Bpf] Review of draft-thaler-bpf-isa-01
Message-ID: <20230811172116.GC542801@maniforge>
References: <CACsn0ckZO+b5bRgMZhOvx+Jn-sa0g8cBD+ug1CJEdtYxSm_hgA@mail.gmail.com>
 <PH7PR21MB3878D8DCEF24A5F8E52BA59DA303A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <CAADnVQJ1fKXcsTXdCijwQzf0OVF0md-ATN5RbB3g10geyofNzA@mail.gmail.com>
 <CACsn0cmf22zEN9AduiRiFnQ7XhY1ABRL=SwAwmmFgxJvVZAOsg@mail.gmail.com>
 <CAADnVQ+O0CZQ1-5+dBiPWgZig3MVRX92PWPwNCrL7rG+4Xrbag@mail.gmail.com>
 <CACsn0cmvuGBKd3erDQKugygZfhT-Cu8xYBJ3hCETp6a-1HNbYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsn0cmvuGBKd3erDQKugygZfhT-Cu8xYBJ3hCETp6a-1HNbYw@mail.gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URI_DOTEDU autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 01, 2023 at 07:33:59PM -0700, Watson Ladd wrote:
> In reply to a long conversation:
> <snip>
> >
> > Could you please be specific which instruction in table 4 is not obvious?
> 
> The question isn't obvious, the question is unambigious, and C is not
> great for this. Maybe with a reference and some text it would get
> better.
> >
> > > >
> > > > > > The good news is I think this is very fixable although tedious.
> > > > > >
> > > > > > The other thornier issues are memory model etc. But the overall structure seems good
> > > > > > and the document overall makes sense.
> > > >
> > > > What do you mean by "memory model" ?
> > > > Do you see a reference to it ? Please be specific.
> > >
> > > No, and that's the problem. Section 5.2 talks about atomic operations.
> > > I'd expect that to be paired with a description of barriers so that
> > > these work, or a big warning about when you need to use them.
> >
> > That's a good suggestion.
> > A warning paragraph that BPF ISA does not have barrier instructions
> > is necessary.
> >
> > > For
> > > clarity I'm pretty unfamiliar with bpf as a technology, and it's
> > > possible that with more knowledge this would make sense. On looking
> > > back on that I don't even know if the memory space is flat, or
> > > segmented: can I access maps through a value set to dst+offset, or
> > > must I always used index? I'm just very confused.
> >
> > flat vs segmented is an orthogonal topic.
> > We definitely need to cover it in the architecture doc.
> > BPF WG charter requires us to produce it as Informational doc eventually.
> 
> Huh? If you access memory through specialized descriptors+offsets
> that's very different from arbitrary computations with addresses, even
> if they do trap. A little explanation might orient the reader to
> understand what is going on. As is I thought "ok, it's flat" and then
> saw the maps and really got thrown for a loop.
> 
> >
> > As far as memory model BPF adopts LKMM (Linux Kernel Memory Model).
> > https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2020/p0124r7.html
> >
> > We can add a reference to it from BPF ISA doc, but since
> > there are no barrier instructions at the moment the memory model
> > statement would be premature.
> > The work on "BPF Memory Model" have been ongoing for quite some time.
> > For example see:
> > https://lpc.events/event/11/contributions/941/attachments/859/1667/bpf-memory-model.2020.09.22a.pdf
> >
> > BPF Memory Model is certainly an important topic, but out of scope for ISA.
> 
> I expect that an ISA defines the semantics of the instructions. Which
> absolutely includes the memory model.  Now maybe we're envisioning a
> different splitting of this information, but I don't see how it can't
> be at a different level if you want to give the instructions
> semantics.

Hello Watson,

Thank you for sharing your thoughts on the ISA standard document thus
far. I tend to agree with you that defining a memory model (including a
memory consistency model) is inevitable, and I think it will be critical
for ensuring source code compatibility between different BPF
implementations. That said, I'm not sure that it needs to be a blocker
to us ratifying this initial proposed standard (not that you said that
explicitly) for the ISA, for a couple of reasons.

Firstly and perhaps most importantly, there is a precedence for ISA
standards evolving, sometimes significantly, as the platforms and
ecosystems surrounding a standard mature. RISC-V is an excellent example
of this. The 2.0 version of the Unprivileged ISA standard [0] published
in 2019 included_many changes that were not present in the initial
publication [1] of the standard in 2011.

[0]: https://github.com/riscv/riscv-isa-manual/releases/download/Ratified-IMAFDQC/riscv-spec-20191213.pdf
[1]: https://people.eecs.berkeley.edu/~krste/papers/EECS-2011-62.pdf

Note, for example, that the RVWMO  (RISC-V Weak Memory Ordering) Memory
Consistency Model was not ratified until v2.0 of the standard, which was
8 years following the publication of v1. Subsection 2.8 in v1.0 does
describe a Memory Model, but it's very high level, and doesn't even
mention e.g. device I/O. This is despite the v1.0 publication describing
"Atomic Memory Operation Instructions" as follows (excluding the diagram
showing the encoding which I won't take the time to type out in
plaintext form):

> The atomic memory operation (AMO) instructions perform
> read-modify-write operations for multiprocessor synchronization and
> are encoded with an R-type instruction format. These AMO instructions
> atomically load a data value from the address in rs1, place the value
> into register rd, apply a binary operator to the loaded value and the
> value in rs2, then store the result back to the address in rs1. AMOs
> can either operate on 32-bit or 64-bit words in memory. For RV64,
> 32-bit AMOs always sign-extend the value placed in rd. The address
> held in rs1 must be naturally aligned to the size of the operand
> (i.e., eight-byte aligned for 64-bit words and four-byte aligned for
> 32-bit words). If the address is not naturally aligned, a misaligned
> address trap will be generated.  The operations supported are integer
> add, logical AND, logical OR, swap, and signed and unsigned integer
> maximum and minimum.

This is in contrast to v2.0, which dedicates the entirety of Chapter 8:
"A" Standard Extension for Atomic Instructions, Version 2.1 to
discussing and formalizing atomic instructions.

That's all to say, I don't think we need to have a full and "feature
complete" ISA standard for our initial ratification. Speaking for
myself, I think it would be prudent for us to actually hold off on
defining some of these finer points like the memory model until we've
had more time to think about what the proper memory model would look
like for BPF rather than just standardizing what industry has built thus
far.

What we _definitely_ need to think through completely in this early
stage is how we're going to enable extensions to the standard, because
no matter how much work we put into this version, we're inevitably going
to have to write extensions (not that you're claiming otherwise).

In my personal opinion, I think standardizing instruction encoding and
semantics is a reasonable first step. Which leads me to my other reason
why I don't think it's necessary to formally define a memory model for
v1:

One of the unique challenges we're going to have to work through as a
Working Group is how to collaborate between the IETF and Linux Kernel
communities. I think we're doing a great job so far, especially given
how things went at IETF 117, and that folks from both communities are
already engaging on the standard. That said, I am personally of the
opinion that we're most likely to succeed in figuring out an ideal
working relationship / culture for the WG if we can do so while
iterating on a standard that has a minimal amount of complexity, and a
lower likelihood of being contentious.

That of course doesn't mean that we should sacrifice the quality of
whatever standard(s) we write and ratify, but I think that if we can
write a standard that we agree is correct, self-contained, well-written,
and can be easily extended, but that is also "non-controversial" (e.g.
for the case of the ISA, defines instruction encodings that are
implemented by clang and gcc, and whose semantics are implemented by
Linux, Microsoft, Netronome, etc), that it may be prudent to take
advantage of that in these early days to flesh out how our WG will
operate when we have to write more open-ended and potentially
contentious parts of the standard such as the BPF memory model.

What do you think? Thanks again for sharing your thoughts, and for
participating in the WG.

- David

