Return-Path: <bpf+bounces-79371-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5CCD38E04
	for <lists+bpf@lfdr.de>; Sat, 17 Jan 2026 12:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7A21530089A7
	for <lists+bpf@lfdr.de>; Sat, 17 Jan 2026 11:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8C53128AE;
	Sat, 17 Jan 2026 11:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SRR64DZL"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6C130F924
	for <bpf@vger.kernel.org>; Sat, 17 Jan 2026 11:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768648147; cv=none; b=f1N8MWqWrKztxib2CgH9dIM1ZzGlYZ4X78/YuW8+LdYE7Fm6TuThrl/J9QRa0Sw0HJ1ghiOhgnsXXBUJSTkX2HD6tCdEshQyuUTs1/xCayyPs31rinGl7Ekm6QPTpU8ngcnVqHPfutPY3hAmGIcXBcUul/0P4C7azagCdmd3lrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768648147; c=relaxed/simple;
	bh=uo1UIQxLdc/NrblW6iOWeC3gVSUSveliTSrHuYDE53A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p8TRW6P/vxXpTHQlXuzPNkO21spdqpMmeScBn16qHW9upbEWYNRS7ZrnpmyXQeahdbidTsAdjSsJ/6LnCzWtxm12vDCiD5pUSWNHEvsaLVZ8cT+kRMkFr9713vymE/Uwj++qHeH9I0UIQLt4LxK9wSEtf7r31GD2HYIle06I0fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SRR64DZL; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768648133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uo1UIQxLdc/NrblW6iOWeC3gVSUSveliTSrHuYDE53A=;
	b=SRR64DZLRbdWBRaNmESfQCRQhoCg8QoKZC+w74e8LvAvrj19MEoxEYq0zofdghYDq3wSau
	bSw7Wwajdhu66cpuuAS18dMUFeDuvzUMmUSfEF+81iDcyakF8k9ZHNXYBQubqKYBUT/BIW
	cVskkIuaW2jU9TyCL7RxcqlvKyCaB9g=
From: Menglong Dong <menglong.dong@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Qiliang Yuan <realwujing@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>,
 Hao Luo <haoluo@google.com>, John Fastabend <john.fastabend@gmail.com>,
 Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, wujing <realwujing@qq.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, yuanql9@chinatelecom.cn
Subject:
 Re: [PATCH v2] bpf/verifier: implement slab cache for verifier state list
Date: Sat, 17 Jan 2026 19:08:35 +0800
Message-ID: <10870214.nUPlyArG6x@7950hx>
In-Reply-To:
 <CAADnVQKNp8FEdiLfTSs-o+HKE4bArj82R78uQZKJkGfDvWZxHA@mail.gmail.com>
References:
 <14011562.uLZWGnKmhe@7950hx> <20260117032612.10008-1-yuanql9@chinatelecom.cn>
 <CAADnVQKNp8FEdiLfTSs-o+HKE4bArj82R78uQZKJkGfDvWZxHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2026/1/17 14:24, Alexei Starovoitov wrote:
> On Fri, Jan 16, 2026 at 7:26=E2=80=AFPM Qiliang Yuan <realwujing@gmail.co=
m> wrote:
> >
> > >
> > > This patch is a little mess. First, don't send a new version by reply=
ing to
> > > your previous version.
> >
> > Hi Menglong,
> >
> > Congratulations on obtaining your @linux.dev email! It is great to see =
your
> > contribution to the community being recognized.
>=20
> It is definitely recognized. Menglong is doing great work.

Haha, glad to hear it, thanks ;)

>=20





