Return-Path: <bpf+bounces-69728-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A573FBA0661
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 17:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77E365E21E6
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 15:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212003054FD;
	Thu, 25 Sep 2025 15:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Y7dbd/IP"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F016303C9B
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 15:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758814339; cv=none; b=rKdFWE4hodWvYjP5iN/wWNhRdpLhJFGzaKXlO4+ECr6+D1FMA8jKf/J8ljux1L7nbQCdQEZ+0YAfSvla2cQ3oAaGVRpUmMpGaWpuBB+RVWL3JRJa4ahGhMvTnIImBB6JCbLcMj67fe0wFyX4+Yaa/0MjOb1ezTTbZLzIbiaf/JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758814339; c=relaxed/simple;
	bh=NgT10FpEpSYYmbnmgt3MhuxO1JnJEvfawqPO+Byo8xI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u96ufgAlvIaJVUtIXBX2+OOAriEInPXBImDF52mzBdHhR1toJG9hHHMjiwL5iGVPiPPJnRkO33eLlTYUG2rlxA1zV0E5U1ePDtMirk66ttEijg//ZnVgkhGbquxJZdHVRiH6yb2AZRtYyljSTbCHkr3HRrr+qye+7/WDNK97Ku4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Y7dbd/IP; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <933a66f3e0e1f642ef53726abe617c4d138a91fa.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758814325;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IVM3/TjrAx73b+FFU6cSE3KCrtsxDRhadpXezuUiniY=;
	b=Y7dbd/IP+lKkGHLIMsxvGvDQN+1VTUeP2StrY8X6sHD1Kd0cnjplNEVjwvAMXKMLL5+suv
	rERCckBKYVHnK0EZJCLgPViCOQ8VfQg+2bERKw2mIuiowcFBYJSl5GqF/wcHJ5Q31aYCgr
	RWDAWjp1VXVduDScsJh34vVJ6g/6gds=
Subject: Re: [PATCH v2] bpf: fix NULL pointer dereference in
 print_reg_state()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: KaFai Wan <kafai.wan@linux.dev>
To: Brahmajit Das <listout@listout.xyz>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>
Cc: syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com, Andrii Nakryiko
 <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf
 <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Eduard
 <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, John Fastabend
 <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, KP Singh
 <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, Song Liu
 <song@kernel.org>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, 
 Yonghong Song <yonghong.song@linux.dev>
Date: Thu, 25 Sep 2025 23:31:41 +0800
In-Reply-To: <wz6god46aom7lfyuvhju67w47czdznzflec3ilqs6f7fpyf3di@k5wliusgqlut>
References: <68d26227.a70a0220.1b52b.02a4.GAE@google.com>
	 <20250923174738.1713751-1-listout@listout.xyz>
	 <CAADnVQ+SkF2jL6NZLTF7ZKwNOfOtpMqr0ubjXpF1K0+EkHdJHw@mail.gmail.com>
	 <qj5y7pjdx2f5alp7sfx2gepfylkk2bytiyeoiapyp3dpzwloyk@aljz7o77tt3m>
	 <9051652cf548271da9c349758cbd70aaa3cee444.camel@linux.dev>
	 <wz6god46aom7lfyuvhju67w47czdznzflec3ilqs6f7fpyf3di@k5wliusgqlut>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

