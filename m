Return-Path: <bpf+bounces-34141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 140CA92AACB
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 22:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FDAEB219CF
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 20:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252CB14D444;
	Mon,  8 Jul 2024 20:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acyExJI0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B0F22334;
	Mon,  8 Jul 2024 20:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720472179; cv=none; b=DLZwBqI+g7jGS+/Bl/8ERrgvsjneHiislT5qcaTAB6V1g8oilt7WC5WHEcOzQ8dn7ocXmflbICyBBts8AH5L5dm3ba03mo1xAXmkqVveVqlybOMI24WrpzGU9SRaFUjiDSrRN9kC2KYdq4E9LqvfSGcMoIOVmhLzSzMHXKQtcYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720472179; c=relaxed/simple;
	bh=FvkKnRWRIjuuxLDXqOIJTJXJTfj5VfXts7dxV6ah8wU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=REGE1zWjJXDF65KqHpdfN9lHAF+kzzdt9N6zVHVXnjKv0a6FG4LDQJ36+GNV/jI17W1PUml9C8WitsMZ0lbT8T0FZy4ZY37bDPN8adx12E0SsOQ/Fjld+SKvfbMnlwpNG1X8Ql5HuFMIn1i+mTitJ+uZLecYNfi/g0inIj+Hmi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acyExJI0; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-706524adf91so3561114b3a.2;
        Mon, 08 Jul 2024 13:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720472177; x=1721076977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rERgIcp1WjGB+7UNVaPoX3fOoHrXUPtCM+cfJmL5i1w=;
        b=acyExJI0VW3RWY3PpHEt5CEqva109lMGQupd2mMiBfa/ex4gadTq8x3Rbl8S8LGjHs
         DyXmAn113y4u4or6Mn3QnFjQZXRobJBiTr3sh/Pw4tmFQHcA2rLsIFUCUK9HSBvnJz5+
         kyq5Ei9zSGrd9dIC4N49Ge6exMhcwqX5aiMLc09oINkf99ASrPMJc83oRg0qXmT9/itX
         zTlJ4BBKp02JgqaWdYtPWF2FQz/C6G28HJ1Sje60fqJ+Hc1LHh7KMK8IM+1uJ9KT8M+e
         SNx8nVXzuSjQ8TOEBBDXwxXitC5ZIQklELI7HtKZRov8xjmomXxudujjghzyB2TwtE1I
         tzhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720472177; x=1721076977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rERgIcp1WjGB+7UNVaPoX3fOoHrXUPtCM+cfJmL5i1w=;
        b=dC+A/kixPHZW2YxitEemI3Nmq74Y4v9YBXz5u+5BJkkxaFqlQOob40Zq+e2hMGABep
         T9WLpZFdr/aTXQDod5bXEQ/Qq6RkGKsJc3/9b7X9ZhpBLDXVBDq7IKy55pDRxzbIjq6r
         WdYvypX4P3PcGFTH7m5FWtM18c+/6PFe19ISBHxKGsipYj7RZKgVQwI5Hbq1gmOyzJkM
         O4n9PS+H/hwLCVBUMYWT1d2+B4PbB5J4WZ6/6eMT2DwzwL37FjBVXZZ0QFBuY8BYw2Ld
         wyCnDCsVXLUfeVzJfTYxsht7hEZiraxjVeUIyGWLe6ODo6tM30u9mwlcSxtnQGdjp5zR
         HyJw==
X-Forwarded-Encrypted: i=1; AJvYcCW56PCMWkee2tWbh4Ez6kWUFt0bw9vC7sN5FRlOXq2iSIHLi8TXLF61kn7g+XLBaS8PpwEZQzFHObvsS5YU5LHEnAEpqHdY4RYjlIbrdCwaIHFt0J4uzcSCLig11ats+NWg
X-Gm-Message-State: AOJu0YwSNBdWVM+tiUXpmNdusUzU3TY3K8lOOeIWluq+PNbfzfVmrsxX
	GtYwQt3KYFpd7yR5t32z7ZO4NNqSeKAse8bCpG11NqBvhloNvMnAEH7E7R03xtT5EtMtcXPapKE
	1e5VtcwJwEk9jqvsWulZGRfKUNAk=
X-Google-Smtp-Source: AGHT+IG/hMAbW5nHgfuuIBBnQR4hnuQKwQwaDMErTb/QOW3CDdkYVCYMYeamoFYfv3CEvF/Cxu7DAhCm4O1v6F+bnBs=
X-Received: by 2002:a05:6a00:2d95:b0:6f8:e1c0:472f with SMTP id
 d2e1a72fcca58-70b4353cce9mr1074367b3a.8.1720472177520; Mon, 08 Jul 2024
 13:56:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703083436.505124-1-ziegler.andreas@siemens.com>
In-Reply-To: <20240703083436.505124-1-ziegler.andreas@siemens.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 8 Jul 2024 13:56:04 -0700
Message-ID: <CAEf4Bzb=ByjP1VgKLZ_4JXE-t5ig+D3gxcKaqi=ZgO=iETGqig@mail.gmail.com>
Subject: Re: [PATCH] libbpf: add NULL checks to bpf_object__{prev_map,next_map}
To: Andreas Ziegler <ziegler.andreas@siemens.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 1:35=E2=80=AFAM Andreas Ziegler
<ziegler.andreas@siemens.com> wrote:
>
> In the current state, an erroneous call to
> bpf_object__find_map_by_name(NULL, ...) leads to a segmentation fault
> through the following call chain:
>
> bpf_object__find_map_by_name(obj =3D NULL, ...)
> -> bpf_object__for_each_map(pos, obj =3D NULL)
> -> bpf_object__next_map((obj =3D NULL), NULL)
> -> return (obj =3D NULL)->maps
>
> While calling bpf_object__find_map_by_name with obj =3D NULL is
> obviously incorrect, this should not lead to a segmentation
> fault but rather be handled gracefully.
>
> As __bpf_map__iter already handles this situation correctly,
> we can delegate the check for the regular case there and only
> add a check in case the prev or next parameter is NULL.
>
> Signed-off-by: Andreas Ziegler <ziegler.andreas@siemens.com>
> ---
>  tools/lib/bpf/libbpf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Generally speaking libbpf's APIs don't check non-optional parameters
for NULL. We historically did check that in some APIs and didn't in
others, it wasn't consistent. But since a long while ago we decided on
not checking arguments for NULL defensively. So I don't think this
patch is necessary.

pw-bot: cr


> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 4a28fac4908a..30f121754d83 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -10375,7 +10375,7 @@ __bpf_map__iter(const struct bpf_map *m, const st=
ruct bpf_object *obj, int i)
>  struct bpf_map *
>  bpf_object__next_map(const struct bpf_object *obj, const struct bpf_map =
*prev)
>  {
> -       if (prev =3D=3D NULL)
> +       if (prev =3D=3D NULL && obj !=3D NULL)
>                 return obj->maps;
>
>         return __bpf_map__iter(prev, obj, 1);
> @@ -10384,7 +10384,7 @@ bpf_object__next_map(const struct bpf_object *obj=
, const struct bpf_map *prev)
>  struct bpf_map *
>  bpf_object__prev_map(const struct bpf_object *obj, const struct bpf_map =
*next)
>  {
> -       if (next =3D=3D NULL) {
> +       if (next =3D=3D NULL && obj !=3D NULL) {
>                 if (!obj->nr_maps)
>                         return NULL;
>                 return obj->maps + obj->nr_maps - 1;
> --
> 2.39.2
>

