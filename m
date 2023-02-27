Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BDC6A4C74
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 21:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjB0Usc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 15:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjB0Usb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 15:48:31 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4057F21977;
        Mon, 27 Feb 2023 12:48:30 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id j3so5077203wms.2;
        Mon, 27 Feb 2023 12:48:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677530909;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pIlJA343Cd7UZPafGMHYrBwMnAO50rw087gk56goomA=;
        b=IZGvfUX1Wz4aDKAHg9lNjguZeFFNeOr8ag8RwmFWw8jO98VuaJj/0dcbktXKThtKTq
         ChIqCsild8955zSDa9JyzSfzXNJjumQuiLJJdYaWNUEqG1N302WObSypYTGjt50O8w9c
         IMJb9ta5Y36G/0Tf0+93yECDoCtVLLumrzo6YZCcwAXEsL54VHs0VR3pTkx4tvpfB7f1
         6DbUP/LAbrn+oGdVfSC/FID1MlVlv+IJRYCIOst4P28w/RNuf24f3b6ssgl8rlK63zkW
         sOtRF63/dvsbNWSVlV3BrLMRpFdoVzsfpUDzbLqqSKUWL/cxmhmiqfU9McfU0oYrTqN6
         8NmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677530909;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pIlJA343Cd7UZPafGMHYrBwMnAO50rw087gk56goomA=;
        b=vPkh+2xJSg5+K5NQrdCjweqBZLgwWCfd/jbwx4yDBMqxv0ui/jnfyjOpVn2+GRsA2K
         GtYzi9en+0YKDdsZcCfkGHQHp5J40Y0eLDwN6qY92Gyf2qM8akTRfdNc31eABs1S6dtq
         3N0Wqf36f9WZhBKB/U4GhIHzBS5n4uoHz7KEP5Oo0HKE0dDkWC8NLiRiQ70NaA/Uw2Oe
         kqxvhjKFgdd/cbUCaOQWXJnbarfu9vicE48rTcFAdzcaqVkScQG+AP39a1cdLmxo093Y
         sb3Mi+72dB4QHMMgm5Xinj8Yd3JBudaoHdRPHXuR5PbS+El6lQ9ekXc9NxCYtj6AzaJf
         kPOw==
X-Gm-Message-State: AO0yUKXP/OZddRMkSxfoBOrUEq2qHDY5dpZ7aAOQTIzgDRfbiRxyIroO
        jTvuGo21jhjn7Q/z9IhodTw=
X-Google-Smtp-Source: AK7set+uSxZF6bCpBSTMGraRAqzREt2CS2ILwy40aOtAOHsalm3v0saURdBsNANKWkqXH4JUnrfTCQ==
X-Received: by 2002:a05:600c:3507:b0:3dc:4fd7:31e9 with SMTP id h7-20020a05600c350700b003dc4fd731e9mr392487wmq.7.1677530908528;
        Mon, 27 Feb 2023 12:48:28 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id az34-20020a05600c602200b003e6efc0f91csm10163185wmb.42.2023.02.27.12.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 12:48:28 -0800 (PST)
Message-ID: <b245e95e9028d4eb14febda06f9fb25139e5e122.camel@gmail.com>
Subject: Re: bpf: Question about odd BPF verifier behaviour
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     KP Singh <kpsingh@kernel.org>,
        Matt Bobrowski <mattbobrowski@google.com>, bpf@vger.kernel.org,
        andrii@kernel.org, acme@redhat.com, dwarves@vger.kernel.org
Date:   Mon, 27 Feb 2023 22:48:26 +0200
In-Reply-To: <CAEf4BzYO+Rgcfbr+QzJ-8BdQg-x-mC6c4bOhA+Z4cvu_1ObX+g@mail.gmail.com>
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

On Mon, 2023-02-27 at 11:31 -0800, Andrii Nakryiko wrote:
[...]
> > > I'd start with understanding what BTF and DWARF differences are
> > > causing the issue before trying to come up with the fix. For that we
> > > don't even need config or repro steps, it should be enough to share
> > > vmlinux with BTF and DWARF, and start from there.
> > >=20
> >=20
> > Yes, I suspect that there is some kind of unanticipated
> > anomaly for some DWARF encoding for some kind of objects,
> > just need to find the root for the diverging type hierarchies.
> >=20
> > > But I'm sure Eduard is on top of this already (especially that he can
> > > repro the issue now).
> >=20
> > I'm working on it, nothing to report yet, but I'm working on it.
> >=20
>=20
> Thanks, please keep us posted!

It is interesting how everything is interconnected. The patch for
pahole below happens to help. I prepared it last week while working on
new DWARF encoding scheme for btf_type_tag.

I still need to track down which "unspecified_type" entries caused the
issue in this particular case. Will post an update tomorrow.

Meanwhile, Matt, KP, could you please verify the patch on your side?
It is for the "next" branch of pahole.

---

From 09fac63ca08e25aea499f827283b07cc87a7daab Mon Sep 17 00:00:00 2001
From: Eduard Zingerman <eddyz87@gmail.com>
Date: Tue, 21 Feb 2023 19:23:00 +0200
Subject: [PATCH] dwarf_loader: Fix for BTF id drift caused by adding
 unspecified types

Recent changes to handle unspecified types (see [1]) cause BTF ID drift.

Specifically, the intent of commits [2], [3] and [4] is to render
references to unspecified types as void type.
However, as a consequence:
- in `die__process_unit()` call to `cu__add_tag()` allocates `small_id`
  for unspecified type tags and adds these tags to `cu->types_table`;
- `btf_encoder__encode_tag()` skips generation of BTF entries for
  `DW_TAG_unspecified_type` tags.

