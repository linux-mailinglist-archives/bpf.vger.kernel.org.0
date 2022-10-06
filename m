Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB6A5F5FC2
	for <lists+bpf@lfdr.de>; Thu,  6 Oct 2022 05:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiJFDss (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 5 Oct 2022 23:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiJFDsr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Oct 2022 23:48:47 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAAF564CA
        for <bpf@vger.kernel.org>; Wed,  5 Oct 2022 20:48:46 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id ot12so1843788ejb.1
        for <bpf@vger.kernel.org>; Wed, 05 Oct 2022 20:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5i9/X8GS55/V0X58/oyllgzvar5d3xiEDGRIlRr1DLM=;
        b=kFBu0O2DAk+Kqx2rqNGal01mbwC0NjJD8+ruEfSCAL9ZnypNFylDBSrW4JioP1WL6e
         wzqYFgeQFdjVQMAkXUVdaAdko1sPOK2EDXvHrIz5k9zbPP7UM5s9bM+wCQ5pkfwnP6X4
         iiCAGqhY6NC2R1TceMZ/c14maBlm3Z2ay16WP6L1Wn59aCXyJX8GNVKRUlErcFnlIJoZ
         OgJK0JvcAS0p9ItNC3oy6PElzPWDyU/nhkQShJLNzvPsI22xpSlDzn94Tedg8r+C4QL+
         gxrxoJuq4CMXXck6rk1i4AJcZHhQhmV786vcDJdU5TnjqLFaf0K3VUQl81S0Jy29DDnh
         MvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5i9/X8GS55/V0X58/oyllgzvar5d3xiEDGRIlRr1DLM=;
        b=IbOFcCenGZKRuY2T9wAxQtMlDmOIZ/FszBIYG16X+N1bBuJAzIKgul9O1YhW6MnfwC
         5Pp8CYqcugT/VEXHhRmTYLs5DUUHXVaRvfufuys7TTY46ZrHu57OdhURi8CcmGzeyYdk
         MAvbGm0UM+4b5CrWdhyj7DEDXcKHValpJRtz1UvOTq/45jiY+hXqS5PSWkM2+QWww/tB
         71y1TrsxtRpC1DeLtaG6U+tC9J601q7TlwNqLwtJIf7QSDoy1MNyiFFv/e3LJsJUVqYL
         jzWGTg0By8hNlHjJZEQLn794/qhA7kyKvBGwrBQZYzzcDGZ0ricZWOj5xvTgMea0SJut
         mJcg==
X-Gm-Message-State: ACrzQf2QNbbEXpskpKfnxHv7KND4DMkJJ+7LAKUVsqPfNSMsO7vYEyX9
        gNsW765s0oRqv7JcfcBOxwsL2AXedT/wntVLVOc=
X-Google-Smtp-Source: AMsMyM4mzS5Uj9kh94zYWKX/GuuTslQ7RwVtRzTTktzFytk1yaRgIDsklulkciMKREIWdxxCb9NeDfOYXB0+yMHvciU=
X-Received: by 2002:a17:907:3fa9:b0:782:ed33:df8d with SMTP id
 hr41-20020a1709073fa900b00782ed33df8dmr2251442ejc.745.1665028125323; Wed, 05
 Oct 2022 20:48:45 -0700 (PDT)
MIME-Version: 1.0
References: <20221005161450.1064469-1-andrii@kernel.org> <20221005161450.1064469-3-andrii@kernel.org>
 <CAADnVQLm_8otwwcTEv=8-fE_220i_o0AhokNwxkSnUg7z8a1rA@mail.gmail.com>
In-Reply-To: <CAADnVQLm_8otwwcTEv=8-fE_220i_o0AhokNwxkSnUg7z8a1rA@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 5 Oct 2022 20:48:33 -0700
Message-ID: <CAEf4BzZcxQyL0DjJin0hh8iiV6nu3+ckRfb70FGq9V37p=1DaA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: add BPF object fixup step to veristat
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
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

On Wed, Oct 5, 2022 at 5:03 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Oct 5, 2022 at 9:15 AM Andrii Nakryiko <andrii@kernel.org> wrote:
> >
> > Add a step to attempt to "fix up" BPF object file to make it possible to
> > successfully load it. E.g., set non-zero size for BPF maps that expect
> > max_entries set, but BPF object file itself doesn't have declarative
> > max_entries values specified.
> >
> > Another issue was with automatic map pinning. Pinning has no effect on
> > BPF verification process itself but can interfere when validating
> > multiple related programs and object files, so veristat disabled all the
> > pinning explicitly.
> >
> > In the future more such fix up heuristics could be added to accommodate
> > common patterns encountered in practice.
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
> >  tools/testing/selftests/bpf/veristat.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
> > index 38f678122a7d..973cbf6af323 100644
> > --- a/tools/testing/selftests/bpf/veristat.c
> > +++ b/tools/testing/selftests/bpf/veristat.c
> > @@ -509,6 +509,28 @@ static int parse_verif_log(char * const buf, size_t buf_sz, struct verif_stats *
> >         return 0;
> >  }
> >
> > +static void fixup_obj(struct bpf_object *obj)
> > +{
> > +       struct bpf_map *map;
> > +
> > +       bpf_object__for_each_map(map, obj) {
> > +               /* disable pinning */
> > +               bpf_map__set_pin_path(map, NULL);
> > +
> > +               /* fix up map size, if necessary */
> > +               switch (bpf_map__type(map)) {
> > +               case BPF_MAP_TYPE_SK_STORAGE:
> > +               case BPF_MAP_TYPE_TASK_STORAGE:
> > +               case BPF_MAP_TYPE_INODE_STORAGE:
> > +               case BPF_MAP_TYPE_CGROUP_STORAGE:
> > +                       break;
> > +               default:
> > +                       if (bpf_map__max_entries(map) == 0)
> > +                               bpf_map__set_max_entries(map, 1);
>
> Should we drop if (==0) check and set max_entries=1 unconditionally
> to save memory and reduce map creation time ?
> since max_entries doesn't affect verifiability.

This might break the map-in-map case, I think? I see
xsk_map_meta_equal() takes into account max_entries, and
array_map_meta_equal() also check max_entries equality unless
BPF_F_INNER_MAP is specified. So in some cases valid apps won't load
correctly.

Given veristat loads one object at a time, hopefully memory usage
won't be a big issue in practice. It seems safer and simpler to keep
it as is.

>
> Applied the set for now.
