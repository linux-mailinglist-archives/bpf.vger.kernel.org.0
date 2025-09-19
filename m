Return-Path: <bpf+bounces-69017-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF79B8BA16
	for <lists+bpf@lfdr.de>; Sat, 20 Sep 2025 01:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D29977A75FA
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 23:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851742D3740;
	Fri, 19 Sep 2025 23:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFK3yKkA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E683A8F7
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 23:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758323944; cv=none; b=paVMJHpG/b357DdLuvH+m2iZtHWvfJrndGkZvCzqCBGIifS+BoPq9nWq4cJU4N0UVCC5ckPKCPg99XoYSo7fOITKeWcOEbzUdMsfxw127GIdYXJmNF+ktq2F4XmQw0gg+SBNSF/DV3mRc5PmVX/YONiO7DsPNO/xNwCVZR3+30Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758323944; c=relaxed/simple;
	bh=agUKBrXFScPWK49lFVgVKGFzwTKsMOaqOE7bRNjFeRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kjW3+iNjHDWqgwJkAD2fpdN+dz7XzmEdKqklNeqrAFHGIQW24KzaRiNjyn/6JUDKXmDOtUfWE6foA3hwWQsLw0OKpmg93RQwEp0P6EbOGBTonOcuoI/4s4KbpmB0ntZpKP/uVscyFPyuD8fCVMbZCqx87uXsqbnvgL6AeFx76r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFK3yKkA; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32dc6616f7dso1941555a91.1
        for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 16:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758323942; x=1758928742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UriU5839ghSKDZkoYlP+N8At1cetT5YoJQHXlHPO/Fo=;
        b=RFK3yKkA2eb6K9lvAn4dGmbfpCYcc4kLFHmrElKAQ1A9bzTIqQB9FeB5UiGtWQZ2ku
         u9kT/Nh3oLV0Wwyvak00wMhyV8wuOUpvNevpsmzz5c4touhxXGPjIIns/j0vq7SmNG06
         FYsps6WZy/4O94u66TWVk7WenoSWoVerzrsyftKQwFzHM8+y4y1f02K7RAvZ8+J7iSPG
         SRtH4pXF8NzCtYA4/c4M1kUa5J1UVCWR7oyryLUq+/0WANEMAHKWbqBEDLnSddlaWwhY
         oIcYh4ZkwT9Vf8fdP2f2JS1jbkGC0NLlbhMgLtKajrk/qXXUD+NOq06NBgOSbHEhFgc6
         Q97g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758323942; x=1758928742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UriU5839ghSKDZkoYlP+N8At1cetT5YoJQHXlHPO/Fo=;
        b=SAWpDK0T/HYQto5QjCTF2WdbEHgkItt6Gyinhq7p7jZgOnFdnUy/NZlcQtE5S7VjVb
         0unw9beA+1CtwIN5IAu+ryP9HLIGGVRF/HvBMjtP4+X4qF8NuDFqn09qJVFgsXBcyb7d
         fGEgvsQpJsCLYJ2lWPzAijVKaH7OjFY4rL/XmlRffVpH4dqEEuwNq8lTBIUqMImx+TFb
         P3I2/U7/UURy9bIx9CGS7JMNpyZ6npEX2+dgkzr9Oe2V5ol38PGn/gM1m16axiji283G
         wGgdLrqsmoYAmAXVujD/hMwDeCZeVHhd5CsEYEqTZqMs1EdqTqZsBT7LTb21mt8QfKVl
         zpmQ==
X-Gm-Message-State: AOJu0YwvHyUSsYlKEsDFa6yGZAdGsVxXTUM4tLIpvKstZrW1zP5TQNAD
	sIQTFV1AJmVvht9557PCFyBrm97t/QZnIU7u4Jcz1Mx2+ByA6MATaSClnniOMN30RjESF/0ReIg
	k0EazhLTAAUGGsboy1a+OnpoGBfUUhrE=
X-Gm-Gg: ASbGncv+yfcrJJdBsVcT0Cyc9IlgZBp1hIXM1Gx8ZOLGsJltH+mNpHbwu2jMeCvQ8ym
	Mnx2mvhG62qPa0+l13IXUNHzrk8AZAs5gGBXPnH5FtFlAf03rQZcrh1LprVQj9s53ONVxkfvv5y
	dFAYpPz7xosUxnSBvUWTIWbIY0IyFfo2SIJ0vF+n543z6QbfIoQK0IQ22skMgMCwvm5HPvubQkz
	CIyx966BQF45arG3gRraR0=
