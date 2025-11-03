Return-Path: <bpf+bounces-73372-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D8431C2D9DD
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 19:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 956AB4E35DE
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 18:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB4B261B9C;
	Mon,  3 Nov 2025 18:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAMAqmBt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AA93191D3
	for <bpf@vger.kernel.org>; Mon,  3 Nov 2025 18:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762193692; cv=none; b=kCJCXbkuIsTDVaYcpNQFJvRupgZXSksji+j3U8knN9TvtANskR2UmoxLOeVs58rrWOOS3WAg8CSukhUtZi9ZLD2qVn4rXzDHV21lkzMgwpUBOXKYg3g5lC01N+7T+s1NPO01brO3pgPzXrJ25UzJyoiOnuQSul9Z4t085LiiL8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762193692; c=relaxed/simple;
	bh=kRTldSDOu/FvTKTFbdBYsuhbuom+HjOyiUNQvk5adZg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jufkaZLXavKaoq28yo4QYSGbNzO1J3EAr2cttjXerjvwJu79Zcziz9e98uE70BmHdPTSYtH3vbBZ4pNDBdnfSWz3BMKfSpQ5ggaUqMfYFYuv+GTXZsPgtmBlZBZCeVXY2+k37qPoOoVQ3jJerU8BKQ8ikqScgB6Z9B4lJFu5uoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HAMAqmBt; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-29586626fbeso15045835ad.0
        for <bpf@vger.kernel.org>; Mon, 03 Nov 2025 10:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762193690; x=1762798490; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfDeb7baff6ASohW/ana1Q5tLYqMzwgelS8O0alrjlo=;
        b=HAMAqmBt4/tW/z0+MrFMaBBudEbDpy7sjg7GZMUujq9GQPuxYEQljr+zVPEA9YmZoN
         SpOtPk50ah4//z5+7olymLmbIprbn9HKhHxREmQOwkJ8D6A9y0yhdaj7Cs4jCjdWiuMG
         ZcyU+G+aYUq9dA83+4iYFA6jlBRka5cb8kiVefNAAV1CWIzD0IOAi3n76DrcayFFWqnQ
         6/QxrHZSvnMptPIHTqqGAB1dG9pCBPfdgOUFGMrtfn5o8D55TvozQCNg3z116y1EbKPO
         glSeWp53qfc+2or0HsiXxAwnR+uhvoHznKspyH/MGqVxbbadYJL7GYlFbO+G85eKdXqP
         mecw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762193690; x=1762798490;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WfDeb7baff6ASohW/ana1Q5tLYqMzwgelS8O0alrjlo=;
        b=bL5QDownWksB8yzDdMvoJAX0XbkgRwgSKq+q68pX7BUyVJsb5DJJixFQhwGhcMCM8u
         HGu+akcCk9VjLVVZxc5FVIQq4WAazNf9mde+/YhfmSxBVGtvb9xq6K7lQ8/3v9A0UXE/
         o1ZoXclRYEL8ys5LfEx5GjR0iTCQnPPo0hGyy7otMPF341PllwrKUBRbAnXUTg+o41d6
         I08Y7GCTuYCBt9ilOQf0mm+6zsLZIyAep90nO8E/MTKsh8bWG3Qjp3oz7Ms3kBug13Qz
         RD7obJb/kjvI//FQT/M0jSUf1JeZ6uedKw5W2z8ijmiJOjEk6IXR2bUrjl6mKWiIX3hx
         7h4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWfRMuqIzQLfPdkkoEsrh0oeRHQ8kmzkHKzyehTspO2iX+UNoRsduUa+4l/PFP3sQozEfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCdB5GekMVKkFiCOpO9NBThn7BwGlkxbRVQC9bRkJJ2TvwQmJe
	QE/LWIJif8S+r8+4cgbVKPRj2ZdClykeG8E7Xqm201UnelFi9fdtx7j5
