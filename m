Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4BBE44694D
	for <lists+bpf@lfdr.de>; Fri,  5 Nov 2021 20:49:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbhKETwg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Nov 2021 15:52:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbhKETwf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Nov 2021 15:52:35 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DDC5C061714
        for <bpf@vger.kernel.org>; Fri,  5 Nov 2021 12:49:56 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o10-20020a17090a3d4a00b001a6555878a8so4084056pjf.1
        for <bpf@vger.kernel.org>; Fri, 05 Nov 2021 12:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gXlN5FZf8wjatJCZa1cF2r5Z+UdMJg7+lQZ4SVQt93Q=;
        b=oTbQ0d/+lTXVt3GBVKXQT/pp6n7r3RqdQEjEw2JoDqFrPTYGX2FQVokdLUtDEsVZ40
         6qSS0kGc4WYQcSBq0r0SJN7kgc3ePYAI4H2FCJ6mEeZ6CJ6BML/ra3wBXUXWjqrMLQ9k
         VLvyOOj3KNOvrQ/noz1Am8T6a8+1qu6bzRfZKIjWh8Xp3tKbcTQXWcJgAwEBj2tRRhZI
         nQK9qzH+Qp66ipCPBTCaK4ED0BqcuN+4BkY25VPS1E63k8n1TeGknM5WN28vRFtu2Ms/
         BsyaU2DVJz6BjvhEw7etyuFA7Oizm4jALNXV5VS1vAonicz/NXulFY8b5noLBIVxtoZA
         Hl4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gXlN5FZf8wjatJCZa1cF2r5Z+UdMJg7+lQZ4SVQt93Q=;
        b=tV5oSDYyrLV6D/mFN1VikXDnfAm2nMi/5eTloICxQ4QjnxjlFe8KCjbfR3d+5Exn6l
         piqZT9NA4tmNZ/SePbEfexlGAaDo3fENMrNcfnUk0sgAiXZOkZ5m+HgA8H50kB+zl/wR
         IlztrQ0NoiVwM8Fvt3Q0x4Gu0bdfDC2vssioKTJ4EclfiBYQeOXtuvcx0wVMgETaiCT3
         rP4jyO0N8lSRbZ7B5C7nheLGD9gLoSrt+A23cqgwZT/hPGhG8t3x3jB2FTuzrMrQKnhS
         7ZFnpBSqQEQJL/W0Xm8fex+5x252IoJ27BMoPSLLIDAZOOyT0tBMBEX7EtaHLts15aBk
         RyLA==
X-Gm-Message-State: AOAM532sKHhaI6nqbAMFuL52gE0FUjDa6foTIp2gqgZDcSkI6cxhe2UK
        wz8QU52f6P2nq5+sFXdRO/nlGRtFIso=
X-Google-Smtp-Source: ABdhPJy1Jei+Ck+ketcco+bQgcpLPAwEzazIAeUVp/5E9QSv4AGBr/NiprU6POJCCiUC+Nuv4ORNvQ==
X-Received: by 2002:a17:90a:f182:: with SMTP id bv2mr32222695pjb.139.1636141795300;
        Fri, 05 Nov 2021 12:49:55 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:808])
        by smtp.gmail.com with ESMTPSA id mg12sm9813843pjb.10.2021.11.05.12.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 12:49:55 -0700 (PDT)
Date:   Fri, 5 Nov 2021 12:49:52 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        bpf <bpf@vger.kernel.org>, regressions@lists.linux.dev,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: Verifier rejects previously accepted program
Message-ID: <20211105194952.xve6u6lgh2oy46dy@ast-mbp.dhcp.thefacebook.com>
References: <CACAyw99hVEJFoiBH_ZGyy=+oO-jyydoz6v1DeKPKs2HVsUH28w@mail.gmail.com>
 <CAADnVQKsK_2HHfOLs4XK7h_LC4+b7tfFw9261Psy5St8P+GWFA@mail.gmail.com>
 <CACAyw9_GmNotSyG0g1OOt648y9kx5Bd72f58TtS-QQD9FaV06w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACAyw9_GmNotSyG0g1OOt648y9kx5Bd72f58TtS-QQD9FaV06w@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 05, 2021 at 10:41:40AM +0000, Lorenz Bauer wrote:
> 
> bpf-next with f30d4968e9ae on top:
> 
>     works!

Awesome.

> commit 3e8ce29850f1 ("bpf: Prevent pointer mismatch in
> bpf_timer_init.") (found via bisection):
> 
>     BPF program is too large. Processed 1000001 insn
> 
> commit 3e8ce29850f1^ ("bpf: Add map side support for bpf timers."):
> 
>    works!

So with just 3e8ce29850f1 it's "too large" and with parent commit it works ?
I've analyzed offending commit again and don't see how it can be causing
state pruning to be more conservative for your asm.
reg->map_uid should only be non-zero for lookups from inner maps,
but your asm doesn't have lookups at all in that loop.
Maybe in some case map_uid doesn't get cleared, but I couldn't find
such code path with manual code analysis.
I think it's worth investigating further.
Please craft a reproducer.
