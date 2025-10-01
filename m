Return-Path: <bpf+bounces-70086-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA46EBB0B93
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 16:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E5F34A555D
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 14:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A53E25784A;
	Wed,  1 Oct 2025 14:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XoUv3gGE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801B71CEADB
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759329309; cv=none; b=gVdaKHxc8dYAWyceruGLYVHDSUsTV1ITdAiDXAxCH/3Xy/o72vVnn4lLLZGIhqYI4OOwZ9iYB0+sVhBuy0mCpYuW2Um3ZeywDOAULroZemIQxhsXBevY4iBVB4QzIPGW/l2mSapcIap+RzHE3M8xza+TvfoRA5LiKKaVgWb9z3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759329309; c=relaxed/simple;
	bh=0u7TZJM98/heR4SOwHNGwHwui4lGqgQQhYNirkwl394=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bGWHgPxw0YpB4qxfBUKB8hyg7i/0F3XreVse4UrNcj8TCOy3L6a9LfjCGSfy4pXiNrh9hMpu/t6MLoxFwk1XEBsKE9ltgdh5mJSVtF2FixaRV9uMN/hU/DHb7KoTDtLO5pg7hdCmau2MLPJRHj9/jzXElRthxxXQawaYhir6a3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XoUv3gGE; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-46e384dfde0so77703085e9.2
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 07:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759329306; x=1759934106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0u7TZJM98/heR4SOwHNGwHwui4lGqgQQhYNirkwl394=;
        b=XoUv3gGEdPNMHjiNyc79xU89E5ch5/Dhy1nENK/QCV9LUap287W8639EtJzTvdofgv
         zfHY9E4pX5FCwa7JUdqSXxCJBRGrzTkvYrYuu43QzthERO21QdVoZc9AgIdWYsJYZlE9
         a5+/qk9Z4XKU45OJBg/h9pSQhMvHJ5V+UA37C+EWWylVGzQVd+YZAVrNn6CnLkr0aJ6f
         VUi9YALu2BYBcmXb49zWOG/LpcM3sjoGV/pJwUhc5sckiSzJD60UGLWSGPImvk8OvzTa
         EZTl8iGscv9Z8tIgXslULD7xUEj6l2DRLrNpe6/0AaWGQKh8Xzmnf3VPUBQjnOxgVoem
         KW5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759329306; x=1759934106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0u7TZJM98/heR4SOwHNGwHwui4lGqgQQhYNirkwl394=;
        b=pNPRrB7Wi82t6BE3RdIzDv652YvU6PpqLYV4PX7r6WvDp7zmqxfe89PNvBEqcn7pXn
         0dOgp9NwidN/yYNwYeDtyqA77KkCqEE5ev72n+sjtl8zprq3Cm7L0kI0KhaZxhKSI+64
         pPZGmWNjJWokp50wbv6bp0w3AaS7UfUqBkwmhyL/ToYAviXmI0/87C1RU8i+soumDFAI
         dTkC3BR/+duORshgFHWrPlIDjpLNgSZQHo2cZji1XekfMNWN8yRVQo1VNMAM3slyQ6tJ
         WRMaNraUxsFJhCJ3XeXVrXE1H1Hyfnx16gjUiZ/ISvBC31bGGIB3nMylCziAqMJ9uKIp
         CjuQ==
X-Gm-Message-State: AOJu0YxRGYiBjrxSgWyY6ia0+xwFoRZxYqV3oYoO1tuwUS8/foCqmhxD
	EPjn3gnhOu6AwRTSZeHcpxbv9rjSUQ2gVZa1OuPwoD0el+jA+221Sn/EYcJA/GdAkukzNRw7zKP
	/mEwMIJApBOohVDi46pZxiKH5e0T7TR3EeHR+
X-Gm-Gg: ASbGncvV3iKRasQWdet0/PF+LCvN/P2huCFYxIanTajV4sj6DJFVn0gp8reMiX9yNsx
	dsMH8gJ2ivMbGgEXyEaOr3/OWKMAP7Ts/J0DDuvq5JdquiYAL5nKisI2e/RJYQ8vVX8jRJVjgWX
	mxHQJ4Z5/Cv5VLKnSZV1C75/5JSmAQtVJ8vWUgUqfySYm0uICMZDRkCXY7doeeXkQ0m4fPnUR/s
	bcvq0p/sVJuYBTrQFdJJ7qrOMrLL2Q1etlRaul8EmZDMfwZuTP9p+4l16aY
X-Google-Smtp-Source: AGHT+IHFOXFoTaM63mZ5WoVj8vGoqX1xh3RZfuqUPiVUnG1pRrLjaGHKJOBJlXZgOrhoR3j0bV9GnJh71nmPMozAxUA=
X-Received: by 2002:a05:6000:200d:b0:3ec:e152:e31c with SMTP id
 ffacd0b85a97d-425577edcf1mr2390761f8f.1.1759329305544; Wed, 01 Oct 2025
 07:35:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930212619.1645410-1-andrii@kernel.org>
In-Reply-To: <20250930212619.1645410-1-andrii@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 1 Oct 2025 07:34:54 -0700
X-Gm-Features: AS18NWCE0q5p-xp5XL6XJG07J3TnOPyc_6Ain5wBtLuRS4s8fF_cZD3t9Aq828g
Message-ID: <CAADnVQJb_BZ-7dgGrdhOTqQqH1FJ8NBy_3qLAR1K-4_Q-6_XVw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/5] libbpf: fix libbp_sha256() for Github compatibility
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 2:26=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> Recent reimplementation of libbpf_sha256() introduced issues for libbpf's
> Github mirror due to reliance on linux/unaligned.h header. This patch set
> fixes those issues to make libbpf source code compatible with Github mirr=
or
> setup.
>
> This patch set starts with a bit of organization: we introduce libbpf_uti=
ls.c
> as a place for generic internal helpers like libbpf_errstr() and
> libbpf_sha256(), and move a few existing helpers there. We also clean up
> libbpf_strerror_r(), which seems to be a leftover of some previous
> refactorings.
>
> And finally, we move libbpf_sha256() from huge libbpf.c into libbpf_utils=
.c,
> following up with fix ups to make its code more Github-friendly.

Though only patch 5 is a fix, let's get the whole thing into bpf tree,
since we're still in the merge window.

