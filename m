Return-Path: <bpf+bounces-27707-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D68B8B1026
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 18:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FA6B1C24E7C
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 16:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADE016C450;
	Wed, 24 Apr 2024 16:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C59Tw+d3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41A3158867
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 16:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713977234; cv=none; b=LCHbXCCFuR081pz6QHFbs/wN8o/mQghwAODD1zVeaP0jEo19WBHm9PXeink3W5F6gkJouAF80TvwJXBvPChf8nnPGi0dk76aP9KGmdaxC9PcNRKkcxfCjmXTFTo4PgdcjP9yXsnhVa2mq3Ii6IUJU2vqqlfR6kXff8vjihuQcHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713977234; c=relaxed/simple;
	bh=aL3FfXTtyKLMJqpGIXwgrha/vDWG1cpKJRqvFrzxdLc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LnCy0D/WfFbst/sThI0WnvQ8bMFakMq2a4wroFHVI8mL66tWpUxTGI07WvZPshWHCUYTe1G2WcK4/SraT/IS1wAnmZZPFbuJPVicxcdXjnXfIq3zQvu0s8zV8ZRt4qDS77euI30+RVWPkbIobwdbjyEl5pcIuhWoTqERSkdC3Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C59Tw+d3; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2a2d0ca3c92so106076a91.0
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 09:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713977233; x=1714582033; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JCS59o0Pnvav9SKCI8hiJduP64/KpioP9KooBGQ7q4A=;
        b=C59Tw+d3wjPur+sIOG+Uez33/9yJczn+st/C2cQIzERPvIzBxcJsz4T/sHBZ8NA/x7
         +erzO1+EpHAKVEISnDiwvrTLIpcmbbDIjrs7pEuA8IFNZoo5TrChyUv2Y1xYTwpse4Rb
         BoTbi8tisYFRFlF879D/XGWXlfG2vc0Y68wnP1jzHbm3xvSy1EsHX5kOuHlpGXKfGfoO
         Yd/wSuW4BY362/yLlSuhW64biSLL0wo9V25BRBmu/hLQNaCH2mlVdj7pzhZzrxKeAB1M
         epN2aSchnYcASPg/T/Z6ag0zHLF5mL5jZllOFbZIVf4I9V4agJqUz+uqjftPU20OfGzU
         cE/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713977233; x=1714582033;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JCS59o0Pnvav9SKCI8hiJduP64/KpioP9KooBGQ7q4A=;
        b=SKUneX46VnEImifISEA9LIm6F7cEsPTKr528vri9OsEN+F1+JWNG7EnsD/WpKWLh7m
         8nrdxS4vbcoTyx+cbaFWuyWxofIRmLoUFRgBcqDUZxPR0Q230ZmBpRNzZpEETdHHD0rP
         KWpdk/pP/fjflOofntDnZIOR002EXYG1kgcfrvBRpRmxZf7OlAJOuS63cGq9I233FNPl
         d7Kv/o3T76LrQXMNObRC1b4xS9DyBcA9Ck12O9dQrer/543wdome1lRzcut5Wll7GKRu
         gUyK7DJ4ZRil6CdsiGwrPB9gF7PuAH5zeYJXhPjqXfvU6PEccyLiBofOFKKAUmfAuMHu
         DA8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSNjR4AfzVtxKKSk95MO8zE/IwqUHRElZyLGcTt/HU458W5oLyvhJGjZWicjEkKOOFjBgNtp2wmuY+u4tFDThzD7ZN
X-Gm-Message-State: AOJu0Yz13HUOoHFvM+tmRRBYzI5EtRENaKu1nSzdso9BrhMH9wXba4Tj
	Ywxjfpj13jLaOmvANrHCBPMD0vTZVf4Nu9MgAsRSvq+GorgGTTq4
X-Google-Smtp-Source: AGHT+IEAMz3aksYGgToWsgq2WruyVOe5YRTOrKOGjd7GHMOCIoebmlQjzRvDled5faMhofqbFwAb6w==
X-Received: by 2002:a17:90b:98:b0:2a2:faf4:71da with SMTP id bb24-20020a17090b009800b002a2faf471damr339092pjb.10.1713977232870;
        Wed, 24 Apr 2024 09:47:12 -0700 (PDT)
Received: from ?IPv6:2604:3d08:9880:5900:6810:716a:5a05:31e3? ([2604:3d08:9880:5900:6810:716a:5a05:31e3])
        by smtp.gmail.com with ESMTPSA id j12-20020a17090a734c00b002a2b58ee4a9sm1507232pjs.1.2024.04.24.09.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 09:47:12 -0700 (PDT)
Message-ID: <81707c6d1c0e2182e30553cfc3022317add5b7d6.camel@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: add a few more options for GCC_BPF in
 selftests/bpf/Makefile
From: Eduard Zingerman <eddyz87@gmail.com>
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf@vger.kernel.org
Cc: Yonghong Song <yhs@meta.com>, david.faust@oracle.com, 
	cupertino.miranda@oracle.com
Date: Wed, 24 Apr 2024 09:47:11 -0700
In-Reply-To: <20240424084141.31298-1-jose.marchesi@oracle.com>
References: <20240424084141.31298-1-jose.marchesi@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-04-24 at 10:41 +0200, Jose E. Marchesi wrote:
> This little patch modifies selftests/bpf/Makefile so it passes the
> following extra options when invoking gcc-bpf:
>=20
>  -gbtf
>    This makes GCC to emit BTF debug info in .BTF and .BTF.ext.
>=20
>  -mco-re
>    This tells GCC to generate CO-RE relocations in .BTF.ext.
>=20
>  -masm=3Dpseudoc
>    This tells GCC to emit BPF assembler using the pseudo-c syntax.
>=20
> Tested in bpf-next master.
> No regressions.
>=20
> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
> Cc: Yonghong Song <yhs@meta.com>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: david.faust@oracle.com
> Cc: cupertino.miranda@oracle.com
> ---

I tried this patch with regular LLVM build and everything works as expected=
.
Unfortunately, can't test for GCC build.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>


