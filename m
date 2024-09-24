Return-Path: <bpf+bounces-40265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4A4984A26
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 19:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D794B1F23FF8
	for <lists+bpf@lfdr.de>; Tue, 24 Sep 2024 17:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BAE1AB6D9;
	Tue, 24 Sep 2024 17:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="WNOPLd9C"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52423612D
	for <bpf@vger.kernel.org>; Tue, 24 Sep 2024 17:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727197935; cv=none; b=qJrCHERAbdLPQFgunPAynBoNxNFE7NRzUBYEAyD6Gy2te8O/tu+j9cWkka9Dp/35W0HWsqyRkwQhN4lbDzoWwLWQqptDhKeHH1NX9mh2DnsuUKPqfa6PLv+nYPpFITWpRFut78cVwvuEzNPQpCNL8ucFiD+0jj7RO7YCarP4pic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727197935; c=relaxed/simple;
	bh=ixEiXE15kc9yzKOEv09IZEg7tqUTTTkuwzUAkMDGYHU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ty2YnqDhoenHG05QjIw6+lXGSwm8jazgsw8HxRczLKcR3cFmP2GlNhJNPO9UCKA8YdpsoamYySMeTO9+HUDQVhXMynQm85HhA32vG+XDColXwu6i7M0+mZuzHXvJZXlBpt0zarTJOQtdwWRvE3DEia+e9064B0uSPF38ziwIIaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=WNOPLd9C; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1727197925; x=1727457125;
	bh=ixEiXE15kc9yzKOEv09IZEg7tqUTTTkuwzUAkMDGYHU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=WNOPLd9C4x5qdzV8ddsgNLzp0wfnoo+0I3O8rbI83EuEXT8Hufg9Bv4kQG8XM0G2N
	 1UXky3eT69MmceXuYsFZy67DX4oJHeGaziDzjo8fHBBsTrQBdUGC/gNFkybqKajxzT
	 kGpdJosIcSQ+iZpXQer/Wf7X29Pj+c8v4MdFrkPTUL/gTEuasjzuigS1YCmVOe2ptp
	 BqbVlAErm8bYc4U4tM5lQVxMhfhXJASHWpblJXD3FoSIiZWosgjObl/khQIvx4qoYx
	 sXgEVJKke2sSELyGuzbA3m/OydsY5HrdyUcosJ+1ZFWApBoGghLqXCeb56sgM+of5p
	 c5w+XiQe1N6hA==
Date: Tue, 24 Sep 2024 17:11:59 +0000
To: Jiri Olsa <jolsa@kernel.org>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: Fix uprobe consumer test
Message-ID: <mcu1nzbyupNb3g3xtiADIASk9rXXU9byY0AdPoPKORTW0GhBKfokwurO3TMu4pjen7ikKaGch9-dxzk5ntbmtMQWRMczotlJNyi0IriF9Ag=@pm.me>
In-Reply-To: <20240924110731.2644249-1-jolsa@kernel.org>
References: <20240924110731.2644249-1-jolsa@kernel.org>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: c652e5e7fb7452b4f8f00e68610fad4ce0d31366
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tuesday, September 24th, 2024 at 4:07 AM, Jiri Olsa <jolsa@kernel.org> w=
rote:

>=20
>=20
> With newly merged code the uprobe behaviour is slightly different
> and affects uprobe consumer test.
>=20
> We no longer need to check if the uprobe object is still preserved
> after removing last uretprobe, because it stays as long as there's
> pending/installed uretprobe instance.
>=20
> This allows to run uretprobe consumers registered 'after' uprobe was
> hit even if previous uretprobe got unregistered before being hit.
>=20
> The uprobe object will be now removed after the last uprobe ref is
> released and in such case it's held by ri->uprobe (return instance)
>=20
> which is released after the uretprobe is hit.
>=20
> Reported-by: Ihor Solodrai ihor.solodrai@pm.me
>=20
> Closes: https://lore.kernel.org/bpf/w6U8Z9fdhjnkSp2UaFaV1fGqJXvfLEtDKEUyG=
DkwmoruDJ_AgF_c0FFhrkeKW18OqiP-05s9yDKiT6X-Ns-avN_ABf0dcUkXqbSJN1TQSXo=3D@p=
m.me/
> Signed-off-by: Jiri Olsa jolsa@kernel.org
>=20
> ---
> .../testing/selftests/bpf/prog_tests/uprobe_multi_test.c | 9 +--------
> 1 file changed, 1 insertion(+), 8 deletions(-)
>=20
> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b=
/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> index 844f6fc8487b..c1ac813ff9ba 100644
> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
> @@ -869,21 +869,14 @@ static void consumer_test(struct uprobe_multi_consu=
mers skel,
> fmt =3D "prog 0/1: uprobe";
> } else {
> /
> - * uprobe return is tricky ;-)
> - *
> * to trigger uretprobe consumer, the uretprobe needs to be installed,
> * which means one of the 'return' uprobes was alive when probe was hit:
> *
> * idxs: 2/3 uprobe return in 'installed' mask
> - *
> - * in addition if 'after' state removes everything that was installed in
> - * 'before' state, then uprobe kernel object goes away and return uprobe
> - * is not installed and we won't hit it even if it's in 'after' state.
> /
> unsigned long had_uretprobes =3D before & 0b1100; / is uretprobe installe=
d /
> - unsigned long probe_preserved =3D before & after; / did uprobe go away =
*/
>=20
> - if (had_uretprobes && probe_preserved && test_bit(idx, after))
> + if (had_uretprobes && test_bit(idx, after))
> val++;
> fmt =3D "idx 2/3: uretprobe";
> }
> --
> 2.46.0

Hi Jiri,

I tested this change on top of bpf-next/master, and
selftests/bpf/vmtest.sh passes.

Thank you for the fix!

Tested-by: Ihor Solodrai <ihor.solodrai@pm.me>


