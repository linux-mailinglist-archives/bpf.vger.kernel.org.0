Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D07662511
	for <lists+bpf@lfdr.de>; Mon,  9 Jan 2023 13:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233830AbjAIMIq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Jan 2023 07:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237172AbjAIMIU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 9 Jan 2023 07:08:20 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE76C1A3BB;
        Mon,  9 Jan 2023 04:08:18 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id b9-20020a17090a7ac900b00226ef160dcaso7444265pjl.2;
        Mon, 09 Jan 2023 04:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T1OCmfJt14Ff10nKPpJf53wbdUqsYynu6v1x2jHi08k=;
        b=iCvsbgppc3bHIfHeR5zGDeBXdCRV7ICWFTUjVl+6G3YDHSFhhYAo5k6K2KtrY5HZRw
         iwVctd3+tCxFvjsOVSBjRhvowL9XWQsHlKb2sVdePlDkjUvoSEJk2k/nX2mYPqTwViCN
         Y06K7Hf5cs+Ni6O2elxTHbXYIBAzbEXuTQZOIdwV/gI3THWFqv0cTAoTbojl7dGyNZUz
         0aUzFvP7pbjhqhmwg1MkMPdbc5M5wF/OZ/ZPHkcWpc9p2B24LnoslEcihDV22+x+Stej
         zED1/h6oHyeM89tx2OnYKklLAWD64t7/Db1H05WWDqyzTkDbR+LTk9svevIm2/x59PBB
         9sTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1OCmfJt14Ff10nKPpJf53wbdUqsYynu6v1x2jHi08k=;
        b=qO4Z4lfqsFISX5bVK+4jKo8WvKvlClwc66eCPcH55oPuW+RC0za+p1KZs9fJ6ANgAz
         URlgsv1Xgv66ex65HkiSttY7AvFUK2mmFrxl6OecJpGdzBqYttoR/bF2vAtN4lcdX1uS
         +1WcoSm79ykBAGhVzhshuP8cerAV7UMTn2Oym7c8Ag8DQDZhJcn6t1jwsgdPL4EoqB6e
         By3qDCqxefCbgLhU4CIwW7bDGDYaYQeTTa8Obk8j8CzA/yjrZ2/QdW8uR8r5804gqicz
         mP/lXytr6pzwigEI/XPdlyIyROU3tvbIAarBmSI+2J75K6xw3aBUCmw/KaRYB73MG/Qh
         1GJg==
X-Gm-Message-State: AFqh2koVtVxi+f1bq+IwfzC8nmpJzEU5bBrUZsOltbZFcjfZ9hPOY3g1
        yxtij4U43YhLlTobXLTKdLY=
X-Google-Smtp-Source: AMrXdXtcvcLZ+TJdh6MeFn91bTUoMQ4ayc/jZaSGUZO7Ln5U/KhqMVLLChkrBePurJGPqASUiqILqQ==
X-Received: by 2002:a17:902:b20b:b0:186:7a6b:24d9 with SMTP id t11-20020a170902b20b00b001867a6b24d9mr70246071plr.23.1673266098359;
        Mon, 09 Jan 2023 04:08:18 -0800 (PST)
Received: from localhost ([2405:201:6014:dae3:7dbb:8857:7c39:bb2a])
        by smtp.gmail.com with ESMTPSA id p8-20020a170902e74800b00176dc67df44sm5978874plf.132.2023.01.09.04.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 04:08:18 -0800 (PST)
Date:   Mon, 9 Jan 2023 17:38:15 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     David Vernet <void@manifault.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
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
Message-ID: <20230109120815.zx5mif4hnee6gyvc@apollo>
References: <20230106195130.1216841-1-void@manifault.com>
 <20230106195130.1216841-2-void@manifault.com>
 <CAADnVQLpK7WXTjF6GS1hcfPXf=8iERJmEeVFfvmG75mJj0DdaA@mail.gmail.com>
 <Y7jUaDD9V556Px3b@maniforge.lan>
 <CAADnVQJJaTXa8Y-aGctrBTjasKzsMDq4nW7Na5X3i8oobpT9NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQJJaTXa8Y-aGctrBTjasKzsMDq4nW7Na5X3i8oobpT9NQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 09, 2023 at 04:47:54AM IST, Alexei Starovoitov wrote:
> On Fri, Jan 6, 2023 at 6:09 PM David Vernet <void@manifault.com> wrote:
> >
> > On Fri, Jan 06, 2023 at 05:04:02PM -0800, Alexei Starovoitov wrote:
> > > On Fri, Jan 6, 2023 at 11:51 AM David Vernet <void@manifault.com> wrote:
> > > >
> > > > kfuncs are functions defined in the kernel, which may be invoked by BPF
> > > > programs. They may or may not also be used as regular kernel functions,
> > > > implying that they may be static (in which case the compiler could e.g.
> > > > inline it away), or it could have external linkage, but potentially be
> > > > elided in an LTO build if a function is observed to never be used, and
> > > > is stripped from the final kernel binary.
> > > >
> > > > We therefore require some convenience macro that kfunc developers can
> > > > use just add to their kfuncs, and which will prevent all of the above
> > > > issues from happening. This is in contrast with what we have today,
> > > > where some kfunc definitions have "noinline", some have "__used", and
> > > > others are static and have neither.
> > > >
> > > > In addition to providing the obvious correctness benefits, having such a
> > > > macro / tag also provides the following advantages:
> > > >
> > > > - Giving an easy and intuitive thing to query for if people are looking
> > > >   for kfuncs, as Christoph suggested at the kernel maintainers summit
> > > >   (https://lwn.net/Articles/908464/). This is currently possible by
> > > >   grepping for BTF_ID_FLAGS(func, but having something more self
> > > >   describing would be useful as well.
> > > >
> > > > - In the future, the tag can be expanded with other useful things such
> > > >   as the ability to suppress -Wmissing-prototype for the kfuncs rather
> > > >   than requiring developers to surround the kfunc with __diags to
> > > >   suppress the warning (this requires compiler support that as far as I
> > > >   know currently does not exist).
> > >
> > > Have you considered doing bpf_kfunc_start/bpf_kfunc_end ?
> > > The former would include:
> > > __diag_push(); __diag_ignore_all(); __used noinline
> >
> > Yeah that's certainly an option. The downside is that all functions
> > within scope of the __diag_push() will be affected, and sometimes we mix
> > kfuncs with non-kfuncs (including e.g. static helper functions that are
> > used by the kfuncs themselves). -Wmissing-prototypes isn't a big deal,
> > but __used and noinline are kind of unfortunate. Not a big deal though,
> > it'll just result in a few extra __bpf_kfuncs_start() and
> > __bpf_kfuncs_end() sprinkled throughout to avoid them being included.
> > The upside is of course that we can get rid of the __diag_push()'es we
> > currently have to prevent -Wmissing-prototypes.
>
> I meant to use bpf_kfunc_start/bpf_kfunc_end around every kfunc.
> Ideally bpf_kfunc_start would be on the same line as func proto
> for nice grepping.
> Maybe it's an overkill.
> Maybe 3 macroses then?
> bpf_kfunc_start to hide __diag
> bpf_kfunc on the proto line
> bpf_kfunc_end to finish __diag_pop
>

There's also the option of doing this:

#define BPF_KFUNC(proto) proto; __used noinline proto

BPF_KFUNC(void kfunc(arg1, arg2)) {
	...
}

No need to disable the warning with diag push/pop, just put a declaration before
the definition to silence the compiler. The only awkward part is entire function
prototype becoming a macro argument (unlike the common case void MACRO(...)) but
it becomes less noisy and easy to grep as well.
