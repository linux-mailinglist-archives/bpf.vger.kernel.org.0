Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96024508EE2
	for <lists+bpf@lfdr.de>; Wed, 20 Apr 2022 19:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381342AbiDTR47 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Apr 2022 13:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381354AbiDTR46 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Apr 2022 13:56:58 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A964E43AD1
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 10:54:11 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id n33-20020a17090a5aa400b001d28f5ee3f9so2727726pji.4
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 10:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uD8z1p/Q/8ux3CU+H6eKpTTlkpCCd0OQILK90LgOw3A=;
        b=aWjbWiEer+zv2JjtW00nVimMXoyoZaOL2eZ7PAiJCiJffP/VVq8ZKdERW2SOvrMPU3
         mAXoxMKTq4UeOF6oIjTmSVtOr0mFBbyVQI/mQjrz/aLZ2SDHa3V7cIB74Y1G6NA+ot/b
         +zNKStpHvae54VoE4Rrx/knL80RUwocafw1/65hVKSrha4k+C8D6vgESSDWEEY0clEnU
         lscK5KOhpGT/sNHFUhjJrsnuiS21yM4aYsB3Y9hlC9YH794H15RF4Pry6uu/8mE/pMF2
         PA8Fffevu52aMudyKT6JdlU9W2U8JoaiVDyGKM7cjP9iGzUXhEsY8awFodMxvBHZtxiS
         qZAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uD8z1p/Q/8ux3CU+H6eKpTTlkpCCd0OQILK90LgOw3A=;
        b=BqJ9P9Os2F45uE1f+uFR1qbSQR8xHLE5U/zCnidoVX+8T7jbwoFQal+schJQUT9JQb
         NS2DUCibDIlAzbkhYxGVD4qF6qJjE3GHgVZYPa98BclVUe1GlA43H9orRkFY3WLZZZ7J
         hkmDKI5E0KjydWD6Ta51Z81Mo2eY7OQXnZt0QGjACiQfgtcXTwW6If9teIBKnFAoRHqF
         ps16/vpUBvpgHOIJ5qF4ZB++0bRNEptXtQUWUPpWxX+tfQVT9c4e5pnFZ71R/4u5Udk/
         AmMHt93llORvZTzyMsrXkt8VnkhhnrgE3fB5lC+rDMVL/eDsd0arBtBc9SAhJy2Zmva6
         7uag==
X-Gm-Message-State: AOAM533jNI+d8Hy342Hf2U2I3eal/k/78hwQKLEfu41SaPsmecomTSec
        Zc67/3mOsXUbccdnw5nyig==
X-Google-Smtp-Source: ABdhPJywIB8LYi/pm42sf149ssk2+fT0PLdxF+bK+7F6TomzVCPDRAcQJKmSqa9gTAf47e97+mbsrA==
X-Received: by 2002:a17:902:8214:b0:158:b5c2:1d02 with SMTP id x20-20020a170902821400b00158b5c21d02mr22340136pln.27.1650477251114;
        Wed, 20 Apr 2022 10:54:11 -0700 (PDT)
Received: from bytedance ([4.7.18.210])
        by smtp.gmail.com with ESMTPSA id 7-20020a17090a174700b001d55fe3d4cesm325427pjm.1.2022.04.20.10.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 10:54:10 -0700 (PDT)
Date:   Wed, 20 Apr 2022 10:54:07 -0700
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Martin KaFai Lau <kafai@fb.com>,
        =?utf-8?B?6IyD5byA5Zac?= <fankaixi.li@bytedance.com>,
        Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>,
        john fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [External] [PATCH bpf-next v2 3/3] selftests/bpf: add ipv6 vxlan
 tunnel source testcase
Message-ID: <20220420175407.GA22312@bytedance>
References: <20220322154231.55044-1-fankaixi.li@bytedance.com>
 <20220322154231.55044-4-fankaixi.li@bytedance.com>
 <20220324193755.vbtg2dvi4x3rysx2@kafai-mbp>
 <CAEEdnKFbq=TpmrXtFi8A-pPcLS-pRS2TT_726v7S52XMX6crQA@mail.gmail.com>
 <CAEEdnKH2g0gZ5y2x_1BCK1MHt6_r=_RLw18=apbwpn9+Thi7nA@mail.gmail.com>
 <20220407175333.tnmk4am3hzpfhept@kafai-mbp.dhcp.thefacebook.com>
 <20220415231155.GA9900@bytedance>
 <CAEf4BzbFT1Sdb4fijyU4WELP64rX1K8dWwMu6CDcDkMXTwqHfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzbFT1Sdb4fijyU4WELP64rX1K8dWwMu6CDcDkMXTwqHfQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Andrii,

On Wed, Apr 20, 2022 at 10:09:59AM -0700, Andrii Nakryiko wrote:
> On Fri, Apr 15, 2022 at 4:12 PM Peilin Ye <yepeilin.cs@gmail.com> wrote:
> > On Thu, Apr 07, 2022 at 10:53:33AM -0700, Martin KaFai Lau wrote:
> > > The .sh is not run by CI also.
> >
> > Just curious: by "CI", did you mean libbpf-ci [1] ?
> >
> > If so, why doesn't libbpf-ci run these .sh tests?  Recently we triggered
> > a bug (see [2]) in ip6_gre by running test_tunnel.sh.  I think it
> > could've been spotted much sooner if test_tunnel.sh was being run.
> 
> If you convert test_tunnel.sh into a test inside test_progs, we'll be
> running it regularly.

Thanks!  I think Kaixi is working on this.

Peilin Ye

