Return-Path: <bpf+bounces-1132-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F343270E66F
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 22:28:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 487991C20DF3
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 20:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F65922605;
	Tue, 23 May 2023 20:28:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6B21F957
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 20:28:33 +0000 (UTC)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AAD129
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 13:28:31 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-3f6915ca22eso2230821cf.0
        for <bpf@vger.kernel.org>; Tue, 23 May 2023 13:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684873710; x=1687465710;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PU/NLuQUlhscdkbhjCJlX82IImb++V3dtI5rcUtW5BU=;
        b=OvzMMWOfBcQyfLYqsUAHxAf5UKkWx54WvWIBz7dTQGs+lXqs68hRO/dMiwzoXWzGN6
         PeuDyOReO8YGT9sQqKYlM+hlytHCNztkUiFB5gzGtCYug5fXW58y1XTpoRXph6OUBH16
         mmXBHL4IJza7wZSgb9/UX0N44O0Beo5AfomTkr7S2ViosxE6b2+j/RUV6TIIW5zoSRgc
         /655tY/LVr01rj4xJXpBP8dm1akSDyAAGgNueF4SGornVI+cw797pgvMMaaqfFxd9H/s
         bnVqGeJrbhYiMgK17lQw5ZZfxkSv9wnJY7ImM8dZhUyHVpYnnPLvzutdRi5tYzZW5r9h
         Plzg==
X-Gm-Message-State: AC+VfDwHtBm7sHw4XY5mpsZlAkxKhJO5ohW/+Jz7PKCJh44GlWIYkDXb
	plMIxpL2OtR/nOH3tUKhdh8=
X-Google-Smtp-Source: ACHHUZ712wC5k92k+wbFQ8O1cQS+W1/eynD0uWjaM69uJohdw9fcuc8acodueq6rSirV7XFBneflHg==
X-Received: by 2002:ac8:57d3:0:b0:3e4:e801:471c with SMTP id w19-20020ac857d3000000b003e4e801471cmr22908925qta.19.1684873710122;
        Tue, 23 May 2023 13:28:30 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:5c45])
        by smtp.gmail.com with ESMTPSA id cp11-20020a05622a420b00b003e89e2b3c23sm3163691qtb.58.2023.05.23.13.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 13:28:29 -0700 (PDT)
Date: Tue, 23 May 2023 15:28:27 -0500
From: David Vernet <void@manifault.com>
To: Michael Richardson <mcr+ietf@sandelman.ca>
Cc: "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Erik Kline <ek.ietf@gmail.com>,
	"Suresh Krishnan (sureshk)" <sureshk@cisco.com>,
	Christoph Hellwig <hch@infradead.org>,
	Dave Thaler <dthaler@microsoft.com>
Subject: Re: [Bpf] IETF BPF working group draft charter
Message-ID: <20230523202827.GA33347@maniforge>
References: <PH7PR21MB38780769D482CC5F83768D3CA37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
 <87v8grkn67.fsf@gnu.org>
 <PH7PR21MB3878BCFA99C1585203982670A37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
 <87r0rdy26o.fsf@gnu.org>
 <PH7PR21MB3878B869D69FD35FA718AF5DA37FA@PH7PR21MB3878.namprd21.prod.outlook.com>
 <20230523163200.GD20100@maniforge>
 <18272.1684864698@localhost>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18272.1684864698@localhost>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, May 23, 2023 at 01:58:18PM -0400, Michael Richardson wrote:
> 
> David Vernet <void@manifault.com> wrote:
>     > As far as I know (please correct me if I'm wrong), there isn't really a
>     > precedence for standardizing ABIs like this. For example, x86 calling
> 
> All of the eBPF work seems unprecedented.
> I don't see having this in the charter is a problem.
> 
> We may fail to get consensus on it, and not make a milestone, but I don't see
> a reason not to be allowed to talk about this.
> (and maybe in the end, it's a no-op)

Hi Michael,

So apologies in advance if my lack of experience with IETF proceedings
is glaringly obvious, and I'd appreciate clarification in any situation
in which I'm mistaken.

My understanding based on the conversations that I've had thus far is
that part of the goal of arriving at the finalized WG charter is to
determine what's in scope and out of scope. It's a bit of a murky
proposition because some things that we think _could_ be in scope, such
as in this case topics related to psABI, may not end up having a
document if we can't get consensus. In other words, being in the WG
charter doesn't imply that something is in-scope and will have a
document written, but _not_ being in the charter does preclude it from
being discussed in this iteration of the WG because of this line:

> The working group shall not adopt new work until these
> documents have progressed to working group last call.

The implication of this is that it's not necessarily a problem to have
some false-positives in terms of what we cover, but it can be
problematic if we leave out something important because we'll have to
cover all of the other topics first. I'd imagine this would tend to make
the default behavior for deciding scope in WG charters to be permissive
rather than dissmive, which makes sense to me.

Assuming I haven't already gone off the rails in terms of my
understanding, let me try to clarify why despite all that, I still think
it's warranted for us to remove psABI as part of the scope of the WG.
There are really two main reasons:

1. As is hopefully clear at this point, there is a wide and historical
   industry precedence for not standardizing on psABI. For example, to
   my knowledge, RISC-V [0] develops and ratifies the RISC-V ISA through
   the RISC-V International Technical Working Groups, but there is no
   such ratified standard or specification for RISC-V calling
   conventions (the operative word of course being "convention"). The
   same is true (to my knowledge) of _all_ psABI ELF extensions, as Jose
   pointed out earlier in the conversation.

[0]: https://riscv.org/technical/specifications/

   With all that said, unless there's more context behind why we think we
   need to standardize psABI which hasn't yet been brought forward, I
   don't see any way we'd achieve consensus when we discuss it in the
   WG. And the reason I specifically think that's the case for ABI (ELF
   or otherwise) is that there's such a well-established precedence
   already for not standardizing it. I guess it's true that there's no
   harm in including it and discussing it, but as things currently
   stand, it also doesn't seem very productive to include it if there's
   already (IMHO) reasonably clear evidence that it's out of scope. To
   go back to my claim made in another email, I think the onus is on the
   folks who think it's in scope to explain why, rather than the folks
   who think we should follow industry precedence to justify that.

2. Assuming that I'm wrong, and ABI / ELF are in scope for
   standardization, we would still have to do a lot of premliminary
   work to determine that. For example, we may end up wanting to
   standardize that maps are put into .maps sections in an ELF file, but
   that would only make sense if we created a document standardizing
   cross-platform map types. The same holds true for cross-platform
   program types, etc. The dependency DAG for discussing ELF has a depth
   of at least 2, and given that it's as-yet unclear whether ELF / psABI
   is an appropriate topic for standardization in the first place, it
   really feels to me like leaving it out of the WG is the right move.

Thanks,
David

> 
> --
> Michael Richardson <mcr+IETF@sandelman.ca>   . o O ( IPv6 IøT consulting )
>            Sandelman Software Works Inc, Ottawa and Worldwide
> 
> 
> 
> 



> -- 
> Bpf mailing list
> Bpf@ietf.org
> https://www.ietf.org/mailman/listinfo/bpf


