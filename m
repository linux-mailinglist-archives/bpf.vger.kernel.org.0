Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C267C53338B
	for <lists+bpf@lfdr.de>; Wed, 25 May 2022 00:30:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242263AbiEXWar (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 May 2022 18:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242261AbiEXWap (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 May 2022 18:30:45 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BFFF366BD
        for <bpf@vger.kernel.org>; Tue, 24 May 2022 15:30:43 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id t13so5894715ilm.9
        for <bpf@vger.kernel.org>; Tue, 24 May 2022 15:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HFi8IC8EJtrcyT57yHzVaV4PPwMrAcAeXopGCMLMRLU=;
        b=N8GtbAKc/tU8SFR/WmtIzP/t8kKnLjxs6WPDS1AJSIsOando3WPUjZQG5BAJb1lKRL
         Ics2f7utNqpO0PaHKQawoDfAPLks9PX9vkznlCUu5LWAaoWUbDscsJuS5mJXgk4JOjNt
         podVFCa9V4RttPLwWi4rxG+sBHdbvBdMLd4Miwb7AsFHMqg62lyffrySZEMWnDZoAcPd
         VlmeI0UWDyoBfvcCWmo2NiQmpmH0aGHfM1QbSoS7076kj7nSjJ8mlfcjcfDy3Os3QGQp
         YzTnvhg/6yIWPVkI3GQopizw31YFYYhMfB6xUhm4NFCxP+51kz4zrXov8YfH0sxg06OS
         BIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HFi8IC8EJtrcyT57yHzVaV4PPwMrAcAeXopGCMLMRLU=;
        b=S7DPalihhAS2EWebX4r8wgvZccTRSWsV0IlTPlvdo0Y9hjBrJHsemBt3/jlaLSIW4w
         cyJzCAC7yREDQ8tPBiVVayxfu/PJRr49Bxyeqq4im6lUgyJ1Hhe7r880GBp3QaiTTk+V
         nwwgk8KZ1nDIBJBfAwmpcFkva8krTkf4/IIBvg5W1jpUjgJ98Pwn2U0z10ESPkG6m6qv
         oN90CCHqxKChEFb1KYxUqWRz61N5XvQvhH6NCBrTVp0TQ0F9dUxvBKQSqFH3EZ+xY+iP
         915dAKumQNd1Ni1tMdadrTu3UaVLT7XnFq/MGFAA58GZfBYYv8jirItYMPHFv1sxJexy
         1GgQ==
X-Gm-Message-State: AOAM530GWCMhEK9pEex3XifpcOBeIZ0Uc/phq+4R31P5vmzqbVNo9A0d
        HKrhXPR2sfAX+kpxI3nXth7Hmrzh4vohXkpAI0NYgAP+LoI=
X-Google-Smtp-Source: ABdhPJx3pGr/k55bxEejwtV1zWI3q4luiFXwGygk97mILO0f/r5v8VnCYQavoZ1XXv+kpTWJfr9FLuxkqutFx/KVQuY=
X-Received: by 2002:a05:6e02:1b8f:b0:2d1:b707:3022 with SMTP id
 h15-20020a056e021b8f00b002d1b7073022mr5082415ili.71.1653431442776; Tue, 24
 May 2022 15:30:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220510205923.3206889-1-kuifeng@fb.com> <20220510205923.3206889-2-kuifeng@fb.com>
 <20220520205118.cw6g2ozxzub52otf@kafai-mbp>
In-Reply-To: <20220520205118.cw6g2ozxzub52otf@kafai-mbp>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 24 May 2022 15:30:31 -0700
Message-ID: <CAEf4BzbxjUqFRcF8qzEnqhJ02GWrqS4ukuEC8m7SnXAPGN=p_w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 1/5] bpf, x86: Generate trampolines from bpf_tramp_links
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Kui-Feng Lee <kuifeng@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
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

On Fri, May 20, 2022 at 1:51 PM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Tue, May 10, 2022 at 01:59:19PM -0700, Kui-Feng Lee wrote:
> [ ... ]
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -1013,6 +1013,7 @@ enum bpf_link_type {
> >       BPF_LINK_TYPE_XDP = 6,
> >       BPF_LINK_TYPE_PERF_EVENT = 7,
> >       BPF_LINK_TYPE_KPROBE_MULTI = 8,
> > +     BPF_LINK_TYPE_STRUCT_OPS = 9,
> Sorry for the late question.  I just noticed it while looking at the
> cgroup-lsm set.
>
> Does BPF_LINK_TYPE_STRUCT_OPS need to be in the uapi?
> The current links of the struct_ops progs should not be
> visible to the user space.
>

bpf_link_init() expects link_type to be specified, so we have to
provide some value. We probably could have specified
BPF_LINK_TYPE_UNSPEC, but that seems wrong. But right now those links
are not going to be visible outside as they don't get their ID
allocated (no bpf_link_settle() call), so we just basically have a
reserved enum for future STRUCT_OPS link, if we ever add it
explicitly.

> >
> >       MAX_BPF_LINK_TYPE,
> >  };

[...]
