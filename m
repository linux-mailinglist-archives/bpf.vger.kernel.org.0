Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A7555372E
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 18:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353662AbiFUQCe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jun 2022 12:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353490AbiFUQCD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jun 2022 12:02:03 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCCC2C139
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 09:01:06 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id fu3so28467452ejc.7
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 09:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xdyyuERQea68cN3wmYDeRMyvTyvfFqxsUiJ9KSCVVWI=;
        b=Z6T5xthgBuDa4VShjwVsx5IrBG8jWmEWLEtNM/57nrNR3aNFm3ibUeYvzKXQ53ugmD
         HXZ9Aw88X/fQKhD9v6GRvXCnR/StMh3SUG2FO++PX6tJ7b8HsfLTWDIjv+y8UFqLJ9x6
         nm8vqsZzvVD5spG1mTsTdhqx1LIvKTVscKY0hNJ6hJ8g98+GRBKrrEwQL09Sb9otC/Pb
         SVa8ewzCzXtrzmESylGCXoMXBjX1oaoJz3p6YJxbadO4oCdftJIgv3VsvpaCs/YquOHw
         ybSQKQEAR0PIzDqFp0KGU0K5GbLtt/vALPedu7AUw2D5X/DAujPK2WP7SPKIbqc2EdOq
         GErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xdyyuERQea68cN3wmYDeRMyvTyvfFqxsUiJ9KSCVVWI=;
        b=XMoemIh6bIvHqVUyaQL090Z0evmzVrBX++XxyYuU/eCmZME+IV3kaYy6EagNu3PIdQ
         KfCwN9/TrHEiY7aBK4ucZq+q5lpMBiQFw0BGsjHUwywmX3aEZnkpFNz4FfKilRnscdoH
         33dsKHUwU3NioSUXWGqZM/iQb2rCU3xf86tLHE9pnTdkhdhm+HNqzCWXX285/Z2VLpjE
         qKwckR1InZADZdhki4E+MWynqT0f4js4ZPhSQ8UI1zoOWL2NQDv+4+pUM1BDvOFFPUKH
         xGubaHuhNAyto7Mbn66qQN4vHHilZTV+e2CTBn53YEWwxtqCEm5x2gnYEpraPF8Koro9
         d63A==
X-Gm-Message-State: AJIora8VxbtQGCOrAt28+gYcPFRLfM8f+5CKaNugACJ+uXx+rkDt39VL
        Z+5dTbsTB5HvKar3/WRfMLQLVkInqa1LxsuOVTVhGKT/7FA=
X-Google-Smtp-Source: AGRyM1v0+XJ1uCC/QrY4Azw/uHxyTdx7XrrAe3NGcooJQcx1M+GG6dehRZw5xf0mboPLT8dfBVcK+sS+1zziusBB7jM=
X-Received: by 2002:a17:907:971e:b0:71d:955c:b296 with SMTP id
 jg30-20020a170907971e00b0071d955cb296mr18310158ejc.633.1655827264755; Tue, 21
 Jun 2022 09:01:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220621012811.2683313-1-kpsingh@kernel.org> <20220621012811.2683313-4-kpsingh@kernel.org>
 <20220621123646.wxdx4lzk3cgnknjr@apollo.legion>
In-Reply-To: <20220621123646.wxdx4lzk3cgnknjr@apollo.legion>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 21 Jun 2022 09:00:53 -0700
Message-ID: <CAADnVQJ9+gpU-92Umj9Cu0TznFHNHxn67WbQAo+62iWNA+2cCA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/5] bpf: Allow kfuncs to be used in LSM programs
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
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

On Tue, Jun 21, 2022 at 5:36 AM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Tue, Jun 21, 2022 at 06:58:09AM IST, KP Singh wrote:
> > In preparation for the addition of bpf_getxattr kfunc.
> >
> > Signed-off-by: KP Singh <kpsingh@kernel.org>
> > ---
> >  kernel/bpf/btf.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > index 02d7951591ae..541cf4635aa1 100644
> > --- a/kernel/bpf/btf.c
> > +++ b/kernel/bpf/btf.c
> > @@ -7264,6 +7264,7 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
> >       case BPF_PROG_TYPE_STRUCT_OPS:
> >               return BTF_KFUNC_HOOK_STRUCT_OPS;
> >       case BPF_PROG_TYPE_TRACING:
> > +     case BPF_PROG_TYPE_LSM:
> >               return BTF_KFUNC_HOOK_TRACING;
>
> Should we define another BTF_KFUNC_HOOK_LSM instead? Otherwise when you register
> for tracing or lsm progs, you write to the same hook instead, so kfunc enabled
> for tracing progs also gets enabled for lsm, I guess that is not what user
> intends when registering kfunc set.

It's probably ok for this case.
We might combine BTF_KFUNC_HOOK* into fewer hooks and
scope them by attach_btf_id.
Everything is 'tracing' like at the end.
Upcoming hid-bpf is 'tracing'. lsm is 'tracing'.
but we may need to reduce the scope of kfuncs
based on attach point or based on argument type.
tc vs xdp don't need to be separate sets.
Their types (skb vs xdp_md) are different, so only
right kfuncs can be used, but bpf_ct_release() is needed
in both tc and xdp.
So we could combine tc and xdp into 'btf_kfunc_hook_networking'
without compromising the safety.
acquire vs release ideally would be indicated with btf_tag,
but gcc still doesn't have support for btf_tag and we cannot
require the kernel to be built with clang.
acquire, release, sleepable, ret_null should be flags on a kfunc
instead of a set. It would be easier to manage and less boilerplate
code. Not clear how to do this cleanly.
export_symbol approach is a bit heavy and requires name being unique
across kernel and modules.
func name mangling or typedef-ing comes to mind. not so clean either.
