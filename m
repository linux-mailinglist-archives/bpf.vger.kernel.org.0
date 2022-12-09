Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA976487A2
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 18:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiLIRVP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Dec 2022 12:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLIRVO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Dec 2022 12:21:14 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD4E2EA
        for <bpf@vger.kernel.org>; Fri,  9 Dec 2022 09:21:12 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id t17so13101562eju.1
        for <bpf@vger.kernel.org>; Fri, 09 Dec 2022 09:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l7pfNoy9/vfQaBGj/99E1RpPiX+9ENtc/QBnwgOAynU=;
        b=XR5vONBEXuDx+uoTY+CAh2U2L0cdQ4tT3JIKuIgN7DvryBJ4zdeCbwaawQlXd+vwwq
         TzHu/3yKVTVHek0Vvl23+HErKNKfqxh2daLxm8LTd4fH2x2lCM59CS8WTzAJoBaFGFSh
         D0MunzH1/wC2y4po/l/zIXhKf0QG05F9slDJ/yzPcOjFVnQcKlXuHJHqkhrqErM7utDt
         SLgRRfWIKkEupM2XWa8t/z/js5aJUfv4oS/F1oC1hRqi6IOa2yDChOq4m35gg+b2E1Ma
         PowNGFtV5yvj9fOoQ1FM7kN2cuvvhQyJUtKFr5Rd/oQPm2dsEOBhQ+mTbubXPalD27Gr
         XjhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l7pfNoy9/vfQaBGj/99E1RpPiX+9ENtc/QBnwgOAynU=;
        b=rG4GRqFcOtquh/pUrBP/BBblA7yS6iSRNVaEXmth4mUj0Ac5db3S8jlMCY1Zz4m6eD
         0Bk1UOy0c7GwEJaxwvQGpcrt4XucdZnVEzSSHlz3okeZap8T5pLJS7HY1Y53MTnGDO8e
         H+SxIqRKL2JOYzksEoAl1dPt/lLXaF/WLqSUhD/coAGToEPMewK241gFZIxLABuSMYb5
         PFDejFr0isyjsfpa61DSTuCrqYWvcGpfX0QvsFrahdclU7Nfnl3/VpUgvTsA9tD2usd1
         GLwNwC5mpXONGGU9I6swOWcnWhMFHXRURjm5m4XOwyjAz4dLx+Xy90HHTK5AcpNWlxWb
         Ftqg==
X-Gm-Message-State: ANoB5pldWXd16x/Dgvq0XjHsSVFo4Y68se8dnD5rrxR3LpyCJLFKqdVM
        8QWJEbLljLgeWFuptVOwBds=
X-Google-Smtp-Source: AA0mqf45GEocNsIqpm+cPwirmQB5yMGDPxtHCjJrUYVZehtUYv4rSDcGJrru3RlXdzU90zPkxt1ABA==
X-Received: by 2002:a17:906:70c5:b0:7c1:381c:935d with SMTP id g5-20020a17090670c500b007c1381c935dmr4559420ejk.25.1670606471179;
        Fri, 09 Dec 2022 09:21:11 -0800 (PST)
Received: from [192.168.43.226] (178-133-28-80.mobile.vf-ua.net. [178.133.28.80])
        by smtp.gmail.com with ESMTPSA id ky4-20020a170907778400b007c0ac4e6b6esm136976ejc.143.2022.12.09.09.21.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 09:21:10 -0800 (PST)
Message-ID: <d22b1c3b25e1739a1318df1f619705a66d8f8584.camel@gmail.com>
Subject: Re: [PATCH bpf-next 5/6] libbpf: fix BTF-to-C converter's padding
 logic
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     kernel-team@fb.com,
        Per =?ISO-8859-1?Q?Sundstr=F6m?= XP 
        <per.xp.sundstrom@ericsson.com>
Date:   Fri, 09 Dec 2022 19:21:08 +0200
In-Reply-To: <20221208185703.2681797-6-andrii@kernel.org>
References: <20221208185703.2681797-1-andrii@kernel.org>
         <20221208185703.2681797-6-andrii@kernel.org>
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

