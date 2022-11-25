Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16967638F61
	for <lists+bpf@lfdr.de>; Fri, 25 Nov 2022 18:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiKYRyC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Nov 2022 12:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiKYRyB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Nov 2022 12:54:01 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6861E2181B
        for <bpf@vger.kernel.org>; Fri, 25 Nov 2022 09:54:00 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id r26so5221409edc.10
        for <bpf@vger.kernel.org>; Fri, 25 Nov 2022 09:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+zu4iOD2i9aEDqWFD4gOuXzRQKvTYuf1pED2Ap01ffY=;
        b=hslFPydCLv7wY2RkVXpQmWmLvHWp2w8pq1r9Tanac+0GVTEM1uKutybZbM+EtuLOoh
         OGZ6esS8xlwGfnN7iMOFJb0Rslqn2ch6KXaOF95SbICBR2qXZUwyXZc5r/c16TObkyjM
         ItgVVU4JOsouf6/fBMb0VHQgMy9weCJqWaiXQoUeDAIcn2B9McrBqjXdbKwXla5RGRJf
         TSdsEIUbvOOZi8DWE8Vs74sY2I9713ymWWWDpVtfZpQkprdwuL6yn2ALQJLFln+lPmFu
         PzsvHAbFprrP0c6daid18OfgElliCTYnDoCit6iHLDDpHUEg2b3omaRWkqiy0iNTfrRb
         zyDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+zu4iOD2i9aEDqWFD4gOuXzRQKvTYuf1pED2Ap01ffY=;
        b=cxQh0/6HMFCqdwRkgtGyE2j8fvl8F2/LwFc0GtqycdivwZV/uIlI7T2ZxkkCJxgM9B
         T+AXjvZPGsqOXkfiLDUdlPZmHhtmglC8sukUeEXLRyJo4o5PJysUanOUqGA4LyAGpwTu
         PlFwv9MpxKiyka+o6y3VMHSI2fjeIxDz3Lb+ghWjGWGyi/VA3pIXbiqXD3UmaSPUTJT3
         EdTm/gnj1TvKYdGneqraepNMlC+YNPIC1uw1x2IkGLMQlxPmWsG+Dt1W1///ZbqgreuN
         93OTO5M5ki7NFNQsUMgmQrGJzhJu8ApB1oPF3p4+jp2LKNbBC2JYda11i5OWtXpUYldK
         sHWQ==
X-Gm-Message-State: ANoB5plryzeHmVV5K6GkZOKs3aOpAfFpmjyetwpJdyoIptAfjE4l8Dvn
        dMAWO294fXjWi195eZS11CWzWtdvPu7IPgET8cZ6NVOCpp4=
X-Google-Smtp-Source: AA0mqf64+/TRDG3mhjeXK6KJ15CEA79Maz2FhlS5TXRoVfFCYd8dKlv1l0JYuoCkmBt4G/EZag6ersNHtQKYe1k1Ym8=
X-Received: by 2002:aa7:cb03:0:b0:46a:a12a:4dcd with SMTP id
 s3-20020aa7cb03000000b0046aa12a4dcdmr6873277edt.338.1669398838803; Fri, 25
 Nov 2022 09:53:58 -0800 (PST)
MIME-Version: 1.0
References: <20221124053201.2372298-1-yhs@fb.com> <20221124053217.2373910-1-yhs@fb.com>
 <CAADnVQKVm1W0JpSD4YbH+teMVg8EHtR-+DXM-eR--EDHXxYz9Q@mail.gmail.com> <540e410d-0a31-ac74-d258-a636530fd77b@meta.com>
In-Reply-To: <540e410d-0a31-ac74-d258-a636530fd77b@meta.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 25 Nov 2022 09:53:46 -0800
Message-ID: <CAADnVQ+H3fm7ffLnJnG5DpKVaHDjPg2vEjRN0bPJOxqgMpKAFg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 3/4] bpf: Add kfunc bpf_rcu_read_lock/unlock()
To:     Yonghong Song <yhs@meta.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
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

On Thu, Nov 24, 2022 at 3:44 PM Yonghong Song <yhs@meta.com> wrote:
>
>
>
> On 11/24/22 12:34 PM, Alexei Starovoitov wrote:
> > On Wed, Nov 23, 2022 at 9:32 PM Yonghong Song <yhs@fb.com> wrote:
> >>
> >> @@ -16580,6 +16682,8 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr)
> >>          env->bypass_spec_v1 = bpf_bypass_spec_v1();
> >>          env->bypass_spec_v4 = bpf_bypass_spec_v4();
> >>          env->bpf_capable = bpf_capable();
> >> +       env->rcu_tag_supported =
> >> +               btf_find_by_name_kind(btf_vmlinux, "rcu", BTF_KIND_TYPE_TAG) > 0;
> >
> > It needs btf_vmlinux != NULL check as well,
> > since we error earlier only on IS_ERR(btf_vmlinux).
> > btf_vmlinux can be NULL at this point when CONFIG_DEBUG_INFO_BTF is not set.
>
> I checked the code and it looks like btf_find_by_name_kind can handle
> btf_vmlinux = NULL properly. Consider this is a unlikely case so
> I did not add btf_vmlinux checking here.

Good point. You're right.
I got confused by the similar !btf check in bpf_find_btf_id().
There it looks to be necessary. Here it's indeed redundant.
Sorry about that.
