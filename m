Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3D356A7F0
	for <lists+bpf@lfdr.de>; Thu,  7 Jul 2022 18:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236332AbiGGQWr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Jul 2022 12:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236182AbiGGQWq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Jul 2022 12:22:46 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1DA2E6B0
        for <bpf@vger.kernel.org>; Thu,  7 Jul 2022 09:22:45 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id l7so7212162ual.9
        for <bpf@vger.kernel.org>; Thu, 07 Jul 2022 09:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YL2NT3tF2m6OvX44lYMQ92EPibm/ACpLuEg/IDa4O3o=;
        b=B7TEEskLpwWChFwIltTmK/3j3mQ9tBBcdFzHZkg7MBDpolgePNLC8ZlBmjyw3TapVu
         ZWi1KdYl1bQfobVWu93oLN1kNdsUz2o/hRDAhZgWLDnI1SbruchneDC9gH8KF4e1uBfB
         QHSHdd6RZxpFbOLWSXIUiOQa1nyag3CA9mqhyvsyl73ZOMJ3X/I+QCHAb8tuVffBF/ni
         1rFFgTRcmlMO8ZyRiVqH5SqyEL0cI89XvgPfhMOHGbhVQstY9gEjY+sYX0vEQyXOL0Yi
         AcFSSgd8kSJrj78F2VPni2ToTK+d/phrfSoga3vUPRbC5oOaKYYbBUfbIl4LIuV4sdsW
         c7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YL2NT3tF2m6OvX44lYMQ92EPibm/ACpLuEg/IDa4O3o=;
        b=vY+kqo+K3yKHzag7Aph9X8pRI71Fyb8+0YoEHOGq3w9J+xX0ePv40kFyYhdgDY20Xl
         qMn5mIjJZViL+XdTCHN3Y1drhcoafjBN3WYiidDwuUzYuhfwOsR8Lm9du3hzIfAD2lMz
         NtSHI/ChNu2sTDtoWk9UndsufwyxinQtL98ruVkUywgjzbzXg7CzvmXs/mQIiYDXIdVM
         emRB4mFk6bh/gU7Bmu7iCFkqKMwquOevtWa1V1SVQKyOwyRT45k6ZCgqTpXhNi1LsEb+
         rP38m8dirA24P/noEwTSfcNuEGUoi8hf3hFmWubRwOVkpzLeMVvdh0vMchE4d8NehUqM
         8zYA==
X-Gm-Message-State: AJIora//I91snEiz7alk9MTpt00lRm031DXgDsXsP6d941+HqrKhlDKj
        jQjkqZFhGeBPXiufh66+FbKNyBxDpGPfk0CJzaM=
X-Google-Smtp-Source: AGRyM1tNUpyVSeFrARrIwLJGLqqgOSoKfOz4fvnsoo21L9zR1v17rJbz4t2hIZlPAAgTZCW/bG0q4b7byFCuBKJ/SI4=
X-Received: by 2002:a9f:3245:0:b0:382:ecc2:e174 with SMTP id
 y5-20020a9f3245000000b00382ecc2e174mr4908062uad.38.1657210964257; Thu, 07 Jul
 2022 09:22:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220706155848.4939-1-laoar.shao@gmail.com> <20220706155848.4939-3-laoar.shao@gmail.com>
 <CAADnVQLHDATCgQE39nVTy-LE+Mhx-hXbj8phBeyUKFc1f=W-6A@mail.gmail.com>
 <CALOAHbDN3zv0Tx+poM5jH_AHR7HzVLag8534QdS07c2U_rVtbQ@mail.gmail.com> <CAADnVQJX-ODKvV3XT1i=0jHBTpgWb0UTmWU5hGn9D4VTiZQUrg@mail.gmail.com>
In-Reply-To: <CAADnVQJX-ODKvV3XT1i=0jHBTpgWb0UTmWU5hGn9D4VTiZQUrg@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Fri, 8 Jul 2022 00:22:07 +0800
Message-ID: <CALOAHbBK1=ujbZp5n4t9zQf+DPZ3-a2ZDL0a3sfhVU6meJGqYw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] bpf: Warn on non-preallocated case for
 missed trace types
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hao Luo <haoluo@google.com>, bpf <bpf@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
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

On Thu, Jul 7, 2022 at 11:45 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jul 7, 2022 at 3:30 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > On Thu, Jul 7, 2022 at 12:50 AM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Wed, Jul 6, 2022 at 8:59 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> > > >
> > > > BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE and BPF_PROG_TYPE_TRACING are
> > > > trace type as well, which may also cause unexpected memory allocation if
> > > > we set BPF_F_NO_PREALLOC.
> > > > Let's also warn on both of them.
> > > >
> > > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > > ---
> > > >  kernel/bpf/verifier.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > index df3ec6b05f05..f9c0f4889a3a 100644
> > > > --- a/kernel/bpf/verifier.c
> > > > +++ b/kernel/bpf/verifier.c
> > > > @@ -12570,6 +12570,8 @@ static bool is_tracing_prog_type(enum bpf_prog_type type)
> > > >         case BPF_PROG_TYPE_TRACEPOINT:
> > > >         case BPF_PROG_TYPE_PERF_EVENT:
> > > >         case BPF_PROG_TYPE_RAW_TRACEPOINT:
> > > > +       case BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE:
> > > > +       case BPF_PROG_TYPE_TRACING:
> > >
> > > BPF_TRACE_ITER should probably be excluded.
> >
> > Right, I have verified that BPF_TRACE_ITER can be excluded.
> > Will change it.
>
> Probably more than that. See that your change broke BPF CI
> and selftests are failing.
> Which means it breaks existing bpf programs.

Ah, yes, "#194 timer:FAIL" which is caused by this change.
I will be more careful here.

-- 
Regards
Yafang
