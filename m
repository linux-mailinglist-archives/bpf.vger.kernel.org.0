Return-Path: <bpf+bounces-48038-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69290A0347B
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 02:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D82BA3A3703
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 01:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24DA83BBC9;
	Tue,  7 Jan 2025 01:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j20+CCCm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2038E2594AB;
	Tue,  7 Jan 2025 01:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736212864; cv=none; b=iJ5pXitre293iBWY8G2mBSo9cVVrvXKgGJ9qGzL+agYGlaD3eQvbOEWBucSeAFTk1MSlJ9Rok/lAqvMigJOMHFJXXAfEfnEniVgJg00kSLcmt4Y7ms4dQLdeb//Lu1y0tYy32J6R9b9K5RZ7612JvZOrTFNfEHpvLaoUo8k4mLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736212864; c=relaxed/simple;
	bh=HgQeOReE01qRVQwdQ9lOIiOaEFsysjFi3Cktgm0uAYM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oeIVkpvKoegse/5xkq2EZTf3Nq0OnnFqAkvMTxjOPXjupQYdyVwwwT/NuhPD6HnlwMuc3eGn7GmHaZ4VWQ0A8D/OKITkxAw1OGMtX7D7DSqtKgmaBef+uo2wpTcFNVneqm1FojsTKuGblc+rxCzZYBUqYTIhKho3t+QFBQxMGwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j20+CCCm; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ef70c7efa5so17469982a91.2;
        Mon, 06 Jan 2025 17:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736212862; x=1736817662; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vcbDvrTMF39k4jngwz3O5zMYA8cGG8FpjBS1pAWzs6A=;
        b=j20+CCCm7hZi+7NDOtX9kfAJb51HULBm5hVqIpZT/TXMNYOz9ZnVg+yQlIYCGB7lsp
         0Q3oKr7lJWdJdcYKDTLs/46iThUFalSJrTv9OZjVV9tOKdMPoPTRvQMAnqFTLkv7/cZU
         C40FXCfSSykB8Y7iPwQCPVVJBsmsXLZetO8yXTOcapXP9m7ot/PeWcmcy+YMIoSNgCLY
         JSaazaTq2jbBXGVqXPz1nB+B10uQA46QkJdb9sY6HAwgMtI9HmjQsH45KcNrML+k/Vpx
         9a2zOKR0nZeL0LbNNmmQU9y2om6x6sMk58282Cq1S1+5EXmHHeLVLsx0F1HhlXie5jx4
         5rUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736212862; x=1736817662;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vcbDvrTMF39k4jngwz3O5zMYA8cGG8FpjBS1pAWzs6A=;
        b=fSf6UdtISLFHahvzK4STNdvmvy99i5iPyWwEelgZVZ/QLlzrHmBmH3p0BsnUMyjTpF
         1c4wWprQzWC1ysuhcZsGf8mZCBs5BVTA25v1XJNE+reMp7gVGViOahKi3mhjl8kl6PcV
         /AyuuCFyE5bXCzXakVdnaLb5ZlSQj6TA9L2OVRMQ/DUISvrzP+ctf7Rd2BuYeCg5P6NG
         6L+B0ek/iX0RaIlcM1y3uvwJx43k5yyKxzKtgvX9poROB34Yptlj9pkjUKKn6nfDinmg
         3MA3zXg+bd+o2JyMjyILetCREaU91ix13XNAZOAgND++r/dx0pAwo5n+bsjZ8h/XB/fa
         jvsw==
X-Forwarded-Encrypted: i=1; AJvYcCWLOf7m4PQcVLB/3TBU2tVEx5vrxUCIYuj3QW7Ocd6vZAAXv1UVAj4J3rtqvNmOeooPY6tPxW+TBzVIy3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR7x8nLxu4MD8V+Vyg/noBqscEJ5BFu6d6n8WDqnEOuycL3IrW
	jMNWAx5Drfk4YgSUmBRjTmezlvsjWb0tZv/07mNrw11XXTB6rm7/
X-Gm-Gg: ASbGncsYKcm45FKYP8NiHbHwKVdf6t80SDyRfNh9eBnDaR3+W+VjwQGasv2SNHbTQ24
	GCiHO/U1R1OrkH8RajKQVsDs1r2x3sYWSXU3vmwYMWM2Aw7o0R4u0sfmn0HLonTdGKJhTuVlSTm
	BKmnBlKOn2JNL7bHbNmoOSFcbqePi9B5mT069sC8h0VUoiM2z/4VO5qdPpuwnngBC57oLNGq4KE
	Rhel5z7dQ7JAEL1AG8Jly4w0X0N5DED5TP45ERCshhQCkTvPVXaLA==
X-Google-Smtp-Source: AGHT+IHyIXbfA2Hr8y07bvoldXNSS0oxmoN+jjI445+F8fGxxs362g8Hmg2/65jphDCT+GYXlBGucg==
X-Received: by 2002:a17:90b:2d43:b0:2ee:cd83:8fc3 with SMTP id 98e67ed59e1d1-2f452eed6f1mr91716737a91.37.1736212862279;
        Mon, 06 Jan 2025 17:21:02 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca02e91sm299209685ad.274.2025.01.06.17.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 17:21:01 -0800 (PST)
