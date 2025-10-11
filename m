Return-Path: <bpf+bounces-70781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6024DBCF7C9
	for <lists+bpf@lfdr.de>; Sat, 11 Oct 2025 17:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D63684E4925
	for <lists+bpf@lfdr.de>; Sat, 11 Oct 2025 15:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E66727CCF2;
	Sat, 11 Oct 2025 15:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a87k1XjB"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8D225394C
	for <bpf@vger.kernel.org>; Sat, 11 Oct 2025 15:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760195397; cv=none; b=N1ln/zZ0Xoxl/uYjaMmYwJ+UjO75fV4dDEt+4iCHgNLWtrvW/tTGT0th1HJ99E6W7g5Tm1vrKaWIV3sI3X38j8ZlhfJO8mtPxTxZdGl4utK+iNLrYh+v8t2OYf0Jjt9L6XiHzhWn114Rjr2ButkkygdLkWyxvhfU/d26zRVQiIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760195397; c=relaxed/simple;
	bh=B9H6A8H7sBLSRT0XPrP4eKlzyZjEL7QhCJoTByvxMfQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HPCqYepjBOtZj5V4ROkxpsiaOX9r4FmQZLTfrVo00vXiuJ2DrLr6R3x4RJpUpoX8OfhDpFF4YomeFak66Cz8M2s2EstAXrQqfANuw1ozpzbFKlk6cJvfSidJGLZdQjHq52VLq05ydxhjlZ49nRlsyYGBXWqqOSrTsQcUKBn4SdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a87k1XjB; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2cf1e3614241abf51a0db5ac435b2f673895a607.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760195393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B9H6A8H7sBLSRT0XPrP4eKlzyZjEL7QhCJoTByvxMfQ=;
	b=a87k1XjBGpn98bcxHAjARTXzdyuS1CxB59y+TnyAq5tHaWuVf5qJ0gxjULzvWRLveRPHAd
	wWGHCG2lcDFKtbRld99KktELa/6qNbXZCzWwG/zRnulpaqDNBAaCxAeL9oB3VmXkt4vGqF
	a613lZKu3PTItMS4x35bZ4lO0Srlumc=
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Add test for unpinning htab
 with internal timer struct
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: KaFai Wan <kafai.wan@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Shuah Khan <shuah@kernel.org>, Toke
 =?ISO-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>, LKML
 <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, "open
 list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Date: Sat, 11 Oct 2025 23:09:40 +0800
In-Reply-To: <CAADnVQJL0FuK1oodJrLOFrtEFyVbYV1PP9S5VZm-_imztkocgg@mail.gmail.com>
References: <20251008102628.808045-1-kafai.wan@linux.dev>
	 <20251008102628.808045-3-kafai.wan@linux.dev>
	 <CAADnVQJL0FuK1oodJrLOFrtEFyVbYV1PP9S5VZm-_imztkocgg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

On Fri, 2025-10-10 at 10:28 -0700, Alexei Starovoitov wrote:
> On Wed, Oct 8, 2025 at 3:27=E2=80=AFAM KaFai Wan <kafai.wan@linux.dev> wr=
ote:
> >=20
> > Add test to verify that unpinning hash tables containing internal timer
> > structures does not trigger context warnings.
> >=20
> > Each subtest (timer_prealloc and timer_no_prealloc) can trigger the
> > context warning when unpinning, but the warning cannot be triggered
> > twice within a short time interval (a HZ), which is expected behavior.
>=20
> It was difficult to decipher the above paragraph.
> I think you're referring to throttling logic in __might_resched().
>=20
> I kept it as-is while applying, but in the future either skip
> such low level implementation detail or expand it.
> Here you could have said that the error is printed by __might_resched()
> which prints it once a HZ.

OK, I understand. Thanks for your feedback and guidance.

--=20
Thanks,
KaFai

