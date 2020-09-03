Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0724D25BA09
	for <lists+bpf@lfdr.de>; Thu,  3 Sep 2020 07:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbgICFSi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Sep 2020 01:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgICFSi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Sep 2020 01:18:38 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB09C061244
        for <bpf@vger.kernel.org>; Wed,  2 Sep 2020 22:18:38 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id r7so1169865ybl.6
        for <bpf@vger.kernel.org>; Wed, 02 Sep 2020 22:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c4wN4lD/jep7mqpuf3QbJO9XIKEOQ1+KPa51IloKKKU=;
        b=YkSa10kBxqkzesxcKRKcV9zSYl8hWTwiXE/Vrs3RqAMp8h7z2DooH2o+Tyae9dx9lD
         j2qBRZNVTPQEEUYNjtPaFclTQRxD3LmP/qFSqEGtj6uOO2K4Jaws3+8tZjXFCogOBTev
         L7i/wzxfr+rMSQ8VSo95Q32qvgnIiHYCsB30dmOy4r4PyXg03hagk0PKxDbq9AHd7T/B
         Jmn23rAzoplvtLlgji51E5pLR1yjkp/LsPzJd9pBoUb8kMQ53UT28RRFIcrOzOO8T6Pz
         ++AEwhVHS9QPR5+mHxOuN6g0Cy8KCH+d5gj6WCd97ZTRFB5YgKZyRJnLekSinF9lPnKE
         vxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c4wN4lD/jep7mqpuf3QbJO9XIKEOQ1+KPa51IloKKKU=;
        b=LI/kHdzWYEIDlGfcvMheVrByAs1vKVY/N/RRIZo1eQMG3XRCXHB+4/Oqcta8t0VSM0
         Iq5T8mAiASXtBuIHpBnKuxis2aEOvJ1YI1L3UAZJ2cLAy4b9V13n1n85pSbTRxF0TGBM
         peDlGD7sTQufZbe8T/z7JpZI6K/LoIKZzE/3BpvSVuhMXh0PevagNhXibUZhyukpd0rA
         a4ZR/qJbV3tgqgx3eaiS970qLH4UdiH472Hi5TX1hRCekNCnxZQ9RwuWnRkrVe2yHCiR
         7843+DGw0CL6J3ldJ3+L6LDSL0r1pHreUsO5iKe3b5Z86EkLOqqq8sXeKtZfKkecqt3n
         IcRQ==
X-Gm-Message-State: AOAM530HvuRvv49I5b8oYiIHmDGwtkNP+sZ2RoekoNgbbFYLoa2t2ofG
        Aznsv2Igk2yxkmYpXb2tQGn/AkXpPFgXs9g5bs+0u/7B0XE=
X-Google-Smtp-Source: ABdhPJzaLBi1DxMXF/L3wkn43iQb1NXmJNiA0e4k6WUb4UTlefzKNskgfDB9xNa3pfQIb3gbYE0UFJ/cVrgr9E5ZGVs=
X-Received: by 2002:a25:ef43:: with SMTP id w3mr343172ybm.230.1599110317246;
 Wed, 02 Sep 2020 22:18:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597915265.git.zhuyifei@google.com> <9138c60f036c68f02c41dae0605ef587a8347f4c.1597915265.git.zhuyifei@google.com>
 <CAEf4BzaGFP=Ob5MOcQgBjFOdY8aP1gvNV68wTAzA-V3kR5BKYg@mail.gmail.com> <20200828165931.GA48607@google.com>
In-Reply-To: <20200828165931.GA48607@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 2 Sep 2020 22:18:26 -0700
Message-ID: <CAEf4BzZQbUgXhryXHG+_xFWmJaPMHL_ew-2EouPGYWaLTqTNkA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/5] bpftool: support dumping metadata
To:     Stanislav Fomichev <sdf@google.com>
Cc:     YiFei Zhu <zhuyifei1999@gmail.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Mahesh Bandewar <maheshb@google.com>,
        YiFei Zhu <zhuyifei@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 28, 2020 at 9:59 AM <sdf@google.com> wrote:
