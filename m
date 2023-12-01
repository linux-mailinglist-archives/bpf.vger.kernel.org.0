Return-Path: <bpf+bounces-16390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDCD800E61
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 16:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E226B21358
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 15:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676984A9B4;
	Fri,  1 Dec 2023 15:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMxUK/tM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55361268A
	for <bpf@vger.kernel.org>; Fri,  1 Dec 2023 07:16:50 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-54b0e553979so2804327a12.2
        for <bpf@vger.kernel.org>; Fri, 01 Dec 2023 07:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701443808; x=1702048608; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aeJ9Rjkar/2/s0q08xq7nIRYp2nog3CrKcawp+aI35A=;
        b=dMxUK/tMogCt+omQZZnlA0Y5tpGe/3WVGbdUvWXMy1ZXk5QE4FRTgfz1uPahRY3nGH
         f5HwQ80N2pRXMOvxuovZXRWB4pggNmv/sn8HoBgyNsKI5Z5jK0nshuD7TzbvsSwZiDV5
         DOCLjes0kKJInm3rjzgOs/KGpLYvBHOYWBDgRQQLnFKSvFjp4N/HIOKpRNZnM/hxUwWQ
         tLIqQkZpNKHk3X3bLYX4r3+2Jl2W1PU5jf6UKO7Z+T0982y8hDMwrUyYkXnblxlmiyk7
         OEglW347WdZhh8HyTrXH3kDlg/uKScdHahOeiGixxdmN+4dePR8d7JqbNyMmi45GROO5
         FHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701443808; x=1702048608;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aeJ9Rjkar/2/s0q08xq7nIRYp2nog3CrKcawp+aI35A=;
        b=Lc4LqnFbHvGsLtL5MQp5OnJzwDfl5ONBsoIc6LoTLRl7QspZngthecx9iPFjQqOLEA
         F/oime06SNd1RoJTZnCOAEti9tUaEKZY5KfaEicYnRZmfMA7q+JWO6ipIaiph3p/jApN
         LjlOeeH1tDe68In8Ot9SDy/SIyiEYwPerOun/93gzjt0+vprF4RYQhNmkAdpj90Br7HN
         +Wt1glu2wwwCHVud6KUji1ccPoWi8Jw6BAfcHQBtGvnsMetc2QrARwmaOSCirEQrytAP
         +YQuaMSJN0lUQ0RU8Bg0FWeTZkqTTrZKdV7Nex61ybx6e9g/yDPxWhVVDJN8DAu3bxoQ
         1MUg==
X-Gm-Message-State: AOJu0YyZpBAA1vL2ntZY5+JNmm3WNRbhp3RQ/dEf6a79bSn4Wdyzwmat
	8qZEr6PyBjJn7w5C/5BHkDs=
X-Google-Smtp-Source: AGHT+IGXQlZbdeNJBrZh7AU7ony++5yHeaZw9SrZx0vDHVMotehf+v5azowPmltzt3VDsI6qHx7elg==
X-Received: by 2002:a50:99c8:0:b0:54c:4837:8202 with SMTP id n8-20020a5099c8000000b0054c48378202mr1015912edb.83.1701443808289;
        Fri, 01 Dec 2023 07:16:48 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id g14-20020a50ee0e000000b0054bca15bf7bsm1725664eds.3.2023.12.01.07.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 07:16:47 -0800 (PST)
