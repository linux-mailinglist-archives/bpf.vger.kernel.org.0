Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961C954D22F
	for <lists+bpf@lfdr.de>; Wed, 15 Jun 2022 21:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345333AbiFOT6O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jun 2022 15:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiFOT6N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Jun 2022 15:58:13 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1B439823;
        Wed, 15 Jun 2022 12:58:13 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id s12so25336457ejx.3;
        Wed, 15 Jun 2022 12:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L1i51INed9MDjVkx5XBHq4A3CdICpq5Shm3o/nTW15c=;
        b=lAP8Khtp863bs2Trxj3LufL1WJw2UYia3GY6QPXmqx0KIq/Vge5ICx3RSvrcRQT3M1
         VxgN3jVNTHa5tEzNwIiIkbduRd33d6qkL9hYw1Gwf5Vd5Jm/OCzsHSxkuIDF/wh9V7e4
         KJEtpD24baWosngE/Pfve5n054u6YiuQqK7Kae/ZUdJXTnOU6xI4GJzyszuDGXkB+bpl
         OL+4zQdR2RPGwJoRNb6uku6pKUBZrkpX8cjZoeEax+E0uiJZZo+oRhormVPQOSAZ2OkA
         9dfVZ88F2C3fzBDG5XJlRRhCDJ58TXEYYfeIzh5W49pTHsqHJECLYTeB4BxfHmNnu20G
         y3Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L1i51INed9MDjVkx5XBHq4A3CdICpq5Shm3o/nTW15c=;
        b=LB5Ynz2bCQN/wuxiLnn2f3UQ4jZpj3m1wTweG7BfIvMTB9jIezxeK58MMUR3YjvlMV
         EKc65SmNP7pQ2YMuLFMaGw1599Qy0FOrvcBW3jOldJXBM2xMxFxiDyXZZwXMAiFZwvxv
         2VLmVMo8gT70qeLweok6dAIQ5VtmFk7gwbNtZO3KCHFjAZgYg9TB1eO4H2Lzlrgd+NYa
         Mzydl/e+8azp3Ony6jAMzJcUe5ynjesjQDE0Of+mL7PRh1k0xlcKeuBTVuCLuOAOKye5
         aaQYCGlgViBUUSx9u+68gVODoIVgMKU7uUr0lvAx+8B2/3VUEwYhOD4YZzhaxLrSqfKj
         OAhA==
X-Gm-Message-State: AJIora+0dFJgILqmV/Cl9E7J9na33zt+PH1tc4V4hae5zXK9x+IZb9FR
        JZy3aAxOVo1Wazx0P6DiA9w=
X-Google-Smtp-Source: AGRyM1sKr7gdYoKzz9Hzt2pC2wiCCAqMPXBxvbAlmpUdtmpnKgpek4E7oo2L20oycSIAPpQmfcGmfg==
X-Received: by 2002:a17:906:7254:b0:6fe:5637:cbe6 with SMTP id n20-20020a170906725400b006fe5637cbe6mr1337710ejk.612.1655323091902;
        Wed, 15 Jun 2022 12:58:11 -0700 (PDT)
Received: from erthalion.local (dslb-094-222-028-039.094.222.pools.vodafone-ip.de. [94.222.28.39])
        by smtp.gmail.com with ESMTPSA id w6-20020a50c446000000b004329ec63c42sm82382edf.25.2022.06.15.12.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 12:58:11 -0700 (PDT)
Date:   Wed, 15 Jun 2022 21:57:09 +0200
From:   Dmitry Dolgov <9erthalion6@gmail.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>
Subject: Re: [PATCH] perf/kprobe: maxactive for fd-based kprobe
Message-ID: <20220615195709.uzpagadyxxyb3fpr@erthalion.local>
References: <20220609192936.23985-1-9erthalion6@gmail.com>
 <9AB360B5-F7DE-4159-B75E-9C21106FDB49@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9AB360B5-F7DE-4159-B75E-9C21106FDB49@fb.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> On Wed, Jun 15, 2022 at 06:20:05PM +0000, Song Liu wrote:
>
>
> > On Jun 9, 2022, at 12:29 PM, Dmitrii Dolgov <9erthalion6@gmail.com> wrote:
> >
> > Enable specifying maxactive for fd based kretprobe. This will be useful
> > for tracing tools like bcc and bpftrace (see for example discussion [1]).
> > Use highest 12 bit (bit 52-63) to allow maximal maxactive of 4095.
> >
> > The original patch [2] seems to be fallen through the cracks and wasn't
> > applied. I've merely rebased the work done by Song Liu and verififed it
> > still works.
> >
> > [1]: https://github.com/iovisor/bpftrace/issues/835
> > [2]: https://lore.kernel.org/all/20191007223111.1142454-1-songliubraving@fb.com/
>
> Thanks for pulling this out of the cracks. :)
>
> Since there isn't much change from [2], I think this should still show
> "From:" me, and with "Signed-off-by" both of us.

Yep, sorry for that -- the second version should have all mentioned
correctly. Thanks!
