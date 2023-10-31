Return-Path: <bpf+bounces-13716-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6534C7DD0AE
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 16:38:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9023D1C20CEA
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 15:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9720E1E539;
	Tue, 31 Oct 2023 15:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TedCTK71"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105941E530
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 15:38:33 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBC4F3
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 08:38:32 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso895923166b.1
        for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 08:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698766711; x=1699371511; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QRNrVgSkmHgqR3jX8UWA1tVvX2jLHxesN6/X2617iWM=;
        b=TedCTK719SEPlqC6bP7FXakDPFBPXy4Ybw05uKDtkvV1X2KahqlNqWcIfZ4uc4mVU6
         rggXJ1hcpjdzE4Rl1qB968eZCd3mNYywE+aAA35eFOKdJ+5BBEhK3Hxfw8hjdu+HFzYi
         NA7wtU57OdrEVYdvEeiCBmtLcFAz4WSljZQYXf3LlANNVqx9VZVV0itstPIjujyKepbu
         Zmr+I2oW/Fm7X3QwLFmqb5cx9+HGiBybxXOtQmOJNray1sfh5DsD7oRX8r7pj7P9m074
         vih6YQYhHX01WWSwJPk5WGyW9w/sOYD5snBtaNaHsAHqkJarhUBszOxbv/o43WpxXeMP
         1HrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698766711; x=1699371511;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QRNrVgSkmHgqR3jX8UWA1tVvX2jLHxesN6/X2617iWM=;
        b=SybD8dBdKFMyH2rPgoIB6tkARI4HwM91UCJ/Eca8OfOeQkrhRkYqvAtMEXaqiMZARc
         gbC+Au8+eo42VXeOnMucpFMhYFoOLAEjASEs48rwVsOFDbbpmOkcdH7cKiFTgp5hVgoq
         zEXgoZZcPh4lPWb5xBgmzFI/Ij4inVQAhuLWg0ZT9G1laAFKadhkhVr5HN3GNV+VuWyc
         mxVQzMJnXaJwXWn5HE8RIDO7FrPirPDpH+t1NZqut2jZF8Kn2cii24dW/zKDLsBHeWtd
         mAUNBzvuUMnOpd01voDjX7bOjcFSxjCReos1NhINW+LPrKQFAR+CWG5lseYJM7ETr+Ox
         xYLw==
X-Gm-Message-State: AOJu0YzI7kGHKjOMEyZsLMmShTKS5croCtObeCNrTRNvgFQs4oitD9VY
	My9RQIu3wj1P4T9iqTCzlMg=
X-Google-Smtp-Source: AGHT+IGQFrzFmJuqe9r4vGuUl1B734nDripargPlc7LWFB1El81ISqeKdnGTDSFMfWRcoN2iBNofCQ==
X-Received: by 2002:a17:907:318a:b0:9be:21dc:8a9a with SMTP id xe10-20020a170907318a00b009be21dc8a9amr10634396ejb.39.1698766710941;
        Tue, 31 Oct 2023 08:38:30 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id ov8-20020a170906fc0800b009b947f81c4asm1149630ejb.155.2023.10.31.08.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 08:38:30 -0700 (PDT)
Message-ID: <8a9da941cc2aefba27da706e4e9b2d11aedfc86f.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 14/23] bpf: generalize is_branch_taken to
 handle all conditional jumps in one place
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org,  daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com
Date: Tue, 31 Oct 2023 17:38:29 +0200
In-Reply-To: <20231027181346.4019398-15-andrii@kernel.org>
References: <20231027181346.4019398-1-andrii@kernel.org>
	 <20231027181346.4019398-15-andrii@kernel.org>
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

On Fri, 2023-10-27 at 11:13 -0700, Andrii Nakryiko wrote:
> > Make is_branch_taken() a single entry point for branch pruning decision
> > making, handling both pointer vs pointer, pointer vs scalar, and scalar
> > vs scalar cases in one place. This also nicely cleans up check_cond_jmp=
_op().
> >=20
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