Such logic causes ID drift if unspecified type is not the last type
processed for compilation unit. `small_id` of each type following
unspecified type in the `cu->types_table` would have its BTF id off by -1.
Thus renders references established on recode phase invalid.

This commit reverts `unspecified_type` id/tag tracking, instead:
- `small_id` for unspecified type tags is set to 0, thus reference to
  unspecified type tag would render BTF id of a `void` on recode phase;
- unspecified type tags are not added to `cu->types_table`.

[1] https://lore.kernel.org/all/Y0R7uu3s%2FimnvPzM@kernel.org/
[2] bcc648a10cbc ("btf_encoder: Encode DW_TAG_unspecified_type returning ro=
utines as void")
[3] cffe5e1f75e1 ("core: Record if a CU has a DW_TAG_unspecified_type")
[4] 75e0fe28bb02 ("core: Add DW_TAG_unspecified_type to tag__is_tag_type() =
set")

Fixes: bcc648a10cbc ("btf_encoder: Encode DW_TAG_unspecified_type returning=
 routines as void")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 btf_encoder.c  |  8 --------
 dwarf_loader.c | 25 +++++++++++++++++++------
 dwarves.h      |  8 --------
 3 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index da776f4..07a9dc5 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -69,7 +69,6 @@ struct btf_encoder {
 	const char	  *filename;
 	struct elf_symtab *symtab;
 	uint32_t	  type_id_off;
-	uint32_t	  unspecified_type;
 	int		  saved_func_cnt;
 	bool		  has_index_type,
 			  need_index_type,
@@ -635,11 +634,6 @@ static int32_t btf_encoder__tag_type(struct btf_encode=
r *encoder, uint32_t tag_t
 	if (tag_type =3D=3D 0)
 		return 0;
=20
-	if (encoder->unspecified_type && tag_type =3D=3D encoder->unspecified_typ=
e) {
-		// No provision for encoding this, turn it into void.
-		return 0;
-	}
-
 	return encoder->type_id_off + tag_type;
 }
=20
@@ -1746,8 +1740,6 @@ int btf_encoder__encode_cu(struct btf_encoder *encode=
r, struct cu *cu, struct co
=20
 	encoder->cu =3D cu;
 	encoder->type_id_off =3D btf__type_cnt(encoder->btf) - 1;
-	if (encoder->cu->unspecified_type.tag)
-		encoder->unspecified_type =3D encoder->cu->unspecified_type.type;
=20
 	if (!encoder->has_index_type) {
 		/* cu__find_base_type_by_name() takes "type_id_t *id" */
diff --git a/dwarf_loader.c b/dwarf_loader.c
index 014e130..c37bd7b 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -2155,8 +2155,7 @@ static struct tag *__die__process_tag(Dwarf_Die *die,=
 struct cu *cu,
 	case DW_TAG_atomic_type:
 		tag =3D die__create_new_tag(die, cu);		break;
 	case DW_TAG_unspecified_type:
-		cu->unspecified_type.tag =3D
-			tag =3D die__create_new_tag(die, cu);     break;
+		tag =3D die__create_new_tag(die, cu);		break;
 	case DW_TAG_pointer_type:
 		tag =3D die__create_new_pointer_tag(die, cu, conf);	break;
 	case DW_TAG_ptr_to_member_type:
@@ -2219,13 +2218,27 @@ static int die__process_unit(Dwarf_Die *die, struct=
 cu *cu, struct conf_load *co
 			continue;
 		}
=20
-		uint32_t id;
-		cu__add_tag(cu, tag, &id);
+		uint32_t id =3D 0;
+		/* There is no BTF representation for unspecified types.
+		 * Currently we want such types to be represented as `void`
+		 * (and thus skip BTF encoding).
+		 *
+		 * As BTF encoding is skipped, such types must not be added to type tabl=
e,
+		 * otherwise an ID for a type would be allocated and we would be forced
+		 * to put something in BTF at this ID.
+		 * Thus avoid `cu__add_tag()` call for such types.
+		 *
+		 * On the other hand, there might be references to this type from other
+		 * tags, so `dwarf_cu__find_tag_by_ref()` must return something.
+		 * Thus call `cu__hash()` for such types.
+		 *
+		 * Note, that small_id of zero would be assigned to unspecified type ent=
ry.
+		 */
+		if (tag->tag !=3D DW_TAG_unspecified_type)
+			cu__add_tag(cu, tag, &id);
 		cu__hash(cu, tag);
 		struct dwarf_tag *dtag =3D tag->priv;
 		dtag->small_id =3D id;
-		if (tag->tag =3D=3D DW_TAG_unspecified_type)
-			cu->unspecified_type.type =3D id;
 	} while (dwarf_siblingof(die, die) =3D=3D 0);
=20
 	return 0;
diff --git a/dwarves.h b/dwarves.h
index 5074cf8..e92b2fd 100644
--- a/dwarves.h
+++ b/dwarves.h
@@ -236,10 +236,6 @@ struct debug_fmt_ops {
=20
 #define ARCH_MAX_REGISTER_PARAMS	8
=20
-/*
- * unspecified_type: If this CU has a DW_TAG_unspecified_type, as BTF does=
n't have a representation for this
- * 		     and thus we need to check functions returning this to convert it=
 to void.
- */
 struct cu {
 	struct list_head node;
 	struct list_head tags;
@@ -248,10 +244,6 @@ struct cu {
 	struct ptr_table functions_table;
 	struct ptr_table tags_table;
 	struct rb_root	 functions;
-	struct {
-		struct tag	 *tag;
-		uint32_t	 type;
-	} unspecified_type;
 	char		 *name;
 	char		 *filename;
 	void 		 *priv;
--=20
2.39.1

