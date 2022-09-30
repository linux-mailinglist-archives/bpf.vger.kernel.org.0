Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AD55F16BC
	for <lists+bpf@lfdr.de>; Sat,  1 Oct 2022 01:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiI3Xlw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Sep 2022 19:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiI3Xlv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Sep 2022 19:41:51 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2729B13DDB8
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 16:41:50 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id y8so7837243edc.10
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 16:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=zQP2NV4WQbBAfhxw8MJdSmMeGnkvIid/qHLH/l7Q878=;
        b=IEIwrz0hKboj5RI4jfmyAgsIcGM7GWyRdhJcHCwkkgREd7HZpMYWMnu3/t8r2kuzN0
         quLEVfH3flSH3KflwK3t+0x17pDFbXO2A6AjIB22M88tUdkGeoekxeI4gz1OowejNx+0
         sMqs5WxcEVZ5C0fuCz78N3iFyxKBC4u5htEIJdARjVjnPI1yjGq04ApuhWHv7pY2EB90
         7AneSD9rftq6p0vSYzqP+N4wniGBL/JoS5SFN0BV93F7xFz8nF8ue7MzR7cGvEHpr2VZ
         GZAuQTAfEvm2M0YjnKjwBhaZrm1uOq5b5wHlY5jH8kasefFf2qTQEJiCbM0lYVDAn/P/
         zNhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=zQP2NV4WQbBAfhxw8MJdSmMeGnkvIid/qHLH/l7Q878=;
        b=Ly9L/h1qA22gRq73j+3LUKXnz6DIiqNcn5IM+3NtPqr7EXbQTIHnx5q4ti8OEoxodo
         cu5yVy6MlDUpk3tCz1w9zIlVcOh9nkvfDKegRAHbYFqzdkAepkKDDoGkYHtWHPog02Lu
         WLRCLNCqzb8tnk3HW0UAaQhjvxbpVas9fA+f0j8F1pvPkZSKyGCqg0/6FjNHekJQTFfO
         O0AdrafmGwn7m9KFSjuSHj+cMViVsqRacAqib59fv7HflVpcQbgwWaHhQiXM88sHsCkB
         nufhbbo/m7xo2wArxt30nMa2MaCEy8lPQohl5mgG79VZdvxHzePt2RE5+48SthO2xwfz
         v43g==
X-Gm-Message-State: ACrzQf1AbAl1/FC/GQCxsX+Val2EjFY/+tz9sD3BAV7515uzEPg0ESB4
        tC3JZ/KaFCvADVNIqVqdznmAIsfFZiGdT1fd33A=
X-Google-Smtp-Source: AMsMyM6kLqU7VuLPPluJMRRia7lODaYSD4s6pjnE7ZK3OFPbiTWgyjurze76UfkwuTCEg3HiNkkOC4MBJ8DW9INR8q0=
X-Received: by 2002:a05:6402:5406:b0:452:1560:f9d4 with SMTP id
 ev6-20020a056402540600b004521560f9d4mr9776723edb.333.1664581308544; Fri, 30
 Sep 2022 16:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220927185958.14995-1-dthaler1968@googlemail.com>
 <20220927185958.14995-7-dthaler1968@googlemail.com> <20220930205211.tb26v4rzhqrgog2h@macbook-pro-4.dhcp.thefacebook.com>
 <DM4PR21MB3440CDB9D8E325CBEA20FFA7A3569@DM4PR21MB3440.namprd21.prod.outlook.com>
 <20220930215914.rzedllnce7klucey@macbook-pro-4.dhcp.thefacebook.com> <DM4PR21MB34402522B614257706D2F785A3569@DM4PR21MB3440.namprd21.prod.outlook.com>
In-Reply-To: <DM4PR21MB34402522B614257706D2F785A3569@DM4PR21MB3440.namprd21.prod.outlook.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 30 Sep 2022 16:41:37 -0700
Message-ID: <CAADnVQJto119zhc3oBuNa-OuwoNWW02bDDRb_SGKxZxq=Wid8A@mail.gmail.com>
Subject: Re: [PATCH 07/15] ebpf-docs: Fix modulo zero, division by zero,
 overflow, and underflow
To:     Dave Thaler <dthaler@microsoft.com>
Cc:     "dthaler1968@googlemail.com" <dthaler1968@googlemail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 30, 2022 at 3:41 PM Dave Thaler <dthaler@microsoft.com> wrote:
>
> > -----Original Message-----
> > From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> > Sent: Friday, September 30, 2022 2:59 PM
> > To: Dave Thaler <dthaler@microsoft.com>
> > Cc: dthaler1968@googlemail.com; bpf@vger.kernel.org
> > Subject: Re: [PATCH 07/15] ebpf-docs: Fix modulo zero, division by zero,
> > overflow, and underflow
> >
> > On Fri, Sep 30, 2022 at 09:54:17PM +0000, Dave Thaler wrote:
> > > [...]
> > > > > +Also note that the modulo operation often varies by language when
> > > > > +the dividend or divisor are negative, where Python, Ruby, etc.
> > > > > +differ from C, Go, Java, etc. This specification requires that
> > > > > +modulo use truncated division (where -13 % 3 == -1) as
> > > > > +implemented in C, Go,
> > > > > +etc.:
> > > > > +
> > > > > +   a % n = a - n * trunc(a / n)
> > > > > +
> > > >
> > > > Interesting bit of info, but I'm not sure how it relates to the ISA doc.
> > >
> > > It's because there's multiple definitions of modulo out there as the
> > > paragraph notes, which differ in what they do with negative numbers.
> > > The ISA defines the modulo operation as being the specific version above.
> > > If you tried to implement the ISA in say Python and didn't know that,
> > > you'd have a non-compliant implementation.
> >
> > Is it because the languages have weird rules to pick between signed vs
> > unsigned mod?
> > At least from llvm pov the smod and umod have fixed behavior.
>
> It's because there's different mathematical definitions and different languages have chosen different definitions.  E.g., languages/libraries that follow Knuth use a
> different mathematical definition than C uses.  For details see:
>
> https://en.wikipedia.org/wiki/Modulo_operation#Variants_of_the_definition
>
> https://torstencurdt.com/tech/posts/modulo-of-negative-numbers/

Those differences are in signed div/mod only, right?
Unsigned div/mod doesn't have it, right?
bpf has only unsigned div/mod.
