Return-Path: <bpf+bounces-74130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BDEC4B4AF
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 04:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A0E7834B5B4
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 03:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3151F3446DF;
	Tue, 11 Nov 2025 03:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h2cHmdpY"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1E5314B77
	for <bpf@vger.kernel.org>; Tue, 11 Nov 2025 03:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762831103; cv=none; b=V65qMEcBilGsFPIqh4+8e7S66eiUmqhackidYAVshEj/H4RVfoQyu/BbaWqY9tpAYnrgwR/48TzXUYeLmBmyuNuVhia4EpczxMAgEu9DqMsawvlMHdVNDZL96TYThM6IcaSTJV3vBHLOmU3CEbFLniCg3GxKj8EBCvmEjHNGI90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762831103; c=relaxed/simple;
	bh=pCXkJegjuRcItgOkKeQjVBrasAklm08f730oR1mmvoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VF7agVwuOdfFKnYTBF06rkWowg0TkxeDk4zmiHSpWMzMtKZe6hcE2q3UELsyRkOESxPY0NL+SKmCYrBfLzv3seqEIj+Bm6yEyOQHl9jesJ8w3LFo0AKtSOfWBaeXHUll6uaU5szit8a9Oj+1eSI26GwfMC96481FV7z4cvAxysY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h2cHmdpY; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762831100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ho3VRKU3eH3eGL2Jbykm8Aw0VkpNiJyYt4cL5izQMs4=;
	b=h2cHmdpYo9lnYmkJDxQErlRaEHTGVwPYKTV1a/tE3JPoz+r4zzxj4HFS/UFrlUM/XhZ4pg
	fFBCXi0JO5PkR4rHHn33LKygrlNZxVQNaMXOZnQq4LzJWcWwSjc2OwZrSBOQS09QnP46MW
	K7My15UwrrCtOGa9xNOiLP/YHSpK6Ww=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>, Song Liu <song@kernel.org>
Cc: ast@kernel.org, song@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, yonghong.song@linux.dev, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, jiang.biao@linux.dev,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH bpf] bpf: handle the return of ftrace_set_filter_ip in
 register_fentry
Date: Tue, 11 Nov 2025 11:17:55 +0800
Message-ID: <2243551.irdbgypaU6@7950hx>
In-Reply-To: <2806193.mvXUDI8C0e@7950hx>
References:
 <20251110120705.1553694-1-dongml2@chinatelecom.cn>
 <CAHzjS_vj26p7SwVupAb0XyTZs__NProJ+CN6DKy+-E1R+Wk33Q@mail.gmail.com>
 <2806193.mvXUDI8C0e@7950hx>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/11/11 08:59, Menglong Dong wrote:
> On 2025/11/10 23:49, Song Liu wrote:
> > On Mon, Nov 10, 2025 at 4:07=E2=80=AFAM Menglong Dong <menglong8.dong@g=
mail.com> wrote:
> > >
> > > The error that returned by ftrace_set_filter_ip() in register_fentry(=
) is
> > > not handled properly. Just fix it.
> > >
> > > Fixes: 00963a2e75a8 ("bpf: Support bpf_trampoline on functions with I=
PMODIFY (e.g. livepatch)")
> > > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > > ---
> > >  kernel/bpf/trampoline.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > LGTM. Thanks for the fix!
> >=20
> > Acked-by: Song Liu <song@kernel.org>
> >=20
> > Can we add a test for this code path?
>=20
> I think it can be done by attach a fentry to a notrace function and
> check the error number.

Hmm...it's a little difficult to trigger this problem, as attaching a
notrace function won't go to this code patch ;|

>=20
> Let me have a try.
>=20
> >=20
> > Song
> >=20
> >=20
>=20
>=20
>=20
>=20
>=20
>=20





