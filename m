Return-Path: <bpf+bounces-47858-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 663FBA01143
	for <lists+bpf@lfdr.de>; Sat,  4 Jan 2025 01:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE6737A214C
	for <lists+bpf@lfdr.de>; Sat,  4 Jan 2025 00:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEECB9463;
	Sat,  4 Jan 2025 00:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MeGmgKvi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FFE3D66;
	Sat,  4 Jan 2025 00:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735949536; cv=none; b=hWjIol84HjMK9lvw7IvHPZtjD26Rou6rjdzTLT9GCvlAaIJjCECk2R7XljpbXKqVV5yTjH8PKJ9OxPBY9g4FjBMgYhilR53wy57nEyVSoxmWJB4AjSUlugLHo53MsMCTKRHQ5uZ8925IY9pQwv3qCWBO7qAFuIsRnVySj/L/hqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735949536; c=relaxed/simple;
	bh=/4GPoPGBe3C63ULLtDdVILhR4O9/rYOT28h8cLKGnIg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dIXcPa06OpzSP+kmpqRe/F+OqoZwhiCqGBzrb9ttXswXl8qJv0+FydN75xZYlPjZChHsilTNFf0fqvB6wEhjLTgDab3lrsAU+QE5CRGf3CrwjDJoKJnFnNvrrQKlzZhImkzzcPcl6PJIZjJJu8CTKRst8SRusxtppU+86XUAlX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MeGmgKvi; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21670dce0a7so103446545ad.1;
        Fri, 03 Jan 2025 16:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735949534; x=1736554334; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9ZnzrytGFkbH9taPpO/MztxTRjvQuwWt2CCNEC5Tvi4=;
        b=MeGmgKviYDrEUaWP1k7be/hBmwKH0RRM1A7vPZDPGF8gUCd1E9gk1PCNFyjTGOTqOz
         aKcx9GGecVsv56lnEme6N39IZTArdtA8W21JhO/Me1P99DjCwMXbvZIx8fkv5snoT7UZ
         vURs0ZUltJM7FV0BnBKRXIuDX0xX/QC6nfUxImEi4Kt0N8j31rI+q3Xoq/XMihpcmsEO
         NoZ6Bhc/7bEp4FE3PnWeYQF5o34Wt79zR1YUcKZjDIYKqcuSZG7wCWCNreWOVQ5WmZPx
         lLAC/bQFid53ij4dthS2YohClxfCsu303QmyYE/0c4IX9Bzv+iq+fvbt5mMMKHMH/DIT
         FatQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735949534; x=1736554334;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9ZnzrytGFkbH9taPpO/MztxTRjvQuwWt2CCNEC5Tvi4=;
        b=kljMkV3KypwdTAz2HVpHezyi9eUPeuKYBqmNDgAliOo/TuLtTL9CMPxNoEbWPSlYgJ
         wTbFidw5k7NC5KJmZ0rPZKbREmQhhr7f4imQCGMTuiG438xU86dSUIkcDSzGoIxyWTUF
         RgOGDy+AtH8i4npV9zqgWGC/VcHQRg2zAQmIQOZRcKEF3FF3ueewPL3gmiNhwp/lDy2Y
         a1OXKzuJlApk5kaLf4/4DvZS4FuwWPDxZvcuUZiq6grcT80fzzrCoBP8YbPD6wxJUyWr
         fdIhkTBuZJ3tS2ak1ulpkUpi6GGkNqbKtWekGqjiP/dq7te9hNH6dpnMiJEdz0alni83
         cbhg==
X-Forwarded-Encrypted: i=1; AJvYcCV+7Eia0Smrim9jfoPbFCH76VDW8LVQEeXNwTM2qPhOvEicXAGnyGDPtKeW9nS7kuA3OmM=@vger.kernel.org, AJvYcCXffyxBd0HQDlQ5JAtR+Mm8RHnml3i03/K/YJX41bYOA/5UQnuouTLJPnHAilgGrBTN4cbC1a1xFfIvHyq3@vger.kernel.org
X-Gm-Message-State: AOJu0YwVm7vhg7Aup6i6H44qs6FMVF6HUSTFZDQesNsPA/puVOuCo/QB
	bR4ifRFWgtB1g/3J7v5kCPNSF7x14uDS+UNxuLyD1SZoDg/Qrh1wtfLl8qKz
X-Gm-Gg: ASbGncuYgnep94+Ww8w6YSrOlILFst7SOLbtpptyxoSrP7/LJioSw1P4lT+JsyhzYdD
	mJRAJ2XIvgpAUIBnkZ/AcsGQtNi5vDWVtC7VUMI5TO7YyLkb2c8kuFMDDj1YCz5RB7QCIeAqzkD
	33Bs+Bc9NR3qS5WJDk0PuQx2TAsYQ/0zW11YdtbDTA6ZO8nB+/lf8++LkBOFvY0urKWSVDTErBm
	LRGH9k0B91G/5RLZiN42/ft0wnQvGV63FeYVUfsOS5CIrptkXZiKg==
