Return-Path: <bpf+bounces-50174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE73A23705
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 22:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FD123A6944
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 21:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAD41F1513;
	Thu, 30 Jan 2025 21:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FielCsJV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92417191F92
	for <bpf@vger.kernel.org>; Thu, 30 Jan 2025 21:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738274383; cv=none; b=hxbV74FDztOJaCOaHLrfUiR4VEkFgwuYISr99RGJTa4hx2iGR4crWuku0NeqPePaf+a55OeeU6LoY59ZNreF8odKzNt3riIWg2yIDbU+k9eSuGklsT11hCI8rPugddqBFeTOlkWG7Awntte/eZfvKR0RexATBDBBiWtKxUjoiQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738274383; c=relaxed/simple;
	bh=jMULiunL2gjwdNQlOUuHKqBVdzRHO8pS+1xerOJBZuQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fshsufKaQr33KILsmhnQynlSQTQsCTg+G7X+zgm+oovz5zIu5DXk19lY1D6+nVFpzNMGlcCfh2s5LNFY+6MdKMIfDUARwX/yWfnzVJyLPUDVMWS+shG2ezb0I2tIJevv2kVaPV9chVtvyDEViK7DYI1ndqEgMGDwic0Lg+6pnIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FielCsJV; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2efded08c79so1821278a91.0
        for <bpf@vger.kernel.org>; Thu, 30 Jan 2025 13:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738274382; x=1738879182; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9s75/z1CbQ8TCVvqwkNqR9xQ/TO/CcN+QaGztxRK74A=;
        b=FielCsJVx4Fk8/Cih61gdYrSwqze2ak7D5dlZrGryOwdhTxDDb9eyyMDDbpmY/m1bN
         0rXMf2gvorpghIGHCxmm30J3I07xJXFpy9q+c/DAJeij0dub8GopygJFy/W6BV2mjcgs
         x6qlIqP1tAjwOpURtAJhUhCz+yoPdaenfPtcTuoSSYKBzjE2DPdVbhwbXrkZ7SqB/YrE
         oCv5xzPMRZO3yfxef/JliRhqInwe18S1vpm2fyarB+9OEMJjvsb0iJKCfB00RBrnH/el
         Elj8U7HQQIu8uqL29uB5QXHe9+MuJ1rUBfAzAmvuAZva1RsHHDUeMhgmMrU5FQbFQwWO
         7X0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738274382; x=1738879182;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9s75/z1CbQ8TCVvqwkNqR9xQ/TO/CcN+QaGztxRK74A=;
        b=rs3hejJSERjiqWAsP+2vZ7w6HHXt3C2YzuSp0e3iYzwtnrDzf2cOXLeNWADpB+P0uO
         dwmuTUXH15bjPwl327/VugaGNG3f4OW9Zasz5v2kbkApkv62TBsDuk7Zk1xWwDZFsz2G
         FNOETaJfUMguG8IbLO6QSc7z3uYWcjOaQ6bKZ1t5t1bUxulYt5s6oattlr1e7pM4ULuM
         UiBJI8T86bXt31u1J3vGAY/F7p2o9q00GV5wBf/d6IxdbE3xCfZdpDm+NfZhk+El5Kr6
         TH4kfV2Uyub2ls8ygNzPakz+2kf0AbloeQaHAuo8fXJKpLNPuof5In7MRv8/5bpFaX+H
         uwHg==
X-Forwarded-Encrypted: i=1; AJvYcCXg51s6eIvNPbzBY3ehc0AwJKAEA4P9yKrGeR7Gxe/wk3OBv1omTygGWtl+qi5sV1+QRcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhqOqNwKxZ76NsEyD3UqSP8rJeCEYyhMQsW+UguLgXZ71S3yKE
	k0VsHQREt6Poq3zke7pKFMZSZs8/0fFmR+FuPogagC2wnVN3+P46