X-Google-Smtp-Source: AGHT+IGBOCIAbISlrKESdAVNbOPBkrSu8RVgiqpuuK62W6rrg8BwrMt62GalCIsItvUvTVc3Qwgy2kK4pBLhx1ehwu0=
X-Received: by 2002:a17:90b:2e83:b0:32e:5646:d43f with SMTP id
 98e67ed59e1d1-3309833cfffmr6023460a91.19.1758323941975; Fri, 19 Sep 2025
 16:19:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918093850.455051-1-a.s.protopopov@gmail.com> <20250918093850.455051-11-a.s.protopopov@gmail.com>
In-Reply-To: <20250918093850.455051-11-a.s.protopopov@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Sep 2025 16:18:47 -0700
X-Gm-Features: AS18NWBkipbG7b60oczge03VwEfhlwrydEr5v62hMflu4cbPW0qkwANgc3Iulmk
Message-ID: <CAEf4BzYgh00UcsTj5z=iFThJ=q+T2-Ps6=25QDfD7wmqcazpXg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 10/13] libbpf: fix formatting of bpf_object__append_subprog_code
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 2:32=E2=80=AFAM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
>
> The commit 6c918709bd30 ("libbpf: Refactor bpf_object__reloc_code")
> added the bpf_object__append_subprog_code() with incorrect indentations.
> Use tabs instead. (This also makes a consequent commit better readable.)
>
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 52 +++++++++++++++++++++---------------------
>  1 file changed, 26 insertions(+), 26 deletions(-)
>

thanks!

Acked-by: Andrii Nakryiko <andrii@kernel.org>


> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index fe4fc5438678..2c1f48f77680 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -6393,32 +6393,32 @@ static int
>  bpf_object__append_subprog_code(struct bpf_object *obj, struct bpf_progr=
am *main_prog,
>                                 struct bpf_program *subprog)
>  {
> -       struct bpf_insn *insns;
> -       size_t new_cnt;
> -       int err;
> -
> -       subprog->sub_insn_off =3D main_prog->insns_cnt;
> -
> -       new_cnt =3D main_prog->insns_cnt + subprog->insns_cnt;
> -       insns =3D libbpf_reallocarray(main_prog->insns, new_cnt, sizeof(*=
insns));
> -       if (!insns) {
> -               pr_warn("prog '%s': failed to realloc prog code\n", main_=
prog->name);
> -               return -ENOMEM;
> -       }
> -       main_prog->insns =3D insns;
> -       main_prog->insns_cnt =3D new_cnt;
> -
> -       memcpy(main_prog->insns + subprog->sub_insn_off, subprog->insns,
> -              subprog->insns_cnt * sizeof(*insns));
> -
> -       pr_debug("prog '%s': added %zu insns from sub-prog '%s'\n",
> -                main_prog->name, subprog->insns_cnt, subprog->name);
> -
> -       /* The subprog insns are now appended. Append its relos too. */
> -       err =3D append_subprog_relos(main_prog, subprog);
> -       if (err)
> -               return err;
> -       return 0;
> +       struct bpf_insn *insns;
> +       size_t new_cnt;
> +       int err;
> +
> +       subprog->sub_insn_off =3D main_prog->insns_cnt;
> +
> +       new_cnt =3D main_prog->insns_cnt + subprog->insns_cnt;
> +       insns =3D libbpf_reallocarray(main_prog->insns, new_cnt, sizeof(*=
insns));
> +       if (!insns) {
> +               pr_warn("prog '%s': failed to realloc prog code\n", main_=
prog->name);
> +               return -ENOMEM;
> +       }
> +       main_prog->insns =3D insns;
> +       main_prog->insns_cnt =3D new_cnt;
> +
> +       memcpy(main_prog->insns + subprog->sub_insn_off, subprog->insns,
> +              subprog->insns_cnt * sizeof(*insns));
> +
> +       pr_debug("prog '%s': added %zu insns from sub-prog '%s'\n",
> +                main_prog->name, subprog->insns_cnt, subprog->name);
> +
> +       /* The subprog insns are now appended. Append its relos too. */
> +       err =3D append_subprog_relos(main_prog, subprog);
> +       if (err)
> +               return err;
> +       return 0;
>  }
>
>  static int
> --
> 2.34.1
>

