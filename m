Return-Path: <bpf+bounces-66118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D74B2E7EB
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 00:06:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D4144E127D
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 22:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF219221F09;
	Wed, 20 Aug 2025 22:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rej3VFYV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F7A6FBF
	for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 22:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755727577; cv=none; b=EwVgKGKk/AKSmQYkqCO7/DUUuCr6E+gArh8afpdJtA6LS1X/DL7D6+FInNUDWUW0huqmVLuxUoXv1XLGVLDXKRiTYC2L3pdarOuSgGmBTogIA6KSSFw0vCKRfQigT9OlrLy+1pn3Zv4XrqkymQmgIeVAkspyPVRxzrE+hvqTcIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755727577; c=relaxed/simple;
	bh=tAzC8BXFk+oyn2dbToXvj7+9vctgDEumItvHiJKgn/Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uaCrWk13nA2gwc5fYaY9PauOJtkVUa05hFupG3O+VgYUgJ+gFJP4lf7S5JXOnNrMNKv/3Ire3UOQ7BtWvQZ8RTrtCyCAGsN7IWyRArHPTSUsC2ZpYw0PE9RA12Vob6PtWd8jLczM0e2fTSdT0gX0PWZ+LJQUZifDA1BXcC/ntoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rej3VFYV; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-32326e2f0b3so310760a91.2
        for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 15:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755727575; x=1756332375; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tAzC8BXFk+oyn2dbToXvj7+9vctgDEumItvHiJKgn/Y=;
        b=Rej3VFYVXIZlNh0v+RUiQImt1v3GFsehcxAKURau14NLJLwsVvcv/o0CS7J/B+F4az
         G7behgL8m6PuImtuhgJ1b894zcFK9cFShOz4Mb3RPdGSZFCtKJZFfYzAjWJ38oh9GPOl
         W7xGC8PI1cBxyEV+CSZ3OOg5AcDi0Ej/UkacrwaC6RfDq5E450xpNEnQuREN5HlpX9LT
         Twy0jyWoJQ+UeoGAWd876xaWF1t6LNguQFTAC1+JMJWHJcKZEV6b/mpT5Akyz3PE/UJS
         lCaPQ8poKjh3kvz8LGe88lymDngYrgc2MiERszrFkwP5U9XYyY7Lc7IFkZHxodC1PA79
         0KqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755727575; x=1756332375;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tAzC8BXFk+oyn2dbToXvj7+9vctgDEumItvHiJKgn/Y=;
        b=itppV5PHi43OU1t7CRAOzSKh7OdKT2keCnzlsRNpmpqefvjtLxtHQCIUaENTV3mu0P
         EHj25BDgL6o4Pu/c0stw/SRqyLgTxLgu4fYYzIk8SLvlU+3D1mP5qlR5JCqauJjR9YdB
         t/srvGDqF40zDNOck49AfxBdFPDXs3BA+KutJCWKsyDlvsEwtD6p4vE5ijZWJ+Ma8KCQ
         y2jxglXxRc/drFGeDmku5NG4frdIrzaHUpkPMEPv87eYR7wFD/Wxvstpp36d6chXmBmR
         atsrQKb1aWHdhHg3rwm+S8Wz/CjN8k+f/K8aJINtckxGONCGPlU73mRXbVME+pqCnw6m
         G19w==
X-Forwarded-Encrypted: i=1; AJvYcCUkLWXZqGcNNzWTteqjYL/tqv/Jk9WRssJYU2r7/y4dVAaYtW4UMPwJgMgRGdsOofLCXpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMxol4IrPvzA59tn0RaLAy/68nJB5SzWBK4XKXXQEpJb6V/Khy
	/8MsNt1zzMtth+JjLeIK3SU8lv1SxPrvDUoiCXQHd5PVgRteFMKdH8dP
X-Gm-Gg: ASbGnctvccyOgxV2e3z4YEy2NO6KqEhxzf5NE/Cy2VndwOjqPnZF6h0oNm1g5cfwAbY
	rjTeiv3x6bQzCOFljsqvz98tBUCrZIrPB+HsVCnlQkywZe3Dktdapg+DN+78nlLQ/AW82/YRvpq
	XPWg5Ah6Ovr+VaBU2STH7XSlIC/2HSy4CXTARf55aWDq6qCp7pEs7ZKfYtvTZtdom62be8bGzsu
	zfAeys+E/2mbpryMEg/guVWmArzXpaGj7mlAfHWVG6hskpet0P/KVcWZkkZOpYNK0nA9rFw2gOt
	plZnMUSKqJUCfKkbKx+aK7Z4muLGchcqh5SEsHhTJb3ogErViAuMFeesfDvuwnvERlCr8EMVHnM
	D3jZR6zZjVTvRC1M6Bm66nxQ75z4lAAoEIX8ChvI=
X-Google-Smtp-Source: AGHT+IHyULgyTpg3Jl2hfh97niFxq1DKJSFdiBYwWpSiiic1Hgza3TA2vyZb6Snn3lMxWwjJJffEWg==
X-Received: by 2002:a17:90b:2549:b0:323:7e80:8817 with SMTP id 98e67ed59e1d1-324ed1d4a5emr493089a91.36.1755727575312;
        Wed, 20 Aug 2025 15:06:15 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::8c7? ([2620:10d:c090:600::1:f668])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324eca25ef3sm183664a91.3.2025.08.20.15.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 15:06:14 -0700 (PDT)
Message-ID: <c1b62e3fa2e7a6de635815efff6cbb641d999a3a.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3] selftests/bpf: add BPF program dump in
 veristat
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, Mykyta Yatsenko <yatsenko@meta.com>
Date: Wed, 20 Aug 2025 15:06:12 -0700
In-Reply-To: <CAEf4BzbtzTZ5t3UwN-cgDNUqSE6vMdDZCHtPWy6bjAUaDhHsKA@mail.gmail.com>
References: <20250819114340.382238-1-mykyta.yatsenko5@gmail.com>
	 <CAEf4Bzbwnwj125ogm5u8pY6GNrR0EWLVH9J-diC49aZp3xi9RQ@mail.gmail.com>
	 <3dc1c46e5cae319823a43edbefc4f7b1d8e8e657.camel@gmail.com>
	 <CAEf4BzbtzTZ5t3UwN-cgDNUqSE6vMdDZCHtPWy6bjAUaDhHsKA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-08-20 at 15:02 -0700, Andrii Nakryiko wrote:

[...]

> What's the concern with popen()? That we have to copy one stream into ano=
ther?

No concern, just see an additional loop as unnecessary, this does not
matter much.

>=20
> I didn't like (instinctively) the implicitness of system() adding
> something to veristat's output, and you just proved that instinct
> correct with that fflush()... ;)

You asked a question off-list on Tuesday whether system() and popen()
behave the same, here is an answer (both are wrappers for 'sh -c').

[...]

