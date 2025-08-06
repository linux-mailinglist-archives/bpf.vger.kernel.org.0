Return-Path: <bpf+bounces-65115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34939B1C492
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 12:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C489A3B8F4E
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 10:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E93D28AAED;
	Wed,  6 Aug 2025 10:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q95c3k26"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E352C23C8AE
	for <bpf@vger.kernel.org>; Wed,  6 Aug 2025 10:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754477881; cv=none; b=ZCZpVMEtKedlcnUWFkYyL/YyLubRtldtABzC6Po3ClrvhkV0y1WaEasNWXkAb+S/l6ws7AHvVZkuWOn2VIW/aTLLLjQtkTa7Py/Y1bEmGu4t+XhYcBqR38tomOs7ZLckOXXzedY+5SmZzVJYix94JlHsFxm4U9LBujcO6dRcVS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754477881; c=relaxed/simple;
	bh=z8GYCyAVv8Y4wWeN8izDuoifjHdbxLP+rh9guv80GFA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oDZuPIbgRo1hQnHcgORjvQDHzWUwXCvZRWaJ0ZTC8CIWtvKxqLNSeW1yzo907sSvSjVJj3fo6C3OBPK/8vRa/BOHq4BrUKL5BSD18nXT+ffx55lqkwmBzz19PLNR/q2xNI7le0QLUYfQhgnrvtS5rWUCitTCh9Gy0Of7zlHlIoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q95c3k26; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c8c870e25c07aee5c84c84aa62cebd655ff53f50.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754477876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vNROiky5WQWNyX8i1Lin0xM/vtQO7Q82V16OYUAfCxM=;
	b=q95c3k26iia3cRM0I4Dnd1gzmoM0yr3JevffrUOq3zzpvwP3oUQCTV7e/0YGWFwH/5Udom
	+h7mr6nGUUItZ6F5kVhkdrShJgExBu/VjapfObHQ5+E0ydcoLxWFtQiahF4kEJjCCB+Tfn
	f4OIxcQSb1WL/Ar4A9hy/a31I1RDwww=
Subject: Re: [PATCH bpf-next 1/1] bpf: Allow fall back to interpreter for
 programs with stack size <= 512
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: KaFai Wan <kafai.wan@linux.dev>
To: Yonghong Song <yonghong.song@linux.dev>, ast@kernel.org, 
 daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, 
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 kpsingh@kernel.org,  sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 mrpre@163.com,  bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>
Date: Wed, 06 Aug 2025 18:57:43 +0800
In-Reply-To: <401418b7-248c-42a3-ba74-9b2b2959e36c@linux.dev>
References: <20250805115513.4018532-1-kafai.wan@linux.dev>
	 <401418b7-248c-42a3-ba74-9b2b2959e36c@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

