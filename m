Return-Path: <bpf+bounces-72535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04583C1507A
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 15:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C6BA1AA2027
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 14:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EBB335BA0;
	Tue, 28 Oct 2025 14:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z9GFkG47"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D861335062
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 14:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761660137; cv=none; b=iY1Pe0N5LdeJfE7o/bbL1fsjgvhIJ9eDKmQRFHMMGJ6FkXlWl3wg+YX6Iga5GctE/fc7aPr0WST8xv3+HGHZiIqCyLubla//i/6Z7gHM3NszcXb5Yu+DmwhLRpQriYkcdo4HWT/eYCcnhxzVRiT9eLxC2ql3UUri+/96U9GWl1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761660137; c=relaxed/simple;
	bh=KQJVW7hQFsOfYlMfXn7g2fhKNRdoKavynWn5pj97P2E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KO2B4sA4vJQM90TbwPlzItdmcRhdEqbneNepR1OEmrd8vqBK+lZjUAjs6qnwR3yityHVoh+JPpiKR5ZvQh3u+MNZpIiTAzSm0sZfrRL96AjTaMc/B/KyBQGvTyen+WQmvsFvuvusE097fUTJ1fFjk32LLsyNYEZNbVPH8OaLTJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z9GFkG47; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ed4e9b731744dd0f80f5f909649dc429cd38d662.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761660130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HQTPBURjsOkZj3EiVY9z0u60SrFsL8Dztnnfp+pAlCA=;
	b=Z9GFkG47Gtvs5GqThyqO3DTOhhShq//34KBy0fz3/b/XoJnmDxAH4ppQO+I+Hw7y78Ih4c
	fU7a9lrwbxmOZoPVtfCo0Bh0hkpbeU/KBc72uATxrQrBglsA13UnJ5LFLlnmeOwe1G+JoY
	rPlCR3T2rfOednltKD71yWyiqS4DSsE=
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Skip bounds adjustment for
 conditional jumps on same register
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: KaFai Wan <kafai.wan@linux.dev>
To: Eduard Zingerman <eddyz87@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net,  john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, song@kernel.org,  yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,  jolsa@kernel.org,
 shuah@kernel.org, paul.chaignon@gmail.com, m.shachnai@gmail.com, 
 harishankar.vishwanathan@gmail.com, colin.i.king@gmail.com,
 luis.gerhorst@fau.de,  bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org
Cc: Kaiyan Mei <M202472210@hust.edu.cn>, Yinhao Hu <dddddd@hust.edu.cn>
Date: Tue, 28 Oct 2025 22:01:50 +0800
In-Reply-To: <51769170ba3cf9eb4007fb0fc22f2434302d9aa5.camel@gmail.com>
References: <20251025053017.2308823-1-kafai.wan@linux.dev>
	 <20251025053017.2308823-2-kafai.wan@linux.dev>
	 <51769170ba3cf9eb4007fb0fc22f2434302d9aa5.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

