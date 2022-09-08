Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D41A5B279B
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 22:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiIHUVU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 16:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiIHUVT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 16:21:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8315AEC74A;
        Thu,  8 Sep 2022 13:21:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 07D56B82258;
        Thu,  8 Sep 2022 20:21:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE503C433C1;
        Thu,  8 Sep 2022 20:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662668475;
        bh=6pLu81MViNZ3vOfUBzSq3rkw+GwHKE8Ga0clDe9AKfw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dSeIQS9ErZc40hJTb/ceFFxw+TGRCEkSQ9mkV5D98K5gITwdVUxh9TqSZM9UQiwhJ
         eWZ7y3zDBex5COdbvvVpyjiJ6SMUhX3NyarURYHA1FvXOGoU/UikpELaoiCeFUY64y
         gE38cbAopvou/oZWj+MlzpKIc9R9J6rfxv5xmz4tqoUhMxb6MAbj+T9n4kQVFqeSDy
         e5zp+sYnQtRIammvTPmY8Ivhve8XbJ7cjJ+8qJapSx0KgPrNbd883WLAcoTCcCvypx
         Osgrq6dUvSB5zHzwsuTvT9XywDm3GGaMB78mXI4VoE4Szj9Nyi8Yh8I1oeXIvqcUD9
         Cpv2zfHpr8gfg==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-11e9a7135easo47450154fac.6;
        Thu, 08 Sep 2022 13:21:15 -0700 (PDT)
X-Gm-Message-State: ACgBeo3BPNob3zVGNfqvhlmj1BLniWeLBg1gO4qgiEoIVx+xYefLmWEm
        IVBzv9jI/Qn6fI7Knags7Iec25CuEpZk9mbiC5I=
X-Google-Smtp-Source: AA6agR4yrENLdhkklnrAOjsgiuEW1FkKaUORHB/1XhO7zv+Xb+H3UuNc5IKeV0xQEdTnh83P8F5fTC2PXyVkAhsiysY=
X-Received: by 2002:aca:3016:0:b0:345:9d47:5e11 with SMTP id
 w22-20020aca3016000000b003459d475e11mr2161800oiw.31.1662668474858; Thu, 08
 Sep 2022 13:21:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220907155746.1750329-1-punit.agrawal@bytedance.com>
 <CAPhsuW6+D0bfoPZdQ0j-NtCvgMED4YF-LyqXTQQHo+x7tw3yug@mail.gmail.com> <877d2ecffy.fsf_-_@stealth>
