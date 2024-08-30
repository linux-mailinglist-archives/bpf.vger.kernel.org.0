Return-Path: <bpf+bounces-38589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5D496687B
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 19:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D9E01F23F9C
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 17:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1DD1BBBC9;
	Fri, 30 Aug 2024 17:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFlG3bIZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD691BB6BD
	for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 17:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725040602; cv=none; b=frKzsLOIvivXVfPeIn6KoyeP7oOMurKGlUqcpQdFBoCL0N2ChMaBbjT1mqnFQUQlzdZfoPsHaUw2Drj8P75dKP464m9sBiZO/Bt2wrxESdVOh3esm+etH+vyA8kQ8/d8AAa7lRGmANr1rN7DTK2byY3/1F12A71+vOuARZ5ptlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725040602; c=relaxed/simple;
	bh=GMAzhJKWV6mvym5/zBUD/yfvV8UgBjXw7W3ik/L/5EU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=njoPlpr6pnyM5/U4s7QxNozyX4QCZkqaC9fVxOBTCVWSrFFTowE2Av0p9dwtFVmyYUm8you+8AuwwfodTTyZZ71CTxxdRtHCGZMBvxdFPX7ouF7woqU2XqNz3hJAmFu+WpWPMckvGkl6muRqaV3YIry4ptFGnU0VI0ejzprvfgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFlG3bIZ; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7cd8d2731d1so1456687a12.3
        for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 10:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725040600; x=1725645400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LR5XJcgqMhm5Q/Ia7ZKjX7hMdZWLiiPv+aAxJeCp3M=;
        b=MFlG3bIZ1oggPRNSzT70EeZBxWqXFMq2Ts2ahxFS/SnBWs/qbB+aW8k+uRJ5g2cMFh
         mUsju+BlvNqDanyT7UnpxStK18KRLUeSUmaa+4OF1Lp+5yrBagzGq00uf18LtNdQNFRY
         dgkkGS7P489ezTMxQyFPQOqQEjeqHT0ImWL6xxX6tZ28a9OQCXtRe5Lf8/gmLqnZYM6y
         PtIUHNFH2YtLjmSS4TLL2qxEzefR23Pq9il7KMNT7dNhylxN0XJCfkZ0ri4yQQn5DST4
         48gbxmC5iBMaR8JGqPg7N2CTM2YJnKt8d8CBzPJpaRkANT6SKuw81S0sfCPwW1gYI2ly
         1vVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725040600; x=1725645400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4LR5XJcgqMhm5Q/Ia7ZKjX7hMdZWLiiPv+aAxJeCp3M=;
        b=vaPvOFpu0YiK2Nt/lXlB6i/yL+QguPQaM8qijNhGAC/blPBFqhe0eOFGeNRRzf+oWn
         2WijUH3gZnZ0hqtMf128lvARA1V9zpfbyHLp+S3uGarhgMio18LHyIkblZMvY2Big89h
         zr78mK9dNrQ4Rqziz7Jxg54uPizyQwxf8nFzCIOTmlJd3OPv9p/LhWAnnpSpw4mMh8xz
         7j0O/FuEbi2rHgSv39AvSk8GBzhCiPyJEKcEbncs5sxVikN2y1j4NxKCSTi36mL3zGrC
         WO2q/UMDOUxl3bTqwGWBloPI21vM5QcuNzc4wUpiJ5sx/0fZswLDrb3UVGG3GvZVC25C
         HIhw==
X-Forwarded-Encrypted: i=1; AJvYcCXNv8TAby33SZuXDYJPKYwQr4wo5KN3pR6JiSW2GJSQ37GY2Rl8cNkRV1gLZslcUn+eNd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGs35wwEiE1w4rVjZpxsspid2FBUvySi2/AwmzQtrEB2Qt0FWL
	BTpmblY1s80wk7whiIacaY1elg4r8zpGg4PcOsjc46J7oT4YQo4z6eesIJD55HXHTbc4NmDwDxr
	PL0gWywoIIWTPNrocgPmYTeIpBbY=
X-Google-Smtp-Source: AGHT+IGDA5waLY077sXEaKmEln2+9hR/okDjwOA5vrO2YgocNdMV/KZJB6FEyC255k7MyBw6DAU8v6mlZDJ5BngISaM=
X-Received: by 2002:a17:90b:4c09:b0:2c6:ee50:5af4 with SMTP id
 98e67ed59e1d1-2d85618aabdmr7449958a91.6.1725040600008; Fri, 30 Aug 2024
 10:56:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830173406.1581007-1-eddyz87@gmail.com> <e3cd9ac9-2c19-454e-833c-08c4ad450b77@oracle.com>
In-Reply-To: <e3cd9ac9-2c19-454e-833c-08c4ad450b77@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 30 Aug 2024 10:56:28 -0700
Message-ID: <CAEf4BzbWHFK-cLN+doN1FVCaYoOUmRGdcpOknBSTT_kyGGb70g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: check if distilled base inherits
 source endianness
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev, tony.ambardar@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 10:54=E2=80=AFAM Alan Maguire <alan.maguire@oracle.=
com> wrote:
>
> On 30/08/2024 18:34, Eduard Zingerman wrote:
> > Create a BTF with endianness different from host, make a distilled
> > base/split BTF pair from it, dump as raw bytes, import again and
> > verify that endianness is preserved.
> >
> > Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
>
> One small thing below, but
>
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> Tested-by: Alan Maguire <alan.maguire@oracle.com>

