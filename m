Return-Path: <bpf+bounces-74328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF14C546B8
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 21:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B4764ED3B9
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 20:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9ADD2C11E6;
	Wed, 12 Nov 2025 20:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T730cRJI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9E1285045
	for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 20:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762978612; cv=none; b=XSqBy06x10A0P+nf4m8Ohl3ey5puly83Yc/Pext9N6CfH1MIAYTF4mXdl97BmqJ4layZnUDVnShvSFThS/eyDmRRgrRneR/XlD4cwRC+OpRoZm9l0m9rYx7CRpAg68VWyU/7P3G3hIe7aPzngy47P24cxcMsdg7hzAYknzXTDGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762978612; c=relaxed/simple;
	bh=gPFd5y0rR8p21X+3l9xdR7CUDfAx+2Mt5Sfjeix2bIg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yq5P5DuDvZP8TrZuQos1aP7JlvE/p9Pa/2TjpClaC3HwMcuQv01IdphhwCfpGak6lHfzKR0IQIUf+OXUhPG+ew82gjdyGTqST3gWYbwviG1tuVkH9F0WhWThQ4jcP6p8IT3s+asHkQaCYA/qZn6PRWBvphiUipmvWUjeRHltpZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T730cRJI; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3438231df5fso48761a91.2
        for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 12:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762978609; x=1763583409; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iy9QvFMHYMC0PPM0G9nClDSW+eIfFhvEVPmCMvOH2bQ=;
        b=T730cRJIVCoveDDyvJsa0KCNTZ+y3j/zaGwV/2dwfVnOB0MZQjO2aFprPO2zno3hjz
         0+YXOQhBfBCGZi2kZloyHSIY5eu2ejrHZ8kv+BB1PuVbJCu0R43CWsGGTEuo/Zpox2se
         heLiJsa3BOWgOW/7ndnx4B2IEj15/l9QUj3tKr5HnFa+1CiGI6rCr1KZDXqUrWQLbu3l
         xaqh2QMvvrlbddPgNHKaOX423zXnB+L5Qpu2qnOyaA9zPVpbmK8O3/Mk/HIATU8uFb7o
         BjMkzGeRu2L6lnhRrLnoah+n1uaZcLYviZSz1Ev4UypfyhShJJvhl0K/HJk1tZ+vYFE7
         VD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762978609; x=1763583409;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iy9QvFMHYMC0PPM0G9nClDSW+eIfFhvEVPmCMvOH2bQ=;
        b=d2H/wW0yjpEvzOb2rHEvfxjVuCtkjhClX9DGDQwlmyxoe2upue2qhUeWOo2Yw9hJ+a
         8Vn1kSK09LHr2wPjWd2E9AkU+ZTcfFbtEz8TlWe8Ur8024mTIiBKzvsAiI8Ol96/nojr
         LkkRAq3642huv5g9Ui5AzBIBW6VzDCikQImcDCn7+7PY82PooHYJQNhUuI095Juf+L8B
         O0POjB57eTBjutrIlZly1dsbAWxoNnUgqBDjViaf2yeUWJHC8w3V80CHaaoQ2SaAGZ3Y
         e5ePfsOGeJ5MYd7IW39WN5X8ApPD8KXh6Yl6sPUOe6kFnGfHUET6n912B35MuRrsZr7e
         WrkQ==
X-Forwarded-Encrypted: i=1; AJvYcCV97G4754DGkSY+vPMyW40qGA4T/NVTt1vzypVLq9sxheTm06vP2xfP1LVnKQFw1PGQ1pU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDMpTOz9cKJVHcgdCi15Ss7Rr8jEO/Jq+e4QBMKLoieBqEXXDW
	fW2Pn6+/GCfA81+cT09D4EgdmH7Bu9LS/+dQOQyYRL0qMsWFFV9fqdrR
X-Gm-Gg: ASbGnctO1mkTO9jaAWX24wk4qtyaDweu6Y/MwwylOt8R4KiO29VKOZ4Vb7y05xBV+QN
	XpAeUnsdmDtbLuaPT8n6cj7pu/FqAbnQbVxdrnoqGdyFFsT5JZXtTQd0I33VzFFqGH5x64N8zq/
	SJHKj+TwFPEg2TkqGRs0dRlqXCo6DAUU6rqamri5HE99eiWOlIwKSzFs8+4y0X8yFNaTfL28wd+
	GYtuhgM4qPv8f3QkD7a/dalJ7Tts1lhY56puqMzFuyoJWws90qIhKheTg9SdAApRU/WxRmZRiA4
	kPRnhyxvq6x1tWCZhJYh6dwyrHLlKtSpHpLKM0ir9GkSf2npHueYX7vLA4sETLJzXUHxSalfZRN
	g9Rw0gDilwPtMAckaUPq8pORLvkcO6qBCvlKZlX8RC/4YJ86LmpngZa+9kerELhGAPXjZz0RMBt
	XyOckeB57d4GcXUh+JDPsqC/WNIXTOQYGKRaXJ
