Return-Path: <bpf+bounces-1104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 340D970E1D0
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 18:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE862281474
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 16:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43BF1F194;
	Tue, 23 May 2023 16:32:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D872069F
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 16:32:06 +0000 (UTC)
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F45C2
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 09:32:04 -0700 (PDT)
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-75b00e5f8e4so6799085a.0
        for <bpf@vger.kernel.org>; Tue, 23 May 2023 09:32:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684859524; x=1687451524;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2fxaaxZmnkZ6/IheHqrPi/4FP/lLx6cJmznjM+Jz/cU=;
        b=j/6H7HPxFGlEDNwMLQPWCxzhZqkpyi9y5NMttax1rkrHQy22v/tE+BobB99x4LtE3p
         IbciK0NA6hTRNJhEilkUq08sEJmcUR51Ul5lTp8BCnYsTuvkF9dVKm1WZmHNHlYuM8ZQ
         4fEyz38+SbSYeMIMIm7YGiTTZYgpRU8grzZafnq1QPg20oSFp5OKI3/FpinBRscxRREn
         i6SpLdPRrbeK51kRd9uQosGoZTD74fVk0gXT9DGAe/Oh0fCIoN0BJp9FV/TdzhVTL95m
         j88PEOrY1RVrK4NrLKRemBr9+fhzb4Fs62RF7gwPyEIBjoGB3L55ty8eWPSfjbDFMFp8
         FJPw==
X-Gm-Message-State: AC+VfDzchga4Qgp0JrAfLdl7fcwso9ARvXUew4q73xGJdKpHWD8Trftk
	tVClqdLPn7DOtADpUZEpq5I=
X-Google-Smtp-Source: ACHHUZ5rWPuUauTb5eE9Xh6sGhOy0DHmGAQS2gxUEGH8U/A67JLtx7HbZrPrnbzc1XoQchjZ81IwdQ==
X-Received: by 2002:a37:c16:0:b0:75b:23a0:d9e2 with SMTP id 22-20020a370c16000000b0075b23a0d9e2mr4226770qkm.56.1684859523560;
        Tue, 23 May 2023 09:32:03 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:5c45])
        by smtp.gmail.com with ESMTPSA id m6-20020ae9e006000000b0074e4b1fe0aesm2608428qkk.94.2023.05.23.09.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 09:32:03 -0700 (PDT)
Date: Tue, 23 May 2023 11:32:00 -0500
From: David Vernet <void@manifault.com>
To: Dave Thaler <dthaler=40microsoft.com@dmarc.ietf.org>
Cc: "Jose E. Marchesi" <jemarch@gnu.org>, "bpf@ietf.org" <bpf@ietf.org>,
	bpf <bpf@vger.kernel.org>, Erik Kline <ek.ietf@gmail.com>,
	"Suresh Krishnan (sureshk)" <sureshk@cisco.com>,
	Christoph Hellwig <hch@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>
Subject: Re: [Bpf] IETF BPF working group draft charter
Message-ID: <20230523163200.GD20100@maniforge>
References: <PH7PR21MB38780769D482CC5F83768D3CA37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
 <87v8grkn67.fsf@gnu.org>
 <PH7PR21MB3878BCFA99C1585203982670A37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
 <87r0rdy26o.fsf@gnu.org>
 <PH7PR21MB3878B869D69FD35FA718AF5DA37FA@PH7PR21MB3878.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR21MB3878B869D69FD35FA718AF5DA37FA@PH7PR21MB3878.namprd21.prod.outlook.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, May 18, 2023 at 07:42:11PM +0000, Dave Thaler wrote:
> Jose E. Marchesi <jemarch@gnu.org> wrote:
> > I would think that the way the x86_64, aarch64, risc-v, sparc, mips, powerpc
> > architectures, along with their variants, handle their ELF extensions and
> > psABI, ensures interoperability good enough for the problem at hand, but ok.
> > I'm definitely not an expert in these matters.
> 
> I am not familiar enough with those to make any comment about that.

Hi Dave,

Taking a step back here, perhaps we need to think about all of this more
generically as "ABI", rather than ELF "extensions", "bindings", etc.  In
my opinion this would include, at a minimum, the following items from
the current proposed WG charter:

* the eBPF bindings for the ELF executable file format,

* the platform support ABI, including calling convention, linker
  requirements, and relocations,

As far as I know (please correct me if I'm wrong), there isn't really a
precedence for standardizing ABIs like this. For example, x86 calling
conventions are not standardized.  Solaris, Linux, FreeBSD, macOS, etc
all follow the System V AMD64 ABI, but Microsoft of course does not. As
Jose pointed out, such standards extensions do not exist for psABI ELF
extensions for various architectures either.

While it may be that we do end up needing to standardize these ABIs for
BPF, I'm beginning to think that we should just remove them from the
current WG charter, and consider standardizing them at a later time if
it's clear that it's actually necessary. I think this is especially true
given that we don't seem to be getting any closer to having consensus,
and that we're very short on time given that Erik is going to be
proposing the charter to the rest of the ADs in just two days on 5/25.

Thanks,
David

