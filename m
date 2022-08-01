Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88A4586251
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 03:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238735AbiHABkt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 31 Jul 2022 21:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238949AbiHABkp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 31 Jul 2022 21:40:45 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93898120A6;
        Sun, 31 Jul 2022 18:40:44 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 42D0C3200645;
        Sun, 31 Jul 2022 21:40:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 31 Jul 2022 21:40:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1659318042; x=1659404442; bh=npawDv71rl
        ZnJaxeFA6Ei4jvOJ58BYEfIDxUEn4gES0=; b=dzeidag36qYQQ75ErjaJGKWcJI
        nT+Ua5mwJxEijSODxBWHWj0iJYBam5yGOHbwOB3y3qepqctMbQeSb4gc5VzSjrPn
        v7PsBSr9zClGybsO0cDsuPp8knHtS0c3Bjv8mISSWHDNXSPaf0zoqmdSolXv9CMZ
        NW9ir5TpT1JxbGwm4djrm86ITrXPMGzwuh+GELrJDoWSK78iusLRHP7o2CM9pbBw
        qckbvUN2NAD87CXzLSP762moiqBN4H9PhLNGidMNiZ0qrvnBiihUqZ+nTFEu5u9g
        CNj0XQAEngqkZvMNqKvQcvRjulQkeKcqi8tIpvKWy9NBpXo6sBnRNpWpwR4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1659318042; x=1659404442; bh=npawDv71rlZnJaxeFA6Ei4jvOJ58
        BYEfIDxUEn4gES0=; b=f6RMUcIz2ark+IhAivBbuFB0nLWO4w1T2+R/KPHLm/qG
        pmeXPcDcvyvE6vAKx4qfljfGZuZpeVnD7n+XdoXyDx2z7q8PcIeM3ElxSOvBON3V
        TyxYSjyaHngVndYxXmLbmPCc3AZGIjY0p9ok2wdADNYbZrj/6xpS7C0uk2Ddkp81
        grLBujrt3PfIS/asedAOR/i0bVraUoDQ9JUdxDlacT6kxsLdb0mfXRTuGF9xeB4e
        rDv8jUISu1hhfAsbpmkv9PEOm1UfX8y4hymOP++yr88Nhju3bqIbgOkg1QkN1vIg
        0QH4LtExM58+ZzITPBqPhB0xcRFXFhH4El24Abf+yg==
X-ME-Sender: <xms:Gi_nYj1D2Dpd1vxL-N_pKCRExbw1QJMTy78SAG7mDk6QJ3njisgtig>
    <xme:Gi_nYiGLr4T7Qjm7ohVLWzeH2ipuUd2HTEehnpGnMcFIWYh4wwg_Bnxxl1CTvEAJu
    kyX8m9rfJoKK9RsDQ>
X-ME-Received: <xmr:Gi_nYj47ig3iqxrHPHswwcAC9d-KitKFl8CFhHRs6L6ec1E3dudkYOjiZ33ldkZzRZ9kRhYDuD6gUdGSfEs-1gJonLDJBDqKmKwi6jHWdzBq7Jo8lxB91c5rvIWt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvvddggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheptehnughr
    vghsucfhrhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuggftrf
    grthhtvghrnhepleehhfelgfeggfejhedvtdfggeehgfevveetteegkefgteegffekkeev
    jedufefhnecuffhomhgrihhnpehfvggrthhurhgvrdhinhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrnhgurhgvshesrghnrghrrgiivghl
    rdguvg
X-ME-Proxy: <xmx:Gi_nYo1ZIJuCcBgAZ5NaR6X-ilTp4d3bs6rAgNHYeP9Qy_DfrZ0_6A>
    <xmx:Gi_nYmGTei3pSggwbq_sXcyri3_6SHGyUYA7dgvNWUefGiuI6fA6gw>
    <xmx:Gi_nYp-C7PnLYycSmZhwKeZzAI4KmForuqV0xpltlg3oGvsk0po7tw>
    <xmx:Gi_nYjMlY2KfzTzrRSAkP4yNMu6xwArHkvAS6oNN_A9Ua6ZUdV-g_w>
Feedback-ID: id4a34324:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 31 Jul 2022 21:40:42 -0400 (EDT)
Date:   Sun, 31 Jul 2022 18:40:41 -0700
From:   Andres Freund <andres@anarazel.de>
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: Re: [PATCH v2 0/5] tools: fix compilation failure caused by
 init_disassemble_info API changes
Message-ID: <20220801014041.24jvobsooyyddvjb@awork3.anarazel.de>
References: <20220622231624.t63bkmkzphqvh3kx@alap3.anarazel.de>
 <20220703212551.1114923-1-andres@anarazel.de>
 <YsKvPW+1RkVvq8aX@krava>
 <20220704201922.pvrh4cmmjxjn4mkx@awork3.anarazel.de>
 <YsNl1XdEuxvqb3vx@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsNl1XdEuxvqb3vx@krava>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 2022-07-05 00:12:37 +0200, Jiri Olsa wrote:
> On Mon, Jul 04, 2022 at 01:19:22PM -0700, Andres Freund wrote:
> > > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > > index ee417c321adb..2aa0bad11f05 100644
> > > --- a/tools/perf/Makefile.config
> > > +++ b/tools/perf/Makefile.config
> > > @@ -914,8 +914,6 @@ ifndef NO_LIBBFD
> > >          FEATURE_CHECK_LDFLAGS-disassembler-init-styled += -liberty -lz -ldl
> > >        endif
> > >      endif
> > > -    $(call feature_check,disassembler-four-args)
> > > -    $(call feature_check,disassembler-init-styled)
> > >    endif
> > >
> > >    ifeq ($(feature-libbfd-buildid), 1)
> > > @@ -1025,6 +1023,9 @@ ifdef HAVE_KVM_STAT_SUPPORT
> > >      CFLAGS += -DHAVE_KVM_STAT_SUPPORT
> > >  endif
> > >
> > > +$(call feature_check,disassembler-four-args)
> > > +$(call feature_check,disassembler-init-styled)
> > > +
> > >  ifeq ($(feature-disassembler-four-args), 1)
> > >      CFLAGS += -DDISASM_FOUR_ARGS_SIGNATURE
> > >  endif
> >
> > This I don't understand - why do we want these to run under NO_LIBBFD etc?
>
> when I was quickly testing that I did not have any of them detected
> and got compile fail.. so I moved it to safe place ;-) it might be
> placed in smarter place

I think that's because you'd removed them from FEATURE_TESTS_BASIC in
Makefile.feature. In v3 I just sent out I just removed them from
FEATURE_DISPLAY, without any more "structural" changes in
tools/perf/Makefile.config. 

Greetings,

Andres Freund
