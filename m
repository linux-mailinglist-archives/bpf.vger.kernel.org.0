Return-Path: <bpf+bounces-38585-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC70966869
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 19:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07E10281509
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 17:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6471BB6A4;
	Fri, 30 Aug 2024 17:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKEi81Yd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DC114E2E9
	for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 17:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725040323; cv=none; b=nomgLlFjAbqrU4W0mS4V2eKZDodtN/kwn3bFDzxQ4vREDzjKjqUtDNeW78prIVZ/z8aHKWNh8EPZSwv48Lq3+Ynex6KhRsBzbsUSyLIhArb/ALJKKOan5vA02IQv0Ay2r12gD3ER8C3tjAeCkIS8lKpgBIK81gm1/5OwPifz3Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725040323; c=relaxed/simple;
	bh=uRR+iSgW2XWqtGKq9ZumpJ37s6OBjLY3EsOg7iRt0CM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wa+DidbiVDMTnyUQrJHnd3jddaEAMlNDsf7wZLO2GMyAlA+MW2lPPZZobAtH02U+lEt0b4YKcS8dHBx1lSn+gf+rjnjmftcrV7fuMjFalQFXNXqlXXgQuqtJ3vEidinJ1940vpVKBTm5xpCQLKEt78LABPqmIWyBidoJ+8OA8VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKEi81Yd; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-6bce380eb96so1195492a12.0
        for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 10:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725040321; x=1725645121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKChkzVbCCfFfBYZvpd3EOBHIgKlScj1Tt9DTkAnXWg=;
        b=nKEi81Yd2tAgUBeA+kP78OsYh04X5F27pGD/K72PVnZnjSUPBr7R9ojwpgvJwACQ2X
         CtHG5YZI4RhqXVTFjohueU7yf9wD36gBgmkRLLrPJBlYCvNQaHxAGsX3hd5nr98gW+lm
         vTb9FvWUAkYlKiuWt6RmmLc+D69bqF3sQoQx/8KbY10zWEVlLXIsa7ZjpYiKPF0hyi3H
         ECdbHKO4i0yBlV6rE46Rb0niW7bK5cDiadZLpEb5OyXwYozmE0IqVw2WcZ+Q29nprtd/
         CQpWbCgxGJbpeKlXMqDx+KN3wG4zF4iAYmm0dMu5ECEHk9omBoZouAKut+LmAEsng544
         fWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725040321; x=1725645121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKChkzVbCCfFfBYZvpd3EOBHIgKlScj1Tt9DTkAnXWg=;
        b=DmSYjJDEG5nJQxMvwKghAn+sljEW+ewvyheI/0vZXxsePzMtHavkzggXWgcKw5dj0G
         gQKjnjUBK57ZhDgkeyufJGnFc3sVG5Co5dP8HdMnuvQ5hVHd747dKbTgJVgc0XYMbxq0
         OnzSPOYvJs+WzP0c2hoyROPQREQVO2fvW40WMCQDyEzGQFGDqs7BfSb4Qsm7WXj8BQRp
         mCIU1C4tW+WJ3Shmqh/JCmi7YarJ5ab4Uv6mPTADka3PxwEeJayX6WBWGxLWOcVnbWGH
         KUjYcisbktCwzKEzvbhNOtfoW6jp8DFx/5oMGEiodSmo7vsi404lfON2p6dCkLixtLi/
         0tIg==
X-Gm-Message-State: AOJu0YwpUlFu9TVJyFMACvovcuobHaXYZf8/w2mMHd0nnbAvPf7CKE2C
	zT7cinFB/Uzqh0+eFfDDijaO4Qg2kBrXSxEXiiNUOOB/Ite97oZ3oUz0m8pIOe+xyfURkrtW8Rp
	fvqAEMOmJ0ihTfopdCFIfJ/SE+iE=
X-Google-Smtp-Source: AGHT+IH4cw/+D0iy6Zj+AtJfDRHj9egLNqaAXbBT2RyzkJhu4kYY8oLXRSuJL1QfkjtC/oGCZi1tS9/WES5e6Ujrei0=
X-Received: by 2002:a17:90a:de93:b0:2d8:8a04:1b16 with SMTP id
 98e67ed59e1d1-2d8905ed640mr118132a91.33.1725040321338; Fri, 30 Aug 2024
 10:52:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830173406.1581007-1-eddyz87@gmail.com>
In-Reply-To: <20240830173406.1581007-1-eddyz87@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 30 Aug 2024 10:51:49 -0700
Message-ID: <CAEf4BzYF0PqVHuj2gjZzaqrBOrVo8TEfuxiJe0TZvBb55n_Jog@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: check if distilled base inherits
 source endianness
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, tony.ambardar@gmail.com, alan.maguire@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 10:34=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>
> Create a BTF with endianness different from host, make a distilled
> base/split BTF pair from it, dump as raw bytes, import again and
> verify that endianness is preserved.
>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/btf_distill.c    | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_distill.c b/tools=
/testing/selftests/bpf/prog_tests/btf_distill.c
> index bfbe795823a2..810b2e434562 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_distill.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_distill.c
> @@ -535,6 +535,77 @@ static void test_distilled_base_vmlinux(void)
>         btf__free(vmlinux_btf);
>  }
>
> +static bool is_host_big_endian(void)
> +{
> +       return htons(0x1234) =3D=3D 0x1234;
> +}
> +
> +/* Split and new base BTFs should inherit endianness from source BTF. */
> +static void test_distilled_endianness(void)
> +{
> +       struct btf *base =3D NULL, *split =3D NULL, *new_base =3D NULL, *=
new_split =3D NULL;
> +       struct btf *new_base1 =3D NULL, *new_split1 =3D NULL;
> +       enum btf_endianness inverse_endianness;
> +       const void *raw_data;
> +       __u32 size;
> +
> +       printf("is_host_big_endian? %d\n", is_host_big_endian());

removed printf

> +       inverse_endianness =3D is_host_big_endian() ? BTF_LITTLE_ENDIAN :=
 BTF_BIG_ENDIAN;
> +       base =3D btf__new_empty();
> +       btf__set_endianness(base, inverse_endianness);
> +       if (!ASSERT_OK_PTR(base, "empty_main_btf"))

moved check before set_endianness

applied to bpf-next after Tony's endianness fix, thanks!

> +               return;
> +       btf__add_int(base, "int", 4, BTF_INT_SIGNED);   /* [1] int */
> +       VALIDATE_RAW_BTF(
> +               base,
> +               "[1] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 enco=
ding=3DSIGNED");
> +       split =3D btf__new_empty_split(base);
> +       if (!ASSERT_OK_PTR(split, "empty_split_btf"))
> +               goto cleanup;
> +       btf__add_ptr(split, 1);

[...]