X-Google-Smtp-Source: AGHT+IHeSojTlezqhf/MonjUFn7EXvRnrOoFvkxYLhaR4ipXqIY8pMPxOXegannBBVCxiapXmvnIfw==
X-Received: by 2002:a05:6a20:9c8d:b0:1e1:f281:8cec with SMTP id adf61e73a8af0-1e5e0481434mr76374713637.10.1735949534102;
        Fri, 03 Jan 2025 16:12:14 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-900ea610beesm9982899a12.2.2025.01.03.16.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 16:12:13 -0800 (PST)
Message-ID: <9941341e8bd78f3563e0027a59cac8966f1e3666.camel@gmail.com>
Subject: Re: [PATCH RFC bpf-next v1 2/4] bpf: Introduce load-acquire and
 store-release instructions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Peilin Ye <yepeilin@google.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko	 <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, John Fastabend	 <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev	 <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  "Paul E. McKenney"	
 <paulmck@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai	
 <xukuohai@huaweicloud.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Quentin Monnet <qmo@kernel.org>, Mykola Lysenko
 <mykolal@fb.com>,  Shuah Khan <shuah@kernel.org>, Josh Don
 <joshdon@google.com>, Barret Rhoden <brho@google.com>, Neel Natu	
 <neelnatu@google.com>, Benjamin Segall <bsegall@google.com>, David Vernet	
 <dvernet@meta.com>, Dave Marchevsky <davemarchevsky@meta.com>, 
	linux-kernel@vger.kernel.org
Date: Fri, 03 Jan 2025 16:12:08 -0800
In-Reply-To: <6ca65dc2916dba7490c4fd7a8b727b662138d606.1734742802.git.yepeilin@google.com>
References: <cover.1734742802.git.yepeilin@google.com>
	 <6ca65dc2916dba7490c4fd7a8b727b662138d606.1734742802.git.yepeilin@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-12-21 at 01:25 +0000, Peilin Ye wrote:
> Introduce BPF instructions with load-acquire and store-release
> semantics, as discussed in [1].  The following new flags are defined:

The '[1]' link is missing.

>   BPF_ATOMIC_LOAD         0x10
>   BPF_ATOMIC_STORE        0x20
>   BPF_ATOMIC_TYPE(imm)    ((imm) & 0xf0)
>=20
>   BPF_RELAXED        0x0
>   BPF_ACQUIRE        0x1
>   BPF_RELEASE        0x2
>   BPF_ACQ_REL        0x3
>   BPF_SEQ_CST        0x4
>=20
>   BPF_LOAD_ACQ       (BPF_ATOMIC_LOAD | BPF_ACQUIRE)
>   BPF_STORE_REL      (BPF_ATOMIC_STORE | BPF_RELEASE)
>=20
> A "load-acquire" is a BPF_STX | BPF_ATOMIC instruction with the 'imm'
> field set to BPF_LOAD_ACQ (0x11).
>=20
> Similarly, a "store-release" is a BPF_STX | BPF_ATOMIC instruction with
> the 'imm' field set to BPF_STORE_REL (0x22).

[...]

> diff --git a/kernel/bpf/disasm.c b/kernel/bpf/disasm.c
> index 309c4aa1b026..2a354a44f209 100644
> --- a/kernel/bpf/disasm.c
> +++ b/kernel/bpf/disasm.c
> @@ -267,6 +267,20 @@ void print_bpf_insn(const struct bpf_insn_cbs *cbs,
>  				BPF_SIZE(insn->code) =3D=3D BPF_DW ? "64" : "",
>  				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
>  				insn->dst_reg, insn->off, insn->src_reg);
> +		} else if (BPF_MODE(insn->code) =3D=3D BPF_ATOMIC &&
> +			   insn->imm =3D=3D BPF_LOAD_ACQ) {
> +			verbose(cbs->private_data, "(%02x) %s%d =3D load_acquire((%s *)(r%d %=
+d))\n",
> +				insn->code,
> +				BPF_SIZE(insn->code) =3D=3D BPF_DW ? "r" : "w", insn->dst_reg,

Nit: I think that 'BPF_DW ? "r" : "w"' part is not really necessary.