will add and force-push, thanks

>
> Thanks!
>
> > ---
> >  .../selftests/bpf/prog_tests/btf_distill.c    | 73 +++++++++++++++++++
> >  1 file changed, 73 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/btf_distill.c b/too=
ls/testing/selftests/bpf/prog_tests/btf_distill.c
> > index bfbe795823a2..810b2e434562 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/btf_distill.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/btf_distill.c
> > @@ -535,6 +535,77 @@ static void test_distilled_base_vmlinux(void)
> >       btf__free(vmlinux_btf);
> >  }
> >
> > +static bool is_host_big_endian(void)
> > +{
> > +     return htons(0x1234) =3D=3D 0x1234;
> > +}
> > +
> > +/* Split and new base BTFs should inherit endianness from source BTF. =
*/
> > +static void test_distilled_endianness(void)
> > +{
> > +     struct btf *base =3D NULL, *split =3D NULL, *new_base =3D NULL, *=
new_split =3D NULL;
> > +     struct btf *new_base1 =3D NULL, *new_split1 =3D NULL;
> > +     enum btf_endianness inverse_endianness;
> > +     const void *raw_data;
> > +     __u32 size;
> > +
> > +     printf("is_host_big_endian? %d\n", is_host_big_endian());
> > +     inverse_endianness =3D is_host_big_endian() ? BTF_LITTLE_ENDIAN :=
 BTF_BIG_ENDIAN;
> > +     base =3D btf__new_empty();
>
>
> nit: I think you could avoid the need for is_host_big_endian() by doing
> this:
>
> inverse_endianness =3D btf__endianness(base) =3D=3D BTF_LITTLE_ENDIAN ?
>                      BTF_BIG_ENDIAN : BTF_LITTLE_ENDIAN;

good point, I'll fix it up

>
>
> > +     btf__set_endianness(base, inverse_endianness);
> > +     if (!ASSERT_OK_PTR(base, "empty_main_btf"))
> > +             return;
> > +     btf__add_int(base, "int", 4, BTF_INT_SIGNED);   /* [1] int */
> > +     VALIDATE_RAW_BTF(
> > +             base,
> > +             "[1] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 enco=
ding=3DSIGNED");
> > +     split =3D btf__new_empty_split(base);
> > +     if (!ASSERT_OK_PTR(split, "empty_split_btf"))
> > +             goto cleanup;
> > +     btf__add_ptr(split, 1);
> > +     VALIDATE_RAW_BTF(
> > +             split,
> > +             "[1] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 enco=
ding=3DSIGNED",
> > +             "[2] PTR '(anon)' type_id=3D1");
> > +     if (!ASSERT_EQ(0, btf__distill_base(split, &new_base, &new_split)=
,
> > +                    "distilled_base") ||
> > +         !ASSERT_OK_PTR(new_base, "distilled_base") ||
> > +         !ASSERT_OK_PTR(new_split, "distilled_split") ||
> > +         !ASSERT_EQ(2, btf__type_cnt(new_base), "distilled_base_type_c=
nt"))
> > +             goto cleanup;
> > +     VALIDATE_RAW_BTF(
> > +             new_split,
> > +             "[1] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 enco=
ding=3DSIGNED",
> > +             "[2] PTR '(anon)' type_id=3D1");
> > +
> > +     raw_data =3D btf__raw_data(new_base, &size);
> > +     if (!ASSERT_OK_PTR(raw_data, "btf__raw_data #1"))
> > +             goto cleanup;
> > +     new_base1 =3D btf__new(raw_data, size);
> > +     if (!ASSERT_OK_PTR(new_base1, "new_base1 =3D btf__new()"))
> > +             goto cleanup;
> > +     raw_data =3D btf__raw_data(new_split, &size);
> > +     if (!ASSERT_OK_PTR(raw_data, "btf__raw_data #2"))
> > +             goto cleanup;
> > +     new_split1 =3D btf__new_split(raw_data, size, new_base1);
> > +     if (!ASSERT_OK_PTR(new_split1, "new_split1 =3D btf__new()"))
> > +             goto cleanup;
> > +
> > +     ASSERT_EQ(btf__endianness(new_base1), inverse_endianness, "new_ba=
se1 endianness");
> > +     ASSERT_EQ(btf__endianness(new_split1), inverse_endianness, "new_s=
plit1 endianness");
> > +     VALIDATE_RAW_BTF(
> > +             new_split1,
> > +             "[1] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 enco=
ding=3DSIGNED",
> > +             "[2] PTR '(anon)' type_id=3D1");
> > +cleanup:
> > +     btf__free(new_split1);
> > +     btf__free(new_base1);
> > +     btf__free(new_split);
> > +     btf__free(new_base);
> > +     btf__free(split);
> > +     btf__free(base);
> > +}
> > +
> >  void test_btf_distill(void)
> >  {
> >       if (test__start_subtest("distilled_base"))
> > @@ -549,4 +620,6 @@ void test_btf_distill(void)
> >               test_distilled_base_multi_err2();
> >       if (test__start_subtest("distilled_base_vmlinux"))
> >               test_distilled_base_vmlinux();
> > +     if (test__start_subtest("distilled_endianness"))
> > +             test_distilled_endianness();
> >  }

