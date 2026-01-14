Return-Path: <bpf+bounces-78822-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AA6D1C29F
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 03:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7695C303EBB3
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 02:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C12320A1A;
	Wed, 14 Jan 2026 02:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="e0qLopXe"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E961731ED8F
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 02:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768358959; cv=none; b=a4LA7+eBTQ4pF724nin1Fpjkxyc0xmsU1NdQmJhhxA6E4ViRgSdW7K89JldMYlutXOfo8JksBYb6YARTutG4S3UajKabDpK4mpbnKLVeJUwDMCULcFN8XVTpNhalZ9z21Ufy/DbRmH3i0bm1KWZZMiaHOGMxbSNDm5p7Tej54J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768358959; c=relaxed/simple;
	bh=JMzOpBH/sHGya8kX1TuMF1RxLT5+wegAx6XPovDAt/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jDoSlidl5/nHbuYBbXNty+URMj44eL6M+tEALPIygarjYKlqovhDQSpLqaKWcUd5g9RWN204UrXnoo4TMpUxhOxaQHanClgmxb6tewqNpHrUuw8EVnABXFb+XBp4DnyH/ahA7ymF91whvrqYGyVaxkOYG4f6Z4s8Qv4Pz6XNYMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=e0qLopXe; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768358946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SHtwFTfck7NSYykC7WlGYK5asQZLLBXEjixifGG0u3A=;
	b=e0qLopXeDHVmqYNRUjTQOjTcTP9WgPvYTx1tu6GN7T8/7KERxTtP4LMGRwrUBnScjpATjF
	i9HpZoNNkdgKM2/82NxDFUGXtwuxHGXGXzKcnsZX5bdDdmqxuL9IA7ZqgdabtgLAkgm6Lo
	lzLPTLFs6qrEBi14AmUTescwS+4Vl+I=
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
 Re: [PATCH bpf-next v9 05/11] bpf: support fsession for bpf_session_cookie
Date: Wed, 14 Jan 2026 10:48:48 +0800
Message-ID: <1917811.atdPhlSkOF@7940hx>
In-Reply-To:
 <CAEf4BzbrYMSaM-EEwz4UhZr0BG4FDyxtaG16e4z10QhmAY8o=g@mail.gmail.com>
References:
 <20260110141115.537055-1-dongml2@chinatelecom.cn>
 <20260110141115.537055-6-dongml2@chinatelecom.cn>
 <CAEf4BzbrYMSaM-EEwz4UhZr0BG4FDyxtaG16e4z10QhmAY8o=g@mail.gmail.com>
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
> > Implement session cookie for fsession. In order to limit the stack usag=
e,
> > we make 4 as the maximum of the cookie count.
>=20
> This 4 is so random, tbh. Do we need to artificially limit it? Even if
> all BPF_MAX_TRAMP_LINKS =3D 38 where using session cookies, it would be
> 304 bytes. Not insignificant, but also not world-ending and IMO so
> unlikely that I wouldn't add extra limits at all.

I'll remove the limitation in the next version.

>=20
> >
> > The offset of the current cookie is stored in the
> > "(ctx[-1] >> BPF_TRAMP_M_COOKIE) & 0xFF". Therefore, we can get the
> > session cookie with ctx[-offset].
>=20
>=20
> ctx here is assumed u64 *, right? So offset is in 8-byte units? Can
> you clarify please?

Yes, ctx is u64 * and the offset is 8-byte units. I'll describe it
here.

>=20
> >
> > The stack will look like this:
> >
> >   return value  -> 8 bytes
> >   argN          -> 8 bytes
> >   ...
[...]
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 2640ec2157e1..a416050e0dd2 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1231,6 +1231,7 @@ enum {
> >
> >  #define BPF_TRAMP_M_NR_ARGS    0
> >  #define BPF_TRAMP_M_IS_RETURN  8
> > +#define BPF_TRAMP_M_COOKIE     9
>=20
> this is not wrong, but certainly weird. Why not make IS_RETURN to be
> the upper bit (63) and keep cookie as a proper second byte?

OK, I think it make sense, which can make the usage of the
func_meta more clear. So for the flag bit, we put it at the
high significant bit. And for the offset filed, we put it at the
low significant bit.

>=20
>=20
> (also I think all these should drop _M and have _SHIFT suffix)
>=20

Glad to hear some advice about the name. I'll use it.

>=20
> >






