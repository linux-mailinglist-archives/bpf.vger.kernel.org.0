Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F36760320D
	for <lists+bpf@lfdr.de>; Tue, 18 Oct 2022 20:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiJRSMX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 14:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiJRSMW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 14:12:22 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107D3748FC
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 11:12:18 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id o13so7885196ilc.7
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 11:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WPYfFt0+MykG0YpnQx6+DhyeSu/BwJtTNFyJrrlyohk=;
        b=bap5k5JzNgBpJ2/dZuTcyz+EyCR16d68pFmA42tq3G68IRmlA3yL4g7cK1ZOn50P7c
         BOGgYrAXJXUnSX/zYEJsxh0X37Uqn5eBtAVVWX6xSAYkA4Z6AkfdK90R0EfHP28Y5mIx
         TLfn0mEv+fuPCaJqFoNfBR1lTf1xeUEd8zrhZNlK+0ATlf5s/x0FvJ0AzVhJtEXX6VmE
         H99goAiEdqPtop/tflWAwYzbbAt6M8B/QYReBELRedGgg+y9RZbNdHMlw14a+7n2Xee3
         aif+WayWI+evQbeEWXuphQb1dmVmC7iLlo3VrmZKsuKeVmu1tdk/tqORPDCsiDLJ/Qx/
         gxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WPYfFt0+MykG0YpnQx6+DhyeSu/BwJtTNFyJrrlyohk=;
        b=T4QE24Ksw4SBPh7YFywnFi8KV0LwSQPBcgJ3ai51DVX56wj0qmFkXtFf80Jid69R+C
         o4QhTC4FsgDjqKER/C3MEBYKzX6wIUMLrrl9UEAqzmyqW/GUUhf0NSZdGKBlYX5jCcdd
         E4ccju6NOh3hWfDpVRUNlMwyRcChDBizvTrAOLqSMQfCHm4v5jvJmJ6xXWx1OFsiNr6X
         LbHlOmDs55OpTOUfPL9r3J/o8nox9kH5EJUAKzx/aKkOKEMwdUO0bCT1KdDmZ7a+2Vqu
         h7U75AYIl7GGLCuowk9FT+lP2WYnlZPR13fI7T4DVSpCVy75g1v/b1xnweAQVC4diSOT
         muEw==
X-Gm-Message-State: ACrzQf1NZYT+UQ0oZPRfM+MwIb+EJjEHgL4QxqPRdgDp7OKdOBabuInj
        TcDJ+C3nqT816u+joMMwJ2zovRwXPcEuuVa4AxSVRrsSXLPRWw==
X-Google-Smtp-Source: AMsMyM7KRQwJEL+0VOdQGc8fDsN6fbOwZWxQoJElnuZm5UyOyrbnsh35753akBDnz7kX1ifLNy6gES3CN2FatcvPCBc=
X-Received: by 2002:a05:6e02:bef:b0:2f9:889b:6db6 with SMTP id
 d15-20020a056e020bef00b002f9889b6db6mr2470872ilu.281.1666116737528; Tue, 18
 Oct 2022 11:12:17 -0700 (PDT)
MIME-Version: 1.0
References: <Y02Yk8gUgVDuZR4Q@google.com> <CAJD7tkYSXNb=D1OX_iv7PD-eJaK_7-5tcNvDQrWprWbWwJ2=oQ@mail.gmail.com>
 <CAKH8qBvHJPj6U_dOxH1C4FHJvg9=FE8YZUV3_kc_HJNt1TDuJQ@mail.gmail.com>
 <CAJD7tkYHQ=7jVqU__v4eNxvP-RBAH-M6BmTO1+ogto=m-xb2gw@mail.gmail.com>
 <CAKH8qBtdNv0OmL0oH+U2w0ygLmGUug37xNhHWpjc5=0tn1cThQ@mail.gmail.com>
 <CAJD7tkbPhecz+XPeSMjua77YXr-+Fkrpz9M3bBVKAj+PsXJgyQ@mail.gmail.com>
 <b539eba1-586a-bf3b-31f9-11ea0774c805@linux.dev> <Y03USAeiBL5Ol22E@google.com>
 <06e37b29-b384-7432-d966-ad89901de55d@linux.dev> <fdc0484e-c2da-a118-b845-f937f0ef5688@meta.com>
 <Y07dlsqt9u3BYF2U@google.com> <CAADnVQKPMaU5av0soDh+ddnqpLbjDHEVyFpK9hX4g+99cBiJdQ@mail.gmail.com>
 <67048049-dee4-3ff0-035c-65af34555725@linux.dev>
