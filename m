Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6347B6A5F16
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 19:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjB1S4Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Feb 2023 13:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjB1S4X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Feb 2023 13:56:23 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDB930193;
        Tue, 28 Feb 2023 10:56:21 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id s26so44046890edw.11;
        Tue, 28 Feb 2023 10:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onDxmU0bvHO2xRTW938wBIy0pRS2oV7xHL5uQzaV2KU=;
        b=hLJeQKfmmpkSCUSr6R4USJKr9lJeyUoPqzvK9ycD+43wRDj4VHnyB4xIGKL2gDY3I6
         oX9qAu49SjfbJ1eA5gYS+z0gIxk6CaeWXjMylL60ssSVgv9s2Q7KH13Y8qgcgJq7FqkS
         fYwljSF2DlusyQoy0yut2R3Q+2NxMH5NmU3Xl0TI1PAkKg29e2+QsN3jpbGysnujQU2v
         gt0OOd44dI/sWjnJYH1IK13pUUACGWsCu4FpaqeP2eO+wiUylbwbB10tl6WvwsqSSwFl
         UeOBPJsgMw6gKeyNxu7eyRJewP96snFgoI94hXod7X/zb6mIS2GX1o8CWlugm2o2lNak
         OXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=onDxmU0bvHO2xRTW938wBIy0pRS2oV7xHL5uQzaV2KU=;
        b=lcPZEDiXP8gZi2g9rjeqah+NVPbJ4kfKzbg9OAYunqPGte7OMinGS6Ds8AoemCB5Yn
         H+DkL11XWSkE+ax5MyEgvFGuzyLPTsNTFdPBjity0QH8V32rSHJMMmUEZgzUs6+L0w+J
         rk4/gp9+br9XaMNxd69L8gyUgQ5xMihxx6sMsf/l3ynHf5QGXnzFts28u5yTBvGktflB
         bILlfWGyE5TJlo9pt1w6WX3LgHy8JmQYfWVQ3fDZFNbouUPN6Zlz2QGZglG0G5SuyIQ/
         Xni0+QAxY4Gkas3pPDgJ3g9H4G6zK15ZkTB0bglKK/HPVlwTJmDJn9Gffe1JjeKpF6bw
         Afmw==
X-Gm-Message-State: AO0yUKVtmhErM5UyvWdZx3xkhMJDuH++ID2Qa5WWaAeNM9sC7Wx8M4nr
        lVQz/sXnrclQknFWfFLaWFuqtOPNgj61ZGQlEp4pAp12
X-Google-Smtp-Source: AK7set/POZNdaVX2Ac9t6W2m34VGaWFeBOARYK7ttDIFvG86i0BEmlEAou7ZHcFO+t9KgAL5FgGF4lpVpnkln9UlCcA=
X-Received: by 2002:a17:907:e94:b0:8d7:edbc:a7b6 with SMTP id
 ho20-20020a1709070e9400b008d7edbca7b6mr3438548ejc.2.1677610579714; Tue, 28
 Feb 2023 10:56:19 -0800 (PST)
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
 <CAEf4BzYO+Rgcfbr+QzJ-8BdQg-x-mC6c4bOhA+Z4cvu_1ObX+g@mail.gmail.com>
 <b245e95e9028d4eb14febda06f9fb25139e5e122.camel@gmail.com>
 <CACYkzJ4yR0n+kP9-G025uP2fwhyBh9DF2feA+H5mw+Re6GdkFQ@mail.gmail.com> <9f843ed8635b8d0f7bb61d0c2ee3f91970863413.camel@gmail.com>
In-Reply-To: <9f843ed8635b8d0f7bb61d0c2ee3f91970863413.camel@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 28 Feb 2023 10:56:07 -0800
Message-ID: <CAEf4BzZXb7SYFqf=gUGdYxDOXSHXkzgpZj4FLBYchsahHBU8Ew@mail.gmail.com>
Subject: Re: bpf: Question about odd BPF verifier behaviour
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     KP Singh <kpsingh@kernel.org>,
        Matt Bobrowski <mattbobrowski@google.com>, bpf@vger.kernel.org,
        andrii@kernel.org, acme@redhat.com, dwarves@vger.kernel.org
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

