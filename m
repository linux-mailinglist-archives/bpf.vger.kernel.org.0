Return-Path: <bpf+bounces-76686-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D511FCC109C
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 06:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74A7430046EE
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 05:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDAD33468C;
	Tue, 16 Dec 2025 05:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dms3mFpV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8D832F765
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 05:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765864703; cv=none; b=I3U99I+7XesQZQaMzfvM1vHoy93INvKqKWYECP42coDyCPFXPM+fveEZru1uitZX6ZZWAoTwYygK+2XFsGNMHhxr17eFnjFhED+TZMiIpOrp03kKvrXPG1g+hetNFk+bptbR9qOGs7mjsjsH3Hx9wvg4ONEe6UyySPyzUFMzp2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765864703; c=relaxed/simple;
	bh=sM3cNw5SIpD6IQ+LU+smmGWOeqggf2l3Ts/h3XPM7KU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fi2uGRpyRf0inUb61Dbd/nUX2jeYMvW0TmoqwY5Y/RVQ0zz+8kc8lHEK4FDTjJjDvDuggldhjo4AFULhyyJYF090rnXChYYLa9+i9yw5E4MPtNil0FGOx8lQBYB9ESP3D1iwi76BQAr4niGTzeLDVIFRLsRHG11eG5EyZtVcjEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dms3mFpV; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34c7d0c5ddaso1123015a91.0
        for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 21:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765864695; x=1766469495; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IVTImU2QQNFAuOXTdHLvkqMQomKRULNxJdHbr0KDxdg=;
        b=Dms3mFpVRZBitcSWGgtum/lNFyVfGlVKEMDOn+bNzD5Lh5priv2tpQbTu9lyhZLrco
         jezpXKmVnGFHwPyJQDNuUH9xL+UjW4JPsif2uBMRe74Uid6YMYPmaqLKuxDSajG06PVy
         MnwKkeYqvGL9p2S73Q5GfpwpVdXpbwOGW230wfCxAYm9357x4h6EChJZ7J1vfckvbI2o
         DkWStaNgZAotjQ1W4uoc1Hrbpb4gBRbTRAvAjD/w4bieooWeExoyr9pqYO+9F4jgqsVs
         bQJlqxynA+cIM7T2GRVkJ3K9AggEtG2tNRYFUd9te4RbtBJl2gFsZFwhcv2WzYDmzXZd
         3CVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765864695; x=1766469495;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IVTImU2QQNFAuOXTdHLvkqMQomKRULNxJdHbr0KDxdg=;
        b=oyAeDggzcGAoDQaB9RS41wllZYdkhcB7L8tBcpOCsqojStxjua2bDivynMPT3u7yxS
         FDUTCZPdOITz3qGVusA3etIACJJreRbDRTjyueU5kiMp5MLxNyiJlQTPtT7YeB6FFVFK
         Q9vGqwNGCggllUh33M+DSsY4Ja+Kg7/db6dgRMjp4HE5mUFn357iuBTayP6qgyvzKjOU
         M7u0iIGThE+qYjyrlmDxDh3pckafm65O0+8KFc7GDo+sdgWP1XNYBor2J756mSVtsWXD
         f1woV2WeYlU9ZCz/OQUvbx6cu+0qZr7uo39sUVT39wiQIkWeaGOeW/8n9asQ+6LzPhf4
         Xl3A==
X-Forwarded-Encrypted: i=1; AJvYcCVTnMP4mLfWO/pzG8HoOC5JgJFvJWAPouab12qCL+pyq5qkbV+Xro7D0m+2cMLUYO3RuX4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9/7LjMgLwxDgze913pQmgFv3kZ4V8ucIsmR4CoO1yFHeGMSCt
	B7X/yOudiYVePB285rB+X7CAc+uQUY7ayK0eQTXqtkAsGupCOLw+2uhF
