Return-Path: <bpf+bounces-70265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC66BB5AF3
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 02:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4EA53AB3AB
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 00:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 916C31A23AF;
	Fri,  3 Oct 2025 00:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J9IG+N8K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D90C2F85B
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 00:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759452640; cv=none; b=oxrqSNBlS2Q02DdJhEYkyJC7hJplpNxCq4kfbkdAoOb/4ddNeKRYeWJPnMPIV0L7V2L1n6N3tmdR4eed1TXRUHd/RmLSpgiZs0stpcY5HHgTmV45SngqlJ7b69O397ga9LkS+qYV91S/39m5WoHq7LUjeQU+90HeepgORoNEaZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759452640; c=relaxed/simple;
	bh=KGFQx2OzTJ+QelDiGzVGx5icvUzU+J5hh1Te9tLqLWg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JR3rJw34dkqqrfWS3xJvGIuFPFK56bN/myKXMOL+Hgpqn4C/z441xdfGr5Cfso5AkRMv6vw18NXaSD2nvtotHxIqIhgShYLiWEiSMfQvXPC2PRncP9OOXbfqKaah3kLR1f+JX4T3WuobK1nlyGgWPyXXD2dJULdSApyKFinG3Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J9IG+N8K; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2697899a202so19236655ad.0
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 17:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759452638; x=1760057438; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yIpIfNeGfJkzN6fKova9m+qfAJ19cQMtujs18cDW0is=;
        b=J9IG+N8KJQ7I/ObCJKeTqaLrYEXuAE6Yeah0HoKFxsEmHpNtwcyNjH17HSuW2j0kLg
         REHWAag/yYJ+otxwBquiDl2I3w76xlAhvaCaRXnM79++uxZRs1LdpDg+SbKwng+U7LHx
         XU0YplNHZ3hPsuPFNTMNO7iaba4jvSVMoeJIHG6TovktV9UYSW+uKtITxjLKnJvbnLAN
         pMDPnO76l05g2iGkl5LDvQHEnsHMsqyAEf4Xt0Gf69jjOssjWm/3pBwDwxLfN51bOrSg
         Z1fA8Gqi2QxR3hhSbatymPFMuNZA5WLfGasgGSb5vHvdB+g8DM42wK4bKI9KcBzTyCBC
         gMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759452638; x=1760057438;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yIpIfNeGfJkzN6fKova9m+qfAJ19cQMtujs18cDW0is=;
        b=MunuFsej9ivGjw90W9EVdBezr3yDYTrOaWMigvcpz4WWCcF5pPGjcZX0xhmW+rKU8Q
         PBEI24OxE9I74RBr24xg8s0UbY5pSj7wIlcAYRo5Z3RWzSuLkGswBxHjw3UsKAQo6pU7
         TnXzMU31D4g+YUuWf2uMo/t3EPw8ptUytjYuYz5kUARReG+M5kbNr6yEC3RVvgu2pPeC
         Tb53ApYC4QH0i7xluA4ofoWK9QxmWNVPCjyTxtTfwBu/WKduZPLuJC1kd/mIimX/Tk0+
         KjZ69/l468dpHvHzLzZZtQBsWbV7IKII1Zd0rx/j2nUnUTSbncsEe69SevHAA9vSfs1z
         VnhA==
X-Forwarded-Encrypted: i=1; AJvYcCVLHIrtxtRchQRHEsrKbodsOZwBd0bRJEhYnEdYdMItCjCwaqO2cxAxoWl9XYkOGfAQpL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywny+6WHGUdFYTwvx4nXZ0REUBGDiZsClJ8MMaQ80vemYeVj2hH
	Dhal4ret7aZxmr07VkHDzsrc893LPZhVzN9Rm/SkInyq42IIkhI+NcEG
X-Gm-Gg: ASbGncsc2ZDCcTDvawmOWVz/UpUfVBwcNrSrrNdFJ8ugrWgVGg0h5o85b1/vSsxPqjI
	OmkY0Fy0y0zzD8WUpzrZnUCZRHIDWBWaMyqNgnoOlZ+qZNtG75smY1JL01rbPAh0/2k/fzBGDKL
	UCPhGQJxfiiUUJU0GOnsZmSjW/Odabrw8F2yp4ribn8xfHuR7cS+cYpkQugtL8EDoLeAAf8kj4N
	zQKu6pQ6g4+vKLypvfOdLsPaRFxbOqKmljnicGYzd31Uy4Cz6k2qJYObZf1wc9wxDsJur/Pddl2
	NTOpNdXm4AV+DCjno2QyqJRupHeAUat5NDDM+b47vxF1j9Dcv9Eg1WodK9oVfuvpTkjS+1+lBSK
	uWpthhCdg7DTNzXA1A/q5funFT6pvOWoTFjPQQB2zX1vx