>
> On 08/25, Andrii Nakryiko wrote:
> > On Thu, Aug 20, 2020 at 2:44 AM YiFei Zhu <zhuyifei1999@gmail.com> wrote:
> > >
> > > From: YiFei Zhu <zhuyifei@google.com>
> > >
> > > Added a flag "--metadata" to `bpftool prog list` to dump the metadata
> > > contents. For some formatting some BTF code is put directly in the
> > > metadata dumping. Sanity checks on the map and the kind of the btf_type
> > > to make sure we are actually dumping what we are expecting.
> > >
> > > A helper jsonw_reset is added to json writer so we can reuse the same
> > > json writer without having extraneous commas.
> > >
> > > Sample output:
> > >
> > >   $ bpftool prog --metadata
> > >   6: cgroup_skb  name prog  tag bcf7977d3b93787c  gpl
> > >   [...]
> > >         btf_id 4
> > >         metadata:
> > >                 metadata_a = "foo"
> > >                 metadata_b = 1
> > >
> > >   $ bpftool prog --metadata --json --pretty
> > >   [{
> > >           "id": 6,
> > >   [...]
> > >           "btf_id": 4,
> > >           "metadata": {
> > >               "metadata_a": "foo",
> > >               "metadata_b": 1
> > >           }
> > >       }
> > >   ]
> > >
> > > Signed-off-by: YiFei Zhu <zhuyifei@google.com>
> > > ---
> > >  tools/bpf/bpftool/json_writer.c |   6 ++
> > >  tools/bpf/bpftool/json_writer.h |   3 +
> > >  tools/bpf/bpftool/main.c        |  10 +++
> > >  tools/bpf/bpftool/main.h        |   1 +
> > >  tools/bpf/bpftool/prog.c        | 135 ++++++++++++++++++++++++++++++++
> > >  5 files changed, 155 insertions(+)
> > >
>
> > [...]
>
> > > +       for (i = 0; i < prog_info.nr_map_ids; i++) {
> > > +               map_fd = bpf_map_get_fd_by_id(map_ids[i]);
> > > +               if (map_fd < 0)
> > > +                       return;
> > > +
> > > +               err = bpf_obj_get_info_by_fd(map_fd, &map_info,
> > &map_info_len);
> > > +               if (err)
> > > +                       goto out_close;
> > > +
> > > +               if (map_info.type != BPF_MAP_TYPE_ARRAY)
> > > +                       goto next_map;
> > > +               if (map_info.key_size != sizeof(int))
> > > +                       goto next_map;
> > > +               if (map_info.max_entries != 1)
> > > +                       goto next_map;
> > > +               if (!map_info.btf_value_type_id)
> > > +                       goto next_map;
> > > +               if (!strstr(map_info.name, ".metadata"))
>
> > This substring check sucks. Let's make libbpf call this map strictly
> > ".metadata". Current convention of "some part of object name" + "." +
> > {rodata,data,bss} is extremely confusing. In practice it's something
> > incomprehensible and "unguessable" like "test_pr.rodata". I think it
> > makes sense to call them just ".data", ".rodata", ".bss", and
> > ".metadata". But that might break existing apps that do lookups based
> > on map name (and might break skeleton as it is today, not sure). But
> > let's at least start with ".metadata", as it's a new map and we can
> > get it right from the start.
> Isn't it bad from the consistency point of view? Even if it's bad,
> at least it's consistent :-/

Just because we made a mistake once, doesn't mean we need to keep
making it. ".metadata" is 9 characters already, which leaves 6
characters for object name prefix, that's not a lot of useful
information anyway. As I said, we should probably fix it for other
global data maps as well, but we will have to do it gradually. For
.metadata we can do a nice and clean ".metadata" immediately, no need
to jump through migration and deprecation hoops.

Also, how is "test_vml.bss" consistent with "test_v.metadata"?