On Thu, 2022-12-08 at 10:57 -0800, Andrii Nakryiko wrote:
> Turns out that btf_dump API doesn't handle a bunch of tricky corner
> cases, as reported by Per, and further discovered using his testing
> Python script ([0]).
>=20
> This patch revamps btf_dump's padding logic significantly, making it
> more correct and also avoiding unnecessary explicit padding, where
> compiler would pad naturally. This overall topic turned out to be very
> tricky and subtle, there are lots of subtle corner cases. The comments
> in the code tries to give some clues, but comments themselves are
> supposed to be paired with good understanding of C alignment and padding
> rules. Plus some experimentation to figure out subtle things like
> whether `long :0;` means that struct is now forced to be long-aligned
> (no, it's not, turns out).
>=20
> Anyways, Per's script, while not completely correct in some known
> situations, doesn't show any obvious cases where this logic breaks, so
> this is a nice improvement over the previous state of this logic.
>=20
> Some selftests had to be adjusted to accommodate better use of natural
> alignment rules, eliminating some unnecessary padding, or changing it to
> `type: 0;` alignment markers.
>=20
> Note also that for when we are in between bitfields, we emit explicit
> bit size, while otherwise we use `: 0`, this feels much more natural in
> practice.
>=20
> Next patch will add few more test cases, found through randomized Per's
> script.
>=20
>   [0] https://lore.kernel.org/bpf/85f83c333f5355c8ac026f835b18d15060725fc=
b.camel@ericsson.com/
>=20
> Reported-by: Per Sundstr=C3=B6m XP <per.xp.sundstrom@ericsson.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/lib/bpf/btf_dump.c                      | 169 +++++++++++++-----
>  .../bpf/progs/btf_dump_test_case_bitfields.c  |   2 +-
>  .../bpf/progs/btf_dump_test_case_padding.c    |  58 ++++--
>  3 files changed, 164 insertions(+), 65 deletions(-)
>=20
> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index 234e82334d56..d708452c9952 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -830,6 +830,25 @@ static void btf_dump_emit_type(struct btf_dump *d, _=
_u32 id, __u32 cont_id)
>  	}
>  }
> =20
> +static int btf_natural_align_of(const struct btf *btf, __u32 id)
> +{
> +	const struct btf_type *t =3D btf__type_by_id(btf, id);
> +	int i, align, vlen;
> +	const struct btf_member *m;
> +
> +	if (!btf_is_composite(t))
> +		return btf__align_of(btf, id);
> +
> +	align =3D 1;
> +	m =3D btf_members(t);
> +	vlen =3D btf_vlen(t);
> +	for (i =3D 0; i < vlen; i++, m++) {
> +		align =3D max(align, btf_natural_align_of(btf, m->type));
> +	}
> +
> +	return align;
> +}
> +

The btf_natural_align_of() recursively visits nested structures.
However, the "packed" relation is non-recursive (see entry for
"packed" in [1]). Such mismatch leads to the following example being
printed incorrectly:

	struct a {
		int x;
	};
=09
	struct b {
		struct a a;
		char c;
	} __attribute__((packed));
=09
	struct c {
		struct b b1;
		short a1;
		struct b b2;
	};
=09
The bpftool output looks as follows:

	struct a {
		int x;
	};
=09
	struct b {
		struct a a;
		char c;
	} __attribute__((packed));

	struct c {
		struct b b1;
		short: 0;
		short a1;
		struct b b2;
	} __attribute__((packed));
=09
While offsets are correct the resulting structure size is wrong, as
could be seen using the following program:

	#include <stddef.h>
	#include <stdio.h>
=09
	struct a {
	  int x;
	};
=09
	struct b {
	  struct a a;
	  char c;
	}  __attribute__((packed));
=09
	struct c {
	  struct b b1;
	  short a1;
	  struct b b2;
	};
=09
	struct c1 {
	  struct b b1;
	  short: 0;
	  short a1;
	  struct b b2;
	} __attribute__((packed));
