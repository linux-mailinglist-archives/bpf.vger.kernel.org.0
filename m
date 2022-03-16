Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD28C4DA9E1
	for <lists+bpf@lfdr.de>; Wed, 16 Mar 2022 06:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353674AbiCPFc4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Mar 2022 01:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353645AbiCPFct (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Mar 2022 01:32:49 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AEF5DA6F
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 22:31:36 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id x9so897720ilc.3
        for <bpf@vger.kernel.org>; Tue, 15 Mar 2022 22:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6cdrmtmG/DaaO3atgIiMBahHzekw40YnNNXiIDKredQ=;
        b=V+pOoRoh1vugMnfBn4hFJtISqDV81HpGE2AEOVNe/hKk1zEpMx7B0VOPLUnHo5TKri
         37LuLAQoJqmLsOkKKdtg2n5/biLpdXMPFTZF51ZzGBCMNF2lIZCYeZtcgHn0V7/KbHtA
         4IoBApI20b0E02ljNjI4z7bZTmEj5WyA8lgJ9UcHGmv4rDzQ6QJWsB3Q8IPw4hY20rLQ
         ibN+vhR3GQTLL3JVtR7Fv8KndKrL9G4zP4ds9MPfPnTkdE++k3Cig/NBHn3ak9qPgEe3
         qYLnJlO7uXII+4wo3wH4lIFnynsnSkVgbhz6IkbfommVhuc83nTe02WN+Bo5DlzeDVa8
         XawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6cdrmtmG/DaaO3atgIiMBahHzekw40YnNNXiIDKredQ=;
        b=i67O/oQ8gaNoz5aLfU5qGvhH8tyzZe3BqthUP7FK69ASVdzeNGCt1OlvwpPAd8Gl7h
         CoMCuS61WOEKwAi1T51vjVWmOL7KOWMyZxzpNaGzkbGx91aEW573UZHzHwI0iwoJ7fdZ
         /HLOtBaFsLs8p5Lyl3XJ6e2/R5gjT0q8Zeprpyygt4wWH2jsQjwt/1Sqkjtww5+97ekF
         HUKZbbbCfApPV47zt4oyCcTaX1hMail/OuJiWPW6x4PSzlJKQBmw5xJYA4Tiu6H0ySTM
         wJpc5NY+6rTAQk3uEfj54FPd1mxuvBwTN3hdpUoA4EAq20kyNFgE+yZQ1OXwRlGKWYp+
         14+A==
X-Gm-Message-State: AOAM532ynq0XBqscwLNbZ3PZf7dr3JZ39vBGXXTwa6IdV2akKwp/bYcQ
        HMaGKZMfzEyHNfftNXvGm1CBBKEnpKhzsCGJt5g=
X-Google-Smtp-Source: ABdhPJwsEBaCdJaWMPxj7zjSPbexylhmctM57tczJvci8ERRhP6Ps+sZ3aTrHwhgoF9erI2hfQcBhJ1SlOtL5GNzR10=
X-Received: by 2002:a92:6406:0:b0:2bb:f1de:e13e with SMTP id
 y6-20020a926406000000b002bbf1dee13emr23466594ilb.305.1647408696151; Tue, 15
 Mar 2022 22:31:36 -0700 (PDT)
MIME-Version: 1.0
References: <7c20ed355c2f587d3e1c81a6b398cb8f68304780.1647342110.git.lorenzo@kernel.org>
 <CAEf4BzZFGv-_5U8LL=Jzr8MqL5F5F0i=gz+06nJOc961Ta54KA@mail.gmail.com> <YjEW2rwFbcHaqv2D@lore-desk>
In-Reply-To: <YjEW2rwFbcHaqv2D@lore-desk>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 15 Mar 2022 22:31:25 -0700
Message-ID: <CAEf4BzZ1SXP9EJYC4PwTEewVeiYk0OwVbRtXzM_K76AOsN4n_g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] samples: bpf: convert xdp_router_ipv4 to XDP
 samples helper
To:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
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

On Tue, Mar 15, 2022 at 3:44 PM Lorenzo Bianconi
<lorenzo.bianconi@redhat.com> wrote:
>
> > On Tue, Mar 15, 2022 at 4:06 AM Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> > >
> > > Rely on the libbpf skeleton facility and other utilities provided by XDP
> > > sample helpers in xdp_router_ipv4 sample.
> > >
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > ---
> > >  samples/bpf/Makefile               |   9 +-
> > >  samples/bpf/xdp_router_ipv4.bpf.c  | 180 +++++++++++
> > >  samples/bpf/xdp_router_ipv4_kern.c | 186 ------------
> >
> > hm... git should be able to record this as a rename and the result
> > patch will be much smaller, only showing what really changed. Can you
> > check where this went wrong?
>
> I am not so familiar with git internal, but I think it depends on the similarity
> between the "old" and "new" files. If they are very different (like in this case),
> git will report the "old" file as remove and the creation of the "new" one.
> I guess you can try to do "git mv" a given file and overwrite it with a
> different one. Am I missing something?

I assumed there are only pretty minimal changes inside
xdp_router_ipv4.bpf.c, tbh. Hard to see when it's two separate files
(which was exactly the point with file rename tracking). Oh well,
that's ok.

>
> >
> > Please also add libbpf_set_strict_mode(LIBBPF_STRICT_ALL) to enable
> > stricter "libbpf 1.0" mode. Thanks!
>
> ack, I will add it in v2.
>
> Regards,
> Lorenzo
>
> >
> > >  samples/bpf/xdp_router_ipv4_user.c | 462 ++++++++++++-----------------
> > >  4 files changed, 377 insertions(+), 460 deletions(-)
> > >  create mode 100644 samples/bpf/xdp_router_ipv4.bpf.c
> > >  delete mode 100644 samples/bpf/xdp_router_ipv4_kern.c
> > >
> >
> > [...]
> >
