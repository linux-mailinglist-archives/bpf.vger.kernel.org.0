Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3B62574474
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 07:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbiGNFYP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 01:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiGNFYO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 01:24:14 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A81B863;
        Wed, 13 Jul 2022 22:24:13 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id y4so991598edc.4;
        Wed, 13 Jul 2022 22:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8jR4w3foBIfwhXpMfecmUsdb0NEz+AG5RBtyTM8Ba6I=;
        b=lJw33/RgWTAnQsn6ke/Dq0bb5lWGWWtszw1wVY596NJuORD+vgks4YHDnJCTjpgyNi
         yX69SFQO5O8NVq55A2pR+Lh2bAIu+YOz4HV1fOMLCOc4Ua7MCYFk2zy/cM9FbOMLiLmN
         bpz25dmpG23dbvNeay8kNVQ8UyHWZGE95nTeRN8bA8xXjswy+2+bGU/VvFaf1boiIC2e
         hmRgyoWAyz0LME83euDf2o3z78m2YGQ7//i37TsCUcbP9ymQYT0F1JyEjUmAiwqUXGaa
         43v1IJjp+LgEx7X/5fOhv4k8CIvIv3n47M5bw6BdOqNJXHZ5TnTrhZrXPDhzDbF99ye/
         e61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8jR4w3foBIfwhXpMfecmUsdb0NEz+AG5RBtyTM8Ba6I=;
        b=XejWOOUGju5Epx42K2uQbOYvdbZjli80sJvvnzRSJG7vL1Ea5LY/2wVim0/9uCE8RU
         owkUm8R9h2ls+FsulevFROL9Nz3YEnW3Vio8UnIEU/lD6csZC1he2F9GTHQcq1rb2vfe
         vBaDwvaqAKu8Y4QFUE0RH4I9RYFqyV8fi8P4hsO7hByiJaPXdaDL2i+MC25+yQbHtkzh
         W+6aGuLxJAjH4guDIkTP+eJFAYxcAx3bqul1OgnqI81cHCJ4IrY1XhfmUx8WpUPPvuaL
         iZhluBWQavuLFNIzuuAl8wACAil99JELOCCnBpCmfVBdKJTGzzB5vmdoqghJfBhSniD0
         k/sA==
X-Gm-Message-State: AJIora9rsifm/43k1jl6rg4cLjZPuPaWsHv47+2BtCkI9EVpc1EneEQM
        8125+iLgiIK5aPc2de0+nWlN8jSGsI2AePdiTic=
X-Google-Smtp-Source: AGRyM1vsdHBBKZSXSs85DZOHy8qKdsYjKliFn+rfLCRv8JkWQ9ubT7CSkIdgK2APiAjmzLQxvs5Yq6P8hfwzltTUAPY=
X-Received: by 2002:a05:6402:1c01:b0:43a:f714:bcbe with SMTP id
 ck1-20020a0564021c0100b0043af714bcbemr10167036edb.14.1657776251991; Wed, 13
 Jul 2022 22:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <OSZP286MB1725CEA1C95C5CB8E7CCC53FB8869@OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM>
 <Ys0xcf2yRG4fjkBY@krava> <OSZP286MB1725CD3371AEC94272D9CD48B8899@OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <OSZP286MB1725CD3371AEC94272D9CD48B8899@OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 13 Jul 2022 22:24:00 -0700