In-Reply-To: <67048049-dee4-3ff0-035c-65af34555725@linux.dev>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 18 Oct 2022 11:11:41 -0700
Message-ID: <CAJD7tkY5DZK9uO=rnNWTFoHU3qnbsj74engcC8VYyzQaJm1PFA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/5] bpf: Implement cgroup storage available to
 non-cgroup-attached bpf progs
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Yonghong Song <yhs@meta.com>, Yonghong Song <yhs@fb.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>, Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 18, 2022 at 11:08 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> On 10/18/22 10:17 AM, Alexei Starovoitov wrote:
> > On Tue, Oct 18, 2022 at 10:08 AM <sdf@google.com> wrote:
> >>>>
> >>>> '#define BPF_MAP_TYPE_CGROUP_STORAGE BPF_MAP_TYPE_CGRP_LOCAL_STORAGE /*
> >>>> depreciated by BPF_MAP_TYPE_CGRP_STORAGE */' in the uapi.
> >>>>
> >>>> The new cgroup storage uses a shorter name "cgrp", like
> >>>> BPF_MAP_TYPE_CGRP_STORAGE and bpf_cgrp_storage_get()?
> >>
> >>> This might work and the naming convention will be similar to
> >>> existing sk/inode/task storage.
> >>
> >> +1, CGRP_STORAGE sounds good!
> >
> > +1 from me as well.
> >
> > Something like this ?
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index 17f61338f8f8..13dcb2418847 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -922,7 +922,8 @@ enum bpf_map_type {
> >          BPF_MAP_TYPE_CPUMAP,
> >          BPF_MAP_TYPE_XSKMAP,
> >          BPF_MAP_TYPE_SOCKHASH,
> > -       BPF_MAP_TYPE_CGROUP_STORAGE,
> > +       BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED,
> > +       BPF_MAP_TYPE_CGROUP_STORAGE = BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED,
>
> +1
>
> >          BPF_MAP_TYPE_REUSEPORT_SOCKARRAY,
> >          BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE,
> >          BPF_MAP_TYPE_QUEUE,
> > @@ -935,6 +936,7 @@ enum bpf_map_type {
> >          BPF_MAP_TYPE_TASK_STORAGE,
> >          BPF_MAP_TYPE_BLOOM_FILTER,
> >          BPF_MAP_TYPE_USER_RINGBUF,
> > +       BPF_MAP_TYPE_CGRP_STORAGE,
> >   };
> >
> > What are we going to do with BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE ?
> > Probably should come up with a replacement as well?
>
> Yeah, need to come up with a percpu answer for it.  The percpu usage has never
> come up on the sk storage and also the later task/inode storage.  or the user is
> just getting by with an array like map's value.
>
> May be the bpf prog can call bpf_mem_alloc() to alloc the percpu memory in the
> future and then store it as the kptr in the BPF_MAP_TYPE_CGRP_STORAGE?

A percpu cgroup storage would be very beneficial for cgroup statistics
collection, things like the selftest in
tools/testing/selftests/bpf/progs/cgroup_hierarchical_stats.c
currently uses a percpu hashmap indexed by cgroup id, so using a
percpu cgroup storage instead would be a nice upgrade.