=09
	int main() {
	  printf("sizeof(struct c): %ld\n", sizeof(struct c));
	  printf("a1 offset: %ld\n", offsetof(struct c, a1));
	  printf("b2 offset: %ld\n", offsetof(struct c, b2));
=09
	  printf("sizeof(struct c1): %ld\n", sizeof(struct c1));
	  printf("a1 offset: %ld\n", offsetof(struct c1, a1));
	  printf("b2 offset: %ld\n", offsetof(struct c1, b2));
=09
	  return 0;
	}

The output is:

	$ gcc -Wall test.c
	$ ./a.out=20
	sizeof(struct c): 14
	a1 offset: 6
	b2 offset: 8
	sizeof(struct c1): 13
	a1 offset: 6
	b2 offset: 8

Also the following comment in [2] is interesting:

>  If the member is a structure, then the structure has an alignment
>  of 1-byte, but the members of that structure continue to have their
>  natural alignment.

Which leads to unaligned access in the following case:

	int foo(struct a *p) { return p->x; }
=09
	int main() {
	  struct b b[2] =3D {{ {1}, 2 }, { {3}, 4 }};
	  printf("%i, %i\n", foo(&b[0].a), foo(&b[1].a));
	}

	$ gcc -Wall test.c
	test.c: In function =E2=80=98main=E2=80=99:
	test.c:38:26: warning: taking address of packed member of =E2=80=98struct =
b=E2=80=99 may result
	              in an unaligned pointer value [-Waddress-of-packed-member]
	   38 |   printf("%i, %i\n", foo(&b[0].a), foo(&b[1].a));

(This works fine on my x86 machine, but would be an issue on arm as
 far as I understand).

[1] https://gcc.gnu.org/onlinedocs/gcc-12.2.0/gcc/Common-Type-Attributes.ht=
ml#Common-Type-Attributes
[2] https://developer.arm.com/documentation/100748/0607/writing-optimized-c=
ode/packing-data-structures

