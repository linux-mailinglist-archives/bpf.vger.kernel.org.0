Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739A96A517B
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 03:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjB1Czo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 21:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjB1Czn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 21:55:43 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E40C1EFE5
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 18:55:41 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id ff4so5975510qvb.2
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 18:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677552940;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=p9lrewpEND0yRGE2S8PNyOOOR6Wlpz7OmzzPHimsopo=;
        b=NI79axnOpIhz+Ax0G4Ahxivfg71FN7HCW8Q/G74N0QaPUTLjpadTlfeLnpgOk74GLM
         umV4PMGPS3ETaqpVQaO/GnpkJcoPAWsJWkMDhvZAgEh6HqC8TltqAzTGxatz9IJTq438
         g1g+w2ULzMF2zkmqTEOrl7BWIswJ8px4aqb1owaE4+Tew203CXNnZIUQiOlWz1gp0PAJ
         cJNkdiqv09gns5mOeNFbXpteEqUoK55COgoaRkUyrkbi4Rq27frzfaKj/PoGGaLT6M9q
         I64Hz5gLent/1LFsC9QhyrVN4CLasAQ1FbJAJii/5KuNYs5lLEYL1GXehzNk5om1z2ou
         zPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677552940;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p9lrewpEND0yRGE2S8PNyOOOR6Wlpz7OmzzPHimsopo=;
        b=Go3+33/acPd8+3FKbIG4XfoiGqR/h00PkB0dblUMMOPTXO0zYKUtME9Gc2Dxc2l948
         h/0ilNYw8gD9SqgOH4ftYXamMmvYeHwqaObN0I6MYtUsoep7Zwnv6X0PxzIRoWZaKtfM
         YXtXePMlChHH3xCKI49osFbm2ggHIkcRdscLo9rcMWX9bzpoUriaE2r5B04zJfzFIRcJ
         yK7w7Vasl2fcZ3mWtJ9wUDzhJameEarp3oU/LtwX+tkWhIVgyuhi9JQjmPPXd19kYwAF
         yQGhn2xE36053yNs/hb6lF0+tdQdpSrZrkBltESRT81sG7hqrCcQqhl4R3jYe0EdVn5D
         LQRQ==
X-Gm-Message-State: AO0yUKULjf/C8Kf3qcwPyEL8yZmzIY3pkhuqQ0ahdHXP+qIkyLP3jMZz
        l/HiZI1t8nMSuprHnf5Q3fCsv60WxSgz8yPYymg=
X-Google-Smtp-Source: AK7set8lwX6HDi3WVv5ajivmz8JPhxd/x6pJfDxPJqGBdSUEyzFeJ5KDR4YHyWBieBe1/vwzQ8PNZXT6P9+kFtOWrxo=
X-Received: by 2002:a05:6214:b82:b0:56f:795:82cd with SMTP id
 fe2-20020a0562140b8200b0056f079582cdmr452699qvb.10.1677552940552; Mon, 27 Feb
 2023 18:55:40 -0800 (PST)
MIME-Version: 1.0
References: <20230227152032.12359-1-laoar.shao@gmail.com> <20230227152032.12359-8-laoar.shao@gmail.com>
 <CAEf4BzZqOUGqhDgN3NzFO5aeSSxGtsVx_xzBkgHhws=MF5xD9w@mail.gmail.com>
In-Reply-To: <CAEf4BzZqOUGqhDgN3NzFO5aeSSxGtsVx_xzBkgHhws=MF5xD9w@mail.gmail.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 28 Feb 2023 10:55:04 +0800
Message-ID: <CALOAHbBFv5Ozk4ymx7J5s=RhzR-H+Xq3ON7o-oFdZv8DC0UeEg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 07/18] bpf: ringbuf memory usage
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com, bpf@vger.kernel.org
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

On Tue, Feb 28, 2023 at 1:22 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Feb 27, 2023 at 7:21 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > A new helper ringbuf_map_mem_usage() is introduced to calculate ringbuf
> > memory usage.
> >
> > The result as follows,
> > - before
> > 15: ringbuf  name count_map  flags 0x0
> >         key 0B  value 0B  max_entries 65536  memlock 0B
> >
> > - after
> > 15: ringbuf  name count_map  flags 0x0
> >         key 0B  value 0B  max_entries 65536  memlock 78424B
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > ---
> >  kernel/bpf/ringbuf.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> > index 80f4b4d..2bbf6e2 100644
> > --- a/kernel/bpf/ringbuf.c
> > +++ b/kernel/bpf/ringbuf.c
> > @@ -336,6 +336,23 @@ static __poll_t ringbuf_map_poll_user(struct bpf_map *map, struct file *filp,
> >         return 0;
> >  }
> >
> > +static u64 ringbuf_map_mem_usage(const struct bpf_map *map)
> > +{
> > +       struct bpf_ringbuf_map *rb_map;
> > +       struct bpf_ringbuf *rb;
> > +       int nr_data_pages;
> > +       int nr_meta_pages;
> > +       u64 usage = sizeof(struct bpf_ringbuf_map);
> > +
> > +       rb_map = container_of(map, struct bpf_ringbuf_map, map);
> > +       rb = rb_map->rb;
>
> nit: rb_map seems unnecessary, I'd just go straight to rb
>
> rb = container_of(map, struct bpf_ringbuf_map, map)->rb;

Thanks for the suggestion. I will do it.

>
> > +       usage += (u64)rb->nr_pages << PAGE_SHIFT;
> > +       nr_meta_pages = RINGBUF_PGOFF + RINGBUF_POS_PAGES;
>
> it would be cleaner to extract this into a constant
> RINGBUF_NR_META_PAGES and use it in ringbuf_map_mem_usage and
> bpf_ringbuf_area_alloc to keep them in sync
>

Will do it.

> But other than that, looks good:
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>

Thanks for the review.


-- 
Regards
Yafang
