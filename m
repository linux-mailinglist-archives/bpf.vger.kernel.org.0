Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8E96A5E9B
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 19:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjB1SIv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Feb 2023 13:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjB1SIu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Feb 2023 13:08:50 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B0661167F;
        Tue, 28 Feb 2023 10:08:48 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id ec43so43614586edb.8;
        Tue, 28 Feb 2023 10:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677607727;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qOzDsbDWz8deVeDlyf7oz70IJZrIrdbf5TIDreK+nk0=;
        b=MkChXyWopf4h/NwbHcDWyKMtrOGonfoRblENFGwJl7+pmN2ugTs2LMkqHbUahzcWvB
         HjMnZsstbpOr81gR7SwT/77CDiY7RcRJs+2+bGtpLrsV7gw0VeAPK3OzXyCnDzvhivac
         NLc/kGsrcunoBn4prE7k+lk/YpZVcHX4G2rrv+b+3rKCA2rNHzHlkCTUx+W3mlA7jDES
         TYWI1bnh3Uwaxrz0OTGPkjzOL1tfT4alm1B8C+8QQ01QJRr3iWo1OIt+eIae0g2ceZoy
         GjEp2xT7TEzSqM9KgaTtF898vtP56uVTD7f8Ki5++ul62RFKuVEmd2WAvAED1k5QV8yB
         5Kdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677607727;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qOzDsbDWz8deVeDlyf7oz70IJZrIrdbf5TIDreK+nk0=;
        b=ffc2/rO+MI7JhXYwPgwxg/tcUaww4zHBhGlc1onQ12gbUzxrC1QIxqiHMEzw8Y7A4U
         Xeqhl274q3ubLQGat8DODLfW2MwswWbtPPCcNCRl71oiqoslJdW2fD941n4DzQqVPQ/G
         yQwpc5spM0YtfzIEDUhkUfVBjSSpFcmYbFGkWnCHbsXuieNMIfsjrOWOfU13xFAShJW4
         M1Lq8yd0uJYBShU8yodSmkIEa1tDPVcyFC5kImSHsnHiGAE1IBl9VO8Q9zAsSlth47XK
         pGotYMW2NZulFdzVu7rNOIRX0c9Qzd1UsJsq+ePVF6sVakchp+qJjBu5Qvznir8X7QC9
         pQqQ==
X-Gm-Message-State: AO0yUKVG3F+EoCYWsnbKBdnM+zyKRwsP6Is7IXAtEgS6o0dlgglKSkMw
        Cj59svcVz4GdwHvuitisy5g=
X-Google-Smtp-Source: AK7set8v2BsMdW0Zs0Qyt6200mf6QrYyzUncmJPAc58mot4CWMyiI90PbHODikDsm9iNLdE+asVVqA==
X-Received: by 2002:aa7:cfd7:0:b0:49e:45a8:1ac9 with SMTP id r23-20020aa7cfd7000000b0049e45a81ac9mr3927728edy.24.1677607726761;
        Tue, 28 Feb 2023 10:08:46 -0800 (PST)
Received: from [192.168.1.94] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id q29-20020a056402249d00b004af62273b66sm4559739eda.18.2023.02.28.10.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 10:08:46 -0800 (PST)
Message-ID: <9f843ed8635b8d0f7bb61d0c2ee3f91970863413.camel@gmail.com>
Subject: Re: bpf: Question about odd BPF verifier behaviour
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     KP Singh <kpsingh@kernel.org>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Matt Bobrowski <mattbobrowski@google.com>, bpf@vger.kernel.org,
        andrii@kernel.org, acme@redhat.com, dwarves@vger.kernel.org
