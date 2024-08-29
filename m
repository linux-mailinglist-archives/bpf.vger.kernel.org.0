Return-Path: <bpf+bounces-38380-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D02963CD2
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 09:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4279B22E32
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 07:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1470C173331;
	Thu, 29 Aug 2024 07:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyUeANWk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0BE15DBC1
	for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 07:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724916474; cv=none; b=AuD7pGbcNI0e23yQD+EfU/3Mfci8oCbugWObERebbMLnZhumvUOw+Higlp3+GCyNQVXcB2QyxRJRLkeRmxG1viWI+dfh+IUjA3Bdls0rd3xz9Y8nP3Ta3vi8S/mqUaOPAQWZZz/RJhn2W+7fJQD0i/q6GzMVpTU2+aBVCcOLlEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724916474; c=relaxed/simple;
	bh=QP3s4qd5DQN03e1PHkjZ1ljQxACtIOsi/luo/KVT2a8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ByYLFSp1xrwn8QwUtMppUuf4o6o+6qlyaSm5vfE2bP6z7zAquWq32sNcWINstEpKgB2H2lxtqYEtIxyoUfWtCEodnOHDky+XYyRps81TXATgrNr9tHLcdJEP77lShiXQ/by5MGtKFaFQspyySFgHMRoYfG99I7T/1fs2NSs+9yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XyUeANWk; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2021c03c13aso2828115ad.1
        for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 00:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724916472; x=1725521272; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/lcmC1LaNrGEOHMKaKAdw228XEPIXA0Qgnr96jOhl5o=;
        b=XyUeANWkpVwG/Xol1mIilztRnBE7rMAtODgVR49BIxnQAxgpFuNJ9wilEZb+/PP2LC
         auANEpkGtVsrJrfsgG4KrzXCBZvO9kTc9nmDLYJVZ759gBaY2WAasK+d5D4isQ6oOQ3V
         8OgRSX+/WOSs9JDWTXo5/Kw9Jw05cI5b42DwSo5PUN48sIPcQAGmd4jsFILArsBflqvV
         ZnbijmYsmtCigYHlupMWXg2kJ1hFnAbLkEKyNXCY3teDXZEOFy+4SFkADzjSyYoWfMpQ
         7hSBgFXSL5zFZoA3tQ72hCF064NPOLfL75/a+p8Sni30UXESkNXgu/4AG7uTYnE21Kky
         f8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724916472; x=1725521272;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/lcmC1LaNrGEOHMKaKAdw228XEPIXA0Qgnr96jOhl5o=;
        b=wEx4u+JpuY/sUztGDJ7SuvpYTd0SciD+b6aYsScXQhm5jtGdkYH0VD5RsgSvhIwVGd
         Dp67FFyZY7H6AUqwphVP7LIXRW9UvRpNvQf83E5JpOTbfr/fugxnENk0I6G3xoCCUT0m
         0ohTZLe0uTrJQmeWFqGyBd7TRrhXbjyzmKpoMYd7ymsyhswDqxrsRZaX6oSbRjVtVrXY
         XFeU5HvXAyCtvejVWymWDcDRRUb9nbSe2VHbrDM3FVOcNJCxPJ3LyKPlPm/rConST561
         gpJXYVTeKietOkqznPUk12RGY2lobXR+nQkyQtC2ksiEAio+jBWaFyD9YeLVsz1iT8Gw
         kIwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXil73f2VwESwRinXdBHQafCMh/F3HoXz7C1EgVmRpaQ1Y6SuV0VjNG+tKHVi9HULB0P6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxaym1p2L3eyzg7kkEsHnNuSHIT7XKStGe1NM42m7zWpB9LTf/K
	EXxcHZ+ua/+AkfO5Cx7wFk0aLReaqtHhU1SSp3CVUAKfhM0yjq25