Message-ID: <e294e3c318e2c7a646e4b2e43516378a0689ea3b.camel@gmail.com>
Subject: Re: [PATCH RFC bpf-next v1 2/4] bpf: Introduce load-acquire and
 store-release instructions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Peilin Ye <yepeilin@google.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Song Liu	
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann
	 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau	 <martin.lau@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh	 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo	
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, "Paul E. McKenney"	
 <paulmck@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai	
 <xukuohai@huaweicloud.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Quentin Monnet <qmo@kernel.org>, Mykola Lysenko
 <mykolal@fb.com>,  Shuah Khan <shuah@kernel.org>, Josh Don
 <joshdon@google.com>, Barret Rhoden <brho@google.com>, Neel Natu	
 <neelnatu@google.com>, Benjamin Segall <bsegall@google.com>, David Vernet	
 <dvernet@meta.com>, Dave Marchevsky <davemarchevsky@meta.com>, 
	linux-kernel@vger.kernel.org
Date: Mon, 06 Jan 2025 17:20:56 -0800
In-Reply-To: <Z3x-qSHxWTw5je1O@google.com>
References: <cover.1734742802.git.yepeilin@google.com>
	 <6ca65dc2916dba7490c4fd7a8b727b662138d606.1734742802.git.yepeilin@google.com>
	 <9941341e8bd78f3563e0027a59cac8966f1e3666.camel@gmail.com>
	 <Z3x-qSHxWTw5je1O@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-01-07 at 01:08 +0000, Peilin Ye wrote:

Hi Peilin,

[...]

> > > --- a/kernel/bpf/disasm.c
> > > +++ b/kernel/bpf/disasm.c
> > > @@ -267,6 +267,20 @@ void print_bpf_insn(const struct bpf_insn_cbs *c=
bs,
> > >  				BPF_SIZE(insn->code) =3D=3D BPF_DW ? "64" : "",
> > >  				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
> > >  				insn->dst_reg, insn->off, insn->src_reg);
> > > +		} else if (BPF_MODE(insn->code) =3D=3D BPF_ATOMIC &&
> > > +			   insn->imm =3D=3D BPF_LOAD_ACQ) {
> > > +			verbose(cbs->private_data, "(%02x) %s%d =3D load_acquire((%s *)(r=
%d %+d))\n",
> > > +				insn->code,
> > > +				BPF_SIZE(insn->code) =3D=3D BPF_DW ? "r" : "w", insn->dst_reg,
> >=20
> > Nit: I think that 'BPF_DW ? "r" : "w"' part is not really necessary.
>=20
> We already do that in other places in the file, so I wanted to keep it
> consistent:
>=20
>   $ git grep "? 'w' : 'r'" kernel/bpf/disasm.c | wc -l
>   8
>=20
> (Though I just realized that I could've used '%c' instead of '%s'.)

These are used for operations that can have either BPF_ALU or
BPF_ALU32 class. I don't think there is such distinction for
BPF_LOAD_ACQ / BPF_STORE_REL.

> > >  static int check_atomic(struct bpf_verifier_env *env, int insn_idx, =
struct bpf_insn *insn)
> > >  {
> > > +	const int bpf_size =3D BPF_SIZE(insn->code);
> > > +	bool write_only =3D false;
> > >  	int load_reg;
> > >  	int err;
> > > =20
> > > @@ -7564,17 +7566,21 @@ static int check_atomic(struct bpf_verifier_e=
nv *env, int insn_idx, struct bpf_i
> > >  	case BPF_XOR | BPF_FETCH:
> > >  	case BPF_XCHG:
> > >  	case BPF_CMPXCHG:
> > > +		if (bpf_size !=3D BPF_W && bpf_size !=3D BPF_DW) {
> > > +			verbose(env, "invalid atomic operand size\n");
> > > +			return -EINVAL;
> > > +		}
> > > +		break;
> > > +	case BPF_LOAD_ACQ:
> >=20
> > Several notes here:
> > - This skips the 'bpf_jit_supports_insn()' call at the end of the funct=
ion.
> > - Also 'check_load()' allows source register to be PTR_TO_CTX,
> >   but convert_ctx_access() is not adjusted to handle these atomic instr=
uctions.
> >   (Just in case: context access is special, context structures are not =
"real",
> >    e.g. during runtime real sk_buff is passed to the program, not __sk_=
buff,
> >    in convert_ctx_access() verifier adjusts offsets of load and store i=
nstructions
> >    to point to real fields, this is done per program type, e.g. see
> >    filter.c:bpf_convert_ctx_access);
>=20
> I see, thanks for pointing these out!  I'll add logic to handle
> BPF_LOAD_ACQ in check_atomic() directly, instead of introducing
> check_load().  I'll disallow using BPF_LOAD_ACQ with src_reg being
> PTR_TO_CTX (just like all existing BPF_ATOMIC instructions), as we don't
> think there'll be a use case for it.
=20
(Just in case: the full list of types currently disallowed for atomics is:
 is_ctx_reg, is_pkt_reg, is_flow_key_reg, is_sk_reg, is_arena_reg,
 see slightly below in the same function).

[...]

> > And there is no need for 'check_reg_arg(env, insn->dst_reg, SRC_OP)'
> > for BPF_STORE_REL.
>=20
> Why is that?  IIUC, 'check_reg_arg(..., SRC_OP)' checks if we can read
> the register, instead of the memory?  For example, doing
> 'check_reg_arg(env, insn->dst_reg, SRC_OP)' prevents BPF_STORE_REL from
> using an uninitialized dst_reg.
>=20
> We also do this check for BPF_ST in do_check():
>=20
>   } else if (class =3D=3D BPF_ST) {
>           enum bpf_reg_type dst_reg_type;
> <...>
>           /* check src operand */
>           err =3D check_reg_arg(env, insn->dst_reg, SRC_OP);
>           if (err)
>                   return err;

Sorry, my bad, the 'check_reg_arg(env, insn->dst_reg, SRC_OP)'
is necessary and is done for BPF_STX as well.

Thanks,
Eduard


