Return-Path: <bpf+bounces-78829-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C97D1C411
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 04:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5EBA3042FD4
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 03:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA8F2FF661;
	Wed, 14 Jan 2026 03:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RctGruig"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A72431355E
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 03:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768361289; cv=none; b=Vb9I/DuSUtgvh0hp14oT0zsw/qd2lQ/gOrIAFtS8+FIhnVC5/jE16xh33uoe0LSZA+Z2jy/ixBa924riZchxqmKaXNJb1CiEuQzlDu35QybDZenIFIgtqm5DljB5tQTETRLX/QHhJsfwXAoZGOPBol80afZIB0yYRsaNKZy+27Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768361289; c=relaxed/simple;
	bh=O9f4C5zUOMjRSe4jnAbx0T/yF7HgptKMwhUuZnIamCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BXmJukimESzg5g7mR20ZcNZHT6dXLvifa39gX4J/9wnUqGz+pCy5nH2TIBSBNT33h7auzd67bjYfUOiqGW4yXyHi1P3KqQvDP1ukfsSyYr6JFFgndX1JW3+MjozofQc5awhqzI1mR4WnxOka8nfXClhl48IKflQMd/YqXm6z+5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RctGruig; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768361285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ycFLTAEQ8/ZiU5uZC5zCeWJAtwNZMqltXXzh3a9aomU=;
	b=RctGruignyn9XNVgpXcREL1KELzps6fBRYIfEchY1V4VUiYu8WJd2T2TNogr5qaKkC8umI
	9A77yw2NzhrZMnUsY3NmkCUpTbcDz8faM6dvTL335FYDnTSVs9/mIh8GG+wJRFvf07t/Xa
	1Q1OdBu8lXO2i+elBursZ9exlPxiGls=
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
Subject: Re: [PATCH bpf-next v9 08/11] libbpf: add fsession support
Date: Wed, 14 Jan 2026 11:27:47 +0800
Message-ID: <3359527.AJdgDx1Vlc@7940hx>
In-Reply-To:
 <CAEf4BzY0s2fe_Xq4MC2PiQaiYZPic=O0mfMaoF5HW-gDnuMQhA@mail.gmail.com>
References:
 <20260110141115.537055-1-dongml2@chinatelecom.cn>
 <20260110141115.537055-9-dongml2@chinatelecom.cn>
 <CAEf4BzY0s2fe_Xq4MC2PiQaiYZPic=O0mfMaoF5HW-gDnuMQhA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/1/14 09:24 Andrii Nakryiko <andrii.nakryiko@gmail.com> write:
> On Sat, Jan 10, 2026 at 6:12=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > Add BPF_TRACE_FSESSION to libbpf and bpftool.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> > v5:
> > - remove the handling of BPF_TRACE_SESSION in legacy fallback path for
> >   BPF_RAW_TRACEPOINT_OPEN
> > - use fsession terminology consistently
> > ---
> >  tools/bpf/bpftool/common.c | 1 +
>=20
> I know it's a trivial change, but we don't normally mix libbpf and
> bpftool changes, can you split it into a separate patch?

ACK.

Thanks!
Menglong Dong

>=20
> >  tools/lib/bpf/bpf.c        | 1 +
> >  tools/lib/bpf/libbpf.c     | 3 +++
> >  3 files changed, 5 insertions(+)
>=20
> [...]
>=20





