Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FA2501D78
	for <lists+bpf@lfdr.de>; Thu, 14 Apr 2022 23:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236826AbiDNVeB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Apr 2022 17:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiDNVeA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Apr 2022 17:34:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C311F63B;
        Thu, 14 Apr 2022 14:31:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B98DB82B9B;
        Thu, 14 Apr 2022 21:31:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2A8C385A5;
        Thu, 14 Apr 2022 21:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649971892;
        bh=h2CDvJ935gRrph03sTEfqDjtYnF3c4eTNU0nFlpfIDo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Up+6imjj/eMa46S04EnplwZ72nsvjrSC5YV3qyxm9pnrLsp0mdQ9TwX76ocqJ9SCY
         RP41SFqMTmrf7d7o/c7ShVRxoKW3EC9uUAfSkKoWpBQfRHXPPbxPkrQPltJGvM9bR4
         wiaW63XvgREN8QkBXQm0zq/s1P3AzVEpNgGynS1p5oae98C+ORn7KaXpDKfGt9kxVY
         k5jBjt+lwHx9FoUd/bZUZzXlR3CQYV3Jky0J9IOyhRmg9Zi0046/J7ck5QJ+F9xS2t
         JUJJVirrbVrZLo0SNKw3xtfcr0L27RHJBF39WbXPgHKE8DHvTWGKzhYI7EkRcP5WJM
         eagGITeKrI4qQ==
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-2ebf4b91212so68378327b3.8;
        Thu, 14 Apr 2022 14:31:31 -0700 (PDT)
X-Gm-Message-State: AOAM531AmBzhdjlFVgDK6Fq5mN7BxnGgOHZdy4Bye61l9RIye5f75eL2
        VIRnHp9QvZy+rRGZGZTSdZImsaWiH+kUhQNEaFo=
X-Google-Smtp-Source: ABdhPJwoOdn0th0XbdegVRBdNkqRR9sYSJqbu0HlnrvstgzzLo278bhR6okJlsLL7beUIEU1zwYtNny56Ms3lI7RT/4=
X-Received: by 2002:a81:5087:0:b0:2ef:33c1:fccd with SMTP id
 e129-20020a815087000000b002ef33c1fccdmr3664971ywb.73.1649971891018; Thu, 14
 Apr 2022 14:31:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220414195914.1648345-1-song@kernel.org> <20220414195914.1648345-4-song@kernel.org>
 <YliFO2sDv31j5vLb@bombadil.infradead.org> <CAPhsuW42Dn2y9skhdJAK1fp9CFA06tpzG=6gMxeTobBj6xifPg@mail.gmail.com>
 <YliOC455r6XmE24Q@bombadil.infradead.org>
In-Reply-To: <YliOC455r6XmE24Q@bombadil.infradead.org>
From:   Song Liu <song@kernel.org>
Date:   Thu, 14 Apr 2022 14:31:18 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5=BfCoWqFgnsLu-X+8FriJCxQ80+aS_9t6fFB1eGCvRQ@mail.gmail.com>
Message-ID: <CAPhsuW5=BfCoWqFgnsLu-X+8FriJCxQ80+aS_9t6fFB1eGCvRQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf RESEND 3/4] module: introduce module_alloc_huge
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        bpf <bpf@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Christoph Hellwig <hch@infradead.org>, imbrenda@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 14, 2022 at 2:11 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
> On Thu, Apr 14, 2022 at 02:03:17PM -0700, Song Liu wrote:
> > Hi Luis,
> >
> > On Thu, Apr 14, 2022 at 1:34 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > >
> > > On Thu, Apr 14, 2022 at 12:59:13PM -0700, Song Liu wrote:
> > > > Introduce module_alloc_huge, which allocates huge page backed memory in
> > > > module memory space. The primary user of this memory is bpf_prog_pack
> > > > (multiple BPF programs sharing a huge page).
> > > >
> > > > Signed-off-by: Song Liu <song@kernel.org>
> > >
> > > See modules-next [0], as modules.c has been chopped up as of late.
> > > So if you want this to go throug modules this will need to rebased
> > > on that tree. fortunately the amount of code in question does not
> > > seem like much.
> > >
> > > [0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=modules-next
> >
> > We are hoping to ship this with to 5.18, as the set addresses some issue with
> > huge page backed vmalloc. I guess we cannot ship it via modules-next branch.
> >
>
> Huh, you intend this to go in as a fix for v5.18 (already released) once
> properly reviewed?  This seems quite large... for a fix.
>
> > How about we ship module_alloc_huge() to 5.18 in module.c for now, and once
> > we update modules-next branch, I will send another patch to clean it up?
>
> I rather set the expectations right about getting such a large fix in
> for v5.18. I haven't even sat down to review all the changes in light of
> this, but a cursorary glance seems to me it's rather "large" for a fix.

Yes, I agree this is a little too big for a fix. I guess we can discuss whether
some of the set need to wait until 5.19.

Thanks,
Song
