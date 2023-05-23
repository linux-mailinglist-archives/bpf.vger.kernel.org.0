Return-Path: <bpf+bounces-1133-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C39E70E670
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 22:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D96D7281496
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 20:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D3C422609;
	Tue, 23 May 2023 20:28:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 273F11F957
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 20:28:39 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4495B129
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 13:28:37 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id E748AC1522C2
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 13:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1684873716; bh=pHUSWz84y/K+jFJzdGeKSbAFEuKeFhqcs357Mc906Xg=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=o9z7/1LtW9w8nMj/Rok92qvW/pAh7qDSIQbY3CU6toP+hr5ME95wX9/w6fJA88UjT
	 EThFfq34u4NT8iJK0j063bqVVwiz4UY44U9f8UbG9EfnRUlBFdtTy5H85h8P+Zdh35
	 N5scJJ+HbDyl1Kdc+sFp9pclTZ1mfb0QQSjHUN+E=
X-Mailbox-Line: From bpf-bounces@ietf.org  Tue May 23 13:28:36 2023
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id AF7CEC15107A;
	Tue, 23 May 2023 13:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1684873716; bh=pHUSWz84y/K+jFJzdGeKSbAFEuKeFhqcs357Mc906Xg=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=o9z7/1LtW9w8nMj/Rok92qvW/pAh7qDSIQbY3CU6toP+hr5ME95wX9/w6fJA88UjT
	 EThFfq34u4NT8iJK0j063bqVVwiz4UY44U9f8UbG9EfnRUlBFdtTy5H85h8P+Zdh35
	 N5scJJ+HbDyl1Kdc+sFp9pclTZ1mfb0QQSjHUN+E=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id ED55BC15107A
 for <bpf@ietfa.amsl.com>; Tue, 23 May 2023 13:28:34 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -1.547
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dmYeZOE0Rogk for <bpf@ietfa.amsl.com>;
 Tue, 23 May 2023 13:28:31 -0700 (PDT)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 6EBA3C14CEFF
 for <bpf@ietf.org>; Tue, 23 May 2023 13:28:31 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-3f6aa6171a6so2087611cf.1
 for <bpf@ietf.org>; Tue, 23 May 2023 13:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684873710; x=1687465710;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:mime-version:references:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PU/NLuQUlhscdkbhjCJlX82IImb++V3dtI5rcUtW5BU=;
 b=THBofuWcykuKDf/tB0YMvqzQJvxPjVnNV3r6Ps2fFfHN7v+cNdXIi/Tio/UnFlHynj
 q5aX3ex/MHTiAjLm93idKHecXWaePRRzFBkfDyS4lOK4u+YXqv/mbG7CfxPmQucVV3ng
 F8hy7nDBSNV0CXLPaRIINOuPZZ5092pwZhhwZHVh5LmqtMvctvIc2R67acMkz+6MLLxC
 z3Tzbg6VZRbhzrF5dZLGPu8DfbGLKmez7ROmp99QgIsI9I+ZrcZ4viG1EMgFkx8rjuUL
 oFXkVzp52r/gIi7HQYLrsWp6LcqXgn9O0oWzL+SmwcMWYcZ56hbWwUpX7+aT60nU4pJJ
 7SkQ==
X-Gm-Message-State: AC+VfDxXI8pvBJFLQXPPFeb7jvo25reVXgm1kQ5rj0+jgxhiyyiSfRdz
 Sv0yGpQaJQC15VASyzE3bsQ=
X-Google-Smtp-Source: ACHHUZ712wC5k92k+wbFQ8O1cQS+W1/eynD0uWjaM69uJohdw9fcuc8acodueq6rSirV7XFBneflHg==
X-Received: by 2002:ac8:57d3:0:b0:3e4:e801:471c with SMTP id
 w19-20020ac857d3000000b003e4e801471cmr22908925qta.19.1684873710122; 
 Tue, 23 May 2023 13:28:30 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:5c45])
 by smtp.gmail.com with ESMTPSA id
 cp11-20020a05622a420b00b003e89e2b3c23sm3163691qtb.58.2023.05.23.13.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 13:28:29 -0700 (PDT)
Date: Tue, 23 May 2023 15:28:27 -0500
From: David Vernet <void@manifault.com>
To: Michael Richardson <mcr+ietf@sandelman.ca>
Cc: "bpf@ietf.org" <bpf@ietf.org>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, "Jose E. Marchesi" <jemarch@gnu.org>,
 Erik Kline <ek.ietf@gmail.com>,
 "Suresh Krishnan (sureshk)" <sureshk@cisco.com>,
 Christoph Hellwig <hch@infradead.org>, Dave Thaler <dthaler@microsoft.com>
Message-ID: <20230523202827.GA33347@maniforge>
References: <PH7PR21MB38780769D482CC5F83768D3CA37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
 <87v8grkn67.fsf@gnu.org>
 <PH7PR21MB3878BCFA99C1585203982670A37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
 <87r0rdy26o.fsf@gnu.org>
 <PH7PR21MB3878B869D69FD35FA718AF5DA37FA@PH7PR21MB3878.namprd21.prod.outlook.com>
 <20230523163200.GD20100@maniforge> <18272.1684864698@localhost>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <18272.1684864698@localhost>
User-Agent: Mutt/2.2.10 (2023-03-25)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/-vlWqLUXU7qlExyOIrfR0vX3uis>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, May 23, 2023 at 01:58:18PM -0400, Michael Richardson wrote:
> =

> David Vernet <void@manifault.com> wrote:
>     > As far as I know (please correct me if I'm wrong), there isn't real=
ly a
>     > precedence for standardizing ABIs like this. For example, x86 calli=
ng
> =

> All of the eBPF work seems unprecedented.
> I don't see having this in the charter is a problem.
> =

> We may fail to get consensus on it, and not make a milestone, but I don't=
 see
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

> =

> --
> Michael Richardson <mcr+IETF@sandelman.ca>   . o O ( IPv6 I=F8T consultin=
g )
>            Sandelman Software Works Inc, Ottawa and Worldwide
> =

> =

> =

> =




> -- =

> Bpf mailing list
> Bpf@ietf.org
> https://www.ietf.org/mailman/listinfo/bpf

-- =

Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

