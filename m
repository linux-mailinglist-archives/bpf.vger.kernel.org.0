Return-Path: <bpf+bounces-34692-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD35930156
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 22:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 691C0B22CA6
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 20:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE6C3C684;
	Fri, 12 Jul 2024 20:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E10VdL5Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187F31BDE6
	for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 20:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720817357; cv=none; b=kipk/4JR4MsAWEQVdn3hZyyw0bGjuu8gzjUOTMWTmmCKI/zVeM7Oa20ykW0pOskumgP5FJq0relp2CCt0jlUJJgOeBZa0yXcm2v2VtYovMaTqBOSofVNJrymHCEtUU28kqfpx6ibaJwIxK15MaQg5TRe4smyt+CP8gmivDI++QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720817357; c=relaxed/simple;
	bh=UQ2jGNGXdtVoASHyqJYS5LQxjKMskB6uZdKjElqddZw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HGUuHgjA1eMyjC6+DigyYiUZb3f8/Fg7h7vlqn1/v15tJ/x/PdsJpRM2IvP1vhcuSd2edG6VMJA846kmPmPRpDg3MO52A+wKtIuhBupfez7+LFn/iSseR8kfuFNXGhzh19vqJJPFeMSEqYCNl/kuyPWyGyjgF9DnASeGKkuYL+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E10VdL5Q; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70af8128081so2039515b3a.1
        for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 13:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720817355; x=1721422155; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zttnmfXCVNKBFEC4aZen+XOiFl5Unmr/1ZHVAZhslng=;
        b=E10VdL5Qu+dC5tgqkyWcd21FzetmAn8TlKK+CspSoGxwCR7avjmoLKD+E3XpHh/gx7
         B8LhCLsGKI7yXCEkY4vrEBCmFcp+eRTLIK/NaUD8Msga4ra8BXS2k/uks2q5QB78RWjp
         msShK48ZTOnl1MvoGDx80/0SEKtnw6n/gxijUUBxh0SmmLUGqkBCmbPFNZipOK7jmeEM
         wmZ6InjGTo3x8de6cIrYgHLNr0E47nty7tNI2iXtrJ6n3Wxf/8rDo2NTtB+Nnch08JJu
         H+8di/bW5mkxEWHyFch2sRgwOCeXLH2OVNSK5tkLBPABI4OEztzZq//F+b+gqGqHCv1e
         +mhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720817355; x=1721422155;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zttnmfXCVNKBFEC4aZen+XOiFl5Unmr/1ZHVAZhslng=;
        b=eyKu0Odt50/EdfJizhWrbvvllR3AQVTLJLS29mm6RR9rXGIdbPeGH0g5SPobjIbD63
         9zvg14CeS49EJHVq/9L1oo+1adLItZLBLBhVOHjJEj7SHCoyi5jET1VrkOGw3e55lWW1
         EhJXcZu917s0dIq7ZZSBvIOLT8dJZJKCjD6tNsohVS09LgYfHAPfAcbET9S0gLK93AkK
         6aD8b9FZmBgLasW3+PpruoG8xshyaHMjqcw0kUMp2JPKHicw6+eaGoVx4/IwiZf/FVR1
         90bnt9IZmdCY6bqMXJsyQ8soHdt2NuJMMANV+v6EFUAgmg62q3FpWfEjQQJ6dBZdsfdW
         TkKg==
X-Forwarded-Encrypted: i=1; AJvYcCXjO2rts5FJQTNS9mLe+eaxTK0Lg8+0bTrMRe+Ii/GYZLGvfWJlPKh4TOnn2PLsNN4AlK8Ph/rP1xCij2VR/zRRNlma
X-Gm-Message-State: AOJu0YzcvLZ5wXD0A/fLrryrbVZjzuAsFMGJz/W5R7sdZMg6MnWsEgIG
	1ORto5lT6iAgP/5VFzSJOzddLhJEXnrn6QvlxZzQoFdBURxJ13Zh