On Tue, 2025-08-05 at 10:45 -0700, Yonghong Song wrote:
>=20
>=20
> On 8/5/25 4:55 AM, KaFai Wan wrote:
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
> > =C2=A0 # CONFIG_BPF_JIT_ALWAYS_ON is not set
> > =C2=A0 CONFIG_BPF_JIT_DEFAULT_ON=3Dy
> >=20
> > The issue arises because commits:
> > 1. "bpf: Fix array bounds error with may_goto" changed default
> > runtime to
> > =C2=A0=C2=A0=C2=A0 __bpf_prog_ret0_warn when jit_requested =3D 1
> > 2. "bpf: Avoid __bpf_prog_ret0_warn when jit fails" returns error
> > when
> > =C2=A0=C2=A0=C2=A0 jit_requested =3D 1 but jit fails
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
> > Fixes: 86bc9c742426 ("bpf: Avoid __bpf_prog_ret0_warn when jit
> > fails")
> > Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
> > ---
> > =C2=A0 kernel/bpf/core.c | 12 +++++++-----
> > =C2=A0 1 file changed, 7 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index 5d1650af899d..2d86bd4b0b97 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -2366,8 +2366,8 @@ static unsigned int
> > __bpf_prog_ret0_warn(const void *ctx,
> > =C2=A0=C2=A0					 const struct bpf_insn
> > *insn)
> > =C2=A0 {
> > =C2=A0=C2=A0	/* If this handler ever gets executed, then
> > BPF_JIT_ALWAYS_ON
> > -	 * is not working properly, or interpreter is being used
> > when
> > -	 * prog->jit_requested is not 0, so warn about it!
> > +	 * or may_goto may cause stack size > 512 is not working
> > properly,
> > +	 * so warn about it!
> > =C2=A0=C2=A0	 */
> > =C2=A0=C2=A0	WARN_ON_ONCE(1);
> > =C2=A0=C2=A0	return 0;
> > @@ -2478,10 +2478,10 @@ static void bpf_prog_select_func(struct
> > bpf_prog *fp)
> > =C2=A0=C2=A0	 * But for non-JITed programs, we don't need bpf_func, so
> > no bounds
> > =C2=A0=C2=A0	 * check needed.
> > =C2=A0=C2=A0	 */
> > -	if (!fp->jit_requested &&
> > -	=C2=A0=C2=A0=C2=A0 !WARN_ON_ONCE(idx >=3D ARRAY_SIZE(interpreters))) =
{
> > +	if (idx < ARRAY_SIZE(interpreters)) {
> > =C2=A0=C2=A0		fp->bpf_func =3D interpreters[idx];
> > =C2=A0=C2=A0	} else {
> > +		WARN_ON_ONCE(!fp->jit_requested);
> > =C2=A0=C2=A0		fp->bpf_func =3D __bpf_prog_ret0_warn;
> > =C2=A0=C2=A0	}
>=20
> Your logic here is to do interpreter even if fp->jit_requested is
> true.
> This is different from the current implementation.
>=20
> Also see below code:
>=20
> static unsigned int __bpf_prog_ret0_warn(const void *ctx,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 const struct bpf_insn
> *insn)
> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* If this handler ever =
gets executed, then
> BPF_JIT_ALWAYS_ON
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * is not working p=
roperly, or interpreter is being used
> when
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * prog->jit_reques=
ted is not 0, so warn about it!
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 WARN_ON_ONCE(1);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> }
>=20
>=20
> It mentions to warn if the interpreter is being used when
> prog->jit_requested is not 0.
>=20
> So if prog->jit_requested is not 0, it is expected not to use
> interpreter.
>=20

The commit 6ebc5030e0c5 ("bpf: Fix array bounds error with may_goto")
[1] this patch fix change the code to that, before this commit it was:

static unsigned int __bpf_prog_ret0_warn(const void *ctx,
					 const struct bpf_insn *insn)
{
	/* If this handler ever gets executed, then BPF_JIT_ALWAYS_ON
	 * is not working properly, so warn about it!
	 */
	WARN_ON_ONCE(1);
	return 0;
}

And=20

static void bpf_prog_select_func(struct bpf_prog *fp)
{
#ifndef CONFIG_BPF_JIT_ALWAYS_ON
	u32 stack_depth =3D max_t(u32, fp->aux->stack_depth, 1);

	fp->bpf_func =3D interpreters[(round_up(stack_depth, 32) / 32) -
1];
#else
	fp->bpf_func =3D __bpf_prog_ret0_warn;
#endif
}

so it can fall back to the interpreter when jit fails. And this fit the
intent of bpf_prog_select_runtime(), see comment:

/**
 *	bpf_prog_select_runtime - select exec runtime for BPF program
 *	@fp: bpf_prog populated with BPF program
 *	@err: pointer to error variable
 *
 * Try to JIT eBPF program, if JIT is not available, use interpreter.
 * The BPF program will be executed via bpf_prog_run() function.
 *
 * Return: the &fp argument along with &err set to 0 for success or
 * a negative errno code on failure
 */
struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)


And this:

	bpf_prog_select_func(fp);

	/* eBPF JITs can rewrite the program in case constant
	 * blinding is active. However, in case of error during
	 * blinding, bpf_int_jit_compile() must always return a
	 * valid program, which in this case would simply not
	 * be JITed, but falls back to the interpreter.
	 */
	if (!bpf_prog_is_offloaded(fp->aux)) {


The commit [1] mismatch the intent of bpf_prog_select_runtime(), so it
should be fixed.


[1] https://lore.kernel.org/all/20250214091823.46042-2-mrpre@163.com/

>=20
> > =C2=A0 #else
> > @@ -2505,7 +2505,7 @@ struct bpf_prog
> > *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
> > =C2=A0=C2=A0	/* In case of BPF to BPF calls, verifier did all the prep
> > =C2=A0=C2=A0	 * work with regards to JITing, etc.
> > =C2=A0=C2=A0	 */
> > -	bool jit_needed =3D fp->jit_requested;
> > +	bool jit_needed =3D false;
> > =C2=A0=20
> > =C2=A0=C2=A0	if (fp->bpf_func)
> > =C2=A0=C2=A0		goto finalize;
> > @@ -2515,6 +2515,8 @@ struct bpf_prog
> > *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
> > =C2=A0=C2=A0		jit_needed =3D true;
> > =C2=A0=20
> > =C2=A0=C2=A0	bpf_prog_select_func(fp);
> > +	if (fp->bpf_func =3D=3D __bpf_prog_ret0_warn)
> > +		jit_needed =3D true;
> > =C2=A0=20
> > =C2=A0=C2=A0	/* eBPF JITs can rewrite the program in case constant
> > =C2=A0=C2=A0	 * blinding is active. However, in case of error during
>=20

--=20
Thanks,
KaFai