X-Gm-Gg: ASbGncsBZ4WrjmnAZgnIxBFUYGMFGtYKOGlpZuK1xvNqDQMFnm80D/heRIMerfLBZdj
	R++u9NQQ8OvBS1T9TevtKsCovLPjPIqNhXLv6SN7D2xZY4k828CzriCClPqd4ypSkFsaBliWXnM
	LO4PLhzyUdN5tBs4rs/i7Sw0JYwU/4QAOl8OAqjjju885YcMh750FFKdHFSu6wOBK5mBtGxhy15
	GZBR3VKgF6iZcO4Stzkk0t3ctl1OwstQPFfsfIYFAoDfxeSopyqd2GFxQI3crpXK7+LYkwtLAeT
	1HTFVmq1rkV2
X-Google-Smtp-Source: AGHT+IEInLwbXq2oqYpImTdGleyPMiTY0By9hs4BmlT+s7AKJ6HjfHiL6d//CE9yB8VRcjjs9x2Taw==
X-Received: by 2002:a17:90b:5190:b0:2ee:af31:a7bd with SMTP id 98e67ed59e1d1-2f83abb3569mr11861445a91.5.1738274380487;
        Thu, 30 Jan 2025 13:59:40 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de32ee1adsm18466905ad.139.2025.01.30.13.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 13:59:40 -0800 (PST)
Message-ID: <b585402df5ecfbf02d9633f3783794058a48d667.camel@gmail.com>
Subject: Re: [PATCH v0 1/3] bpf: Introduce tnum_scast as a tnum native sign
 extension helper
From: Eduard Zingerman <eddyz87@gmail.com>
To: Dimitar Kanaliev <dimitar.kanaliev@siteground.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau	 <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>,  Stanislav
 Fomichev	 <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Mykola Lysenko	 <mykolal@fb.com>, Yonghong Song
 <yonghong.song@linux.dev>, Shung-Hsi Yu	 <shung-hsi.yu@suse.com>
Date: Thu, 30 Jan 2025 13:59:34 -0800
In-Reply-To: <20250130112342.69843-2-dimitar.kanaliev@siteground.com>
References: <20250130112342.69843-1-dimitar.kanaliev@siteground.com>
	 <20250130112342.69843-2-dimitar.kanaliev@siteground.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-01-30 at 13:23 +0200, Dimitar Kanaliev wrote:

Hi Dimitar,

[...]

> +struct tnum tnum_scast(struct tnum a, u8 size)
> +{
> +	u64 s =3D size * 8 - 1;
> +	u64 sign_mask;
> +	u64 value_mask;
> +	u64 new_value, new_mask;
> +	u64 sign_bit_unknown, sign_bit_value;
> +	u64 mask;
> +
> +	if (size >=3D 8) {
> +		return a;
> +	}
> +
> +	sign_mask =3D 1ULL << s;
> +	value_mask =3D (1ULL << (s + 1)) - 1;
> +
> +	new_value =3D a.value & value_mask;
> +	new_mask =3D a.mask & value_mask;
> +
> +	sign_bit_unknown =3D (a.mask >> s) & 1;
> +	sign_bit_value =3D (a.value >> s) & 1;
> +
> +	mask =3D ~value_mask;
> +	new_mask |=3D mask & (0 - sign_bit_unknown);
> +	new_value |=3D mask & (0 - ((sign_bit_unknown ^ 1) & sign_bit_value));
> +
> +	return TNUM(new_value, new_mask);
> +}

So, effectively what you want to achieve here:
- pick a sign bit SM from mask and set signed extended bits of mask to SM
- pick a sign bit SV from value and set signed extended bits of value to SV
right?

I think this could be done a bit simpler, e.g.:

struct tnum tnum_scast(struct tnum a, u8 size)
{
	u8 s =3D 64 - size * 8;
	u64 value, mask;

	if (size >=3D 8)
		return a;

	value =3D ((s64)a.value << s) >> s;
	mask =3D ((s64)a.mask << s) >> s;
	return TNUM(value, mask);
}

wdyt?


