Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96486A517C
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 03:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjB1Czo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 21:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjB1Czn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 21:55:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B786B1EBD7
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 18:55:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7315BB80DE4
        for <bpf@vger.kernel.org>; Tue, 28 Feb 2023 02:55:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04763C433A1
        for <bpf@vger.kernel.org>; Tue, 28 Feb 2023 02:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677552940;
        bh=VBPG5iiLB6TmIOuFFxfUgwRC5mFm+MsCffw8ayRQero=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PEXkIYNQ1MF+T5eHE3MUkxEJOjOa/2JUOBso6lpyQtkuoMViUAjJIXiDsUMPxhjtm
         bD45UHDlxd+IeTIxlPPGUA9tGBJx2zwNI1x21aPEI4BvIGC+9X8UVrOEhAXwo9jb7E
         ZgHhogJUxHGwfJOK3t4Ykr/1LUvUyWY471ivBJWl8BVIsDhR4wybJ0q4gx51F3x64J
         kZr5rztQ+4mFSOnAoUO3FV/qtNXY5g/ir5cXo7jddUF1GYmC1bK2Cs3KuBx3n0Nnmu
         7GDowSj/fHQdt1EhkJnE4KLRM8yoSMm74pzLNM3pieqPiDX7O7yetzGh3KBSSY1Te/
         JiQ0diF01Sadg==
Received: by mail-ed1-f50.google.com with SMTP id d30so34206695eda.4
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 18:55:39 -0800 (PST)
X-Gm-Message-State: AO0yUKW+ey1uqvsT5zgu8tgWkbZMc3jcy2ia1AjNdK427tunZQmsEVHu
        50vdBqW6zA9jZds//wgE63KUrZYGN16h1I+gjggLuw==
X-Google-Smtp-Source: AK7set9+s6RBs8R8IAa8yyX0HzzsKEa2VqfgH8veAjwahsiwqEzlCgeDlUVWUQKC43sxpKjtQKIpmuGpgFj/u2sQX6I=
X-Received: by 2002:a17:906:4bc4:b0:8b0:fbd5:2145 with SMTP id
 x4-20020a1709064bc400b008b0fbd52145mr441213ejv.15.1677552938135; Mon, 27 Feb
 2023 18:55:38 -0800 (PST)
MIME-Version: 1.0
References: <Y/P1yxAuV6Wj3A0K@google.com> <e9f7c86ff50b556e08362ebc0b6ce6729a2db7e7.camel@gmail.com>
 <Y/czygarUnMnDF9m@google.com> <17833347f8cec0e44d856aeafbb1bbe203526237.camel@gmail.com>
 <Y/hLsgSO3B+2g9iF@google.com> <8f8f9d43d2f3f6d19c477c28d05527250cc6213d.camel@gmail.com>
 <Y/p0ryf5PcKIs7uj@google.com> <c4cda35711804ec26ebaeedc07d10d5d51901495.camel@gmail.com>
 <693dffd9571073a47820653fd2de863010491454.camel@gmail.com>
 <CAEf4BzYaiD27y=Y85xhrj+VOvJY_5q1oVtg-4vYmFZFEpmW+nQ@mail.gmail.com>
 <CACYkzJ7tgbJqwUVxfGd4UKDUcOQjK8zsbEKUUjV79=xHQn1fFg@mail.gmail.com>
 <CAEf4BzZauF7V3pY1hgWgnJRN1F6eSkbTOTG3kM0c85uAX-vOfQ@mail.gmail.com>
 <9ea9b52fca1300265ce5639a2da809813edb774f.camel@gmail.com>
 <CAEf4BzYO+Rgcfbr+QzJ-8BdQg-x-mC6c4bOhA+Z4cvu_1ObX+g@mail.gmail.com> <b245e95e9028d4eb14febda06f9fb25139e5e122.camel@gmail.com>