On Tue, Feb 28, 2023 at 10:08=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> On Tue, 2023-02-28 at 03:55 +0100, KP Singh wrote:
> > On Mon, Feb 27, 2023 at 9:48=E2=80=AFPM Eduard Zingerman <eddyz87@gmail=
.com> wrote:
> > >
> > > On Mon, 2023-02-27 at 11:31 -0800, Andrii Nakryiko wrote:
> > > [...]
> > > > > > I'd start with understanding what BTF and DWARF differences are
> > > > > > causing the issue before trying to come up with the fix. For th=
at we
> > > > > > don't even need config or repro steps, it should be enough to s=
hare
> > > > > > vmlinux with BTF and DWARF, and start from there.
> > > > > >
> > > > >
> > > > > Yes, I suspect that there is some kind of unanticipated
> > > > > anomaly for some DWARF encoding for some kind of objects,
> > > > > just need to find the root for the diverging type hierarchies.
> > > > >
> > > > > > But I'm sure Eduard is on top of this already (especially that =
he can
> > > > > > repro the issue now).
> > > > >
> > > > > I'm working on it, nothing to report yet, but I'm working on it.
> > > > >
> > > >
> > > > Thanks, please keep us posted!
> > >
> > > It is interesting how everything is interconnected. The patch for
> > > pahole below happens to help. I prepared it last week while working o=
n
> > > new DWARF encoding scheme for btf_type_tag.
> > >
> > > I still need to track down which "unspecified_type" entries caused th=
e
> > > issue in this particular case. Will post an update tomorrow.
> > >
> > > Meanwhile, Matt, KP, could you please verify the patch on your side?
> > > It is for the "next" branch of pahole.
> > >
> > > ---
> > >
> > > From 09fac63ca08e25aea499f827283b07cc87a7daab Mon Sep 17 00:00:00 200=
1
> > > From: Eduard Zingerman <eddyz87@gmail.com>
> > > Date: Tue, 21 Feb 2023 19:23:00 +0200
> > > Subject: [PATCH] dwarf_loader: Fix for BTF id drift caused by adding
> > >  unspecified types
> > >
> > > Recent changes to handle unspecified types (see [1]) cause BTF ID dri=
ft.
> > >
> > > Specifically, the intent of commits [2], [3] and [4] is to render
> > > references to unspecified types as void type.
> > > However, as a consequence:
> > > - in `die__process_unit()` call to `cu__add_tag()` allocates `small_i=
d`
> > >   for unspecified type tags and adds these tags to `cu->types_table`;
> > > - `btf_encoder__encode_tag()` skips generation of BTF entries for
> > >   `DW_TAG_unspecified_type` tags.
> > >
> > > Such logic causes ID drift if unspecified type is not the last type
> > > processed for compilation unit. `small_id` of each type following
> > > unspecified type in the `cu->types_table` would have its BTF id off b=
y -1.
> > > Thus renders references established on recode phase invalid.
> > >
> > > This commit reverts `unspecified_type` id/tag tracking, instead:
> > > - `small_id` for unspecified type tags is set to 0, thus reference to
> > >   unspecified type tag would render BTF id of a `void` on recode phas=
e;
> > > - unspecified type tags are not added to `cu->types_table`.
> > >
> > > [1] https://lore.kernel.org/all/Y0R7uu3s%2FimnvPzM@kernel.org/
> > > [2] bcc648a10cbc ("btf_encoder: Encode DW_TAG_unspecified_type return=
ing routines as void")
> > > [3] cffe5e1f75e1 ("core: Record if a CU has a DW_TAG_unspecified_type=
")
> > > [4] 75e0fe28bb02 ("core: Add DW_TAG_unspecified_type to tag__is_tag_t=
ype() set")
> > >
> > > Fixes: bcc648a10cbc ("btf_encoder: Encode DW_TAG_unspecified_type ret=
urning routines as void")
> > > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> >
> > Tested-by: KP Singh <kpsingh@kernel.org>
> > Reported-by: Matt Bobrowski <mattbobrowski@google.com>
> >
> > Thank you so much Eduard, this worked:
> >
> > * No duplicate BTF ID warnings
> > * No 15 minute BTF ID generation
> > * Matt's reproducer loads successfully.
> >
> > I had a sneaky suspicion that it was these unspecified types, which is
> > why my hacky patch which got unspecified types out of the way got
> > things to *mostly* work.
>
> Hi KP,
>
> Thanks a lot for testing!
>
> I found the root cause for the bug (took me longer than I would like
> to admit...). Using the patch below the reproducer from Matt works as
> expected and warnings are gone.
>
> Still, I think that my patch from yesterday is a more general
> approach, as it correctly handles unspecified types that occur in
> non-tail position, so I'll post that one.

I agree, please send it to dwarves@ as a proper patch. Thank you for
digging into this and fixing it quickly!

>
> Thanks,
> Eduard
>
> ---
>
> From daa53248e8a5087edbceaffe1fad51f9eb06e922 Mon Sep 17 00:00:00 2001
> From: Eduard Zingerman <eddyz87@gmail.com>
> Date: Tue, 28 Feb 2023 19:44:22 +0200
> Subject: [PATCH] btf_encoder: reset encoder->unspecified_type for each CU
>
> The field `encoder->unspecified_type` is set but not reset by function
> `btf_encoder__encode_cu()` when processed `cu` has unspecified type.
> The following sequence of events might occur when BTF encoding is
> requested:
> - CU with unspecified type is processed:
>   - unspecified type id is 42
>   - encoder->unspecified_type is set to 42
> - CU without unspecified type is processed next using the same
>   `encoder` object:
>   - some `struct foo` has id 42 in this CU
>   - the references to `struct foo` are set 0 by function
>     `btf_encoder__tag_type()`.
>
> This commit sets `encoder->unspecified_type` to 0 when CU does not
> have unspecified type.
>
> This issue was reported in thread [1].
> See also [2].
> [1] https://lore.kernel.org/bpf/Y%2FP1yxAuV6Wj3A0K@google.com/
> [2] https://lore.kernel.org/all/Y0R7uu3s%2FimnvPzM@kernel.org/
>
> Fixes: 52b25808e44a ("btf_encoder: Store type_id_off, unspecified type in=
 encoder")
> Reported-by: Matt Bobrowski <mattbobrowski@google.com>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  btf_encoder.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/btf_encoder.c b/btf_encoder.c
> index da776f4..24f4c65 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -1748,6 +1748,8 @@ int btf_encoder__encode_cu(struct btf_encoder *enco=
der, struct cu *cu, struct co
>         encoder->type_id_off =3D btf__type_cnt(encoder->btf) - 1;
>         if (encoder->cu->unspecified_type.tag)
>                 encoder->unspecified_type =3D encoder->cu->unspecified_ty=
pe.type;
> +       else
> +               encoder->unspecified_type =3D 0;
>
>         if (!encoder->has_index_type) {
>                 /* cu__find_base_type_by_name() takes "type_id_t *id" */
> --
> 2.39.1
