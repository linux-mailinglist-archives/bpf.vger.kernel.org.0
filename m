Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E80A64E2E4
	for <lists+bpf@lfdr.de>; Thu, 15 Dec 2022 22:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbiLOVQ2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Dec 2022 16:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiLOVQ1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Dec 2022 16:16:27 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9901A231
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 13:16:26 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id b9so275846ljr.5
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 13:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=psl0FigBggHlFjNhl2/n/Xn2O/OFzIsWap+B9QSe+Yg=;
        b=KdLbKwdQqKgx1K/NtgjM/PdE6L7tqFeQmtZfeaNGiKrTcq808Qb5IQ6znNTagObW57
         I6//s5//vC0KgKUN9/Wn7wVjCZUFr5Y9auL1A9ULM+qSrpDxUhY8pilwqAuJ2JyA40SH
         NhwCbzCHKAPr3x97KS4yah6gIYEhdhbmeO7c6SB2ZPGGIkKILz8paSA4pqjU8CzPrBzf
         K+X3luxg2+qZwHvaUneyvtjxitJ2qvT6cLE94S5mfjJ/X1r/czqPxP4Q423An6UZFD6j
         N7L07CtTPyyd/SaIuL9wEQJXOrCCZC1U0v4/rYibmczSH4BghL7A2o+l5OC+Xo8TbhoP
         i5vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=psl0FigBggHlFjNhl2/n/Xn2O/OFzIsWap+B9QSe+Yg=;
        b=53kTjibcT4JhOXx+LPPJzcVwpmfgJ5sodBUEuU73y+q4eLfzHpp+I82HEOopx+WXsd
         YOMnTGEM4A+jnPL63jk95tDMz7ZKatM2qybWl9hcHPSkMAMLPcDu/PaD5GpmOX19YKdr
         bgHTkibafuOTVKJr/9dbIvMgG5M8IejmGgeAURicgQ9XRDVz4xNSFji5C3pDTxJoD+6k
         i6s5M6Jm84sjt0ArcnHidG4XeVzYa120vkvZ4tI9k4KiW2tVicBWMhT/eF9JWCuqvDZ5
         hi4j+Nv75Siepue2YNCO8uF6C/bGui6dobXte/IjtTs+j5fZc1xKQB81tNhp+ORMKjFD
         jpkA==
X-Gm-Message-State: ANoB5pnmSHHMAprDwUCNhNvqLIU66ebVIeNvaxHdKNoxgKlLb5xmhSkz
        ssqffhF88nxSVx9p2+Y4TL8=
X-Google-Smtp-Source: AA0mqf4H4SuPJLFwIboKtLU4bkgGIkWcdwrHbZL/n5PP3DoXuLdZqfG1qyU2DcF1kTPdoOA5TWzfMw==
X-Received: by 2002:a05:651c:1603:b0:277:44e:499e with SMTP id f3-20020a05651c160300b00277044e499emr13568583ljq.14.1671138984394;
        Thu, 15 Dec 2022 13:16:24 -0800 (PST)
Received: from [192.168.1.113] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id u10-20020a05651220ca00b0048a982ad0a8sm17117lfr.23.2022.12.15.13.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 13:16:23 -0800 (PST)
Message-ID: <3379155f9ee1902b0ae96d1207fab1a86bb9f048.camel@gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: fix btf_dump's packed struct
 determination
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     kernel-team@fb.com
Date:   Thu, 15 Dec 2022 23:16:22 +0200
In-Reply-To: <20221215183605.4149488-1-andrii@kernel.org>
References: <20221215183605.4149488-1-andrii@kernel.org>
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

On Thu, 2022-12-15 at 10:36 -0800, Andrii Nakryiko wrote:
> Fix bug in btf_dump's logic of determining if a given struct type is
> packed or not. The notion of "natural alignment" is not needed and is
> even harmful in this case, so drop it altogether. The biggest difference
> in btf_is_struct_packed() compared to its original implementation is
> that we don't really use btf__align_of() to determine overall alignment
> of a struct type (because it could be 1 for both packed and non-packed
> struct, depending on specifci field definitions), and just use field's
> actual alignment to calculate whether any field is requiring packing or
> struct's size overall necessitates packing.
>=20
> Add two simple test cases that demonstrate the difference this change
> would make.
>=20
> Fixes: ea2ce1ba99aa ("libbpf: Fix BTF-to-C converter's padding logic")
> Reported-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Looks good!

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