X-Gm-Gg: ASbGncvEbctW6kiMFK0V/guECFzgKL3bA6Rn98GNcPFc4CCKfbaa+g7ciiUisCqTku+
	s3wlfyruHUAK73LhuY0S03+px6YwSBV+2feYsZg8bu3r7MGO1xbwnR198Mnzcau/NSH6pjuXp1I
	B+IdfB/gND7ItlkgmmPbn3GR6XSSrS7IUctZBSCG3crc8a5szjlDzrBzdEXdorUeYIRmeWhaoNO
	viEfzHYYriOfSWFBHIPe9+nwvfAsusieTEFrghcoVBZU5g6M0leG5kEeeR9BmHusiOl0j24H4TG
	RNZE9iK3jYaTl2aLmBsxed6wmYRQwWb59dzc0vXiA/iBODwplAiJi+jWywppsyUaPSwZ/uv3uRl
	1iFfOKKvEo7dEpP9+oi5llgR9waAeE1IZDDEQ+sOqagxsPsbnzgoelSJGyoRrfAE8MBDi6LT+dO
	Ild8uALw2IOsVWvcBst+y1R3lkTGcSBKpGNIQ4
X-Google-Smtp-Source: AGHT+IFj6on1DpKDZ6l6GB/KDZKBx7WGs07I/oEK6+7I8XTKoEXeIEIYlTAWE0TZSKyMOsESiOQzAw==
X-Received: by 2002:a17:902:c406:b0:24b:25f:5f81 with SMTP id d9443c01a7336-2951a3eacaamr206673065ad.17.1762193690274;
        Mon, 03 Nov 2025 10:14:50 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:3eb6:963c:67a2:5992? ([2620:10d:c090:500::5:d721])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3415c8b5cfcsm1740053a91.19.2025.11.03.10.14.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 10:14:49 -0800 (PST)
Message-ID: <ae64d43491a36fa5efc861be912a615348877d51.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Add test for conditional
 jumps on same scalar register
From: Eduard Zingerman <eddyz87@gmail.com>
To: KaFai Wan <kafai.wan@linux.dev>, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 song@kernel.org, 	yonghong.song@linux.dev, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, 	jolsa@kernel.org, shuah@kernel.org,
 paul.chaignon@gmail.com, m.shachnai@gmail.com, 
	harishankar.vishwanathan@gmail.com, colin.i.king@gmail.com,
 luis.gerhorst@fau.de, 	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Mon, 03 Nov 2025 10:14:47 -0800
In-Reply-To: <20251103063108.1111764-3-kafai.wan@linux.dev>
References: <20251103063108.1111764-1-kafai.wan@linux.dev>
	 <20251103063108.1111764-3-kafai.wan@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-11-03 at 14:31 +0800, KaFai Wan wrote:
> Add test cases to verify the correctness of the BPF verifier's branch ana=
lysis
> when conditional jumps are performed on the same scalar register. And mak=
e sure
> that JGT does not trigger verifier BUG.
>=20
> Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
> ---

Thank you for adding these.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

(but a comment needs a fix)

[...]

> +SEC("socket")
> +__description("jset on same register, scalar value unknown branch 3")
> +__msg("4: (b7) r0 =3D 0 {{.*}} R0=3D0")
> +__msg("6: (b7) r0 =3D 1 {{.*}} R0=3D1")
> +__success __log_level(2)
> +__flag(BPF_F_TEST_REG_INVARIANTS)
> +__naked void jset_on_same_register_5(void *ctx)
> +{
> +	asm volatile("			\
> +	/* range [-1;-1] */		\
                     ^^
   Typo, should be [-1;1].

> +	call %[bpf_get_prandom_u32];	\
> +	r0 &=3D 0x2;			\
> +	r0 -=3D 1;			\
> +	if r0 & r0 goto l1_%=3D;		\
> +l0_%=3D:	r0 =3D 0;				\
> +	exit;				\
> +l1_%=3D:	r0 =3D 1;				\
> +	exit;				\
> +"	:
> +	: __imm(bpf_get_prandom_u32)
> +	: __clobber_all);
> +}
> +
>  char _license[] SEC("license") =3D "GPL";

