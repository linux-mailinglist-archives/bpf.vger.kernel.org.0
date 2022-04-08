Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB4C4F9A59
	for <lists+bpf@lfdr.de>; Fri,  8 Apr 2022 18:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiDHQUD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Apr 2022 12:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiDHQUD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Apr 2022 12:20:03 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAFA3192D
        for <bpf@vger.kernel.org>; Fri,  8 Apr 2022 09:17:59 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id g21so11150633iom.13
        for <bpf@vger.kernel.org>; Fri, 08 Apr 2022 09:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WtugMnN2pDtNadZzehY5Jqr/qg9IOlREj9+SgHc6fJ0=;
        b=Oekk5Am8LXG+ouQ5CprM5IzKYpd966BCiiXJpHaG9IOiBnIzqwgcn23BwHHSOBg2Ta
         QQaBNvNGPOfsmCgtiRGTx+UZUjIf5T8TKJFCSqa2U3Lo8Ox4Tx7xOS3av05Be5iby1cI
         Kk2TeIvSyXLU0KamGCJGXGtb3m4jmNYJNkonM5QSoaqZZD6qgnq1VkPM1nSijC6POZLz
         5zK6shagGEz/KMxTSxJuPnEtN3lpaanqkWRfkJqXPuiqgLeEIvecn1NxU+iEjrFi+XS5
         C+KLq9rP8i578IfEWQecSwEsZ7opIl0Lyrjq3WduIz6562TX3f977v3xI3f/+EyV2usT
         OnxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WtugMnN2pDtNadZzehY5Jqr/qg9IOlREj9+SgHc6fJ0=;
        b=nmZwpBltWGqPBv4ILVDzqxV06aBTMX0AYYxRlTwHD3NDHiqK7d0ppzDcHRsr1ojZWC
         1z+m98hL+f9ECloR+fWLHzksxi2jnlAifwm/ln52VlxUfslXHXRGXqiNEsIYXyflTlWp
         7pzeb8WuswH+ydi3ssjFKKHCyW+h/zaBAuAGwq9S9PO/waWtU0MepTQwVZflnEdo7kDS
         mxw1RVBqAJRkQAI7Hm7M9etQHiqNccbtQAIraIchmJv1DU2Nh44n5UJrWJe4UfD6eQl+
         p0OR3A9CCdX2xk/GTqhaYNtTSSnElWZqJLKrfqptTYWRyALIrozK3hgupEsu9ufc9gu/
         +efg==
X-Gm-Message-State: AOAM53291dVo7Ao0bzxtfsL6B+iaz2hoPQi1c7s4VNIn9Jw/itB0Bv5l
        ziWv2FmgcYFhZ5dxNyfnj6nk9PWUyKTDczF0f80=
X-Google-Smtp-Source: ABdhPJyBS+DKdTexJUdy3c0jfZ1j3usJUNMuKGFh04mBi9TgVWbXGb4lyJzYtJFWUzC+mwJ+vFCz45CuIqE5N/nIYew=
X-Received: by 2002:a05:6602:185a:b0:645:d914:35e9 with SMTP id
 d26-20020a056602185a00b00645d91435e9mr8699586ioi.154.1649434679028; Fri, 08
 Apr 2022 09:17:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220404234202.331384-1-andrii@kernel.org> <20220404234202.331384-6-andrii@kernel.org>
 <CAEf4BzbETp3S4-HebGBNjFm1fCCAuytSqTp=SNXgXFSqsgCQOQ@mail.gmail.com>
 <034e57e04eeb7dab4bad4fa674ab337a5534cbdc.camel@linux.ibm.com>
 <CAEf4BzYJixpYpg4MUxETPVbCrUrZYbn==-UYgVh1z5MWx1TV+w@mail.gmail.com> <alpine.LRH.2.23.451.2204081515040.17700@MyRouter>
In-Reply-To: <alpine.LRH.2.23.451.2204081515040.17700@MyRouter>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 8 Apr 2022 09:17:48 -0700
Message-ID: <CAEf4BzYPCE3Msow71GfC75YgS6Y1V3YW3CrJqEKZ7XgWRYtAaw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 5/7] libbpf: add x86-specific USDT arg spec
 parsing logic
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 8, 2022 at 7:16 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> On Wed, 6 Apr 2022, Andrii Nakryiko wrote:
>
> > On Wed, Apr 6, 2022 at 3:49 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
> > >
> > > On Wed, 2022-04-06 at 10:23 -0700, Andrii Nakryiko wrote:
> > > > On Mon, Apr 4, 2022 at 4:42 PM Andrii Nakryiko <andrii@kernel.org>
> > > > wrote:
> > > > >
> > > > > Add x86/x86_64-specific USDT argument specification parsing. Each
> > > > > architecture will require their own logic, as all this is arch-
> > > > > specific
> > > > > assembly-based notation. Architectures that libbpf doesn't support
> > > > > for
> > > > > USDTs will pr_warn() with specific error and return -ENOTSUP.
> > > > >
> > > > > We use sscanf() as a very powerful and easy to use string parser.
> > > > > Those
> > > > > spaces in sscanf's format string mean "skip any whitespaces", which
> > > > > is
> > > > > pretty nifty (and somewhat little known) feature.
> > > > >
> > > > > All this was tested on little-endian architecture, so bit shifts
> > > > > are
> > > > > probably off on big-endian, which our CI will hopefully prove.
> > > > >
> > > > > Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> > > > > Reviewed-by: Dave Marchevsky <davemarchevsky@fb.com>
> > > > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > > > ---
> > > >
> > > > Ilya, would you be interested in implementing at least some limited
> > > > support of USDT parameters for s390x? It would be good to have
> > > > big-endian platform supported and tested. aarch64 would be nice as
> > > > well, but I'm not sure who's the expert on that to help with.
> > >
>
> I'm definitely not the expert, but I've got aarch64 arg parsing working
> and all usdt tests pass - I'll submit once Ilya's s390x patches land.

They did this morning. I won't be able to test those patches, though,
so please do as thorough a testing as you can.

>
> Alan
