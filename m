Return-Path: <bpf+bounces-10479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2CC7A8B22
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 20:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 090872816B4
	for <lists+bpf@lfdr.de>; Wed, 20 Sep 2023 18:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0DE3FB3B;
	Wed, 20 Sep 2023 18:06:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E553C1A5A2
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 18:06:50 +0000 (UTC)
Received: from sonic311-30.consmr.mail.ne1.yahoo.com (sonic311-30.consmr.mail.ne1.yahoo.com [66.163.188.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA1F94
	for <bpf@vger.kernel.org>; Wed, 20 Sep 2023 11:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1695233208; bh=hRtjVQ6/Khk/MfUicAh5qdWtkIXSrKJMODQOgKOQ69A=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=eyLmgiiyQiyo3l7r/A2AjPz5vtggZaqSKZ4ctvyqvGj8Fwbs6CwUcwXJARZmn35MASS9ZBCNE5WJZ4rImq+tfD/ewoT3Uw8/0OLpO/UV8v89hk5yLntQnLgk5+4bz75btXo70gkHiYrCeSQC9CWuO1lwVHbyTqT9sGMw6S9lymRR3lm3A7+pMhT236ceF+PfAD+wnQu7jW765ezFUAVrMELejS1iQi2k7ps8HJbOrXpiUIQ9Qg9yGH2XOt0WHkGy2fJ0ae4xtwCpJa4xAy54CYIS05pLzdpFFbnfQJ8PuiaNXtNN4UJCxRqwQZkxWqMQR61EQ+RDgV8cSppaCzJ/vQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1695233208; bh=6qa9bUTwJ9WQIG7vYWyifPpDf3qviTdwDdy/VcqBlG6=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=MncPQRYdxXU8nHt45KrMjDqUkxqDwqGVxzAb7mpjV37lwMD3VjzvvI7SM9wEu9jxYmHv5teTyiwKVJsrkzHvX80nnWQQTUv2C+FSMnYX8hVH0T7YicljkMbzY4Z7CSx7fXHwL0DWO5eYGc1FT2NGvwjH9ut3OuEwtRuYYFXBl3xs+4W9JzLHA+89TIifIULuK2DldgXCGCOi2farVjcfZhj3txChq+7tZoJI8OCkQW4Peea+c8CoBK6j1a+JQi0NIhYxldvJBE3aRfXzr3iHIeduB7YTQlb2+zdhYN9NnJ1nTtcwIL7fjc3yEjeCg/t3CZARwu9gz1H2HoG8AYzhgg==
X-YMail-OSG: pqeh1iYVM1nClyt83ijimBrbimIp8_2RfD9OtV97FoBQEOQZfaWy5zDxf20ovmo
 A620fRR3EbQ72MgFw0POCC25rnRQ_wGvPo8UiKoQQpoJh7rkIgbXweIJTU..SUEqLabyL0RSD2RB
 1TC6hCjgn4VSl3gBJXEzk7XR92Wjrj8QFFaWoqGMhKf3UmFzV8K_kZQOpfZ0LEkEVguALrxtn3P0
 3AbzrBr9gcALLywxdf7LSG3wd8sgIGyS0y6B.vla8PnNuru.kCUeGmtQ6.Y58XXDhRqdpAx5E.JQ
 7gNWBZ4frcfUQyI55OXi49Bim6erB6EfUKATsRCQ_t.Q_Jka2_7MzmM_KDObNUHMgBJ1YYKwoPfm
 we3nTTbhcwK1IDZIENrUKEQXicao7FtxR5Tj4g29nlr2nR2P1UlhXi6ekXzvb0Usqqu_2RmrHx5T
 5DBkpBRKgzwOfXWkolP8RmSsW8DIx1isIIDCo.5P4klZtVjeqMuHW_oz5ELHnqd.c.3nOrejhh41
 jzwpzc_ppBadMWb5704e.aPQyWlyEe25vJFkUJQGddnUMhZVjPLe2Q1nVJKbIEt1f.d7aAQZ0BIZ
 AciiMCpB6mzNUFlpVtb4KElEmRIH7num_bjTr7NUsw286AGAWu1iIeRIm2lYaaSuxH8YZYvaVf39
 wM9Z43jFy.eV7wtjP.20wCYfjAhYb6IXV1264e9YG9m33f1c47ZINr2kM0G6A1mKBs2VAaQMfpz6
 prmYsBTNVrw2oxTAeEFlo56.RDB3p.KAlCvBv58NnvkzvDXg8_c.aSJNz32UINKiAhuIxS8otAvS
 RXkzjyzbnrb2fdS7V7Hoc1rfQfX5t.3Z2nLSUdts8ogfNju7C3NYR4vVJKKV8QSJkk5kFqrsng5e
 o2tV1aTLMOWyxEnmfnNLGFShzgFEmC2kqD55LErGev.L7qpKFojq0w7jIsXV1D9XX4L_TpMY.QYD
 NkvYFxbtOWY9lahtzDeJ9t2Nj1NC9VLXzH87i6hE4jHNf.3tnvpWr4w4uT6lsDrloSMDI5rbzhdx
 s6Manii_m465Z6ogxzsaNS2uyBXejLUwfvUQqpnGlKACH8jg4gLPldr0Dcc_OopbHmvKCxfygZli
 CLUMw9ZUtu07OqoVkkEbQRgoJeQc7y.aD.sk60.Khlo71gKl_IKjmjNbaSFZtlJq1VLJbti_nEE1
 uDI4ygpgOozo1z78LgXx6pvAHWtCv9XkVy5x0ZvBSS1n_N1n_jG1M9STuGaEDBPx.iVz6vf6v0Hz
 jeS5E5pOw_y3kh1_Wc2Hkkev6nuzVv8sU6v5ZpQGgdre9Ls7BYk67O1fq.V296pZDD0CgrzwG0qd
 APGSXoVira3e1g.JSOxaQk5Sm2AAeUEg2pCDh9wPO8m.B8XILs1hbP3i6FBEyKm4v21m09iNhH1W
 Vakk6glvydGNJ4IBf7ZffUQ6RhzzrG96.HP79sV4paRwe948owjxT_PpJaY4hno7NIjkmC3._Ei4
 agGqG0WqcHDlWXMWuE6MZCPpxWd3o_iz2eqsOoqcII9Rdpv.eWaKKHTnNSWRjZJEi4MyMBrtINXO
 R.u1DVwn7IlGNIg0XwgX9JqyL9GpNSMsHMqIyCitRO5AA9imQRcO5DdUZRN7bBq3peZgaM4a7oGx
 O0zk7kpZgVmghvHhNoqCnQLWNQMNr5EcBaIFYIEy3L1tDNFJJMZVRodDbG.vIyifCPG5hnQYmSbU
 CtZs7t2KaoN64oA0b1eytqbn.FH.Cu1NXcFJYzqKkWhNgiKHQxCZ7Abd5iXK6TjrdQEqco9rjzqd
 npTwZnHj90PSKslUWXExv69X068OUFc7UimrKZ4z.hfdrCDndmhMROwyNGpknMROlrxAOf0VTpJq
 Bs1HhO2tNTpfBkYO_bcn7NSG_kXkK4Rh4Z.PDrvA_htOrqiBHe1kRrCALjWMgtyBywwCRz5_rVPO
 sDzslOkJInUp8ZnkNfFSkLiZnkT9IP8M8chgMxOAe36LB4B6KeHYXpHVWCVYVxQJlrTdcxdZC.ji
 H5MRXCrOk3enPQ_79Zc63wX0gceptY.r4x1P1Yg.1kzE7HR2j.DjX9Bb1MmEHHJdgKTS1FYgkVBD
 QQhpNplF8SXTKKYnj0W5_.FwPhX.IAPhu3FblSgphO98SYHFrTR_BhDrd8kWKUqGZR0A47505LAI
 ogS15cWlBc7gUrpes6qkZEC_w5aVnZlelh8ZQO0ScvfAzOSny0i9BN4fEESNQ8m25CqtdgPkrUQN
 QlenWx9CFJjESF_zvfaDf_YE-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: cd73b909-979b-4621-942b-c5c7c3952a79
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Wed, 20 Sep 2023 18:06:48 +0000
Received: by hermes--production-bf1-678f64c47b-5k7bw (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2cb5464a6ae5309e39cd6e68f4047bed;
          Wed, 20 Sep 2023 18:06:46 +0000 (UTC)
Message-ID: <52867a35-ec5e-3fa5-dde5-2722dc3a94a3@schaufler-ca.com>
Date: Wed, 20 Sep 2023 11:06:42 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 1/5] kernel: Add helper macros for loop unrolling
Content-Language: en-US
To: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org,
 bpf@vger.kernel.org
Cc: paul@paul-moore.com, keescook@chromium.org, song@kernel.org,
 daniel@iogearbox.net, ast@kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20230918212459.1937798-1-kpsingh@kernel.org>
 <20230918212459.1937798-2-kpsingh@kernel.org>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230918212459.1937798-2-kpsingh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21797 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/18/2023 2:24 PM, KP Singh wrote:
> This helps in easily initializing blocks of code (e.g. static calls and
> keys).
>
> UNROLL(N, MACRO, __VA_ARGS__) calls MACRO N times with the first
> argument as the index of the iteration. This allows string pasting to
> create unique tokens for variable names, function calls etc.
>
> As an example:
>
> 	#include <linux/unroll.h>
>
> 	#define MACRO(N, a, b)            \
> 		int add_##N(int a, int b) \
> 		{                         \
> 			return a + b + N; \
> 		}
>
> 	UNROLL(2, MACRO, x, y)
>
> expands to:
>
> 	int add_0(int x, int y)
> 	{
> 		return x + y + 0;
> 	}
>
> 	int add_1(int x, int y)
> 	{
> 		return x + y + 1;
> 	}
>
> Signed-off-by: KP Singh <kpsingh@kernel.org>

I confess that I find some of the macros are scary, nonetheless

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>

> ---
>  include/linux/unroll.h | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 include/linux/unroll.h
>
> diff --git a/include/linux/unroll.h b/include/linux/unroll.h
> new file mode 100644
> index 000000000000..d42fd6366373
> --- /dev/null
> +++ b/include/linux/unroll.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Copyright (C) 2023 Google LLC.
> + */
> +
> +#ifndef __UNROLL_H
> +#define __UNROLL_H
> +
> +#include <linux/args.h>
> +
> +#define UNROLL(N, MACRO, args...) CONCATENATE(__UNROLL_, N)(MACRO, args)
> +
> +#define __UNROLL_0(MACRO, args...)
> +#define __UNROLL_1(MACRO, args...)  __UNROLL_0(MACRO, args)  MACRO(0, args)
> +#define __UNROLL_2(MACRO, args...)  __UNROLL_1(MACRO, args)  MACRO(1, args)
> +#define __UNROLL_3(MACRO, args...)  __UNROLL_2(MACRO, args)  MACRO(2, args)
> +#define __UNROLL_4(MACRO, args...)  __UNROLL_3(MACRO, args)  MACRO(3, args)
> +#define __UNROLL_5(MACRO, args...)  __UNROLL_4(MACRO, args)  MACRO(4, args)
> +#define __UNROLL_6(MACRO, args...)  __UNROLL_5(MACRO, args)  MACRO(5, args)
> +#define __UNROLL_7(MACRO, args...)  __UNROLL_6(MACRO, args)  MACRO(6, args)
> +#define __UNROLL_8(MACRO, args...)  __UNROLL_7(MACRO, args)  MACRO(7, args)
> +#define __UNROLL_9(MACRO, args...)  __UNROLL_8(MACRO, args)  MACRO(8, args)
> +#define __UNROLL_10(MACRO, args...) __UNROLL_9(MACRO, args)  MACRO(9, args)
> +#define __UNROLL_11(MACRO, args...) __UNROLL_10(MACRO, args) MACRO(10, args)
> +#define __UNROLL_12(MACRO, args...) __UNROLL_11(MACRO, args) MACRO(11, args)
> +#define __UNROLL_13(MACRO, args...) __UNROLL_12(MACRO, args) MACRO(12, args)
> +#define __UNROLL_14(MACRO, args...) __UNROLL_13(MACRO, args) MACRO(13, args)
> +#define __UNROLL_15(MACRO, args...) __UNROLL_14(MACRO, args) MACRO(14, args)
> +#define __UNROLL_16(MACRO, args...) __UNROLL_15(MACRO, args) MACRO(15, args)
> +#define __UNROLL_17(MACRO, args...) __UNROLL_16(MACRO, args) MACRO(16, args)
> +#define __UNROLL_18(MACRO, args...) __UNROLL_17(MACRO, args) MACRO(17, args)
> +#define __UNROLL_19(MACRO, args...) __UNROLL_18(MACRO, args) MACRO(18, args)
> +#define __UNROLL_20(MACRO, args...) __UNROLL_19(MACRO, args) MACRO(19, args)
> +
> +#endif /* __UNROLL_H */

