Return-Path: <bpf+bounces-64463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF01B1321B
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 00:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05156174EC6
	for <lists+bpf@lfdr.de>; Sun, 27 Jul 2025 22:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455F61F2380;
	Sun, 27 Jul 2025 22:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrtZG2lr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6B09460
	for <bpf@vger.kernel.org>; Sun, 27 Jul 2025 22:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753653650; cv=none; b=fCpNbI3cPgqtc8kC+JShCXkvtv+tYnqVbSIL6X7DzZMP9AoiishnXOJDOTJIAMxi49LBZqBnd3V15RIR3rVzit719sWn5qDAkNeJ6lEIxzWeZZ5Dz8IxCx+w9L0B47qvLqVzNamHLJzSGJLxt9KBujZWS/RKRMZpfouJYxSbbfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753653650; c=relaxed/simple;
	bh=sXHfTAQeVZKlFEm/S4Bz6vmAHNjeR9/b4jJEijfLEQ8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oFI51G1BGrGpJX8d+k+fGvqVmDizZHbkdVJD1o82Q/lgAq1eAgaUoVTGzP7THB1NEgleBUZ/mL9TBgfPd2Z9eohFbIdl/B34QtlC/afscpJoyWbnxtJt5xWngNc4YFctf7F0SXKb57xavJgEflQJL8PdSRxqumniFBV+kQM+++A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PrtZG2lr; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b3226307787so3138978a12.1
        for <bpf@vger.kernel.org>; Sun, 27 Jul 2025 15:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753653649; x=1754258449; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T0m4o/sUJN2D4k/ZgURNFwu7FOvGQVUZpwGTxmQVunk=;
        b=PrtZG2lrX7zSX/UB4RFtrKkyCZjG2QPmRyXOyra6aDi+6pIghHqnkeFHkCICRQxsKD
         G0m0lInIFls9sID5cgmQ1+2ewF/mW9nVRnUWvQqA066AWgZyQ2e6BgBV8q7wZy97LVA/
         vEnI+Bn/gaqay7rg4bL3Jhw2JbjoJz0adUGO/rPNmivTEKFpu+YvjnZlpUWCn81OODHU
         l6llK8GzpOj2T5ElCNQ+jpg/DNGQCa4gwALQMGRHKtahXeLolHNnoe1IMGTvz0Ku4nVG
         fO315zG9vnoSGwb3oD1eZTYyMhUXEaxJ5eKIn2vH6Hs/TpfSgPubk6icw8zWmHalHof9
         jXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753653649; x=1754258449;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T0m4o/sUJN2D4k/ZgURNFwu7FOvGQVUZpwGTxmQVunk=;
        b=dEIFuj8iC3JTSLyJNaiMrrJhyt2wHHkzFqQ/W/rxWAe4zH0Vt+MsrA2n+Zz7REz+ie
         rUQpr9CymGyAB0E9PrPhS9WTVJVL3ALJZNhMmq8SqGV8zLHZumftnWbrn+x0axLAvzRR
         GNhA3PaqJfOjWdaD2QS9XoPuAojJaiGrPnACPfEWw4a1NUuXFYjQtpfzcdC3EPtzOxbg
         XLT1PaaFoEpMPhPqhLSNWPeOLOYyQ7gDhyDqqH5ZiouVzFLi4T4BUfRPmzPw5ox9gL9Z
         wwFmkts0OOFtMYePD76GMXhNCF0WO0NqPGC7g5QgxvsJF3UnN12tlAX7u5cT/LNY5VLQ
         80WA==
X-Forwarded-Encrypted: i=1; AJvYcCWzHHv/GTBXYuvcOeXEnkG097bQyNmQqq1S4Dwnsxb4bq2I2vV1zUzXJJN2aZf5pks+duM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRgWnmuLVRMhAqxnaL559Ep1ZfKOoAcE5sVtnm7MkWoAnn0W0c
	GPyC5KKGO5xO969XgMutJ7/uGipHgXsjs8p72l+GCjM3TgNUdQSiDQ07
X-Gm-Gg: ASbGncurXRu9wsedPiDr1V/nCZ8tnCKmrHg0DYSHEgn4+GpfsB32RfYgHg7kxnL4iUg
	b6UltFKFuDY6Kbxgl7QllcveFTcI65WExf24aF7ZYlToj2hdhKcO+Lm9sBZwZSMjRtWXk9uIwnU
	gEEGthaD1JlHqekk32lpa9XSCa/yewnvhAHjBwfPqEmqAz9ZU0c5iP0kb5ztONp8plai4NahiTT
	+Ux3ivia6iqJn02mjT/qngpUo3ZSEBiLxG/uqy5vIomxU1FVsqclYLebbLSSanoblBoxRW/hroj
	CDX7r+fRXk71FtZ5apz62BnPx0UKqGzCXKyhLQH0EHBdcpRAg3Y7MVXZub5B4VIUTiDYjOq3q8s
	Ret+z7ZNIx0bITRgyc4K9g97WNedo
X-Google-Smtp-Source: AGHT+IHxi+31PA6L/iEEh5VZxKvefbtOmqG6UBzGA2us8tpn9ISmWmdNod57JNwGCYVsLX9CXroQkg==
X-Received: by 2002:a05:6a20:748b:b0:222:c961:af1d with SMTP id adf61e73a8af0-23d6ffe87e6mr16046350637.8.1753653648542;
        Sun, 27 Jul 2025 15:00:48 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640863506dsm3728384b3a.18.2025.07.27.15.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 15:00:48 -0700 (PDT)
