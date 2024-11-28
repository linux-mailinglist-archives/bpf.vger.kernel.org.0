Return-Path: <bpf+bounces-45829-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C129DB841
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 14:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86CD3281843
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 13:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4191A9B47;
	Thu, 28 Nov 2024 13:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NbC0lIXT"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1911E1A9B22
	for <bpf@vger.kernel.org>; Thu, 28 Nov 2024 13:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732799249; cv=none; b=XCfjlnsyvW02mjo0Kg7iXrC7Lf9aZKfAwT140GR8QeT3nZv6kJ21tGyLFR8jcbUhs6FHgKtwYP+wG6/Fj7iayGv7WtaS0XF9Yx+879igC7aTso6fn2AJUUFht0CAjomvKBOg8WzREswTqpZpyve0ThOwnM3cs9nWZLjZ0czAoZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732799249; c=relaxed/simple;
	bh=cAXH3dA3hXdD9DhMWQf4k+asQ47TKDyVsQWDK1csVME=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gaOqapDgeT3LTHoucPznp0XXNyPZVoYJ6WFcovZob2r0/RCOhp+7JzqwDUd1c2UZQEVrwE9E+fUio7QsVpRXWy1JRrW8u5Zx2ltHm3sgnF1Of+xhJDKJY0wPTL/gHjvDaqtuF0FMP1ljS9M1AplJang6j6ItR7XY1s4mm5830Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NbC0lIXT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732799245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cAXH3dA3hXdD9DhMWQf4k+asQ47TKDyVsQWDK1csVME=;
	b=NbC0lIXTtF2aSuGzTE3LPxSIxjRSXKQUiXuXIIdFWW1uKufxb7VXvrAgyV4WxWqRhGraM+
	oGQPEPXv4cl4q1uj7wmW5Bi4Xg4pWnl/rREJataAK92JCs4WmxeM1XWEznA3mwplv1c61M
	ZdRc1c9OOyouCHRPASRNqSUC306Toi4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-AOlkngTLNPuBEvyqGyae9Q-1; Thu, 28 Nov 2024 08:07:24 -0500
X-MC-Unique: AOlkngTLNPuBEvyqGyae9Q-1
X-Mimecast-MFC-AGG-ID: AOlkngTLNPuBEvyqGyae9Q
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-434a04437cdso6353025e9.2
        for <bpf@vger.kernel.org>; Thu, 28 Nov 2024 05:07:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732799243; x=1733404043;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cAXH3dA3hXdD9DhMWQf4k+asQ47TKDyVsQWDK1csVME=;
        b=m+vVjheN3WhbcAfG1+UaH9nHooRk/Ljb5hBRMSLTcOpwNrE3OcdT7sWOOS8CgEuVtF
         zPy+ObDQmbBaBCZ8xbg3YFf+oVSRdyz+EBp3cF4gj1DSsxBJywDpfP+7UY4jVfGCzEPm
         bc6qTvSZ/VAYU+ifzn3znTpa2VwDKMt/5FJP5RljfjP+pEnSzmaL6Sd4AFp13BmqcIQy
         7H+z8GIBQaZ9fWRD8Z5bAsISJYuwJYE/r4XEteznjAmAGbNwbDf6CEcjTxshh686tRT3
         nL+FXYDuxEMtpMjZ0GNO+1qMzWmfw12O9mTKJxHs4k/4xlxUyV1qyAie9GhS7tBlPEBD
         juEA==
X-Forwarded-Encrypted: i=1; AJvYcCWV+5/CYnhCLjYbviM8VZW+2OLdUpCzDJh6GKcM6vmA15DKQGJT7nB+uXsoKuRRZFPOpM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqeoxjLSA+3hZU73j4LI8RgvsOFgTxgdYZxpf5Eg1WD3ZQ3tDP
	FewJ83niXzLeYQR7jrWUVOtwyn/Dd0gaj/fzVD/d7HAEFTG1p9qmsQNTwX3maD6NcptSq4TfBFq
	/r+0hTEVtO26CihkDhsHBrj5zwRSDbaPkKXvjXg6K/edM4TjPjQ==
X-Gm-Gg: ASbGncsXrCx8/Zbtut331LIorLy8SyUgH0178oW3x9p6ODY/p9dM5OOGMEnH9cB9QWN
	QgF247FzdaaYqNUX9oEXAD9gplAJ4n0IdCXhCfAhIpnhoafUqAAGJ/Dq/2oWGhlJWhNvOfsYA/s
	zSeKIizu+6SGKt3NaV2RYts3ecUwoFytuEpZKqiOA2yyh4hVQrE/WYdTKaGxikDe9xupZCyFs9K
	VCrSfACwN2Yc8hERqNop1xGiwc1PJQLEuy/fQuMkEe4VItI9QIQlSsFBf858Su7B+0dVkXrWMc=
X-Received: by 2002:a05:600c:4e8a:b0:431:5e3c:2ff0 with SMTP id 5b1f17b1804b1-434a9dc5003mr65339365e9.8.1732799242814;
        Thu, 28 Nov 2024 05:07:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2psrPhjev3bJrjSIB+JHRV7XwXM7FdQVe1Lk4BWmEHa6+pF1hXmW+7huHZUP0OGwp9t/s8w==
X-Received: by 2002:a05:600c:4e8a:b0:431:5e3c:2ff0 with SMTP id 5b1f17b1804b1-434a9dc5003mr65339055e9.8.1732799242505;
        Thu, 28 Nov 2024 05:07:22 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd367f9sm1582466f8f.31.2024.11.28.05.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 05:07:21 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id D262C164E1A8; Thu, 28 Nov 2024 14:07:20 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Alexandre Ghiti
 <alexghiti@rivosinc.com>, Arnaldo Carvalho de Melo <acme@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, Quentin Monnet
 <qmo@kernel.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, David Abdurachmanov <davidlt@rivosinc.com>,
 Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH bpf v2] tools: Override makefile ARCH variable if
 defined, but empty
In-Reply-To: <20241127101748.165693-1-bjorn@kernel.org>
References: <20241127101748.165693-1-bjorn@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 28 Nov 2024 14:07:20 +0100
Message-ID: <87o71zik1j.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:

> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> There are a number of tools (bpftool, selftests), that require a
> "bootstrap" build. Here, a bootstrap build is a build host variant of
> a target. E.g., assume that you're performing a bpftool cross-build on
> x86 to riscv, a bootstrap build would then be an x86 variant of
> bpftool. The typical way to perform the host build variant, is to pass
> "ARCH=3D" in a sub-make. However, if a variable has been set with a
> command argument, then ordinary assignments in the makefile are
> ignored.
>
> This side-effect results in that ARCH, and variables depending on ARCH
> are not set.
>
> Workaround by overriding ARCH to the host arch, if ARCH is empty.
>
> Fixes: 8859b0da5aac ("tools/bpftool: Fix cross-build")
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> Acked-by: Quentin Monnet <qmo@kernel.org>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


