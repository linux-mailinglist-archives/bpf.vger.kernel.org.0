Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB05544C8DF
	for <lists+bpf@lfdr.de>; Wed, 10 Nov 2021 20:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbhKJTTn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Nov 2021 14:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232244AbhKJTTm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Nov 2021 14:19:42 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFC4C061764
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 11:16:54 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id z6so3525364pfe.7
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 11:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/RXq1qB/rHnOoJKPinntNIPHQAA7cSWx22w33fl3PNA=;
        b=VZcdqKN2AG/3VK8Sk6NtH17em49FemMxiWyhW6RIznoeZtkAt9MKh7zSbnzTiUM6CX
         gPe+/9mLEIpCv55ACeScybaY12N5i1bVatVYo5cX6JU+UMfIu9mqgmHl5FH0SEL8+64A
         xbASPWx1s4s2TIFJ6f5VMVWoA7r86CTWEJEiENQA2jZkDc9FciMmwKGTav2IcKKxHA8r
         mW65S5d2SdPrPABaFPWYSssllMkC88Y86ND4/H8kwM0jEx3OhxeOIOwQEhFNyIFVcY2n
         pRw0MLEOp0VRWenSo6Z7jp8uDNfvZby8YJLFbwKCnepAAXYODyHmJ1+xlrN1RFBq03N7
         J1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/RXq1qB/rHnOoJKPinntNIPHQAA7cSWx22w33fl3PNA=;
        b=nXpd9WY8f8B4g6o4V5aiTevcFOiQwcGyhUBwA7h6HcO6gmuRWRmUyo4MnvBeFuuZcV
         8B0jTg+XoP6m8Z0jQZ7oTYOe6YtN9Mnz7PqYNLzUGQ0iCUCxOKv0BldIu8Z5OUsNiOYc
         pYn/R2WBxwlvMwGy2ptnImm5RaSc0tn7y8EWYqAYehTv8CKyIAggrKeqJqreUhZU/+pT
         936cmS1fiTDXCOZFh5jhmO+dQyNVv1yD3QZr8zw90+sTm3eW3KXo0J+s0UTII7qEpiDJ
         EtTVNk1PoduCTNq7cXt1KMTLlI1TxbhaaFvb/RPSLmD8eD59L2MXfYCzuV5Zd9dgF3+P
         ka7A==
X-Gm-Message-State: AOAM530pzi0CfINluqIxKSln1AfbJI5w9YUepzBZIn29de4d/yyNdiaJ
        6z/sKTYKo/pPunwoamLIhyRZciccvhijLOD4ghw=
X-Google-Smtp-Source: ABdhPJydQ1SDenCDX0QpQyIqAlW3DNgZBC/keXnmZBefQFfbfIhQcbShcNzmc6DHQMeBFQg55uTgAv2lK9x3l/inDaA=
X-Received: by 2002:a05:6a00:1583:b0:49f:dc1c:a0fe with SMTP id
 u3-20020a056a00158300b0049fdc1ca0femr1481646pfk.46.1636571814372; Wed, 10 Nov
 2021 11:16:54 -0800 (PST)
MIME-Version: 1.0
References: <CACAyw99hVEJFoiBH_ZGyy=+oO-jyydoz6v1DeKPKs2HVsUH28w@mail.gmail.com>
 <CAADnVQKsK_2HHfOLs4XK7h_LC4+b7tfFw9261Psy5St8P+GWFA@mail.gmail.com>
 <CACAyw9_GmNotSyG0g1OOt648y9kx5Bd72f58TtS-QQD9FaV06w@mail.gmail.com>
 <20211105194952.xve6u6lgh2oy46dy@ast-mbp.dhcp.thefacebook.com>
 <CACAyw99KGdTAz+G3aU8G3eqC926YYpgD57q-A+NFNVqqiJPY3g@mail.gmail.com>
 <20211110042530.6ye65mpspre7au5f@ast-mbp.dhcp.thefacebook.com>
 <CACAyw9-s0ahY8m7WtMd1OK=ZF9w5gS9gktQ6S8Kak2pznXgw0w@mail.gmail.com>
 <20211110165044.kkjqrjpmnz7hkmq3@ast-mbp.dhcp.thefacebook.com> <7e7f180c-6cf6-ba86-e8fd-49b3b291e81e@leemhuis.info>
In-Reply-To: <7e7f180c-6cf6-ba86-e8fd-49b3b291e81e@leemhuis.info>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 10 Nov 2021 11:16:43 -0800
Message-ID: <CAADnVQ+1xY2fGKH2=VxeukSwBUc0D=+6ChqCgwEMPGMPKeKiOA@mail.gmail.com>
Subject: Re: Verifier rejects previously accepted program
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Lorenz Bauer <lmb@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        bpf <bpf@vger.kernel.org>, regressions@lists.linux.dev,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 10, 2021 at 10:01 AM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
>
>
> On 10.11.21 17:50, Alexei Starovoitov wrote:
> > On Wed, Nov 10, 2021 at 11:41:09AM +0000, Lorenz Bauer wrote:
> >>
> >> uid changes on every invocation, and therefore regsafe() returns false?
> >
> > That's correct.
> > Could you please try the following fix.
> > I think it's less risky and more accurate than what I've tried before.
> >
> >>From be7736582945b56e88d385ddd4a05e13e4bc6784 Mon Sep 17 00:00:00 2001
> > From: Alexei Starovoitov <ast@kernel.org>
> > Date: Wed, 10 Nov 2021 08:47:52 -0800
> > Subject: [PATCH] bpf: Fix inner map state pruning regression.
> >
> > Fixes: 3e8ce29850f1 ("bpf: Prevent pointer mismatch in bpf_timer_init.")
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>
> Thanks for working on a fix for this regression. There is one small
> detail that afaics could be improved (maybe you left that for later, if
> that's the case please simply stop reading and ignore this mail):
>
> The commit message would benefit from a link to the regression report.
> This is explained in Documentation/process/submitting-patches.rst, which
> recently was changed slightly to make this aspect clearer:
> https://git.kernel.org/linus/1f57bd42b77c

I don't think you're familiar with bpf process of applying patches.
Please take a look at bpf tree.
The 'Link:' exists for every commit.
