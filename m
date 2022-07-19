Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127A657A91F
	for <lists+bpf@lfdr.de>; Tue, 19 Jul 2022 23:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbiGSVl6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 17:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237616AbiGSVl6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 17:41:58 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776194E87E
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 14:41:57 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id y15so8449156plp.10
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 14:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/g6GXdIPPS5OS1ET6McLrahN2C68TuBM2Z8BK5MQlCA=;
        b=sRFvIC9j/xc0vcM06DM1PV1Zcd1sObIBVepKhGEwrUm/uzcZJCY77/3eVnawnfTcRm
         Jmw6PT64fR8Zt0kqNp6GVeTvRbTUuU1wxRMhPtTwp6/RGsrq8eWXfq37nX2y6wbM+d6/
         p2phauOj5+BoOABocQm2m7HnsTi5VzshZth1WGysarV6YPGPX2UlNwRBOpHZw57qnpWH
         q1NcWfATD3qPHXihnA+X0XkmoBj7juI2HOUc2paQdbTo/T7PWVxE2Mkv8XAhuZPLV4JM
         3Lnc5Us18o77e/zFaRy1gHul/cNzbUDcnf1pxvVLeE5y/W1l6rH3NjVVy0UkUNsluAHa
         6btQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/g6GXdIPPS5OS1ET6McLrahN2C68TuBM2Z8BK5MQlCA=;
        b=0Ms8d77qc6t4u12GXYilljuwiuxHP1u0tiMKdwSlcvrOZeh0njQAjZwc7gKKMXo8Wv
         5YvnYZeix3Q7EkRqkuWnPm+ZLNFXXvXizGn8RBx8kigz0RafB9uOEjlIXN0+nf34U1gE
         08CVb1SkEddTnqWuRUsk9RwU5r4GqPrtNnE4G+DLMwcfQEt244cJIYAYCN4ClyG64aWW
         TI10vusosaz39khrSzVK6e25mDGFYn3n4DVAHcSd6h/ydkO2LgBye0DJRzhoIkpKrO3N
         MBAZzr6Pffbd0TGgv0Z4vN64oP7zg9lE8/h1FJL6wv592aDlzBHxSbRiJ/qgoWpwwxm4
         b4zQ==
X-Gm-Message-State: AJIora8EK2SVS3/CFgPgj3HTrDzwsvqMdktGfZadeX2tTCjQ8fj9N1Hv
        zA4WbW2HxkC9OxPS8HgvNrbxJBQnAopYtWW3hCxU/g==
X-Google-Smtp-Source: AGRyM1vrDWVlGf0soAHJPHaSjYXjrxXK4+pLz93KgOwxldGGqySx3d75LBo9tORsXubdipK/KhNC+4UTo6wXHh1zCes=
X-Received: by 2002:a17:902:db11:b0:16c:3e90:12e5 with SMTP id
 m17-20020a170902db1100b0016c3e9012e5mr34925383plx.73.1658266916788; Tue, 19
 Jul 2022 14:41:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220718190748.2988882-1-sdf@google.com> <CAADnVQLxh_pt8bgoo=_CS3voab7HuQautZGfHQMM=TmQmVr2pQ@mail.gmail.com>
 <CAKH8qBv9q=eXBq9XSKEN2Nce5Wf0MJEX_zbTi12p4r3WCjmBEw@mail.gmail.com>
In-Reply-To: <CAKH8qBv9q=eXBq9XSKEN2Nce5Wf0MJEX_zbTi12p4r3WCjmBEw@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 19 Jul 2022 14:41:45 -0700
Message-ID: <CAKH8qBv66=Fdea0u-vbu-Q=P9pySo+tjy5YpPPcNo8dF0qN8bw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] RFC: libbpf: resolve rodata lookups
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 19, 2022 at 1:33 PM Stanislav Fomichev <sdf@google.com> wrote:
>
> On Tue, Jul 19, 2022 at 1:21 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Jul 18, 2022 at 12:07 PM Stanislav Fomichev <sdf@google.com> wrote:
> > >
> > > Motivation:
> > >
> > > Our bpf programs have a bunch of options which are set at the loading
> > > time. After loading, they don't change. We currently use array map
> > > to store them and bpf program does the following:
> > >
> > > val = bpf_map_lookup_elem(&config_map, &key);
> > > if (likely(val && *val)) {
> > >   // do some optional feature
> > > }
> > >
> > > Since the configuration is static and we have a lot of those features,
> > > I feel like we're wasting precious cycles doing dynamic lookups
> > > (and stalling on memory loads).
> > >
> > > I was assuming that converting those to some fake kconfig options
> > > would solve it, but it still seems like kconfig is stored in the
> > > global map and kconfig entries are resolved dynamically.
> > >
> > > Proposal:
> > >
> > > Resolve kconfig options statically upon loading. Basically rewrite
> > > ld+ldx to two nops and 'mov val, x'.
> > >
> > > I'm also trying to rewrite conditional jump when the condition is
> > > !imm. This seems to be catching all the cases in my program, but
> > > it's probably too hacky.
> > >
> > > I've attached very raw RFC patch to demonstrate the idea. Anything
> > > I'm missing? Any potential problems with this approach?
> >
> > Have you considered using global variables for that?
> > With skeleton the user space has a natural way to set
> > all of these knobs after doing skel_open and before skel_load.
> > Then the verifier sees them as readonly vars and
> > automatically converts LDX into fixed constants and if the code
> > looks like if (my_config_var) then the verifier will remove
> > all the dead code too.
>
> Hm, that's a good alternative, let me try it out. Thanks!

Turns out we already freeze kconfig map in libbpf:
if (map_type == LIBBPF_MAP_RODATA || map_type == LIBBPF_MAP_KCONFIG) {
        err = bpf_map_freeze(map->fd);

And I've verified that I do hit bpf_map_direct_read in the verifier.

But the code still stays the same (bpftool dump xlated):
  72: (18) r1 = map[id:24][0]+20
  74: (61) r1 = *(u32 *)(r1 +0)
  75: (bf) r2 = r9
  76: (b7) r0 = 0
  77: (15) if r1 == 0x0 goto pc+9

I guess there is nothing for sanitize_dead_code to do because my
conditional is "if (likely(some_condition)) { do something }" and the
branch instruction itself is '.seen' by the verifier.

And, most annoyingly for me, 72 and 74 lookups still stay :-(

I can try to unwrap/resolve these on the verifier side instead of libbpf maybe..
