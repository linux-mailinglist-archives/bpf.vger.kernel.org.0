Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BC34F5503
	for <lists+bpf@lfdr.de>; Wed,  6 Apr 2022 07:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236028AbiDFFYe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Apr 2022 01:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1847748AbiDFCUQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Apr 2022 22:20:16 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048065640D
        for <bpf@vger.kernel.org>; Tue,  5 Apr 2022 16:38:07 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id e22so1044053ioe.11
        for <bpf@vger.kernel.org>; Tue, 05 Apr 2022 16:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J0VDn3TWssya7/c3pZXBannNTPpSZhPFSmYNNSwztHg=;
        b=gW2KyGQ7bElr7Z+/g04+BuCCfjvnAckL9UlGRRoTvpc/FdkgRtoImlld80jmUUwAvd
         RgQZ4cAIGuNXqeJJ1RURN3A+FVVLQE9+Fa04P26Hp32ny0AA5hvKZ16l7ghXk0+9dlzf
         yWnwDvAmxB8Rbedw26a1cffnbkjOpGZ0ydk9vQAF7z8rftTEHFx6nVzhtsUW2LIyo4+l
         gonodjpHwhDc7VS6dj/Ue/WpM3vuUfyBf1HSVNaiU8m1RejTKjI9WHxmu0GCRX+KU2VR
         9CZ8LAg3ihtvr457N7UmrCZfB6LdEqWqRFsfuIfieX/WbFS8Vmnzsj1wKQ0Hc17RqXOK
         hpmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J0VDn3TWssya7/c3pZXBannNTPpSZhPFSmYNNSwztHg=;
        b=DALnV0vhrRXWKV9i6OSkZum5t/ax3PvMqKxUD1H230a1rvvIVaIUIi3rRNOdWDlgpk
         avBohR4j9GC0y/4NKdEOJxUvwJBmcd8NP9v9W+cgp7ALJfrM4Wufa8umklyLdXqaxuLQ
         WwsDIMFzWNoDSzqK05FaExEGyprndzOa0uOwKsKPRK1NUHd5UpAz3qMX2eULlPA8O+mn
         cWhxDDnghHsoctLHoOcQQi4mb4ib2zvlz2k5y1s9EiG5xoWQSeKDFAOPAJovEQPLNrLP
         2xfuMKP5Azf8hh3o1zbAYLy1G85E0TrKP2JuJusDoP4Q4ZnbJUlbpa006Q30D/C57pjn
         FOiA==
X-Gm-Message-State: AOAM532lgNQfMDxDiSjSuCw3xrBhrGsccv36cHAtHxqAlRAM3VMdkk3r
        QGxRfisCUyQlYostc0MRo9Aea2isl+cbVYPNtvg=
X-Google-Smtp-Source: ABdhPJxwaAzlWgM7RAglEYzRKlaIkTejW+hfWu8dHqRuWKj1V4R7ZMqPYN9zZOyXp4hNLpO9wOwF8qEYrfZNxCTnYEc=
X-Received: by 2002:a05:6638:3395:b0:323:8a00:7151 with SMTP id
 h21-20020a056638339500b003238a007151mr3155713jav.93.1649201886427; Tue, 05
 Apr 2022 16:38:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220404083816.1560501-1-nborisov@suse.com>
In-Reply-To: <20220404083816.1560501-1-nborisov@suse.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 5 Apr 2022 16:37:55 -0700
Message-ID: <CAEf4BzZrz42Ffe37n+NbiVsvzHX995=1P_tTun-bHzL8kXOpeg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Add btf__field_exists
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
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

On Mon, Apr 4, 2022 at 1:38 AM Nikolay Borisov <nborisov@suse.com> wrote:
>
> Hello,
>
> Here are 2 patches with which I want to probe what's the sentiments towards 2
> changes:
>
> 1. Introduction of libbpf APIs similar to the bpf counterparts: bpf_core_field_exists,
> bpf_core_type_exists and bpf_core_enum_value_exists. Of those I've implemented only
> the first one and the reasoning behind this is in the patch itself. However, the
> TLDR is that there can be cases where based on the kernel version we have to make a
> decision in userspace what set of kprobes to use. There are currently no convenince
> api's to do this so one has to essentially open code the checks that can be provided
> by the aforementioned APIs.
>

The problem is that what you've implemented is not a user-space
equivalent of bpf_core_xxx() macros. CO-RE has extra logic around
___<flavor> suffixes, extra type checks, etc, etc. Helper you are
adding does a very straightforward strings check, which isn't hard to
implement and it doesn't have to be a set in stone API. So I'm a bit
hesitant to add this.

But I can share what I did in similar situations where I had to do
some CO-RE check both on BPF side and know its result in user-space. I
built a separate very simple BPF skeleton and all it did was perform
various feature checks (including those that require CO-RE) and then
returned the result through global variables. You can then trigger
such BPF feature-checking program either through bpf_prog_test_run or
through whatever other means (I actually did a simple sys_enter
program in my case). See [0] for BPF program side and [1] for
user-space activation/consumption of that.

The benefit of this approach is that there is no way BPF and
user-space sides can get "out of sync" in terms of their feature
checking. With skeleton it's also extremely simple to do all this.

  [0] https://github.com/anakryiko/retsnoop/blob/master/src/calib_feat.bpf.c
  [1] https://github.com/anakryiko/retsnoop/blob/master/src/mass_attacher.c#L483-L529


> 2. The kernel has for_each_member macro but the libbpf library doesn't provide it,
> this results in having to open code members enumeration in various places such as
> in find_member_by_name/find_struct_ops_kern_types/bpf_map__init_kern_struct_ops/
> parse_btf_map_def  and in the newly introduced btf__field_exists. So how about
> bringing the convenience macro to libbpf?

see my comment, not sure it's worth it

>
> The reason why this series is RFC is if people agree with the proposed changed
> I'd be happy to extend it to add more *exists* APIs and do the conversion to
> using the  for_each_member macro.
>
> Nikolay Borisov (2):
>   libbpf: Add userspace version of for_each_member macro
>   libbpf: Add btf__field_exists
>
>  tools/lib/bpf/btf.c      | 28 ++++++++++++++++++++++++++++
>  tools/lib/bpf/btf.h      |  8 ++++++++
>  tools/lib/bpf/libbpf.map |  1 +
>  3 files changed, 37 insertions(+)
>
> --
> 2.25.1
>
