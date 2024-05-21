Return-Path: <bpf+bounces-30167-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE708CB5DF
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 00:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEDA4B216AD
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 22:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6F3148820;
	Tue, 21 May 2024 22:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ez2WGs4W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E5B487B0
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 22:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716328925; cv=none; b=GvlvIDQhjhU7b896iApVYOBaQWhFp5W3zbQxjP69eyNOH5JQbDAhZNZzI8ZxgFv8F1drss8gWRdO64DkalRRKoeRnRYel7j2YCH/Y8WdnZulvYJTYr+Y/mOItv1on5v5qVwyM9QTeK+7BLif0ZfUmStDk7qnwWlXJMyv8ziJ5b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716328925; c=relaxed/simple;
	bh=ohrlaaQGetumAzTMDJi8/ROafCHeD2Q0W6qUJgDn9hs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PAWqg7mMxY9zGrNc+QDcWMGwIs7fjDuDv+oc/m7s8Jik+6EgOp9LjDa66+DwhzGB7+KuXglRKrJQExWXQ64zAsvcbvBlJ4tEKKhna3G1GmNwfLMby+pBwGGKLe89AjIMrfxD5UAH1Yw5z1b9kTOdyFBGARcIAI3GtaqtvpVdwK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ez2WGs4W; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2bd816ecaf5so659068a91.2
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 15:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716328923; x=1716933723; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQ4OjxJHKguUpH+wJ3+tiB6/8yEKR12KEj0snIWlDzg=;
        b=Ez2WGs4WVE5ScEVDePaxFVN+MXbqVzW81bp1jHoM5LbFRKR3RwgE20NMQUdFikxTF+
         O/nCQgTlNsO5EgFCaNgWxlOY5+1jRYVogm0ea+uB+SvG/zKjAxl3bpiT7TwbpEY8gXYg
         1AYQ3PWLaqu+V1LCh5VJh87/O1pvzGDQRljiW0vtAy0bwIfB3UNsZ4SOio3C1VYxx8jb
         fef5aOhLyhJnyh1uy/qkUfZDSROx+jduT+vKk0+4vhaxPOtCfeaie0V9brA7Fptbo9YM
         EeLZr6Y8nfdnoxPBdlZDCRk0rdZevpMHvhD48CekP7SfWibJ1/bRWwlIbQiCpfjmv8lr
         H9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716328923; x=1716933723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BQ4OjxJHKguUpH+wJ3+tiB6/8yEKR12KEj0snIWlDzg=;
        b=iMGXSVH4DNZ7tbLv0znUr/W+sTaRZZaUSqw6GVi2LWyFMXDGTkmRTcLgotfAgBIBXa
         Ljnoj/kX4axaSpj8B8Pi7Yw+UdYUiM86VA1RhGab2sM6ZFe9r+oWA1ytC20k474jKoPK
         iOI8hdzyZWY7tX8JDCYYkLhVhmpdbz9xVLyWxnpxqV1lua0zNPjDqCquWVOBOSfJBXsp
         21OtDi2Z6qVGAdRJw8MNlhhLU5zjYhZ9mVrGvOVcKye9GgTScmLVfTUSDqGwQHmVWnyi
         U08+XsZicTpwkwVT9m4hN74DwkMcJmHwrWEdem7qG7RrX0ispahPZ4rza/PSTwdaMUi9
         0gLw==
X-Forwarded-Encrypted: i=1; AJvYcCXMzmsCu2aj/1DstApmf1/bO0jBNURtL7qDGHufgDqUf+Wh6KqyTpIJcz9dUdYZLlmK6kRtVN72JRM6fSItwECIIEVL
X-Gm-Message-State: AOJu0Yzwy2SiiGbXwz/fB2lRlyo4x6g1g6tmnUmljoVc64uNM5vBWF4P
	myugKPSVcOg1hADCZT8Vje0wRjngGYGrGTFwg5LrtULQ4hMnoL7oWO02Bt+963N4+x+TkaMHiVB
	dvkR0G0EBoTVJqalR89QlHkkvldQ=
X-Google-Smtp-Source: AGHT+IEZVmtxgsIPvGegYgWae6RCqHVqB/tOIQeXOO8lPWa+OCzKX/otNZBEpZPM2N3+GPZjVa9z9ud3txbKyVlNvAs=
X-Received: by 2002:a17:90a:de94:b0:2b4:32c0:86be with SMTP id
 98e67ed59e1d1-2bd9f5d500fmr334515a91.45.1716328923113; Tue, 21 May 2024
 15:02:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517102246.4070184-1-alan.maguire@oracle.com> <20240517102246.4070184-4-alan.maguire@oracle.com>
In-Reply-To: <20240517102246.4070184-4-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 21 May 2024 15:01:51 -0700
Message-ID: <CAEf4BzZuVkaUmPQdynTHVkbqMx9TjVta5gAj6TAFq9c0LcfOYQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 03/11] libbpf: add btf__parse_opts() API for
 flexible BTF parsing
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, jolsa@kernel.org, acme@redhat.com, 
	quentin@isovalent.com, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org, 
	masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 3:23=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> Options cover existing parsing scenarios (ELF, raw, retrieving
> .BTF.ext) and also allow specification of the ELF section name
> containing BTF.  This will allow consumers to retrieve BTF from
> .BTF.base sections (BTF_BASE_ELF_SEC) also.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/btf.c      | 49 +++++++++++++++++++++++++++-------------
>  tools/lib/bpf/btf.h      | 31 +++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.map |  1 +
>  3 files changed, 65 insertions(+), 16 deletions(-)
>

[...]

> -static struct btf *btf_parse(const char *path, struct btf *base_btf, str=
uct btf_ext **btf_ext)
> +struct btf *btf__parse_opts(const char *path, struct btf_parse_opts *opt=
s)
>  {
> -       struct btf *btf;
> +       struct btf *btf, *base_btf;
> +       const char *btf_sec;
> +       struct btf_ext **btf_ext;
>         int err;
>
> +       if (!OPTS_VALID(opts, btf_parse_opts))
> +               return libbpf_err_ptr(-EINVAL);
> +       base_btf =3D OPTS_GET(opts, base_btf, NULL);
> +       btf_sec =3D OPTS_GET(opts, btf_sec, NULL);
> +       btf_ext =3D OPTS_GET(opts, btf_ext, NULL);
> +
>         if (btf_ext)
>                 *btf_ext =3D NULL;
> -
> -       btf =3D btf_parse_raw(path, base_btf);
> +       if (!btf_sec) {
> +               btf =3D btf_parse_raw(path, base_btf);
> +               err =3D libbpf_get_error(btf);

IS_ERR/PTR_ERR, btf_parse_raw is internal function, not a public API,
so we shouldn't be using libbpf_get_error() here

> +               if (!err)
> +                       return btf;
> +               if (err !=3D -EPROTO)
> +                       return libbpf_err_ptr(err);
> +       }
> +       btf =3D btf_parse_elf(path, btf_sec ?: BTF_ELF_SEC, base_btf, btf=
_ext);
>         err =3D libbpf_get_error(btf);
> -       if (!err)
> -               return btf;
> -       if (err !=3D -EPROTO)
> -               return ERR_PTR(err);
> -       return btf_parse_elf(path, base_btf, btf_ext);
> +       if (err)
> +               return libbpf_err_ptr(err);
> +       return btf;
>  }

[...]

