Return-Path: <bpf+bounces-77865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC6CCF539E
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 19:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2EA5307930D
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 18:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF4D33FE05;
	Mon,  5 Jan 2026 18:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1twbJKf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2AD30AD13
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 18:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767637389; cv=none; b=tv0Phix8ONpR7jJXuUv9kOqmY5eQm7ZOGrqqPcDBVOzt7cBl23e0vwuU1/h5lewIhbY9AQfjVlQXmXXygxr8bn9SzMRymKiS6wPJyr8y+rrJ7P+KwNu8RDrlP5zueyWkOolvx6iPla0VWnLL9HBgN66SqpIpmKHhir+RiPRgNbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767637389; c=relaxed/simple;
	bh=k9OtXFkIqje/AIKDr9FzDdAQGPBa0Z+JbsPnAT8CraI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oxh2rbsttElLn+tqg0X1JVCmhsMHG+G99Q5RFofgttQPWPqKFn3auptc+Z2Ve1WwXHhp5gUbsgyeLPZYxVRgk2mdAF+tLjHXqGlIqugur34oeVk3xOuZVPSMhSDyixOoahyOIC4VksVZsjEwFH3j7byDkg00zUXDYhJhdGHjm5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1twbJKf; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-bc17d39ccd2so81101a12.3
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 10:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767637387; x=1768242187; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ms3aLacsOOIkp2oK0SNeT2U5HEsWh1y7ZpyB6UCuuEk=;
        b=T1twbJKfvBv2BAF0etic1S1JEuu1Yn8uJQ+L6ozvOuwk+mkbY7jFjJnjCNBnSNrdsq
         3/Yt8VnnIpMbo94NA2zSLgiC5zFdop+bHz7f7T3MR5k5S5tYN6CWf4LARU/UcgnJWH8p
         VIH+v1ozDPeLd7K/bNcjf7W8e8nEptqzf6BTZw4LlU+360VeJSvP1oJpuyXBMF/aUszr
         vRyVQFsD2BHahthTAjG1F5eDasiw8Jq5TmCrflSAo4mS0PmiNqknkgEd/UAatGTX+T+g
         JMrt0BsztaGLX3RV03DGEG7aTAknX00CHHwTSEeCTmuWOmrLc7ZdAV0Fr4kejcnNy9mJ
         GKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767637387; x=1768242187;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ms3aLacsOOIkp2oK0SNeT2U5HEsWh1y7ZpyB6UCuuEk=;
        b=aziZNcmR9brt4si3/ll5ScVLpwNqIWJVtljLix8xZ5olQvDN14lDlyoF1dL80XfND0
         ppefkOc01w6naVV+qGZbLB/Hx1QVLrfPkMVbvDiJnfODRWi0j0xPZpXAv5J16P0FFG5c
         MulmVKjjDMkRN6oMxcQ1b9L3c5TW46iN1N3faOXpohuwRBnLozLvHU4dpI1p3YXq0I9s
         pmg/fHoqmXSOiE+aefBAkJMyocULwIzh1aWvPQs0kcgm3nSkvDTwspS/lbUf1XvrgBxg
         HoE+s1ZOfPrVF1gRRmKdjcy2U7HiAhH2xol/+rpV4VWmtp61v2IuRZanxISEvoCYjYN0
         Xqjw==
X-Forwarded-Encrypted: i=1; AJvYcCVbIeLkHmMlbi+kB9pOl/RIf9s3xFLy4uTKNRHjRI38nZOlh5ZghRvUVkqsndW+1+9W0wI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbJVveD3vF2SdCHWeRbAgaHphiG/8gCaXdYE+W6WwORgHiclcS
	wRh8Y+IlE8LTZvqrrvY7Uy8li/XDjTzwcAmubgYZtvR2r5iVi0jjv/nz
X-Gm-Gg: AY/fxX6m/J9YWGuHSe5ZXk+cLtD3RYEP3xUiDawOsSfYpXnfjl6x93SbjTR0luttJEx
	Fk7fZ/y7GLzTZnAPjkjuryb1kZ+Q1uy/LO8//PdTJMRL7OMTo3KpOnIXotGGv2uQ6dgLiiGIUt3
	5ERIzGujrU8II2V9UBR9EfZeVw9hMpbHpJbAS+fMX7mkgCkMfVP7Yj686KY0Xd9p4icffqhedKa
	g9nJvPqQD6uoHiMTxtitLxUqADNbFMVabttUSQlG9wT7SXYxlJTLAEEKqU10Kim769QxCarBti3
	asUJ7p3PU3cqp5C3pkWJRW83dpr944GiEubA88WAyajjMQy3ISTFc7HQ5s1vVkqhncUQr5FKac5
	W1IvTnRayjqgryQijcj/7FMrDOj3/bkxDQXMoscHeTKNBEXETag1wDU7sZMtU0vXOWLtbcnMQ08
	m/Las9iTbQKd6ERNAsPUCS0VcUuOVXTz/jBHxs
X-Google-Smtp-Source: AGHT+IGW7v0ICSXKYWEYUupKVRuUMgwDWFva4yxYPTG4kQGunsdTuh7n7fddYgADWUlpPt0RKxb9Aw==
X-Received: by 2002:a05:7300:cd97:b0:2ae:5b71:d233 with SMTP id 5a478bee46e88-2b16f87bb54mr234020eec.19.1767637386466;
        Mon, 05 Jan 2026 10:23:06 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:175e:3ec9:5deb:d470? ([2620:10d:c090:500::2:d7b1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b16f02b24asm690718eec.0.2026.01.05.10.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 10:23:06 -0800 (PST)
Message-ID: <17247510f876045d49deabba99f8b668633715a2.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 11/16] bpf, verifier: Remove side effects
 from may_access_direct_pkt_data
From: Eduard Zingerman <eddyz87@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>,  Alexei Starovoitov	 <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev	
 <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, Andrii Nakryiko	
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu	
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh	
 <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, 	kernel-team@cloudflare.com
Date: Mon, 05 Jan 2026 10:23:03 -0800
In-Reply-To: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-11-a21e679b5afa@cloudflare.com>
References: 
	<20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
	 <20260105-skb-meta-safeproof-netdevs-rx-only-v2-11-a21e679b5afa@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-01-05 at 13:14 +0100, Jakub Sitnicki wrote:
> The may_access_direct_pkt_data() helper sets env->seen_direct_write as a
> side effect, which creates awkward calling patterns:
>=20
> - check_special_kfunc() has a comment warning readers about the side effe=
ct
> - specialize_kfunc() must save and restore the flag around the call
>=20
> Make the helper a pure function by moving the seen_direct_write flag
> setting to call sites that need it.
>=20
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

>  kernel/bpf/verifier.c | 33 ++++++++++++---------------------
>  1 file changed, 12 insertions(+), 21 deletions(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9394b0de2ef0..52d76a848f65 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6151,13 +6151,9 @@ static bool may_access_direct_pkt_data(struct bpf_=
verifier_env *env,
>  		if (meta)
>  			return meta->pkt_access;
> =20
> -		env->seen_direct_write =3D true;

Note to reviewers:
the call to may_access_direct_pkt_data() in check_func_arg() always
has a non-NULL 'meta', so it is correct to skip setting
'env->seen_direct_write' there, behavior does not change.

>  		return true;
> =20
>  	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
> -		if (t =3D=3D BPF_WRITE)
> -			env->seen_direct_write =3D true;
> -
>  		return true;
> =20
>  	default:

[...]

