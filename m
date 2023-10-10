Return-Path: <bpf+bounces-11810-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 412827BFF88
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 16:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA014281D31
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 14:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA5F21375;
	Tue, 10 Oct 2023 14:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N25Jh0Yz"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D00CDDA6
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 14:46:44 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C667B9;
	Tue, 10 Oct 2023 07:46:42 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9a6190af24aso1001664766b.0;
        Tue, 10 Oct 2023 07:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696949201; x=1697554001; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w1dSpfK0+acBDpzpVFgyfg1T22Ag8ukFcTmpvayQbNw=;
        b=N25Jh0YzPbSYdObo4IhOM7lRPhwjCr/R2sTYRT8fhjU1L5PVjI/3DVcTyHuKSMk0na
         X1Uvzv5qfGeIdg9bDsyxSw+DHops8oYugAF7If7nX2ZpNKhqwt4l7qKn3gdXw3USEM1w
         2N7Lr/wcVqMyJ6W99z6E5b0BApjA74wTvGub+03eCPBL1rCEH6yMURIsuBLKgT16V4fx
         +66j3P3tSdAO4yla4paS41oz1mGommJYgqaJ9EiIpjMulhMTWju454m6Hzud4XVO+ak1
         lMfMnQh1Sx33dNcBDOKv2xG1NZztj3o4sgiSY0t47LjfEFMbRyKydXE9Owhy4wdwsm3T
         XX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696949201; x=1697554001;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w1dSpfK0+acBDpzpVFgyfg1T22Ag8ukFcTmpvayQbNw=;
        b=M/XqE4JlNioMpYV8IOeg8aUep9LArmahOUGEP/5yBCc9TRUi1ijC48AU/p1iNxn7tf
         t6HPSXOCcKwIgdomfI/xtPHb/++82olUjccwQVG59mRK+NmpABFrtXzckWSWkIlNxBXF
         8vaO5GaHYCv8Lh/B0PVdyZuzdtbxZwrN55ynmxqUjhc3gBKgym3aTN9dwU1WvngmEVPz
         0o8OZtoLw94cMj9Ac05lPHA8Hqwlmd6iRt317zgOzJbwFFICL2UQ+LJRroG/6oKTHLpE
         lx6aW/U4JymJGsd48mLa8abNRWBGzGMjnf3S5p1RvDWOBf4GiMMcw8MU7e61HBxSr6Qk
         zxhQ==
X-Gm-Message-State: AOJu0Yz7Qteu2nqhpI4qo/J3zepByE4VeF17lLVdiyu65CvmIm83ByM7
	EaEAlgKy0PjuwTyHKJOY5AY=
X-Google-Smtp-Source: AGHT+IGFq0/YtecTNhAsBtDYRof/npP23rDl+BWVDMl8f0Gv10Laxrua3LDSDT4sg0EpxwMgZmklyA==
X-Received: by 2002:a17:906:20e:b0:9ad:7e21:5a6d with SMTP id 14-20020a170906020e00b009ad7e215a6dmr16078111ejd.33.1696949200695;
        Tue, 10 Oct 2023 07:46:40 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id t8-20020a17090616c800b009a1be9c29d7sm8681309ejd.179.2023.10.10.07.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 07:46:40 -0700 (PDT)
Message-ID: <a2a875ca30b2629afe6f9804eb43572ac81dcf42.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Detect jumping to reserved code during
 check_cfg()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Hao Sun <sunhao.th@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 10 Oct 2023 17:46:38 +0300
In-Reply-To: <20231010-jmp-into-reserved-fields-v2-1-3dd5a94d1e21@gmail.com>
References: <20231010-jmp-into-reserved-fields-v2-1-3dd5a94d1e21@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.0 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-10-10 at 14:03 +0200, Hao Sun wrote:
> Currently, we don't check if the branch-taken of a jump is reserved code =
of
> ld_imm64. Instead, such a issue is captured in check_ld_imm(). The verifi=
er
> gives the following log in such case:
>=20
> func#0 @0
> 0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
> 0: (18) r4 =3D 0xffff888103436000       ; R4_w=3Dmap_ptr(off=3D0,ks=3D4,v=
s=3D128,imm=3D0)
> 2: (18) r1 =3D 0x1d                     ; R1_w=3D29
> 4: (55) if r4 !=3D 0x0 goto pc+4        ; R4_w=3Dmap_ptr(off=3D0,ks=3D4,v=
s=3D128,imm=3D0)
> 5: (1c) w1 -=3D w1                      ; R1_w=3D0
> 6: (18) r5 =3D 0x32                     ; R5_w=3D50
> 8: (56) if w5 !=3D 0xfffffff4 goto pc-2
> mark_precise: frame0: last_idx 8 first_idx 0 subseq_idx -1
> mark_precise: frame0: regs=3Dr5 stack=3D before 6: (18) r5 =3D 0x32
> 7: R5_w=3D50
> 7: BUG_ld_00
> invalid BPF_LD_IMM insn
>=20
> Here the verifier rejects the program because it thinks insn at 7 is an
> invalid BPF_LD_IMM, but such a error log is not accurate since the issue
> is jumping to reserved code not because the program contains invalid insn=
.
> Therefore, make the verifier check the jump target during check_cfg(). Fo=
r
> the same program, the verifier reports the following log:
>=20
> func#0 @0
> jump to reserved code from insn 8 to 7
>=20
> Also adjust existing tests in ld_imm64.c, testing forward/back jump to
> reserved code.
>=20
> Signed-off-by: Hao Sun <sunhao.th@gmail.com>

