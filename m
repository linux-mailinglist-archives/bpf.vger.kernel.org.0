Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A5C64E97F
	for <lists+bpf@lfdr.de>; Fri, 16 Dec 2022 11:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbiLPKcl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Dec 2022 05:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbiLPKcZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Dec 2022 05:32:25 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619D836C49
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 02:32:22 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id co23so2047840wrb.4
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 02:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qe6KtQ/PVxJcAa1+i3Pw91kj9uFtRQg1Ch7/v5kN+mA=;
        b=K32tt9FnZQr85MAUPpFnAjLltZCrMROIydE0ezMINNmUiaP5JQvUOYZu/PVDf10ziJ
         0OquiTPxrPiflRLol+U7fSACeTIW+zFsAaUW3QRAzZ0D0knS3StvfuDBqWdEM0S1f9UW
         QNTh5gTKvUfe7HIyWkLopxX4rig699hvFqxexKNH56ahgVEiG9YuY+enyKUZRgzfVmgY
         XzuzBmD/6axV3uzSyMle3vogVOHUzmCsckS51DhJlgzF9rn+UVt8TIpQPLZIyzzcO1U2
         wRMlmHVUGPKoS+L4+ijC2utCanvA2JUpsvm/Etjj2sXQSUOnmIQ/8lu05ZZNM1a/wU0h
         XdBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qe6KtQ/PVxJcAa1+i3Pw91kj9uFtRQg1Ch7/v5kN+mA=;
        b=4al6d2HxJFAD7Xqe/qp3haFhsmq57cxd/NtCTlWmI32KRvKtLwF/Rzx0hIVrnTOQQe
         16Amh0ZlBbZQT+odufz/WvNnbYekebXlioHakMMMY0r9Tsk/UHbDC0F/xtSHc6snTH68
         mjSYViGLwWsuiPti10ylEsJq1phkmXZn8vQNHCIXyah2NP6/rCwokQqku9zuUkk70Ovp
         7IENLxnrfvvvFSxJPBia08gKXbvi+/bgfl7+eScuzBA5QFytwd/5X1LmCgrz3bwGFv1i
         Ukjp5zCgsxUZzlh5wPVsQXr/UArZ6FVy1S8IQKz0r3qf/31MUZ9W5/ovrIRKJe3v+qlS
         o9xA==
X-Gm-Message-State: ANoB5pn0ULkG7V6oxZ4FQpmJoMFCiIFEkh+w6fezaORjU0Yf3Yr2w4Dh
        1kaS8DiEsyKAeWXLJjZuATr/2SknZEX2ys1Y0K0=
X-Google-Smtp-Source: AA0mqf5Aca/nc7lYt1v8MXvSFte71fDeG7Swt+2oOTWrdHQyN1Jg5BZt8xkbLtQHH8chL54D5+TDQGdq/lLGjxoVjs4=
X-Received: by 2002:a5d:4592:0:b0:242:5675:5a0d with SMTP id
 p18-20020a5d4592000000b0024256755a0dmr13207352wrq.199.1671186740895; Fri, 16
 Dec 2022 02:32:20 -0800 (PST)
MIME-Version: 1.0
References: <20221214103857.69082-1-xiangxia.m.yue@gmail.com> <2e2dc326-69ad-1228-c425-357dcdb6bfcd@huawei.com>
In-Reply-To: <2e2dc326-69ad-1228-c425-357dcdb6bfcd@huawei.com>
From:   Tonghao Zhang <xiangxia.m.yue@gmail.com>
Date:   Fri, 16 Dec 2022 18:31:44 +0800
Message-ID: <CAMDZJNUjjaUBYP9wB7z6VrwAQebb4J=DZrch9zA+AcL2VD4qnw@mail.gmail.com>
Subject: Re: [bpf-next 1/2] bpf: hash map, avoid deadlock with suitable hash mask
To:     Hou Tao <houtao1@huawei.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
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

On Fri, Dec 16, 2022 at 6:15 PM Hou Tao <houtao1@huawei.com> wrote:
>
> Hi,
>
> On 12/14/2022 6:38 PM, xiangxia.m.yue@gmail.com wrote:
> > From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> >
> > The deadlock still may occur while accessed in NMI and non-NMI
> > context. Because in NMI, we still may access the same bucket but with
> > different map_locked index.
> >
> > For example, on the same CPU, .max_entries = 2, we update the hash map,
> > with key = 4, while running bpf prog in NMI nmi_handle(), to update
> > hash map with key = 20, so it will have the same bucket index but have
> > different map_locked index.
> >
> > To fix this issue, using min mask to hash again.
> >
> > Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: Andrii Nakryiko <andrii@kernel.org>
> > Cc: Martin KaFai Lau <martin.lau@linux.dev>
> > Cc: Song Liu <song@kernel.org>
> > Cc: Yonghong Song <yhs@fb.com>
> > Cc: John Fastabend <john.fastabend@gmail.com>
> > Cc: KP Singh <kpsingh@kernel.org>
> > Cc: Stanislav Fomichev <sdf@google.com>
> > Cc: Hao Luo <haoluo@google.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Hou Tao <houtao1@huawei.com>
> > ---
> >  kernel/bpf/hashtab.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> > index 5aa2b5525f79..8b25036a8690 100644
> > --- a/kernel/bpf/hashtab.c
> > +++ b/kernel/bpf/hashtab.c
> > @@ -152,7 +152,7 @@ static inline int htab_lock_bucket(const struct bpf_htab *htab,
> >  {
> >       unsigned long flags;
> >
> > -     hash = hash & HASHTAB_MAP_LOCK_MASK;
> > +     hash = hash & min(HASHTAB_MAP_LOCK_MASK, htab->n_buckets -1);
> There is warning for kernel test robot and it seems that min_t(...) is required
I will send v2 soon. Thanks.
> here.
>
> Otherwise, this patch looks good to me, so:
>
> Acked-by: Hou Tao <houtao1@huawei.com>
> >
> >       preempt_disable();
> >       if (unlikely(__this_cpu_inc_return(*(htab->map_locked[hash])) != 1)) {
> > @@ -171,7 +171,7 @@ static inline void htab_unlock_bucket(const struct bpf_htab *htab,
> >                                     struct bucket *b, u32 hash,
> >                                     unsigned long flags)
> >  {
> > -     hash = hash & HASHTAB_MAP_LOCK_MASK;
> > +     hash = hash & min(HASHTAB_MAP_LOCK_MASK, htab->n_buckets -1);
> >       raw_spin_unlock_irqrestore(&b->raw_lock, flags);
> >       __this_cpu_dec(*(htab->map_locked[hash]));
> >       preempt_enable();
>


-- 
Best regards, Tonghao
