Return-Path: <bpf+bounces-28465-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8758B9F5E
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 19:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78061B21BD1
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 17:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3DC15E5A9;
	Thu,  2 May 2024 17:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oy3tmieJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A69616D9D1
	for <bpf@vger.kernel.org>; Thu,  2 May 2024 17:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714670441; cv=none; b=pXFo9En2UcylJ4li65Y9VBsfUKw3dCwDTMHAsBRX2ia2nM4p0kvJwDAthkRlKDs16kQljKpgSHE6ytO8pznHqD0qOtf44cgW267pDMpm2EO7kTfHs/ejYFrMEBeFsuo0vw6KZEvjaLZxhi48uatoSI4u6qcSPpboTUv/p9E5OaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714670441; c=relaxed/simple;
	bh=VhOejjmvQh0MO1ktRzefBNavI+jQPT4qirXMsRitAjg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U2Uow4/9dS0/oi5j0n6UhpReE+meq+aRQXVfgHvf8whuWyKjQGrRiMmpRvxSkLxBGgLQA0J2JQFl0xgaxDHJjt9WbAeyTZvIv72kUQ+d2Jc+ZndMRjxIzFBbpbJqaumE/P9Wia0Pv4q7cq14RABWKzoFNsnpt0OpLXZu60/+cQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oy3tmieJ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1ed012c1afbso6159705ad.1
        for <bpf@vger.kernel.org>; Thu, 02 May 2024 10:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714670439; x=1715275239; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3jADiLYx54wcQ/dnAqkp6UYRgueX7NutPSzWYlg3LiU=;
        b=Oy3tmieJV6rqooeT6L3DMvoMJgQ5iwdo5bWarlerirFysgKQFWoIv+p9bRbUXDbrcX
         La6crH5b9zElLzDJIJH+bcoTT0RnL1bAIquNUDtNQgYjpm78ORURQXtTfOgsECTRigX7
         qctj2+wprKDEA2YcUs9OWb3UcunG4xrJVMTC+eEqywZ2a1zVNPsCcUUrztqvMa+Yhs/1
         m5ovxXiVQj10RM5bVgikQyeDdytTmQ3YG6oNQxLXieGmMUmwu2EaosabXmvbKrYYtm1i
         YoiAv1hHg7L8pk//REoMvOzWSq6X084w24M6Kdvt1wR4KhOMI3M6y0IxfjGJBaEpERsp
         R3uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714670439; x=1715275239;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3jADiLYx54wcQ/dnAqkp6UYRgueX7NutPSzWYlg3LiU=;
        b=ZWWAaquCuWP6mq8oT7ZntBD+m/3S/DLTiLDNJr3M5C0DoSaS7qdbYLPFmpxJrVcB6l
         Y3HMsCxDsSLxGJzM81110szfSSm4TNwGVxK5mJrXh+A3dpcAMC389Nyh3a2AG5DBBy4Q
         2ST6/OL9rg0xe+rCnq7V1oBD7FC6E/ZFwk+TWFVPvwgRXs2uhfiKV4jQDyaENhvulNaW
         gPbAm0SLnbx8VySSlfcIGbV3biR6IhUuDK0g1Iq9b5+S89vrbJPEv9VYgxUFi5Jvxzok
         eTIG4uR8d7enjwFhReznRnWCb3xFHLOPpZOSqMv+H3BAKPMsEkc0gAsvfQ6EkV+j6Z5y
         2BFA==
X-Forwarded-Encrypted: i=1; AJvYcCUc7a6SKQmaZzQcqODHNFtlITopTc9RJqjmiem8y2p42cfhoA9AiQOeuSwv4LsEG/v2ON8Qy0L2IXgYAZPRZJ5SedCs
X-Gm-Message-State: AOJu0YwQ1asS/cI6sRWrb9d08A2l6NzZf0giLNsSidPBG+8Gk+1mPerR
	GZ6wqnq6yrdv7rknJ1Fo0/7Om7G4YPrK5hSm+EI7TuvAZMONGHyF