Message-ID: <8c4e3d2e5400b7816781c8dae74a5fe58d631d48.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 5/5] bpf: Add third round of bounds deduction
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, Shung-Hsi Yu <shung-hsi.yu@suse.com>
Date: Sun, 27 Jul 2025 15:00:45 -0700
In-Reply-To: <b0cd5dc5ac6abb84f09b253dea5dd5c61126e83c.1753468667.git.paul.chaignon@gmail.com>
References: <cover.1753468667.git.paul.chaignon@gmail.com>
	 <b0cd5dc5ac6abb84f09b253dea5dd5c61126e83c.1753468667.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-07-25 at 21:08 +0200, Paul Chaignon wrote:
> Commit d7f008738171 ("bpf: try harder to deduce register bounds from
> different numeric domains") added a second call to __reg_deduce_bounds
> in reg_bounds_sync because a single call wasn't enough to converge to a
> fixed point in terms of register bounds.
>=20
> With patch "bpf: Improve bounds when s64 crosses sign boundary" from
> this series, Eduard noticed that calling __reg_deduce_bounds twice isn't
> enough anymore to converge. The first selftest added in "selftests/bpf:
> Test cross-sign 64bits range refinement" highlights the need for a third
> call to __reg_deduce_bounds. After instruction 7, reg_bounds_sync
> performs the following bounds deduction:
>=20
>   reg_bounds_sync entry:          scalar(smin=3D-655,smax=3D0xeffffeee,sm=
in32=3D-783,smax32=3D-146)
>   __update_reg_bounds:            scalar(smin=3D-655,smax=3D0xeffffeee,sm=
in32=3D-783,smax32=3D-146)
>   __reg_deduce_bounds:
>       __reg32_deduce_bounds:      scalar(smin=3D-655,smax=3D0xeffffeee,sm=
in32=3D-783,smax32=3D-146,umin32=3D0xfffffcf1,umax32=3D0xffffff6e)
>       __reg64_deduce_bounds:      scalar(smin=3D-655,smax=3D0xeffffeee,sm=
in32=3D-783,smax32=3D-146,umin32=3D0xfffffcf1,umax32=3D0xffffff6e)
>       __reg_deduce_mixed_bounds:  scalar(smin=3D-655,smax=3D0xeffffeee,um=
in=3Dumin32=3D0xfffffcf1,umax=3D0xffffffffffffff6e,smin32=3D-783,smax32=3D-=
146,umax32=3D0xffffff6e)
>   __reg_deduce_bounds:
>       __reg32_deduce_bounds:      scalar(smin=3D-655,smax=3D0xeffffeee,um=
in=3Dumin32=3D0xfffffcf1,umax=3D0xffffffffffffff6e,smin32=3D-783,smax32=3D-=
146,umax32=3D0xffffff6e)
>       __reg64_deduce_bounds:      scalar(smin=3D-655,smax=3Dsmax32=3D-146=
,umin=3D0xfffffffffffffd71,umax=3D0xffffffffffffff6e,smin32=3D-783,umin32=
=3D0xfffffcf1,umax32=3D0xffffff6e)
>       __reg_deduce_mixed_bounds:  scalar(smin=3D-655,smax=3Dsmax32=3D-146=
,umin=3D0xfffffffffffffd71,umax=3D0xffffffffffffff6e,smin32=3D-783,umin32=
=3D0xfffffcf1,umax32=3D0xffffff6e)
>   __reg_bound_offset:             scalar(smin=3D-655,smax=3Dsmax32=3D-146=
,umin=3D0xfffffffffffffd71,umax=3D0xffffffffffffff6e,smin32=3D-783,umin32=
=3D0xfffffcf1,umax32=3D0xffffff6e,var_off=3D(0xfffffffffffffc00; 0x3ff))
>   __update_reg_bounds:            scalar(smin=3D-655,smax=3Dsmax32=3D-146=
,umin=3D0xfffffffffffffd71,umax=3D0xffffffffffffff6e,smin32=3D-783,umin32=
=3D0xfffffcf1,umax32=3D0xffffff6e,var_off=3D(0xfffffffffffffc00; 0x3ff))
>=20
> In particular, notice how:
> 1. In the first call to __reg_deduce_bounds, __reg32_deduce_bounds
>    learns new u32 bounds.
> 2. __reg64_deduce_bounds is unable to improve bounds at this point.
> 3. __reg_deduce_mixed_bounds derives new u64 bounds from the u32 bounds.
> 4. In the second call to __reg_deduce_bounds, __reg64_deduce_bounds
>    improves the smax and umin bounds thanks to patch "bpf: Improve
>    bounds when s64 crosses sign boundary" from this series.
> 5. Subsequent functions are unable to improve the ranges further (only
>    tnums). Yet, a better smin32 bound could be learned from the smin
>    bound.
>=20
> __reg32_deduce_bounds is able to improve smin32 from smin, but for that
> we need a third call to __reg_deduce_bounds.
>=20
> As discussed in [1], there may be a better way to organize the deduction
> rules to learn the same information with less calls to the same
> functions. Such an optimization requires further analysis and is
> orthogonal to the present patchset.
>=20
> Link: https://lore.kernel.org/bpf/aIKtSK9LjQXB8FLY@mail.gmail.com/ [1]
> Co-developed-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

