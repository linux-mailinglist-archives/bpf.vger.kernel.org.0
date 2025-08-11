Return-Path: <bpf+bounces-65331-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E01E2B207EC
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 13:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D973165353
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 11:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8BA2D3A6A;
	Mon, 11 Aug 2025 11:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uvuYxoaN"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E4F2D3756
	for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 11:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754911733; cv=none; b=a4fPsFBhXR3LKgonzf2PyIupofpTIbxnIZ0fGz07wlR6ytNCw9gdzw/Lirp/8i3q0HpmgjDtYXl0XJJub/QZofh5aC4gAAJllefuZagFjQj47AavR+oY+PCyfQyMGO1nIyqFQm+WAxXuIh1IAn87D484YPqa1D51UCwEaVuxtSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754911733; c=relaxed/simple;
	bh=KbccFC5X8k+i5EVJH+EK/p6cqM1QSCs1E7070K3qb3o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l8Dt9hyqYpzIo4GwB+zxurncFKSS3Ul9HSUNXfa/RWeYJS57qK3t3H+47V3f6nTM8FSRj3PWFB2zCSBKd2H+tOuXf9sSFk8mYE3slSvu95+wV5Dq0z2sHxYw1zDCRNf26ZfbzlFxKKR5gGfagd+z/8XG8V2rsP0ikSo+n/TybcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uvuYxoaN; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d845425e524ee4c81e0f12553e3ed9daa549ce9a.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754911719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KbccFC5X8k+i5EVJH+EK/p6cqM1QSCs1E7070K3qb3o=;
	b=uvuYxoaNVDnzEnkrncpNHCSU+g/PO47HDgf09ewQu7PTEeb4xkn7qfsXXIBWG0Z99GeWLW
	GcvpWrZpGzZSYLi4nP73J6EPvboqTll4MPeSzGIfLnwqRtnC3b7srekazEWZyQ8LM0DX0P
	mpwCgqXWuDgjZkWa6FZco6cf7bY5UPo=
Subject: Re: [PATCH bpf-next 1/1] bpf: Allow fall back to interpreter for
 programs with stack size <= 512
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: KaFai Wan <kafai.wan@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>,  Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Jiayuan Chen <mrpre@163.com>, bpf
 <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Felix Fietkau
 <nbd@nbd.name>
Date: Mon, 11 Aug 2025 19:28:26 +0800
In-Reply-To: <CAADnVQLecBEmQzxOzUwv_2mO9BDrKSp1xiC4WY8-gL2w4OaxaQ@mail.gmail.com>
References: <20250805115513.4018532-1-kafai.wan@linux.dev>
	 <CAADnVQLecBEmQzxOzUwv_2mO9BDrKSp1xiC4WY8-gL2w4OaxaQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

