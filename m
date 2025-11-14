Return-Path: <bpf+bounces-74495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C21B5C5C589
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 10:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 793943ACEA7
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 09:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2213081B2;
	Fri, 14 Nov 2025 09:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZicUMhgG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73159235358
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 09:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763113470; cv=none; b=EL12yhEcEpGmv0woIvsyrBsSeLY3QyB9mUjK7W++Bmekkd8vbl8P+yx/Hvw+mswlhiHlugtigh0TJKZHfaKx+tmXgfV/6hPsVBoCewFmr0iQZLeEGDsu7Spdg6kegz+Umx4pARMHJaP9czqJMF94pQgYQLnaBlzAfu5qpTE/kGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763113470; c=relaxed/simple;
	bh=WLyAJinJpwSJGxw00T5r2Njx39P23VObMwvbrfa0x3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OYwV6b9Qx3aiipdgkh6b3b4Ncl6w2pq8GUYxfrwZa9W+Sx76akTP1pgiM0Y2FD9jp0XBx/fVZLS+QEMXP9iH3/YCtdH771b1iclYoBIKTyBT8DaA9bQbcJ+eXBes2+4TwdJVr6R+Yn/6k4ZFzAQN/Ya8uymPv4hFXFfOAWZy49M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZicUMhgG; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b737502f77bso7834466b.2
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 01:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763113467; x=1763718267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oycy26d5ri9QE6bUeHq9Rl/2Qkr0ro1WWRzDIGBVqp4=;
        b=ZicUMhgG3leILfBEtoniwbnihePXp21KylEUWrn3MnPF2+4Btz83n4na2JRn0XMnuB
         /dYdKekQ/0ZMcm8mieOfDh3Lq2hozqTJNJM2DdT3EVVk5Y1f+W5BgxcpTEesp6/ekwlp
         F/kn8DBi+Yod2jEJ0z7WpZ6/AhI88SaTRZoAJD1+b9Jye1s0ht7n//5/zmZNbpkmv6HX
         SPo1RUBXHmnGi/KDK1q4Yq06VT8MDXlIT9wTQhgYkMsQsWT3r1gZKmcSGNRAyFul+D8X
         UkXR0K0+a8j9pFumZ4tIxqD3sSSmjWXzyRZ/TAoWDJ2BSE1c/r376rGnUOlnHfDHqgW2
         l1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763113467; x=1763718267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oycy26d5ri9QE6bUeHq9Rl/2Qkr0ro1WWRzDIGBVqp4=;
        b=VTbbR/F14hRNeWOO0kZw+rrNlXTrZI5wUAiMbXGGszrWhCAauwnBEg5OBmQPf9nH9i
         kqNpfnSr+meAUZYG4crkrKw4MbNapK8QobXON2pc6OKg5IKDA2F5i5svaPP8ozEHBLYt
         ++YYtELCS9kqWsC85oFVfednMmj7b//ONUodfHg1OvgG33oDstUsOyOeNvhrSEHokIRn
         WHLWr8KBixT7Dv3QVDyEbjBAlLIBytkpQnkju33W94k/pD9TjLUS5ulyVck0xzGhaZ9g
         faNRU5vEtILWjDuzt3pP1ohk7GcoTLICCV3ONOOIfbbeWlg+3Lmpb9yvjb6DcW+dDTSI
         h1HQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvAaOwqVtAQNAjQO06VFwwRNkT3trmW3Mppcd+sgE1qoBs3DfMP8SW1RdxZS2q1T64IUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO3EojcOzftQy2RwAuVgAQaOepd12tIzPeovxx/spy0Tsfmcox
	bT0imxuZTGYduiKgzyb7UjUPcYDnrytXgcUCpmr0gszGHW1+HOXmjC6Ek65AfHconsZv+VzUmzA
	uzwXIqNsyjf5khpMSAj+/JYwReHfhyB0=