Date:   Tue, 28 Feb 2023 20:08:44 +0200
In-Reply-To: <CACYkzJ4yR0n+kP9-G025uP2fwhyBh9DF2feA+H5mw+Re6GdkFQ@mail.gmail.com>
References: <Y/P1yxAuV6Wj3A0K@google.com>
         <e9f7c86ff50b556e08362ebc0b6ce6729a2db7e7.camel@gmail.com>
         <Y/czygarUnMnDF9m@google.com>
         <17833347f8cec0e44d856aeafbb1bbe203526237.camel@gmail.com>
         <Y/hLsgSO3B+2g9iF@google.com>
         <8f8f9d43d2f3f6d19c477c28d05527250cc6213d.camel@gmail.com>
         <Y/p0ryf5PcKIs7uj@google.com>
         <c4cda35711804ec26ebaeedc07d10d5d51901495.camel@gmail.com>
         <693dffd9571073a47820653fd2de863010491454.camel@gmail.com>
         <CAEf4BzYaiD27y=Y85xhrj+VOvJY_5q1oVtg-4vYmFZFEpmW+nQ@mail.gmail.com>
         <CACYkzJ7tgbJqwUVxfGd4UKDUcOQjK8zsbEKUUjV79=xHQn1fFg@mail.gmail.com>
         <CAEf4BzZauF7V3pY1hgWgnJRN1F6eSkbTOTG3kM0c85uAX-vOfQ@mail.gmail.com>
         <9ea9b52fca1300265ce5639a2da809813edb774f.camel@gmail.com>
         <CAEf4BzYO+Rgcfbr+QzJ-8BdQg-x-mC6c4bOhA+Z4cvu_1ObX+g@mail.gmail.com>
         <b245e95e9028d4eb14febda06f9fb25139e5e122.camel@gmail.com>
         <CACYkzJ4yR0n+kP9-G025uP2fwhyBh9DF2feA+H5mw+Re6GdkFQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, 2023-02-28 at 03:55 +0100, KP Singh wrote:
> On Mon, Feb 27, 2023 at 9:48=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
> >=20
> > On Mon, 2023-02-27 at 11:31 -0800, Andrii Nakryiko wrote:
> > [...]
> > > > > I'd start with understanding what BTF and DWARF differences are
> > > > > causing the issue before trying to come up with the fix. For that=
 we
> > > > > don't even need config or repro steps, it should be enough to sha=
re
> > > > > vmlinux with BTF and DWARF, and start from there.
> > > > >=20
> > > >=20
> > > > Yes, I suspect that there is some kind of unanticipated
> > > > anomaly for some DWARF encoding for some kind of objects,
> > > > just need to find the root for the diverging type hierarchies.
> > > >=20
> > > > > But I'm sure Eduard is on top of this already (especially that he=
 can
