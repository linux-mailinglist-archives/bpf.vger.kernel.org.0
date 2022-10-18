Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184A5603683
	for <lists+bpf@lfdr.de>; Wed, 19 Oct 2022 01:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbiJRXMc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Oct 2022 19:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiJRXMc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Oct 2022 19:12:32 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1980FD8EDE
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 16:12:29 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id 13so35891591ejn.3
        for <bpf@vger.kernel.org>; Tue, 18 Oct 2022 16:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LfNp2lXOaZYMUQSpvZhsLca4a1ic/3wCMoE7aGN+9Hw=;
        b=JUHNsZaqJwRhNlfM0u2YJCdPtb1ci2qkH/8YL6KvY0ePQGmZFRK+D2RR1+HzQAo/zb
         I5ae1P6Lij20JHksPoH6+q3Ouw8NONxPx6jIl3HXtHhfplYMLu5NJLydTgDQgN0uPIOG
         fnzWyCVCWwb8/16/cm/K0Up3sr6CUadZn+8LXLiloDVY3Oy3s5jcMQuikUrqJ/ekIOR6
         yHEeNValT7/htO6hxAD3YHGeyWuRIpmxMWc+T4Zte4R+Z9nEvlwKkd/FTouw7nc8NBqq
         qwEIjvoAaI5o8ewOP/QTP+ZP/Csjn/adN0fhyNWzSOtpS0FJEySoK3l9ceJm2eZEMUxv
         VaSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LfNp2lXOaZYMUQSpvZhsLca4a1ic/3wCMoE7aGN+9Hw=;
        b=YVbm2280xGhs74iskZZ87nxAT8ce74cx9pByafXNyAgr1GnNH6LOCbUDZFqxUtVwSq
         NfB2prmRmrQEQ9PubcLNrz+6DpfonxuEpmdleFZpYerW6trE0cHRULzrQmynM7lFlHtG
         H21D6BAa/6vX/gnM4LP7bxv9iw4OBm5xR70iEBgFHJ9Bm6MPC4X7ykLL0Q9PK14EwkXs
         eKB42gc0aiH0L+jdWhoGeDNVtZbJkchCNA0tptNUaz8x4HCtEpJA/K6b02W+v8X8kCaT
         bQRnGQ5vlR1AvtT2yFErrbkL0rNLPggjw+ldtUcaXGIQmoPDK3choRtC5EVRZgvEMC8I
         P/HA==
X-Gm-Message-State: ACrzQf2qLX4RBpD8EVZ5SCc85OgBVN+D3pTiiCFEvbh3akRh2x51x2d8
        VGZlZknzszr8zyQWORDwHLOW5Hebdn+tBRwtJbo=
X-Google-Smtp-Source: AMsMyM57h/J9SaUGp+VddFomXW2QDXkKI5fLCXjjggElPLb35vQnLhe9S2Gaa+1G32S+bx23/tFYQkhEUiKWrojMDak=
X-Received: by 2002:a17:907:72c1:b0:783:34ce:87b9 with SMTP id
 du1-20020a17090772c100b0078334ce87b9mr4385821ejc.115.1666134747476; Tue, 18
 Oct 2022 16:12:27 -0700 (PDT)
MIME-Version: 1.0
References: <Y02Yk8gUgVDuZR4Q@google.com> <CAJD7tkYSXNb=D1OX_iv7PD-eJaK_7-5tcNvDQrWprWbWwJ2=oQ@mail.gmail.com>
 <CAKH8qBvHJPj6U_dOxH1C4FHJvg9=FE8YZUV3_kc_HJNt1TDuJQ@mail.gmail.com>
 <CAJD7tkYHQ=7jVqU__v4eNxvP-RBAH-M6BmTO1+ogto=m-xb2gw@mail.gmail.com>
 <CAKH8qBtdNv0OmL0oH+U2w0ygLmGUug37xNhHWpjc5=0tn1cThQ@mail.gmail.com>
 <CAJD7tkbPhecz+XPeSMjua77YXr-+Fkrpz9M3bBVKAj+PsXJgyQ@mail.gmail.com>
 <b539eba1-586a-bf3b-31f9-11ea0774c805@linux.dev> <Y03USAeiBL5Ol22E@google.com>
 <06e37b29-b384-7432-d966-ad89901de55d@linux.dev> <fdc0484e-c2da-a118-b845-f937f0ef5688@meta.com>
 <Y07dlsqt9u3BYF2U@google.com> <CAADnVQKPMaU5av0soDh+ddnqpLbjDHEVyFpK9hX4g+99cBiJdQ@mail.gmail.com>
In-Reply-To: <CAADnVQKPMaU5av0soDh+ddnqpLbjDHEVyFpK9hX4g+99cBiJdQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 18 Oct 2022 16:12:15 -0700
Message-ID: <CAEf4BzZWdHZquywrk9YZv1sn72g9-NRQYOSVv8ipRnLZj1+w1w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/5] bpf: Implement cgroup storage available to
 non-cgroup-attached bpf progs
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Stanislav Fomichev <sdf@google.com>, Yonghong Song <yhs@meta.com>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Yosry Ahmed <yosryahmed@google.com>,
        Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 18, 2022 at 10:18 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Oct 18, 2022 at 10:08 AM <sdf@google.com> wrote:
> > > >
> > > > '#define BPF_MAP_TYPE_CGROUP_STORAGE BPF_MAP_TYPE_CGRP_LOCAL_STORAGE /*
> > > > depreciated by BPF_MAP_TYPE_CGRP_STORAGE */' in the uapi.
> > > >
> > > > The new cgroup storage uses a shorter name "cgrp", like
> > > > BPF_MAP_TYPE_CGRP_STORAGE and bpf_cgrp_storage_get()?
> >
> > > This might work and the naming convention will be similar to
> > > existing sk/inode/task storage.
> >
> > +1, CGRP_STORAGE sounds good!
>
> +1 from me as well.

it's totally bikeshedding zone :) but isn't CG_STORAGE just as
recognizable but easier to mentally read as well? Like SK for socket,
instead of SCKT

>
> Something like this ?
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 17f61338f8f8..13dcb2418847 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -922,7 +922,8 @@ enum bpf_map_type {
>         BPF_MAP_TYPE_CPUMAP,
>         BPF_MAP_TYPE_XSKMAP,
>         BPF_MAP_TYPE_SOCKHASH,
> -       BPF_MAP_TYPE_CGROUP_STORAGE,
> +       BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED,
> +       BPF_MAP_TYPE_CGROUP_STORAGE = BPF_MAP_TYPE_CGROUP_STORAGE_DEPRECATED,
>         BPF_MAP_TYPE_REUSEPORT_SOCKARRAY,
>         BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE,
>         BPF_MAP_TYPE_QUEUE,
> @@ -935,6 +936,7 @@ enum bpf_map_type {
>         BPF_MAP_TYPE_TASK_STORAGE,
>         BPF_MAP_TYPE_BLOOM_FILTER,
>         BPF_MAP_TYPE_USER_RINGBUF,
> +       BPF_MAP_TYPE_CGRP_STORAGE,
>  };
>
> What are we going to do with BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE ?
> Probably should come up with a replacement as well?
