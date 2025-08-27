Return-Path: <bpf+bounces-66637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C7CB37AE0
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 08:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4DC636276C
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 06:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2BC313E0D;
	Wed, 27 Aug 2025 06:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dCFVyUgy"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81443128B9
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 06:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756277694; cv=none; b=CpEj6RBQom+v3119f46IZkI9mLW3/S4tbA0chXolnP4UsuzsEmVIat4g53hqb5xOgdeB9nlg6/LZ4vVsXTBWv0BNqtS7SCGDMz09O4YcUcobPJ8l2xKLL+U+qHuyCizT15nfXre3saSj3sVED9sk2zEiv0aOUygRMIAQEEpZ0ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756277694; c=relaxed/simple;
	bh=skkMaqJJ+U3kGklh+BMpgZ/SHZGzQXad2rHRCM6J5RQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cjbsNTKJwFA7qEZhngYUvGT44b2Mp/Ab/qaJ37CrbRJCiChwbIP8BkzsZQEE7/L8zmVP/AMXWM9VSG5TQB7ZXdWVR0ezKSB63DA1gD4Aw9kPb7R4+1Hp7yEgff/5xaS9NIVBBRTji0mITNEooHQZ5h1nPARoeHYiAy6/IchvGoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dCFVyUgy; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756277678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=skkMaqJJ+U3kGklh+BMpgZ/SHZGzQXad2rHRCM6J5RQ=;
	b=dCFVyUgyh81T2anCnyTj3HBh4+W2MO8awED6tEyqwZtQkNrFE+npdx0pEcv80PpedYvjBZ
	FReaeZ0w8I/OMgVdpyvFRzsTtUMLbI9qiG0HoDLgOudSuOhwNK9Ha2uEAeKQSOXYMz1Vtk
	HZeRxL8KTmnz4ipOQ79uKkojEwvCQH0=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>, Jiri Olsa <olsajiri@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, shuah@kernel.org, yikai.lin@vivo.com,
 memxor@gmail.com, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH bpf-next v2 3/3] selftests/bpf: add benchmark testing for
 kprobe-multi-all
Date: Wed, 27 Aug 2025 14:54:29 +0800
Message-ID: <6338236.lOV4Wx5bFT@7940hx>
In-Reply-To: <aK4BiJduYDsw7e0m@krava>
References:
 <20250826080430.79043-1-dongml2@chinatelecom.cn>
 <20250826080430.79043-4-dongml2@chinatelecom.cn> <aK4BiJduYDsw7e0m@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025=E5=B9=B48=E6=9C=8827=E6=97=A5=E6=98=9F=E6=9C=9F=E4=B8=89 02:48 Jiri=
 Olsa <olsajiri@gmail.com> write:
> On Tue, Aug 26, 2025 at 04:04:30PM +0800, Menglong Dong wrote:
> > For now, the benchmark for kprobe-multi is single, which means there is
> > only 1 function is hooked during testing. Add the testing
> > "kprobe-multi-all", which will hook all the kernel functions during
> > the benchmark. And the "kretprobe-multi-all" is added too.
>=20
> hi,
> fyi this bench causes panic on my setup.. very silent, so not sure
> yet which function we should blacklist next, attaching my .config
>=20

Yeah, I can reproduce it easily with your config. Let me have a
debug on this problem.

Thanks!
Menglong Dong

> jirka
>=20




