Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77BF16759B5
	for <lists+bpf@lfdr.de>; Fri, 20 Jan 2023 17:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjATQRt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Jan 2023 11:17:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjATQRs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Jan 2023 11:17:48 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8CCDB7BB;
        Fri, 20 Jan 2023 08:17:31 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id mp20so15178265ejc.7;
        Fri, 20 Jan 2023 08:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oaoP2q5jxU9ldhcqzrgZ3L4zkQjm2DT6Rdi7UTtBpUw=;
        b=mB9YMobTYsLoR7B7uzDVlkcj+h/F3QR4cZKj1nZZ+q+LiDNmKgo0PqvMi/iSmZnHyM
         b7cLUPy7ygYHEEC7Wjqyd52ZpU1z2uy5Oh74FntvPiuQNxjiPjNgeHAQuo2yvLYV2pof
         X0xEAVIkJT8bih7d9p3YV8IXVo6+Jt+JYK5oaQImXzHE4+e9U8JvmbOwRbsKNmGixfVX
         /xmu00ddxvucT82zARCxesRfhbgMPTsEcunznkjAzcmsAS4a2dZmOq/sLID1EzNvJqj0
         klphywc0H34nV3fuMjTLl8hLNuvUDQ2mA9NrPgHeUGXt/u1WFY3+ig0QW4ug4z86z1dj
         pL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oaoP2q5jxU9ldhcqzrgZ3L4zkQjm2DT6Rdi7UTtBpUw=;
        b=hZxtsG4eSqbX0fuh7Qo82J6Hvt+bwEt1scIpRK8Wy80Jtcolyi3Rw2DrqvFqPitVf0
         FaauY5J8wepVyp41OfPUvRHI58hp3Cx50B5MYG++IMHRp2MLqPairdr4KS9DWD/AumzS
         Jz0PdVAF7Xk/1//VddMQReakv+/9OfhIx+oDXHCbHCs+Ju1mtkz1PhkAPupkZCRaWagX
         lhVep4eOsHfeMdkBCUqX4vOO7bc3J1KyMPETRvZsZWpF6TzNE4egv4oPRWzT5TLKN/7p
         Hc1+jhSo61p6ts8XoOz67gbSz4aDcAhTXE9kl3og2NXfyMQYaHn4niiNfoe+bPIWr5xK
         exbA==
X-Gm-Message-State: AFqh2kq7WeHDYKsrTfPwyL4I/4qW7vNsAzNEm0CVK/kPfcUbvaZyx7gh
        WNU767n9mKUiKZqB+Sv6Hiut0L2EbAdGzETSWt0=
X-Google-Smtp-Source: AMrXdXtTAQ9GntGhptU9kFKiyEH91MsJHHX4poRMEpj7p01pbcBBTK6CkRIec1hPJWwlbY/9Xgvla9yWq2GjfxrWXak=
X-Received: by 2002:a17:906:cf9b:b0:872:a7ee:f4c7 with SMTP id
 um27-20020a170906cf9b00b00872a7eef4c7mr1493481ejb.378.1674231449760; Fri, 20
 Jan 2023 08:17:29 -0800 (PST)
MIME-Version: 1.0
References: <20230119235833.2948341-1-void@manifault.com> <20230119235833.2948341-3-void@manifault.com>
 <20230120045815.4b7dc6obdt4uzy6a@apollo> <Y8olRi9SjcyNtam0@maniforge.lan>
 <20230120054027.wcj3jxqkx2s2zsxo@MacBook-Pro-6.local.dhcp.thefacebook.com>
 <CAP01T76aNAn2ish+jwFQuMrCk+11Rb_ZmteGe8RsE7ZMy1t4RA@mail.gmail.com>
 <20230120061441.3gifklagiugmkrtd@MacBook-Pro-6.local.dhcp.thefacebook.com>
 <Y8qrt7pdWCS6Gef8@maniforge.lan> <Y8qyovnr2bkEpldc@maniforge.lan>
In-Reply-To: <Y8qyovnr2bkEpldc@maniforge.lan>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 20 Jan 2023 08:17:18 -0800
Message-ID: <CAADnVQ+sn9imVimk2DnjxtTfmzddSehT2ucAcatK5rhMTd46fw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/8] bpf: Allow trusted args to walk struct when
 checking BTF IDs
To:     David Vernet <void@manifault.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@meta.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>, Tejun Heo <tj@kernel.org>
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

On Fri, Jan 20, 2023 at 7:26 AM David Vernet <void@manifault.com> wrote:
> > >
> > > Yes. Agree. I used unfortunate example in the previous reply with nf_conn___init.
> > > I meant to say:
> > >
> > >  For definition:
> > >  struct nf_conn_init {
> > >     struct nf_conn ct;
> > >  };
> > >  if a kfunc accepts a pointer to nf_conn it should always accept a pointer to nf_conn_init
> > >  for both read and write, because in C that's valid and safe type cast.
> > >
> > > Meainng that C rules apply.
> > > Our triple underscore is special, because it's the "same type".
> > > In the 2nd part of my reply I'm proposing to use the whole suffix "___init" to indicate that.
> > > I think you're arguing that just "___" part is enough to enforce strict match.
> > > Matching foo___flavor with foo should not be allowed.
> > > While passing struct foo_flavor {struct foo;} into a kfunc that accepts 'struct foo'
> > > is safe.
> > > If so, I'm fine with such approach.
> >
> > Alright, I'll spin v2 to treat any type with name___.* as a disallowed
> > alias, and update the documentation to mention it. I was originally
> > going to push back and say that we should just use a single alias like
> > __nocast to keep things simple, but it doesn't feel generalizable
> > enough.
>
> On second thought, unless you guys feel strongly, I'll just check
> ___init. The resulting code is going to be a lot of tricky string
> manipulation / math otherwise. Not _terrible_, but I'd prefer to avoid
> adding it until we have a concrete use-case. And I expect this could be
> implemented much simpler using something like tags, once gcc has support
> for it.

There is bpf_core_is_flavor_sep() that makes it easy to check,
but thinking more about it we probably should stick to strict "___init"
suffix for now, since flavors can appear in progs too and they
are equivalent to corresponding types in the kernel.
The nf_conn___init is kernel only type.
The verifier sees that bpf_xdp_ct_alloc kfunc returns it,
but when we export this kfunc to bpf prog it returns nf_conn.
We probably should pick some other suffix without "___" to distinguish
from flavors. bpf prog should not use nf_conn___init.
