Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1169E2A5E62
	for <lists+bpf@lfdr.de>; Wed,  4 Nov 2020 07:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgKDGvk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Nov 2020 01:51:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgKDGvk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Nov 2020 01:51:40 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BCDC061A4D;
        Tue,  3 Nov 2020 22:51:40 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id s21so21191642oij.0;
        Tue, 03 Nov 2020 22:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=ww8C00KkabtDLxcKDhOCeqOXU2u0UX9A1QT4C+4IqFg=;
        b=U+oNG1i1btw1zXWh+bm57bzcwFK4mYE4QByksZ31ZOpagHl1C+v/SOUHCSg7CswSd6
         PTALrp62R1Zd8o9Y2R4V+5pfOT3M3V17TSN4pIWQYirQTCsraF9BmMCa9HTYEcOhzRI6
         rGK786eMxm2RXA5HdI85KXlzyUyZDPdQ/K3LpagBqDCjooWEpQC47PVpuET5ReKHkqAN
         yPH5rnqhxev3jEnC9f/hYHs/HCsNCd06op0/ksCYK/NFIkHeh27ebS8RmQNk4AUYSS/y
         gQ2zSOgJ4tkFBwdR5yXoOf82s3pQt86EctYNMw+0zoXy0dANx6Y1gV4hE99tet0przAN
         dhhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=ww8C00KkabtDLxcKDhOCeqOXU2u0UX9A1QT4C+4IqFg=;
        b=OmHFjjwYCA/8mCMNtWhy1eZecHveNnO1E6YFoNocxjA9QnIjjjnrv6UM5E+scgxM6M
         kUR+LtICxHt2efgWRbFPTSU2v0uBCOW376pHsw33q4a0ZdO6VOtFSEoyqOFlKQQ28w7C
         THcCsuAnTd4VlQIY5zMq2PIHN+3ydzDO3/prBOIs+PLnKxpOO09dimyiB2OqrA33MCbh
         YLxEZeiCK8Vs+QDvShkgx2gw1agvmhHdMUgMece3eEDr0XwofONYky6bvhBUFju4FMcM
         PrJVN4F2bI9M/1goSzeb2BTvL4Q18kGA+bDjnJXdiqY9A58bY4cO/IGZ22U/MJsOX64b
         Xp4g==
X-Gm-Message-State: AOAM530tA6crOrZUcqqeMgyz4MnHlOyeN/7TEtqT/DurJHm71wYGr8Il
        UzRcUeuwmmeNM9f3P1VticDl1qtE16EGtA==
X-Google-Smtp-Source: ABdhPJzyun/H7Hi4rEAyd54p/J+uvbUT3Lpvv2RlIVlAbVFszhVzGqMO/sgbsnF8KixxOElEmKZGPQ==
X-Received: by 2002:aca:5b85:: with SMTP id p127mr1872802oib.34.1604472699568;
        Tue, 03 Nov 2020 22:51:39 -0800 (PST)
Received: from localhost ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id h15sm303563ots.31.2020.11.03.22.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 22:51:38 -0800 (PST)
Date:   Tue, 03 Nov 2020 22:51:30 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Message-ID: <5fa24f72dd48e_9fa0e20871@john-XPS-13-9370.notmuch>
In-Reply-To: <CAADnVQLKhmA49RGH=SSCg3qHxZOzU5bHp+sw+Yw7M_7KB0zD4g@mail.gmail.com>
References: <20201103153132.2717326-1-kpsingh@chromium.org>
 <20201103153132.2717326-8-kpsingh@chromium.org>
 <20201103184714.iukuqfw2byls3s4k@ast-mbp.dhcp.thefacebook.com>
 <CACYkzJ6A5GrQhBhv7GC8aeeLpoc7bnN=6Rn2UoM1P90odLZZ=g@mail.gmail.com>
 <CACYkzJ6D=vwaEhgaB2vevOo0186m=yfxeKBQ8eWWck8xjtczNA@mail.gmail.com>
 <CAADnVQ+DBHXkf8SFwnTKmSKi7mdAx56dWbpp5++Cc02CQjz+Ng@mail.gmail.com>
 <CACYkzJ6uc4fbRMNmj3kFeSu=V2JqWruJLFjMnPet_HXW-EdRng@mail.gmail.com>
 <CAADnVQLKhmA49RGH=SSCg3qHxZOzU5bHp+sw+Yw7M_7KB0zD4g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 7/8] bpf: Add tests for task_local_storage
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov wrote:
> On Tue, Nov 3, 2020 at 5:55 PM KP Singh <kpsingh@chromium.org> wrote:
> >
> > [...]
> >
> > > >
> > > > I saw the docs mention that these are not exposed to tracing programs due to
> > > > insufficient preemption checks. Do you think it would be okay to allow them
> > > > for LSM programs?
> > >
> > > hmm. Isn't it allowed already?
> > > The verifier does:
> > >         if ((is_tracing_prog_type(prog_type) ||
> > >              prog_type == BPF_PROG_TYPE_SOCKET_FILTER) &&
> > >             map_value_has_spin_lock(map)) {
> > >                 verbose(env, "tracing progs cannot use bpf_spin_lock yet\n");
> > >                 return -EINVAL;
> > >         }
> > >
> > > BPF_PROG_TYPE_LSM is not in this list.
> >
> > The verifier does not have any problem, it's just that the helpers are not
> > exposed to LSM programs via bpf_lsm_func_proto.
> >
> > So all we need is:
> >
> > diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> > index 61f8cc52fd5b..93383df2140b 100644
> > --- a/kernel/bpf/bpf_lsm.c
> > +++ b/kernel/bpf/bpf_lsm.c
> > @@ -63,6 +63,10 @@ bpf_lsm_func_proto(enum bpf_func_id func_id, const
> > struct bpf_prog *prog)
> >                 return &bpf_task_storage_get_proto;
> >         case BPF_FUNC_task_storage_delete:
> >                 return &bpf_task_storage_delete_proto;
> > +       case BPF_FUNC_spin_lock:
> > +               return &bpf_spin_lock_proto;
> > +       case BPF_FUNC_spin_unlock:
> > +               return &bpf_spin_unlock_proto;
> 
> Ahh. Yes. That should do it. Right now I don't see concerns with safety
> of the bpf_spin_lock in bpf_lsm progs.

What about sleepable lsm hooks? Normally we wouldn't expect to sleep with
a spinlock held. Should we have a check to ensure programs bpf_spin_lock
are not also sleepable?
