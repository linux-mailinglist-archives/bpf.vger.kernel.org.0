Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E006A7370
	for <lists+bpf@lfdr.de>; Wed,  1 Mar 2023 19:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjCASaK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Mar 2023 13:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjCASaJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Mar 2023 13:30:09 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D0FC3403A
        for <bpf@vger.kernel.org>; Wed,  1 Mar 2023 10:30:08 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id f13so57682771edz.6
        for <bpf@vger.kernel.org>; Wed, 01 Mar 2023 10:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/gkoiObz3zDA1XgmJ+JATcDdPVPFNAscjSZi9L46qVI=;
        b=fykzmNupB1fEAhL9IxIh/R8c6086kLMzjc2f/5Vow9bXHGq5pPyjYClC+M0VcFxHr4
         SSRc2S6v+gc93B8/xtMVLSLmugOKtjA18w2bZA0CXTC7VYTozSr/TlmxxPiwHKOWC3W2
         pnHkUZNA/Wz0lHOElrsl9UtYlmVUDUrJxxKrTrT60aT/ADMj+BZJTNsFumxuBTRhCQwr
         IT21PAPJYwwEweW//nFkMT4pSTS3RlAWFVKCWy+35Dh2HgwpKTsubojhAQJjHVPjFMOx
         udRPqQibopNpaA+fJS1mdbT/50AI76/kebNrwfJUJBKhr5fwe18YqgdshpPBlB/c/6Nb
         PAPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/gkoiObz3zDA1XgmJ+JATcDdPVPFNAscjSZi9L46qVI=;
        b=00kVwM5OW+gOazX5KmQN+Zomd7oEMHqKK5lpFQdwwM3pYNW/uYvk9cGc96pBBGDovd
         2ES6uc59ZczcOkfNQa9RnDaWywctIRLehTw6YndkFVuT8nLuwqJvlaiijpvHutMWPlFS
         8wujU/JMzAi48SgjKcPmKSjBtfC6C3gOR6A0mZO78RC8c48eDqa9+GwxLOtnWhPo+O5R
         WZWCyI1KuUpw6ppTCtIGcmkLJtvR9ZC/Fs9nMpI8w+S+vYU0q99ARr6vOCziszESDpj2
         kagiI1LEg5NgwblnS0yZYbgQGXHb1uTjUE/+gOEl0AHKUSX7m8x2tQ1sN1GBflE/7P4F
         hjDA==
X-Gm-Message-State: AO0yUKVvw+eCxRxQFA9tp6MgFNTCYK+AjVOmlgZYY5h3LLXeU3m+1hMm
        VSNQoWuc5FeTepP1rUj/t8e+nWF2DphKOEE4G3c=
X-Google-Smtp-Source: AK7set+X+X+vX0MvgLP6logdL5wCQVTw27WSG1xxPk7w3yLHPuLrzK13jONPij5BguMU67nHEDli2ceeHU32HRPTcaI=
X-Received: by 2002:a17:906:d789:b0:8ae:9f1e:a1c5 with SMTP id
 pj9-20020a170906d78900b008ae9f1ea1c5mr3562280ejb.3.1677695406573; Wed, 01 Mar
 2023 10:30:06 -0800 (PST)
MIME-Version: 1.0
References: <20230225154010.391965-1-memxor@gmail.com> <20230225154010.391965-3-memxor@gmail.com>
 <86a26e3d-08fc-cee5-68f0-8000b490a9f0@linux.dev> <CACYkzJ7XBa1B03GRW1f61dmaadh9Z1sR8t9Qvf47s5jVgtwmXQ@mail.gmail.com>
In-Reply-To: <CACYkzJ7XBa1B03GRW1f61dmaadh9Z1sR8t9Qvf47s5jVgtwmXQ@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 1 Mar 2023 10:29:55 -0800
Message-ID: <CAADnVQJ6qE9+2cmU9HknYEGpPd7zA2o+qg4pqFPfuNrhOmfQrQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/3] bpf: Support kptrs in local storage maps
To:     KP Singh <kpsingh@kernel.org>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        David Vernet <void@manifault.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 27, 2023 at 7:04=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
>
> > >
> > >       if (use_trace_rcu)
> > > -             call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_rcu);
> > > +             call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_tasks_=
trace_rcu);
> > >       else
> > > -             kfree_rcu(selem, rcu);
> > > +             call_rcu(&selem->rcu, bpf_selem_free_rcu);
> >
> > Instead of adding 'bool can_use_smap' to 'struct bpf_local_storage_elem=
', can it
> > be a different rcu call back when smap->map.record is not NULL and only=
 that new
> > rcu call back can use smap?
> > I have a use on this 8-byte hole when using bpf_mem_alloc in bpf_local_=
storage.

I've decided it to apply it as-is to speeds things up.
Kumar, please follow up addressing Kumar's and KP's suggestions.
