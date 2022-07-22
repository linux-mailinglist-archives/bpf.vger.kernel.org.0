Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7859857DF22
	for <lists+bpf@lfdr.de>; Fri, 22 Jul 2022 12:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236729AbiGVJrr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jul 2022 05:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236720AbiGVJrb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jul 2022 05:47:31 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D62E384;
        Fri, 22 Jul 2022 02:44:27 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id x11so3096718qts.13;
        Fri, 22 Jul 2022 02:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=njvi007IPZLoUToBw/3oPRzvfKBBxiE1LtWmOJ0CDkM=;
        b=faaBiu8PQbrF0hbtgBRSJKQfxe0bl+oozsq1LPinmpqtNTODqltOTuUUpmMCgHE1Fe
         zfDxD3TnET4fLEPA9b7UQf1J+Ac9wPLz+fHDC5A9OK1Z8PdT4zxs1KKlQgz8HYQrPVkA
         4mHdHYalAQGGijiugIfoB6Sh4NisZp/9T5BJgw/Dacu9tbVZnYkmQyuNg61vIhjKpQnQ
         jlXuTStEVdsYmDFDc9lIfLKNaIBHJmS8yXxUJfvEgU/Id+ZJL4bnQvHrniO8kapUdnTs
         j2RipDTqt8liV36R/Tj5vVkbBngiLDe2/rAvF1vq9hjpWrS+kWF0lK4xNvGgfMtbWHi1
         niRA==
X-Gm-Message-State: AJIora8aEbrl2qN8zJzE8nqEaGCXtEJwrvVlvnt/g4aTr+UOe+ql3xwF
        3lFPCIWy5goeH19kasI7ZtuJZdUq6OgMXw==
X-Google-Smtp-Source: AGRyM1stuifbRMfdMmPCQQ/E1nqIXx4qgUrTCGdhSiCs7VO/WrjQkFiSdAqof610M7C3BSZa0Rt+uA==
X-Received: by 2002:a05:622a:613:b0:31e:f64a:6d88 with SMTP id z19-20020a05622a061300b0031ef64a6d88mr2201717qta.321.1658483066664;
        Fri, 22 Jul 2022 02:44:26 -0700 (PDT)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id x27-20020a05620a0b5b00b006b5e43466ebsm2918821qkg.59.2022.07.22.02.44.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 02:44:26 -0700 (PDT)
Received: by mail-yb1-f177.google.com with SMTP id b143so5900800yba.11;
        Fri, 22 Jul 2022 02:44:26 -0700 (PDT)
X-Received: by 2002:a05:6902:38c:b0:670:b6bc:6ed5 with SMTP id
 f12-20020a056902038c00b00670b6bc6ed5mr2008042ybs.604.1658483065858; Fri, 22
 Jul 2022 02:44:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220721015605.20651-1-slark_xiao@163.com> <20220721154110.fqp7n6f7ij22vayp@kafai-mbp.dhcp.thefacebook.com>
 <21cac0ea.18f.182218041f7.Coremail.slark_xiao@163.com> <874jzamhxe.fsf@meer.lwn.net>
 <6ca59494-cc64-d85c-98e8-e9bef2a04c15@infradead.org>
In-Reply-To: <6ca59494-cc64-d85c-98e8-e9bef2a04c15@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 22 Jul 2022 11:44:14 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWSCHW4WzXPr95SyAQ3OnMdyO9_PNLAMA_38osV2LMt=Q@mail.gmail.com>
Message-ID: <CAMuHMdWSCHW4WzXPr95SyAQ3OnMdyO9_PNLAMA_38osV2LMt=Q@mail.gmail.com>
Subject: Re: [PATCH v2] docs: Fix typo in comment
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Slark Xiao <slark_xiao@163.com>,
        kafai <kafai@fb.com>, Baoquan He <bhe@redhat.com>,
        vgoyal <vgoyal@redhat.com>, dyoung <dyoung@redhat.com>,
        ast <ast@kernel.org>, daniel <daniel@iogearbox.net>,
        andrii <andrii@kernel.org>, "martin.lau" <martin.lau@linux.dev>,
        song <song@kernel.org>, yhs <yhs@fb.com>,
        "john.fastabend" <john.fastabend@gmail.com>,
        kpsingh <kpsingh@kernel.org>, sdf <sdf@google.com>,
        haoluo <haoluo@google.com>, jolsa <jolsa@kernel.org>,
        "william.gray" <william.gray@linaro.org>,
        dhowells <dhowells@redhat.com>, peterz <peterz@infradead.org>,
        mingo <mingo@redhat.com>, will <will@kernel.org>,
        longman <longman@redhat.com>,
        "boqun.feng" <boqun.feng@gmail.com>, tglx <tglx@linutronix.de>,
        bigeasy <bigeasy@linutronix.de>,
        kexec <kexec@lists.infradead.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        linux-cachefs <linux-cachefs@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 21, 2022 at 8:52 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 7/21/22 11:36, Jonathan Corbet wrote:
> > "Slark Xiao" <slark_xiao@163.com> writes:
> >
> >> May I know the maintainer of one subsystem could merge the changes
> >> contains lots of subsystem?  I also know this could be filtered by
> >> grep and sed command, but that patch would have dozens of maintainers
> >> and reviewers.
> >
> > Certainly I don't think I can merge a patch touching 166 files across
> > the tree.  This will need to be broken down by subsystem, and you may
> > well find that there are some maintainers who don't want to deal with
> > this type of minor fix.
>
> We have also seen cases where "the the" should be replaced by "then the"
> or some other pair of words, so some of these changes could fall into
> that category.

Yes we have:

    --- a/arch/m68k/coldfire/intc-2.c
    +++ b/arch/m68k/coldfire/intc-2.c
    @@ -7,7 +7,7 @@
      * family, the 5270, 5271, 5274, 5275, and the 528x family which
have two such
      * controllers, and the 547x and 548x families which have only one of them.
      *
    - * The external 7 fixed interrupts are part the the Edge Port unit of these
    + * The external 7 fixed interrupts are part the Edge Port unit of these
      * ColdFire parts. They can be configured as level or edge triggered.
      *
      * (C) Copyright 2009-2011, Greg Ungerer <gerg@snapgear.com>

And that's already been fixed
https://lore.kernel.org/lkml/6fe2468a-9664-30f7-7f17-9093289eb4b6@linux-m68k.org

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
