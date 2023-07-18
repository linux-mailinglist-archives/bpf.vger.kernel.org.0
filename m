Return-Path: <bpf+bounces-5172-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EA37581AA
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 18:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6581B1C20D67
	for <lists+bpf@lfdr.de>; Tue, 18 Jul 2023 16:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0305B134D3;
	Tue, 18 Jul 2023 16:06:36 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAB410952
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 16:06:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B576C433C7;
	Tue, 18 Jul 2023 16:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689696393;
	bh=EOkdjFMWH7brfMl6FFZE0qz5Gq2zAqO7jP+yRL3OVlU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qIb3AHg2MbxQcaCcnDObe7IyWQP9EULqWkf332wERinXUyRdCHH/qCNeIigrp5Ycw
	 ydaIfRizs/INJy0ZXVU/+UZxqXbZ1IndtS1QbbNupQjXFCMOZ7s9GtI5Lx1NiLYhed
	 N/TXvdwYWv4fstA72glvLH0cz5taXu9s65LrpLU7ltohhuRGO22kZCO1NSDiaci9Yc
	 TJl7yenY0O0Vr33FHbShSyg4HHSBhu5lDXZoQp2aT3kvY61gJajckRsCIyRPO8GqYb
	 736uydTpvyC9e+RNDJoH0F4C0bAE+h387TX3d2LR2rVDoFVrDCpdJmKatD4hvVsZ17
	 nWLnw8l6c1maQ==
Date: Tue, 18 Jul 2023 09:06:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Rosenberg <drosen@google.com>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John
 Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Joanne Koong <joannelkoong@gmail.com>, Mykola Lysenko
 <mykolal@fb.com>, LKML <linux-kernel@vger.kernel.org>, "open list:KERNEL
 SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Android Kernel Team
 <kernel-team@android.com>
Subject: Re: [PATCH v2 1/3] bpf: Allow NULL buffers in bpf_dynptr_slice(_rw)
Message-ID: <20230718090632.4590bae3@kernel.org>
In-Reply-To: <CAADnVQJEEF=nqxo6jHKK=Tn3M_NVXHQjhY=_sry=tE8X4ss25A@mail.gmail.com>
References: <20230502005218.3627530-1-drosen@google.com>
	<20230718082615.08448806@kernel.org>
	<CAADnVQJEEF=nqxo6jHKK=Tn3M_NVXHQjhY=_sry=tE8X4ss25A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Jul 2023 08:52:55 -0700 Alexei Starovoitov wrote:
> On Tue, Jul 18, 2023 at 8:26=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> > On Mon,  1 May 2023 17:52:16 -0700 Daniel Rosenberg wrote: =20
> > > --- a/include/linux/skbuff.h
> > > +++ b/include/linux/skbuff.h
> > > @@ -4033,7 +4033,7 @@ __skb_header_pointer(const struct sk_buff *skb,=
 int offset, int len,
> > >       if (likely(hlen - offset >=3D len))
> > >               return (void *)data + offset;
> > >
> > > -     if (!skb || unlikely(skb_copy_bits(skb, offset, buffer, len) < =
0))
> > > +     if (!skb || !buffer || unlikely(skb_copy_bits(skb, offset, buff=
er, len) < 0))
> > >               return NULL; =20
> >
> > First off - please make sure you CC netdev on changes to networking!
> >
> > Please do not add stupid error checks to core code for BPF safety.
> > Wrap the call if you can't guarantee that value is sane, this is
> > a very bad precedent. =20
>=20
> This is NOT for safety. You misread the code.

Doesn't matter, safety or optionality. skb_header_pointer() is used=20
on the fast paths of the networking stack, adding heavy handed input
validation to it is not okay. No sane code should be passing NULL
buffer to skb_header_pointer(). Please move the NULL check to the BPF
code so the rest of the networking stack does not have to pay the cost.

This should be common sense. If one caller is doing something..
"special" the extra code should live in the caller, not the callee.
That's basic code hygiene.

