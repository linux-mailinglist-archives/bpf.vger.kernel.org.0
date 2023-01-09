Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8C03662C34
	for <lists+bpf@lfdr.de>; Mon,  9 Jan 2023 18:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234538AbjAIRHM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Jan 2023 12:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbjAIRG1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Jan 2023 12:06:27 -0500
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D0142E21;
        Mon,  9 Jan 2023 09:05:44 -0800 (PST)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-4c186ff0506so121373537b3.6;
        Mon, 09 Jan 2023 09:05:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zPVCpbi7IFUjfl+kqKF1GBf38n57/rlv+lygUdA5yNk=;
        b=C6sdNlPKP8IVlDrgemUvnEB8JOAhcPneEchpbYmapkPi9Sv5JE4M2uEc66dXNCr3EC
         LDulgFnacU5lW2hGmxy1S6PdSELbF4cVP26FPGm8ga3xK8B8W6V/rylU+epqi2DTNBna
         X+Hb2DVzevjcALkHNcikM9H0X9XSzl8/1Ip8oPjwVbd/t8513U2xzq6J+Frlo3w+sw+U
         UidYWO7Re0E+Up7/2RTfzPRCFBHL27MCYEV8Dopr5HQlUGd8vHNLWjpHINxX7jUUnrO/
         KyCYwczlLSItwe2KhSb5IHvbEWmsdAvF3BDBIeHQBLdeaWSJS25GeCubnfVaGCIfXRwU
         Bo6w==
X-Gm-Message-State: AFqh2kpzl+AdAZwTtPIJD/jFToNrrRCZFviaWozWSbaiQ4n71m6o31DZ
        HpyA9UILLFVFqs8OuIaNNdc=
X-Google-Smtp-Source: AMrXdXtEHccPbHcS/bkAY0ElT5eoj9Zj3sZoVq6gWorCDGTH/EovylXWCHjhVoFCkYFtPY5dX4/Tvg==
X-Received: by 2002:a05:7500:338a:b0:f0:3bdd:b78f with SMTP id cr10-20020a057500338a00b000f03bddb78fmr446307gab.4.1673283943376;
        Mon, 09 Jan 2023 09:05:43 -0800 (PST)
Received: from maniforge.lan ([2620:10d:c091:480::1:40cc])
        by smtp.gmail.com with ESMTPSA id bq35-20020a05620a46a300b00704c9015e68sm5656045qkb.116.2023.01.09.09.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 09:05:42 -0800 (PST)
Date:   Mon, 9 Jan 2023 11:05:42 -0600
From:   David Vernet <void@manifault.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
        Kernel Team <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: Add __bpf_kfunc tag for marking kernel
 functions as kfuncs
Message-ID: <Y7xJZv6Ncw1JSoJy@maniforge.lan>
References: <20230106195130.1216841-1-void@manifault.com>
 <20230106195130.1216841-2-void@manifault.com>
 <CAADnVQLpK7WXTjF6GS1hcfPXf=8iERJmEeVFfvmG75mJj0DdaA@mail.gmail.com>
 <Y7jUaDD9V556Px3b@maniforge.lan>
 <CAADnVQJJaTXa8Y-aGctrBTjasKzsMDq4nW7Na5X3i8oobpT9NQ@mail.gmail.com>
 <20230109120815.zx5mif4hnee6gyvc@apollo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109120815.zx5mif4hnee6gyvc@apollo>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 09, 2023 at 05:38:15PM +0530, Kumar Kartikeya Dwivedi wrote:
> On Mon, Jan 09, 2023 at 04:47:54AM IST, Alexei Starovoitov wrote:
> > On Fri, Jan 6, 2023 at 6:09 PM David Vernet <void@manifault.com> wrote:
> > >
> > > On Fri, Jan 06, 2023 at 05:04:02PM -0800, Alexei Starovoitov wrote:
> > > > On Fri, Jan 6, 2023 at 11:51 AM David Vernet <void@manifault.com> wrote:
> > > > >
> > > > > kfuncs are functions defined in the kernel, which may be invoked by BPF
> > > > > programs. They may or may not also be used as regular kernel functions,
> > > > > implying that they may be static (in which case the compiler could e.g.
> > > > > inline it away), or it could have external linkage, but potentially be
> > > > > elided in an LTO build if a function is observed to never be used, and
> > > > > is stripped from the final kernel binary.
> > > > >
> > > > > We therefore require some convenience macro that kfunc developers can
> > > > > use just add to their kfuncs, and which will prevent all of the above
> > > > > issues from happening. This is in contrast with what we have today,
> > > > > where some kfunc definitions have "noinline", some have "__used", and
> > > > > others are static and have neither.
> > > > >
> > > > > In addition to providing the obvious correctness benefits, having such a
> > > > > macro / tag also provides the following advantages:
> > > > >
> > > > > - Giving an easy and intuitive thing to query for if people are looking
> > > > >   for kfuncs, as Christoph suggested at the kernel maintainers summit
> > > > >   (https://lwn.net/Articles/908464/). This is currently possible by
> > > > >   grepping for BTF_ID_FLAGS(func, but having something more self
> > > > >   describing would be useful as well.
> > > > >
> > > > > - In the future, the tag can be expanded with other useful things such
> > > > >   as the ability to suppress -Wmissing-prototype for the kfuncs rather
> > > > >   than requiring developers to surround the kfunc with __diags to
> > > > >   suppress the warning (this requires compiler support that as far as I
> > > > >   know currently does not exist).
> > > >
> > > > Have you considered doing bpf_kfunc_start/bpf_kfunc_end ?
> > > > The former would include:
> > > > __diag_push(); __diag_ignore_all(); __used noinline
> > >
> > > Yeah that's certainly an option. The downside is that all functions
> > > within scope of the __diag_push() will be affected, and sometimes we mix
> > > kfuncs with non-kfuncs (including e.g. static helper functions that are
> > > used by the kfuncs themselves). -Wmissing-prototypes isn't a big deal,
> > > but __used and noinline are kind of unfortunate. Not a big deal though,
> > > it'll just result in a few extra __bpf_kfuncs_start() and
> > > __bpf_kfuncs_end() sprinkled throughout to avoid them being included.
> > > The upside is of course that we can get rid of the __diag_push()'es we
> > > currently have to prevent -Wmissing-prototypes.
> >
> > I meant to use bpf_kfunc_start/bpf_kfunc_end around every kfunc.
> > Ideally bpf_kfunc_start would be on the same line as func proto
> > for nice grepping.
> > Maybe it's an overkill.
> > Maybe 3 macroses then?
> > bpf_kfunc_start to hide __diag
> > bpf_kfunc on the proto line
> > bpf_kfunc_end to finish __diag_pop

Ah, I see. Hmm, I guess this is better than what we have now, but is
still a lot of macros and boilerplate which IMO is a sign we're not
going in quite the right direction. I don't really have a better
suggestion at this point, though I do like Kumar's suggestion below.

> There's also the option of doing this:
> 
> #define BPF_KFUNC(proto) proto; __used noinline proto
> 
> BPF_KFUNC(void kfunc(arg1, arg2)) {
> 	...
> }
> 
> No need to disable the warning with diag push/pop, just put a declaration before
> the definition to silence the compiler. The only awkward part is entire function
> prototype becoming a macro argument (unlike the common case void MACRO(...)) but
> it becomes less noisy and easy to grep as well.

If nobody would come after us with pitchforks for this, IMO this is the
most user-friendly option and what I would vote for. It doesn't seem
like this is violating anything in [0]?

[0]: https://www.kernel.org/doc/html/latest/process/coding-style.html#macros-enums-and-rtl
