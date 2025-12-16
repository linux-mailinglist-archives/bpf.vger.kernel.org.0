Return-Path: <bpf+bounces-76767-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D81CC52AE
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 22:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D0EE3014AE7
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 21:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573232E1730;
	Tue, 16 Dec 2025 21:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUoDVYSI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FDDE55A
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 21:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765919092; cv=none; b=Hd8A0e8KavaEExun2dKsQeBSmWxBVK90FxGqa/04Twf5luWYrmW38rar+86zxcsGSmJsmhXazBAre6q3v+1XUu3eZs7jW4/VYIiJYhvvPGbXgZjG2Cgo4gZ3SeY4Mpnqz+h/NKuHYSl1IVnpyktZS/hcY7tx1eVtnV2ZEsQJPCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765919092; c=relaxed/simple;
	bh=FDeqb4YVxKH/kBQ78qSpKhuU3RRP/gsIDLhtpIGKkso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vc6AOJ9Gab+ITOdS3zDKOhbV+eMyvkjgAWne0ADYZ2q5Gka3k1yo8VPSS5FjZg6XQSVLVGCoPT3XzP5+OzoW9CxZtQKfWUDEU+QpNZPXyyPc0lGtsnchvLIuNfzX3sXSOYOTH21h8tjToAafwtmw85iZ+o0oS0qgOTZ1lVjTBTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUoDVYSI; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-34cf1e31f85so498549a91.1
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 13:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765919091; x=1766523891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIXd/dFGyEZDpmc4f1kvbOIwtnfZwt/kYFCBECgbqUI=;
        b=FUoDVYSIFvWWLCn+Iu80vXvllnLbyEMu0e17MJk4oXbZeIfOK9jXrUTSLKvvXn/pjI
         +bFD/lY9bbh3OhmdL337Tv7fE4/UA2gsTkygfyo8RG/HotXP6A1kvrH8IHkWHWB+pwwp
         79SicwiOzO3clw56ixWEkn6GP3rS1jYKA0VwBLa/0k4j6KrPtcCFpabCpwlev740Zsc/
         LsKHxXDPDXUgjIkmmb1kruxh4vtanv0EHLsNZfXrPclxdCbSWwpKlT2b2943sPQ43rw3
         Fp1uDOKFpc71oJ/BvUiabGtmJ9OvUFTfdIs4QvE3FUKAZRcZecqJ/q62tm5pCnOox30f
         41Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765919091; x=1766523891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EIXd/dFGyEZDpmc4f1kvbOIwtnfZwt/kYFCBECgbqUI=;
        b=m5YLNoR18OJD+cJ6jhyKkTHICoS2Cr3cMtxn9G29p6OWEUrt87tFDeuwdFavqptIuc
         YT9HrWBWppVyySpF+AhvVGuIM7TRGELBd5G4VYhOxKxl0ZyW74z8ug9pajJvgGR/TZiz
         C9GI9D39yZV5CXwFC2/TobkPqhLNqGGcGky0Bzgv9E62gRaBMRsvflUwB1odjwixfROW
         HTySOG9hSQdQ3q5kXvbvkQYb3X1XT6UNTKkYPMuqw0DvwwoeATBhfkyEMh2THEc9xCr5
         2GvATurRXYVWJyj+sMY/7+fRQigGPLsHQqWNuIH+IBZJSRwSeY57cGLzRWvV4/nO1D+Q
         ChSg==
X-Forwarded-Encrypted: i=1; AJvYcCXQrR0j977g3ZFlW99F4MfcTlNHPZeZw1CJrLI8ZDfMo2Z9TTd4Daqp7x+3uwytZ1EgsfU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsm+JA5j/T1J0t/z+dkRxOPMttmORDiKFCY4Famc5BwsLFkTwC
	OAjMaIEb5kMw5mgf6oq/tI5GLl+v2xO+0xfdiRnh8jvRnlF6MjMWtI4ndPnNG0Bl7EYZ2myw7cq
	Ao89iRaxCAb7KEF65MZjaIFQ7APKh/KM=
X-Gm-Gg: AY/fxX4Y+ByXO3cyWq6VD2G664mcep1XhPEE7jIfVnwFdAcMoOrzY4NILvHh0Apg55r
	NG2Z6b/8q8Is3KixZRcbRKy2tT5w5VBfei23bVHDKyjsoNMw6jEJESOyFBAVdYoe9qfiA7B/cjM
	xGgh3dGYUbFAcQ+1U8vYT5J5jNx635Xbi8Gyt+pbo6Z/kL3HEho8/mOpyMOQTs3zchUp/SiIunH
	rkDT5mEn2+ZprsZsmQfmFH3j/HNl/PupdH2uopafQQlccYv4A7uUpjGLcGg+wdBgnqR9YcY1/Tj
	hjiOrlobb0sBl4WUMERYVg==
