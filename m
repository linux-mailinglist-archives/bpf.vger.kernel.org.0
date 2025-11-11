Return-Path: <bpf+bounces-74115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C29EEC4A1A5
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 02:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20BBF3AD442
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 00:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDF42586C8;
	Tue, 11 Nov 2025 00:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CcYNdGr/"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1CD4C97
	for <bpf@vger.kernel.org>; Tue, 11 Nov 2025 00:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762822768; cv=none; b=DVcQ1yt/cHzztiGiMGVTkfNlxedS53y838IQ64L6/ToNdf5wwfgbB5+nNm4pXIeRD3T1JmBayf24zvjNovWiHtLHKQCa0uNn/HeJmZZvJZZ2GOOYr2wgQVvbnQr3xehVZ9uVvrVwJuKK8KmIBPYHocpeEhM5mEUK5QaEc1LfYJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762822768; c=relaxed/simple;
	bh=lH4MtGKoPnrI1sXdA0bQ14rxZPD3TPNVJddPSUsj7jA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZtSY3+4wJ6w5kBiKWiXSGZE2bxLIzRipEuWV2G6/DqlbjPMc7cnkQAtRZuwoizk89oqmeMbDRVDUk5/ICqC5kwxR6M14+bLS2gEBRJhvcIDBe05mSztp+sQXpPsp2kGJwn2bsi2exHn/yjNDVdhsVyKBeKixfjEUTiHetZHXT+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CcYNdGr/; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762822763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p0LiTT3vfQ1evUTRc258iJ2UQXRFMLtdgeURzgP5nP4=;
	b=CcYNdGr/ZQ2ALgZjdu15qzCjLR8NjvhzT96eXM6jCEx200Zavj3FCjETGxQd76L3wKXX8L
	tqqKp3sP1gp09ZzxqYmgQmNILXrgtuvcPnqgZEEfFDOXMpmJYzMSvKWfcf6w27r9h74GcG
	EdwsheoLi61WtK9JOsfXW+6Tvg9dXq0=
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
Date: Tue, 11 Nov 2025 08:59:10 +0800
Message-ID: <2806193.mvXUDI8C0e@7950hx>
In-Reply-To:
 <CAHzjS_vj26p7SwVupAb0XyTZs__NProJ+CN6DKy+-E1R+Wk33Q@mail.gmail.com>
References:
 <20251110120705.1553694-1-dongml2@chinatelecom.cn>
 <CAHzjS_vj26p7SwVupAb0XyTZs__NProJ+CN6DKy+-E1R+Wk33Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/11/10 23:49, Song Liu wrote:
> On Mon, Nov 10, 2025 at 4:07=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > The error that returned by ftrace_set_filter_ip() in register_fentry() =
is
> > not handled properly. Just fix it.
> >
> > Fixes: 00963a2e75a8 ("bpf: Support bpf_trampoline on functions with IPM=
ODIFY (e.g. livepatch)")
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> >  kernel/bpf/trampoline.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> LGTM. Thanks for the fix!
>=20
> Acked-by: Song Liu <song@kernel.org>
>=20
> Can we add a test for this code path?

I think it can be done by attach a fentry to a notrace function and
check the error number.

Let me have a try.

>=20
> Song
>=20
>=20





