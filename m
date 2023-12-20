Return-Path: <bpf+bounces-18404-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D1081A5FC
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 18:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3ABB5B222B0
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 17:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE80D4777F;
	Wed, 20 Dec 2023 17:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BT4+uRsY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351E94777E
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 17:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a2699ee30d1so49950466b.2
        for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 09:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703092044; x=1703696844; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XJrQxgkFJExqF+syvwQH5GdWqLalF2TKgSCCUDhEwsg=;
        b=BT4+uRsY8eWoAbmwzf3oXrhVrVP5pZnZ4bnNCxxrtQ14Gwvy+q/r+m9QI+nX3AXT98
         QkRfO9RC9A1CJ9bhNNf1ihcgtJK8C5zBTpF6xowKM0NarzD3X2IpfJGbvPC/3YYE/D7D
         qkTzqWTm/KsmqB5HYtQvGTCp99TpCzWCzwhOOWQJoKBqFvPbL88amfE7WwAbkGgGmkXg
         NYMkJ3jSIEtB9v3y5rkBpiu5v4C95Tg4M4aeUPEUgni/V1hHAgYhSLaWC8eFvr8nhs4q
         pfEUR4Wr1BKlAITakHK/V7JPvU9iDGwu8aeaHdiDW8SdMPkbiswF227Qfrn83j13BTbN
         3DTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703092044; x=1703696844;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XJrQxgkFJExqF+syvwQH5GdWqLalF2TKgSCCUDhEwsg=;
        b=myy/2a5RrqAVYuPqRHlAh1oF51Zu9D2qlIMymerD1NxvM34Cheu5GQA1WW51wntGZk
         OQGg4WWI93Vu+KbzrWuxojuqx0jTBvoGbD3kX33E+LFzQCWP6k6k2KMhjbX4nwP9qyKa
         97hURCf09vSAczHGtsRzcA7RzM89HULRth/kcxmDDjXM2k8wNDe8BXDNW5fBpThCWmWb
         76FrHthJR7kRh+ZTvUzxggSyzojaQvvv6XaaEwnj2EhHP8+sgeSbvqf5Rcsazh7riYDS
         qdrke22HjFQLvy5rrMAfIogZQqmraj2rli3oIJh/lMnW8eiVU3aNdVoZ59wA4ZqXb/4Q
         F9NQ==
X-Gm-Message-State: AOJu0Yykyzq/7VG5IWrpqg1uBelLo/PklMOYAUgh26auslSxTEuBtxxc
	AtNyM2MwnpdMY1+oL0Qjp6IzWvKBQKuV7w==
X-Google-Smtp-Source: AGHT+IEeRtGXDgCTXDcbMDZMZVExwW3k0/K5jIn9Cm4Asdqlbaoj+AYfXHyFzhQzIaIAco6QlPDbpA==
X-Received: by 2002:a17:906:159:b0:a22:eae6:1657 with SMTP id 25-20020a170906015900b00a22eae61657mr7941234ejh.33.1703092044312;
        Wed, 20 Dec 2023 09:07:24 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id ew18-20020a170907951200b00a1dd58874b8sm18753ejc.119.2023.12.20.09.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 09:07:23 -0800 (PST)
Message-ID: <3ced2738d99310fdd448ecbcbf1370b6f60bc05f.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: Support inlining bpf_kptr_xchg()
 helper
From: Eduard Zingerman <eddyz87@gmail.com>
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Song
 Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, Yonghong Song
 <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Jiri Olsa
 <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
 houtao1@huawei.com
Date: Wed, 20 Dec 2023 19:07:22 +0200
In-Reply-To: <20231219135615.2656572-2-houtao@huaweicloud.com>
References: <20231219135615.2656572-1-houtao@huaweicloud.com>
	 <20231219135615.2656572-2-houtao@huaweicloud.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-12-19 at 21:56 +0800, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
[...]
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9456ee0ad129..7814c4f7576e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19668,6 +19668,23 @@ static int do_misc_fixups(struct bpf_verifier_en=
v *env)
>  			continue;
>  		}
> =20
> +		/* Implement bpf_kptr_xchg inline */
> +		if (prog->jit_requested && BITS_PER_LONG =3D=3D 64 &&
> +		    insn->imm =3D=3D BPF_FUNC_kptr_xchg &&
> +		    bpf_jit_supports_ptr_xchg()) {
> +			insn_buf[0] =3D BPF_MOV64_REG(BPF_REG_0, BPF_REG_2);
> +			insn_buf[1] =3D BPF_ATOMIC_OP(BPF_DW, BPF_XCHG, BPF_REG_1, BPF_REG_0,=
 0);
> +			cnt =3D 2;
> +
> +			new_prog =3D bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
> +			if (!new_prog)
> +				return -ENOMEM;
> +
> +			delta    +=3D cnt - 1;
> +			env->prog =3D prog =3D new_prog;
> +			insn      =3D new_prog->insnsi + i + delta;
> +			continue;
> +		}
>  patch_call_imm:
>  		fn =3D env->ops->get_func_proto(insn->imm, env->prog);
>  		/* all functions that have prototype and verifier allowed

Hi Hou,

I have a suggestion about testing this rewrite.
It is possible to use function get_xlated_program() from
tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c,
to obtain a BPF disassembly for the program after
do_misc_fixups() are applied.

So, it shouldn't be difficult to:
- prepare a dummy program in progs/ that uses bpf_kptr_xchg();
- prepare a new test_* function in prog_tests/ that:
  - loads that dummy program;
  - queries it's disassembly using get_xlated_program();
  - compares it with expected template.

I know that do_misc_fixups() are usually not tested this way,
but that does not mean they shouldn't, wdyt?

Thanks,
Eduard

