Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC2F647B71
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 02:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiLIBaS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Dec 2022 20:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLIBaR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Dec 2022 20:30:17 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEFC801CF
        for <bpf@vger.kernel.org>; Thu,  8 Dec 2022 17:30:16 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id b2so8139754eja.7
        for <bpf@vger.kernel.org>; Thu, 08 Dec 2022 17:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PpgPIRMYXA/NbqFHAY433Lo2QAAdNNBkILQ8YxXvklI=;
        b=aYZ3LYCNTmJmctkoLRjt28HM0hkikHjp75dreX8udX5HI5IK+d5MclEPtCx5aDQDSD
         LWJVFqpg/JC+Eax3bMz6WU+kqB1m4LkQComVE14sXKMy11X6lM4atRp0GB9cdCP4MP66
         +ZIYyV/u42vDDVwh3v4RH4mU72NG8/yzhK7xwgIXrfm+508MVvNG7RpjVYkFJGCVg3hO
         CIHTnN5noSnQxvhPNlu7GtecASDjsIj9P+8fGkt8RJXe8SLOoRF1ZAPhYjJ7iIlMjqqD
         sg+VHkLkM588cBMnwIFnKdFPh3uX1DgemjgibEqsglHEV4+6lOVa//oOeE/s0Xd1VwxS
         HsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PpgPIRMYXA/NbqFHAY433Lo2QAAdNNBkILQ8YxXvklI=;
        b=4yTP7DQLyA1KDgowOgfVDuNjE7qka+n1tNVmZyBumQBaVddV/8C1rBAmkC3qGmutzW
         BggCyZcG+VPbTet83dvPVFihepEK7TaKqjWZQTduR+F8ar2czAhPpKCmcewTEHxv7hhi
         6Md5HnAPdrsnQNYXZbYK6mjpXZ3EqwaqumbjgPPVg2HGhN26F8FeWVil5n/SZIJRawbJ
         jG4UmRsBcFaIs1e0RX0hHiA4IQ81sQzcadbJjZ6p5HxvLJdN9OOi/e22QPZSdVcAFot2
         RLcORQUJMTQYg8otYfuuzDJXn9F3sceTR4lyOn7aMn4aD+Gp75jIym4z0FvewoVv1OYW
         RS8g==
X-Gm-Message-State: ANoB5pkuwWqssbp7Ow7C8dazXRSAJEmAU14vGH2BaQ2UvUP9ei/9ftLQ
        qO6opd96cXxkEUtGGbGC4fATTAO5SnU7v2j6CZY=
X-Google-Smtp-Source: AA0mqf6t4LBmzhFMupE4KwYPavdVXJINhJjsnO551lplgGRGvFeOht5gQqNW6/8E+xPL8RFcwMGGrQhEW1jBzWO7GNc=
X-Received: by 2002:a17:906:fc5:b0:7c0:8b4c:e30f with SMTP id
 c5-20020a1709060fc500b007c08b4ce30fmr34726196ejk.502.1670549414653; Thu, 08
 Dec 2022 17:30:14 -0800 (PST)
MIME-Version: 1.0
References: <20221207205537.860248-1-joannelkoong@gmail.com>
 <20221208015434.ervz6q5j7bb4jt4a@macbook-pro-6.dhcp.thefacebook.com> <CAEf4BzYGUf=yMry5Ezen2PZqvkfS+o1jSF2e1Fpa+pgAmx+OcA@mail.gmail.com>
In-Reply-To: <CAEf4BzYGUf=yMry5Ezen2PZqvkfS+o1jSF2e1Fpa+pgAmx+OcA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 8 Dec 2022 17:30:03 -0800
Message-ID: <CAADnVQKgTCwzLHRXRzTDGAkVOv4fTKX_r9v=OavUc1JOWtqOew@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/6] Dynptr convenience helpers
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Joanne Koong <joannelkoong@gmail.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, kernel-team@meta.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>
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

On Thu, Dec 8, 2022 at 4:42 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Dec 7, 2022 at 5:54 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Wed, Dec 07, 2022 at 12:55:31PM -0800, Joanne Koong wrote:
> > > This patchset is the 3rd in the dynptr series. The 1st can be found here [0]
> > > and the 2nd can be found here [1].
> > >
> > > In this patchset, the following convenience helpers are added for interacting
> > > with bpf dynamic pointers:
> > >
> > >     * bpf_dynptr_data_rdonly
> > >     * bpf_dynptr_trim
> > >     * bpf_dynptr_advance
> > >     * bpf_dynptr_is_null
> > >     * bpf_dynptr_is_rdonly
> > >     * bpf_dynptr_get_size
> > >     * bpf_dynptr_get_offset
> > >     * bpf_dynptr_clone
> > >     * bpf_dynptr_iterator
> >
> > This is great, but it really stretches uapi limits.
>
> Stretches in what sense? They are simple and straightforward getters
> and trim/advance/clone are fundamental modifiers to be able to work
> with a subset of dynptr's overall memory area.
>
> > Please convert the above and those in [1] to kfuncs.
> > I know that there can be an argument made for consistency with existing dynptr uapi
>
> yeah, given we have bpf_dynptr_{read,write} and bpf_dynptr_data() as
> BPF helpers, it makes sense to have such basic things like is_null and
> trim/advance/clone as BPF helpers as well. Both for consistency and
> because there is nothing unstable about them. We are not going to
> remove dynptr as a concept, it's pretty well defined.
>
> Out of the above list perhaps only move bpf_dynptr_iterator() might be
> a candidate for kfunc. Though, personally, it makes sense to me to
> keep it as BPF helper without GPL restriction as well, given it is
> meant for networking applications in the first place, and you don't
> need to be GPL-compatible to write useful networking BPF program, from
> what I understand. But all the other ones is something you'd need to
> make actual use of dynptr concept in real-world BPF programs.
>
> Can we please have those as BPF helpers, and we can decide to move
> slightly fancier bpf_dynptr_iterator() (and future dynptr-related
> extras) into kfunc?

Sorry, uapi concerns are more important here.
non-gpl and consistency don't even come close.
We've been doing everything new as kfuncs and dynptr is not special.

> > helpers, but we got burned on them once and scrambled to add 'flags' argument.
> > kfuncs are unstable and can be adjusted/removed at any time later.
>
> I don't see why we would remove any of the above list ever? They are
> generic and fundamental to dynptr as a concept, they can't restrict
> what dynptr can do in the future.

It's not about removing them, but about changing them.

Just for example the whole discussion of whether frags should
be handled transparently and how write is handled didn't inspire
confidence that there is a strong consensus on semantics
of these new dynptr accessors.

Scrambling to add flags to dynptr helpers was another red flag.

All signs are pointing out that we're not ready do fix dynptr api.
It will evolve and has to evolve without uapi pain.

kfuncs only. For everything. Please.