> ---
>  tools/lib/bpf/btf_dump.c                      | 33 ++++---------------
>  .../bpf/progs/btf_dump_test_case_packing.c    | 19 +++++++++++
>  2 files changed, 25 insertions(+), 27 deletions(-)
>=20
> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index d6fd93a57f11..580985ee5545 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -830,47 +830,26 @@ static void btf_dump_emit_type(struct btf_dump *d, =
__u32 id, __u32 cont_id)
>  	}
>  }
> =20
> -static int btf_natural_align_of(const struct btf *btf, __u32 id)
> -{
> -	const struct btf_type *t =3D btf__type_by_id(btf, id);
> -	int i, align, vlen;
> -	const struct btf_member *m;
> -
> -	if (!btf_is_composite(t))
> -		return btf__align_of(btf, id);
> -
> -	align =3D 1;
> -	m =3D btf_members(t);
> -	vlen =3D btf_vlen(t);
> -	for (i =3D 0; i < vlen; i++, m++) {
> -		align =3D max(align, btf__align_of(btf, m->type));
> -	}
> -
> -	return align;
> -}
> -
>  static bool btf_is_struct_packed(const struct btf *btf, __u32 id,
>  				 const struct btf_type *t)
>  {
>  	const struct btf_member *m;
> -	int align, i, bit_sz;
> +	int max_align =3D 1, align, i, bit_sz;
>  	__u16 vlen;
> =20
> -	align =3D btf_natural_align_of(btf, id);
> -	/* size of a non-packed struct has to be a multiple of its alignment */
> -	if (align && (t->size % align) !=3D 0)
> -		return true;
> -
>  	m =3D btf_members(t);
>  	vlen =3D btf_vlen(t);
>  	/* all non-bitfield fields have to be naturally aligned */
>  	for (i =3D 0; i < vlen; i++, m++) {
> -		align =3D btf_natural_align_of(btf, m->type);
> +		align =3D btf__align_of(btf, m->type);
>  		bit_sz =3D btf_member_bitfield_size(t, i);
>  		if (align && bit_sz =3D=3D 0 && m->offset % (8 * align) !=3D 0)
>  			return true;
> +		max_align =3D max(align, max_align);
>  	}
> -
> +	/* size of a non-packed struct has to be a multiple of its alignment */
> +	if (t->size % max_align !=3D 0)
> +		return true;
>  	/*
>  	 * if original struct was marked as packed, but its layout is
>  	 * naturally aligned, we'll detect that it's not packed
> diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_packing=
.c b/tools/testing/selftests/bpf/progs/btf_dump_test_case_packing.c
> index 5c6c62f7ed32..7998f27df7dd 100644
> --- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_packing.c
> +++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_packing.c
> @@ -116,6 +116,23 @@ struct usb_host_endpoint {
>  	long: 0;
>  };
> =20
> +/* ----- START-EXPECTED-OUTPUT ----- */
> +struct nested_packed_struct {
> +	int a;
> +	char b;
> +} __attribute__((packed));
> +
> +struct outer_nonpacked_struct {
> +	short a;
> +	struct nested_packed_struct b;
> +};
> +
> +struct outer_packed_struct {
> +	short a;
> +	struct nested_packed_struct b;
> +} __attribute__((packed));
> +
> +/* ------ END-EXPECTED-OUTPUT ------ */
> =20
>  int f(struct {
>  	struct packed_trailing_space _1;
> @@ -128,6 +145,8 @@ int f(struct {
>  	union jump_code_union _8;
>  	struct outer_implicitly_packed_struct _9;
>  	struct usb_host_endpoint _10;
> +	struct outer_nonpacked_struct _11;
> +	struct outer_packed_struct _12;
>  } *_)
>  {
>  	return 0;

