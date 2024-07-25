Return-Path: <bpf+bounces-35606-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C10BD93BBDD
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 06:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC37C1C23A98
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 04:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE3A1BF50;
	Thu, 25 Jul 2024 04:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4Wta7Vd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08B717565
	for <bpf@vger.kernel.org>; Thu, 25 Jul 2024 04:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721883323; cv=none; b=IqjjCHzsnN/bjm8DzcyVnDlkmWL7oY5Ex33CQ6+NZx2IaxVTTieLjLJNsiClQincr07wX1XHXc2RT8c0O8TvgVtxqiGHopIslw6M7sWOmwh6yvIUs7W0FzswpQ8h0PR6PKbZOuuASRJlmLTO0mgp6o7K1QqcT6cz+kBbMKtZXk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721883323; c=relaxed/simple;
	bh=f3SLv9PhMUk/2M5hmv7BYgZfxj3cTjkqpb4cXCcWxDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GukonaAvuaVJi2JxugYLcRNnF/zf7itrDjDIjSzRDqAPs9tVP+21b7v+kcbI906Se+RIZxaV8RncfwHYh3TDgdIyzY0NdjowiBbYsm+F3t/i03snljmYWe3KaxBSD0R2xmyBr1ZmpuXRvQGoGMATZAIMf4Kqp3hblw/cwEOz/Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4Wta7Vd; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-369cb9f086aso282219f8f.0
        for <bpf@vger.kernel.org>; Wed, 24 Jul 2024 21:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721883320; x=1722488120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3SLv9PhMUk/2M5hmv7BYgZfxj3cTjkqpb4cXCcWxDQ=;
        b=P4Wta7VdL5HqKUIduhrxb1Ll1iyKCSWGfNgYE2RUZF5BjL7wytYdcXgHJh9nb6Nl0W
         PliTq0vBxUUWIts4vtHtBmSePwNP9SoVtSMnY0HE3DMi3vkJyiM3bbLDxgMp1bqAtaH1
         t89t59IwAk2f34SRdSSUk+kt1jwt7KD90cfJwhY6UL9VWIkJf0oHJf0iLyF+/I6o1EK1
         KysSLZGgCVQ1/sLzjYFPoKOSwcm/qpDi0sqqchDsB3LRQl4bKOPwkRPD1eMTBvYasB1c
         diUso2DaCu4MSYnxDYQXFDa9uToNA6A4MpJj1B2UaEmCWtCdadaPlsAptcez5nplX0fe
         j2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721883320; x=1722488120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f3SLv9PhMUk/2M5hmv7BYgZfxj3cTjkqpb4cXCcWxDQ=;
        b=Nq5Zdmb5AKneBtjGbdB0oVN9a/2ndipDLUgyYHBGGBq5MD86wIGTRAqlO4Yy10Bd9A
         XJiYOza1ajyh9srX/sLacvmQnAwSKJ5Gv8NHprRcOPstz3rNcoueuL4/w7GBauiCnZCY
         w5d/1/qB/V52Ve4kjsU+XIlBgs/lyTitGSY8bgqYXb1U5csADtH4fNVRwRUHWaUUdmOZ
         wghmbwdExqNgUwkEJBgBltdRN+yw0iRLAJreEdgOVqThwdmnjUrxq1YcigNqD9sPaHjp
         0v26hL2b9v9vkvetCiA5TbluomMpB0wMdgjo6IQcJmhBrffiLqrjYFxaKlIa/6nhiu/T
         Bz6g==
X-Forwarded-Encrypted: i=1; AJvYcCUprqoDHpnVrxyBxCGMEo9IcCUhKAs+G9NDScwgjkqBOZKSy5U9qfR60S/aL8Jj7I4pjzl00xoeSNGZUrEp2ll/R9br
X-Gm-Message-State: AOJu0Yw0WCoJjP27WqW1p8YSN+i0GK4ltI0oyapgD3wIPKtGkkG68mNo
	Wc4cS7acGLk6AVteF9b9n2PbPeXxBf3kjzpuos37OjR498Hk4vpH48BEUhDF/EVSAdQdcDBKYcp
	QjttpIjbvKfcfopZwDvHO4WOkKfftgwVAmu4DOHdE
X-Google-Smtp-Source: AGHT+IFDUccoRWYqStJAiSnL2Y74cKbICqhO80VA9Wp3W0rPQC4Uurpt/hPGQTbe+K+H8pLqCy7Mjyuwu2BoN+W13KE=
X-Received: by 2002:adf:ce08:0:b0:362:8201:fa3 with SMTP id
 ffacd0b85a97d-36b31afbf8bmr1097289f8f.34.1721883319786; Wed, 24 Jul 2024
 21:55:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718205158.3651529-1-yonghong.song@linux.dev>
 <86b7ae7ea24239db646ba6d6b4988b4a5c8b30cd.camel@gmail.com> <f0706fd3-7665-4983-b7ca-ab410c83bf57@linux.dev>
In-Reply-To: <f0706fd3-7665-4983-b7ca-ab410c83bf57@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 24 Jul 2024 21:55:08 -0700
Message-ID: <CAADnVQJGPvMTakVH6hwngzetab+RYDO37ZpV7n8+szeDskTzZQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Support private stack for bpf progs
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 24, 2024 at 2:28=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> > In the following branch I explored a way to add such capability:
> > https://github.com/eddyz87/bpf/tree/yhs-private-stack-plus-jit-testing
...
> > 0156b148b5b4 ("selftests/bpf: utility function to get program disassemb=
ly after jit")
..

> There are some differences like constant representation, e.g. jump offset=
 hex number,
> gcc does not have '0x' prefix while clang has. Insn at 4b is also differe=
nce.
> But overall the difference is smaller.

There is certainly a difference in disasm libs that will be causing
miscompare with expected text.

Also not everyone has disasm enabled in bpftool.
In my setup:
$ bpftool prog dump jited id 1
Error: No JIT disassembly support

So we can enable such feature in selftests,
but it would have to skip the tests if bpftool is not built
with the right disasm library, hence the value of such
tests will be small.

It's probably better to make test_progs use
LLVMDisasm* directly and converge on that disasm style
assuming distros have this lib easily available.

