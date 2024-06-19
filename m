Return-Path: <bpf+bounces-32479-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 216C290E087
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 02:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C83041F23007
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 00:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3FB1103;
	Wed, 19 Jun 2024 00:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKMa8En7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34249196
	for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 00:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718756183; cv=none; b=E6FXU9dTkOFBSfUuZMGxPafZvsygdwsyGYKERUFhrSxNrR5FLWFoFnWMZG/XXLCs+cCEBgBGLOJ0fLtKBb/kjEtDQiTb3VuEYU+6o5yl3VFFvF1Sbb8lWqpPmb7H09SQDYHgdcWd8kBofqI88iPIQ2yX9n9ZX4Eq8WtQ9nW/hHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718756183; c=relaxed/simple;
	bh=PqtVn6w3bKvw30t0q5DGlA7v7q54xu2zS5A8pjaWth0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qxum7mNyyD8etTOKbMPD3Dn2mfrzqsrAiC8YEq7r7WDjW8IItF6k4CvKUvjVAfbwy0K40wow8jggihIOjql89vt0jNiYtJsVO2K5lntZ+8SJAQC8A1+T+n4RZTqdunx4gLTgYUHv1x4DE2pnULV5O0ljKYNDA/BvIJ6SHPx9EMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKMa8En7; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6f9c1902459so3597445a34.0
        for <bpf@vger.kernel.org>; Tue, 18 Jun 2024 17:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718756181; x=1719360981; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PqtVn6w3bKvw30t0q5DGlA7v7q54xu2zS5A8pjaWth0=;
        b=KKMa8En76AQzj2AihtSqK5Rs3RjytZo3c2vqq12AUy5SkSh+vanOleYHMdODgsGJLF
         4GT3j6uucuAO2JTsugXGRilyddxo//XYmZRAJlX/UU0kbA2VbO+qT/54Azb908c5Bwh3
         5SBSjfb7KJJJLNo3XEorevns+Mig9OxD+uBEXM3F7+hsNw8jcYy10aO91JkIQERIn4y0
         WdAJd+qsz3kGcM3YENd03jJhtDyhpJtghx20r+32ZIkAtb080C+t1vTEnpVSW4shQZg4
         dZusPqxWq2JZU4y7bII0KiYCIKCNmGm0SM0pg9FXC46hpSQborn9KTnhLdQwBzm3qBSw
         3B7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718756181; x=1719360981;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PqtVn6w3bKvw30t0q5DGlA7v7q54xu2zS5A8pjaWth0=;
        b=hGDrjfyQDvJhUmAMoKKTLLWYYxX72r6HwhwnEnbnrcynfxDhnq8nwouDGtll/qjrs4
         1g51M+eP14WNtm9kH9pRegepdMusV58fE2ybZMkIgVKYeR9RB11DBBIjc4T0t1chb48k
         lHrX/GOO1LV1mD75I4lVDQ8csW8HQ048tcjTIXsZdM2QXR2pBhbEVLS/soADJUlGOTMk
         yeiVrvgLg0+hOOGcaztHE/BiimI4JjH4WMFC9dMTEM2Hhh2DhQTrP1aY5yK1Nt0fTOtc
         pWHaSCGxLfD4V5Enb2ta2pLGkqvtAUHe7mo8O2YdAYCRry6eqBMqY2sGorNPQHqSztHZ
         v8Hw==
X-Forwarded-Encrypted: i=1; AJvYcCVNaz7GGuMpD7eaDjm1Q4EFJK3e80aGvj5/OhxytfHyQ7+idsXeOE+ZMe7hl4tZrcr5XZjkE2KGssqiNYtRukz9klCj
X-Gm-Message-State: AOJu0YytIZKQYYbK2tHe2vexRiIWV0vx3j0qdS9Jp+rBQEWAvMyM/lh2
	QpZdbYE5U6jriZuxB97KMsmy+LhcZRxjXSGH8lYl7qe3cDhNHLHz
X-Google-Smtp-Source: AGHT+IGgB+hmacVGaU9hd462EEE9MsYa6bpET2vfgDCXcUFeJ/g/x/7QpyYYChPWXDFj4QxJFILaLQ==
X-Received: by 2002:a05:6359:2e14:b0:1a2:89:299e with SMTP id e5c5f4694b2df-1a200892c43mr52030655d.12.1718756181159;
        Tue, 18 Jun 2024 17:16:21 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fee3c9ed1fsm7216578a12.83.2024.06.18.17.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 17:16:20 -0700 (PDT)
Message-ID: <5f74aaa8b05a709cfdd42748128948c2728d2ae8.camel@gmail.com>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Tests with may_goto and jumps to
 the 1st insn
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	memxor@gmail.com, zacecob@protonmail.com, kernel-team@fb.com
Date: Tue, 18 Jun 2024 17:16:16 -0700
In-Reply-To: <20240618184219.20151-2-alexei.starovoitov@gmail.com>
References: <20240618184219.20151-1-alexei.starovoitov@gmail.com>
	 <20240618184219.20151-2-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-18 at 11:42 -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>=20
> Add few tests with may_goto and jumps to the 1st insn.
>=20
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Nit:
I think a test with conditional jump and a test with gotol are needed as we=
ll
(or some of the tests in this patch could be modified).

[...]

