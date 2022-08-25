Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9085A0536
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 02:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiHYAf6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 20:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiHYAf5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 20:35:57 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56FC82D31
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 17:35:56 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id b142so14773863iof.10
        for <bpf@vger.kernel.org>; Wed, 24 Aug 2022 17:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=9xIitNI2kBDldEzG9ZBQhex3Em4TszbN91MY6Jz1X20=;
        b=NipC4HT8qdJ6dNW3lQF7lZwdv/yzxPxGum9zcYOaa8h+RdPx23JEbaMdHN+pjWbLjS
         1qBGrCs0fcipiASODRrxEKXpfML0IR1MysUBjvpJhBrlfBEEG77eQ+WI4B0FwtykOnNR
         6QM9IDycVrAYkUayWE3+ijEPFPCzHOzCOUdyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=9xIitNI2kBDldEzG9ZBQhex3Em4TszbN91MY6Jz1X20=;
        b=LnllEezvqoSOehQh58dOizNJyxGqIqqvrw5seIn2JRGGk8Kb+bkn8n1qmqTy/wSwx1
         0Xii1t4vI53IeqjZ9Np7eM6gN+FDQEr6y7vjymkctmuR1rxKZvXBrFDm9neoN+rAqlQL
         +uqbd8Rrb5toNkaa9qGtU0pwA5gdYDbjGptU/lkQOHzK2RfANOjM7IiISnGlcZjcrNwu
         WWMEUtSjOBKcbEfvMcMjreg5K0cD2iO40EL1wMVDLnHKcudMMZcVZT7+4chxQ+/Pd6/G
         hSxtO1f2IH/apOgqqYZyrGjXo8+czF/YpNmAreMSNTICNzftoghhdhJXbZMehVB/b2ok
         almA==
X-Gm-Message-State: ACgBeo1L0EjHokUpbvok24/d9OBMEECoZnIXrEdudGZY6hn6ZuJI+TPC
        dHRXah/Rt9GFAHUzdK90eQmnvFjB0Sd4ZHCGZgXQUg==
X-Google-Smtp-Source: AA6agR4ETsJ4XySAEUGPf5u5BXlXlFzx7xpAqcidLI/88KdMjz9oNbLzQqBEpBFN5rBXipXUzYi0QIunuq2eBqWvAQY=
X-Received: by 2002:a05:6638:378c:b0:343:447e:e6e2 with SMTP id
 w12-20020a056638378c00b00343447ee6e2mr669419jal.118.1661387756170; Wed, 24
 Aug 2022 17:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220819214232.18784-1-alexei.starovoitov@gmail.com>
 <20220819214232.18784-10-alexei.starovoitov@gmail.com> <CAP01T74qCUsm3mO64d6mbDcjQZxO2fxjZ+JX7kkv2ACXPpZojw@mail.gmail.com>
 <CAADnVQJqqjN=i-ghnk4hjaztBtrRmyDZD7ro8cPNNwRP16=gkg@mail.gmail.com>
In-Reply-To: <CAADnVQJqqjN=i-ghnk4hjaztBtrRmyDZD7ro8cPNNwRP16=gkg@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 24 Aug 2022 20:35:44 -0400
Message-ID: <CAEXW_YSDzfBmHsAtPruRQp6YKA6vXnV4MD3AxsS3=xxWAxuY2g@mail.gmail.com>
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

On Wed, Aug 24, 2022 at 8:14 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Aug 24, 2022 at 12:59 PM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Fri, 19 Aug 2022 at 23:43, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > From: Alexei Starovoitov <ast@kernel.org>
> > >
> > > SLAB_TYPESAFE_BY_RCU makes kmem_caches non mergeable and slows down
> > > kmem_cache_destroy. All bpf_mem_cache are safe to share across different maps
> > > and programs. Convert SLAB_TYPESAFE_BY_RCU to batched call_rcu. This change
> > > solves the memory consumption issue, avoids kmem_cache_destroy latency and
> > > keeps bpf hash map performance the same.
> > >
> > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> >
> > Makes sense, there was a call_rcu_lazy work from Joel (CCed) on doing
> > this batching using a timer + max batch count instead, I wonder if
> > that fits our use case and could be useful in the future when it is
> > merged?
> >
> > https://lore.kernel.org/rcu/20220713213237.1596225-2-joel@joelfernandes.org
>
> Thanks for the pointer. It looks orthogonal.
> timer based call_rcu is for power savings.
> I'm not sure how it would help here. Probably wouldn't hurt.
> But explicit waiting_for_gp list is necessary here,
> because two later patches (sleepable support and per-cpu rcu-safe
> freeing) are relying on this patch.

Hello Kumar and Alexei,

Kumar thanks for the CC. I am seeing this BPF work for the first time
so have not gone over it too much - but in case the waiting is
synchronous by any chance, call_rcu_lazy() could hurt. The idea is to
only queue callbacks that are not all that important to the system
while keeping it quiet (power being the primary reason but Daniel
Bristot would concur it brings down OS noise and helps RT as well).

Have a good evening, Thank you,

 - Joel