X-Google-Smtp-Source: AGHT+IFMIwh21ikhDKMfcfZPq4afb5cjuBNy7xli0B2P36QEj2XlMh+oD2CeTSCGleHnEUkf/OoKwXOajg43jVFbqkg=
X-Received: by 2002:a17:90b:2891:b0:32b:9774:d340 with SMTP id
 98e67ed59e1d1-34abd78d3a2mr13349984a91.33.1765919090552; Tue, 16 Dec 2025
 13:04:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215091730.1188790-1-alan.maguire@oracle.com> <20251215091730.1188790-5-alan.maguire@oracle.com>
In-Reply-To: <20251215091730.1188790-5-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 16 Dec 2025 13:04:37 -0800
X-Gm-Features: AQt7F2qWwrDEBXsFsq1OiDW_11tfqC-ZuahsYEDLv8_rqpT-CV-RT2EpvUPVwIQ
Message-ID: <CAEf4BzZuFB6zvMjdqKDumUAT4vr5MeA3LBqTh5xRZmAQ5KC10g@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 04/10] libbpf: Add kind layout encoding support
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org, 
	ihor.solodrai@linux.dev, dwarves@vger.kernel.org, bpf@vger.kernel.org, 
	ttreyer@meta.com, mykyta.yatsenko5@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 1:18=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> Support encoding of BTF kind layout data via btf__new_empty_opts().
>
> Current supported opts are base_btf and add_kind_layout.
>
> Kind layout information is maintained in btf.c in the
> kind_layouts[] array; when BTF is created with the
> add_kind_layout option it represents the current view
> of supported BTF kinds.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/btf.c      | 60 ++++++++++++++++++++++++++++++++++++++--
>  tools/lib/bpf/btf.h      | 20 ++++++++++++++
>  tools/lib/bpf/libbpf.map |  1 +
>  3 files changed, 78 insertions(+), 3 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 3936ee04a46a..589a9632a630 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -29,6 +29,35 @@
>
>  static struct btf_type btf_void;
>
> +/* Describe how kinds are laid out; some have a singular element followi=
ng the "struct btf_type",
> + * some have BTF_INFO_VLEN(t->info) elements.  Specify sizes for both.  =
Flags are currently unused.
> + * Kind layout can be optionally added to the BTF representation in a de=
dicated section to
> + * facilitate parsing.  New kinds must be added here.
> + */
> +struct btf_kind_layout kind_layouts[NR_BTF_KINDS] =3D {

static?

> +/*     singular element size           vlen element(s) size */
> +{      0,                              0                               }=
, /* _UNKN */

use

[BTF_KIND_UNKN] =3D { 0, 0 },
[BTF_KIND_INT] =3D { sizeof(__u32), 0 },
and so on

it's succinct and self-descriptive

[...]

>  static struct btf *btf_new(const void *data, __u32 size, struct btf *bas=
e_btf, bool is_mmap)
> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index cc01494d6210..dcc166834937 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -109,6 +109,26 @@ LIBBPF_API struct btf *btf__new_empty(void);
>   */
>  LIBBPF_API struct btf *btf__new_empty_split(struct btf *base_btf);
>
> +struct btf_new_opts {
> +       size_t sz;
> +       struct btf *base_btf;   /* optional base BTF */
> +       bool add_kind_layout;   /* add BTF kind layout information */

Why an option? Let's just always emit this. And teach libbpf to
"sanitize" layout if the host kernel doesn't support it. Looking at
kernel validation code, it should be enough to just zero-out layout
len/off fields in the header. (Maybe we'll need to zero out layout
data itself, but I don't see any zero checks for that, so probably is
fine without that).

As a general rule, let's avoid adding options if we can just make it
work unconditionally. Options are never a great solution, it's just
sometimes a necessary evil.

> +       size_t:0;
> +};
> +#define btf_new_opts__last_field add_kind_layout
> +
> +/**
> + * @brief **btf__new_empty_opts()** creates an unpopulated BTF object wi=
th
> + * optional *base_btf* and BTF kind layout description if *add_kind_layo=
ut*
> + * is set
> + * @return new BTF object instance which has to be eventually freed with
> + * **btf__free()**
> + *
> + * On error, NULL is returned and the thread-local `errno` variable is
> + * set to the error code.
> + */
> +LIBBPF_API struct btf *btf__new_empty_opts(struct btf_new_opts *opts);
> +
>  /**
>   * @brief **btf__distill_base()** creates new versions of the split BTF
>   * *src_btf* and its base BTF. The new base BTF will only contain the ty=
pes
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 84fb90a016c9..0fb9a1f70e72 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -453,4 +453,5 @@ LIBBPF_1.7.0 {
>                 bpf_map__exclusive_program;
>                 bpf_prog_assoc_struct_ops;
>                 bpf_program__assoc_struct_ops;
> +               btf__new_empty_opts;
>  } LIBBPF_1.6.0;
> --
> 2.39.3
>

