Return-Path: <bpf+bounces-78813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2C2D1C1D9
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 03:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D518300BEE9
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 02:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60FE2F49EB;
	Wed, 14 Jan 2026 02:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SSj1vj1c"
X-Original-To: bpf@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAE623D7DC
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 02:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768357188; cv=none; b=bxuZJ3j0qKwg3eCO2iMeHO2cq/FJjwrXYjLSmLZW6pSWdEmfeGn0vlM8pOIu8IuHVjwSTyvo2WcVTDVAXA4j6kz9K9QH4KJjNN6wqR2WHOZdwU5+hHP+3n2a+1R5ERuIzjRO3vjpHB6a6VxwHaoLXhSZsmVvj7Wo5D2McalEb5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768357188; c=relaxed/simple;
	bh=CbOwZWVt02pTmAdBvT2v/9JOm8DTA3cij2f8VlEdS/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=niobQP+fzr28aLWtsiqZqBHE7ODtJDq9guBOD3FUuERkV2tMIhfzpxXBQIDCselZEOCGeBC9/mlUSuRqXdb9bZg9XyZDKcsycz2MnUMtJlBLhbqgMUOwQNKfy+lUdR8QREpVyLa2nhXZCD6t7hKC/KDLbQplTPYbfLgp4+YBdNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SSj1vj1c; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768357184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UvgWx1kTHRPgiLXD8oKSH/+hs2Bj1hao3LoyD/Aq7ys=;
	b=SSj1vj1cuT4sC5LRrQe1UUXcjsargeO3UaGr9CAgBHU74EONr+PesIqoOaJvk2s5WWRfSY
	Lp8AhurYUq91ogApC+cy1hzl/Kx7O1I7AKVc2wphUN6TkUeliqQI4HwBl0pVLzEFhPsigX
	L8/dohZA2p1N+koQFoXqAk1x3oQ7I4Y=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 dsahern@kernel.org, tglx@linutronix.de, mingo@redhat.com,
 jiang.biao@linux.dev, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, hpa@zytor.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH bpf-next v9 03/11] bpf: change prototype of
 bpf_session_{cookie,is_return}
Date: Wed, 14 Jan 2026 10:19:34 +0800
Message-ID: <22969680.EfDdHjke4D@7940hx>
In-Reply-To:
 <CAEf4BzYid4WaAkNLBegeN5FLiLTjZ1scToA-Sdpz3tqL6iE=Tw@mail.gmail.com>
References:
 <20260110141115.537055-1-dongml2@chinatelecom.cn>
 <20260110141115.537055-4-dongml2@chinatelecom.cn>
 <CAEf4BzYid4WaAkNLBegeN5FLiLTjZ1scToA-Sdpz3tqL6iE=Tw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/1/14 09:22 Andrii Nakryiko <andrii.nakryiko@gmail.com> write:
> On Sat, Jan 10, 2026 at 6:12=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > Add the function argument of "void *ctx" to bpf_session_cookie() and
> > bpf_session_is_return(), which is a preparation of the next patch.
> >
> > The two kfunc is seldom used now, so it will not introduce much effect
> > to change their function prototype.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> >  kernel/trace/bpf_trace.c                             |  4 ++--
> >  tools/testing/selftests/bpf/bpf_kfuncs.h             |  4 ++--
> >  .../bpf/progs/kprobe_multi_session_cookie.c          | 12 ++++++------
> >  .../selftests/bpf/progs/uprobe_multi_session.c       |  4 ++--
> >  .../bpf/progs/uprobe_multi_session_cookie.c          | 12 ++++++------
> >  .../bpf/progs/uprobe_multi_session_recursive.c       |  8 ++++----
> >  6 files changed, 22 insertions(+), 22 deletions(-)
> >
>=20
> LGTM, let's do it
>=20
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>=20
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 5f621f0403f8..297dcafb2c55 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -3316,7 +3316,7 @@ static u64 bpf_uprobe_multi_entry_ip(struct bpf_r=
un_ctx *ctx)
> >
> >  __bpf_kfunc_start_defs();
> >
> > -__bpf_kfunc bool bpf_session_is_return(void)
> > +__bpf_kfunc bool bpf_session_is_return(void *ctx)
> >  {
> >         struct bpf_session_run_ctx *session_ctx;
> >
> > @@ -3324,7 +3324,7 @@ __bpf_kfunc bool bpf_session_is_return(void)
> >         return session_ctx->is_return;
> >  }
> >
> > -__bpf_kfunc __u64 *bpf_session_cookie(void)
> > +__bpf_kfunc __u64 *bpf_session_cookie(void *ctx)
> >  {
> >         struct bpf_session_run_ctx *session_ctx;
> >
> > diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/s=
elftests/bpf/bpf_kfuncs.h
> > index e0189254bb6e..dc495cb4c22e 100644
> > --- a/tools/testing/selftests/bpf/bpf_kfuncs.h
> > +++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
> > @@ -79,8 +79,8 @@ extern int bpf_verify_pkcs7_signature(struct bpf_dynp=
tr *data_ptr,
> >                                       struct bpf_dynptr *sig_ptr,
> >                                       struct bpf_key *trusted_keyring) =
__ksym;
> >
> > -extern bool bpf_session_is_return(void) __ksym __weak;
> > -extern __u64 *bpf_session_cookie(void) __ksym __weak;
> > +extern bool bpf_session_is_return(void *ctx) __ksym __weak;
> > +extern __u64 *bpf_session_cookie(void *ctx) __ksym __weak;
> >
>=20
> (and actually drop these, vmlinux.h will have them)

OK, I'll drop these in the next version.

>=20
> >  struct dentry;
> >  /* Description
>=20
> [...]
>=20





