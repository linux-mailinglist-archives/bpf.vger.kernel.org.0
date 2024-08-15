Return-Path: <bpf+bounces-37231-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C49F69526B3
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 02:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 043141C21F9A
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 00:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DDB18D631;
	Thu, 15 Aug 2024 00:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PlCIP409"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F170CB660
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 00:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723680642; cv=none; b=jq79DdvRj/a0GfuTQvJwZIMfNRdKtumIF+SNBa5UDFJzTic5QVVuAD4WFvUheiYhPCp3Y/dNHx6h7TX5GzKlr4GY1/4VyjETm8EMjhsmI16nG+oiL5qzOoJ4UN0VFkaaR6gIMLFHj2FBg2g62ourxOaaDzccKnveORyLF6WzYtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723680642; c=relaxed/simple;
	bh=xinAuPQ/E3gQjHA+HyBMDKbw++x3UN9QJDxZ0x3eDlU=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NO7VOSwMv8TcU6hD8jRZM10kPC0CB8Hnl1ayhxMUJq0i8W9Umn4ftFQZWL3fU8d7avMgJ9Hol3X78ZtDSDH3RofNOObzI+Jz10UZK+f+1MJbC0lIpopHg3ubyXAf95WFjs6pbioNELN3EI7nBL+OmjtXr56K/eC7TRF4aZRKark=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PlCIP409; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fc5296e214so4404155ad.0
        for <bpf@vger.kernel.org>; Wed, 14 Aug 2024 17:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723680640; x=1724285440; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHx+ajFP4u5MwGcW5VOG3NeKYA0jdyc8yxoRkce+2lk=;
        b=PlCIP409pIV+hXazNrNI4UfnO+8SNoRWnfbVgjQvMMJUYKN00hXE+KPZjOe6gYrteo
         XHHSXLCvrda0+L885ci9vGIOXbuhyzRrCbsgyRTwnXYN9IHElSfNHKpUPVJH9nWmXZio
         kJOREGYNNhC1g99G6UgaphXkk0pG423um71YceHpy9HOAGm5sNFict53dTF7gxuY76J1
         w4oSXik7HGhdksW+NK+CqBB5ZpqyXsaCA/ySBFc/8YVMiOJ2SI9NJw0zmd1xC9yIGGW/
         D+9oXts12GXK4zJtk7OC5i/lnm6y6QopmBIogPwr/MiGqy1N82nF7+4O+96BUKTMw2lr
         3ysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723680640; x=1724285440;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MHx+ajFP4u5MwGcW5VOG3NeKYA0jdyc8yxoRkce+2lk=;
        b=kw5WNdytPddjRLJRYZYdKVAdUFC1TdgJVcYZ9skcd7NR6Joat1JDpCHzzP4WYlbjO9
         MjA6in25QheMrDcxZC/7P3tJOPm17vreGt2OIvWs5PGwdPBXKpqBNk095/MHFZ1UGPvo
         2dHzaHIa0rM/Yrt7sKQtrK9iINmHmO8/tZVJGK/DkhiMZbuiep9oHbprx35xPXzlXfeY
         xfQpfkhB1yxSzsQAu//hgb1XhK+ku7ECWFZqyannnU3zE4D9pBMwc7eSj5OrBlRh6FqE
         OCkWCxz/OT8tPoQrrpZh6vqrXETbUDn42Er4FbHtw28ZN6NWJG+lIjQf96x+jBuq17vD
         z3dw==
X-Forwarded-Encrypted: i=1; AJvYcCV8Wr0dI6w0tIJU6gNRbeSaItG6O/zBPwb1N6nJIl5U1K2pOA42A4jwjCGGgC9ZKICfRQoEhhR3gKf7zZo/3xEOvxBE
X-Gm-Message-State: AOJu0Yxe2MUEdzQt8zH2W3+C4+ZBaABd7y1p1zUAgdx9UrMFMmhEnbW+
	NX1QYY/K8rB5UH2AKp01cRuLiAnCeqo/9IxTLExhaqHHtmOHDHmtvwREjL9kt/s=
X-Google-Smtp-Source: AGHT+IHVnfH29KB792c6w0sWOVWj1KeeuZGAfvF13M27u9vbhOuHHR2E6U3NJln7QGTg/JhafPKmBg==
X-Received: by 2002:a17:902:db11:b0:1fa:9c04:946a with SMTP id d9443c01a7336-201d638d9c3mr63190595ad.1.1723680640120;
        Wed, 14 Aug 2024 17:10:40 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f03b15a4sm1821435ad.305.2024.08.14.17.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 17:10:39 -0700 (PDT)
Message-ID: <881f9163509d2f85ba7265315218b8489d53913e.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf/selftests: coverage for calling kfuncs
 within tracepoint
From: Eduard Zingerman <eddyz87@gmail.com>
To: JP Kobryn <inwardvessel@gmail.com>, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org
Date: Wed, 14 Aug 2024 17:10:35 -0700
In-Reply-To: <20240814235800.15253-2-inwardvessel@gmail.com>
References: <20240814235800.15253-1-inwardvessel@gmail.com>
	 <20240814235800.15253-2-inwardvessel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-08-14 at 16:57 -0700, JP Kobryn wrote:
> This test exposes the issue of being unable to call kfuncs within a
> normal tracepoint program. The program will be rejected by the verifier
> as not allowed.
>=20
> Signed-off-by: JP Kobryn <inwardvessel@gmail.com>
> ---

I have no opinion regarding the gist of this patch-set,
just a few technical nits.

Please swap places for patches 1 and 2, such that at any point in
commit history selftests are passing. This should help with any
potential bisect.

>  .../selftests/bpf/prog_tests/kfunc_in_tp.c    | 34 ++++++++++++++++++
>  .../selftests/bpf/progs/test_kfunc_in_tp.c    | 35 +++++++++++++++++++
>  2 files changed, 69 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/kfunc_in_tp.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_kfunc_in_tp.c
>=20
> diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_in_tp.c b/tools=
/testing/selftests/bpf/prog_tests/kfunc_in_tp.c
> new file mode 100644
> index 000000000000..bef1d192fc00
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/kfunc_in_tp.c
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
> +
> +#include <errno.h>
> +#include <sys/syscall.h>
> +#include <unistd.h>
> +
> +#include "test_kfunc_in_tp.skel.h"
> +#include "test_progs.h"
> +
> +static void run_tp(void)
> +{
> +	(void)syscall(__NR_getpid);
> +}
> +
> +void test_kfunc_in_tp(void)

Could you please consider use of test_loader framework for these tests?
This would make 'kfunc_in_tp.c' unnecessary.
Example of tests using this framework:

    tools/testing/selftests/bpf/progs/cpumask_failure.c

(but please, integrate with tools/testing/selftests/bpf/prog_tests/verifier=
.c
 to avoid creation of unnecessary files).

> +{
> +	struct test_kfunc_in_tp *skel;
> +	int err;
> +
> +	skel =3D test_kfunc_in_tp__open();
> +	ASSERT_OK_PTR(skel, "test_kfunc_in_tp__open");
> +
> +	err =3D test_kfunc_in_tp__load(skel);
> +	ASSERT_OK(err, "test_kfunc_in_tp__load");
> +
> +	err =3D test_kfunc_in_tp__attach(skel);
> +	ASSERT_OK(err, "test_kfunc_in_tp__attach");
> +
> +	run_tp();
> +	ASSERT_OK(skel->data->result, "complete");
> +
> +	test_kfunc_in_tp__destroy(skel);
> +}

[...]


