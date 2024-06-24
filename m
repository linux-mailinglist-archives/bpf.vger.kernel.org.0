Return-Path: <bpf+bounces-32926-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5116915385
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 18:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BA36285FCE
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 16:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066DE19DF76;
	Mon, 24 Jun 2024 16:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYcDU2It"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306A219D8BE
	for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 16:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719246182; cv=none; b=kIOUYPJ5IjO1bwKa5WHr7YXy3BCu0qUfkrN4+B8UWRnpIfw5fn3+Xo04fheZS76td2NujhnelZOUskui/n9RQQu38uvcKzeQfbEFdNNkNRUM4jmq0aDPPtayHAZXfJLixSzDEq31ZURKeZfgaHkMxZH+rA+rIt2t5UEtl+WFdZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719246182; c=relaxed/simple;
	bh=dkz4ftg4wwFTewhc/eH1ssJsFIH3VdfRS8hnJd4TqxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ksmTB9hpEGT9pXWKk35P+mXuvqPWTqbvRvlbErPJ0iL0kaePM43xIX60HI+LmZAo71RZhOKeQ1SO/M+I/p3TlDbJdffYItbwknSCUbYMjlt7rDFMnpE1b+VRUk/3qY6MPMag8tOf3fgoTny3skfa5JZXe+lIza4W4M7XJTfdv8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYcDU2It; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2c8755f041aso871781a91.1
        for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 09:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719246180; x=1719850980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OFIAGHQtM8jilnOgNBwaprWiCYn0YpMSLYNWH6h1dvs=;
        b=QYcDU2ItUL7YbVAZKNv9lh9kVEx73t/aIlNkMvqY5c5w9zQZY9/6231BnoILpiciFv
         mFKw+O2ADgrk+hRt9DNh+nOtGJrz0tlhMDSea54Tz5aFksAc0z+lsQ4AQW0F17Xm89mU
         Zb4aImnSlombCXWVsdSgPXjk8l+qxjMDt571kTvvmH75P5n2DDPPRfbgIA2qt92200r8
         8Hw1I15ue4hvqnPM/MyBsY7oOYBTHkpET5CENr0OF6vJGqYd7YvlTZIbMFJK3IwnNuw9
         owBR6CrExgTYu59zkLokNQbObK1ITL/v4bhMLxIBrQPai6mECWcwEcCP/6DHckcdeaLl
         JV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719246180; x=1719850980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OFIAGHQtM8jilnOgNBwaprWiCYn0YpMSLYNWH6h1dvs=;
        b=eunjsv+gptx56FRd/0bu3/kYGUO9iFROyGkCPZXGJokq6WQQI9QZUmS6kt5dzOjLkO
         7rH/HP9hlcNLg0xod03uVsfcgwI9skTQ6TvNRUQRw9WGkv5oaj2DoN3hWGyPVeZ3TroU
         3FvvtxfSlImIywCRAm6GU0G+TunVykkjlYVAHbOJmmneziCrApfNwtELneIvPgkymkk0
         1DML5xBEHGXt9hr3QuBFP6CBQ32zoYooeD5ClGCHfBBeinChlP4VywJAf9SN59wD6rPS
         8bc63K9rP/DnbajD81O7WBEERqwHIWPtxJsS7DRLiHrCC256lNp67IhlvetvFQiW1hHD
         501w==
X-Forwarded-Encrypted: i=1; AJvYcCV0bs1aMyruShXOCg/a+UuZlN5X91zVG1Gs0YJTwPJD6AOkCZ4o2VqdaGeDf8U6prXEuiE9aYI2oxv3ZP06Rmk1f1IY
X-Gm-Message-State: AOJu0YwB32nZnoi++GGgD9kXuoFxb5kaam3ZgYFzMngJ7J67dI6cNLur
	Uk3Jb8qr7rgmLtFWxLRhkzG3G6uz2H5l6hS7O6WRhrsoOU+sKSHJkjI4Mzxcrey95H826a316gu
	jF8gNmoi/QKWWp7qXGlsOjjRnaYk=
