Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0181A64CB41
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 14:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237522AbiLNN0G (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 08:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiLNN0G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 08:26:06 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316E3A460
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 05:26:04 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id o15so11246447wmr.4
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 05:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vwko3RpMUBmRcGg2VkMfx6byGKuLu6C9h4wBIlhoRvU=;
        b=cwfu5y4R7arDgv61NB/HAZ0gGBl+IV7pvkRBIylGXszSjxDRN/wcc4dk1zkTBdjBRV
         rNBYWiNcVgE04kjI0gzq33u24waksbMt1MW7z5Ai4EkobomRH6/0WmDi/2fTZ4NoJ97p
         3Lfe8DKzCkoVXkY3paJkNohr0Q8kGIVvrMWJDVNJEjg/HnFr2b1QfWGWUB5JA580uD5a
         TByog/6Zm7Cvv4jzcA5VchaN12f59LYL+C1EQxqWaLsWzZFavpEoksf29Ff+83xNSq/i
         igVVBQ8FDqd1ME/jk+NxajrfLR0DlsOYJgB6eLnjgpgfFv4JY9BNbAIO6dfNDK+IcIa6
         UHCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vwko3RpMUBmRcGg2VkMfx6byGKuLu6C9h4wBIlhoRvU=;
        b=LVrrMuiZAKI8Rl2KS3Oa6iNh13atypIFB1r2f2yH4x9JPyarsp6o8EIX3bL+YVryc1
         WkqBSE1SN6ZZ+jlvY3SXDxf0kTUPdiqeJGu0MXLVnAIlfU9jZ8RrJBw5SdBfVPgwBG0H
         HKaPH3ODt5DizZ29+DiAkgRLZKDVoLKow7egsYuUvg6DN9BljuImicJxWBEIhzmw370i
         k3InaX365r8NXiMD42kys5Vdd/84ebbWmLv3MBLCpGPPKTok/H2ICHPi421KdwpDKn4M
         EumQ3wZ703bYyaKpo4LwmHXOY/c4STjIeCpBGTtVJ1FHo0LD8Mc8eK724yQFMdi5T7bo
         7q4g==
X-Gm-Message-State: ANoB5pkWKDKjMoEBJ43ARRnULfGI9Iic4ITwIjw10XDFTYUEbDOa9w9O
        gNBv4qOCEhdA5ZIsCPNOVLKR6lmpDiIGTw==
X-Google-Smtp-Source: AA0mqf75xymVWqL+eufBgK06FYe6IKe7KmWVmPJchxSVlebVIar/6TSn7JFdcLcGFxHkKumZtJ+d/Q==
X-Received: by 2002:a05:600c:3ac3:b0:3d2:148b:4a26 with SMTP id d3-20020a05600c3ac300b003d2148b4a26mr14070003wms.32.1671024362565;
        Wed, 14 Dec 2022 05:26:02 -0800 (PST)
Received: from [192.168.43.226] (178-133-1-161.mobile.vf-ua.net. [178.133.1.161])
        by smtp.gmail.com with ESMTPSA id p5-20020a1c2905000000b003d1b4d957aasm2454653wmp.36.2022.12.14.05.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 05:26:01 -0800 (PST)
Message-ID: <6ff2854e4c1f2a5c3754a8ffaadf5d47fa1c2285.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/7] bpf: regsafe() must not skip check_ids()
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com,
        memxor@gmail.com, ecree.xilinx@gmail.com
Date:   Wed, 14 Dec 2022 15:25:58 +0200
In-Reply-To: <CAEf4BzbPBeAUzueQ7mxcmSovY2Nqr37RFZnb5B1pwSDqNhyZ6w@mail.gmail.com>
References: <20221209135733.28851-1-eddyz87@gmail.com>
         <20221209135733.28851-2-eddyz87@gmail.com>
         <CAEf4BzbPBeAUzueQ7mxcmSovY2Nqr37RFZnb5B1pwSDqNhyZ6w@mail.gmail.com>
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