X-Google-Smtp-Source: AGHT+IFT2kSJitShWf+rBUmQwnvP/sUF7RjsGACgdyKqifAKv6G5C/wsXFal3/hzc9Gwi+9nzTbYqg==
X-Received: by 2002:a17:90b:3a92:b0:341:3ea2:b615 with SMTP id 98e67ed59e1d1-343dde29c37mr5533570a91.15.1762978608682;
        Wed, 12 Nov 2025 12:16:48 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:3e6d:747b:3d83:10e8? ([2620:10d:c090:500::6:aa7e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e072580dsm3532839a91.8.2025.11.12.12.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 12:16:48 -0800 (PST)
Message-ID: <31a5fcc60535d93b8b8ab7e9ca38487038fc38f7.camel@gmail.com>
Subject: Re: [PATCH v2 1/2] libbpf: fix BTF dedup to support recursive
 typedef definitions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Houssel <paulhoussel2@gmail.com>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Martin Horth <martin.horth@telecom-sudparis.eu>, Ouail Derghal	
 <ouail.derghal@imt-atlantique.fr>, Guilhem Jazeron
 <guilhem.jazeron@inria.fr>,  Ludovic Paillat <ludovic.paillat@inria.fr>,
 Robin Theveniaut <robin.theveniaut@irit.fr>, Tristan d'Audibert	
 <tristan.daudibert@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau	 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song	 <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh	 <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo	 <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,  Paul Houssel
 <paul.houssel@orange.com>
Date: Wed, 12 Nov 2025 12:16:45 -0800
In-Reply-To: <c1b79b23c2a20964792961f23348970ebaee14b8.1762956565.git.paul.houssel@orange.com>
References: <cover.1762956564.git.paul.houssel@orange.com>
	 <c1b79b23c2a20964792961f23348970ebaee14b8.1762956565.git.paul.houssel@orange.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-11-12 at 15:11 +0100, Paul Houssel wrote:
> Handle recursive typedefs in BTF deduplication
>=20
> Pahole fails to encode BTF for some Go projects (e.g. Kubernetes and
> Podman) due to recursive type definitions that create reference loops
> not representable in C. These recursive typedefs trigger a failure in
> the BTF deduplication algorithm.
>=20
> This patch extends btf_dedup_ref_type() to properly handle potential
> recursion for BTF_KIND_TYPEDEF, similar to how recursion is already
> handled for BTF_KIND_STRUCT. This allows pahole to successfully
> generate BTF for Go binaries using recursive types without impacting
> existing C-based workflows.
>=20
> Co-developed-by: Martin Horth <martin.horth@telecom-sudparis.eu>
> Signed-off-by: Martin Horth <martin.horth@telecom-sudparis.eu>
> Co-developed-by: Ouail Derghal <ouail.derghal@imt-atlantique.fr>
> Signed-off-by: Ouail Derghal <ouail.derghal@imt-atlantique.fr>
> Co-developed-by: Guilhem Jazeron <guilhem.jazeron@inria.fr>
> Signed-off-by: Guilhem Jazeron <guilhem.jazeron@inria.fr>
> Co-developed-by: Ludovic Paillat <ludovic.paillat@inria.fr>
> Signed-off-by: Ludovic Paillat <ludovic.paillat@inria.fr>
> Co-developed-by: Robin Theveniaut <robin.theveniaut@irit.fr>
> Signed-off-by: Robin Theveniaut <robin.theveniaut@irit.fr>
> Suggested-by: Tristan d'Audibert <tristan.daudibert@gmail.com>
> Signed-off-by: Paul Houssel <paul.houssel@orange.com>
>=20
> ---

No differences in BTF generated for kernel when using pahole built
against libbpf with and without this patch.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

> @@ -4939,7 +4979,7 @@ static int btf_dedup_struct_types(struct btf_dedup =
*d)
>  /*
>   * Deduplicate reference type.
>   *
> - * Once all primitive and struct/union types got deduplicated, we can ea=
sily
> + * Once all primitive, struct/union and typedef types got deduplicated, =
we can easily
>   * deduplicate all other (reference) BTF types. This is done in two step=
s:
>   *
>   * 1. Resolve all referenced type IDs into their canonical type IDs. Thi=
s

Nit: this passage continues as:

      * There is no danger of encountering cycles because in C type
      * system the only way to form type cycle is through struct/union, so =
any chain
      * of reference types, even those taking part in a type cycle, will in=
evitably
      * reach struct/union at some point.

     I think it needs adjustment to refer to typedef as well.

[...]

