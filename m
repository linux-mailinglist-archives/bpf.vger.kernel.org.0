Return-Path: <bpf+bounces-33912-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62939927E57
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 22:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09C5E1F24A23
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 20:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA92C1428FA;
	Thu,  4 Jul 2024 20:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mndlzo+X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3125E45945
	for <bpf@vger.kernel.org>; Thu,  4 Jul 2024 20:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720126604; cv=none; b=c5AwAw4I30e5xu5YlI2daLaiTYwNO+hgQYPJCsmlWfp1wsF2WuSgSOYXC4aRac+SyKxoLnUAbEPXUA09olcnw5XCU8hypuYFhGMIUHkfIMOJZEepziURm8c2YSfxzDmR6EZbVToarGq+vlK5jm+L4uMBiG17AVlUrR+9xapmfjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720126604; c=relaxed/simple;
	bh=ItNzLTp59PKGpWz+AiKDftCCiiRwXM5Rb6WWCWfelw8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nM/kXjZR7dCfQnXxRhZR6SRqDN34zWQt7aGF2JqfzMGk3nejj1q6nq7ScqHAr8AJUNAcpOmtKaV8QPD37sgpznOnBdOqIDLw9+wKDkY6k0vVkU7yWmK6jIsXnZHbyYoeBGYqre1lf1aqncGS/DEhhUvTAsbo4kdFOMnNn64zDDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mndlzo+X; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1faad2f1967so15353165ad.0
        for <bpf@vger.kernel.org>; Thu, 04 Jul 2024 13:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720126602; x=1720731402; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YBpkWV/WHHVW4ZN983R3oU+Qwvd5M0RMkwK5u2fvDvg=;
        b=Mndlzo+XuG3C6Pmpy2Y8JC6y/B5daGr352oyl2GmjxJaxjNcAAyih3N/qSD+3uf5KR
         HYd0fEtCFrzSiola7KpLH+kno8TwjIiVRW4s45ULts8IYW2PUU/hTIVy7kK8vpgmjHGd
         j+OQo1FfwpSHsm6RJjHd5dlqEfulprG5qYwliXFn+3YusJztXs1OC68bsqdXMJ5a/jat
         LpppdtcVHPSTrtd3qxJHEUuuM+r52suhrFpn8yfQToCrbWjk1SZwZPVXLg4dS/P4k+MH
         rDy+xyxiLgDrFx3n2sWvdJB+f3YAvRny4gdY/PiD+lzuYOjuOanZqGL24In+leRlZnak
         ImkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720126602; x=1720731402;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YBpkWV/WHHVW4ZN983R3oU+Qwvd5M0RMkwK5u2fvDvg=;
        b=kno20gg4RMUHKXq2IAJfJJVLTJ1bgT6hjJ5dRPBPamVtYUiCqU9Z1ge8qP+wsb6bMs
         KRXuvOEa0XZXrxYDGinEp6zgbdQW98ymqLLhj0UmKTGxnNTbOulghJUxp44/fUJZA3LL
         22a1YEE98VmblYReetFjoH+TzF1peChw0I3SnJUSXHtmMY+5ZN1Na89IhO1/WxTkT/JX
         FGVcntLZpcYqHVA0IJdu8ye2wGmzhjX/lTa/7A+64yBalQBSQs0saOkm0T7RJJjY2uNH
         RZcMQYHtLw7bpTeagNXxZoxdRYZN+yRDxsXHJtRDHvrtG49NYPPMVyDoHZQ2DQa90HXF
         Xdow==
X-Forwarded-Encrypted: i=1; AJvYcCVVjul61+mVFo64HqTRU/Gm/fzGt9TLGI34NIdQYN5dzE2ot9HZX3khE8Sz8fRGsKafglpXr33yvRKgRl7Y9eiM2g+A
X-Gm-Message-State: AOJu0YwHbuzN1q5O+eoV0H782DB30+Ek+wMccntVIfjD/A0wv0MkKyD2
	RFkCPTWh4f5WwYF+NgpSoim5tSjI565B05wYCC+2b9AUJHLgyRqM
X-Google-Smtp-Source: AGHT+IGdmLfbw0XR5e/cCvAnLouL5vHMs0gKvJuixMiYUAh8ixmiInyTatA2y6bwGyK/PyjHT0Nq7Q==
X-Received: by 2002:a17:902:f64f:b0:1fa:ff88:890c with SMTP id d9443c01a7336-1fb37060753mr41136855ad.19.1720126602272;
        Thu, 04 Jul 2024 13:56:42 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb1a3d081bsm37870385ad.221.2024.07.04.13.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 13:56:41 -0700 (PDT)
Message-ID: <2b28deafbfdd5cccc0781bb95ebf8a966ceb6c74.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/2] libbpf: fix BPF skeleton forward/backward
 compat handling
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, Andrii Nakryiko
 <andrii@kernel.org>,  bpf@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com, Mykyta Yatsenko <yatsenko@meta.com>
Date: Thu, 04 Jul 2024 13:56:36 -0700
In-Reply-To: <13891abf-3c88-4369-8fe3-0fb8f5673038@oracle.com>
References: <20240704001527.754710-1-andrii@kernel.org>
	 <20240704001527.754710-3-andrii@kernel.org>
	 <13891abf-3c88-4369-8fe3-0fb8f5673038@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-07-04 at 16:16 +0100, Alan Maguire wrote:

[...]

> Nit: would it be worth dropping a debug logging message here
>=20
>=20
>         /* Skeleton is created with earlier version of bpftool
>          * which does not support auto-attachment
>          */
> -        if (s->map_skel_sz < sizeof(struct bpf_map_skeleton))
> +        if (s->map_skel_sz < sizeof(struct bpf_map_skeleton)) {
> +		pr_debug("libbpf version mismatch, cannot auto-attach\n");
> 		return 0;
> +	}
>=20
> ...as it's a hard issue to spot?

+1 for debug message, but this is not an error condition,
so I'd say something like "..., skipping auto-attach for struct_ops".

