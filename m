Return-Path: <bpf+bounces-38362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 502A4963B1E
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 08:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE34EB244A7
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 06:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F54149011;
	Thu, 29 Aug 2024 06:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YINX05HG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FEE4C62
	for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 06:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724912194; cv=none; b=NFLBxUWXy4iB99rcxIBylovZeBVplvKrGqGirT+XurCIzt20+YGicoGWD+1x0+Om/gedc6Vq8j1ZhQE3qwh+quXBWtA2+7jcgX+muEizepG9QIJDXFCfpgZ0ibn3OXwTifWZBwvU50bwMW+dmN2AomcyP8GyhBYKoPLlgbaaNzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724912194; c=relaxed/simple;
	bh=NhW2MWguRe2h+ggbJXvr9KoHvnuijhn2RAe4IniPLDk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YBxTA2eI1+srlN4kMK73TCqizQPbIoE0LQDh2W9oE/oVSMK2SfPXacF+jvFuvRkmCQp1MMQ98OvroBQ2nzU72l65fCTeApSX2Ee2D+MSnB2Edn6YE49l1sRHO/0iBZu85YZaMy0Ky2Ocjs+iANzS5UjMguH8bkrKXsB/PgRxrLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YINX05HG; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70cec4aa1e4so206247b3a.1
        for <bpf@vger.kernel.org>; Wed, 28 Aug 2024 23:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724912193; x=1725516993; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L2Kd00aZcvMwEdMANLIehh93eGChlFfAC3hvLV4wUAo=;
        b=YINX05HGivd/7Z9qBsGE0Je9/CmfkUv2xaibEAtowb5dKLMpJ7qw+vUNjcFq2Ershy
         qPsV7/y8JgERZv44Gkrpx9zmzhwTzllhF2IhJi9SRTeGgH0nFN1kBBkRFm85ywNndx6w
         qK9gyBAK3WpXf3ahSdfKCTx8747VanQ1Yvy6Elm1gLNjcpFRncRsHgr1ihdFUIPhq0aC
         C8b5YtdJn1fH8YNZ7b7JGgt8mUKo5wGLzSu+VNYtFQRRn/YRFRnt6Mtd1cJ6k9D55AEA
         nFkZ1Ts0awnk0UkuoB7rTfNnLVtoJFoNFv6jpEUvEDD+ky+9Ah8b8LDMvyx2KacSart8
         EN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724912193; x=1725516993;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L2Kd00aZcvMwEdMANLIehh93eGChlFfAC3hvLV4wUAo=;
        b=CLICX0We4i0ZN75E6HrznfasdICQYiNQ/D3SiJVYrB57JU+MqWl1s5IzDjCZNVZ2oy
         QbTXkstIgIGUho3vooOsg3xOLaj0YB+5IGfD5JmtOKfaeMZH5qrbi6bYPvSANmvYosXy
         rILUMrv+WxtsaxeDuwrurKeUPskjdBaammgrUB0RYfAXY2kB6E6RxZLcFbq2v+Mly/8b
         m1pAxr0iJ+v6pGvjlN2MP6vN3cAQKTtEGtLd6dXK4VF+mRZa1J/vsshnHAwmTLaeYTZq
         updZXKZgC5sm/eZ+55M6kvtxNQQGH8oSUzMmEFsA0osVfEANveo7+bbZLX1g9JFSpAb1
         STRw==
X-Forwarded-Encrypted: i=1; AJvYcCWr+QxHamH8EDw3qihkh8q02OrU16iC26xosa8kjN4M6zJokx9lFM/vaxb7Bbpl5VD5/LE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGnv75uZ3L5SnlGO4Oq+co8H6ajui8OQNqSpcKWXBimKK4yhnE
	b3aFMuP/Z9Tx7BGyj6qWSU2XaQshBXdZfdkInJpBc69QTYr2yEhm
