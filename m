Return-Path: <bpf+bounces-38566-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77625966664
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 18:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3281E286F01
	for <lists+bpf@lfdr.de>; Fri, 30 Aug 2024 16:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6A51B8EB6;
	Fri, 30 Aug 2024 16:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E60ia9i5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159AB1B8EB8
	for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 16:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725033666; cv=none; b=ZxdzcKATOah5QB1dLjIZQxDRl7yoXtozG9jvFhUGmNqFOjbCZYiIdcfr2dF62BzyYwUzkfdy6gxcxCqQncfl8AhWXsF41ZYoW3Bg93fml0/NVB7Nz6zdif3eteiHc3j7DktsN7GknCZRyehvJtio8uu7wJhY3kDi4J6+ME4hg5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725033666; c=relaxed/simple;
	bh=gHWbPneExtgN6k9ToDNNfFE6Fx3kux2xQTY48RpptP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gBDvTUDJMhnT+e/qNNXjipUtZ7H3mAUP0bQcuqjqb3I6gKb0e720Z7ZlIr7AxoSnOlZ0vln8mvh0BJcRho9yZaSB32ZEBlI6Hb4sKbOr4N5vlL9lnvjjNDi8HhEzje3jDQ7z3/0KGjDwpkjyD+hKfPZLVRsDR/6RtSaa6b+vn0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E60ia9i5; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7cf5e179b68so1335826a12.1
        for <bpf@vger.kernel.org>; Fri, 30 Aug 2024 09:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725033664; x=1725638464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBDbxJU21T7L/UzcFfIRe29/jzO5Efklip9vWpLlmLI=;
        b=E60ia9i5RbXPQwJDyffco5ynCP1nrXcCZ+SceM6JenmqB7g3S7rwucG2Rjc/ZyBKSf
         Kr5FmBswPvBrx6BaND56xOeFmFRscLLXxIomXBoivl6lI6yrrUUHJULznArox1lqcZAN
         UfBYFbERNEfZuGqoLM9JdBrJEeJ1uhNr2XEo6zmX2wmyk1SMWNCsLEGLxfZzzOicasFQ
         yfX+RYvfync4SNc/VJq/6ZUE+P9WwsCUkAx9V7xXE1MrrBoP+t92KdCTS54WaNjlXHff
         rd8dLs0CDdfbXAoymNydJ639KSydUh889ET0RLhhZNEjaTbFoH4tcRbtlBhpPwZEo7IT
         omVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725033664; x=1725638464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TBDbxJU21T7L/UzcFfIRe29/jzO5Efklip9vWpLlmLI=;
        b=JSO08VTuL/DxTWgNWYbsdyubkMRzahHZ08A4VWWniYGZN15cnZ/jLyGc5J8cEbwiVu
         cZR1WyGvgsIRqwrm0Bkhy/pCUWc9+pMLo3hjjw8zxxBZ7tMUUD+eK6QHRWGf9iXOGZuT
         elVS7F0SpPwFQMHRGHTLluZeMDlQHmXjcduOB/oi7fLG3TsfyuEw4X914Z+1o7Sp6uVw
         A40g22ZbIVzknNcpUOEJxrnZVcbZE/cEbNp0x6I563zEGvU1J+T3z9Zgp625isBUXxsp
         7EPv2jhctE3AfXl5B0b40rKvi+Dj4AfiOLOvoAkclIRLhEGDJMctpG3UNBzvO7i+NMP5
         5y+Q==
X-Gm-Message-State: AOJu0YxmbBaGVhLK2tBmMvGo8aHFSmYlZK1A3OcldQwomQojKN+puAwk
	NEp9TAUG8qTFMop1tjHyoaxm5HrE+IJZJfTJ32RZ02qrrNYkhophuKjOcUCYk2rqNpuM/cyOTKS
	Z7J1Hrg0QAzae9XEjRufnd3v4LmE=
X-Google-Smtp-Source: AGHT+IHXSXeNaABBAB1t+ezqIhyqL6IRfUG/zxJ5hQ48GcS/kWb2BCM6J7ySuSHK047nKkFgOIMtARN56xhEg1eo+W0=
X-Received: by 2002:a17:90b:370f:b0:2d8:7a63:f9c8 with SMTP id
 98e67ed59e1d1-2d87a63fceemr2767559a91.14.1725033664187; Fri, 30 Aug 2024
 09:01:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5be4f797c3d5092b34d243361ebd0609f3301452.camel@gmail.com> <20240830095150.278881-1-tony.ambardar@gmail.com>
In-Reply-To: <20240830095150.278881-1-tony.ambardar@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 30 Aug 2024 09:00:51 -0700
Message-ID: <CAEf4BzYCgP8Y63Y5wjA=7mRHCMMYa-XBXqhyVTzwk94AhqLKCQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] libbpf: ensure new BTF objects inherit input endianness
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 2:52=E2=80=AFAM Tony Ambardar <tony.ambardar@gmail.=
com> wrote:
>
> The pahole master branch recently added support for "distilled BTF" based
> on libbpf v1.5, but may add .BTF and .BTF.base sections with the wrong by=
te

there is no libbpf v1.5 release, are we talking about using unreleased
master branch?

> order (e.g. on s390x BPF CI), which then lead to kernel Oops when loaded.
>
> Fix by updating libbpf's btf__distill_base() and btf_new_empty() to retai=
n
> the byte order of any source BTF objects when creating new ones.
>
> Reported-by: Song Liu <song@kernel.org>
> Reported-by: Eduard Zingerman <eddyz87@gmail.com>
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Link: https://lore.kernel.org/bpf/6358db36c5f68b07873a0a5be2d062b1af5ea5f=
8.camel@gmail.com/
> Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> ---
>  tools/lib/bpf/btf.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 064cfe126c09..7726b7c6d40a 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -996,6 +996,7 @@ static struct btf *btf_new_empty(struct btf *base_btf=
)
>                 btf->base_btf =3D base_btf;
>                 btf->start_id =3D btf__type_cnt(base_btf);
>                 btf->start_str_off =3D base_btf->hdr->str_len;
> +               btf->swapped_endian =3D base_btf->swapped_endian;
>         }
>
>         /* +1 for empty string at offset 0 */
> @@ -5554,6 +5555,10 @@ int btf__distill_base(const struct btf *src_btf, s=
truct btf **new_base_btf,
>         new_base =3D btf__new_empty();
>         if (!new_base)
>                 return libbpf_err(-ENOMEM);
> +       err =3D btf__set_endianness(new_base, btf__endianness(src_btf));
> +       if (err < 0)
> +               goto done;

This error check is really unnecessary and paranoid, because the only
way btf__set_endianness() can fail is if the provided endianness enum
is corrupted (some invalid int cast to enum). But in this case we are
getting it from libbpf itself, which will always be correct. So I
think I'll drop the error check while applying.

> +
>         dist.id_map =3D calloc(n, sizeof(*dist.id_map));
>         if (!dist.id_map) {
>                 err =3D -ENOMEM;
> --
> 2.34.1
>