>  static bool btf_is_struct_packed(const struct btf *btf, __u32 id,
>  				 const struct btf_type *t)
>  {
> @@ -837,16 +856,16 @@ static bool btf_is_struct_packed(const struct btf *=
btf, __u32 id,
>  	int align, i, bit_sz;
>  	__u16 vlen;
> =20
> -	align =3D btf__align_of(btf, id);
> -	/* size of a non-packed struct has to be a multiple of its alignment*/
> -	if (align && t->size % align)
> +	align =3D btf_natural_align_of(btf, id);
> +	/* size of a non-packed struct has to be a multiple of its alignment */
> +	if (align && (t->size % align) !=3D 0)
>  		return true;
> =20
>  	m =3D btf_members(t);
>  	vlen =3D btf_vlen(t);
>  	/* all non-bitfield fields have to be naturally aligned */
>  	for (i =3D 0; i < vlen; i++, m++) {
> -		align =3D btf__align_of(btf, m->type);
> +		align =3D btf_natural_align_of(btf, m->type);
>  		bit_sz =3D btf_member_bitfield_size(t, i);
>  		if (align && bit_sz =3D=3D 0 && m->offset % (8 * align) !=3D 0)
>  			return true;
> @@ -859,44 +878,97 @@ static bool btf_is_struct_packed(const struct btf *=
btf, __u32 id,
>  	return false;
>  }
> =20
> -static int chip_away_bits(int total, int at_most)
> -{
> -	return total % at_most ? : at_most;
> -}
> -
>  static void btf_dump_emit_bit_padding(const struct btf_dump *d,
> -				      int cur_off, int m_off, int m_bit_sz,
> -				      int align, int lvl)
> +				      int cur_off, int next_off, int next_align,
> +				      bool in_bitfield, int lvl)
>  {
> -	int off_diff =3D m_off - cur_off;
> -	int ptr_bits =3D d->ptr_sz * 8;
> +	const struct {
> +		const char *name;
> +		int bits;
> +	} pads[] =3D {
> +		{"long", d->ptr_sz * 8}, {"int", 32}, {"short", 16}, {"char", 8}
> +	};
> +	int new_off, pad_bits, bits, i;
> +	const char *pad_type;
> +
> +	if (cur_off >=3D next_off)
> +		return; /* no gap */
> +
> +	/* For filling out padding we want to take advantage of
> +	 * natural alignment rules to minimize unnecessary explicit
> +	 * padding. First, we find the largest type (among long, int,
> +	 * short, or char) that can be used to force naturally aligned
> +	 * boundary. Once determined, we'll use such type to fill in
> +	 * the remaining padding gap. In some cases we can rely on
> +	 * compiler filling some gaps, but sometimes we need to force
> +	 * alignment to close natural alignment with markers like
> +	 * `long: 0` (this is always the case for bitfields).  Note
> +	 * that even if struct itself has, let's say 4-byte alignment
> +	 * (i.e., it only uses up to int-aligned types), using `long:
> +	 * X;` explicit padding doesn't actually change struct's
> +	 * overall alignment requirements, but compiler does take into
> +	 * account that type's (long, in this example) natural
> +	 * alignment requirements when adding implicit padding. We use
> +	 * this fact heavily and don't worry about ruining correct
> +	 * struct alignment requirement.
> +	 */
> +	for (i =3D 0; i < ARRAY_SIZE(pads); i++) {
> +		pad_bits =3D pads[i].bits;
> +		pad_type =3D pads[i].name;
> =20
> -	if (off_diff <=3D 0)
> -		/* no gap */
> -		return;
> -	if (m_bit_sz =3D=3D 0 && off_diff < align * 8)
> -		/* natural padding will take care of a gap */
> -		return;
> +		new_off =3D roundup(cur_off, pad_bits);
> +		if (new_off <=3D next_off)
> +			break;
> +	}
> =20
> -	while (off_diff > 0) {
> -		const char *pad_type;
> -		int pad_bits;
> -
> -		if (ptr_bits > 32 && off_diff > 32) {
> -			pad_type =3D "long";
> -			pad_bits =3D chip_away_bits(off_diff, ptr_bits);
> -		} else if (off_diff > 16) {
> -			pad_type =3D "int";
> -			pad_bits =3D chip_away_bits(off_diff, 32);
> -		} else if (off_diff > 8) {
> -			pad_type =3D "short";
> -			pad_bits =3D chip_away_bits(off_diff, 16);
> -		} else {
> -			pad_type =3D "char";
> -			pad_bits =3D chip_away_bits(off_diff, 8);
> +	if (new_off > cur_off && new_off <=3D next_off) {
> +		/* We need explicit `<type>: 0` aligning mark if next
> +		 * field is right on alignment offset and its
> +		 * alignment requirement is less strict than <type>'s
> +		 * alignment (so compiler won't naturally align to the
> +		 * offset we expect), or if subsequent `<type>: X`,
> +		 * will actually completely fit in the remaining hole,
> +		 * making compiler basically ignore `<type>: X`
> +		 * completely.
> +		 */
> +		if (in_bitfield ||
> +		    (new_off =3D=3D next_off && roundup(cur_off, next_align * 8) !=3D =
new_off) ||
> +		    (new_off !=3D next_off && next_off - new_off <=3D new_off - cur_of=
f))
> +			/* but for bitfields we'll emit explicit bit count */
> +			btf_dump_printf(d, "\n%s%s: %d;", pfx(lvl), pad_type,
> +					in_bitfield ? new_off - cur_off : 0);
> +		cur_off =3D new_off;
> +	}
> +
> +	/* Now we know we start at naturally aligned offset for a chosen
> +	 * padding type (long, int, short, or char), and so the rest is just
> +	 * a straightforward filling of remaining padding gap with full
> +	 * `<type>: sizeof(<type>);` markers, except for the last one, which
> +	 * might need smaller than sizeof(<type>) padding.
> +	 */
> +	while (cur_off !=3D next_off) {
> +		bits =3D min(next_off - cur_off, pad_bits);
> +		if (bits =3D=3D pad_bits) {
> +			btf_dump_printf(d, "\n%s%s: %d;", pfx(lvl), pad_type, pad_bits);
> +			cur_off +=3D bits;
> +			continue;
> +		}
> +		/* For the remainder padding that doesn't cover entire
> +		 * pad_type bit length, we pick the smallest necessary type.
> +		 * This is pure aesthetics, we could have just used `long`,
> +		 * but having smallest necessary one communicates better the
> +		 * scale of the padding gap.
> +		 */
> +		for (i =3D ARRAY_SIZE(pads) - 1; i >=3D 0; i--) {
> +			pad_type =3D pads[i].name;
> +			pad_bits =3D pads[i].bits;
> +			if (pad_bits < bits)
> +				continue;
> +
> +			btf_dump_printf(d, "\n%s%s: %d;", pfx(lvl), pad_type, bits);
> +			cur_off +=3D bits;
> +			break;
>  		}
> -		btf_dump_printf(d, "\n%s%s: %d;", pfx(lvl), pad_type, pad_bits);
> -		off_diff -=3D pad_bits;
>  	}
>  }
> =20
> @@ -916,9 +988,11 @@ static void btf_dump_emit_struct_def(struct btf_dump=
 *d,
>  {
>  	const struct btf_member *m =3D btf_members(t);
>  	bool is_struct =3D btf_is_struct(t);
> -	int align, i, packed, off =3D 0;
> +	bool packed, prev_bitfield =3D false;
> +	int align, i, off =3D 0;
>  	__u16 vlen =3D btf_vlen(t);
> =20
> +	align =3D btf__align_of(d->btf, id);
>  	packed =3D is_struct ? btf_is_struct_packed(d->btf, id, t) : 0;
> =20
>  	btf_dump_printf(d, "%s%s%s {",
> @@ -928,33 +1002,36 @@ static void btf_dump_emit_struct_def(struct btf_du=
mp *d,
> =20
>  	for (i =3D 0; i < vlen; i++, m++) {
>  		const char *fname;
> -		int m_off, m_sz;
> +		int m_off, m_sz, m_align;
> +		bool in_bitfield;
> =20
>  		fname =3D btf_name_of(d, m->name_off);
>  		m_sz =3D btf_member_bitfield_size(t, i);
>  		m_off =3D btf_member_bit_offset(t, i);
> -		align =3D packed ? 1 : btf__align_of(d->btf, m->type);
> +		m_align =3D packed ? 1 : btf__align_of(d->btf, m->type);
> +
> +		in_bitfield =3D prev_bitfield && m_sz !=3D 0;
> =20
> -		btf_dump_emit_bit_padding(d, off, m_off, m_sz, align, lvl + 1);
> +		btf_dump_emit_bit_padding(d, off, m_off, m_align, in_bitfield, lvl + 1=
);
>  		btf_dump_printf(d, "\n%s", pfx(lvl + 1));
>  		btf_dump_emit_type_decl(d, m->type, fname, lvl + 1);
> =20
>  		if (m_sz) {
>  			btf_dump_printf(d, ": %d", m_sz);
>  			off =3D m_off + m_sz;
> +			prev_bitfield =3D true;
>  		} else {
>  			m_sz =3D max((__s64)0, btf__resolve_size(d->btf, m->type));
>  			off =3D m_off + m_sz * 8;
> +			prev_bitfield =3D false;
>  		}
> +
>  		btf_dump_printf(d, ";");
>  	}
> =20
>  	/* pad at the end, if necessary */
> -	if (is_struct) {
> -		align =3D packed ? 1 : btf__align_of(d->btf, id);
> -		btf_dump_emit_bit_padding(d, off, t->size * 8, 0, align,
> -					  lvl + 1);
> -	}
> +	if (is_struct)
> +		btf_dump_emit_bit_padding(d, off, t->size * 8, align, false, lvl + 1);
> =20
>  	/*
>  	 * Keep `struct empty {}` on a single line,
> diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_bitfiel=
ds.c b/tools/testing/selftests/bpf/progs/btf_dump_test_case_bitfields.c
> index e5560a656030..e01690618e1e 100644
> --- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_bitfields.c
> +++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_bitfields.c
> @@ -53,7 +53,7 @@ struct bitfields_only_mixed_types {
>   */
>  /* ------ END-EXPECTED-OUTPUT ------ */
>  struct bitfield_mixed_with_others {
> -	long: 4; /* char is enough as a backing field */
> +	char: 4; /* char is enough as a backing field */
>  	int a: 4;
>  	/* 8-bit implicit padding */
>  	short b; /* combined with previous bitfield */
> diff --git a/tools/testing/selftests/bpf/progs/btf_dump_test_case_padding=
.c b/tools/testing/selftests/bpf/progs/btf_dump_test_case_padding.c
> index 7cb522d22a66..6f963d34c45b 100644
> --- a/tools/testing/selftests/bpf/progs/btf_dump_test_case_padding.c
> +++ b/tools/testing/selftests/bpf/progs/btf_dump_test_case_padding.c
> @@ -19,7 +19,7 @@ struct padded_implicitly {
>  /*
>   *struct padded_explicitly {
>   *	int a;
> - *	int: 32;
> + *	long: 0;
>   *	int b;
>   *};
>   *
> @@ -28,41 +28,28 @@ struct padded_implicitly {
> =20
>  struct padded_explicitly {
>  	int a;
> -	int: 1; /* algo will explicitly pad with full 32 bits here */
> +	int: 1; /* algo will emit aligning `long: 0;` here */
>  	int b;
>  };
> =20
>  /* ----- START-EXPECTED-OUTPUT ----- */
> -/*
> - *struct padded_a_lot {
> - *	int a;
> - *	long: 32;
> - *	long: 64;
> - *	long: 64;
> - *	int b;
> - *};
> - *
> - */
> -/* ------ END-EXPECTED-OUTPUT ------ */
> -
>  struct padded_a_lot {
>  	int a;
> -	/* 32 bit of implicit padding here, which algo will make explicit */
>  	long: 64;
>  	long: 64;
>  	int b;
>  };
> =20
> +/* ------ END-EXPECTED-OUTPUT ------ */
> +
>  /* ----- START-EXPECTED-OUTPUT ----- */
>  /*
>   *struct padded_cache_line {
>   *	int a;
> - *	long: 32;
>   *	long: 64;
>   *	long: 64;
>   *	long: 64;
>   *	int b;
> - *	long: 32;
>   *	long: 64;
>   *	long: 64;
>   *	long: 64;
> @@ -85,7 +72,7 @@ struct padded_cache_line {
>   *struct zone {
>   *	int a;
>   *	short b;
> - *	short: 16;
> + *	long: 0;
>   *	struct zone_padding __pad__;
>   *};
>   *
> @@ -108,6 +95,39 @@ struct padding_wo_named_members {
>  	long: 64;
>  };
> =20
> +struct padding_weird_1 {
> +	int a;
> +	long: 64;
> +	short: 16;
> +	short b;
> +};
> +
> +/* ------ END-EXPECTED-OUTPUT ------ */
> +
> +/* ----- START-EXPECTED-OUTPUT ----- */
> +/*
> + *struct padding_weird_2 {
> + *	long: 56;
> + *	char a;
> + *	long: 56;
> + *	char b;
> + *	char: 8;
> + *};
> + *
> + */
> +/* ------ END-EXPECTED-OUTPUT ------ */
> +struct padding_weird_2 {
> +	int: 32;	/* these paddings will be collapsed into `long: 56;` */
> +	short: 16;
> +	char: 8;
> +	char a;
> +	int: 32;	/* these paddings will be collapsed into `long: 56;` */
> +	short: 16;
> +	char: 8;
> +	char b;
> +	char: 8;
> +};
> +
>  /* ------ END-EXPECTED-OUTPUT ------ */
> =20
>  int f(struct {
> @@ -117,6 +137,8 @@ int f(struct {
>  	struct padded_cache_line _4;
>  	struct zone _5;
>  	struct padding_wo_named_members _6;
> +	struct padding_weird_1 _7;
> +	struct padding_weird_2 _8;
>  } *_)
>  {
>  	return 0;