X-Google-Smtp-Source: AGHT+IE1dUuoN/X7oL8jwOcTVZ+Zu19d043bwY2KzeQnwffetAz+hG/XqeNr5EQS73UoQASVM8y8cXUI/uypDDnF0d4=
X-Received: by 2002:a17:90b:1086:b0:2c2:c3f5:33c3 with SMTP id
 98e67ed59e1d1-2c8489d761bmr7467609a91.6.1719246180335; Mon, 24 Jun 2024
 09:23:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624130505.694567-1-alan.maguire@oracle.com>
In-Reply-To: <20240624130505.694567-1-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 24 Jun 2024 09:22:47 -0700
Message-ID: <CAEf4Bzb_2uqkRQ9d1qBwa8APg9EJAbApPvKaDts+6TXTcdKBRw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: fix clang compilation error in
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, acme@redhat.com, ast@kernel.org, 
	daniel@iogearbox.net, jolsa@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, mcgrof@kernel.org, masahiroy@kernel.org, 
	nathan@kernel.org, mykolal@fb.com, thinker.li@gmail.com, bentiss@kernel.org, 
	tanggeliang@kylinos.cn, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 6:05=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> When building with clang for ARCH=3Di386, the following errors are
> observed:
>
>   CC      kernel/bpf/btf_relocate.o
> ./tools/lib/bpf/btf_relocate.c:206:23: error: implicit truncation from 'i=
nt' to a one-bit wide bit-field changes value from 1 to -1 [-Werror,-Wsingl=
e-bit-bitfield-constant-conversion]
>   206 |                 info[id].needs_size =3D true;
>       |                                     ^ ~
> ./tools/lib/bpf/btf_relocate.c:256:25: error: implicit truncation from 'i=
nt' to a one-bit wide bit-field changes value from 1 to -1 [-Werror,-Wsingl=
e-bit-bitfield-constant-conversion]
>   256 |                         base_info.needs_size =3D true;
>       |                                              ^ ~
> 2 errors generated.
>
> The problem is we use 1-bit and 31-bit bitfields in a signed int;
> changing to unsigned int resolves the error.  Change associated
> assignments from 'true' to 1 also for clarity.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/btf_relocate.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tools/lib/bpf/btf_relocate.c b/tools/lib/bpf/btf_relocate.c
> index 2281dbbafa11..1fa11aa4e827 100644
> --- a/tools/lib/bpf/btf_relocate.c
> +++ b/tools/lib/bpf/btf_relocate.c
> @@ -58,8 +58,8 @@ struct btf_relocate {
>  struct btf_name_info {
>         const char *name;
>         /* set when search requires a size match */
> -       int needs_size:1,
> -           size:31;
> +       unsigned int needs_size:1,
> +                    size:31;

while you are at it, please declare them as:

unsigned int needs_size: 1;
unsigned int size: 31;

This multi-line fields declaration is unusual for libbpf code base and
looks out of place (I didn't want to nitpick on that initially, but it
caught my eye immediately back then)

also, I believe if you did

bool needs_size: 1;
unsigned size: 31;

it would work fine as well and would let you use true/false (please
double check with pahole if compiler co-locates all the bits into a
single 32-bit backing integer)

pw-bot: cr


>         __u32 id;
>  };
>
> @@ -203,7 +203,7 @@ static int btf_relocate_map_distilled_base(struct btf=
_relocate *r)
>                 info[id].name =3D btf__name_by_offset(r->dist_base_btf, d=
ist_t->name_off);
>                 info[id].id =3D id;
>                 info[id].size =3D dist_t->size;
> -               info[id].needs_size =3D true;
> +               info[id].needs_size =3D 1;
>         }
>         qsort(info, r->nr_dist_base_types, sizeof(*info), cmp_btf_name_si=
ze);
>
> @@ -253,7 +253,7 @@ static int btf_relocate_map_distilled_base(struct btf=
_relocate *r)
>                 case BTF_KIND_ENUM:
>                 case BTF_KIND_ENUM64:
>                         /* These types should match both name and size */
> -                       base_info.needs_size =3D true;
> +                       base_info.needs_size =3D 1;
>                         base_info.size =3D base_t->size;
>                         break;
>                 case BTF_KIND_FWD:
> --
> 2.31.1
>