X-Gm-Gg: ASbGncsV7wsyB3MejLiJxYD8SHq1Q27jhCUhMGYSh8Pm9uNDYaz/etPKsKDO2zs1rCe
	vDmeP7yjcZlLdLQ1N3Nr/0NU3CE9wzjw0B3GTBpFL1L3oyZbPaDtAjFPuG/0C3K2fVyN0phVqsC
	VQJfNdCeZI9SBDhgqDgP9R0i8pEYbhoLP3Y9ixotGcpXyKtNcuX/cW/nNeHqhuc6P8c+0RApnlQ
	6d4e4l3HF4vaSlTmG1pI+QsOaDFzh1TVls/mXt7jh7KduzLIVfOxa7GuLArVg==
X-Google-Smtp-Source: AGHT+IGZh2PQN6YWuZChMLI2tLB4HB+dE1MDgGr44rLY76YbDMrN+OdRVr04AGpw9sDwoPn3vs9F0ZpLDdC+eEkSWWU=
X-Received: by 2002:a17:907:3f97:b0:b45:b1f2:fac0 with SMTP id
 a640c23a62f3a-b7367829f0emr217015166b.29.1763113466538; Fri, 14 Nov 2025
 01:44:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114090231.2786984-3-dolinux.peng@gmail.com> <39c391d944fa3db4426d0c1f9b4a22ccd1660133231a02efbcb78e0b55ac84b2@mail.kernel.org>
