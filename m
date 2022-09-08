Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B8E5B238A
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 18:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbiIHQYf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 12:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbiIHQYd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 12:24:33 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AE3D100
        for <bpf@vger.kernel.org>; Thu,  8 Sep 2022 09:24:30 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id b81so8976210vkf.1
        for <bpf@vger.kernel.org>; Thu, 08 Sep 2022 09:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=ODfnmlFfycvjfVXmsxtWSPqog+vmYpbjDzuWEGIV7BM=;
        b=EaAhHTSA2iQzIEOMY0imysjl2phthxebpFlsdwUq1rW8grglIO0/JDXLNMdn0CvgzC
         eWvSw/5+hYAbAQ0B6eEXgcJvAes5zcqjqaloL461NRHb5fJdAKais39mg6bRD32ycXLj
         l0p3JjEdy5IvAoHYEENZDPxyY+qK96FyPi9d9HRDWFoN3yogGYsqrGw6N+CkQlIkX120
         6MX2MQjl7lUYDbKb31teLMwxPppPqb+luygXENNM/ChvlVmkCcKF4bbfsrfqQwqA4Hw3
         zG69YrJsnKnZOvR/eeehUxCSLDClOsOZgTBWOs6pgfxv6fj4VEhQ1RaRi51RfppVTJ80
         b1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=ODfnmlFfycvjfVXmsxtWSPqog+vmYpbjDzuWEGIV7BM=;
        b=0DluqQc7pzxsIj0Z1VbQ8Y+IvQpe+EbWHoUVPDJIJ/SaPfoziYxoAlSRglz6kGf30b
         DOQwR+0RgjQM68e1fFvuSbNe+ZchdI2VFMnt6SgBbJdwxVq37B88rMtyAuV59zC9GgPO
         GwiVCTv3+Nd9Z5S7+svvuNcsKAgnkqsyCOnwQ3l2NRYsMaQ3T+famKtjAjON7Zvs4hfa
         YDADtxwB8tQVldwlgHeZuxlEfsZadUXvR1SIrvdKd+Lpd31XJSGSDDW1/a7ftCTH+Atw
         3Tjd29oGLcVMqTk8KTrQTUA6QBGoTTWW96AK5bt5oyh6S+uQybrU9lEwKTGsfv4UL5t8
         lzsw==
X-Gm-Message-State: ACgBeo2NtUqxU4czY62yUf+OIuM2Q/kACxgRAhhxiz1dBCocp/o8pglQ
        eB0T7s3wu04PfLr/boWDAnimbq2wmxxD0dPFcUo=
X-Google-Smtp-Source: AA6agR64615e19W4s8OzIek4zeXS/CW+Y4vVHwC1MYKo+w1tHjqSIZ3nI7Zw3ujWLNJY3Js8FAbMnSnC7KoEFea8VXo=
X-Received: by 2002:a1f:980d:0:b0:3a1:d89f:e3b6 with SMTP id
 a13-20020a1f980d000000b003a1d89fe3b6mr923756vke.29.1662654269971; Thu, 08 Sep
 2022 09:24:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAK3+h2zZQ4zEB55Bn565Xf0okf+Jotmo6qHYmzpoJPBcFWPP0A@mail.gmail.com>
 <CAK3+h2y4isKQQWFY9dnEq86a4BRG1zr5nEveyKqFyVvYaRrPpw@mail.gmail.com> <YxlmpEzm/ZDFTjKE@syu-laptop>
In-Reply-To: <YxlmpEzm/ZDFTjKE@syu-laptop>
From:   Vincent Li <vincent.mc.li@gmail.com>
Date:   Thu, 8 Sep 2022 09:24:19 -0700
Message-ID: <CAK3+h2won0ZJqmJZd46RfmnHnLSaqDc5+f_FuHxn8fpD6khKjw@mail.gmail.com>
Subject: Re: differentiate the verifier invalid mem access message error?
To:     Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc:     bpf <bpf@vger.kernel.org>
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

On Wed, Sep 7, 2022 at 8:51 PM Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
>
> On Wed, Sep 07, 2022 at 07:40:55PM -0700, Vincent Li wrote:
> > On Wed, Sep 7, 2022 at 7:35 PM Vincent Li <vincent.mc.li@gmail.com> wrote:
> > > Hi,
> > >
> > > I see some verifier log examples with error like:
> > >
> > > R4 invalid mem access 'inv'
> > >
> > > It looks like invalid mem access errors occur in two places below,
> > > does it make sense to make the error message slightly different so for
> > > new eBPF programmers like me to tell the first invalid mem access is
> > > maybe the memory is NULL? and the second invalid mem access is because
> > > the register type does not match any valid memory pointer? or this
> > > won't help identifying problems and don't bother ?
> > >
> > >  4772         } else if (base_type(reg->type) == PTR_TO_MEM) {
> > >  4773                 bool rdonly_mem = type_is_rdonly_mem(reg->type);
> > >  4774
> > >  4775                 if (type_may_be_null(reg->type)) {
> > >  4776                         verbose(env, "R%d invalid mem access
> > > '%s'\n", regno,
> > >  4777                                 reg_type_str(env, reg->type));
>
> While the error you're seeing is coming from the bottom case (more on that
> below), I agree hinting the user that a null check is missing may be
> helpful.
>
right, I think the reg_type_str will output the 'nul' string in this
case if I read the code correct.

> > >  4778                         return -EACCES;
> > >  4779                 }
> > >
> > > and
> > >
> > >  4924         } else {
> > >  4925                 verbose(env, "R%d invalid mem access '%s'\n", regno,
> > >  4926                         reg_type_str(env, reg->type));
> > >  4927                 return -EACCES;
> > >  4928         }
> >
> > sorry I should read the code more carefully, I guess the "inv" already
> > says it is invalid memory access, not NULL, right?
>
> The "inv" actually means that the type of R4 is scalar. IIUC "inv" stands
> for invariant, which is a term used in static analysis.
>
> Since v5.18 (commit 7df5072cc05f "bpf: Small BPF verifier log improvements")
> the verifier will say "scalar" instead.

Thanks for the clarification :)
