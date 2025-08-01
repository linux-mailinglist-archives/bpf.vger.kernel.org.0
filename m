Return-Path: <bpf+bounces-64910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 750A7B18574
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 18:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75AE517E635
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 16:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1487B28C871;
	Fri,  1 Aug 2025 16:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLZ1QWHL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B8728C5C0;
	Fri,  1 Aug 2025 16:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754064579; cv=none; b=dCWtcPfHEPonY77CzHC5Q3eS5Vqj1sTNjolF2HlopzM1aorI/MD8upe8DKzPhUa2UNekfvRcEe9rsmiKMVpIcW3PmgzD8hGN4vSD0wCVSpRhnuewEBE5xkoeP+qcOcYsGlHoXSY7TAhnIEUX21tYyGdVXYsFEHnlcYAuEu6Ofdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754064579; c=relaxed/simple;
	bh=nEem78S3EKLbyxgVtK71HhdlTM0Smhwa4fPZjFNXh0M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LC/qEwFKYCJKWIx5zgt/dKydnV9A3EUa2lOpyYZsLpO7LhJSQ0p6J954KUNEgshq0AEwV/RM4URDKUwVwIPYxGL+7k/kNyO41j2AxsqOdOy+qppDgGyfpAquVtwNfA7hj+Z66aaiVllLqE2fhwy4J1Zph9/PpKPI3rUTzjt8jWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MLZ1QWHL; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2402b5396cdso15518435ad.2;
        Fri, 01 Aug 2025 09:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754064577; x=1754669377; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mu7JOTA/2SJhfVdwxLAP1JL8OuHZOfEARn9f8m8RloM=;
        b=MLZ1QWHLGaIJtzaK4GaRR14fsudpxDAdtt/B/sflPfndyUQD8od3dhaT/98yEk66eE
         fLW4AWciKxQQ6LYza5+3gup+qlrjdEd3o4l/qaG3jF/V2PRI1KGhi9Go5p8eKUR9j0Wm
         w8+BKKVRU5VAusNYVBE9PDb4W2Z17PHalF7WxEWKlwboD2vXCTDGNkMMpHv0kCRh/Lyv
         qEH1ZIjtez3C+4E5y/LHmISgJQ8u3d8iItlVMlQeNYRgKub3h2lJal+etX7n2I/8Ht0I
         r6bi7FAYEJ/4LWUYh8tZj2x+F97llyMDFOEfEaiKQCvHy1QPfQ8PcvVBbsilenwlClqG
         x+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754064577; x=1754669377;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mu7JOTA/2SJhfVdwxLAP1JL8OuHZOfEARn9f8m8RloM=;
        b=A9ojWMmvwIOV37mm/CRXMpX3wPYzhC6WGFFW7e02qiNpZrrPSWx6drcn6LLL7vlF2C
         Ik6s/oEGe5pFINTvtC+xLPI1zy4LrKnSMw6fa3sd5xjavXewZmDNtcFrnm+4oBa7SLWp
         12csL9HAPkjeVIuttC0Zh7LQsuKWEjNPKzaW/DmjJPYFeUxRJb2CWPJH0vBF8Hf693Y9
         bjbuYJh0dS3hP1JCPuOOGMWgfgsh5RZ3Wh36RK2U8CvzH2u2T93yPfngHmfCGqFyl3ap
         tw2HQ/oiM/ZvEs3h5syQisSExd2UjhtUz/i17jKFQzONnFSslOfgl4N7gxIqBX8H4sxZ
         7HFw==
X-Forwarded-Encrypted: i=1; AJvYcCV8SdY1G+90HA0pis32FtXmLja8E7KaFeOIy+f7ZajViZZxmteSmTr7tdVvideakokA/NA=@vger.kernel.org, AJvYcCWXW5TAKGwBiLjIXzakvGIgIRZI8+BeUY4L7VcN0XZxaMx23YiPyRFRShI5pkNeIXdcNc1cMigbvnpNENvyONsM@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1yuFS30ax1nfKJzcO6KyGNC7cMsh4xjQTsRuC4kX9143pmN3j
	hjb2kquqwrEAk1Pk27IgDnKTYOhA07BdHbd5l+S/I8ip66FtHvA/ZWqKHpQBLCi4
X-Gm-Gg: ASbGncv/5i0gq3AVKxH5yPbGXbAV6uyAqAQ2teNK/K+haQ/EXlru33oSlCIO7gK+OEe
	0EyG5N0MV+K36Bq8TQjyJsQsXMTG0g4rhk4rUTvrMVRlTCGt5Ywz5pgo9LwAnFCXIvoUOtahOEa
	XC8P6AkU7cEgCb0gYmBk+lXpN9sX+k+JbwreItqXvgEMBp6ezMdF4mvQPyO490Y7OpmpsjvSj/v
	Vn+pOwFuACSK6lBqdyuPoRSMFx7bMt+ws9ULVFdx0Ff/HGCUkche8Cy16HbEvHOaDyVi9LPAlKB
	zIWuS3Rbg2RtWYBX03oCRVGaLZPL5s8G7JhGoQkSP6ZskvgzatiDdVKP+YgYtcywZ0HgMd3WlIA
	sQsu9g47piZFEIFFaLVfZBUNuLZeWsg==
X-Google-Smtp-Source: AGHT+IGwfJVFc6MH1aBgVUpSzpG4QW3BbfTVcl5/uqmD/IQkws7XeNOj6jg0XVcSsrd203gcZDSgBg==
X-Received: by 2002:a17:902:d487:b0:240:4d19:8797 with SMTP id d9443c01a7336-24246f8c70amr1397045ad.22.1754064576922;
        Fri, 01 Aug 2025 09:09:36 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3207ebc2f3dsm5043646a91.14.2025.08.01.09.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 09:09:36 -0700 (PDT)
Message-ID: <5e7b3c728c88b238224d3dffde4abbd7567b8d1c.camel@gmail.com>
Subject: Re: [PATCH bpf 3/4] bpf: Improve ctx access verifier error message
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, netfilter-devel@vger.kernel.org,  Pablo Neira
 Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, Petar
 Penkov <ppenkov@google.com>,  Florian Westphal	 <fw@strlen.de>
Date: Fri, 01 Aug 2025 09:09:33 -0700
In-Reply-To: <cc94316c30dd76fae4a75a664b61a2dbfe68e205.1754039605.git.paul.chaignon@gmail.com>
References: 
	<cc1b036be484c99be45eddf48bd78cc6f72839b1.1754039605.git.paul.chaignon@gmail.com>
	 <cc94316c30dd76fae4a75a664b61a2dbfe68e205.1754039605.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-08-01 at 11:49 +0200, Paul Chaignon wrote:
> We've already had two "error during ctx access conversion" warnings
> triggered by syzkaller. Let's improve the error message by dumping the
> cnt variable so that we can more easily differentiate between the
> different error cases.
>=20
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

>  kernel/bpf/verifier.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 399f03e62508..0806295945e4 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -21445,7 +21445,7 @@ static int convert_ctx_accesses(struct bpf_verifi=
er_env *env)
>  					 &target_size);
>  		if (cnt =3D=3D 0 || cnt >=3D INSN_BUF_SIZE ||
>  		    (ctx_field_size && !target_size)) {
> -			verifier_bug(env, "error during ctx access conversion");
> +			verifier_bug(env, "error during ctx access conversion (%d)", cnt);

Nit: maybe print the rest of the fields as well?

>  			return -EFAULT;
>  		}
> =20

