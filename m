Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A277C5B3AA4
	for <lists+bpf@lfdr.de>; Fri,  9 Sep 2022 16:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiIIO03 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 10:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiIIO01 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 10:26:27 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B019AFE5
        for <bpf@vger.kernel.org>; Fri,  9 Sep 2022 07:26:25 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id e17so2780302edc.5
        for <bpf@vger.kernel.org>; Fri, 09 Sep 2022 07:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=6OVYT87a1HM+BEDMyFtepXNcpTv/Hy0RQK4o3Avssaw=;
        b=Kw7wSnhyKUyVU0ooIE/fR+dQGnH40NVZ/S138hwiExoNqB0SCYj201c3UtLFHvuhOG
         /iN1MZQR73xBYa76jw+Oo3uIJsVs2lAedplrS2sdOYuHF6AxU7LJrVYnxI8muJh4sgKX
         9adf/h1vHfLtR8uMgsiU7SZC1wz5w1Z7cfBphz4Abgd7lSyBXCAGBqyGwAX3ZKDesEjy
         +FtDg9/Yxms6GGlXNUHCX/IhJ3OZlAjXeP9FgToxnOWvwcTLc8Npt3PS3yGBOa+DBiEX
         HyH6xABCZfu6QVfHecz/COolevQQnLYDGeJjMnq7rIL5K3qaSRP+UMv3dGH4ux1Ce3Ah
         d7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=6OVYT87a1HM+BEDMyFtepXNcpTv/Hy0RQK4o3Avssaw=;
        b=Hydf0udyVfgw4f5Yy2ChFoMYRIU5aJS/H0s65eEtnBfJdPA6MorC+8BZmJ4nm6tMim
         OzqJMaMwCRF/r89gp4T5YOUTNLZmTgNperBQyPbj6wooa/ZvwffUgXwZy6PWGmo97oWt
         4vKpxOg7KLA4BbGlYD6+3xj6v2GBvmsRvONQc80+5ztjV1M/M90g8hvLFFVhcc759n9Q
         3l1loXZeyZSGYtUrXyVT3aoqLsbf8IzjifV0mO1NA37Y8rC0scb2bdEpqUj4NzAJNLbh
         KpffGTUPh43CujNAbeHxuxjmp49lMFzC7OG6BtN5CtlsTQstMjW3vpSpo63P7SxVaHzf
         CPJQ==
X-Gm-Message-State: ACgBeo0PRNMtMFQzZ5ZEpisutTXgL1ITobE9lGkNV3BcHDO0xTv3/g18
        YAHvEYGQULTZnmNG1Rz5wnxJ/kffxk+u3/1lPZE=
X-Google-Smtp-Source: AA6agR7OdpnEE6dWBclst2cpa5PBSZlEIT6+sNOp+ygv2qri0tDw+k2Gpck9ytzDUKZIj9kHJQf0ilORkcNPOfJTCSU=
X-Received: by 2002:a05:6402:27ca:b0:43e:ce64:ca07 with SMTP id
 c10-20020a05640227ca00b0043ece64ca07mr12025743ede.66.1662733584359; Fri, 09
 Sep 2022 07:26:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220904204145.3089-1-memxor@gmail.com> <20220904204145.3089-19-memxor@gmail.com>
 <20220908003557.uqiiwfjmjoq2sp3j@macbook-pro-4.dhcp.thefacebook.com>
 <247e2959-410f-f494-1083-f53224fb6f7a@fb.com> <CAP01T77RdV-yP4RBy2G1R1SDfuwhLPOBi9mdAwnB7q_B8ovPtA@mail.gmail.com>
In-Reply-To: <CAP01T77RdV-yP4RBy2G1R1SDfuwhLPOBi9mdAwnB7q_B8ovPtA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 9 Sep 2022 07:26:13 -0700
Message-ID: <CAADnVQJmJfD7L3LVTWtYWu8A7frHs+A_Km8Ra4GRFr4iVTx9gQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next v1 18/32] bpf: Support bpf_spin_lock in local kptrs
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Delyan Kratunov <delyank@fb.com>
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

On Fri, Sep 9, 2022 at 4:21 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> On Fri, 9 Sept 2022 at 10:25, Dave Marchevsky <davemarchevsky@fb.com> wrote:
> >
> > On 9/7/22 8:35 PM, Alexei Starovoitov wrote:
> > > On Sun, Sep 04, 2022 at 10:41:31PM +0200, Kumar Kartikeya Dwivedi wrote:
> > >> diff --git a/include/linux/poison.h b/include/linux/poison.h
> > >> index d62ef5a6b4e9..753e00b81acf 100644
> > >> --- a/include/linux/poison.h
> > >> +++ b/include/linux/poison.h
> > >> @@ -81,4 +81,7 @@
> > >>  /********** net/core/page_pool.c **********/
> > >>  #define PP_SIGNATURE                (0x40 + POISON_POINTER_DELTA)
> > >>
> > >> +/********** kernel/bpf/helpers.c **********/
> > >> +#define BPF_PTR_POISON              ((void *)((0xeB9FUL << 2) + POISON_POINTER_DELTA))
> > >> +
> > >
> > > That was part of Dave's patch set as well.
> > > Please keep his SOB and authorship and keep it as separate patch.
> >
> > My patch picked a different constant :). But on that note, it also added some
> > checking in verifier.c so that verification fails if any arg or retval type
> > was BPF_PTR_POISON after it should've been replaced. Perhaps it's worth shipping
> > that patch ("bpf: Add verifier check for BPF_PTR_POISON retval and arg")
> > separately? Would allow both rbtree series and this lock-focused patch to drop
> > BPF_PTR_POISON changes after rebase.
>
> Yeah, feel free to post it separately. I'm using the constant in this
> patch for a different purpose (I separate the BPF_PTR_POISON case into
> its own different argument type, and then check that it is always set
> for it in check_btf_id_ok, to ensure DYN_BTF_ID is not setting some
> static real BTF ID).
>
> But why change the constant, eB9F looks very close to eBPF already :).

+1. It's already in many spots:
git grep eB9F
