Return-Path: <bpf+bounces-7192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87228772DD5
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 20:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF8DB1C20C83
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 18:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCED156FE;
	Mon,  7 Aug 2023 18:26:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BD7111A9
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 18:26:06 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF2A8F
	for <bpf@vger.kernel.org>; Mon,  7 Aug 2023 11:26:05 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99cbfee358eso317899766b.3
        for <bpf@vger.kernel.org>; Mon, 07 Aug 2023 11:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691432764; x=1692037564;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZTQW9HDTEHkdbhFe0RF58oayWNr6jP47W+/OQP97nOM=;
        b=doJN/yTfSORlrofZuxvF6V0Q4ouRex42LqEx4gi/DxyZ169oM8zMM2e8km8l+OcgvB
         9OL/glgQHTJknodk4c6VFboMg/6tdFQ7seZb1XEWk/Uc7ZI6uS3zXHeHsGpIati+S0qy
         E4KNowPbGq8/Uiy05aXBYluRECpo0TBsgYRymYS+0tFDsRt5OvKXTy7ajToUuZjibOO1
         RKhOIp5keF/txO8G3E2IPXfciubplhVoSTtohEXrOEFDNNmh4l3XKj6Xhr3mDj5pQyrU
         eA76CbKn5ot/wJiWUVGT5hm9MpNgPhvF4Y43xKPrQDADAyktvLIFDnc7p+hKT6hlL0i/
         U8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691432764; x=1692037564;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZTQW9HDTEHkdbhFe0RF58oayWNr6jP47W+/OQP97nOM=;
        b=NobiNpL5MKQA1MsDE5F/4mYsvlZSl6IdLE5aE0ldXLDc3kNY78urx1OI31x0F2FB06
         mR9nI6DRsOqQswwF5kxPEn1Igtj0LGttefQnE0n1rb+mU+V7XlozWhPQXskOb4tHHc3u
         nr5tc0JhMOJWJ7kNHIiZPA+iBxPFwd+qzo3h00AOE4vY8oKyjjCkD+8Gz0IM2a1rHnqj
         j9gJuFKLnE0V1yLl4b5mwvocpRbGapHRSo/ivlQ+oIirxt0WXzhANciJAFYfD+P+8ITM
         DJgkxPIVaEkifsN2aaLI2NYbjqyeKykOzqVUwWG/OHcTm8/j9OnNsJ+EjAcY62KwooAj
         KkFg==
X-Gm-Message-State: AOJu0YxCrxcSDejKStHvt5bCWN+J2+HXthhsbII+zNzU/DB9ebMCjbuL
	SZObhy1jPM+UTvPNwB8rruLM4EjbplQ=
X-Google-Smtp-Source: AGHT+IEtXEecStuU00qJ1cfjbm91LLbmlvjEa4hfx9NGqcp+MGWpGdcvK/YM51er10e0ynh6yKHwVQ==
X-Received: by 2002:a17:906:19b:b0:99c:180a:ea61 with SMTP id 27-20020a170906019b00b0099c180aea61mr8295901ejb.32.1691432763583;
        Mon, 07 Aug 2023 11:26:03 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id ch25-20020a170906c2d900b0098d2f703408sm5499117ejb.118.2023.08.07.11.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 11:26:03 -0700 (PDT)
Message-ID: <048f07bbdfb3038bf6ee1cbe6fa67557f45f5f71.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix an incorrect verification success
 with movsx insn
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>, 
 syzbot+d61b595e9205573133b3@syzkaller.appspotmail.com
Date: Mon, 07 Aug 2023 21:26:01 +0300
In-Reply-To: <20230807175721.671696-1-yonghong.song@linux.dev>
References: <20230807175721.671696-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-08-07 at 10:57 -0700, Yonghong Song wrote:
> syzbot reports a verifier bug which triggers a runtime panic.
> The test bpf program is:
>    0: (62) *(u32 *)(r10 -8) =3D 553656332
>    1: (bf) r1 =3D (s16)r10
>    2: (07) r1 +=3D -8
>    3: (b7) r2 =3D 3
>    4: (bd) if r2 <=3D r1 goto pc+0
>    5: (85) call bpf_trace_printk#-138320
>    6: (b7) r0 =3D 0
>    7: (95) exit
>=20
> At insn 1, the current implementation keeps 'r1' as a frame pointer,
> which caused later bpf_trace_printk helper call crash since frame
> pointer address is not valid any more. Note that at insn 4,
> the 'pointer vs. scalar' comparison is allowed for privileged
> prog run.
>=20
> To fix the problem with above insn 1, the fix in the patch adopts
> similar pattern to existing 'R1 =3D (u32) R2' handling. For unprivileged
> prog run, verification will fail with 'R<num> sign-extension part of poin=
ter'.
> For privileged prog run, the dst_reg 'r1' will be marked as
> an unknown scalar, so later 'bpf_trace_pointk' helper will complain
> since it expected certain pointers.
>=20
> Reported-by: syzbot+d61b595e9205573133b3@syzkaller.appspotmail.com
> Fixes: 8100928c8814 ("bpf: Support new sign-extension mov insns")
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

All works on my side.
Nitpick: the test case could be simplified.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

> ---
>  kernel/bpf/verifier.c | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 132f25dab931..4ccca1f6c998 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -13165,17 +13165,26 @@ static int check_alu_op(struct bpf_verifier_env=
 *env, struct bpf_insn *insn)
>  					dst_reg->subreg_def =3D DEF_NOT_SUBREG;
>  				} else {
>  					/* case: R1 =3D (s8, s16 s32)R2 */
> -					bool no_sext;
> -
> -					no_sext =3D src_reg->umax_value < (1ULL << (insn->off - 1));
> -					if (no_sext && need_id)
> -						src_reg->id =3D ++env->id_gen;
> -					copy_register_state(dst_reg, src_reg);
> -					if (!no_sext)
> -						dst_reg->id =3D 0;
> -					coerce_reg_to_size_sx(dst_reg, insn->off >> 3);
> -					dst_reg->live |=3D REG_LIVE_WRITTEN;
> -					dst_reg->subreg_def =3D DEF_NOT_SUBREG;
> +					if (is_pointer_value(env, insn->src_reg)) {
> +						verbose(env,
> +							"R%d sign-extension part of pointer\n",
> +							insn->src_reg);
> +						return -EACCES;
> +					} else if (src_reg->type =3D=3D SCALAR_VALUE) {
> +						bool no_sext;
> +
> +						no_sext =3D src_reg->umax_value < (1ULL << (insn->off - 1));
> +						if (no_sext && need_id)
> +							src_reg->id =3D ++env->id_gen;
> +						copy_register_state(dst_reg, src_reg);
> +						if (!no_sext)
> +							dst_reg->id =3D 0;
> +						coerce_reg_to_size_sx(dst_reg, insn->off >> 3);
> +						dst_reg->live |=3D REG_LIVE_WRITTEN;
> +						dst_reg->subreg_def =3D DEF_NOT_SUBREG;
> +					} else {
> +						mark_reg_unknown(env, regs, insn->dst_reg);
> +					}
>  				}
>  			} else {
>  				/* R1 =3D (u32) R2 */


