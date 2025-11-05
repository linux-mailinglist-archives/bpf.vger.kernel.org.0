Return-Path: <bpf+bounces-73615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51481C3553C
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 12:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2385565141
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 11:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CE430CDAF;
	Wed,  5 Nov 2025 11:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7tzWh7e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4881B2F1FD2
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 11:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762341430; cv=none; b=ZzLgVEfeOm8eML9pYVI/Y5S3CZsvuqfv1QX+t2QRBoHZ2QMam8luATouyva6Rb9Zx4yWvwvQwwRZ1kMtIP4CAO+EF4L+lnO62I6CBRI1jnfCAb6jsoy7o7E2msJeNoe7J8ARNy8Otm6hbX6zgPepHZZucoP1/cAhDRIgvt/lthE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762341430; c=relaxed/simple;
	bh=6KSr46iwhipcwaPKYTCYgpWRnSnGDs3vSNRu2qBG9Q4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4olLWhQo2P6sRp6b/P/ZM7XNZ2nHjx9GAhuc31uwBHOH7lU2Bdbeho9z+H3n7JvexkJh6phaM777ECIAVmw4XadI0MwYqKLEjRisdc0QHvwszj6I9mJOSpSVYmsbAIvcvYIg5V9Gu9/0ml3fX6TUPecB7moTnTSDqyT2kFesLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T7tzWh7e; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b3c2db014easo1307694566b.0
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 03:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762341427; x=1762946227; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6KSr46iwhipcwaPKYTCYgpWRnSnGDs3vSNRu2qBG9Q4=;
        b=T7tzWh7ehtiJ9j6pjmJzkm5Aw35H2cRjaxg1RlSM/BCVEctM/OkEJ/98asjhqlbAUj
         wfM/SS3IoDQYG8vEoPU0cz/beMYqQ7XfT4gCUimLQ1HcW6L54D1MhxbwRM7yz9R5jipF
         JJCfqBL12BOqgwkBSk6XcxwOq87PFvfNMnaPDuB6COeSNCuKDKYxE4fZ5MDDnQ2Ffnp+
         g9GmiY5ojovy0sufzU9DbJwGR5wDRM77mfqPfMSvgPMqS9+VvXH6fPi2pcPN+DSsNsCO
         Bm+n9vijrvds/DuEyoxDk9Ok6aU7sEKzUh/2PKV9Xfpscz/d+eKBDfBweuW99A0UzbR7
         uGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762341427; x=1762946227;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6KSr46iwhipcwaPKYTCYgpWRnSnGDs3vSNRu2qBG9Q4=;
        b=k8RxMqG7mT8zP49Nmj7vPKB0UIBGu7H9JaK0kYJgy01BuSCMrVTTr0GZi1Q6IAggNg
         GG8iwxZ0xDoP98hrSvFW7VLRO3QmYu7idNLIvnZInPzn5T9Q5AfY1HYpnQ5TaNrijex+
         t4jdp3RX/0ZTF2u9XJxByu9dF4DmrbUu7rfv441707YXlOaVI2go1yHvtdTl4MlVJDYO
         PJTqCOQi/ipRdJj2ASxKD+bpD1JnYlBTeQxlUPd7iVkHRNTeSxN/BjesCdVxSgvI2CuU
         SGcKkKDvG8EX4wdmyJRsMHNLU3I5XEGUiso40NuuagadjZWISKGRSTQgDD1aLPw5GwdS
         lo2w==
X-Gm-Message-State: AOJu0YxO89vzaHzPVZgd+bPid9b9vmERDzFcqLUOei9KkcZIpUiv6QLc
	+m5wMCIC7hsuzvlzgI6fUSzBZwUpL8V+4RhRGTcjWodVLRhx0FppROawiDHkZg==
X-Gm-Gg: ASbGnctawFFD6I4Avhb8BP6nzzzTQjYmvx3iZfGHt+Yod2dM4nt+YT7HUMO5ObKY/lx
	ut7GgExSj5snSZtXrUgVCoV65Z1Vi18RYxdlwjcXcnVYf0D5JXCTQhUqrWfwQl3LhluGjtTcmze
	Q4XT+G+P7+TpDBM+ivt//t3i7iTrI7VcrbwKtYMzUPKZHVdZ+56dBBCsSfnyL1CfKGTo8rBVwoI
	OdMxvbyDSLQ9L4pbaSKyQ8D3fanPlLF1m1YLVibnZyCob7Cr8YOnHWTlPwCn3ZUVVVD2+bt/n9J
	AzkY0aDh7dACDkM0AeKf3iALHVcnRSO2FHqz3VApvE1MMG9x2Bckx04cIFIRvkjjCJXQX/EP4AW
	WYLrcrSiRPqrs+ehPxbqtjwqDxmUzUIYt687CMP0TdKhPn8eSqcBqtk2HGAQye4EXXY9ZXSndSY
	0OJcSfg0Yj+DX/roZAbXZm2KAtI5aobM8=
X-Google-Smtp-Source: AGHT+IGKVhJiHM4SzesuQV5Lk41EEFuA+3grHGP37dzHWgVWtfXLz8Xbzd1Xthpzj3SjctewGlZRxQ==
X-Received: by 2002:a17:907:1c0a:b0:b45:eea7:e97c with SMTP id a640c23a62f3a-b726553bb23mr250629666b.47.1762341427015;
        Wed, 05 Nov 2025 03:17:07 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723f6e2560sm465344066b.46.2025.11.05.03.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 03:17:06 -0800 (PST)
Date: Wed, 5 Nov 2025 11:23:20 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v11 bpf-next 08/12] bpf, x86: add support for indirect
 jumps
Message-ID: <aQszqAyqdQZMlt3p@mail.gmail.com>
References: <20251105090410.1250500-1-a.s.protopopov@gmail.com>
 <20251105090410.1250500-9-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105090410.1250500-9-a.s.protopopov@gmail.com>

On 25/11/05 09:04AM, Anton Protopopov wrote:
> Add support for a new instruction
> [...]

Interestingly, AI review is stuck with "Setting up Claude Code..."
on this and libbpf patches of this series. Robot got tired? :-)