In-Reply-To: <39c391d944fa3db4426d0c1f9b4a22ccd1660133231a02efbcb78e0b55ac84b2@mail.kernel.org>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Fri, 14 Nov 2025 17:44:13 +0800
X-Gm-Features: AWmQ_blcyJWaRigfkDB3Gn8DQNP2eZFdLuVnTU-GeoMH4mcudpzc4s5xehN7Mjs
Message-ID: <CAErzpmu9ZTfg_dWns-LCiwRy1PRvjYvtzf_15Om9=9TwBnnM9w@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] selftests/bpf: Add test cases for btf__permute functionality
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, eddyz87@gmail.com, andrii.nakryiko@gmail.com, 
	zhangxiaoqin@xiaomi.com, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin@xiaomi.com, alan.maguire@oracle.com, song@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org, 
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 5:39=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/btf_permute.c b/too=
ls/testing/selftests/bpf/prog_tests/btf_permute.c
> > new file mode 100644
> > index 000000000..c1a47b846
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/btf_permute.c
>
> [ ... ]
>
> > @@ -0,0 +1,626 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/* Copyright (c) 2025 Xiaomi */
> > +
> > +#include <test_progs.h>
> > +#include <bpf/btf.h>
> > +#include "btf_helpers.h"
>
> [ ... ]
>
> > +/* Verify btf__permute then btf__dedup work correctly */
> > +static void test_permute_drop_dedup(void)
> > +{
> > +     struct btf *btf, *new_btf;
>                               ^^^^^^^^
> Can this crash if the test fails before new_btf is initialized?  Looking
> at the declaration above, new_btf is uninitialized, and if ASSERT_EQ()
> fails at line 570 before new_btf is assigned, the code jumps to the done
> label which calls btf__free(new_btf). While btf__free() checks for NULL,
> it doesn't protect against uninitialized garbage values and may
> dereference an invalid pointer.

Thanks, I will fix it.

>
> > +     const struct btf_header *hdr;
> > +     const void *btf_data;
> > +     char expect_strs[] =3D "\0int\0s1\0m\0tag1\0tag2\0tag3";
> > +     char expect_strs_dedupped[] =3D "\0int\0s1\0m\0tag1";
> > +     __u32 permute_ids[6], btf_size;
> > +     int err;
> > +
> > +     btf =3D btf__new_empty();
> > +     if (!ASSERT_OK_PTR(btf, "empty_main_btf"))
> > +             return;
> > +
> > +     btf__add_int(btf, "int", 4, BTF_INT_SIGNED);    /* [1] int */
> > +     btf__add_struct(btf, "s1", 4);                  /* [2] struct s1 =
{ */
> > +     btf__add_field(btf, "m", 1, 0, 0);              /*       int m; *=
/
> > +                                                     /* } */
> > +     btf__add_decl_tag(btf, "tag1", 2, -1);          /* [3] tag -> s1:=
 tag1 */
> > +     btf__add_decl_tag(btf, "tag2", 2, 1);           /* [4] tag -> s1/=
m: tag2 */
> > +     btf__add_decl_tag(btf, "tag3", 2, 1);           /* [5] tag -> s1/=
m: tag3 */
> > +
> > +     VALIDATE_RAW_BTF(
> > +             btf,
> > +             "[1] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 enco=
ding=3DSIGNED",
> > +             "[2] STRUCT 's1' size=3D4 vlen=3D1\n"
> > +             "\t'm' type_id=3D1 bits_offset=3D0",
> > +             "[3] DECL_TAG 'tag1' type_id=3D2 component_idx=3D-1",
> > +             "[4] DECL_TAG 'tag2' type_id=3D2 component_idx=3D1",
> > +             "[5] DECL_TAG 'tag3' type_id=3D2 component_idx=3D1");
> > +
> > +     btf_data =3D btf__raw_data(btf, &btf_size);
> > +     hdr =3D btf_data;
> > +     if (!ASSERT_EQ(hdr->str_len, ARRAY_SIZE(expect_strs), "expect_str=
s"))
>                ^^^^^^^^^^^^^^
> Does this need a NULL check for btf_data?  The btf__raw_data() function
> can return NULL on allocation failure (returns NULL at btf.c:1596), and
> dereferencing hdr->str_len without checking would cause a segfault and
> crash the test program.

Thanks, I will fix it.

>
> > +             goto done;
> > +
> > +     new_btf =3D btf__new(btf_data, btf_size);
> > +     if (!ASSERT_OK_PTR(new_btf, "btf__new"))
> > +             goto done;
> > +
> > +     /* Drop 2 IDs result in unreferenced strings */
> > +     permute_ids[0] =3D 0;
> > +     permute_ids[1] =3D 3; /* [1] -> [3] */
> > +     permute_ids[2] =3D 1; /* [2] -> [1] */
> > +     permute_ids[3] =3D 2; /* [3] -> [2] */
> > +     permute_ids[4] =3D 0; /* Drop result in unreferenced "tag2" */
> > +     permute_ids[5] =3D 0; /* Drop result in unreferenced "tag3" */
> > +     err =3D btf__permute(new_btf, permute_ids, ARRAY_SIZE(permute_ids=
), NULL);
> > +     if (!ASSERT_OK(err, "btf__permute"))
> > +             goto done;
> > +
> > +     VALIDATE_RAW_BTF(
> > +             new_btf,
> > +             "[1] STRUCT 's1' size=3D4 vlen=3D1\n"
> > +             "\t'm' type_id=3D3 bits_offset=3D0",
> > +             "[2] DECL_TAG 'tag1' type_id=3D1 component_idx=3D-1",
> > +             "[3] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 enco=
ding=3DSIGNED");
> > +
> > +     btf_data =3D btf__raw_data(new_btf, &btf_size);
> > +     hdr =3D btf_data;
> > +     if (!ASSERT_EQ(hdr->str_len, ARRAY_SIZE(expect_strs), "expect_str=
s"))
>                ^^^^^^^^^^^^^^
> Same NULL check issue here with btf__raw_data().

Thanks, I will fix it.

>
> > +             goto done;
> > +
> > +     err =3D btf__dedup(new_btf, NULL);
> > +     if (!ASSERT_OK(err, "btf__dedup"))
> > +             goto done;
> > +
> > +     btf_data =3D btf__raw_data(new_btf, &btf_size);
> > +     hdr =3D btf_data;
> > +     if (!ASSERT_EQ(hdr->str_len, ARRAY_SIZE(expect_strs_dedupped), "e=
xpect_strs_dedupped"))
>                ^^^^^^^^^^^^^^
> And again here.

Thanks, I will fix it.

>
> > +             goto done;
> > +
> > +done:
> > +     btf__free(btf);
> > +     btf__free(new_btf);
> > +}
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/193599=
45665