In-Reply-To: <877d2ecffy.fsf_-_@stealth>
From:   Song Liu <song@kernel.org>
Date:   Thu, 8 Sep 2022 13:21:04 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6fUuc6E7_EoY1h-cikDAT6AuLYCwb89JnaTeOcdrsNFw@mail.gmail.com>
Message-ID: <CAPhsuW6fUuc6E7_EoY1h-cikDAT6AuLYCwb89JnaTeOcdrsNFw@mail.gmail.com>
Subject: Re: Re: [PATCH v2] bpf: Simplify code by using for_each_cpu_wrap()
To:     Punit Agrawal <punit.agrawal@bytedance.com>
Cc:     Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        zhoufeng.zf@bytedance.com, Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 8, 2022 at 3:45 AM Punit Agrawal
<punit.agrawal@bytedance.com> wrote:
>
> Hi Song,
>
> Thanks for taking a look.
>
> Song Liu <song@kernel.org> writes:
>
> > On Wed, Sep 7, 2022 at 8:58 AM Punit Agrawal
> > <punit.agrawal@bytedance.com> wrote:
> >>
> >> In the percpu freelist code, it is a common pattern to iterate over
> >> the possible CPUs mask starting with the current CPU. The pattern is
> >> implemented using a hand rolled while loop with the loop variable
> >> increment being open-coded.
> >>
> >> Simplify the code by using for_each_cpu_wrap() helper to iterate over
> >> the possible cpus starting with the current CPU. As a result, some of
> >> the special-casing in the loop also gets simplified.
> >>
> >> No functional change intended.
> >>
> >> Signed-off-by: Punit Agrawal <punit.agrawal@bytedance.com>
> >> ---
> >> v1 -> v2:
> >> * Fixed the incorrect transformation changing semantics of __pcpu_freelist_push_nmi()
> >>
> >> Previous version -
> >> v1: https://lore.kernel.org/all/20220817130807.68279-1-punit.agrawal@bytedance.com/
> >>
> >>  kernel/bpf/percpu_freelist.c | 48 ++++++++++++------------------------
> >>  1 file changed, 16 insertions(+), 32 deletions(-)
> >>
> >> diff --git a/kernel/bpf/percpu_freelist.c b/kernel/bpf/percpu_freelist.c
> >> index 00b874c8e889..b6e7f5c5b9ab 100644
> >> --- a/kernel/bpf/percpu_freelist.c
> >> +++ b/kernel/bpf/percpu_freelist.c
> >> @@ -58,23 +58,21 @@ static inline void ___pcpu_freelist_push_nmi(struct pcpu_freelist *s,
> >>  {
> >>         int cpu, orig_cpu;
> >>
> >> -       orig_cpu = cpu = raw_smp_processor_id();
> >> +       orig_cpu = raw_smp_processor_id();
> >>         while (1) {
> >> -               struct pcpu_freelist_head *head;
> >> +               for_each_cpu_wrap(cpu, cpu_possible_mask, orig_cpu) {
> >> +                       struct pcpu_freelist_head *head;
> >>
> >> -               head = per_cpu_ptr(s->freelist, cpu);
> >> -               if (raw_spin_trylock(&head->lock)) {
> >> -                       pcpu_freelist_push_node(head, node);
> >> -                       raw_spin_unlock(&head->lock);
> >> -                       return;
> >> +                       head = per_cpu_ptr(s->freelist, cpu);
> >> +                       if (raw_spin_trylock(&head->lock)) {
> >> +                               pcpu_freelist_push_node(head, node);
> >> +                               raw_spin_unlock(&head->lock);
> >> +                               return;
> >> +                       }
> >>                 }
> >> -               cpu = cpumask_next(cpu, cpu_possible_mask);
> >> -               if (cpu >= nr_cpu_ids)
> >> -                       cpu = 0;
> >
> > I personally don't like nested loops here. Maybe we can keep
> > the original while loop and use cpumask_next_wrap()?
>
> Out of curiosity, is there a reason to avoid nesting here? The nested
> loop avoids the "cpu == orig_cpu" unnecessary check every iteration.

for_each_cpu_wrap is a more complex loop, so we are using some
checks either way.

OTOH, the nesting is not too deep (two loops then one if), so I guess
current version is fine.

Acked-by: Song Liu <song@kernel.org>


>
> As suggested, it's possible to use cpumask_next_wrap() like below -
>
> diff --git a/kernel/bpf/percpu_freelist.c b/kernel/bpf/percpu_freelist.c
> index 00b874c8e889..19e8eab70c40 100644
> --- a/kernel/bpf/percpu_freelist.c
> +++ b/kernel/bpf/percpu_freelist.c
> @@ -68,9 +68,7 @@ static inline void ___pcpu_freelist_push_nmi(struct pcpu_freelist *s,
>                         raw_spin_unlock(&head->lock);
>                         return;
>                 }
> -               cpu = cpumask_next(cpu, cpu_possible_mask);
> -               if (cpu >= nr_cpu_ids)
> -                       cpu = 0;
> +               cpu = cpumask_next_wrap(cpu, cpu_possible_mask, orig_cpu, false);
>
>                 /* cannot lock any per cpu lock, try extralist */
>                 if (cpu == orig_cpu &&
>
>
> I can send an updated patch if this is preferred.
>
> Thanks,
> Punit
