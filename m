Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2700653764
	for <lists+bpf@lfdr.de>; Wed, 21 Dec 2022 21:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbiLUUN1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Dec 2022 15:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiLUUN0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Dec 2022 15:13:26 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F115331
        for <bpf@vger.kernel.org>; Wed, 21 Dec 2022 12:13:25 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d7so16616881pll.9
        for <bpf@vger.kernel.org>; Wed, 21 Dec 2022 12:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zLXJYoqrA8qjYj9G2HQZKjo0c3Ld+Ma9nTGSOm1fY/s=;
        b=lDjSKwbp4bofJhEAqRo/WnqiarwYW0DG6LpPc3cfdsyZB0jGuYoqb8cutonM3jZ3uI
         zcmaJMlCgyeqGvUKzXavLKYDm/sW6Qyl/zCiaX32ela93wCMV1a7JKBS3UkxVkTU72Z6
         FXAK7UUh24Fc4fg3dXP/Ua5Cj3Cx0smUVJG4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zLXJYoqrA8qjYj9G2HQZKjo0c3Ld+Ma9nTGSOm1fY/s=;
        b=WVgOEc/qjV2jMEiiUe6+0WVHoHl5TFcYfYL7XJoSjLqvX4CjbdZwoJNWaZLpk1BjyC
         Xjyy4eZxYTghdkQQVtmSCrMGu+3pet00ZRWS0Ynvs/0YLiGH8TBSiB1GgFDZzUZS8EjW
         l9HaiYkO5j+5x+XqkzRJkXdC5votP/kn4GWYAO7JQQreE7Qkcy6Aqr04H3EVf8IlSTHn
         yvPa0ge3gkRJ7CfKweBowtHgWQUoUO/FPtlSImLcDYM0SgIIWym7yNt/+b03RKWXjnIH
         /bf2HTXq2tK0wInwwuCfgzZezaqIpezMs44PRAxqLVDA6WGoJ7/CX8B2BqC2U9c8yY6X
         fEUQ==
X-Gm-Message-State: AFqh2kp1NYlZ6gRtjF26PSrOS2WiVMP2yYiCEKX8Zukm0AGS5II6TyAK
        ezuxOS3CJxUwhOwmqFBByNHfgVA5uvNRcE+Dtxg=
X-Google-Smtp-Source: AMrXdXuObTLvyTgx0ldnlZ2lP+rn/X1kOnH32A92dEdVZG2k6gAU+PvRo4o04FGwTE3YZUW2fpOHyA==
X-Received: by 2002:a05:6a20:3d84:b0:b0:1abd:8604 with SMTP id s4-20020a056a203d8400b000b01abd8604mr5316142pzi.41.1671653604939;
        Wed, 21 Dec 2022 12:13:24 -0800 (PST)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com. [209.85.216.54])
        by smtp.gmail.com with ESMTPSA id e8-20020a170902784800b00186abb95bfdsm11834496pln.25.2022.12.21.12.13.23
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 12:13:24 -0800 (PST)
Received: by mail-pj1-f54.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so3221297pjd.0
        for <bpf@vger.kernel.org>; Wed, 21 Dec 2022 12:13:23 -0800 (PST)
X-Received: by 2002:a17:902:a984:b0:189:d081:1ebb with SMTP id
 bh4-20020a170902a98400b00189d0811ebbmr142129plb.130.1671653603257; Wed, 21
 Dec 2022 12:13:23 -0800 (PST)
MIME-Version: 1.0
References: <20221221-bpf-syscall-v1-0-9550f5f2c3fc@chromium.org> <CAKH8qBuLhZ+T9fvP=DXeYevdrNofTPpEiQqq2RenBUKVghPmtA@mail.gmail.com>
In-Reply-To: <CAKH8qBuLhZ+T9fvP=DXeYevdrNofTPpEiQqq2RenBUKVghPmtA@mail.gmail.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 21 Dec 2022 21:13:12 +0100
X-Gmail-Original-Message-ID: <CANiDSCv0EObZHCL1D1CHBRaNf68Df4Ur9kFgaoGSGH=KYwgOPw@mail.gmail.com>
Message-ID: <CANiDSCv0EObZHCL1D1CHBRaNf68Df4Ur9kFgaoGSGH=KYwgOPw@mail.gmail.com>
Subject: Re: [PATCH] bpf: Remove unused field initialization
To:     Stanislav Fomichev <sdf@google.com>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Hao Luo <haoluo@google.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Song Liu <song@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Stanislav

On Wed, 21 Dec 2022 at 21:10, Stanislav Fomichev <sdf@google.com> wrote:
>
> On Wed, Dec 21, 2022 at 11:55 AM Ricardo Ribalda <ribalda@chromium.org> wrote:
> >
> > Maxlen is used by standard proc_handlers such as proc_dointvec(), but in this
> > case we have our own proc_handler. Remove the initialization.
>
> Are you sure?
>
> bpf_stats_handler
>   proc_dointvec_minmax
>     do_proc_dointvec
>       __do_proc_dointvec
>         vleft = table->maxlen / sizeof(*i);

I believe do_proc_dointvec is using the value from:

struct ctl_table tmp = {
  .maxlen=sixeof(val);
}

>
> Maybe we should really do the following instead?
>
> .maxlen: sizeof(int)
>
> ?
>
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> > bpf: Trivial remove of unitialised field.
> >
> > I have inspired myself in your code and heritaded this bug :). Fixing this
> > here so none else makes the same mistake.
> >
> > To: Alexei Starovoitov <ast@kernel.org>
> > To: Daniel Borkmann <daniel@iogearbox.net>
> > To: John Fastabend <john.fastabend@gmail.com>
> > To: Andrii Nakryiko <andrii@kernel.org>
> > To: Martin KaFai Lau <martin.lau@linux.dev>
> > To: Song Liu <song@kernel.org>
> > To: Yonghong Song <yhs@fb.com>
> > To: KP Singh <kpsingh@kernel.org>
> > To: Stanislav Fomichev <sdf@google.com>
> > To: Hao Luo <haoluo@google.com>
> > To: Jiri Olsa <jolsa@kernel.org>
> > Cc: bpf@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
> >  kernel/bpf/syscall.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 35972afb6850..8e55456bd648 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -5319,7 +5319,6 @@ static struct ctl_table bpf_syscall_table[] = {
> >         {
> >                 .procname       = "bpf_stats_enabled",
> >                 .data           = &bpf_stats_enabled_key.key,
> > -               .maxlen         = sizeof(bpf_stats_enabled_key),
> >                 .mode           = 0644,
> >                 .proc_handler   = bpf_stats_handler,
> >         },
> >
> > ---
> > base-commit: b6bb9676f2165d518b35ba3bea5f1fcfc0d969bf
> > change-id: 20221221-bpf-syscall-58d1ac3f817a
> >
> > Best regards,
> > --
> > Ricardo Ribalda <ribalda@chromium.org>



-- 
Ricardo Ribalda
