Return-Path: <bpf+bounces-21531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 701B084E90A
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 20:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2D5CB3102A
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 19:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16353381C2;
	Thu,  8 Feb 2024 19:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ER4dpgUe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130A6381BE
	for <bpf@vger.kernel.org>; Thu,  8 Feb 2024 19:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707420854; cv=none; b=jwra7BtcbtA/Jk5LrEijVLtvUDgPaMAgKcun+1qKlPaTkiJLLi127ufP02px6xj4usQi/30/KSx4bdbQRYMTP8EfCHXQhHsJdo92FjT+0s1mhP/SOd8HJvrP14REiDlxD/TwyK/rjMA348C8rnPsTY8/Le5602kbR2EINWLXVs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707420854; c=relaxed/simple;
	bh=DeRXIw8gyyrXMLr7K9JSNR0GT+nRAj2uReVoMUgiQLs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q0QdGFpDwqjMm85i6B9DDPJ7VJvwiNGbhA7EvntOpRX1cQ8EFPEp/ssKkVqboag5r9KUq38vDYr3E9GeMXllC3Utv9gYt9wYUxbGm5c78zfnLjBiVoZ3vOoo582VVlz21ByBya82i89fqDfQnX4ZSxA+dxvcgmOAvUP76Ymto5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ER4dpgUe; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a29c4bbb2f4so20527066b.1
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 11:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707420851; x=1708025651; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zSYAY8GfiPgnE9ei1FPPdjbar5PQTRIQ0Skn8g09wSE=;
        b=ER4dpgUeBbjPlUSgIkgI65UcOsRSxWyKKmrNtLcSxDe3qPOiIsko5MYoFd4lOmSSny
         BlS1B0Z9JK5qz+Mj2mfnIhoaNXGviFOvD+LyGsI6tK/AO2xG5Jo6cwuhKECorcwJAoq/
         1QbUIprUgHe7/AN0Evwcf5KB7AeYkeIXLVcrixrsermGq6VhHvVaDnt4mFLws6pIZtmy
         4r4OHIdnWRG2WKsZsRGfbVKCurj0eU6J8e+6b62CHUePIWAm9cnOcdp6xZ1KkogJ/jcp
         un37Ksx8DmmN7UuWICJEqLbfs4WBYzXbK7aRvgR4qWu9c27od2gks/Ui3orPws0c30mn
         jm4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707420851; x=1708025651;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zSYAY8GfiPgnE9ei1FPPdjbar5PQTRIQ0Skn8g09wSE=;
        b=fUIceUkCUeum6Th8wqwr9Syplvumw5qWuVDXHZal4/82M82sx/j3D6wE0giX5UVA3R
         MVucReVD8Myr8609D+YMh+L4Z6/bBQSKj7kTq38FNauFq1lyl4EDuy3KtCExCcDkHKML
         sY9DxZhYtL4NJSJYko97OguRK2zkrWc+RKQvxmV9haYHybmkPOYglndBEWncY6NyCZWi
         +TgLSI6Mvh7sZKpEYZlobK36KC5J3/TIz51suxhdE/dx7mJtEGbjDUh7YqixY+jZq9XT
         bilVUMl6RkFJKspBQW1nutMaR2NQsGOw4lln8FMLvZZ50ESM7I2DzP8i5qbeDTVbU1cf
         LNqw==
X-Gm-Message-State: AOJu0YyclpSrbz/maa/xBoSNfbX0YdlFiR4q2wBSyG74gWMS7Q31JDx2
	pX8CWNzNnOVntKBMapC3A3uYZMKTqtx8qR+4T4XPMYwk027JQURl
X-Google-Smtp-Source: AGHT+IF3CGMcOSBxha7B3qgbRcHAp3pgA89vLJLlIxImjsibIO2VnKqdvFYCAi8CwiZgqpv3i1E9jw==
X-Received: by 2002:a17:906:4acf:b0:a38:350:bbdd with SMTP id u15-20020a1709064acf00b00a380350bbddmr224441ejt.48.1707420851230;
        Thu, 08 Feb 2024 11:34:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWcctNAL2py4AOO6nUD0zMZLNawA6pinRRru6w08qLCBeSP2+6DY7IpInhC6m/hM1FF8W3jA1ZJhfR4Zi/9gUrd2VCcf5LnAiWWOYFhNPfm9mOZFhTqw9VolwmHbbEiicphQYBx4t7AeIjhI8NIJoYWhOgh/dRZZLQVF3mU5AvOq4FdUNWNrC1EnbaBYaiMfJi3GqTEOB2xU0qosVL2MjzqY21xKqItTLLF
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id n26-20020a170906b31a00b00a36a94ecf9dsm365355ejz.175.2024.02.08.11.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 11:34:10 -0800 (PST)
Message-ID: <a21d4915bb861ac5c2def8ea2f48c99689cc854a.camel@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: abstract loop unrolling pragmas in BPF
 selftests
From: Eduard Zingerman <eddyz87@gmail.com>
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>, Yonghong Song
	 <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Yonghong Song <yhs@meta.com>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>, david.faust@oracle.com, 
	cupertino.miranda@oracle.com
Date: Thu, 08 Feb 2024 21:34:09 +0200
In-Reply-To: <875xyydbir.fsf@oracle.com>
References: <20240207101253.11420-1-jose.marchesi@oracle.com>
	 <c3d29d43-ffa3-47e5-9e44-9114f650bfc4@linux.dev>
	 <87h6ijfayj.fsf@oracle.com> <87wmrfdsk7.fsf@oracle.com>
	 <4ad9dad64b38ae90e4a050ce5181ced750913b23.camel@gmail.com>
	 <87o7crdmjn.fsf@oracle.com>
	 <eea74ef852fc57e9fb69d18e1e5960523c4f7abb.camel@gmail.com>
	 <87il2zdl43.fsf@oracle.com>
	 <7d2b05bf2e7ae7c95807ac4b2a9664f203facbfe.camel@gmail.com>
	 <871q9mew62.fsf@oracle.com>
	 <8297be08-cd05-4f08-8bb2-5956f13bbd25@linux.dev>
	 <514b171d-8a3c-4134-a0b4-9b6531b3fc38@linux.dev>
	 <87a5oadboq.fsf@oracle.com> <875xyydbir.fsf@oracle.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-08 at 20:03 +0100, Jose E. Marchesi wrote:
[...]

> This makes me wonder, asking from ignorance: what is the benefit/point
> for BPF programs to partially unroll a loop?  I would have said either
> we unroll them completely in order to avoid verification problems, or we
> don't unroll them because the verifier is supposed to handle it the way
> it is written...

Generally speaking, I'd agree.
But basing on the git history, this specific test was added to check
if verifier is capable to process some specific pattern generated by clang.
See [0]:

    The main purpose of the profiler test to check different llvm generatio=
n
    patterns to make sure the verifier can load these large programs.

I'd say it would be fair to select any reasonable combination
of unroll pragmas for GCC, e.g. use unroll(fully) instead of "unroll".

[0] 03d4d13fab3f ("selftests/bpf: Add profiler test")

