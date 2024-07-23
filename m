Return-Path: <bpf+bounces-35420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC25693A800
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 22:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 619002829E4
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 20:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E14142900;
	Tue, 23 Jul 2024 20:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="XvbXgRl/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5378D13D60F
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 20:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721765485; cv=none; b=YoaG4fyA5r4GxQ03rTjWlfwwxSX++CJBabmWbCho25PoJzgmlyu+Pu92tCx3FI9/fRA36mgpnphG/zp3Rw8tdY/5lW9fBr4ldlBBYtDeT25xghBYsMQ7QMISTj60PdstT4eXaAojTiVVof8PQuRqsSWrMTSQTuBRaxo1bxspFRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721765485; c=relaxed/simple;
	bh=yuVLOtHpH97l9EDhCTJ94kFj+f3VcI67IkcQ1UIEARU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZguzKTzDbFAACJu2EIgmC7QqMmVJYgktsOXtFxI2AqWOqVqfAvJw4t65nu5A9yN3sWxceKy+G7pb771Jse8w9pGpnJp1hNRwbL1u321DyghqvaA2xVoqyxJ7HXcSg+NWatKFl7MRl7gUe4uU5+IrAyWmr36ROeQLnpWADZl+680=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=XvbXgRl/; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1721765481; x=1722024681;
	bh=yuVLOtHpH97l9EDhCTJ94kFj+f3VcI67IkcQ1UIEARU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=XvbXgRl/xckbBKORLsApgfX5qYKXdBo2x3bSlkeRlx92GNFPKuccEoTWpEwXtryCV
	 Z1KktmDlcYROJNnQbL7BrxUI0APVpgr7LFQghaSKaVmykKTKt7bdjo+jDFYMy3x9Yh
	 /WbRK8FaGMXMxK8L+gkm4pQYKscWMEvJbYRksXSRsHQlH74YfZ3Sk/rRbjjwa53gWU
	 /pZosyD+oK5CxyqvY7+9HsGiaupWGkirGxwKU21pO/LhwXaNZWIsONLrN1FMxMgooW
	 4CjbOikZbibMD5Ad8UeC3lp0k5IwN9OufB2Y9fp2ORATEAlDJao9ldFeCzZCnm0Z89
	 A4inJ8papENYA==
Date: Tue, 23 Jul 2024 20:11:12 +0000
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, patchwork-bot+netdevbpf@kernel.org, bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Mykola Lysenko <mykolal@fb.com>
Subject: Re: [PATCH bpf-next v4] selftests/bpf: use auto-dependencies for test objects
Message-ID: <ieRPXUbPxZOI2ejlD1pRvSOAb5QfDaopRdpOIrBZ5S772KT0JWTT2nW7Z_f_MZxGq4LLbEwe10sK89V2l4jPzxKKGntYt_2_UF4ecfiw0VA=@pm.me>
In-Reply-To: <CAEf4BzaN7b6N3Qb_hrb-Abq=gbB=fSHho-nx+H3MSvpARXQoWg@mail.gmail.com>
References: <VJihUTnvtwEgv_mOnpfy7EgD9D2MPNoHO-MlANeLIzLJPGhDeyOuGKIYyKgk0O6KPjfM-MuhtvPwZcngN8WFqbTnTRyCSMc2aMZ1ODm1T_g=@pm.me> <172141323037.13293.5496223993427449959.git-patchwork-notify@kernel.org> <CAADnVQ+F6JKp1e61NC22wt8L9YEVAz9w648GvdV8hUrM3dkDFA@mail.gmail.com> <24a6649743528b2c8f44cc5415df32a3020b0951.camel@gmail.com> <oNTIdax7aWGJdEgabzTqHzF4r-WTERrV1e1cNaPQMp-UhYUQpozXqkbuAlLBulczr6I99-jM5x3dxv56JJowaYBkm765R9Aa9kyrVuCl_kA=@pm.me> <FnnOUuDMmf0SebqA1bb0fQIW4vguOZ-VcAlPnPMnmT2lJYxMMxFAhcgh77px8MsPS5Fr01I0YQxLJClEJTFWHdpaTBVSQhlmsVTcEsNQbV4=@pm.me> <CAEf4BzaN7b6N3Qb_hrb-Abq=gbB=fSHho-nx+H3MSvpARXQoWg@mail.gmail.com>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 79c25407018b71a51f4da1584bbf0e5edf3b48ff
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tuesday, July 23rd, 2024 at 1:02 PM, Andrii Nakryiko <andrii.nakryiko@gm=
ail.com> wrote:

[...]
> >=20
> > I can send this fix together with the condition for the clean targets
> > (so [1] can be discarded); or I can submit a separate change. Let me
> > know what you'd prefer.
>=20
>=20
> Send it separately, if that fix is good, I'll just apply it as is?

Ok. Yes, you can apply the "if clean" patch as is.