Message-ID: <CAEf4Bza2N=1-miBPAeFC1tqVfsw2+muTSzzpUrFMRY2GTuZQFQ@mail.gmail.com>
Subject: Re: [PATCH v2] libbpf: fix the name of a reused map
To:     Anquan Wu <leiqi96@hotmail.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 12, 2022 at 10:59 PM Anquan Wu <leiqi96@hotmail.com> wrote:
>
> On Tue, 2022-07-12 at 10:31 +0200, Jiri Olsa wrote:
> > On Tue, Jul 12, 2022 at 11:15:40AM +0800, Anquan Wu wrote:
> > > BPF map name is limited to BPF_OBJ_NAME_LEN.
> > > A map name is defined as being longer than BPF_OBJ_NAME_LEN,
> > > it will be truncated to BPF_OBJ_NAME_LEN when a userspace program
> > > calls libbpf to create the map. A pinned map also generates a path
> > > in the /sys. If the previous program wanted to reuse the map=EF=BC=8C
> > > it can not get bpf_map by name, because the name of the map is only
> > > partially the same as the name which get from pinned path.
> > >
> > > The syscall information below show that map name
> > > "process_pinned_map"
> > > is truncated to "process_pinned_".
> > >
> > >     bpf(BPF_OBJ_GET, {pathname=3D"/sys/fs/bpf/process_pinned_map",
> > >     bpf_fd=3D0, file_flags=3D0}, 144) =3D -1 ENOENT (No such file or
> > > directory)
> > >
> > >     bpf(BPF_MAP_CREATE, {map_type=3DBPF_MAP_TYPE_HASH, key_size=3D4,
> > >     value_size=3D4,max_entries=3D1024, map_flags=3D0, inner_map_fd=3D=
0,
> > >     map_name=3D"process_pinned_",map_ifindex=3D0, btf_fd=3D3,
> > > btf_key_type_id=3D6,
> > >     btf_value_type_id=3D10,btf_vmlinux_value_type_id=3D0}, 72) =3D 4
> > >
> > > This patch check that if the name of pinned map are the same as the
> > > actual name for the first (BPF_OBJ_NAME_LEN - 1),
> > > bpf map still uses the name which is included in bpf object.
> > >
> > > Signed-off-by: Anquan Wu <leiqi96@hotmail.com>
> > > ---
> > >
> > > v2: compare against zero explicitly
> > >
> > > v1:
> > > https://lore.kernel.org/linux-kernel/OSZP286MB1725A2361FA2EE8432C4D5F=
4B8879@OSZP286MB1725.JPNP286.PROD.OUTLOOK.COM/
> > > ---
> > >  tools/lib/bpf/libbpf.c | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > > index e89cc9c885b3..7b4d3604dfb4 100644
> > > --- a/tools/lib/bpf/libbpf.c
> > > +++ b/tools/lib/bpf/libbpf.c
> > > @@ -4328,6 +4328,7 @@ int bpf_map__reuse_fd(struct bpf_map *map,
> > > int
> > > fd)
> > >  {
> > >         struct bpf_map_info info =3D {};
> > >         __u32 len =3D sizeof(info);
> > > +       __u32 name_len;
> > >         int new_fd, err;
> > >         char *new_name;
> > >
> > > @@ -4337,7 +4338,12 @@ int bpf_map__reuse_fd(struct bpf_map *map,
> > > int
> > > fd)
> > >         if (err)
> > >                 return libbpf_err(err);
> > >
> > > -       new_name =3D strdup(info.name);
> > > +       name_len =3D strlen(info.name);
> > > +       if (name_len =3D=3D BPF_OBJ_NAME_LEN - 1 && strncmp(map->name=
,
> > > info.name, name_len) =3D=3D 0)
> >
> > so what if the map->name is different after 'name_len' ?
> >
> > jirka
> >
>
> If  A map name is defined as being longer than name_len (name_len is
> "BPF_OBJ_NAME_LEN - 1" in this context), a program will fail to get a
> reused bpf_map by bpf_object__find_map_by_name().
>
>    fromhttps://github.com/libbpf/libbpf/blob/master/src/libbpf.c#L9295,
>    pos->name in bpf_object__find_map_by_name() is from  new_name
> in
>    bpf_map_reuse_fd(). It can not find map by the name which is defined
>    in bpf object.
>
> I wrote some code to verify this problem and test the solution
> mentioned above.
> Link: https://github.com/leiqi96/libbpf-fix
>

It would be great to have something like this as a selftest, please
send a follow up patch adding a test under selftests/bpf for map
reuse. See prog_tests/pinning.c, this might belong there.

To also answer Jiri's question. This is not an ideal solution, but it
improves the current situation. And while potentially it's not 100%
correct (because only checks first 15 characters), user normally would
use bpf_map__reuse_fd() on well-known and presumably correct map, so
chance of misuse here are pretty minimal.

So I added

Fixes: 26736eb9a483 ("tools: libbpf: allow map reuse")

and applied to bpf-next, thanks.

> Anquan
>
>
> > > +               new_name =3D strdup(map->name);
> > > +       else
> > > +               new_name =3D strdup(info.name);
> > > +
> > >         if (!new_name)
> > >                 return libbpf_err(-errno);
> > >
> > > --
> > > 2.32.0
> > >
>
>
>
