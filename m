Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413DD65CC41
	for <lists+bpf@lfdr.de>; Wed,  4 Jan 2023 04:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjADD7X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Jan 2023 22:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238441AbjADD7S (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Jan 2023 22:59:18 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5034F15725
        for <bpf@vger.kernel.org>; Tue,  3 Jan 2023 19:59:18 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 79so21423262pgf.11
        for <bpf@vger.kernel.org>; Tue, 03 Jan 2023 19:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wTGNCk99pawntNnfGl2KHBjkXBa7uE377m43kLrPbUk=;
        b=SLYPygDxt6VMu9DpVzd58JRW6WapRGpYzTyE3dl3vTUqXTkP2grTYAP5uk8Bbqh7LX
         pa2PgMiaoTsHxVOQhXQ4d8SEkumbpiG2BVU5zOxyJlisNZLMoFb5fVcksdk2j8kslCOy
         oaSRKFccPbS2gWGzyCShiY8p00RFu2Z+5RaQYgVz4pwirx0GRFWDuAvKyCRzc2FfMEyq
         hciMizjJrABbNDRydvLtUXt2Fns0YXoRobR2zN2G1NqUI58T19684TbI0ORTxgnCrH2i
         P5GngZOu9/Yrolk7ezTi76zp3iq7d26aTkHAlvoq8KUGE1K01Xi9E7lJpllMg0GtXwO9
         NHRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wTGNCk99pawntNnfGl2KHBjkXBa7uE377m43kLrPbUk=;
        b=p2Os0qMvmEhwqpnsRif67wUtqWNdo4YG+M1Tp9R1BYiCllbu8aodNf2qcG4431GBhF
         8bgmy21KNIjt7lNfikMIwzciaoPx8E50UfxpBqL/fRUcSOMehkQx5099mxk/x+VP+KbG
         ZwmMv918pE+vTVIb4XH/tftojz15Yn5vTMyaudEwMi25s0cYFQ8h67Nj4V3n3z+vhkqm
         Q2BlvytNYGDIqtMEjLEwOIreVQV46DQI2DYJVD/Enz36EYQ+aS9R9e8saUtOELvu621y
         4Qg78gJj2tG3duofTbDqo1a5RUdbOSS+XRtgfEBw4S6f7mLIpwnYLmpUmHJotA99Ovvi
         QZcg==
X-Gm-Message-State: AFqh2kqKsFSr8PsC9xycSm9NLJEF8Fx1s4yjlcNg3ZeVCy9eKCbvfXLL
        tkf3s42SWhjz8dSLfPdaPWkkqLyrmNKjKupYb565sA==
X-Google-Smtp-Source: AMrXdXtI/jbvRljZh2hKsP2PdRUSKrgkb44UoTu2PRb8QElaH7NO6zPJlA4b+PqiOBDXLSrGMzCQY7PPXg9fF68wXMs=
X-Received: by 2002:a63:1e11:0:b0:490:afd1:55b2 with SMTP id
 e17-20020a631e11000000b00490afd155b2mr2410087pge.112.1672804756667; Tue, 03
 Jan 2023 19:59:16 -0800 (PST)
MIME-Version: 1.0
References: <20221220222043.3348718-1-sdf@google.com> <20221220222043.3348718-9-sdf@google.com>
 <5983e0f0-e1ee-5843-33ea-64d139e2e849@linux.dev> <CAKH8qBtCrAqxTzSECyG2VjO7rx27mdSEKMwXadrvVOvDaf5rBg@mail.gmail.com>
 <9b7bfabe-1d67-07b6-80e9-19e87143beec@linux.dev>
In-Reply-To: <9b7bfabe-1d67-07b6-80e9-19e87143beec@linux.dev>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 3 Jan 2023 19:59:05 -0800
Message-ID: <CAKH8qBu6bWuczAgjdQc0tnkFK9p2YDtO-3j=u_AjTUvHv9cKCg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 08/17] bpf: Support consuming XDP HW metadata
 from fext programs
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>,
        bpf@vger.kernel.org
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

On Tue, Jan 3, 2023 at 5:51 PM Martin KaFai Lau <martin.lau@linux.dev> wrote:
>
> On 12/22/22 8:06 PM, Stanislav Fomichev wrote:
> >>> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> >>> index 11c558be4992..64a68e8fb072 100644
> >>> --- a/kernel/bpf/syscall.c
> >>> +++ b/kernel/bpf/syscall.c
> >>> @@ -2605,6 +2605,12 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr)
> >>>                        goto free_prog_sec;
> >>>        }
> >>>
> >>> +     if (type == BPF_PROG_TYPE_EXT && dst_prog) {
> >> Does it also need to test the bpf_prog_is_dev_bound(dst_prog->aux)?  Otherwise,
> >> the bpf_prog_dev_bound_inherit() below will fail on everything for !CONFIG_NET.
> > We do the following in bpf_prog_dev_bound_inherit which should be enough?
> >
> > if (!bpf_prog_is_dev_bound(old_prog->aux))
> >       return 0;
> >
> > Or am I missing something?
>
> The inline one in include/linux/bpf.h will be called instead when CONFIG_NET is
> not set:
>
> static inline int bpf_prog_dev_bound_inherit(struct bpf_prog *new_prog,
>                                              struct bpf_prog *old_prog)
> {
>         return -EOPNOTSUPP;
> }

Ah, I totally missed the fact you were talking about !CONFIG_NET,
thanks for clarifying.
Yeah, will add that extra bpf_prog_is_dev_bound(dst_prog->aux) you've
mentioned, thx!
