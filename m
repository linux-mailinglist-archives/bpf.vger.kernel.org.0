Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF7D647AE0
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 01:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiLIAmV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Dec 2022 19:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLIAmV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Dec 2022 19:42:21 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4308AA0F81
        for <bpf@vger.kernel.org>; Thu,  8 Dec 2022 16:42:20 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id c17so1095492edj.13
        for <bpf@vger.kernel.org>; Thu, 08 Dec 2022 16:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L0P58DcP3XPwDsoto+UpzWZK19ua+c8YEUz0QUQhh6A=;
        b=gCGIWoVa10uKZinBJQ9Ppz0DklDvkyHlSNZhV3vlxwNgobKnJhFn/1oj1p7LyUG9UE
         CoH+LPfqTKfq9yi/OOJ3Q6liz9/eIiAy4yr/rB9AhOHS96NC8SYTQ2FcjYPiOcdjW0kV
         W/ITcX9MrmvOnrDa0djIUF5Kg34AmsPr0UVwYcOYNs7MOdEPfpfVwdf+t7YAzfNmh+1P
         DdAMRjWsNQ00YrkK0POUIlv6KacnwDCF7P4Qn0WpYGzjU4nXMGMmRtxFPlIk1wQxyVuZ
         xh/5iMsCHXf9/bYBHm6yNbc5ZCHTB4XXBWjq7tx3yiNhAtawB7P77BVcoLnX4mkxOfw6
         ec2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L0P58DcP3XPwDsoto+UpzWZK19ua+c8YEUz0QUQhh6A=;
        b=KVdu9EUdCsF75x6XVYcYchQY1m+66RgIhHlWAlZXr1k7/W+rn+mv/K157VJs1ssFkO
         aZc4B85M54EuaKsQmKn0AtDcXoFsgVilaLOeJfNTUcBPg1r4MJABEnZHpBiN0ILcSGqx
         j8itoZwQHajE/4FGvZRC/aJsGukBGjd3CxOnwLKe7T5woP3T1wtCyymSsPX9O0tQhngC
         BpefHLSpeGVvIhGuH+yOmtPrbNI4uH1oNKdzE06v5wXOU1xEBSnttHSRHzwIuYfJjy6k
         WIUolVA6h/NMK8h5d69qaEV3ak2IukUj+fVC1qC7kdWXCVUINurm9DpIX7I3KGw3I75D
         bhFA==
X-Gm-Message-State: ANoB5pkKw6xUR5sp0k7qflaPR3XRDiH4GlRZmo/JoJcUp00TROMhgGLg
        gOXm42dCzk/IobzoLUMmyM0zcXcrQEZp67DXT18L/K2a
X-Google-Smtp-Source: AA0mqf5acd7Z0FZwNV3kqSpfR/1Mv5P8dheSCpvkfj6/nRnflcOljI+MieAgvNEL5w/BHVJN06RabXm2wfihjDHBwYw=
X-Received: by 2002:aa7:d80d:0:b0:46b:7645:86a9 with SMTP id
 v13-20020aa7d80d000000b0046b764586a9mr35645807edq.311.1670546538679; Thu, 08
 Dec 2022 16:42:18 -0800 (PST)
MIME-Version: 1.0
References: <20221207205537.860248-1-joannelkoong@gmail.com> <20221208015434.ervz6q5j7bb4jt4a@macbook-pro-6.dhcp.thefacebook.com>
In-Reply-To: <20221208015434.ervz6q5j7bb4jt4a@macbook-pro-6.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 8 Dec 2022 16:42:06 -0800
Message-ID: <CAEf4BzYGUf=yMry5Ezen2PZqvkfS+o1jSF2e1Fpa+pgAmx+OcA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/6] Dynptr convenience helpers
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Joanne Koong <joannelkoong@gmail.com>, bpf@vger.kernel.org,
        andrii@kernel.org, kernel-team@meta.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org
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

On Wed, Dec 7, 2022 at 5:54 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Dec 07, 2022 at 12:55:31PM -0800, Joanne Koong wrote:
> > This patchset is the 3rd in the dynptr series. The 1st can be found here [0]
> > and the 2nd can be found here [1].
> >
> > In this patchset, the following convenience helpers are added for interacting
> > with bpf dynamic pointers:
> >
> >     * bpf_dynptr_data_rdonly
> >     * bpf_dynptr_trim
> >     * bpf_dynptr_advance
> >     * bpf_dynptr_is_null
> >     * bpf_dynptr_is_rdonly
> >     * bpf_dynptr_get_size
> >     * bpf_dynptr_get_offset
> >     * bpf_dynptr_clone
> >     * bpf_dynptr_iterator
>
> This is great, but it really stretches uapi limits.

Stretches in what sense? They are simple and straightforward getters
and trim/advance/clone are fundamental modifiers to be able to work
with a subset of dynptr's overall memory area.

> Please convert the above and those in [1] to kfuncs.
> I know that there can be an argument made for consistency with existing dynptr uapi

yeah, given we have bpf_dynptr_{read,write} and bpf_dynptr_data() as
BPF helpers, it makes sense to have such basic things like is_null and
trim/advance/clone as BPF helpers as well. Both for consistency and
because there is nothing unstable about them. We are not going to
remove dynptr as a concept, it's pretty well defined.

Out of the above list perhaps only move bpf_dynptr_iterator() might be
a candidate for kfunc. Though, personally, it makes sense to me to
keep it as BPF helper without GPL restriction as well, given it is
meant for networking applications in the first place, and you don't
need to be GPL-compatible to write useful networking BPF program, from
what I understand. But all the other ones is something you'd need to
make actual use of dynptr concept in real-world BPF programs.

Can we please have those as BPF helpers, and we can decide to move
slightly fancier bpf_dynptr_iterator() (and future dynptr-related
extras) into kfunc?

> helpers, but we got burned on them once and scrambled to add 'flags' argument.
> kfuncs are unstable and can be adjusted/removed at any time later.

I don't see why we would remove any of the above list ever? They are
generic and fundamental to dynptr as a concept, they can't restrict
what dynptr can do in the future.

Also GPL restriction of kfuncs doesn't apply to these dynptr helpers
either, IMO.

> The verifier now supports dynptr in kfunc verification, so conversion should
> be straightforward.
> Thanks
>
> >
> > Please note that this patchset will be rebased on top of dynptr refactoring/fixes
> > once that is landed upstream.
> >
> > [0] https://lore.kernel.org/bpf/20220523210712.3641569-1-joannelkoong@gmail.com/
> > [1] https://lore.kernel.org/bpf/20221021011510.1890852-1-joannelkoong@gmail.com/
> >