X-Google-Smtp-Source: AGHT+IH8yVprjmMrJ7UlJjf/M5E5VLut0MCJcqCnh8xoG/1HZg4UxliYPdadtN0gfWUvUZecdICnHQ==
X-Received: by 2002:a17:902:ea07:b0:1e0:e8b5:3225 with SMTP id s7-20020a170902ea0700b001e0e8b53225mr608483plg.12.1714670439457;
        Thu, 02 May 2024 10:20:39 -0700 (PDT)
Received: from ?IPv6:2605:8d80:4c3:8aa3:a6b4:2cc7:9867:3518? ([2605:8d80:4c3:8aa3:a6b4:2cc7:9867:3518])
        by smtp.gmail.com with ESMTPSA id j12-20020a170903024c00b001e43576a7a1sm1561744plh.222.2024.05.02.10.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 10:20:38 -0700 (PDT)
Message-ID: <017ecee002197526aa5d91d856c25510d36b57ce.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 3/7] bpf: create repeated fields for arrays.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org,  martin.lau@linux.dev, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org
Cc: sinquersw@gmail.com, kuifeng@meta.com
Date: Thu, 02 May 2024 10:20:36 -0700
In-Reply-To: <20240501204729.484085-4-thinker.li@gmail.com>
References: <20240501204729.484085-1-thinker.li@gmail.com>
	 <20240501204729.484085-4-thinker.li@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-05-01 at 13:47 -0700, Kui-Feng Lee wrote:

I think this looks good for repeating fields of nested arrays
(w/o visiting nested structures), two nits below.

> @@ -3575,6 +3628,19 @@ static int btf_find_datasec_var(const struct btf *=
btf, const struct btf_type *t,
>  	for_each_vsi(i, t, vsi) {
>  		const struct btf_type *var =3D btf_type_by_id(btf, vsi->type);
>  		const struct btf_type *var_type =3D btf_type_by_id(btf, var->type);
> +		const struct btf_array *array;
> +		u32 j, nelems =3D 1;
> +
> +		/* Walk into array types to find the element type and the
> +		 * number of elements in the (flattened) array.
> +		 */
> +		for (j =3D 0; j < MAX_RESOLVE_DEPTH && btf_type_is_array(var_type); j+=
+) {
> +			array =3D btf_array(var_type);
> +			nelems *=3D array->nelems;
> +			var_type =3D btf_type_by_id(btf, array->type);
> +		}
> +		if (nelems =3D=3D 0)
> +			continue;

Nit: Should this return an error if j =3D=3D MAX_RESOLVE_DEPTH after the lo=
op?

> =20
>  		field_type =3D btf_get_field_type(__btf_name_by_offset(btf, var_type->=
name_off),
>  						field_mask, &seen_mask, &align, &sz);
> @@ -3584,7 +3650,7 @@ static int btf_find_datasec_var(const struct btf *b=
tf, const struct btf_type *t,
>  			return field_type;
> =20
>  		off =3D vsi->offset;
> -		if (vsi->size !=3D sz)
> +		if (vsi->size !=3D sz * nelems)
>  			continue;
>  		if (off % align)
>  			continue;
> @@ -3624,9 +3690,14 @@ static int btf_find_datasec_var(const struct btf *=
btf, const struct btf_type *t,
> =20
>  		if (ret =3D=3D BTF_FIELD_IGNORE)
>  			continue;
> -		if (idx >=3D info_cnt)
> +		if (idx + nelems > info_cnt)
>  			return -E2BIG;

Nit: This is bounded by BTF_FIELDS_MAX which has value of 11,
     would that be enough?

> -		++idx;
> +		if (nelems > 1) {
> +			ret =3D btf_repeat_field(info, idx, nelems - 1, sz);
> +			if (ret < 0)
> +				return ret;
> +		}
> +		idx +=3D nelems;
>  	}
>  	return idx;
>  }