On Mon, 2025-10-27 at 13:09 -0700, Eduard Zingerman wrote:
> On Sat, 2025-10-25 at 13:30 +0800, KaFai Wan wrote:
> > When conditional jumps are performed on the same register (e.g., r0 <=
=3D r0,
> > r0 > r0, r0 < r0) where the register holds a scalar with range, the ver=
ifier
> > incorrectly attempts to adjust the register's min/max bounds. This lead=
s to
> > invalid range bounds and triggers a BUG warning:
> >=20
> > verifier bug: REG INVARIANTS VIOLATION (true_reg1): range bounds violat=
ion u64=3D[0x1, 0x0]
> > s64=3D[0x1, 0x0] u32=3D[0x1, 0x0] s32=3D[0x1, 0x0] var_off=3D(0x0, 0x0)
> > WARNING: CPU: 0 PID: 92 at kernel/bpf/verifier.c:2731 reg_bounds_sanity=
_check+0x163/0x220
> > Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-=
debian-1.16.3-2
> > 04/01/2014
> > RIP: 0010:reg_bounds_sanity_check+0x163/0x220
> > Call Trace:
> > =C2=A0<TASK>
> > =C2=A0reg_set_min_max+0xf7/0x1d0
> > =C2=A0check_cond_jmp_op+0x57b/0x1730
> > =C2=A0? print_bpf_insn+0x3d5/0xa50
> > =C2=A0do_check_common+0x33ac/0x33c0
> > =C2=A0...
> >=20
> > The root cause is in regs_refine_cond_op() where BPF_JLT/BPF_JSLT opera=
tions
> > adjust both min/max bounds on the same register, causing invalid bounds=
.
> >=20
> > Since comparing a register with itself should not change its bounds (th=
e
> > comparison result is always known: r0 =3D=3D r0 is always true, r0 < r0=
 is
> > always false), the bounds adjustment is unnecessary.
> >=20
> > Fix this by:
> > 1. Enhance is_branch_taken() and is_scalar_branch_taken() to properly
> > =C2=A0=C2=A0 handle branch direction computation for same register comp=
arisons
> > =C2=A0=C2=A0 across all BPF jump operations
> > 2. For unknown branch directions (e.g., BPF_JSET), add early return in
> > =C2=A0=C2=A0 reg_set_min_max() to avoid bounds adjustment on the same r=
egister
> >=20
> > The fix ensures that unnecessary bounds adjustments are skipped, preven=
ting
> > the verifier bug while maintaining correct branch direction analysis.
> >=20
> > Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> > Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> > Closes: https://lore.kernel.org/all/1881f0f5.300df.199f2576a01.Coremail=
.kaiyanm@hust.edu.cn/
> > Fixes: 0df1a55afa83 ("bpf: Warn on internal verifier errors")
> > Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
> > ---
> > =C2=A0kernel/bpf/verifier.c | 32 ++++++++++++++++++++++++++++++++
> > =C2=A01 file changed, 32 insertions(+)
> >=20
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 6d175849e57a..653fa96ed0df 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -16037,6 +16037,12 @@ static int is_scalar_branch_taken(struct bpf_r=
eg_state *reg1, struct
> > bpf_reg_sta
> > =C2=A0		}
> > =C2=A0		break;
> > =C2=A0	case BPF_JSET:
> > +		if (reg1 =3D=3D reg2) {
> > +			if (tnum_is_const(t1))
> > +				return t1.value !=3D 0;
> > +			else
> > +				return (smin1 <=3D 0 && smax1 >=3D 0) ? -1 : 1;
> > +		}
>=20
> I think this logic is fine, but it needs tests for multiple cases.
>=20
ok, I'll add tests for that.

> > =C2=A0		if (!is_reg_const(reg2, is_jmp32)) {
> > =C2=A0			swap(reg1, reg2);
> > =C2=A0			swap(t1, t2);
> > @@ -16172,6 +16178,25 @@ static int is_pkt_ptr_branch_taken(struct bpf_=
reg_state *dst_reg,
> > =C2=A0static int is_branch_taken(struct bpf_reg_state *reg1, struct bpf=
_reg_state *reg2,
> > =C2=A0			=C2=A0=C2=A0 u8 opcode, bool is_jmp32)
> > =C2=A0{
> > +	if (reg1 =3D=3D reg2) {
> > +		switch (opcode) {
> > +		case BPF_JGE:
> > +		case BPF_JLE:
> > +		case BPF_JSGE:
> > +		case BPF_JSLE:
> > +		case BPF_JEQ:
> > +			return 1;
> > +		case BPF_JGT:
> > +		case BPF_JLT:
> > +		case BPF_JSGT:
> > +		case BPF_JSLT:
> > +		case BPF_JNE:
> > +			return 0;
> > +		default:
> > +			break;
> > +		}
> > +	}
> > +
>=20
> I think Alexei was against my suggestion to put it in
> is_branch_taken() and preferred is_scalar_branch_taken() instead.
>=20
Hmm, I misunderstood that. If put in is_scalar_branch_taken() then just for=
 scalar cases,
just confirm that.

> > =C2=A0	if (reg_is_pkt_pointer_any(reg1) && reg_is_pkt_pointer_any(reg2)=
 && !is_jmp32)
> > =C2=A0		return is_pkt_ptr_branch_taken(reg1, reg2, opcode);
> > =C2=A0
> > @@ -16429,6 +16454,13 @@ static int reg_set_min_max(struct bpf_verifier=
_env *env,
> > =C2=A0	if (false_reg1->type !=3D SCALAR_VALUE || false_reg2->type !=3D =
SCALAR_VALUE)
> > =C2=A0		return 0;
> > =C2=A0
> > +	/* We compute branch direction for same registers in is_branch_taken(=
) and
> > +	 * is_scalar_branch_taken(). For unknown branch directions (e.g., BPF=
_JSET)
> > +	 * on the same registers, we don't need to adjusts the min/max values=
.
> > +	 */
> > +	if (false_reg1 =3D=3D false_reg2)
> > +		return 0;
> > +
> > =C2=A0	/* fallthrough (FALSE) branch */
> > =C2=A0	regs_refine_cond_op(false_reg1, false_reg2, rev_opcode(opcode), =
is_jmp32);
> > =C2=A0	reg_bounds_sync(false_reg1);

--=20
Thanks,
KaFai