On Tue, 2022-12-13 at 16:35 -0800, Andrii Nakryiko wrote:
> On Fri, Dec 9, 2022 at 5:58 AM Eduard Zingerman <eddyz87@gmail.com> wrote=
:
> >=20
> > The verifier.c:regsafe() has the following shortcut:
> >=20
> >         equal =3D memcmp(rold, rcur, offsetof(struct bpf_reg_state, par=
ent)) =3D=3D 0;
> >         ...
> >         if (equal)
> >                 return true;
> >=20
> > Which is executed regardless old register type. This is incorrect for
> > register types that might have an ID checked by check_ids(), namely:
> >  - PTR_TO_MAP_KEY
> >  - PTR_TO_MAP_VALUE
> >  - PTR_TO_PACKET_META
> >  - PTR_TO_PACKET
> >=20
> > The following pattern could be used to exploit this:
> >=20
> >   0: r9 =3D map_lookup_elem(...)  ; Returns PTR_TO_MAP_VALUE_OR_NULL id=
=3D1.
> >   1: r8 =3D map_lookup_elem(...)  ; Returns PTR_TO_MAP_VALUE_OR_NULL id=
=3D2.
> >   2: r7 =3D ktime_get_ns()        ; Unbound SCALAR_VALUE.
> >   3: r6 =3D ktime_get_ns()        ; Unbound SCALAR_VALUE.
> >   4: if r6 > r7 goto +1         ; No new information about the state
> >                                 ; is derived from this check, thus
> >                                 ; produced verifier states differ only
> >                                 ; in 'insn_idx'.
> >   5: r9 =3D r8                    ; Optionally make r9.id =3D=3D r8.id.
> >   --- checkpoint ---            ; Assume is_state_visisted() creates a
> >                                 ; checkpoint here.
> >   6: if r9 =3D=3D 0 goto <exit>     ; Nullness info is propagated to al=
l
> >                                 ; registers with matching ID.
> >   7: r1 =3D *(u64 *) r8           ; Not always safe.
> >=20
> > Verifier first visits path 1-7 where r8 is verified to be not null
> > at (6). Later the jump from 4 to 6 is examined. The checkpoint for (6)
> > looks as follows:
> >   R8_rD=3Dmap_value_or_null(id=3D2,off=3D0,ks=3D4,vs=3D8,imm=3D0)
> >   R9_rwD=3Dmap_value_or_null(id=3D2,off=3D0,ks=3D4,vs=3D8,imm=3D0)
> >   R10=3Dfp0
> >=20
> > The current state is:
> >   R0=3D... R6=3D... R7=3D... fp-8=3D...
> >   R8=3Dmap_value_or_null(id=3D2,off=3D0,ks=3D4,vs=3D8,imm=3D0)
> >   R9=3Dmap_value_or_null(id=3D1,off=3D0,ks=3D4,vs=3D8,imm=3D0)
> >   R10=3Dfp0
> >=20
> > Note that R8 states are byte-to-byte identical, so regsafe() would
> > exit early and skip call to check_ids(), thus ID mapping 2->2 will not
> > be added to 'idmap'. Next, states for R9 are compared: these are not
> > identical and check_ids() is executed, but 'idmap' is empty, so
> > check_ids() adds mapping 2->1 to 'idmap' and returns success.
> >=20
> > This commit pushes the 'equal' down to register types that don't need
> > check_ids().
> >=20
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> > ---
> >  kernel/bpf/verifier.c | 29 ++++++++---------------------
> >  1 file changed, 8 insertions(+), 21 deletions(-)
> >=20
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 3194e9d9e4e4..d05c5d0344c6 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -12926,15 +12926,6 @@ static bool regsafe(struct bpf_verifier_env *e=
nv, struct bpf_reg_state *rold,
> >=20
> >         equal =3D memcmp(rold, rcur, offsetof(struct bpf_reg_state, par=
ent)) =3D=3D 0;
> >=20
> > -       if (rold->type =3D=3D PTR_TO_STACK)
> > -               /* two stack pointers are equal only if they're pointin=
g to
> > -                * the same stack frame, since fp-8 in foo !=3D fp-8 in=
 bar
> > -                */
> > -               return equal && rold->frameno =3D=3D rcur->frameno;
> > -
> > -       if (equal)
> > -               return true;
> > -
> >         if (rold->type =3D=3D NOT_INIT)
> >                 /* explored state can't have used this */
> >                 return true;
> > @@ -12942,6 +12933,8 @@ static bool regsafe(struct bpf_verifier_env *en=
v, struct bpf_reg_state *rold,
> >                 return false;
> >         switch (base_type(rold->type)) {
> >         case SCALAR_VALUE:
> > +               if (equal)
> > +                       return true;
> >                 if (env->explore_alu_limits)
> >                         return false;
> >                 if (rcur->type =3D=3D SCALAR_VALUE) {
> > @@ -13012,20 +13005,14 @@ static bool regsafe(struct bpf_verifier_env *=
env, struct bpf_reg_state *rold,
> >                 /* new val must satisfy old val knowledge */
> >                 return range_within(rold, rcur) &&
> >                        tnum_in(rold->var_off, rcur->var_off);
> > -       case PTR_TO_CTX:
> > -       case CONST_PTR_TO_MAP:
> > -       case PTR_TO_PACKET_END:
> > -       case PTR_TO_FLOW_KEYS:
> > -       case PTR_TO_SOCKET:
> > -       case PTR_TO_SOCK_COMMON:
> > -       case PTR_TO_TCP_SOCK:
> > -       case PTR_TO_XDP_SOCK:
> > -               /* Only valid matches are exact, which memcmp() above
> > -                * would have accepted
> > +       case PTR_TO_STACK:
> > +               /* two stack pointers are equal only if they're pointin=
g to
> > +                * the same stack frame, since fp-8 in foo !=3D fp-8 in=
 bar
> >                  */
> > +               return equal && rold->frameno =3D=3D rcur->frameno;
> >         default:
> > -               /* Don't know what's going on, just say it's not safe *=
/
> > -               return false;
> > +               /* Only valid matches are exact, which memcmp() */
> > +               return equal;
>=20
> Is it safe to assume this for any possible register type? Wouldn't
> register types that use id and/or ref_obj_id need extra checks here? I
> think preexisting default was a safer approach, in which if we forgot
> to explicitly add support for some new or updated register type, the
> worst thing is that for that *new* register we'd have suboptimal
> verification performance, but not safety concerns.

Well, I don't think that this commit changes regsafe() behavior in
this regard. Here is how the code was structured before this commit:

static bool regsafe(struct bpf_verifier_env *env, struct bpf_reg_state *rol=
d,
		    struct bpf_reg_state *rcur, struct bpf_id_pair *idmap)
{
	bool equal;

	if (!(rold->live & REG_LIVE_READ))
		return true;
	equal =3D memcmp(rold, rcur, offsetof(struct bpf_reg_state, parent)) =3D=
=3D 0;
	if (rold->type =3D=3D PTR_TO_STACK)
		return equal && rold->frameno =3D=3D rcur->frameno;
--->	if (equal)
		return true;
	if (rold->type =3D=3D NOT_INIT)
		return true;
	if (rcur->type =3D=3D NOT_INIT)
		return false;
	switch (base_type(rold->type)) {
	case SCALAR_VALUE:
        	... it's own logic, always returns ...
	case PTR_TO_MAP_KEY:
	case PTR_TO_MAP_VALUE:
        	... it's own logic, always returns ...
	case PTR_TO_PACKET_META:
	case PTR_TO_PACKET:
        	... it's own logic, always returns ...
	case PTR_TO_CTX:
	case CONST_PTR_TO_MAP:
	case PTR_TO_PACKET_END:
	case PTR_TO_FLOW_KEYS:
	case PTR_TO_SOCKET:
	case PTR_TO_SOCK_COMMON:
	case PTR_TO_TCP_SOCK:
	case PTR_TO_XDP_SOCK:
	default:
		return false;
	}

	/* Shouldn't get here; if we do, say it's not safe */
	WARN_ON_ONCE(1);
	return false;
}

So the "safe if byte-to-byte equal" behavior was present already.
I can add an explicit list of types to the "return equal;" branch
and add a default "return false;" branch if you think that it is
more fool-proof.

>=20
>=20
> >         }
> >=20
> >         /* Shouldn't get here; if we do, say it's not safe */
> > --
> > 2.34.1
> >=20