X-Google-Smtp-Source: AGHT+IHNYke1OevZi36RLV71VT7c9NEAuQ4AAWAv3sZtubTFDPbyy1LZvYl3gADkiP8RjFBJgfjQGA==
X-Received: by 2002:a05:6a00:138c:b0:706:6f18:839d with SMTP id d2e1a72fcca58-70b4356f66cmr14489892b3a.14.1720817355144;
        Fri, 12 Jul 2024 13:49:15 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b54ec749esm5408139b3a.52.2024.07.12.13.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 13:49:14 -0700 (PDT)
Message-ID: <e05bd24690aab17ec0764e6318d13bf5690f6bdd.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Get better reg range with ldsx and
 32bit compare
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
Date: Fri, 12 Jul 2024 13:49:09 -0700
In-Reply-To: <20240712202815.3540564-1-yonghong.song@linux.dev>
References: <20240712202815.3540564-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-07-12 at 13:28 -0700, Yonghong Song wrote:

[...]

> +
> +	/* Here we would like to handle a special case after sign extending loa=
d,
> +	 * when upper bits for a 64-bit range are all 1s or all 0s.
> +	 *
> +	 * Upper bits are all 1s when register is in a rage:
> +	 *   [0xffff_ffff_0000_0000, 0xffff_ffff_ffff_ffff]
> +	 * Upper bits are all 0s when register is in a range:
> +	 *   [0x0000_0000_0000_0000, 0x0000_0000_ffff_ffff]
> +	 * Together this forms are continuous range:
> +	 *   [0xffff_ffff_0000_0000, 0x0000_0000_ffff_ffff]
> +	 *
> +	 * Now, suppose that register range is in fact tighter:
> +	 *   [0xffff_ffff_8000_0000, 0x0000_0000_ffff_ffff] (R)
> +	 * Also suppose that it's 32-bit range is positive,
> +	 * meaning that lower 32-bits of the full 64-bit register
> +	 * are in the range:
> +	 *   [0x0000_0000, 0x7fff_ffff] (W)
> +	 *
> +	 * It this happens, then any value in a range:
> +	 *   [0xffff_ffff_0000_0000, 0xffff_ffff_7fff_ffff]
> +	 * is smaller than a lowest bound of the range (R):
> +	 *   0xffff_ffff_8000_0000
> +	 * which means that upper bits of the full 64-bit register
> +	 * can't be all 1s, when lower bits are in range (W).
> +	 *
> +	 * Note that:
> +	 *  - 0xffff_ffff_8000_0000 =3D=3D (s64)S32_MIN
> +	 *  - 0x0000_0000_ffff_ffff =3D=3D (s64)S32_MAX
> +	 * These relations are used in the conditions below.
> +	 */
> +	if (reg->s32_min_value >=3D 0) {
> +		if ((reg->smin_value >=3D S32_MIN && reg->smax_value <=3D S32_MAX) ||
> +		    (reg->smin_value >=3D S16_MIN && reg->smax_value <=3D S16_MAX) ||
> +		    (reg->smin_value >=3D S8_MIN && reg->smax_value <=3D S8_MAX)) {

Sorry, maybe there is still something I don't understand.
Why do we need 3 different checks here?
- S32_MIN <=3D r <=3D S32_MAX (R32)
- S16_MIN <=3D r <=3D S16_MAX (R16)
-  S8_MIN <=3D r <=3D  S8_MAX (R8)

If R8 or R16 is true then R32 is true, so it seems this condition is redund=
ant.

> +			reg->smin_value =3D reg->umin_value =3D reg->s32_min_value;
> +			reg->smax_value =3D reg->umax_value =3D reg->s32_max_value;
> +			reg->var_off =3D tnum_intersect(reg->var_off,
> +						      tnum_range(reg->smin_value,
> +								 reg->smax_value));
> +		}
> +	}

[...]