> +				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
> +				insn->src_reg, insn->off);
> +		} else if (BPF_MODE(insn->code) =3D=3D BPF_ATOMIC &&
> +			   insn->imm =3D=3D BPF_STORE_REL) {
> +			verbose(cbs->private_data, "(%02x) store_release((%s *)(r%d %+d), %s%=
d)\n",
> +				insn->code,
> +				bpf_ldst_string[BPF_SIZE(insn->code) >> 3],
> +				insn->dst_reg, insn->off,
> +				BPF_SIZE(insn->code) =3D=3D BPF_DW ? "r" : "w", insn->src_reg);
>  		} else {
>  			verbose(cbs->private_data, "BUG_%02x\n", insn->code);
>  		}
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index fa40a0440590..dc3ecc925b97 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3480,7 +3480,7 @@ static bool is_reg64(struct bpf_verifier_env *env, =
struct bpf_insn *insn,
>  	}
> =20
>  	if (class =3D=3D BPF_STX) {
> -		/* BPF_STX (including atomic variants) has multiple source
> +		/* BPF_STX (including atomic variants) has one or more source
>  		 * operands, one of which is a ptr. Check whether the caller is
>  		 * asking about it.
>  		 */
> @@ -7550,6 +7550,8 @@ static int check_load(struct bpf_verifier_env *env,=
 struct bpf_insn *insn, const
> =20
>  static int check_atomic(struct bpf_verifier_env *env, int insn_idx, stru=
ct bpf_insn *insn)
>  {
> +	const int bpf_size =3D BPF_SIZE(insn->code);
> +	bool write_only =3D false;
>  	int load_reg;
>  	int err;
> =20
> @@ -7564,17 +7566,21 @@ static int check_atomic(struct bpf_verifier_env *=
env, int insn_idx, struct bpf_i
>  	case BPF_XOR | BPF_FETCH:
>  	case BPF_XCHG:
>  	case BPF_CMPXCHG:
> +		if (bpf_size !=3D BPF_W && bpf_size !=3D BPF_DW) {
> +			verbose(env, "invalid atomic operand size\n");
> +			return -EINVAL;
> +		}
> +		break;
> +	case BPF_LOAD_ACQ:

Several notes here:
- This skips the 'bpf_jit_supports_insn()' call at the end of the function.
- Also 'check_load()' allows source register to be PTR_TO_CTX,
  but convert_ctx_access() is not adjusted to handle these atomic instructi=
ons.
  (Just in case: context access is special, context structures are not "rea=
l",
   e.g. during runtime real sk_buff is passed to the program, not __sk_buff=
,
   in convert_ctx_access() verifier adjusts offsets of load and store instr=
uctions
   to point to real fields, this is done per program type, e.g. see
   filter.c:bpf_convert_ctx_access);
- backtrack_insn() needs special rules to handle BPF_LOAD_ACQ same way
  it handles loads.

> +		return check_load(env, insn, "atomic");
> +	case BPF_STORE_REL:
> +		write_only =3D true;
>  		break;
>  	default:
>  		verbose(env, "BPF_ATOMIC uses invalid atomic opcode %02x\n", insn->imm=
);
>  		return -EINVAL;
>  	}
> =20
> -	if (BPF_SIZE(insn->code) !=3D BPF_W && BPF_SIZE(insn->code) !=3D BPF_DW=
) {
> -		verbose(env, "invalid atomic operand size\n");
> -		return -EINVAL;
> -	}
> -
>  	/* check src1 operand */
>  	err =3D check_reg_arg(env, insn->src_reg, SRC_OP);
>  	if (err)

Note: this code fragment looks as follows:

	/* check src1 operand */
	err =3D check_reg_arg(env, insn->src_reg, SRC_OP);
	if (err)
		return err;

	/* check src2 operand */
	err =3D check_reg_arg(env, insn->dst_reg, SRC_OP);
	if (err)
		return err;

And there is no need for 'check_reg_arg(env, insn->dst_reg, SRC_OP)'
for BPF_STORE_REL.

> @@ -7615,6 +7621,9 @@ static int check_atomic(struct bpf_verifier_env *en=
v, int insn_idx, struct bpf_i
>  		return -EACCES;
>  	}
> =20
> +	if (write_only)
> +		goto skip_read_check;
> +
>  	if (insn->imm & BPF_FETCH) {
>  		if (insn->imm =3D=3D BPF_CMPXCHG)
>  			load_reg =3D BPF_REG_0;
> @@ -7636,14 +7645,15 @@ static int check_atomic(struct bpf_verifier_env *=
env, int insn_idx, struct bpf_i
>  	 * case to simulate the register fill.
>  	 */
>  	err =3D check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
> -			       BPF_SIZE(insn->code), BPF_READ, -1, true, false);
> +			       bpf_size, BPF_READ, -1, true, false);
>  	if (!err && load_reg >=3D 0)
>  		err =3D check_mem_access(env, insn_idx, insn->dst_reg, insn->off,
> -				       BPF_SIZE(insn->code), BPF_READ, load_reg,
> -				       true, false);
> +				       bpf_size, BPF_READ, load_reg, true,
> +				       false);
>  	if (err)
>  		return err;
> =20
> +skip_read_check:
>  	if (is_arena_reg(env, insn->dst_reg)) {
>  		err =3D save_aux_ptr_type(env, PTR_TO_ARENA, false);
>  		if (err)

[...]


