Return-Path: <bpf+bounces-72128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8031C0759E
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 18:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C8DC18913C6
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 16:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2E1280037;
	Fri, 24 Oct 2025 16:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gZTbNWIm"
X-Original-To: bpf@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F79274FD0
	for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 16:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761323888; cv=none; b=eazYKF1oTbm/JpMzRUcNX5JE3R2Ab6FZAyJS13avy3blZro3tozyWR1K0ceO3Jd7eRU8try+PMAetlZ2uWLnr2YHR2hM5H3bcygbk4Y1d8uv7DJEY5IT8uY2rNmjgjaCKRheuBEG7CbE2oL351LTV+xH/82sPYFg0PPde9Ocw3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761323888; c=relaxed/simple;
	bh=4RdmMOkVFovv6W3PG0hz9kHh4ekzafNn8MrGb3gvNds=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N5JgDj8umd0QMo0BRXxTsjpKAHypfWk/Shcw25+KhSgEc7FzfIJptfw3em9YVggKrMeiz6huSsxPDPpgwmVIAjHVR9fT2GNIwX6VNClEBvlhexuTkSIXRSsPlAy4kCTUhIKz9Yg2QMYWsjYdBVE7Af48xbD9+F9px/9gP/EFErs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gZTbNWIm; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <90ec497a230584b0e627d12eaf172236b7a5165b.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761323883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yk3pEU/ACNai1/q+WeDU0CKJXNjGIfc4+FFbTTAuSvo=;
	b=gZTbNWImdS5DbYczGLOS/duKMTfC1P2/KqR8Fj2/eycDa09s2PtKWcKM0HCsLRm/Rzw2XX
	nVchMoKRZKM1GI44f0wW9auzTW8aQUS7K3YF06nYI9s4mrYLtWXESoCt6Tz19rX43UQIRp
	M2MWPeJxq1A/HmUTimc2gQYTS9AjZ9w=
Subject: Re: [PATCH bpf-next 1/2] bpf: Skip bounds adjustment for
 conditional jumps on same register
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: KaFai Wan <kafai.wan@linux.dev>
To: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>, Paul Chaignon <paul.chaignon@gmail.com>, Matan Shachnai
 <m.shachnai@gmail.com>, Luis Gerhorst <luis.gerhorst@fau.de>, 
 colin.i.king@gmail.com, Harishankar Vishwanathan
 <harishankar.vishwanathan@gmail.com>, bpf <bpf@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK"
 <linux-kselftest@vger.kernel.org>, Kaiyan Mei <M202472210@hust.edu.cn>, 
 Yinhao Hu <dddddd@hust.edu.cn>
Date: Sat, 25 Oct 2025 00:37:51 +0800
In-Reply-To: <0d98a2c754884e94c3367209680c071a8df4279d.camel@gmail.com>
References: <20251022164457.1203756-1-kafai.wan@linux.dev>
	 <20251022164457.1203756-2-kafai.wan@linux.dev>
	 <39af9321-fb9b-4cee-84f1-77248a375e85@linux.dev>
	 <1d03174dfe2a7eab1166596c85a6b586a660dffc.camel@gmail.com>
	 <CAADnVQKdMcOkkqNa3LbGWqsz9iHAODFSinokj6htbGi0N66h_Q@mail.gmail.com>
	 <abe1bd5def7494653d52425818815baa54a3628a.camel@gmail.com>
	 <0d267da41178f3ac4669621516888a06d6aa5665.camel@linux.dev>
	 <f0a52150bc99aa4da1a25d6181975cd3c80a717f.camel@gmail.com>
	 <b190c9b2837b28cf579aa38126de50e29e0add32.camel@linux.dev>
	 <0d98a2c754884e94c3367209680c071a8df4279d.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

On Fri, 2025-10-24 at 09:21 -0700, Eduard Zingerman wrote:
> On Sat, 2025-10-25 at 00:13 +0800, KaFai Wan wrote:
>=20
> [...]
>=20
> > For non-scalar cases we only allow pointer comparison on pkt_ptr, this =
check is before
> > is_branch_taken()
> >=20
> > 	src_reg =3D &regs[insn->src_reg];
> > 	if (!(reg_is_pkt_pointer_any(dst_reg) && reg_is_pkt_pointer_any(src_re=
g)) &&
> > 	=C2=A0=C2=A0=C2=A0 is_pointer_value(env, insn->src_reg)) {
> > 		verbose(env, "R%d pointer comparison prohibited\n",
> > 			insn->src_reg);
> > 		return -EACCES;
> > 	}=20
> >=20
> > and in the end of check_cond_jmp_op() (after is_branch_taken()), we che=
cked again
> >=20
> > 	} else if (!try_match_pkt_pointers(insn, dst_reg, &regs[insn->src_reg]=
,
> > 					=C2=A0=C2=A0 this_branch, other_branch) &&
> > 		=C2=A0=C2=A0 is_pointer_value(env, insn->dst_reg)) {
> > 		verbose(env, "R%d pointer comparison prohibited\n",
> > 			insn->dst_reg);
> > 		return -EACCES;
> > 	}
> >=20
> > this time we=C2=A0check if it is valid comparison on pkt_ptr in try_mat=
ch_pkt_pointers().=C2=A0
> >=20
> > Currently we just allow 4 opcode (BPF_JGT, BPF_JLT, BPF_JGE, BPF_JLE) o=
n pkt_ptr, and with
> > conditions. But we bypass these prohibits in privileged mode (is_pointe=
r_value() always=C2=A0
> > return false in privileged mode).
> >=20
> > So the logic skip these prohibits for pkt_ptr in unprivileged mode.
>=20
> Well, yes, but do you really need to do forbid `if r0 > r0 goto ...` in u=
npriv?

Currently `if r0 > r0 goto ...` is forbid in unpriv, but we can allow it.=
=20

--=20
Thanks,
KaFai