X-Google-Smtp-Source: AGHT+IGgxaiQvlr/p0GDndT6l5jJ2IAjrnBknTPaXo/494pKTsDc2d6PNE1yAzAmocfmyGnYmQgLSw==
X-Received: by 2002:a17:903:3806:b0:26c:4280:4860 with SMTP id d9443c01a7336-28e8d038cf6mr74533065ad.8.1759452637888;
        Thu, 02 Oct 2025 17:50:37 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d126012sm33118135ad.41.2025.10.02.17.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 17:50:37 -0700 (PDT)
Message-ID: <7f2e28c4cee292fb6eb5785830d5e572b7bd59c2.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 04/15] bpf, x86: add new map type:
 instructions array
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Thu, 02 Oct 2025 17:50:34 -0700
In-Reply-To: <20250930125111.1269861-5-a.s.protopopov@gmail.com>
References: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
	 <20250930125111.1269861-5-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-09-30 at 12:51 +0000, Anton Protopopov wrote:

Overall I think this patch is fine.
We discussed this some time ago, but I can't find the previous discussion:
would it be possible to make this map element a tuple of three elements
(orig_off, xlated_off, jitted_off)?
Visible to user as well.

[...]

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 4c497e839526..cc06e6d57faa 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

[...]

> @@ -7645,4 +7646,14 @@ enum bpf_kfunc_flags {
>  	BPF_F_PAD_ZEROS =3D (1ULL << 0),
>  };
> =20
> +/*
> + * Values of a BPF_MAP_TYPE_INSN_ARRAY entry must be of this type.
> + * On updates jitted_off must be equal to 0.
> + */
> +struct bpf_insn_array_value {
> +	__u32 jitted_off;
> +	__u32 xlated_off;
> +};

Could you please expand the comment a bit?  Describe the meaning of
the fields both before and after program load.

> +
> +
>  #endif /* _UAPI__LINUX_BPF_H__ */

[...]

> @@ -0,0 +1,285 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2025 Isovalent */
> +
> +#include <linux/bpf.h>
> +
> +#define MAX_INSN_ARRAY_ENTRIES 256

Hm, did not notice this before.  We probably need an option limiting
max number of jump table alternatives.

Yonghong, wdyt?

[...]

> +void bpf_insn_array_adjust_after_remove(struct bpf_map *map, u32 off, u3=
2 len)
> +{
> +	struct bpf_insn_array *insn_array =3D cast_insn_array(map);
> +	int i;
> +
> +	for (i =3D 0; i < map->max_entries; i++) {
> +		if (insn_array->ptrs[i].user_value.xlated_off < off)
> +			continue;
> +		if (insn_array->ptrs[i].user_value.xlated_off =3D=3D INSN_DELETED)
> +			continue;
> +		if (insn_array->ptrs[i].user_value.xlated_off >=3D off &&
                                                              ^^^^^^
Nit:                                       this condition is redundant

> +		    insn_array->ptrs[i].user_value.xlated_off < off + len)
> +			insn_array->ptrs[i].user_value.xlated_off =3D INSN_DELETED;
> +		else
> +			insn_array->ptrs[i].user_value.xlated_off -=3D len;
> +	}
> +}
> +
> +void bpf_prog_update_insn_ptr(struct bpf_prog *prog,
> +			      u32 xlated_off,
> +			      u32 jitted_off,
> +			      void *jitted_ip)
> +{
> +	struct bpf_insn_array *insn_array;
> +	struct bpf_map *map;
> +	int i, j;
> +
> +	for (i =3D 0; i < prog->aux->used_map_cnt; i++) {
> +		map =3D prog->aux->used_maps[i];
> +		if (!is_insn_array(map))
> +			continue;
> +
> +		insn_array =3D cast_insn_array(map);
> +		for (j =3D 0; j < map->max_entries; j++) {
> +			if (insn_array->ptrs[j].user_value.xlated_off =3D=3D xlated_off) {

If this would check for `insn_array->ptrs[j].orig_xlated_off =3D=3D xlated_=
off`
there would be no need in `user_value.xlated_off =3D orig_xlated_off`
in the `bpf_insn_array_init()`, right?

> +				insn_array->ips[j] =3D (long)jitted_ip;
> +				insn_array->ptrs[j].jitted_ip =3D jitted_ip;
> +				insn_array->ptrs[j].user_value.jitted_off =3D jitted_off;
> +			}
> +		}
> +	}
> +}

[...]

