Return-Path: <bpf+bounces-68621-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A98AB7EEC9
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 15:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34C6918902D6
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 04:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B610E22B8B0;
	Wed, 17 Sep 2025 04:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIV3a+0N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DF4469D
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 04:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758083996; cv=none; b=N6xtlIzdjxy+FVVP5fK4ndwUypgbx72YO4rk532kIfqEajqfXZQJj032FApYqQUN9NwtfMKtl9UWvzai7qqmGSyPa2Q0bslmQRC5Cqf9ukNjI7hBrQzhueUVZx+4Ett+QNfXF/0n1YAAhkzW4k597ttvDxU/vCIqVp+TbA3/07Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758083996; c=relaxed/simple;
	bh=mB+786OotP4hl8q2+boyGq/UhLtVGIFOFRggYiBZ+hc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dvhTZxEayLgi2TCm+OEZULV4llb1IU0TSeIdo08+3/OKgXaZ8nbZUsxfk6d6B1aB11p7YcRFr6mlDa+pg6N11y0ntcyp+3S/i1TJ+PEqAnJRw3OTlg21IlsYpjK7GLJtykbwpq/MXCkAb9OLeRFEuLhkV7Z+pos1dbkjRCknO6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OIV3a+0N; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45ddc7d5731so43638975e9.1
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 21:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758083992; x=1758688792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXHdMg/mfZkpni2gxFFkaepTapnOfZAMzYn8zXl5pzk=;
        b=OIV3a+0NqiRAeQewyBcEBHufujqxazVSi1l7iMOjoY6AQXzjEpH7LWVrKrGROUda5e
         pyOvLDEVchtefDJyqydPYuRg1/dbD9ncbkMfykqnsGNAZuKx6xNsOxYowH/fEA2G2NX6
         NLYPqYsOQYYUmA7dJoXx81oPymfilmgXFYXioJ2VV8DSTN2IW+bn3e4GgHYiCsVNommz
         4Q08Oozn14RkRAb1yH08eD74N8/VC0WXUYKAYtWFOMp7zOOKTElUIANBF8LZomf9Wrj2
         LJ2mrba58odd6yRSKEU12HSuROr7Xzbw2U/u+Q7n2QkOuw7S9FuQbgCMvoNK6r+I91n7
         +Bsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758083992; x=1758688792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IXHdMg/mfZkpni2gxFFkaepTapnOfZAMzYn8zXl5pzk=;
        b=xLtZfum+eXCuJqCgBcIN+M5H3O7ogWYqD+lzcAe003+dhYZRdZbcXwFaiAQAPyrWwd
         ALdkSgbIyZL8jqQTHChsa0h5gJwsbeDTcHS+1s4VnvDspBw4O9nrvXAyvAtGe3D8wKW8
         N9OeNijHQIW9ZjsuTQ+tMCqqB+GfWNwDX0Icve4FB8tC1T3eJ7lkfhZyJ0ogtIPNg0/N
         Qm2/iPEX1PNNKvGxVaSs8o24kOuzE7xXtng8v1K5a+/u7V0PJaZ1+wKdH7zKQGYcU7R8
         KVyb1RId1Im5ZIFskX31VxCvnsjyx8dt9X3jUS/UUuk9RmT83lhn/UzQP5G4hhhn0UoH
         W5ZQ==
X-Gm-Message-State: AOJu0YyKY3QYP2lWWnYaii6w7ibkxnlDQFQwiv6qYgVl6OLWlaXSiCbf
	CRhahVn4FXRJ55x/TtlmPYTmslCpl5ZLQSsgPwHoR/z7brRZ+Xg1fec2ueYR/xgnBC1X/9qZsWI
	Xbck3vo35Vz3JxaLmn4WI96JP3f1rt2g=
X-Gm-Gg: ASbGncveNh8EV6cFvdA+eWPqE5uEsSqiwKBpdoWywUZ2qkSZh+pMU7AdVhoeAxnThyh
	mp+sJT2D8CFb9NecFtqVG2Uppa89EUpGuZ0n3l5FIXNDqORxtS6EjWhMeyPgaNlaCKrn8DV595h
	stUYDO940NQMXhzyQ0O11gteg7dcmqahvsqOcB68ZADdViaKaiUCR11SSLO3P6wzbTmg8x1HXYA
	WaOYHkexFDpIbwl9zlewzls6vUV5DS9OywgdKImbakB6bY=
X-Google-Smtp-Source: AGHT+IE35d7FRImgEShaEx3LN1cD8Iv+WYbJ9XeRlrYJegaKpYCs0B3uK4ExWvHuUSLf9HPgXZhMYCNN5rYqFR+rD3k=
X-Received: by 2002:a05:600c:1c87:b0:456:19eb:2e09 with SMTP id
 5b1f17b1804b1-46201f8aeb4mr6029835e9.8.1758083992074; Tue, 16 Sep 2025
 21:39:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916233651.258458-1-mykyta.yatsenko5@gmail.com> <20250916233651.258458-7-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250916233651.258458-7-mykyta.yatsenko5@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 16 Sep 2025 21:39:40 -0700
X-Gm-Features: AS18NWAtzbe0taDWQEawmTeEbtVysKrHt4je8BJpetLmh8ztyWqCjZ8OrixZdtk
Message-ID: <CAADnVQ+9yXTWNqmA23X5DERcUs=eqhcDbcKRTvNP+uq6UmyG7w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 6/8] bpf: extract map key pointer calculation
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Lau <kafai@meta.com>, 
	Kernel Team <kernel-team@meta.com>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 4:37=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Calculation of the BPF map key, given the pointer to a value is
> duplicated in a couple of places in helpers already, in the next patch
> another use case is introduced as well.
> This patch extracts that functionality into a separate function.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  kernel/bpf/helpers.c | 31 ++++++++++++++-----------------
>  1 file changed, 14 insertions(+), 17 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 0fddf7d0954b..5ea18509bc37 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1081,6 +1081,18 @@ const struct bpf_func_proto bpf_snprintf_proto =3D=
 {
>         .arg5_type      =3D ARG_CONST_SIZE_OR_ZERO,
>  };
>
> +static void *map_key_from_value(struct bpf_map *map, void *value, u32 *a=
rr_idx)
> +{
> +       if (map->map_type =3D=3D BPF_MAP_TYPE_ARRAY) {
> +               struct bpf_array *array =3D container_of(map, struct bpf_=
array, map);
> +
> +               *arr_idx =3D ((char *)value - array->value) / array->elem=
_size;
> +               return arr_idx;
> +       }
> +       BUG_ON(map->map_type !=3D BPF_MAP_TYPE_HASH && map->map_type !=3D=
 BPF_MAP_TYPE_LRU_HASH);

BUG_ON-s are frowned upon.
Drop it or handle the error case.

