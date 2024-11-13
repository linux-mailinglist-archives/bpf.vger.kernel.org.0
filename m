Return-Path: <bpf+bounces-44804-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 218779C7C86
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 21:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6F07285C20
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 20:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE6320694C;
	Wed, 13 Nov 2024 20:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vahedi.org header.i=@vahedi.org header.b="Jq+HR0iP"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC41C204953
	for <bpf@vger.kernel.org>; Wed, 13 Nov 2024 20:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731528025; cv=none; b=SUm/lSEika0sOPpexmRUtuQGh4y9LpiVFnR0HdqNc2SZE7PmSqSYf0qsbk5xsAFZ14v1sSPX8DWS8aTb0Y9QMSOQLwKxV+H94Mfy6KyodjNqEDUdaAhtIObjmCaYtTVWlO8TzlqxOr2YZVvqdGY00NrthNWQOd9M+PgYSADyCEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731528025; c=relaxed/simple;
	bh=ZrwRcle6eumpiJO2FfVOfK4rQIqM1H+WeqqUrRbeZOM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=RXeiqPslXuPLxC4Yb38yvVDZ4shBDOTArnOWlOxjIy7xdKXPWaphSKr3aC3yVtFs83EL8skjG0z6m1x4xZWb1xhuncV29eud3kb5zWqlDmCqwmkRuaLFnQT48tD2dq6ICKAutLi1EfEquhQ0jPILutwoWs+tnzlUtyan8IQ25aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vahedi.org; spf=pass smtp.mailfrom=vahedi.org; dkim=pass (2048-bit key) header.d=vahedi.org header.i=@vahedi.org header.b=Jq+HR0iP; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vahedi.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vahedi.org
Date: Wed, 13 Nov 2024 21:00:12 +0100 (GMT+01:00)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vahedi.org; s=key1;
	t=1731528019;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZrwRcle6eumpiJO2FfVOfK4rQIqM1H+WeqqUrRbeZOM=;
	b=Jq+HR0iPg9e70Lwtzzr5qDjKyPMIuWkoTZxbOZ5KZp0Z1xztXhoOsb0cMIb0lkDmkEEeHC
	7xCnPuQnUn/2RNEpLgrCFS4qThmNYtsaFhl3SpJ3vGTxBYzSZSDlt+E78a98ZsMpxi6y5x
	E7OG3+wKZg3x5qFO51Ys5hKYORTIsAC9P3qvxM4B3HWwaa015FSMlh8AeSedoPWe9PT92f
	KnIjgTQGhsFMW0vfUxQdKhG5eGaQpfNL7sAWH7Ria9kSyl4tzcKkdtVYI40QG5RGjX2AAg
	RXNC9Y5WcJGc4oE8izGiGBGAiQ6pKjPwNzCU7hHdoHrUMDdlpnqEWc5HoekR3g==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shahab Vahedi <list+bpf@vahedi.org>
To: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io>
Cc: ast@kernel.org, vadim.fedorenko@linux.dev,
	tarang.raval@siliconsignals.io,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Vineet Gupta <vgupta@kernel.org>, bpf@vger.kernel.org,
	linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <920e71ab-2375-4722-bcf3-d6aaf8e68b3a@vahedi.org>
In-Reply-To: <20241113134142.14970-1-hardevsinh.palaniya@siliconsignals.io>
References: <20241113134142.14970-1-hardevsinh.palaniya@siliconsignals.io>
Subject: Re: [PATCH v2] ARC: bpf: Correct conditional check in
 'check_jmp_32'
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <920e71ab-2375-4722-bcf3-d6aaf8e68b3a@vahedi.org>
X-Migadu-Flow: FLOW_OUT

> The original code checks 'if (ARC_CC_AL)', which is always true since
> ARC_CC_AL is a constant. This makes the check redundant and likely
> obscures the intention of verifying whether the jump is conditional.
>
> Updates the code to check cond =3D=3D ARC_CC_AL instead, reflecting the i=
ntent
> to differentiate conditional from unconditional jumps.
>
> Suggested-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> Signed-off-by: Hardevsinh Palaniya <hardevsinh.palaniya@siliconsignals.io=
>
> ---
>
> Changelog in V2:
>
> - Changed subject line
> - Updated condition check to 'if (cond =3D=3D ARC_CC_AL)' instead of remo=
ving it
>
> Link for v1: https://lore.kernel.org/bpf/e6d27adb-151c-46c1-9668-1cd2b492=
321b@linux.dev/T/#t
> ---
> arch/arc/net/bpf_jit_arcv2.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arc/net/bpf_jit_arcv2.c b/arch/arc/net/bpf_jit_arcv2.c
> index 4458e409ca0a..6d989b6d88c6 100644
> --- a/arch/arc/net/bpf_jit_arcv2.c
> +++ b/arch/arc/net/bpf_jit_arcv2.c
> @@ -2916,7 +2916,7 @@ bool check_jmp_32(u32 curr_off, u32 targ_off, u8 co=
nd)
> =C2=A0=C2=A0=C2=A0 addendum =3D (cond =3D=3D ARC_CC_AL) ? 0 : INSN_len_no=
rmal;
> =C2=A0=C2=A0=C2=A0 disp =3D get_displacement(curr_off + addendum, targ_of=
f);
>
> -=C2=A0=C2=A0 if (ARC_CC_AL)
> +=C2=A0=C2=A0 if (cond =3D=3D ARC_CC_AL)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return is_valid_far_disp(disp)=
;
> =C2=A0=C2=A0=C2=A0 else
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return is_valid_near_disp(disp=
);
> --
> 2.43.0

Thank you for your contribution!

Acked-by: Shahab Vahedi <list+bpf@vahedi.org>

