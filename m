Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2743E565F5F
	for <lists+bpf@lfdr.de>; Tue,  5 Jul 2022 00:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbiGDWMp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Jul 2022 18:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbiGDWMo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Jul 2022 18:12:44 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AAC6308;
        Mon,  4 Jul 2022 15:12:43 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id h23so18603423ejj.12;
        Mon, 04 Jul 2022 15:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ax8ZOmKuftFHkfswWqK0Q99M7L18BhPxIsLeyV4g1Kw=;
        b=mybSoRDihZNQWO75rkkqVUNhkPiw2o8iqInVHHdy3lo8UImmCjl4/FmErasbunwz+Y
         wo5AMYqO1vW88Xp7lHfBqQ2Lr2URWyWuIeHVpsM3wNxeCaT8LfmB/euLzKuY91ZNE1Qr
         7mtYBZ+34R8XAmWUnBuyO6OPFwEiRv6BksbWN9iLWJ1L5cQ1jFQTUq5ALbgtl7FNdW8Y
         wYz0yQAv1TUqBDoLp5hvMkRK9gWAkvXOM/ykYxRmd5w1qIyMMHKUR9p8iTcG82zKAYoU
         sT11p70Y7TeBj+JPgKRFPHpaFWTnrejJyshMCymW6AXo6aIVY3CRWhL0WI2hcVtABVd3
         kx1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ax8ZOmKuftFHkfswWqK0Q99M7L18BhPxIsLeyV4g1Kw=;
        b=Uz8cAv3LrfVnAMANt1zHCdkF751bjundqm1tQCk6TVa8PykqrN4yjOrHvGAcj+Ei5G
         L6fVPyxytIst/NxV1eVKjPBsLoG5juViPxcqkt52t8cFxZ4T1S8eosOLsC2Ledr6uymS
         pPjfLU9umzmgJbZbo9fc2C37qKu79pFKeDrKFM13g0+DpQNKrdhy83j/f33k5b013UT0
         dayAUYj2JkQ8E06d1DJH3PoWux+8dKaxMQHU/MX6+9Dzd6Q+vXTfQjLUYS3IgiDeLXLq
         qdWJ8yM338a9YWsuje3ofPBGGWsz2Hh3CLELHeo6MriOLdebdruHr8vikKGRCEqrmSFt
         n0Bg==
X-Gm-Message-State: AJIora/8e9fStQn+N7A9Z5MSoEFE2TaQoF363qhp/dTbmcPAJzGx+vAX
        do8STBhzTAk9KVsKeaaKfXYSh+yHW6jSyrMY
X-Google-Smtp-Source: AGRyM1uNmYHmyVnUvIC9MqS9/DRGr45NTonHF4dH5QqsoL9H/aaHtAHaI5fP5UIUTFWFzMQvTvfgPA==
X-Received: by 2002:a17:907:9483:b0:726:bea5:7a87 with SMTP id dm3-20020a170907948300b00726bea57a87mr30404955ejc.629.1656972761852;
        Mon, 04 Jul 2022 15:12:41 -0700 (PDT)
Received: from krava ([151.70.14.154])
        by smtp.gmail.com with ESMTPSA id r6-20020aa7cb86000000b0043a734c7393sm722409edt.31.2022.07.04.15.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 15:12:41 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Tue, 5 Jul 2022 00:12:37 +0200
To:     Andres Freund <andres@anarazel.de>
Cc:     Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: Re: [PATCH v2 0/5] tools: fix compilation failure caused by
 init_disassemble_info API changes
Message-ID: <YsNl1XdEuxvqb3vx@krava>
References: <20220622231624.t63bkmkzphqvh3kx@alap3.anarazel.de>
 <20220703212551.1114923-1-andres@anarazel.de>
 <YsKvPW+1RkVvq8aX@krava>
 <20220704201922.pvrh4cmmjxjn4mkx@awork3.anarazel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704201922.pvrh4cmmjxjn4mkx@awork3.anarazel.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 04, 2022 at 01:19:22PM -0700, Andres Freund wrote:
> Hi,
> 
> On 2022-07-04 11:13:33 +0200, Jiri Olsa wrote:
> > I think the disassembler checks should not be displayed by default,
> > with your change I can see all the time:
> > 
> > ...        disassembler-four-args: [ on  ]
> > ...      disassembler-init-styled: [ OFF ]
> > 
> > 
> > could you please squash something like below in? moving disassembler
> > checks out of sight and do manual detection
> 
> Makes sense - I was wondering why disassembler-four-args is displayed, but
> though it better to mirror the existing behaviour. Does "hiding"
> disassembler-four-args need to be its own set of commits?

I guess first hide the disassembler-four-args and add the new the same way

> 
> 
> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index ee417c321adb..2aa0bad11f05 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -914,8 +914,6 @@ ifndef NO_LIBBFD
> >          FEATURE_CHECK_LDFLAGS-disassembler-init-styled += -liberty -lz -ldl
> >        endif
> >      endif
> > -    $(call feature_check,disassembler-four-args)
> > -    $(call feature_check,disassembler-init-styled)
> >    endif
> >  
> >    ifeq ($(feature-libbfd-buildid), 1)
> > @@ -1025,6 +1023,9 @@ ifdef HAVE_KVM_STAT_SUPPORT
> >      CFLAGS += -DHAVE_KVM_STAT_SUPPORT
> >  endif
> >  
> > +$(call feature_check,disassembler-four-args)
> > +$(call feature_check,disassembler-init-styled)
> > +
> >  ifeq ($(feature-disassembler-four-args), 1)
> >      CFLAGS += -DDISASM_FOUR_ARGS_SIGNATURE
> >  endif
> 
> This I don't understand - why do we want these to run under NO_LIBBFD etc?

when I was quickly testing that I did not have any of them detected
and got compile fail.. so I moved it to safe place ;-) it might be
placed in smarter place 

thanks,
jirka

> 
> Greetings,
> 
> Andres Freund
