Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6016E52F682
	for <lists+bpf@lfdr.de>; Sat, 21 May 2022 02:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354175AbiEUADj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 May 2022 20:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354167AbiEUADi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 May 2022 20:03:38 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94CE1A811E
        for <bpf@vger.kernel.org>; Fri, 20 May 2022 17:03:37 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id f2so13411584wrc.0
        for <bpf@vger.kernel.org>; Fri, 20 May 2022 17:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ao66QeFbzosK7IX954n0lcqOo4BUr8kGzcQrW92Wd4M=;
        b=fRy7I7LFIlmaulsFg99KHwNg/D5q8O0y9bt5e+iqOlsnOFvjbg42KwjU4Ipir8rsgt
         5isGjdWT9K3QQSpRv39248sxV99V26sbXrBNgrj+N7GNGxyfLFgeYvnLDDfyjM6f2e+r
         1GKRFk5eb6r+8e4yEGVNSbggZPzTzsV5/+EjLsxktYrCYQ0fMDuuOy8872Slv56qPBxi
         nM/ykxpKA08x8zH9z0QQUuIZXfyRVdxhQ7901yaiY22iN4o12RlvP9hCXYo20EGXShBa
         miQY60KtiyhUxAOYI/YYrp0fpoAUnZBOnpL131U9bADXkPhlc+K88jdxvKx0jLBUhVmL
         5Z5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ao66QeFbzosK7IX954n0lcqOo4BUr8kGzcQrW92Wd4M=;
        b=frhLsKM7Btgw754Eiy6zIGVu93MbogVRcA9NQmMimiTZgSgE4Kkx9i/vnTGnx8jaQo
         2MLw5TKFwCFNHpzCmOqxchW1x4CIbBAIwxGCuIJAZ1o+FyNIk1nOJzCCV+Q9sHCg8Nfz
         rcFmr2YxNSoLfjZj2AW3pHhCAKx2IAdZMpxsQA/HPopkF7JQVPrd+XD85G6yOXap7H1h
         YUgY1QzaPac2OfKSqUsH7LzjKxyAhrCcb3n2Sb5Ammine/muXdKxalJ2hui2xJnRJwne
         a5Heo+KuYDwPP9EGThva2vXPzuXJ+/FhJfGu8Kbvu0CBcphYenu3XhP/YxJ9b/Q0M3uu
         QYcQ==
X-Gm-Message-State: AOAM533wiWu98CYz0vVQzujOyKykw84l8s57oaIuvopqBJl5y1gEMMiQ
        gASA3FaPdGux5nGM/HEJXFRZSTs1HqmLDOXTrt7pyQ==
X-Google-Smtp-Source: ABdhPJy5bAvS4+nFOnV2YmgK6Rdf8aRqh3QnQzHZLlvdC2dMqfYA8ZeIzkUpjL6t5a4FcFRz91r0B3jyAcoa5idEocc=
X-Received: by 2002:adf:f803:0:b0:20d:3a1:3c31 with SMTP id
 s3-20020adff803000000b0020d03a13c31mr10257981wrp.565.1653091416208; Fri, 20
 May 2022 17:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220518225531.558008-1-sdf@google.com> <20220518225531.558008-2-sdf@google.com>
 <787b0ed8-00f7-3a94-85a8-0cc301b11470@fb.com>
In-Reply-To: <787b0ed8-00f7-3a94-85a8-0cc301b11470@fb.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 20 May 2022 17:03:25 -0700
Message-ID: <CAKH8qBsntN_T1DFsCzg6ZRaae-AwTxgvUW5diY-cwZ4qGNcWCw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 01/11] bpf: add bpf_func_t and trampoline helpers
To:     Yonghong Song <yhs@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 19, 2022 at 5:45 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 5/18/22 3:55 PM, Stanislav Fomichev wrote:
> > I'll be adding lsm cgroup specific helpers that grab
> > trampoline mutex.
> >
> > No functional changes.
> >
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >   include/linux/bpf.h     | 11 ++++----
> >   kernel/bpf/trampoline.c | 62 ++++++++++++++++++++++-------------------
> >   2 files changed, 38 insertions(+), 35 deletions(-)
> >
> [...]
> > +
> > +int bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr)
> > +{
> > +     int err;
> > +
> > +     mutex_lock(&tr->mutex);
> > +     err = __bpf_trampoline_link_prog(link, tr);
> >       mutex_unlock(&tr->mutex);
> >       return err;
> >   }
> >
> >   /* bpf_trampoline_unlink_prog() should never fail. */
>
> The comment here can be removed.

Will do, thank you!


> > -int bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr)
> > +static int __bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr)
> >   {
> >       enum bpf_tramp_prog_type kind;
> >       int err;
> >
> >       kind = bpf_attach_type_to_tramp(link->link.prog);
> > -     mutex_lock(&tr->mutex);
> >       if (kind == BPF_TRAMP_REPLACE) {
> >               WARN_ON_ONCE(!tr->extension_prog);
> >               err = bpf_arch_text_poke(tr->func.addr, BPF_MOD_JUMP,
> >                                        tr->extension_prog->bpf_func, NULL);
> >               tr->extension_prog = NULL;
> > -             goto out;
> > +             return err;
> >       }
> >       hlist_del_init(&link->tramp_hlist);
> >       tr->progs_cnt[kind]--;
> > -     err = bpf_trampoline_update(tr);
> > -out:
> > +     return bpf_trampoline_update(tr);
> > +}
> > +
> > +/* bpf_trampoline_unlink_prog() should never fail. */
> > +int bpf_trampoline_unlink_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr)
> > +{
> > +     int err;
> > +
> > +     mutex_lock(&tr->mutex);
> > +     err = __bpf_trampoline_unlink_prog(link, tr);
> >       mutex_unlock(&tr->mutex);
> >       return err;
> >   }