On Thu, 2025-08-07 at 09:50 -0700, Alexei Starovoitov wrote:
> On Tue, Aug 5, 2025 at 4:55=E2=80=AFAM KaFai Wan <kafai.wan@linux.dev> wr=
ote:
> >=20
> > OpenWRT users reported regression on ARMv6 devices after updating
> > to latest
> > HEAD, where tcpdump filter:
> >=20
> > tcpdump -i mon1 \
> > "not wlan addr3 3c37121a2b3c and not wlan addr2 184ecbca2a3a \
> > and not wlan addr2 14130b4d3f47 and not wlan addr2 f0f61cf440b7 \
> > and not wlan addr3 a84b4dedf471 and not wlan addr3 d022be17e1d7 \
> > and not wlan addr3 5c497967208b and not wlan addr2 706655784d5b"
> >=20
> > fails with warning: "Kernel filter failed: No error information"
> > when using config:
> > =C2=A0# CONFIG_BPF_JIT_ALWAYS_ON is not set
> > =C2=A0CONFIG_BPF_JIT_DEFAULT_ON=3Dy
> >=20
> > The issue arises because commits:
> > 1. "bpf: Fix array bounds error with may_goto" changed default
> > runtime to
> > =C2=A0=C2=A0 __bpf_prog_ret0_warn when jit_requested =3D 1
> > 2. "bpf: Avoid __bpf_prog_ret0_warn when jit fails" returns error
> > when
> > =C2=A0=C2=A0 jit_requested =3D 1 but jit fails
> >=20
> > This change restores interpreter fallback capability for BPF
> > programs with
> > stack size <=3D 512 bytes when jit fails.
> >=20
> > Reported-by: Felix Fietkau <nbd@nbd.name>
> > Closes:
> > https://lore.kernel.org/bpf/2e267b4b-0540-45d8-9310-e127bf95fc63@nbd.na=
me/
> > Fixes: 6ebc5030e0c5 ("bpf: Fix array bounds error with may_goto")
>=20
> This commit looks fine.
>=20
> > Fixes: 86bc9c742426 ("bpf: Avoid __bpf_prog_ret0_warn when jit
> > fails")
>=20
> But this one is indeed problematic.
> But before we revert, please provide a selftest that is causing
> valid classic bpf prog to fail JITing on arm,
> because it has to be fixed as well.=20
>=20
OK, I'll add a test for it.

> Sounds like OpenWRT was suffering performance loss due to the
> interpreter.
>=20
> > Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
> > ---
> > =C2=A0kernel/bpf/core.c | 12 +++++++-----
> > =C2=A01 file changed, 7 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index 5d1650af899d..2d86bd4b0b97 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -2366,8 +2366,8 @@ static unsigned int
> > __bpf_prog_ret0_warn(const void *ctx,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 const struct bpf_insn
> > *insn)
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* If this handler ever gets=
 executed, then
> > BPF_JIT_ALWAYS_ON
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * is not working properly, =
or interpreter is being used
> > when
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * prog->jit_requested is no=
t 0, so warn about it!
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * or may_goto may cause sta=
ck size > 512 is not working
> > properly,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * so warn about it!
>=20
> We shouldn't have touched this comment. Let's not do it again.
>=20
OK.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WARN_ON_ONCE(1);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > @@ -2478,10 +2478,10 @@ static void bpf_prog_select_func(struct
> > bpf_prog *fp)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * But for non-JITed pr=
ograms, we don't need bpf_func, so
> > no bounds
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * check needed.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!fp->jit_requested &&
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !WARN_ON_=
ONCE(idx >=3D ARRAY_SIZE(interpreters))) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (idx < ARRAY_SIZE(interpreters=
)) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 fp->bpf_func =3D interpreters[idx];
>=20
> this is fine.
>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 WARN_ON_ONCE(!fp->jit_requested);
>=20
> drop it. Let's not give syzbot more opportunities
> to spam us again with fault injection -like corner cases.
>=20
OK, will drop it.

> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 fp->bpf_func =3D __bpf_prog_ret0_warn;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0#else
> > @@ -2505,7 +2505,7 @@ struct bpf_prog
> > *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* In case of BPF to BPF cal=
ls, verifier did all the prep
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * work with regards to=
 JITing, etc.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool jit_needed =3D fp->jit_reque=
sted;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool jit_needed =3D false;
>=20
> ok
>=20
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (fp->bpf_func)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto finalize;
> > @@ -2515,6 +2515,8 @@ struct bpf_prog
> > *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 jit_needed =3D true;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bpf_prog_select_func(fp);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (fp->bpf_func =3D=3D __bpf_pro=
g_ret0_warn)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 jit_needed =3D true;
>=20
> This is too hacky.
> Change bpf_prog_select_func() to return bool and
> rename it bpf_prog_select_func/bpf_prog_select_interpreter()
>=20
> true on success, false on when interpreter is impossible.
>=20
OK, will change it.

> And target bpf tree.
>=20
OK.=20
> --
> pw-bot: cr
>=20
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* eBPF JITs can rewrite the=
 program in case constant
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * blinding is active. =
However, in case of error during
> > --
> > 2.43.0
> >=20

--=20
Thanks,
KaFai