> > ---
> >  kernel/bpf/verifier.c | 49 ++++++++++++++++++++++---------------------
> >  1 file changed, 25 insertions(+), 24 deletions(-)
> >=20
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 25b5234ebda3..fedd6d0e76e5 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -14169,6 +14169,19 @@ static void find_good_pkt_pointers(struct bpf_=
verifier_state *vstate,
> >  	}));
> >  }
> > =20
> > +/* check if register is a constant scalar value */
> > +static bool is_reg_const(struct bpf_reg_state *reg, bool subreg32)
> > +{
> > +	return reg->type =3D=3D SCALAR_VALUE &&
> > +	       tnum_is_const(subreg32 ? tnum_subreg(reg->var_off) : reg->var_=
off);
> > +}
> > +
> > +/* assuming is_reg_const() is true, return constant value of a registe=
r */
> > +static u64 reg_const_value(struct bpf_reg_state *reg, bool subreg32)
> > +{
> > +	return subreg32 ? tnum_subreg(reg->var_off).value : reg->var_off.valu=
e;
> > +}
> > +
> >  /*
> >   * <reg1> <op> <reg2>, currently assuming reg2 is a constant
> >   */
> > @@ -14410,12 +14423,20 @@ static int is_pkt_ptr_branch_taken(struct bpf=
_reg_state *dst_reg,
> >  static int is_branch_taken(struct bpf_reg_state *reg1, struct bpf_reg_=
state *reg2,
> >  			   u8 opcode, bool is_jmp32)
> >  {
> > -	struct tnum reg2_tnum =3D is_jmp32 ? tnum_subreg(reg2->var_off) : reg=
2->var_off;
> >  	u64 val;
> > =20
> > -	if (!tnum_is_const(reg2_tnum))
> > +	if (reg_is_pkt_pointer_any(reg1) && reg_is_pkt_pointer_any(reg2) && !=
is_jmp32)
> > +		return is_pkt_ptr_branch_taken(reg1, reg2, opcode);
> > +
> > +	/* try to make sure reg2 is a constant SCALAR_VALUE */
> > +	if (!is_reg_const(reg2, is_jmp32)) {
> > +		opcode =3D flip_opcode(opcode);
> > +		swap(reg1, reg2);
> > +	}
> > +	/* for now we expect reg2 to be a constant to make any useful decisio=
ns */
> > +	if (!is_reg_const(reg2, is_jmp32))
> >  		return -1;
> > -	val =3D reg2_tnum.value;
> > +	val =3D reg_const_value(reg2, is_jmp32);
> > =20
> >  	if (__is_pointer_value(false, reg1)) {
> >  		if (!reg_not_null(reg1))
> > @@ -14896,27 +14917,7 @@ static int check_cond_jmp_op(struct bpf_verifi=
er_env *env,
> >  	}
> > =20
> >  	is_jmp32 =3D BPF_CLASS(insn->code) =3D=3D BPF_JMP32;
> > -
> > -	if (BPF_SRC(insn->code) =3D=3D BPF_K) {
> > -		pred =3D is_branch_taken(dst_reg, src_reg, opcode, is_jmp32);
> > -	} else if (src_reg->type =3D=3D SCALAR_VALUE &&
> > -		   is_jmp32 && tnum_is_const(tnum_subreg(src_reg->var_off))) {
> > -		pred =3D is_branch_taken(dst_reg, src_reg, opcode, is_jmp32);
> > -	} else if (src_reg->type =3D=3D SCALAR_VALUE &&
> > -		   !is_jmp32 && tnum_is_const(src_reg->var_off)) {
> > -		pred =3D is_branch_taken(dst_reg, src_reg, opcode, is_jmp32);
> > -	} else if (dst_reg->type =3D=3D SCALAR_VALUE &&
> > -		   is_jmp32 && tnum_is_const(tnum_subreg(dst_reg->var_off))) {
> > -		pred =3D is_branch_taken(src_reg, dst_reg, flip_opcode(opcode), is_j=
mp32);
> > -	} else if (dst_reg->type =3D=3D SCALAR_VALUE &&
> > -		   !is_jmp32 && tnum_is_const(dst_reg->var_off)) {
> > -		pred =3D is_branch_taken(src_reg, dst_reg, flip_opcode(opcode), is_j=
mp32);
> > -	} else if (reg_is_pkt_pointer_any(dst_reg) &&
> > -		   reg_is_pkt_pointer_any(src_reg) &&
> > -		   !is_jmp32) {
> > -		pred =3D is_pkt_ptr_branch_taken(dst_reg, src_reg, opcode);
> > -	}
> > -
> > +	pred =3D is_branch_taken(dst_reg, src_reg, opcode, is_jmp32);
> >  	if (pred >=3D 0) {
> >  		/* If we get here with a dst_reg pointer type it is because
> >  		 * above is_branch_taken() special cased the 0 comparison.