> > > > > repro the issue now).
> > > >=20
> > > > I'm working on it, nothing to report yet, but I'm working on it.
> > > >=20
> > >=20
> > > Thanks, please keep us posted!
> >=20
> > It is interesting how everything is interconnected. The patch for
> > pahole below happens to help. I prepared it last week while working on
> > new DWARF encoding scheme for btf_type_tag.
> >=20
> > I still need to track down which "unspecified_type" entries caused the
> > issue in this particular case. Will post an update tomorrow.
> >=20
> > Meanwhile, Matt, KP, could you please verify the patch on your side?
> > It is for the "next" branch of pahole.
> >=20
> > ---
> >=20
> > From 09fac63ca08e25aea499f827283b07cc87a7daab Mon Sep 17 00:00:00 2001
> > From: Eduard Zingerman <eddyz87@gmail.com>
> > Date: Tue, 21 Feb 2023 19:23:00 +0200
> > Subject: [PATCH] dwarf_loader: Fix for BTF id drift caused by adding
> >  unspecified types
> >=20
> > Recent changes to handle unspecified types (see [1]) cause BTF ID drift=
.
> >=20
> > Specifically, the intent of commits [2], [3] and [4] is to render
> > references to unspecified types as void type.
> > However, as a consequence:
> > - in `die__process_unit()` call to `cu__add_tag()` allocates `small_id`
> >   for unspecified type tags and adds these tags to `cu->types_table`;
> > - `btf_encoder__encode_tag()` skips generation of BTF entries for
> >   `DW_TAG_unspecified_type` tags.
> >=20
> > Such logic causes ID drift if unspecified type is not the last type
> > processed for compilation unit. `small_id` of each type following
> > unspecified type in the `cu->types_table` would have its BTF id off by =
-1.
> > Thus renders references established on recode phase invalid.
> >=20
> > This commit reverts `unspecified_type` id/tag tracking, instead:
> > - `small_id` for unspecified type tags is set to 0, thus reference to
> >   unspecified type tag would render BTF id of a `void` on recode phase;
> > - unspecified type tags are not added to `cu->types_table`.
> >=20
> > [1] https://lore.kernel.org/all/Y0R7uu3s%2FimnvPzM@kernel.org/
> > [2] bcc648a10cbc ("btf_encoder: Encode DW_TAG_unspecified_type returnin=
g routines as void")
> > [3] cffe5e1f75e1 ("core: Record if a CU has a DW_TAG_unspecified_type")
> > [4] 75e0fe28bb02 ("core: Add DW_TAG_unspecified_type to tag__is_tag_typ=
e() set")
> >=20
> > Fixes: bcc648a10cbc ("btf_encoder: Encode DW_TAG_unspecified_type retur=
ning routines as void")
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
>=20
> Tested-by: KP Singh <kpsingh@kernel.org>
> Reported-by: Matt Bobrowski <mattbobrowski@google.com>
>=20
> Thank you so much Eduard, this worked:
>=20
> * No duplicate BTF ID warnings
> * No 15 minute BTF ID generation
> * Matt's reproducer loads successfully.
>=20
> I had a sneaky suspicion that it was these unspecified types, which is
> why my hacky patch which got unspecified types out of the way got
> things to *mostly* work.

Hi KP,

Thanks a lot for testing!

I found the root cause for the bug (took me longer than I would like
to admit...). Using the patch below the reproducer from Matt works as
expected and warnings are gone.

Still, I think that my patch from yesterday is a more general
approach, as it correctly handles unspecified types that occur in
non-tail position, so I'll post that one.

Thanks,
Eduard

---

From daa53248e8a5087edbceaffe1fad51f9eb06e922 Mon Sep 17 00:00:00 2001
From: Eduard Zingerman <eddyz87@gmail.com>
Date: Tue, 28 Feb 2023 19:44:22 +0200
Subject: [PATCH] btf_encoder: reset encoder->unspecified_type for each CU

The field `encoder->unspecified_type` is set but not reset by function
`btf_encoder__encode_cu()` when processed `cu` has unspecified type.
The following sequence of events might occur when BTF encoding is
requested:
- CU with unspecified type is processed:
  - unspecified type id is 42
  - encoder->unspecified_type is set to 42
- CU without unspecified type is processed next using the same
  `encoder` object:
  - some `struct foo` has id 42 in this CU
  - the references to `struct foo` are set 0 by function
    `btf_encoder__tag_type()`.

This commit sets `encoder->unspecified_type` to 0 when CU does not
have unspecified type.

This issue was reported in thread [1].
See also [2].
[1] https://lore.kernel.org/bpf/Y%2FP1yxAuV6Wj3A0K@google.com/
[2] https://lore.kernel.org/all/Y0R7uu3s%2FimnvPzM@kernel.org/

Fixes: 52b25808e44a ("btf_encoder: Store type_id_off, unspecified type in e=
ncoder")
Reported-by: Matt Bobrowski <mattbobrowski@google.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 btf_encoder.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/btf_encoder.c b/btf_encoder.c
index da776f4..24f4c65 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1748,6 +1748,8 @@ int btf_encoder__encode_cu(struct btf_encoder *encode=
r, struct cu *cu, struct co
 	encoder->type_id_off =3D btf__type_cnt(encoder->btf) - 1;
 	if (encoder->cu->unspecified_type.tag)
 		encoder->unspecified_type =3D encoder->cu->unspecified_type.type;
+	else
+		encoder->unspecified_type =3D 0;
=20
 	if (!encoder->has_index_type) {
 		/* cu__find_base_type_by_name() takes "type_id_t *id" */
--=20
2.39.1
