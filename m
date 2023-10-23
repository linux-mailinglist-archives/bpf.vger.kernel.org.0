Return-Path: <bpf+bounces-13060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D007D429B
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 00:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0A0B1C20A32
	for <lists+bpf@lfdr.de>; Mon, 23 Oct 2023 22:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3126241F1;
	Mon, 23 Oct 2023 22:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3FF2376D
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 22:15:48 +0000 (UTC)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B7AFF
	for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 15:15:46 -0700 (PDT)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-66d1a05b816so27707816d6.1
        for <bpf@vger.kernel.org>; Mon, 23 Oct 2023 15:15:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698099345; x=1698704145;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E6B+Zv4N2u3nsJJpruO+pOD6moI9VuvybD1oyXiZQvo=;
        b=rWWo4Ar7S0+DtoPz7fyKmqPKPWFmC6WjjF3iOEsDCe+z+NA4BJFEP8XlofkkZPsByG
         uXEfsIfU7vP1U4FW2xr33j3i5+aK9heUfwJR8HiTy63pwEVNSQxO2E3aSWYpNAbpatw5
         wSuASArePU0LfUHJrQ0xVdgT3+vIAkdfw6jcWodwT3g0Wao1aKFqKmVZGr7c89Tg+i8l
         sqhazDGKkJRCSmO/yP3YHXi+iwn92HhGj4+4ROmq8J3IQ6jkMcXB7IE5vAciUFZgEvgD
         cOK1LLGLJmNcHcvmXoLhd6oADA8kPmSrXK8Hw8//xphza2xA2l2l3mEDn0s75RqrBRTG
         AfaA==
X-Gm-Message-State: AOJu0YyQvlqYYPiuHXImvcSCvsxp2E61IxGUNqN/WCzpnz1vLLVX9snN
	x40WBjYlJOq4jnY7/yKC/KY=
X-Google-Smtp-Source: AGHT+IEMqmqUkf3DruAD4pL/wDt/xxAkQFOdHqJJMsoC82d3fXH1DyFDHBCyVPd48H48s/AoAUf7Rg==
X-Received: by 2002:a05:6214:2427:b0:66d:a4d:84f7 with SMTP id gy7-20020a056214242700b0066d0a4d84f7mr11772722qvb.28.1698099345303;
        Mon, 23 Oct 2023 15:15:45 -0700 (PDT)
Received: from maniforge (c-24-1-27-177.hsd1.il.comcast.net. [24.1.27.177])
        by smtp.gmail.com with ESMTPSA id cu7-20020a05621417c700b0066cfd398ab5sm3118706qvb.146.2023.10.23.15.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 15:15:43 -0700 (PDT)
Date: Mon, 23 Oct 2023 17:15:40 -0500
From: David Vernet <void@manifault.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Dave Thaler <dthaler@microsoft.com>, "bpf@ietf.org" <bpf@ietf.org>,
	bpf <bpf@vger.kernel.org>
Subject: Re: [Bpf] ISA RFC compliance question
Message-ID: <20231023221540.GE32029@maniforge>
References: <PH7PR21MB387850B8DB6A2A5FB87DAC06A3C0A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <PH7PR21MB3878027C6E6FB01651023912A3C0A@PH7PR21MB3878.namprd21.prod.outlook.com>
 <CAADnVQL69iqzxsNRDLKW22B=3sJpO0Yy2yHzioWZmhtQvUwtTQ@mail.gmail.com>
 <PH7PR21MB3878A25F817337EF14FE039FA3CAA@PH7PR21MB3878.namprd21.prod.outlook.com>
 <CAADnVQ+BOdrU4x3qKHJVbpZCJwTWe6HXWhuMqOk-x5UK22yPDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+BOdrU4x3qKHJVbpZCJwTWe6HXWhuMqOk-x5UK22yPDQ@mail.gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)

On Fri, Oct 06, 2023 at 04:06:53PM -0700, Alexei Starovoitov wrote:
> On Thu, Oct 5, 2023 at 1:14 PM Dave Thaler <dthaler@microsoft.com> wrote:
> >
> > > Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > > On Fri, Sep 29, 2023 at 1:17 PM Dave Thaler
> > > <dthaler=40microsoft.com@dmarc.ietf.org> wrote:
> > > > Now that we have some new "v4" instructions, it seems a good time to
> > > > ask about what it means to support (or comply with) the ISA RFC once
> > > > published.  Does it mean that a verifier/disassembler/JIT compiler/etc. MUST
> > > support *all* the
> > > > non-deprecated instructions in the document?   That is any runtime or tool that
> > > > doesn't support the new instructions is considered non-compliant with the BPF
> > > ISA?
> > [...]
> > > > Or should we create some things that are SHOULDs, or finer grained
> > > > units of compliance so as to not declare existing deployments non-compliant?
> > >
> > > I suspect 'non-compliance' label will cause an unnecessary backlash, so I would
> > > go with SHOULD wording.
> >
> > Yeah, but if each instruction is a separate SHOULD, then a runtime could (say)
> > support one atomic instruction and not others.  Having that level of granularity
> > would really complicate interoperability and cross-platform tooling in my opinion.
> > So it might be better to list groups of instructions and have the SHOULD be at the
> > granularity of a group?
> 
> I guess we can group them based on LLVM evolution of the instruction set:
> -mcpu=v1,v2,v3,v4
> but it would have mainly historical benefits and not practical.

We will discuss more at IETF 118, but I agree that grouping based on
LLVM instruction set releases is not a good idea. It's the same
sentiment for why we don't want to standardize the .maps ELF section
just because it's what libbpf expects.

> Grouping atomic vs not is not realistic either, since atomic_xadd
> was there since the very beginning.

This might be a dumb question, but I'm not sure I'm following why it
being introduced since the beginning would preclude it from being
SHOULD?

> I suspect any kind of grouping scheme will end up in bike shedding.
> My preference would be to agree on either SHOULD or MUST for
> all insns currently described in ISA doc.

SHOULD for all instructions seems very risky for compliance. Wouldn't
that functionally make the standard entirely optional?

> We can go with MUST to force compliance.
> Some archs, OSes, JITs won't be compliant in the short term,
> but MUST wording will be a good motivation to do the work now instead of later.

This seems like the overall lowest risk to me, though there are some
nuances we'll have to consider. For example, it would require that all
platforms support BTF in order to be compliant with BPF_CALL by BTF ID.
Realistically that seems desirable. Unless there are groups of
instructions that could be submitted logically as their own separate
extensions, being consistent with MUST seems like the least error prone
approach.

Thanks,
David

