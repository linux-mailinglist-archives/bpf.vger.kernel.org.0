Return-Path: <bpf+bounces-78444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E913ED0CDF6
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 04:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B264A3025F8C
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 03:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8241256C6C;
	Sat, 10 Jan 2026 03:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SVKRUx7n"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECD922CBC6
	for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 03:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768016317; cv=none; b=a0S/+GT40ktEpX7RQaeeulDipITRqXhcNvx4q0SFWsxnTeoXsWNMh5oIyW17M2dMvKbceov603DKAPDGqcUryhzZDAeN9pTQWalruKuiHQy144h3rD+Tvm9YcNDu3MiJA+yapE6Xy2MQruUl5jkZQHk6IJFx9oOnIkPs+wrwgjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768016317; c=relaxed/simple;
	bh=c5Wo/st2+sAGS/EFOFCnLO9oT0KKZTnx/lM3SuLi8is=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H6WJBOv1TP6zLsmfNiP0LpztglFsm/tfnFcUoBA8x5GvEb3svhw+OfPd3FsZcDsBSeUBIMZMcV9zw58Sfe+CAjivOICE/eQ8OyzUXITsXLshwDkv4tI76/P932CRHGAG8ZtzVWssHanMIqeS7mPgw3wGYVcSDjLW/t1CCdIoTDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SVKRUx7n; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768016313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OZBYECfPSQ3dr8bx6aRQm1r3SvRlxssMGEF9FguxNIY=;
	b=SVKRUx7nETtnWTvD+gmO64MnCZU8huySbw6mZlRazRAfivAPblmvc4UXmYk/xmVqKNJ7PV
	x5Gnc9UMd9wQNt97pALvqZLSMG+MDCzXO+NIPeLcYHEzgg/IUd0QdDYK2b2nDH+89DiWHo
	I0nwyEp7mYCtn8+xLtxjM9jEthaug1Q=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, jiang.biao@linux.dev,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Subject:
 Re: [PATCH bpf-next v8 05/11] bpf: support fsession for bpf_session_cookie
Date: Sat, 10 Jan 2026 11:38:11 +0800
Message-ID: <2401703.ElGaqSPkdT@7950hx>
In-Reply-To:
 <CAADnVQJtyGS5BQKcnzsqRNEDO7Kcs_89k6Q5tBi10iaff=tbtQ@mail.gmail.com>
References:
 <20260108022450.88086-1-dongml2@chinatelecom.cn>
 <20260108022450.88086-6-dongml2@chinatelecom.cn>
 <CAADnVQJtyGS5BQKcnzsqRNEDO7Kcs_89k6Q5tBi10iaff=tbtQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/1/10 10:42, Alexei Starovoitov wrote:
> On Wed, Jan 7, 2026 at 6:26=E2=80=AFPM Menglong Dong <menglong8.dong@gmai=
l.com> wrote:
> >
> >
> > +u64 *bpf_fsession_cookie(void *ctx)
> > +{
> > +       /* This helper call is inlined by verifier. */
> > +       u64 off =3D (((u64 *)ctx)[-1] >> BPF_TRAMP_M_COOKIE) & 0xFF;
> > +
> > +       return &((u64 *)ctx)[-off];
> > +}
>=20
> Same question... this can be a comment.
> For some of the helpers earlier we kept C functions to make
> things work on architectures where JIT is not available,
> but kfuncs require JIT, so for kfuncs there is no fallback necessary.

Yeah, it make sense.

>=20
>=20