On Wed, 2025-09-24 at 23:58 +0530, Brahmajit Das wrote:
> On 25.09.2025 01:38, KaFai Wan wrote:
> > On Wed, 2025-09-24 at 21:10 +0530, Brahmajit Das wrote:
> > > On 24.09.2025 09:32, Alexei Starovoitov wrote:
> > > > On Wed, Sep 24, 2025 at 1:43=E2=80=AFAM Brahmajit Das
> > > > <listout@listout.xyz>
> > > > wrote:
> > > > >=20
> > > > > Syzkaller reported a general protection fault due to a NULL
> > > > > pointer
> > > > > dereference in print_reg_state() when accessing reg->map_ptr
> > > > > without
> > > > > checking if it is NULL.
> > > > >=20
> > > ...snip...
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (type_is_map_ptr(t)) {
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (type_is_map_ptr(t) && r=
eg->map_ptr) {
> > > >=20
> > > > You ignored earlier feedback.
> > > > Fix the root cause, not the symptom.
> > > >=20
> > > > pw-bot: cr
> > >=20
> > > I'm not sure if I'm headed the write direction but it seems like
> > > in
> > > check_alu_op, we are calling adjust_scalar_min_max_vals when we
> > > get
> > > an
> > > BPF_NEG as opcode. Which has a call to __mark_reg_known when
> > > opcode
> > > is
> > > BPF_NEG. And __mark_reg_known clears map_ptr with
> > >=20
> > > 	/* Clear off and union(map_ptr, range) */
> > > 	memset(((u8 *)reg) + sizeof(reg->type), 0,
> > > 	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 offsetof(struct bpf_reg_state, =
var_off) -
> > > sizeof(reg-
> > > > type));
> > >=20
> >=20
> > I think you are right. The following code can reproduce the error.
> >=20
> > 	asm volatile ("					\
> > 	r0 =3D %[map_hash_48b] ll;			\
> > 	r0 =3D -r0;					\
> > 	exit;						\
> > "	:
> > 	: __imm_addr(map_hash_48b)
> > 	: __clobber_all);
> >=20
> >=20
> > BPF_NEG calls __mark_reg_known(dst_reg, 0) which clears the 'off'
> > and
> > 'union(map_ptr, range)' of dst_reg, but keeps the 'type', which is
> > CONST_PTR_TO_MAP.
> >=20
> > Perhaps we can only allow the SCALAR_VALUE type to run BPF_NEG as
> > an
> > opcode, while for other types same as the before BPF_NEG.
> >=20
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index e892df386eed..dbf9f1efc6e7 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -15346,13 +15346,15 @@ static bool
> > is_safe_to_compute_dst_reg_range(struct bpf_insn *insn,
> > =C2=A0	switch (BPF_OP(insn->code)) {
> > =C2=A0	case BPF_ADD:
> > =C2=A0	case BPF_SUB:
> > -	case BPF_NEG:
> > =C2=A0	case BPF_AND:
> > =C2=A0	case BPF_XOR:
> > =C2=A0	case BPF_OR:
> > =C2=A0	case BPF_MUL:
> > =C2=A0		return true;
> > =C2=A0
> > +	case BPF_NEG:
> > +		return base_type(src_reg->type) =3D=3D SCALAR_VALUE;
> > +
> >=20
> >=20
> > --=20
> > Thanks,
> > KaFai
>=20
> Before even going into adjust_scalar_min_max_vals we have a check in
> check_alu_op, which I think is not being respected. Going to expand
> on
> this below as response to Alexei.
>=20
> On 24.09.2025 18:28, Alexei Starovoitov wrote:
> > On Wed, Sep 24, 2025 at 4:41=E2=80=AFPM Brahmajit Das <listout@listout.=
xyz>
> > wrote:
> > >=20
> > > On 24.09.2025 09:32, Alexei Starovoitov wrote:
> > > > On Wed, Sep 24, 2025 at 1:43=E2=80=AFAM Brahmajit Das
> > > > <listout@listout.xyz> wrote:
> > > > >=20
> > > > > Syzkaller reported a general protection fault due to a NULL
> > > > > pointer
> > > > > dereference in print_reg_state() when accessing reg->map_ptr
> > > > > without
> > > > > checking if it is NULL.
> > > > >=20
> > > ...snip...
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (type_is_map_ptr(t)) {
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (type_is_map_ptr(t) && r=
eg->map_ptr) {
> > > >=20
> > > > You ignored earlier feedback.
> > > > Fix the root cause, not the symptom.
> > > >=20
> > > > pw-bot: cr
> > >=20
> > > I'm not sure if I'm headed the write direction but it seems like
> > > in
> > > check_alu_op, we are calling adjust_scalar_min_max_vals when we
> > > get an
> > > BPF_NEG as opcode. Which has a call to __mark_reg_known when
> > > opcode is
> > > BPF_NEG. And __mark_reg_known clears map_ptr with
> >=20
> > Looks like we're getting somewhere.
> > It seems the verifier is not clearing reg->type.
> > adjust_scalar_min_max_vals() should be called on scalar types only.
>=20
> Right, there is a check in check_alu_op
>=20
> 		if (is_pointer_value(env, insn->dst_reg)) {
> 			verbose(env, "R%d pointer arithmetic
> prohibited\n",
> 				insn->dst_reg);
> 			return -EACCES;
> 		}
>=20
> is_pointer_value calls __is_pointer_value which takes bool
> allow_ptr_leaks as the first argument. Now for some reason in this
> case
> allow_ptr_leaks is being passed as true, as a result
> __is_pointer_value
> (and in turn is_pointer_value) returns false when even when register
> type is CONST_PTR_TO_MAP.
>=20

IIUC, `env->allow_ptr_leaks` set true means privileged mode (
CAP_PERFMON or CAP_SYS_ADMIN ), false for unprivileged mode.=20


We can use __is_pointer_value to check if the register type is a
pointer. For pointers, we check as before (before checking BPF_NEG
separately), and for scalars, it remains unchanged.=C2=A0Perhaps this way w=
e
can fix the error.

if (opcode =3D=3D BPF_NEG) {
	if (__is_pointer_value(false, &regs[insn->dst_reg])) {
		err =3D check_reg_arg(env, insn->dst_reg, DST_OP);
	} else {
		err =3D check_reg_arg(env, insn->dst_reg,
DST_OP_NO_MARK);
		err =3D err ?: adjust_scalar_min_max_vals(env, insn,
						&regs[insn->dst_reg],
						regs[insn->dst_reg]);
	}
} else {


--=20
Thanks,
KaFai

