Return-Path: <bpf+bounces-48568-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2222DA0968B
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 16:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E62A3A95EC
	for <lists+bpf@lfdr.de>; Fri, 10 Jan 2025 15:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8CA211A2D;
	Fri, 10 Jan 2025 15:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="YVOQPekY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06FB20A5FB;
	Fri, 10 Jan 2025 15:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736524690; cv=none; b=me01+JEJYxqKtW8DaXhOpT25/IL6gpfwwEu77uQXpmdf+6c4roCShEtmQGga02WnE6B8+2OHKHylefu2KIOeO5nh2qKMgUrJ+5tp3ldVhZYjKgNy75CePEEbGGSbVt13VyCrHpa2wgrL6ZgXvFrYIqrBxuLf5noM1t9u0C6mA2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736524690; c=relaxed/simple;
	bh=3cEKb1NvFZs1snxhw4WugIAM/8gqIYeDV8Lh3OPcAlc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V1PIBs1nUlspXsmx3MeNwocFk2FskE91IRVVk+ZqhcO8yngNPt8ggC8tT5iRd/ZWjfEyyN5/yB2m3lz/Hj9vMN1xAM58x+xX+gc1Fy10u6rTuOe0HuIlGO8AKkz5/zmFN1PXKr/hzdRlwg7nAD1uCS10MKTZoEXRonF7K9e6/NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=YVOQPekY; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1736524686; x=1736783886;
	bh=3cEKb1NvFZs1snxhw4WugIAM/8gqIYeDV8Lh3OPcAlc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=YVOQPekYmu1xxhcrAd67A9x1c4x7co3B/RI0O/vKuBY13OEnAtaQ2grbGFE+Sz4W3
	 K8AURfVdSIcRGe+blU0+os2ASNdT30Ht+KNKCvJuXTsGYmk7yRnRCCfJltO/IgpF+N
	 P4C0+iZXaG5iBwiI/SEa19+bU7yJEsBeq9MStG1N3YJf163NkBxWHU4OkITDDtKEaw
	 8mAOn0pWhgukGqoI/HZMQ/62TUzl4j1no9lO97GD8vUJ8FUmYL2LlydwI61Rx52Zlh
	 GuAfvXqm914G6/xeenzigGnMemgxHpTxMVBljmaddMZd5DIcDQshRfodoFOdUoP3a4
	 S83AdxniMnkrw==
Date: Fri, 10 Jan 2025 15:58:00 +0000
To: andrii@kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, bpf@vger.kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, mykolal@fb.com, olsajiri@gmail.com
Subject: Re: [PATCH dwarves] btf_encoder: always initialize func_state to 0
Message-ID: <hUL5Ezb9xUJEqsK7bb5iftwkA6tM4b3eZ1uA_pusQ68pSzwUzRh4s2rh4pgiv_WxqlaeZ6BizW9CHBiWeodp_N1vOZmpJLvoKwHbWALMc2Y=@pm.me>
In-Reply-To: <Z4El7MpHaaj2YX32@x1>
References: <20250110023138.659519-1-ihor.solodrai@pm.me> <Z4El7MpHaaj2YX32@x1>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: fb5634f11962cf09b4785de4a8c0a29798c0fdb1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Friday, January 10th, 2025 at 5:51 AM, Arnaldo Carvalho de Melo <acme@ke=
rnel.org> wrote:

>=20
>=20
> On Fri, Jan 10, 2025 at 02:31:41AM +0000, Ihor Solodrai wrote:
>=20
> > BPF CI caught a segfault on aarch64 and s390x [1] after recent merges
> > into the master branch.
>=20
>=20
> In the past the libbpf github actions was tracking the tmp.master (it wou=
ld
> be better to track "next") branch and I was looking at when it passed to
> then move "next" to master, that would be great to have so that we
> wouldn't be having these bugs in the git history, avoiding force pushes.

libbpf CI is still tracking tmp.master:

https://github.com/libbpf/libbpf/actions/runs/12696027660/job/35389206487

However it only runs once a day. BPF CI runs more frequently due to the
volume of incoming patches. As of recently, BPF CI has been using "master".
Yesterday, when I saw the failures, I switched BPF CI to v1.28.

I think the right way to approach this is for libbpf/libbpf to track "next"=
,
and BPF CI use "master". Then, most importantly, only merge next into maste=
r
after libbpf CI has passed.

This can potentially be automated, but would require push access to the
pahole repo. Until then, a maintainer would need to manually check the
libbpf CI status here:

https://github.com/libbpf/libbpf/actions/workflows/test.yml

Another thing is that libbpf CI only tests x86_64 currently.
We could add aarch64 to libbpf, or migrate pahole staging job to
kernel-patches/vmtest (which is almost identical to BPF CI).

Andrii, what do you think?

>=20
> Anyhway, thanks for the fix, I'll add it and push it out.
>=20
> - Arnaldo
>=20
> > The segfault happened at free(func_state->annots) in
> > btf_encoder__delete_saved_funcs().
> >=20
> > func_state->annots arrived there uninitialized because after patch [2]
> > in some cases func_state may be allocated with a realloc, but was not
> > zeroed out.
> >=20
> > Fix this bug by always memset-ing a func_state to zero in
> > btf_encoder__alloc_func_state().
> >=20
> > [1] https://github.com/kernel-patches/bpf/actions/runs/12700574327
> > [2] https://lore.kernel.org/dwarves/20250109185950.653110-11-ihor.solod=
rai@pm.me/
> > ---
> > btf_encoder.c | 7 +++++--
> > 1 file changed, 5 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/btf_encoder.c b/btf_encoder.c
> > index 78efd70..511c1ea 100644
> > --- a/btf_encoder.c
> > +++ b/btf_encoder.c
> > @@ -1083,7 +1083,7 @@ static bool funcs__match(struct btf_encoder_func_=
state *s1,
> >=20
> > static struct btf_encoder_func_state *btf_encoder__alloc_func_state(str=
uct btf_encoder *encoder)
> > {
> > - struct btf_encoder_func_state *tmp;
> > + struct btf_encoder_func_state *state, *tmp;
> >=20
> > if (encoder->func_states.cnt >=3D encoder->func_states.cap) {
> >=20
> > @@ -1100,7 +1100,10 @@ static struct btf_encoder_func_state *btf_encode=
r__alloc_func_state(struct btf_e
> > encoder->func_states.array =3D tmp;
> > }
> >=20
> > - return &encoder->func_states.array[encoder->func_states.cnt++];
> > + state =3D &encoder->func_states.array[encoder->func_states.cnt++];
> > + memset(state, 0, sizeof(*state));
> > +
> > + return state;
> > }
> >=20
> > static int32_t btf_encoder__save_func(struct btf_encoder *encoder, stru=
ct function *fn, struct elf_function *func)
> > --
> > 2.47.1