X-Google-Smtp-Source: AGHT+IFvPZ0tzQAX0yc9MGwM6/yCSQgYsbB8nGLjPR8ugoFltygyEUHQGxIeMFRlepRVHNHHV+Uh1w==
X-Received: by 2002:a05:6a21:1304:b0:1c3:a411:dc45 with SMTP id adf61e73a8af0-1cce10ab2e3mr1515192637.39.1724912192573;
        Wed, 28 Aug 2024 23:16:32 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-205152b1326sm4484585ad.35.2024.08.28.23.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 23:16:32 -0700 (PDT)
Message-ID: <5ef794cd921623dd8e0e6e350b6ad8ffd1aa7c26.camel@gmail.com>
Subject: Re: [PATCH v4 bpf-next 7/9] selftests/bpf: Add tailcall epilogue
 test
From: Eduard Zingerman <eddyz87@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song
 <yonghong.song@linux.dev>, Amery Hung <ameryhung@gmail.com>, 
 kernel-team@meta.com
Date: Wed, 28 Aug 2024 23:16:27 -0700
In-Reply-To: <20240827194834.1423815-8-martin.lau@linux.dev>
References: <20240827194834.1423815-1-martin.lau@linux.dev>
	 <20240827194834.1423815-8-martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-08-27 at 12:48 -0700, Martin KaFai Lau wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
>=20
> This patch adds a gen_epilogue test to test a main prog
> using a bpf_tail_call.
>=20
> A non test_loader test is used. The tailcall target program,
> "test_epilogue_subprog", needs to be used in a struct_ops map
> before it can be loaded. Another struct_ops map is also needed
> to host the actual "test_epilogue_tailcall" struct_ops program
> that does the bpf_tail_call. The earlier test_loader patch
> will attach all struct_ops maps but the bpf_testmod.c does
> not support >1 attached struct_ops.
>=20
> The earlier patch used the test_loader which has already covered
> checking for the patched pro/epilogue instructions. This is done
> by the __xlated tag.
>=20
> This patch goes for the regular skel load and syscall test to do
> the tailcall test that can also allow to directly pass the
> the "struct st_ops_args *args" as ctx_in to the
> SEC("syscall") program.
>=20
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> +static void test_tailcall(void)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, topts);
> +	struct epilogue_tailcall *skel;
> +	struct st_ops_args args;
> +	int err, prog_fd;
> +
> +	skel =3D epilogue_tailcall__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "epilogue_tailcall__open_and_load"))
> +		return;
> +
> +	topts.ctx_in =3D &args;
> +	topts.ctx_size_in =3D sizeof(args);
> +
> +	skel->links.epilogue_tailcall =3D
> +		bpf_map__attach_struct_ops(skel->maps.epilogue_tailcall);
> +	if (!ASSERT_OK_PTR(skel->links.epilogue_tailcall, "attach_struct_ops"))
> +		goto done;
> +

Nitpick:
Both test_epilogue_tailcall and test_epilogue_subprog would be
augmented with epilogue, and we know that tail call run as expected
because only test_epilogue_subprog does +1, right?

If above is true, could you please update the comment a bit, e.g.:

/* Both test_epilogue_tailcall and test_epilogue_subprog are
 * augmented with epilogue. When syscall_epilogue_tailcall()
 * is run test_epilogue_tailcall() is triggered,
 * it executes a tail call and control is transferred to
 * test_epilogue_subprog(). Only test_epilogue_subprog()
 * does args->a +=3D 1, thus final args.a value of 10001
 * guarantees that tail call was executed as expected.
 */

(For some reason it took me a while to understand what happens in this test=
)

> +	/* tailcall prog + gen_epilogue */
> +	memset(&args, 0, sizeof(args));
> +	prog_fd =3D bpf_program__fd(skel->progs.syscall_epilogue_tailcall);
> +	err =3D bpf_prog_test_run_opts(prog_fd, &topts);
> +	ASSERT_OK(err, "bpf_prog_test_run_opts");
> +	ASSERT_EQ(args.a, 10001, "args.a");
> +	ASSERT_EQ(topts.retval, 10001 * 2, "topts.retval");
> +
> +done:
> +	epilogue_tailcall__destroy(skel);
> +}

[...]


