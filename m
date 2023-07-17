Return-Path: <bpf+bounces-5076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D38E75591C
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 03:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EDA21C2095F
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 01:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFA5111F;
	Mon, 17 Jul 2023 01:42:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7554A49
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 01:42:08 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01C3DD
	for <bpf@vger.kernel.org>; Sun, 16 Jul 2023 18:42:06 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbc5d5746cso40740555e9.2
        for <bpf@vger.kernel.org>; Sun, 16 Jul 2023 18:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689558125; x=1692150125;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E27woSRv7CvLDQSTqXQBPjAm5Jv4YMnlqK9UjvyYd3s=;
        b=NAmKYEUPBd2ES0DzMY+XagTriluknTKX8w+Bs0KSeKJ8wdf2B9FBJrq3nLNfeJZXyQ
         o3VPgwePODOIxMafgo0gSNTwrz7tm/wn1MpmCmQzC/ZqfM3r78v4nyLldLHCnyWjp0yd
         sp8g93exlvABy7noxsx14EIWw6CfqoJ7vaOd9WqSx7o/wQgUiYW+dNWsPJ5gRMDRh641
         h7UlM3u0JxwLxnP7U8GARClry8VuiAmd2WHEx3nsjNFxYO+whgrq8MY+09pnYnQ6OfKT
         Kz8gmTOcMDVU2anZxab4doRBIu8ulnNImL7UN8+yyQRw/+iRUD36yQK/V2CZKLtBnfiB
         iyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689558125; x=1692150125;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E27woSRv7CvLDQSTqXQBPjAm5Jv4YMnlqK9UjvyYd3s=;
        b=h9ZY4A9vvU/1a+eNftpDDEYrzK4D5rdjipGfoCZbELnBd5lh9nd7kcjjs+TRkL5ke9
         GYmxCUEWFPwYNCry6Or7rOzkwltaNEgvR7mDdHMQPHiNQJHg7BqZwPqCWzwiq4zO7xqi
         Vwtd0O4IHtcVZNPwXw9WZrWx45SXc0ott7mcUDn6mwiU+ujHgL+akl4+YTgF7mhrT7PX
         BsTSN6fkzxmTKkFS71Ecepl+cP3WamuHw+AUu2aTFHKq1WbG2Oc3NcM053wJwjdbumEg
         Gq0bLe+vgSTm0fmt2oBsnY1Jt1gZgSV3Gp+TcJzeR2XPFINqfQlQtVNhOyRqodEwIG9G
         VAbg==
X-Gm-Message-State: ABy/qLb/t1uPMd7ZIrHp3TFA/I8Hb/hDm7FBTyjvTjq3lamOVd8xdDDZ
	FFHLTyUXWJ6drl9psm098Rk=
X-Google-Smtp-Source: APBJJlGPUjrCZpdRURM+DeSTquPjhALiwsgzX+hXBd8pUrOY3Zbk49xNJF6fvygWdx61zL7we4YaOQ==
X-Received: by 2002:a7b:cd0a:0:b0:3fb:b5c0:a079 with SMTP id f10-20020a7bcd0a000000b003fbb5c0a079mr9210255wmj.21.1689558125179;
        Sun, 16 Jul 2023 18:42:05 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id y13-20020a05600c364d00b003f819faff24sm6633407wmq.40.2023.07.16.18.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 18:42:04 -0700 (PDT)
Message-ID: <cb9ba725b54fb02a5a552d46043a8e90c6f7b85a.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 04/15] bpf: Support new unconditional bswap
 instruction
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Fangrui Song
 <maskray@google.com>, kernel-team@fb.com
Date: Mon, 17 Jul 2023 04:42:03 +0300
In-Reply-To: <20230713060739.390659-1-yhs@fb.com>
References: <20230713060718.388258-1-yhs@fb.com>
	 <20230713060739.390659-1-yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 2023-07-12 at 23:07 -0700, Yonghong Song wrote:
> > The existing 'be' and 'le' insns will do conditional bswap
> > depends on host endianness. This patch implements
> > unconditional bswap insns.
> >=20
> > Signed-off-by: Yonghong Song <yhs@fb.com>

Note sure if this is important, but here is an observation:
function is_reg64() has the following code:

 ...
 if (class =3D=3D BPF_ALU64 || class =3D=3D BPF_JMP ||
 /* BPF_END always use BPF_ALU class. */
 (class =3D=3D BPF_ALU && op =3D=3D BPF_END && insn->imm =3D=3D 64))
 return true;
 ...

It probably has to be updated but I'm not sure how:
- either check insn->imm =3D=3D 64 for ALU64 as well;
- or just update the comment, given that instruction always sets all 64-bit=
s.

> > ---
> >  arch/x86/net/bpf_jit_comp.c |  1 +
> >  kernel/bpf/core.c           | 14 ++++++++++++++
> >  kernel/bpf/verifier.c       |  2 +-
> >  3 files changed, 16 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index a740a1a6e71d..adda5e7626b4 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -1322,6 +1322,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int =
*addrs, u8 *image, u8 *rw_image
> >  			break;
> > =20
> >  		case BPF_ALU | BPF_END | BPF_FROM_BE:
> > +		case BPF_ALU64 | BPF_END | BPF_FROM_LE:
> >  			switch (imm32) {
> >  			case 16:
> >  				/* Emit 'ror %ax, 8' to swap lower 2 bytes */
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index fe648a158c9e..86bb412fee39 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -1524,6 +1524,7 @@ EXPORT_SYMBOL_GPL(__bpf_call_base);
> >  	INSN_3(ALU64, DIV,  X),			\
> >  	INSN_3(ALU64, MOD,  X),			\
> >  	INSN_2(ALU64, NEG),			\
> > +	INSN_3(ALU64, END, TO_LE),		\
> >  	/*   Immediate based. */		\
> >  	INSN_3(ALU64, ADD,  K),			\
> >  	INSN_3(ALU64, SUB,  K),			\
> > @@ -1845,6 +1846,19 @@ static u64 ___bpf_prog_run(u64 *regs, const stru=
ct bpf_insn *insn)
> >  			break;
> >  		}
> >  		CONT;
> > +	ALU64_END_TO_LE:
> > +		switch (IMM) {
> > +		case 16:
> > +			DST =3D (__force u16) __swab16(DST);
> > +			break;
> > +		case 32:
> > +			DST =3D (__force u32) __swab32(DST);
> > +			break;
> > +		case 64:
> > +			DST =3D (__force u64) __swab64(DST);
> > +			break;
> > +		}
> > +		CONT;
> > =20
> >  	/* CALL */
> >  	JMP_CALL:
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 5fee9f24cb5e..22ba0744547b 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -13036,7 +13036,7 @@ static int check_alu_op(struct bpf_verifier_env=
 *env, struct bpf_insn *insn)
> >  		} else {
> >  			if (insn->src_reg !=3D BPF_REG_0 || insn->off !=3D 0 ||
> >  			    (insn->imm !=3D 16 && insn->imm !=3D 32 && insn->imm !=3D 64) |=
|
> > -			    BPF_CLASS(insn->code) =3D=3D BPF_ALU64) {
> > +			    (BPF_CLASS(insn->code) =3D=3D BPF_ALU64 && BPF_SRC(insn->code) =
!=3D BPF_K)) {
> >  				verbose(env, "BPF_END uses reserved fields\n");
> >  				return -EINVAL;
> >  			}


