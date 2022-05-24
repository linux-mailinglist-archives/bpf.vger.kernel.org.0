Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C74105320CE
	for <lists+bpf@lfdr.de>; Tue, 24 May 2022 04:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbiEXCP1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 May 2022 22:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbiEXCP0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 May 2022 22:15:26 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06629CCBB
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 19:15:23 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id y24so2040431wmq.5
        for <bpf@vger.kernel.org>; Mon, 23 May 2022 19:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KJUdzoGEvkdzSxoC2YbNMA59v8a+bgjpBxVChFvyyJA=;
        b=eEoRgOfINUuV2bC0KhEu6YJTz64zs6CMg02nXh0qrnBbpQVNiHrZHTEzmoa6Ok+TUN
         bcM4S/rA3QgQjYKfeFxMZp5AAEzf5XFDmAnnaeo4+98XlwxkA6NUbY9Ssp+CF2efJnxx
         34mcoF5ZP/3PjjpK+TD6JrEsWf9J8zCew/JBMW8iXdAeN3138nagVVDN4H5OSaibyNjg
         qrbzaM9UF3p/ye6WLFzfQaAQY9C2B7g8t26eLawottgX0W+tfE5i4S89Wz9A/A3nTJsz
         ZB0WhPoBJ6jApeAsFYkxuIEXcKSV56AmC/2htdfstKoxf4hq0Kja/yyd0wnRwscu8oru
         0cHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KJUdzoGEvkdzSxoC2YbNMA59v8a+bgjpBxVChFvyyJA=;
        b=hoYyA/bGAmESkw6+i1LOS2Oe6xxZLYBRpdYlCFm5A3AJ8i0XFxD/kp/qbD2v7NikWV
         dus6xkxJnpkg4R1bKr9JO2t9gYOBN21I4M752VF47c6BU8MOosMjio2IA+Zb7ZAyjg5j
         b/qQpHYXeQ3PEaoAbFh9BZkxOIC6s7NFaae0FUGz8UJ9NOoHKm3MIhRn77BPXIdfjboK
         RCpMKrZ8/Sn5zQHtzQT1Ucs2J1+stK3QIG1+UqtNyvpWUQo4LmIZFwKwyGPI7wlkjIP/
         3ZJe1Hg9HEwgIX2dAM6wW/Srce1S29gaFnjIx7ArVmPNC8OKT0BcJNa2NsckWktyPS6i
         Ec7g==
X-Gm-Message-State: AOAM5324Rtuh0iKnJCTGIXFK12IQx6JyuKrNFyzgbwhj048NffOHZLAG
        9KdNiDHG4MJuYJvrQBzdyhkxdBS6C8ebq0EaNemYhA==
X-Google-Smtp-Source: ABdhPJyO+pG6DqNphML7TwohsErsNEXUtSw7USclHs8mHV7FMRIdU/DCObyoqf+nufffGlHVd2GHpoJRkJHP6svNZDM=
X-Received: by 2002:a05:600c:2b89:b0:397:330f:a5e8 with SMTP id
 j9-20020a05600c2b8900b00397330fa5e8mr1607767wmc.150.1653358522037; Mon, 23
 May 2022 19:15:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220518225531.558008-1-sdf@google.com> <20220518225531.558008-8-sdf@google.com>
 <CAEf4BzaYx9EdabuxjLsN4HKTcq+EfwRzpAYdY-D+74YOTpr4Yg@mail.gmail.com>
In-Reply-To: <CAEf4BzaYx9EdabuxjLsN4HKTcq+EfwRzpAYdY-D+74YOTpr4Yg@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Mon, 23 May 2022 19:15:10 -0700
Message-ID: <CAKH8qBs7YE26=ecmn6xdjTC-5-NFMP_-=qkuKtRUDjzeqMTWcg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 07/11] libbpf: implement bpf_prog_query_opts
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 23, 2022 at 4:22 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, May 18, 2022 at 3:55 PM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > Implement bpf_prog_query_opts as a more expendable version of
> > bpf_prog_query. Expose new prog_attach_flags and attach_btf_func_id as
> > well:
> >
> > * prog_attach_flags is a per-program attach_type; relevant only for
> >   lsm cgroup program which might have different attach_flags
> >   per attach_btf_id
> > * attach_btf_func_id is a new field expose for prog_query which
> >   specifies real btf function id for lsm cgroup attachments
> >
>
> just thoughts aloud... Shouldn't bpf_prog_query() also return link_id
> if the attachment was done with LINK_CREATE? And then attach flags
> could actually be fetched through corresponding struct bpf_link_info.
> That is, bpf_prog_query() returns a list of link_ids, and whatever
> link-specific information can be fetched by querying individual links.
> Seems more logical (and useful overall) to extend struct bpf_link_info
> (you can get it more generically from bpftool, by querying fdinfo,
> etc).

Note that I haven't removed non-link-based APIs because they are easy
to support. That might be an argument in favor of dropping them.
Regarding the implementation: I'm not sure there is an easy way, in
the kernel, to find all links associated with a given bpf_prog?

> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  tools/include/uapi/linux/bpf.h |  5 ++++
> >  tools/lib/bpf/bpf.c            | 42 +++++++++++++++++++++++++++-------
> >  tools/lib/bpf/bpf.h            | 15 ++++++++++++
> >  tools/lib/bpf/libbpf.map       |  1 +
> >  4 files changed, 55 insertions(+), 8 deletions(-)
> >
>
> [...]
>
> >         ret = sys_bpf(BPF_PROG_QUERY, &attr, sizeof(attr));
> >
> > -       if (attach_flags)
> > -               *attach_flags = attr.query.attach_flags;
> > -       *prog_cnt = attr.query.prog_cnt;
> > +       if (OPTS_HAS(opts, prog_cnt))
> > +               opts->prog_cnt = attr.query.prog_cnt;
>
> just use OPTS_SET() instead of OPTS_HAS check

Ah, definitely, for some reason I thought that these are "output"
arguments and OPT_SET won't work for them.

> > +       if (OPTS_HAS(opts, attach_flags))
> > +               opts->attach_flags = attr.query.attach_flags;
> >
> >         return libbpf_err_errno(ret);
> >  }
> >
>
> [...]
>
> > diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> > index 6b36f46ab5d8..24f7a5147bf2 100644
> > --- a/tools/lib/bpf/libbpf.map
> > +++ b/tools/lib/bpf/libbpf.map
> > @@ -452,6 +452,7 @@ LIBBPF_0.8.0 {
> >                 bpf_map_delete_elem_flags;
> >                 bpf_object__destroy_subskeleton;
> >                 bpf_object__open_subskeleton;
> > +               bpf_prog_query_opts;
>
> please put it into LIBBPF_1.0.0 section, 0.8 is closed now

Definitely, will pull new changes and put them into proper place.

Thank you for your review!