X-Gm-Gg: AY/fxX4vueZkjyvBUonv532JnZ0a7n23H4RBKMm3qEuM1wRp8SvDZZY4LzCOGV495T+
	MueqLVe+Kh7U5UcBLHb08xSxl5biImzZUZWK5kqVnG/rc92bMPUQ8BiDN5b61U08iQ3MhNUxDnW
	xaemNHwQUB9UAIcP6Tdh70GyaMEYTTV2YnHg8s28QwnWvGLKzPkxz44IanWCluJAcc5ACzTrZdH
	w+pyiX45X4GvGNwSVLvGr9s5JAZcO8h+SqXsgSPltMVNarb2sUCyxRGnitb/6oDClS7cK25/cE0
	sBTIcPyt5IFGvBWbg0P6A3MbWWHMBYpgxiTDU2KYPpW2ArFYIroBC7gteaXqW+5HMPi8lAIEWh+
	w2HZzmy2yAh/zTHns1hLOFGGKKuIY+O5TQkp6V3v0d0bqvzV3BdY9nFy6Qd7GstguSu0s26kAIu
	IX/+IGhfw9
X-Google-Smtp-Source: AGHT+IHLNsvQdwzrBfeSHByDYIeQscxyPTYW9jk/uY54VBfW+Ug79KVvtcihVB6EuC6Db4DpraKqnA==
X-Received: by 2002:a17:90b:3c05:b0:34c:2778:1681 with SMTP id 98e67ed59e1d1-34c27781911mr10785620a91.6.1765864695242;
        Mon, 15 Dec 2025 21:58:15 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34cd215a212sm192143a91.0.2025.12.15.21.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 21:58:14 -0800 (PST)
Message-ID: <1456370aa292410bdda4bff85bead8e091675f4c.camel@gmail.com>
Subject: Re: [PATCH v8 bpf-next 04/10] libbpf: Add kind layout encoding
 support
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org, ast@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org, 
	ihor.solodrai@linux.dev, dwarves@vger.kernel.org, bpf@vger.kernel.org, 
	ttreyer@meta.com, mykyta.yatsenko5@gmail.com
Date: Mon, 15 Dec 2025 21:58:11 -0800
In-Reply-To: <20251215091730.1188790-5-alan.maguire@oracle.com>
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
	 <20251215091730.1188790-5-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-12-15 at 09:17 +0000, Alan Maguire wrote:

[...]

> @@ -1106,6 +1137,8 @@ static struct btf *btf_new_empty(struct btf *base_b=
tf)
> =20
>  	/* +1 for empty string at offset 0 */
>  	btf->raw_size =3D sizeof(struct btf_header) + (base_btf ? 0 : 1);
> +	if (add_kind_layout)
> +		btf->raw_size =3D roundup(btf->raw_size, 4) + sizeof(kind_layouts);
>  	btf->raw_data =3D calloc(1, btf->raw_size);
>  	if (!btf->raw_data) {
>  		free(btf);
> @@ -1126,6 +1159,13 @@ static struct btf *btf_new_empty(struct btf *base_=
btf)
>  		free(btf);
>  		return ERR_PTR(-ENOMEM);
>  	}
> +
> +	if (add_kind_layout) {
> +		hdr->kind_layout_len =3D sizeof(kind_layouts);
> +		hdr->kind_layout_off =3D roundup(hdr->str_len, 4);

btf_add_str() adjusts btf->hdr->str_len w/o moving hdr->kind_layout_off.
This should make hdr->kind_layout_off obsolete after each string addition.
btf_get_raw_data() does not seem to have any logic to adjust kind_layout_of=
f.
Is this a problem, or do I miss something?

> +		btf->kind_layout =3D btf->raw_data + hdr->hdr_len + hdr->kind_layout_o=
ff;
> +		memcpy(btf->kind_layout, kind_layouts, sizeof(kind_layouts));
> +	}
>  	memcpy(btf->hdr, hdr, sizeof(*hdr));
> =20
>  	return btf;
> @@ -1133,12 +1173,26 @@ static struct btf *btf_new_empty(struct btf *base=
_btf)
> =20
>  struct btf *btf__new_empty(void)
>  {
> -	return libbpf_ptr(btf_new_empty(NULL));
> +	LIBBPF_OPTS(btf_new_opts, opts);
> +
> +	return libbpf_ptr(btf_new_empty(&opts));

Nit: btf_new_empty(NULL) should work fine because of OPTS_GET.

>  }
> =20

[...]