In-Reply-To: <b245e95e9028d4eb14febda06f9fb25139e5e122.camel@gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Tue, 28 Feb 2023 03:55:27 +0100
X-Gmail-Original-Message-ID: <CACYkzJ4yR0n+kP9-G025uP2fwhyBh9DF2feA+H5mw+Re6GdkFQ@mail.gmail.com>
Message-ID: <CACYkzJ4yR0n+kP9-G025uP2fwhyBh9DF2feA+H5mw+Re6GdkFQ@mail.gmail.com>
Subject: Re: bpf: Question about odd BPF verifier behaviour
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Matt Bobrowski <mattbobrowski@google.com>, bpf@vger.kernel.org,
        andrii@kernel.org, acme@redhat.com, dwarves@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 27, 2023 at 9:48=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Mon, 2023-02-27 at 11:31 -0800, Andrii Nakryiko wrote:
> [...]
> > > > I'd start with understanding what BTF and DWARF differences are
> > > > causing the issue before trying to come up with the fix. For that w=
e
> > > > don't even need config or repro steps, it should be enough to share
> > > > vmlinux with BTF and DWARF, and start from there.
> > > >
> > >
> > > Yes, I suspect that there is some kind of unanticipated
> > > anomaly for some DWARF encoding for some kind of objects,
> > > just need to find the root for the diverging type hierarchies.
> > >
> > > > But I'm sure Eduard is on top of this already (especially that he c=
an
> > > > repro the issue now).
> > >
> > > I'm working on it, nothing to report yet, but I'm working on it.
> > >
> >
> > Thanks, please keep us posted!
>
> It is interesting how everything is interconnected. The patch for
> pahole below happens to help. I prepared it last week while working on
> new DWARF encoding scheme for btf_type_tag.
>
> I still need to track down which "unspecified_type" entries caused the
> issue in this particular case. Will post an update tomorrow.
>
> Meanwhile, Matt, KP, could you please verify the patch on your side?
> It is for the "next" branch of pahole.
>
> ---
>
> From 09fac63ca08e25aea499f827283b07cc87a7daab Mon Sep 17 00:00:00 2001
> From: Eduard Zingerman <eddyz87@gmail.com>
> Date: Tue, 21 Feb 2023 19:23:00 +0200
> Subject: [PATCH] dwarf_loader: Fix for BTF id drift caused by adding
>  unspecified types
>
> Recent changes to handle unspecified types (see [1]) cause BTF ID drift.
>
> Specifically, the intent of commits [2], [3] and [4] is to render
> references to unspecified types as void type.
> However, as a consequence:
> - in `die__process_unit()` call to `cu__add_tag()` allocates `small_id`
>   for unspecified type tags and adds these tags to `cu->types_table`;
> - `btf_encoder__encode_tag()` skips generation of BTF entries for
>   `DW_TAG_unspecified_type` tags.
>
> Such logic causes ID drift if unspecified type is not the last type
> processed for compilation unit. `small_id` of each type following
> unspecified type in the `cu->types_table` would have its BTF id off by -1=
.
> Thus renders references established on recode phase invalid.
>
> This commit reverts `unspecified_type` id/tag tracking, instead:
> - `small_id` for unspecified type tags is set to 0, thus reference to
>   unspecified type tag would render BTF id of a `void` on recode phase;
> - unspecified type tags are not added to `cu->types_table`.
>
> [1] https://lore.kernel.org/all/Y0R7uu3s%2FimnvPzM@kernel.org/
> [2] bcc648a10cbc ("btf_encoder: Encode DW_TAG_unspecified_type returning =
routines as void")
> [3] cffe5e1f75e1 ("core: Record if a CU has a DW_TAG_unspecified_type")
> [4] 75e0fe28bb02 ("core: Add DW_TAG_unspecified_type to tag__is_tag_type(=
) set")
>
> Fixes: bcc648a10cbc ("btf_encoder: Encode DW_TAG_unspecified_type returni=
ng routines as void")
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Tested-by: KP Singh <kpsingh@kernel.org>
Reported-by: Matt Bobrowski <mattbobrowski@google.com>

Thank you so much Eduard, this worked:

* No duplicate BTF ID warnings
* No 15 minute BTF ID generation
* Matt's reproducer loads successfully.

I had a sneaky suspicion that it was these unspecified types, which is
why my hacky patch which got unspecified types out of the way got
things to *mostly* work.