Please see a nitpick below.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

> ---
> Changes in v2:
> - Adjust existing test cases
> - Link to v1: https://lore.kernel.org/bpf/20231009-jmp-into-reserved-fiel=
ds-v1-1-d8006e2ac1f6@gmail.com/
> ---
>  kernel/bpf/verifier.c                           | 7 +++++++
>  tools/testing/selftests/bpf/verifier/ld_imm64.c | 8 +++-----
>  2 files changed, 10 insertions(+), 5 deletions(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index eed7350e15f4..725ac0b464cf 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -14980,6 +14980,7 @@ static int push_insn(int t, int w, int e, struct =
bpf_verifier_env *env,
>  {
>  	int *insn_stack =3D env->cfg.insn_stack;
>  	int *insn_state =3D env->cfg.insn_state;
> +	struct bpf_insn *insns =3D env->prog->insnsi;
> =20
>  	if (e =3D=3D FALLTHROUGH && insn_state[t] >=3D (DISCOVERED | FALLTHROUG=
H))
>  		return DONE_EXPLORING;
> @@ -14993,6 +14994,12 @@ static int push_insn(int t, int w, int e, struct=
 bpf_verifier_env *env,
>  		return -EINVAL;
>  	}
> =20
> +	if (e =3D=3D BRANCH && insns[w].code =3D=3D 0) {
> +		verbose_linfo(env, t, "%d", t);
> +		verbose(env, "jump to reserved code from insn %d to %d\n", t, w);
> +		return -EINVAL;
> +	}
> +
>  	if (e =3D=3D BRANCH) {
>  		/* mark branch target for state pruning */
>  		mark_prune_point(env, w);
> diff --git a/tools/testing/selftests/bpf/verifier/ld_imm64.c b/tools/test=
ing/selftests/bpf/verifier/ld_imm64.c
> index f9297900cea6..c34aa78f1877 100644
> --- a/tools/testing/selftests/bpf/verifier/ld_imm64.c
> +++ b/tools/testing/selftests/bpf/verifier/ld_imm64.c
> @@ -9,22 +9,20 @@
>  	BPF_MOV64_IMM(BPF_REG_0, 2),
>  	BPF_EXIT_INSN(),
>  	},
> -	.errstr =3D "invalid BPF_LD_IMM insn",
> -	.errstr_unpriv =3D "R1 pointer comparison",
> +	.errstr =3D "jump to reserved code",
>  	.result =3D REJECT,
>  },
>  {
>  	"test2 ld_imm64",
>  	.insns =3D {
> -	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, 1),
>  	BPF_LD_IMM64(BPF_REG_0, 0),
> +	BPF_JMP_IMM(BPF_JEQ, BPF_REG_1, 0, -2),

This change is not really necessary, the test reports same error
either way.

>  	BPF_LD_IMM64(BPF_REG_0, 0),
>  	BPF_LD_IMM64(BPF_REG_0, 1),
>  	BPF_LD_IMM64(BPF_REG_0, 1),
>  	BPF_EXIT_INSN(),
>  	},
> -	.errstr =3D "invalid BPF_LD_IMM insn",
> -	.errstr_unpriv =3D "R1 pointer comparison",
> +	.errstr =3D "jump to reserved code",
>  	.result =3D REJECT,
>  },
>  {
>=20
> ---
> base-commit: 3157b7ce14bbf468b0ca8613322a05c37b5ae25d
> change-id: 20231009-jmp-into-reserved-fields-fc1a98a8e7dc
>=20
> Best regards,


