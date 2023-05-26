Return-Path: <bpf+bounces-1325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFAA712BA1
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 19:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEFDA1C2110F
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 17:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EFC28C23;
	Fri, 26 May 2023 17:19:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF6C2CA6
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 17:19:59 +0000 (UTC)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7212C1B1
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 10:19:33 -0700 (PDT)
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-75b3645fb1fso121680585a.1
        for <bpf@vger.kernel.org>; Fri, 26 May 2023 10:19:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685121572; x=1687713572;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wbDQtFpjPgfxrzi2lMXXqeaTE0rEM6xDO1oipT+ez5A=;
        b=ixdwoi33ul1rvbVmkgWXdAGpsWM+It6PbfdSsmAIQzvZ9TwJYo501DOKCfFdapub/9
         Nd5H8w4FmZCKUcXCFQUsZvrdFhJx92Rn3J6O3fuqCHxZFndVkw0vp0rhZug3JatzL1WS
         5ajoLjHV1quBV2WoBoPWOJSysacpQ+cKQmfLwljak1CNawGooEvjYbbKm7LT/Lhf6NFC
         WPearetjfR1ywDAMkiCcgNFQ/UZhqBIYlscNxB8UVhpsbHt+QlP/Ti+itXbh3Wq8tKzo
         PaGrZffdMfY6sMkTnD4fjmfmo4NB4vt0xNgtds2GJhWu+/FkU0p95Eb57L/J6AyCDwWV
         3pFA==
X-Gm-Message-State: AC+VfDxVfJ1LwGkaXnlmwJLfilmgGEOLC1KUes6b5y9ORXNdoHxiHErO
	jUB2CYbYQJ51rzVaZSxOyZEZOQjXktpFUw==
X-Google-Smtp-Source: ACHHUZ7e6yuvFViApkFf/8nuTNm/ttPOkI/RCt8nQ2R0OoR/HO0baOQ904kXQvbCd6yfIFLgLf20JA==
X-Received: by 2002:a05:6214:400d:b0:623:9a41:ea00 with SMTP id kd13-20020a056214400d00b006239a41ea00mr2313235qvb.22.1685121572214;
        Fri, 26 May 2023 10:19:32 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:5368])
        by smtp.gmail.com with ESMTPSA id t29-20020a05620a035d00b0075b27186d9asm1287788qkm.106.2023.05.26.10.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 10:19:31 -0700 (PDT)
Date: Fri, 26 May 2023 12:19:29 -0500
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler@microsoft.com>
Cc: "Jose E. Marchesi" <jemarch@gnu.org>,
	Christoph Hellwig <hch@infradead.org>,
	Michael Richardson <mcr+ietf@sandelman.ca>,
	"bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>, Erik Kline <ek.ietf@gmail.com>,
	"Suresh Krishnan (sureshk)" <sureshk@cisco.com>,
	Lorenz Bauer <oss@lmb.io>
Subject: Re: [Bpf] IETF BPF working group draft charter
Message-ID: <20230526171929.GB1209625@maniforge>
References: <87r0rdy26o.fsf@gnu.org>
 <PH7PR21MB3878B869D69FD35FA718AF5DA37FA@PH7PR21MB3878.namprd21.prod.outlook.com>
 <20230523163200.GD20100@maniforge>
 <18272.1684864698@localhost>
 <20230523202827.GA33347@maniforge>
 <ZG8R3JgOPHo7xn61@infradead.org>
 <87y1lclnui.fsf@gnu.org>
 <PH7PR21MB38781A9FBC44A275FDF3D5F6A347A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <20230526165511.GA1209625@maniforge>
 <PH7PR21MB3878E80B01C2AA8273131D7CA347A@PH7PR21MB3878.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR21MB3878E80B01C2AA8273131D7CA347A@PH7PR21MB3878.namprd21.prod.outlook.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, May 26, 2023 at 05:01:57PM +0000, Dave Thaler wrote:
> David Vernet writes:
> [...]
> > I'd like to highlight this line in particular:
> > 
> > > This means any version of this specification published at the above
> > > link can be regarded as stable in the technical sense of the word (but
> > > not necessarily in the official RISC-V International specification
> > > state meaning), with the official specification state being an
> > > indicator of the completeness, clarity and general editorial quality
> > > of the specification.
> > 
> > To my reading, this sounds a lot more like a (strongly advised) informational
> > document, than a formal standard.
> > 
> > > The eBPF Foundation could publish the equivalent of the
> > > riscv-calling.pdf document above, but we (the IETF and BPF
> > > communities) decided the IETF was the best place to publish such
> > > documents.  As such, I envision an IETF RFC for the BPF calling convention
> > that is very similar to the RISC-V standard one above.
> > >
> > > Given the precedent, and the need in BPF, I don't see a problem.
> > 
> > Just to make sure we're all on the same page here: Are you proposing that we
> > publish a formal standard for psABI specifications, or are you proposing we
> > publish an informationl document?
> 
> In an email last week to the list I mentioned Informational as a possibility.
> I don't have a strong preference, but I have a weak preference for Proposed
> Standard status.

Thanks for clarifying. Erik, Suresh and I met yesterday to try and find
a middle ground that addresses everyone's concerns, and we came up with
[0].

[0]: https://github.com/ekline/bpf/blob/ekline-patch-1/charter-ietf-bpf.txt#L31

Does that sound reasonable to you?

I must admit that I feel quite strongly that a Proposed Standard is not
the right move for now. Many of the existing ABI conventions that exist
today are simply artifacts of somewhat arbitrary choices that were made
early-on in libbpf. I say "arbitrary" here not to imply that they
weren't well thought out, but rather just to say that like many other
decisions in software projects, they were made somewhat organically and
without the benefit of hindsight and a larger corpus of participants.

> As an implementer, I would want to make sure that ebpf-for-windows,
> PREVAIL, and uBPF all do the same thing, ideally matching Linux for everything
> the former projects support, to allow using consistent tooling.

I completely understand the motivation. Hopefully an Information
document will address those concerns? Let me know what you think.

- David

