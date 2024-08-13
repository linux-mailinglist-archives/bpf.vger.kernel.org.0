Return-Path: <bpf+bounces-37081-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5483E950D1B
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 21:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89A041C233E1
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 19:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9CF1A4F0F;
	Tue, 13 Aug 2024 19:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvkxVbAE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FE319D089
	for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 19:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723577139; cv=none; b=udkoH+c0QWFyXOjsASZqay4zcPRoVZWZDcoFZsAq9nM3UqSoRK9REHQLxrCqcXWr9Q9m1fSxkJOJz6KOjUbTeG14YyHY+aX/dyxJY2DGt3GZPo2w63bgO2Gyki/JKvmi6wC7Lb4rodqK14uAn0MRO0zfdIiG2RdiFXU1zJwfW5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723577139; c=relaxed/simple;
	bh=vP5bzAVAVgOdbZ/Pr/1TkR71VQdyVFk1+28GaUaz1RI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kVS0aYxzq6B3pAk5GMr+Rj5Wo0ISleTw1JA/QQs440vNWG8sawk1/G2N59QY3332z7DDVtCAQG7XzYwK/65PfIh4sfg0k+4T40+/gbd4qbKY/izfo6LjR8bos+es02GSNBRHpFa1XPNKgN7mcxzSLZwV7kIV1lUKEyjV2dlbc2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gvkxVbAE; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70cec4aa1e4so4228341b3a.1
        for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 12:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723577137; x=1724181937; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSkVPzo66QG0d78ZkfQNxp79bYX28/ABQdlk2I54/dg=;
        b=gvkxVbAEo5guXHVA4iC8X2yx+FWNtvxBEpOI5lpz5pmuHZ2DAlGFJj9FWfJn8IET13
         6+xtHFnJKowgi1Pf5nlJSZtWesaZ5Eup9AJz63lT5FPuqldJtSyCXYdhYVbTiYyCZZqu
         C769Sm2kWsC1htO99cud6MIF+44+KtQr3RdQsRFlKims6yU1VZXehpfsRlEx7PtKlHwZ
         PLY4j+eZAa3BQ9ngFIKlpLKcp66BXV9dUAoI3jGhUW68vzJueHW3LeX8K45b4aXjuWgL
         5keZCExzAOr32bAOceAfdAQbO7+1KnOB7yWLJ46viAGPmzN1/wTPmXvMMcMjFmxJDWSn
         5KQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723577137; x=1724181937;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RSkVPzo66QG0d78ZkfQNxp79bYX28/ABQdlk2I54/dg=;
        b=MmUp+hLN89GuR81jDCdWvoCZmQCLFbKCx5+7qekxfVzEtxuEoeZWkneJP95gAPKWCz
         eV2JOfw9/i7D8goe26hfMVyz71Aaebnmdf9BMFg2f7g/qu5SAlRPNWQvbZEXPxUO84+b
         bGC3K+AfLq+UyyB2ynFw6rl8QdVmII9YdM3lWxATmwPH8iCffdqr8Lsjc2itZaYG2Bc2
         9JA68FNdmkOqLcX0l1czkoCJ/Bk3uyGTU2BqDf8xcT0ukkfMcF+LL1qACjVpdhZ6O9As
         COqxGCgwYJdWe2qt0ZeXBtcXGsFEr7/n7DnkTaH2G5gbHruQwES1AMuGt4vH7Y/33wuI
         ZKxw==
X-Forwarded-Encrypted: i=1; AJvYcCUtRtZTG2eJp3ECZOxCZavUOUvqzUl6lqwTDQYPflFBHSH5PTs+zz8hoYUm3kd2jB1AH2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyxW4+C3rSe0pyoVXL8IwPABfhDbv/iZ5MMPJXsjziMYFtfvVw
	9yuVrY7WEVljxyEdGzRS/5cICEszVeGHsjp3+Xl4QKlPwjcO9lnXumvVh00UOsA=
X-Google-Smtp-Source: AGHT+IG67488AkLUI6jyHGfq+IjcH0TfyyVkQXP0jNVslijLS8yY2+JenYCUODAGv7TTwNYR+bKfYA==
X-Received: by 2002:a05:6a21:498b:b0:1c8:eb7a:30b3 with SMTP id adf61e73a8af0-1c8eb7a324amr490241637.1.1723577137260;
        Tue, 13 Aug 2024 12:25:37 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7c6979ebfaesm1851682a12.24.2024.08.13.12.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 12:25:36 -0700 (PDT)
Message-ID: <ed81500f96d0272662150047768be5a96373bdf7.camel@gmail.com>
Subject: Re: [PATCH v2] bpf: Fix percpu address space issues
From: Eduard Zingerman <eddyz87@gmail.com>
To: Uros Bizjak <ubizjak@gmail.com>, bpf@vger.kernel.org
Date: Tue, 13 Aug 2024 12:25:31 -0700
In-Reply-To: <20240811161414.56744-1-ubizjak@gmail.com>
References: <20240811161414.56744-1-ubizjak@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-08-11 at 18:13 +0200, Uros Bizjak wrote:
> In arraymap.c:
>=20
> In bpf_array_map_seq_start() and bpf_array_map_seq_next()
> cast return values from the __percpu address space to
> the generic address space via uintptr_t [1].
>=20
> Correct the declaration of pptr pointer in __bpf_array_map_seq_show()
> to void __percpu * and cast the value from the generic address
> space to the __percpu address space via uintptr_t [1].
>=20
> In hashtab.c:
>=20
> Assign the return value from bpf_mem_cache_alloc() to void pointer
> and cast the value to void __percpu ** (void pointer to percpu void
> pointer) before dereferencing.
>=20
> In memalloc.c:
>=20
> Explicitly declare __percpu variables.
>=20
> Cast obj to void __percpu **.
>=20
> In helpers.c:
>=20
> Cast ptr in BPF_CALL_1 and BPF_CALL_2 from generic address space
> to __percpu address space via const uintptr_t [1].
>=20
> Found by GCC's named address space checks.
>=20
> There were no changes in the resulting object files.
>=20
> [1] https://sparse.docs.kernel.org/en/latest/annotations.html#address-spa=
ce-name
>=20
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Song Liu <song@kernel.org>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Cc: Hao Luo <haoluo@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> ---
> v2: - cast return values from the __percpu address space to
>     the generic address space in bpf_array_map_seq_{start,next}().
>     - correct the declaration of pptr pointer in
>     __bpf_array_map_seq_show() to void __percpu *
> ---

Looks ok, thank you for applying suggested changes.
The only nit I have is that '(void *)(uintptr_t)p' (and it's inverse)
looks quite bulky, hiding it behind some macro might make some sense.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


