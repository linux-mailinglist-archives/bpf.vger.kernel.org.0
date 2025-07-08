Return-Path: <bpf+bounces-62702-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD42AFD6DC
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 21:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13400564059
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 19:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271172E5B10;
	Tue,  8 Jul 2025 19:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hqdISj2D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F2517C21E;
	Tue,  8 Jul 2025 19:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752001660; cv=none; b=ufPYAu3c3gXIU/ZsDAnyXlfCKXs0xEzUhMNGvk82ZjtTG909Xu5IZtzIoorBW6kECTYAQjPnxFD85B2VoBKmzpnD2PgDVwp9ZhjZawId4Q0v3hupz46lMguQWzpCj/YsYkM4u5npXgFCMn5t8mgdGgnJ6ZX79fkZCRhTC0vMiUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752001660; c=relaxed/simple;
	bh=2f3RZiFeofFcvc61Ms/b+cnETdj7G3/8UcEa1Ka+/Uk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Twu5G0ZJ99hySM+wDjT5UtTdxYRXT/CMEmCQelcNtTuG/UUUztDcXgfTehCD7PCVnRawbbdCfULNIlaKOJZ5/jrYJ6atzILz20otat4Tam3hiYyPf+CqZnc1lDND/p1kgG7NkbWIjmMtc6kMQNe86/KGmVd2ratf8+YwnLYKK+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hqdISj2D; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-748e63d4b05so2579192b3a.2;
        Tue, 08 Jul 2025 12:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752001659; x=1752606459; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ESYp8LNJOnczrMrDpM7UABHIa+moUPbT/fUz8S8n/kU=;
        b=hqdISj2DFsMjqhTczXubt/tesrA5x5nM3Lc0Y5bAEwmxZGBIkTTtm+ZlZcj6JTexFn
         ypioITfZQV1D6dHMGr9oqgKttPs0lPEVVj4oE1QNf0l++jn6eru8DgmllXZyBVEJyDxo
         ++v0HQBIS3640aBQ1eH/Cg6UunZ9FDqQ5uXKexBLUmdGqWS1xzmv/aeDalAHAAppQpjt
         sx+vn+08CYGQnIpyludDcUOd69l9hr3YzlhACwXKgD8qFT+9HNHAC0hGquQTkvNPdRzO
         +BfaX3D6YNzgtRlYogumVSw0zlvWZu4sPTLNJjEYXEgV3l5RLKbe58pTyc6j2Gk6iVz8
         OQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752001659; x=1752606459;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ESYp8LNJOnczrMrDpM7UABHIa+moUPbT/fUz8S8n/kU=;
        b=BPY4plrozmhGlvnefQ/fKSRJFgX4Bi3wt9C4OI6hHEuL66WlNw7KVHUl0J5o1BRbe0
         zcB8THOP9Qn85ZywvZEFPpx8/dMBmYJMduyag3oSCLiLiH8kdWvs0ysqM15yLoDu5TaE
         DXRwgQk15OHIRP28t6oW57tJ+8QIHNo//kXBGQt7yP7tQuUc2OI7awVPTshYlx0TQ0TT
         TEzscAqsCNR+KQ1d+PJ0cRhcUR7AGX3+qGLblVuJrvRqPGuAR7ijc7lpKvOAUzziiMRn
         2l6bJAHUIziuweBtlyzf7LIsYZrfWoWbC7McsvSdJE8gVN6NLaWXE7y1R5PnxuAshzbJ
         eA/A==
X-Forwarded-Encrypted: i=1; AJvYcCVVUjrv/Y0ZtFj+E0+p69wikTCRGPaezfQaAMfih6pgR2AVl0OJk53bhyLgChr1/kI6HNI=@vger.kernel.org, AJvYcCVsGtNf8MnfOg1SfsoZcT7pYIzMMavLCJoN9crdnLVhCYfZw5FdRcqrjLdN9zQlqCyqV9AhxGxNbSj0udPS@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfvf1XK53ddt3lGJ9cE4+O2BnHOMgzJZpgDA1lMQDuLyjAw0Y9
	JQnrkjh/HdLFyxdwz6xiaelUBrmYH08Qpf4YeJ+QL6RQTkUgp/JwR8FF
X-Gm-Gg: ASbGncscjDFhWhJNDtile5IbJTB8Me7wULFTlRcEh//IpGILOYyZFDh3/RXxLiLzokZ
	YoOxlkGB8NkKcJD7BXpOtw+dUXcpQP89csroBQjR27VKK92SE7vBhrpYLiIv6rN9uOzeOjsU/l4
	2lnh651VtBoBNz/ku7DE75ubgYuVY28W7LhaHx8300LUIj5Ngc1SLXfT6P/HDYD1MQoL5+m4jm4
	N1J5+qgx9KAo41rwlDCJBpFN9MoZpyQEhLMx3XTy16cTmfeonpNN+wdO9vbZYHQHm75yC34wtpI
	picuUb4LM/Bc10Cl9NlOVKLzUFyHSe/BoZAARGt8j17h3VL78FtVxhW/q80BI08B6fcV
X-Google-Smtp-Source: AGHT+IEd9LPMOcrkmUZ2OGsapCQihiFIJ5vHNPE4vKdRUICVetias+kwjZrumjusXZRRxW+PCTKJ7w==
X-Received: by 2002:a05:6a20:7343:b0:220:4750:133a with SMTP id adf61e73a8af0-2260b29d7e2mr27933240637.25.1752001658586;
        Tue, 08 Jul 2025 12:07:38 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::647? ([2620:10d:c090:600::1:2404])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b38ee748913sm11977492a12.72.2025.07.08.12.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 12:07:38 -0700 (PDT)
Message-ID: <4ba5fd7e81438037189a89697b1ba6c8a67f4818.camel@gmail.com>
Subject: Re: [PATCH] bpf: fix dump_stack() type cast
From: Eduard Zingerman <eddyz87@gmail.com>
To: Arnd Bergmann <arnd@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>, Emil
 Tsalapatis <emil@etsalapatis.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Martin KaFai Lau <martin.lau@linux.dev>, 
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John
 Fastabend	 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev	 <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri
 Olsa <jolsa@kernel.org>, 	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 08 Jul 2025 12:07:36 -0700
In-Reply-To: <20250708160737.1834080-1-arnd@kernel.org>
References: <20250708160737.1834080-1-arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-07-08 at 18:07 +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> Passing a pointer as a 'u64' variable requires a double cast when
> converting it back to a pointer:
>=20
> kernel/bpf/stream.c: In function 'dump_stack_cb':
> kernel/bpf/stream.c:505:64: error: cast to pointer from integer of differ=
ent size [-Werror=3Dint-to-pointer-cast]
>   505 |         ctxp->err =3D bpf_stream_stage_printk(ctxp->ss, "%pS\n", =
(void *)ip);
>       |                                                                ^
>=20
> Fixes: d7c431cafcb4 ("bpf: Add dump_stack() analogue to print to BPF stde=
rr")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

This warning is already fixed in
bfa2bb9abd99be ("bpf: Fix improper int-to-ptr cast in dump_stack_cb"),
which landed in bpf-next yesterday.

[...]

