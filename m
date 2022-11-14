Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ECFE6288D3
	for <lists+bpf@lfdr.de>; Mon, 14 Nov 2022 20:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235941AbiKNTCv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Nov 2022 14:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235617AbiKNTCu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Nov 2022 14:02:50 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D173926E
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 11:02:49 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id k5so11172932pjo.5
        for <bpf@vger.kernel.org>; Mon, 14 Nov 2022 11:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JesK8RfIzaG2Wdh3Ptq3bdpkcsYA3Bjzkbx/5Cl4fM8=;
        b=LqnUmnLIAp4w+yt7pfzyQhDnVUW0kbFA0rQSZghxBbj+DHdHyvutDy5NE0VTs+q7vD
         7eauEX5AyQfZ2M255fw4fvvgtNpVkjUXALsRS1xjTuVyRWqJMDfcJkLUwszL1NVhPxH8
         nLmhDzyis3nOtB7piYs09IF0XJCwt+sWNVosHTV0Ef97Mb5qnFLh3TSh9KFBbduLd1oC
         zPpgv4T/1W8Wee4ZFo7qZoSB5JiwNhhndSwByEVuPb610Q+EQ8wm3gGJ7Hz7y4GEM8Zs
         C41fo4zchELSeQSfVFzMKPlUVMlyQDA50GeuXJXvqtBcT/0mYLw7H/LmpvPB1te2cbVW
         ZBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JesK8RfIzaG2Wdh3Ptq3bdpkcsYA3Bjzkbx/5Cl4fM8=;
        b=8JfazQRcDN0Fgt31CuLz27CFXKzLmbtGkHtz4J9gOtyDF6/GRVT0xhfjf0+G8l0BEm
         nBdhvxQbGCgO+IkG7Nc9Tb89p2ZeoOdq+PSLl/EPePia2CMV3UQwY7IjY6mjmFjGNkQl
         NJB7mtNWkVkvtBZOAgqmnB10X6rc3aG1hTF1Eg+dmqNgOhqA0cYn5jrxd5wJm686IPa2
         NpxrbTfarEV6de6D82PuSl//KXmkJAvFGqzUwMS+ClIDPZzLilAWKeywjZYF4wXdnKNr
         IGCJLqr4gkBN96yCcOHMNj3A6vA2715/02OZTXTL8Y8XWIJZCXS731UdHOMK9RW+2wL7
         cB5w==
X-Gm-Message-State: ANoB5plU8QEIKHyAmmfHVTd36MoXktXnFtvDjgR86iEN/x1it7lIWR3x
        w29Dr5ehS/16Uu6kIvkU0oWgEuGqmjnwUzYLbxcnmD2OmvI=
X-Google-Smtp-Source: AA0mqf78SFrsIvXUysfJzQxvpRJy4ZMG4eaeCr4/CjibH19Z5pBhrXMBkrjS2gAnK5WW/qubEWVle/oo7NSvljFB4rc=
X-Received: by 2002:a17:902:b695:b0:17d:95af:fb59 with SMTP id
 c21-20020a170902b69500b0017d95affb59mr485617pls.154.1668452569237; Mon, 14
 Nov 2022 11:02:49 -0800 (PST)
MIME-Version: 1.0
References: <CAO658oUrud+RaV4dAWQ+JYkDttgW00xyDmsoa8-vCeknQNjVtg@mail.gmail.com>
 <91787040-3612-e847-b512-a38a3dae199e@meta.com>
In-Reply-To: <91787040-3612-e847-b512-a38a3dae199e@meta.com>
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Mon, 14 Nov 2022 14:02:36 -0500
Message-ID: <CAO658oXVoDsiNt3NtC0qDECOCA8XnLh+aOb4kR=-HhFvddo1aA@mail.gmail.com>
Subject: Re: Best way to share maps between multiple files/objects?
To:     Dave Marchevsky <davemarchevsky@meta.com>
Cc:     bpf <bpf@vger.kernel.org>
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

On Fri, Nov 11, 2022 at 2:34 AM Dave Marchevsky <davemarchevsky@meta.com> wrote:
>
> On 11/10/22 7:32 PM, Grant Seltzer Richman wrote:
> > Hi folks,
> >
> > I want to organize my BPF programs so that I can load them
> > individually. I want this so that if loading one fails (because of
> > lack of kernel support for BPF features), I can load a fall-back
> > replacement program. To do so, I've organized the BPF programs into
> > their own source code files and compiled them individually. Each BPF
> > program references what is supposed to be the same ringbuffer. Using
> > libbpf I open them and attempt to load each in order.
> >
> > My question is, how am I supposed to share maps such as ringbuffers
> > between them? If I have identical map definitions in each, they have
> > their own file descriptors. Is the best way to call
> > `bpf_map__reuse_fd()` on each handle of the maps in each BPF object?
>
> Sounds like each of the source files have the exact same map definitions,
> including name? And each is compiled into a separate BPF object?
>
> If so, adding __uint(pinning, LIBBPF_PIN_BY_NAME); to
> each definition will probably be the easiest way to get the map reuse
> behavior you want. The first bpf object in the set that successfully loads
> will pin its maps by name in /sys/fs/bpf and future objects which load same
> maps will reuse them instead of creating new maps.

This worked beautifully, thank you for the suggestion!

>
> selftests/bpf/progs/test_pinning.c demonstrates this behavior.
>
> I'm curious, though: is this a single BPF program with various fallbacks,
> with goal of running only one? Or a set of N programs working together using
> same maps, each of which might have fallbacks, with goal of running some
> version of all N programs?

The latter. We have N programs all sharing M maps. Each program might
have fallbacks but some version should be loaded.

>
> > I'd also take advice on how to better achieve my overall goal of being
> > able to load programs individually!
>
> You can group each program together with its fallbacks in the same
> source file / BPF object by disabling autoload for all variants of the
> program via SEC("?foobar") syntax. Then in userspace you could turn
> autoload on for the first version you'd like to try after opening
> the BPF object, try loading the object, try with 2nd variant if that
> fails, etc.

Thank you for this suggestion as well, but it doesn't seem to work as
I get: `load can't be attempted twice`. Is this a potential bug?
`obj->loaded` is set to true regardless of success in
`bpf_object_load()`

>
> selftests/bpf/progs/dynptr_fail.c + verify_fail function in
> selftests/bpf/prog_tests/dynptr.c is an example of this pattern.
>
> > Thanks so much for your help,
> > Grant Seltzer