Message-ID: <68fc1915f6d0fec5d4503052dfabe0f0f9fb6d91.camel@gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: validate eliminated global
 subprog is not freplaceable
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Fri, 01 Dec 2023 17:16:41 +0200
In-Reply-To: <20231201013006.910349-1-andrii@kernel.org>
References: <20231201013006.910349-1-andrii@kernel.org>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=mQGNBGKNNQEBDACwcUNXZOGTzn4rr7Sd18SA5Wv0Wna/ONE0ZwZEx+sIjyGrPOIhR14/DsOr3ZJer9UJ/WAJwbxOBj6E5Y2iF7grehljNbLr/jMjzPJ+hJpfOEAb5xjCB8xIqDoric1WRcCaRB+tDSk7jcsIIiMish0diTK3qTdu4MB6i/sh4aeFs2nifkNi3LdBuk8Xnk+RJHRoKFJ+C+EoSmQPuDQIRaF9N2m4yO0eG36N8jLwvUXnZzGvHkphoQ9ztbRJp58oh6xT7uH62m98OHbsVgzYKvHyBu/IU2ku5kVG9pLrFp25xfD4YdlMMkJH6l+jk+cpY0cvMTS1b6/g+1fyPM+uzD8Wy+9LtZ4PHwLZX+t4ONb/48i5AKq/jSsb5HWdciLuKEwlMyFAihZamZpEj+9n91NLPX4n7XeThXHaEvaeVVl4hfW/1Qsao7l1YjU/NCHuLaDeH4U1P59bagjwo9d1n5/PESeuD4QJFNqW+zkmE4tmyTZ6bPV6T5xdDRHeiITGc00AEQEAAbQkRWR1YXJkIFppbmdlcm1hbiA8ZWRkeXo4N0BnbWFpbC5jb20+iQHUBBMBCgA+FiEEx+6LrjApQyqnXCYELgxleklgRAkFAmKNNQECGwMFCQPCZwAFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQLgxleklgRAlWZAv/cJ5v3zlEyP0/jMKQBqbVCCHTirPEw+nqxbkeSO6r2FUds0NnGA9a6NPOpBH+qW7a6+n6q3sIbvH7jlss4pzLI7LYlDC6z+egTv7KR5X1xFrY1uR5UGs1beAjnzYeV2hK4yqRUfygsT0Wk5e4FiNBv4+DUZ8r0cNDkO6swJxU55DO21mcteC147+4aDoHZ40R0tsAu+brDGSSoOPpb0RWVsEf9XOBJqWWA+T7mluw
 nYzhLWGcczc6J71q1Dje0l5vIPaSFOgwmWD4DA+WvuxM/shH4rtWeodbv iCTce6yYIygHgUAtJcHozAlgRrL0jz44cggBTcoeXp/atckXK546OugZPnl00J3qmm5uWAznU6T5YDv2vCvAMEbz69ib+kHtnOSBvR0Jb86UZZqSb4ATfwMOWe9htGTjKMb0QQOLK0mTcrk/TtymaG+T4Fsos0kgrxqjgfrxxEhYcVNW8v8HISmFGFbqsJmFbVtgk68BcU0wgF8oFxo7u+XYQDdKbI1uQGNBGKNNQEBDADbQIdo8L3sdSWGQtu+LnFqCZoAbYurZCmUjLV3df1b+sg+GJZvVTmMZnzDP/ADufcbjopBBjGTRAY4L76T2niu2EpjclMMM3mtrOc738Kr3+RvPjUupdkZ1ZEZaWpf4cZm+4wH5GUfyu5pmD5WXX2i1r9XaUjeVtebvbuXWmWI1ZDTfOkiz/6Z0GDSeQeEqx2PXYBcepU7S9UNWttDtiZ0+IH4DZcvyKPUcK3tOj4u8GvO3RnOrglERzNCM/WhVdG1+vgU9fXO83TB/PcfAsvxYSie7u792s/I+yA4XKKh82PSTvTzg2/4vEDGpI9yubkfXRkQN28w+HKF5qoRB8/L1ZW/brlXkNzA6SveJhCnH7aOF0Yezl6TfX27w1CW5Xmvfi7X33V/SPvo0tY1THrO1c+bOjt5F+2/K3tvejmXMS/I6URwa8n1e767y5ErFKyXAYRweE9zarEgpNZTuSIGNNAqK+SiLLXt51G7P30TVavIeB6s2lCt1QKt62ccLqUAEQEAAYkBvAQYAQoAJhYhBMfui64wKUMqp1wmBC4MZXpJYEQJBQJijTUBAhsMBQkDwmcAAAoJEC4MZXpJYEQJkRAMAKNvWVwtXm/WxWoiLnXyF2WGXKoDe5+itTLvBmKcV/b1OKZF1s90V7WfSBz712eFAynEzyeezPbwU8QBiTpZcHXwQni3IYKvsh7s
 t1iq+gsfnXbPz5AnS598ScZI1oP7OrPSFJkt/z4acEbOQDQs8aUqrd46PV jsdqGvKnXZxzylux29UTNby4jTlz9pNJM+wPrDRmGfchLDUmf6CffaUYCbu4FiId+9+dcTCDvxbABRy1C3OJ8QY7cxfJ+pEZW18fRJ0XCl/fiV/ecAOfB3HsqgTzAn555h0rkFgay0hAvMU/mAW/CFNSIxV397zm749ZNLA0L2dMy1AKuOqH+/B+/ImBfJMDjmdyJQ8WU/OFRuGLdqOd2oZrA1iuPIa+yUYyZkaZfz/emQwpIL1+Q4p1R/OplA4yc301AqruXXUcVDbEB+joHW3hy5FwK5t5OwTKatrSJBkydSF9zdXy98fYzGniRyRA65P0Ix/8J3BYB4edY2/w0Ip/mdYsYQljBY0A==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-11-30 at 17:30 -0800, Andrii Nakryiko wrote:
> Add selftest that establishes dead code-eliminated valid global subprog
> (global_dead) and makes sure that it's not possible to freplace it, as
> it's effectively not there. This test will fail with unexpected success
> before 2afae08c9dcb ("bpf: Validate global subprogs lazily").
>=20
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
> diff --git a/tools/testing/selftests/bpf/prog_tests/global_func_dead_code=
.c b/tools/testing/selftests/bpf/prog_tests/global_func_dead_code.c
[...]
> +void test_global_func_dead_code(void)
> +{
[...]
> +	ASSERT_HAS_SUBSTR(log_buf, "Subprog global_dead doesn't exist", "dead_s=
ubprog_missing_msg");

Nit: the log is not printed if verbose tests execution is requested.

[...]

> index a0a5efd1caa1..7f9b21a1c5a7 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_global_subprogs.c
> @@ -10,25 +10,31 @@
> =20
>  int arr[1];
>  int unkn_idx;
> +const volatile bool call_dead_subprog =3D false;
> =20
> -__noinline long global_bad(void)
> +__noinline long global_bad(int x)
>  {
> -	return arr[unkn_idx]; /* BOOM */
> +	return arr[unkn_idx] + x; /* BOOM */
>  }

Nit/question:
  Why change prototype from (void) to (int) here and elsewhere?
  Does not seem necessary for test logic.

[...]

