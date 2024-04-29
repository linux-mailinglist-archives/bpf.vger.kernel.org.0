Return-Path: <bpf+bounces-28217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0038B669E
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 01:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D20192842EA
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 23:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008D61836D1;
	Mon, 29 Apr 2024 23:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FE0Gk+m/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C94194C69
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 23:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714434232; cv=none; b=T7dCEe3zH4RiCOt4Wux6ipCi8KJEfMMoihdQc95Uej5KmWly/LOP21s8YxWQ3bjcWx1sCLA6LMbwQHSPboFLm3WVtBxSdaFJapH3TQIhr2tTdZZDoMilXFzttrYMtYiNIGY4KUqt40a1shnQBIIX+jhq9zayJQgIpwfqsYevI+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714434232; c=relaxed/simple;
	bh=5v9ujUWalGhr7P+8HS4eAMbipSMi25y1/nbggu0M6Uw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q1unl5kfvrzh5O4GxiiEqYKr1qhLOL/bWO+lEaH5YlF65SX5nmS2387hBUeA3bdurAsOoyZipruOuCpudgBEzjVEnoUytqVfwThr7BaVh6JAjjZJL1jBX4c+BBpVDkh6nyRiaUgFZDboflV+441pHBlP9XLtJkfcnCPTtYdmcwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FE0Gk+m/; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ae913878b0so3834357a91.2
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 16:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714434230; x=1715039030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOw17n0YsZcjjlhp2QsQu3hovhRIn0+j9HJZZ1WV1HI=;
        b=FE0Gk+m/fiFrYovzQgPOcsxpA1ifUqRQ8W6A7FIlhJK7k6Noy9tWrmQ2WtC0j5oqSC
         d/3L/58/XNuh4t5tLm2yETYtnYnO2F6nEuuywywlCvC85dHVXDO5DdlN+8FlwkXQwnx9
         pEHedvIydsrTW1xyCtm2eLyPtjKBSPea57jrCGU/NgoNRgCDc+9klV2fXSXFRpPtT5wT
         HqRYkrTYI4GyV77IriG/oCtc0DkSE8LvGeL7KogrrapjYRSs/egaMB+Urgt/c+a3j4/J
         CIcpZy1VmSO8MpvzhvtifeowqdnRBdTG6B0aICTPu0yDGlacjsHMnMTcJL3njkGDMBe5
         VtuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714434230; x=1715039030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dOw17n0YsZcjjlhp2QsQu3hovhRIn0+j9HJZZ1WV1HI=;
        b=GBcs6JQvCKJ4r7Oe8cmNFcPR5h0jN4CJws+iFZZbc7fQfYy6mwUTlCxolhVfOffG2G
         RhJN257EsYvGGXk7TK9s8PUU8IBT2SmCQZOAQ2P0aaq4RF5S9dpRGqXN8HyeZoRgBFwY
         gtSqO0Q2UmH7p/FnpQHuNuKkLSS0Po8CbnNdF+/3KNg0uAh3yGeBNuu+89O9ws5mfdjA
         N6uRj5EuZUVjdBSxuDSvxPq8VV3v4q90VKrv78KuPprOpxd+3ChW7dxYX45syu2k1zDz
         CN/Qpl4T+AdOglzbUqNmA4ZN7MQOCy/sX/ch3s5EJ9YQLI5eLEoa/nbqUMP688pwOk/F
         ru6Q==
X-Forwarded-Encrypted: i=1; AJvYcCV6aKpecAfnSgUaNz47w45bLzCWDIMSehH21v9nkix9kApv76YBHvR+DI4vq1G1DESTyZgX/tdp6yYCkedgAPzSYo5N
X-Gm-Message-State: AOJu0Yz8lyWwUwJJ23wxpMwuVRrJjjNh48/wzcTNuhO414GMBrrix6U/
	JJnVESQni71d05+Cd770gDUO4AcPyt5Pw2D2ex+aYvYPUUmaaG2DHpDFhfR+1fRiwUZvcd9cqU0
	opYyLhwbgJUtCQBsQJGherkb/druQ332C
X-Google-Smtp-Source: AGHT+IEuH9VDx8fuwB6OH5LpyU7z+s6BmO0dJ7f6k8v9GMoDioNYWLr//S2msUS8bDJGhXT9s8qzwSZh0kUMiG2PAC4=
X-Received: by 2002:a17:90a:8810:b0:2ae:c8fe:a4a4 with SMTP id
 s16-20020a17090a881000b002aec8fea4a4mr7106465pjn.46.1714434230396; Mon, 29
 Apr 2024 16:43:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424154806.3417662-1-alan.maguire@oracle.com> <20240424154806.3417662-7-alan.maguire@oracle.com>
In-Reply-To: <20240424154806.3417662-7-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 29 Apr 2024 16:43:38 -0700
Message-ID: <CAEf4BzY_-nJe2VkCjw7AkOr_g3njZAy_rcBVO+UP_wgioNw3Hw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 06/13] kbuild,bpf: switch to using
 --btf_features for pahole v1.26 and later
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, ast@kernel.org, jolsa@kernel.org, acme@redhat.com, 
	quentin@isovalent.com, eddyz87@gmail.com, mykolal@fb.com, 
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org, 
	masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 8:49=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> The btf_features list can be used for pahole v1.26 and later -
> it is useful because if a feature is not yet implemented it will
> not exit with a failure message.  This will allow us to add feature
> requests to the pahole options without having to check pahole versions
> in future; if the version of pahole supports the feature it will be
> added.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  scripts/Makefile.btf | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>

post this patch separately? we can land it sooner, right?


> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> index 82377e470aed..8e6a9d4b492e 100644
> --- a/scripts/Makefile.btf
> +++ b/scripts/Makefile.btf
> @@ -12,8 +12,11 @@ pahole-flags-$(call test-ge, $(pahole-ver), 121)     +=
=3D --btf_gen_floats
>
>  pahole-flags-$(call test-ge, $(pahole-ver), 122)       +=3D -j
>
> -pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)         +=3D --lang_exclu=
de=3Drust
> -
>  pahole-flags-$(call test-ge, $(pahole-ver), 125)       +=3D --skip_encod=
ing_btf_inconsistent_proto --btf_gen_optimized
>
> +# Switch to using --btf_features for v1.26 and later.
> +pahole-flags-$(call test-ge, $(pahole-ver), 126)       =3D -j --btf_feat=
ures=3Dencode_force,var,float,enum64,decl_tag,type_tag,optimized_func,consi=
stent_func
> +
> +pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)         +=3D --lang_exclu=
de=3Drust
> +
>  export PAHOLE_FLAGS :=3D $(pahole-flags-y)
> --
> 2.31.1
>

