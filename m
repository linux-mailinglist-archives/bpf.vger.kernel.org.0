Return-Path: <bpf+bounces-9407-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 662EC797353
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 17:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FE5C281637
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 15:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2BD125A3;
	Thu,  7 Sep 2023 15:23:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE12023C3
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 15:23:31 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E32197
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 08:23:28 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2bd0a5a5abbso19357801fa.0
        for <bpf@vger.kernel.org>; Thu, 07 Sep 2023 08:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1694100206; x=1694705006; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XeBbVRtX/aIWzlXHiHUn4OCigEvkTh1dLDX2VajCG9M=;
        b=MgqjFiMnGi3jBTk4Lnje2FGFkbBD4OREe8+LLmBVgrEpSyY9vZ0fcqzYvwV6wAa/tg
         WSs5RItZlTGNIOAnIGR1VhtGeEAb5C16bVH+pq0t47B4e4XuQpiChv8KZeUt0Z9kzNUG
         De2aW1MyHfgCJ6ycqN7B55xI10hNxp3xvKJBJeNMxBTdox7q81F/5xQVbUQtdn6EEW9b
         dThlNo2JBM0KWvRBOkg+tZ54NOsSQuE21mLOLpgp3g/5T8oZqFv5qwwAoRmxckYk1yIA
         zBm83joNG+gJiaMg6l10TphVLwY5H6NtpspEO78WkcoRqp1GJfxIvcJqbiV+fKu9ao8h
         xMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694100206; x=1694705006;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XeBbVRtX/aIWzlXHiHUn4OCigEvkTh1dLDX2VajCG9M=;
        b=EzkGA6DqXx+BMVIFHFfb6qym/WL4e3CvbRV2O72AzCv2OUGC66fwoLTZjCKm/M4VTl
         R2KPeeYtFapWobrR7yKNIjDHV5+71xC6hStIbR71IqKHPI469aIHUWqpa36CELeGY/4t
         RaddogZ9dnLhgLTKzi6KKrolwzFRGRRQjq9DtiMmiNUlsoypw6mzu4gSZ6rJbszXtAuJ
         ly95EfeXHFAY7jpsuMo7fKPnk8rllkZ6exMnWz1aIWqsGw3WUh80tQkmd6Utp4gf/0Dy
         CmAOa4+yY/J1WD70wIRSg1Ymk+vJpRp0ctCNPZ+kbOpP2onWZzfjmJQtNptMXW6IS6Ib
         ogXg==
X-Gm-Message-State: AOJu0YyEd5GNlc99TNfRVZHdB8ikuEZD4slUQwG6Is8oN/J4ubtpc4YT
	ctbeGxcIKpZBOF8+2wjvkRFeSYkdX3uAZ9wohI8=
X-Google-Smtp-Source: AGHT+IGEGmreaznUgLT0wco7186DbxtRAxnnEI6albp1jZXrz+2WijzMa2iZXNVK2n5/iINTQ0Yxlw==
X-Received: by 2002:adf:fd4d:0:b0:316:fb57:26d1 with SMTP id h13-20020adffd4d000000b00316fb5726d1mr4496582wrs.8.1694076710917;
        Thu, 07 Sep 2023 01:51:50 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id l21-20020a1c7915000000b003fef6881350sm1853914wme.25.2023.09.07.01.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 01:51:50 -0700 (PDT)
Date: Thu, 7 Sep 2023 10:51:49 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, jrtc27@jrtc27.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, bpf@vger.kernel.org, Paul Walmsley <paul.walmsley@sifive.com>, 
	aou@eecs.berkeley.edu, peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com, 
	rostedt@goodmis.org, Ard Biesheuvel <ardb@kernel.org>, anup@brainfault.org, 
	atishp@atishpatra.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	bjorn@kernel.org, luke.r.nels@gmail.com, xi.wang@gmail.com, namcaov@gmail.com
Subject: Re: [PATCH 00/10] RISC-V: Refactor instructions
Message-ID: <20230907-304f53e7de4e0386d04f4dcf@orel>
References: <ZN5OJO/xOWUjLK2w@ghost>
 <mhng-7d609dde-ad47-42ed-a47b-6206e719020a@palmer-ri-x1c9a>
 <20230818-63347af7195b7385c146778d@orel>
 <ZPjKGd7VstwIKDV5@ghost>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPjKGd7VstwIKDV5@ghost>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 06, 2023 at 11:51:05AM -0700, Charlie Jenkins wrote:
> On Fri, Aug 18, 2023 at 09:30:32AM +0200, Andrew Jones wrote:
> > On Thu, Aug 17, 2023 at 10:52:22AM -0700, Palmer Dabbelt wrote:
> > > On Thu, 17 Aug 2023 09:43:16 PDT (-0700), Charlie Jenkins wrote:
> > ...
> > > > It seems to me that it will be significantly more challenging to use
> > > > riscv-opcodes than it would for people to just hand create the macros
> > > > that they need.
> > > 
> > > Ya, riscv-opcodes is pretty custy.  We stopped using it elsewhere ages ago.
> > 
> > Ah, pity I didn't know the history of it or I wouldn't have suggested it,
> > wasting Charlie's time (sorry, Charlie!). So everywhere that needs
> > encodings are manually scraping them from the PDFs? Or maybe we can write
> > our own parser which converts adoc/wavedrom files[1] to Linux C?
> > 
> > [1] https://github.com/riscv/riscv-isa-manual/tree/main/src/images/wavedrom
> 
> The problem with the wavedrom files is that there are no standard for
> how each instruction is identified. The title of of the adoc gives some
> insight and there is generally a funct3 or specific opcode that is
> associated with the instruction but it would be kind of messy to write a
> script to parse that. I think manually constructing the instructions is
> fine. When somebody wants to add a new instruction they probably will
> not need to add very many at a time, so it should be only a couple of
> lines that they will be able to test.
>

OK, we'll just have to prop our eyelids open with toothpicks to get
through the review of the initial mass conversion.

Thanks,
drew

