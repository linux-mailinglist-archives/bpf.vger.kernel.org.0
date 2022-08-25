Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 678295A055C
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 02:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiHYAtq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 20:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbiHYAto (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 20:49:44 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B92D10550
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 17:49:44 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id 62so14793957iov.5
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 17:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=N5i57tWQ+irbW+vnVsv9droGyD3UZBCcowhtHNvVvPU=;
        b=s/ooz3pquL0Gz0cf/qsj/faJ+E6H3xbieImxrb1Xqr7y1hyNM/EvkqoGAOKnb9BFDe
         irGhnXyWcfg20C8oUBPV5LSCI3iiMrezDMfq0eAm2Q+ISsR0r5IC2UH7dGY6jzZZe0DC
         mQyo+32zxbNZJ0cLIPk66CV9E3rQf2ITAzQ2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=N5i57tWQ+irbW+vnVsv9droGyD3UZBCcowhtHNvVvPU=;
        b=zHmCsHW4SBx9UBcqbaFZ6hVqZYkKrb3fqgRW8J8vP4sOtlZ8qU43XzmefleqqvA8Zt
         ObqdTTF9t1TQ+nHL9p9aEHnA0Nejf8xq8jR690claLAZazTEtvqwp2FY89U5TBV/yRcg
         r3mp3TJAljeK25A9kAKxefICsQmgO+Y3gr4RmZZKQpfOpay417mHGV/4bFAotziJBt1N
         IZNVALgVwDmQC6uODp5k4mav0ysJec7JHrmpOtxbQ148ksUse4YFI2Q7MU7xtpzdlWIB
         JG6A3cdllAUcd6COafxiRp6YOJyw0A+xpzsEET1CKdRYOPxZ8aXOhtROckprkx+Cq3Xe
         89Iw==
X-Gm-Message-State: ACgBeo1FQWymh1QqGSqfGrpIO+ki7DD0CgbEDD8DkOoyP/A02kYSkXCE
        RcM/OG57H0ltEo4lH/bmmHI7SDPtn8pAT4j56LSA1w==
X-Google-Smtp-Source: AA6agR6468ijP2gfHY/mTIsuu4vjhOIIKZZRxIDj36hgNKBAeicdpHwPHQjKgrWvxkmVcfnoCSnS9CEdCfOyHcuJXG8=
X-Received: by 2002:a05:6638:40a8:b0:346:8e3c:8141 with SMTP id
 m40-20020a05663840a800b003468e3c8141mr668278jam.107.1661388583517; Wed, 24
 Aug 2022 17:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220819214232.18784-1-alexei.starovoitov@gmail.com>
 <20220819214232.18784-10-alexei.starovoitov@gmail.com> <CAP01T74qCUsm3mO64d6mbDcjQZxO2fxjZ+JX7kkv2ACXPpZojw@mail.gmail.com>
 <CAADnVQJqqjN=i-ghnk4hjaztBtrRmyDZD7ro8cPNNwRP16=gkg@mail.gmail.com> <CAEXW_YSDzfBmHsAtPruRQp6YKA6vXnV4MD3AxsS3=xxWAxuY2g@mail.gmail.com>
In-Reply-To: <CAEXW_YSDzfBmHsAtPruRQp6YKA6vXnV4MD3AxsS3=xxWAxuY2g@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 24 Aug 2022 20:49:31 -0400
Message-ID: <CAEXW_YSa9PhCNv=nmiBtydYhwb+rs-_Wn+0s1zaSvMKjA6=2+Q@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 09/15] bpf: Batch call_rcu callbacks instead
 of SLAB_TYPESAFE_BY_RCU.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Tejun Heo <tj@kernel.org>,
        Delyan Kratunov <delyank@fb.com>,
        linux-mm <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 24, 2022 at 8:35 PM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Wed, Aug 24, 2022 at 8:14 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Aug 24, 2022 at 12:59 PM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > On Fri, 19 Aug 2022 at 23:43, Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > >
> > > > From: Alexei Starovoitov <ast@kernel.org>
> > > >
> > > > SLAB_TYPESAFE_BY_RCU makes kmem_caches non mergeable and slows down
> > > > kmem_cache_destroy. All bpf_mem_cache are safe to share across different maps
> > > > and programs. Convert SLAB_TYPESAFE_BY_RCU to batched call_rcu. This change
> > > > solves the memory consumption issue, avoids kmem_cache_destroy latency and
> > > > keeps bpf hash map performance the same.
> > > >
> > > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > >
> > > Makes sense, there was a call_rcu_lazy work from Joel (CCed) on doing
> > > this batching using a timer + max batch count instead, I wonder if
> > > that fits our use case and could be useful in the future when it is
> > > merged?
> > >
> > > https://lore.kernel.org/rcu/20220713213237.1596225-2-joel@joelfernandes.org
> >
> > Thanks for the pointer. It looks orthogonal.
> > timer based call_rcu is for power savings.
> > I'm not sure how it would help here. Probably wouldn't hurt.
> > But explicit waiting_for_gp list is necessary here,
> > because two later patches (sleepable support and per-cpu rcu-safe
> > freeing) are relying on this patch.
>
> Hello Kumar and Alexei,
>
> Kumar thanks for the CC. I am seeing this BPF work for the first time
> so have not gone over it too much - but in case the waiting is
> synchronous by any chance, call_rcu_lazy() could hurt. The idea is to
> only queue callbacks that are not all that important to the system
> while keeping it quiet (power being the primary reason but Daniel
> Bristot would concur it brings down OS noise and helps RT as well).

Just as FYI, I see rcu_barrier() used in Alexei's patch - that will
flush the lazy CBs to keep rcu_barrier() both correct and performant.
At that point call_rcu_lazy() is equivalent to call_rcu() as we  no
longer kept the callbacks a secret from the rest of the system.

Thanks,

 -  Joel