X-Google-Smtp-Source: AGHT+IFN6qIqIBqCVHAxMYLUlIPa94/OP/sHqf1kL85CqeqvdVlIhaWSSVj+VEYDpW1z9Uvf/eTuzw==
X-Received: by 2002:a17:903:32cf:b0:1fb:2ebc:d16b with SMTP id d9443c01a7336-2050e961adamr27210945ad.7.1724916472391;
        Thu, 29 Aug 2024 00:27:52 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2051556a5f6sm5603905ad.306.2024.08.29.00.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 00:27:51 -0700 (PDT)
Message-ID: <12566dccdcf9b39cf6b9eda88104451719d18676.camel@gmail.com>
Subject: Re: [PATCH v4 bpf-next 6/9] selftests/bpf: Test gen_prologue and
 gen_epilogue
From: Eduard Zingerman <eddyz87@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Yonghong Song
 <yonghong.song@linux.dev>, Amery Hung <ameryhung@gmail.com>, 
 kernel-team@meta.com
Date: Thu, 29 Aug 2024 00:27:46 -0700
In-Reply-To: <20240827194834.1423815-7-martin.lau@linux.dev>
References: <20240827194834.1423815-1-martin.lau@linux.dev>
	 <20240827194834.1423815-7-martin.lau@linux.dev>
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
> This test adds a new struct_ops "bpf_testmod_st_ops" in bpf_testmod.
> The ops of the bpf_testmod_st_ops is triggered by new kfunc calls
> "bpf_kfunc_st_ops_test_*logue". These new kfunc calls are
> primarily used by the SEC("syscall") program. The test triggering
> sequence is like:
>     SEC("syscall")
>     syscall_prologue_subprog(struct st_ops_args *args)
>         bpf_kfunc_st_op_test_prologue(args)
> 	    st_ops->test_prologue(args)
>=20
> .gen_prologue adds 1000 to args->a
> .gen_epilogue adds 10000 to args->a
> .gen_epilogue will also set the r0 to 2 * args->a.
>=20
> The .gen_prologue and .gen_epilogue of the bpf_testmod_st_ops
> will test the prog->aux->attach_func_name to decide if
> it needs to generate codes.
>=20
> The main programs of the pro_epilogue_subprog.c will call a subprog()
> which does "args->a +=3D 1".
>=20
> The main programs of the pro_epilogue_kfunc.c will call a
> new kfunc bpf_kfunc_st_ops_inc10 which does "args->a +=3D 10".
>=20
> This patch uses the test_loader infra to check the __xlated
> instructions patched after gen_prologue and/or gen_epilogue.
> The __xlated check is based on Eduard's example (Thanks!) in v1.
>=20
> args->a is returned by the struct_ops prog (either the main prog
> or the epilogue). Thus, the __retval of the SEC("syscall") prog
> is checked. For example, when triggering the ops in the
> 'SEC("struct_ops/test_epilogue_subprog") int test_epilogue_subprog'
> The expected args->a is +1 (subprog call) + 10000 (.gen_epilogue) =3D 100=
01.
> The expected return value is 2 * 10001 (.gen_epilogue).
>=20
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> diff --git a/tools/testing/selftests/bpf/progs/pro_epilogue_kfunc.c b/too=
ls/testing/selftests/bpf/progs/pro_epilogue_kfunc.c
> new file mode 100644
> index 000000000000..7d1124cf4942
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/pro_epilogue_kfunc.c
> @@ -0,0 +1,156 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Meta Platforms, Inc. and affiliates. */
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_tracing.h>
> +#include "bpf_misc.h"
> +#include "../bpf_testmod/bpf_testmod.h"
> +#include "../bpf_testmod/bpf_testmod_kfunc.h"
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +void __kfunc_btf_root(void)
> +{
> +	struct st_ops_args args =3D {};
> +
> +	bpf_kfunc_st_ops_inc10(&args);

Nit: 'bpf_kfunc_st_ops_inc10(0);' would also work.

> +}

As a side note, I think that kfunc and subprog sets of tests could be
combined in order to have less code. Probably does not matter.

[...]


