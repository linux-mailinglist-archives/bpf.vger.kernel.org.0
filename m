Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A284764D494
	for <lists+bpf@lfdr.de>; Thu, 15 Dec 2022 01:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbiLOAUd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 19:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiLOATm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 19:19:42 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F246147
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 16:19:39 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id z26so13174917lfu.8
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 16:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EMl2OEc9EUmzv+kmM8p3TiYt8JF0be+c6ViQGAalmrM=;
        b=j+Q4nq5LhKep5w8csZD+6NSgQ4jCoJ4M6bTb2t0ZvH+cYaaQqQ0gMJzLcKEHhdUIdE
         HOBjSxbb/46y1jvJoO4d54Ox+xTTQGTvlQvVn71JL5aD/+ErJBairS9GL1NrFOp/31+c
         QuMOmLyjrk1O5rlJ5FqfbbwTcA3ubwyd7AZ2J0EEFIT8kwYAQAPWvRJ54SYvesP/KRrM
         vgQLzrQm91t/UOPVZdi0F3Q4hUncy6d9zRNmjcJwMEtu17ilWD2mLuknfMLfon0TT9o6
         HEFC7Eifu0/jmU547ZyEqmP5Q8ifI+gJU19u2xF6N7yNrJEtkTDenoeOkV5DV8YndEM0
         T18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EMl2OEc9EUmzv+kmM8p3TiYt8JF0be+c6ViQGAalmrM=;
        b=3MsCJnIjY/9mXimfyF7m/wIRqdF8vyns/D74JP8SZG9CjtnMvl2elQJRZSLm7RwCXj
         mB7HED6kK+opB9+j6XK8QNRumcqY41RlDGBOclS3CAgkV7gqMb3BN9pKJs6E6AxqVL6n
         eRofXyYRgWxcQTu7CS4kak1jgXleB8yAwQW4IcWy2uusTyG1/y57FFwMv34H9XT/phe0
         RJRyv0J+eMIRUcTF7O57d9f2by/yFKioKd2Z3Wah4ivOxQLNZHi8ugGlMr/HuMjlLzFq
         scqL9DRRE895Jqrj2U0HwlGlZPpqdpN8mUj253JkUVrrtF+2wKKP0jVShucz6CSBPFjA
         AzRw==
X-Gm-Message-State: AFqh2kpq2Z4qCZRovesEM2G9Wyrjzfl3UJisnCIKtRwt4tH00vLzUr/F
        8tPknz21AbYlsy5EJubCkW4=
X-Google-Smtp-Source: AMrXdXuPUjKyIV07vLkyMp8Pc7yJ7KkrCGERre/iqgNSqBPvNrXbUXXD7XzHbCIXIeO5leE4LIW+cg==
X-Received: by 2002:ac2:509a:0:b0:4b9:f5e5:8fb4 with SMTP id f26-20020ac2509a000000b004b9f5e58fb4mr947646lfm.3.1671063578005;
        Wed, 14 Dec 2022 16:19:38 -0800 (PST)
Received: from [192.168.1.113] (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id b12-20020a0565120b8c00b0048a8c907fe9sm981640lfv.167.2022.12.14.16.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 16:19:37 -0800 (PST)
Message-ID: <0a1f4677cf72f2a75b5acafc3a48df16d530e0e6.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 5/6] libbpf: fix BTF-to-C converter's
 padding logic
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     kernel-team@fb.com,
        Per =?ISO-8859-1?Q?Sundstr=F6m?= XP 
        <per.xp.sundstrom@ericsson.com>
Date:   Thu, 15 Dec 2022 02:19:34 +0200
In-Reply-To: <20221212211505.558851-6-andrii@kernel.org>
References: <20221212211505.558851-1-andrii@kernel.org>
         <20221212211505.558851-6-andrii@kernel.org>
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

On Mon, 2022-12-12 at 13:15 -0800, Andrii Nakryiko wrote:
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
> index 234e82334d56..d6fd93a57f11 100644
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
> +		align =3D max(align, btf__align_of(btf, m->type));
> +	}
> +
> +	return align;
> +}
> +
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

Sorry, I'm late to the party...

I think that this call to btf__align_of() should remain as is,
otherwise the packed-ness of the m->type is ignored, which leads to
the example below generating unnecessary packed annotation, which in
turn leads to wrong result of sizeof() if asked.
Reverting this hunk makes the test below work as expected and
no other tests break.

02:02:44 tmp$ cat test.c=20
#ifndef __BPF__

#include <stddef.h>
#include <stdio.h>

#endif /* __BPF__ */

struct a {
  int x;
  char y;
}  __attribute__((packed));

struct b {
  short x;
  struct a a;
};

#ifdef __BPF__

int root(struct b *b) { return 7; }

#else /* __BPF__ */

struct b1 {
  short x;
  struct a a;
} __attribute__((packed));

int main() {
  printf("sizeof(struct b ): %ld\n", sizeof(struct b));
  printf("sizeof(struct b1): %ld\n", sizeof(struct b1));
}

#endif /* __BPF__ */

02:04:24 tmp$ clang test.c && ./a.out
sizeof(struct b ): 8
sizeof(struct b1): 7

02:04:30 tmp$ clang -target bpf -g -c test.c -o test.o && bpftool btf dump =
file ./test.o format c
#ifndef __VMLINUX_H__
#define __VMLINUX_H__

#ifndef BPF_NO_PRESERVE_ACCESS_INDEX
#pragma clang attribute push (__attribute__((preserve_access_index)), apply=
_to =3D record)
#endif

struct a {
	int x;
	char y;
} __attribute__((packed));

struct b {
	short x;
	struct a a;
} __attribute__((packed));

#ifndef BPF_NO_PRESERVE_ACCESS_INDEX
#pragma clang attribute pop
#endif

#endif /* __VMLINUX_H__ */

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

