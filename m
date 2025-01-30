Return-Path: <bpf+bounces-50120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB469A22C7A
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 12:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 236FF188649E
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 11:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8B91DDC19;
	Thu, 30 Jan 2025 11:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsQspPtZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86921BC065;
	Thu, 30 Jan 2025 11:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738236249; cv=none; b=JdTI7itO1r6G+5A5j81G3+xUKGpXZOCZmhf/9kuJ993BGSsVTX2fk+ohyQ+/d0a26titABF93t1buUOyJLxWHJf8ks/wtumed1xhCVxIsLzyFh+sOVaRDe6aV0aV6I14vYulnMsVF2u2piK9/6Pmwb5srTLBEmfTS3iIQvofPhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738236249; c=relaxed/simple;
	bh=wDl2kfGArafP0t3yD1cDiGvh5wGA0nD57PSF/Ozc0fU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=cs7iKwVZWv1vDOAoAF9xl9BZFgbRnHjtfWWwOniHxTgzFBYBDCB5SfWpe3H6mYk+I4lgHNVDtaYyzWWdosMiQTsBqfCqMDcinq4W5jREVZV+LbXkl5eJF7mHXAOCvd3iPU024E/XixNmFWPxdKHGGlyMGE+S15PCjfUbGhFLmOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsQspPtZ; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4361815b96cso4447655e9.1;
        Thu, 30 Jan 2025 03:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738236244; x=1738841044; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Id92T0AVX6JDwaxiz3z7oRBD6wW+GTifuBoqUY0sTA=;
        b=gsQspPtZ81aBimV9bj/pdPd8nM6yfXJ8NADl+XtoGPZt1NXM5W2TbNm0yJUG6BQa8S
         kJuI2A6nDUXH9XoCVZNcOwjwwTmYmHKA5bxs8oAw8VX86pQXQAsF48ySHqhPust3b2YN
         0JY+rv+WXJNHcbWY9LBTIhabj9RqVOg1dMyp2oa82KWBD/yu8ow8xk2X/2CB3D5QUO4F
         S7mlBQ6gRd0fbzVNijIFrgVlk2aezeNHC2Yzk2OZW54qgko5wJDOuC9UH2589o4hyXgU
         gxwCRSfsPmLYkgCrmkjzXGLu4mMjAqo3F8bbr4tB9rZiK6gkSNttHOtip5S3C7Hazy1i
         k2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738236244; x=1738841044;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Id92T0AVX6JDwaxiz3z7oRBD6wW+GTifuBoqUY0sTA=;
        b=MLBZ5AAwACWnGzvAjUzQu+mrKXOtv2EeHNNrO++WELB5Ofu1AiViAcaQhgS9vR+XeU
         LoOhQpdEh5rn5Duv7ooAFwuhpYFNfYwItaagYY07oepf1xX59pHD8DDAy4D5BG19pvch
         69fTR98XJEg8nqH0+3Ft9Hikph1q9HpfxQ/JX/hGZfDDHqGiylipJMhk00zVJg4cQk7L
         F6kHHrCNaMajBEYv/fbYWWwSKNSixzTLu0FR/Ukxl7lcyYhVT7kHrtS95IVXNWp8P+Ga
         8Fx+kpiWOczYUuPTQjaud0sk1J8XhURgB0rB+jyHOTBW2/Je0PfISiMMbRuVSg5nmqcX
         y7qA==
X-Forwarded-Encrypted: i=1; AJvYcCUgPXzyinkNz6DxIOK7lUP3B15wVgWJRAwnGFMGorx2qWm+xF8evWC8xvp19y2S8ghhOZA=@vger.kernel.org, AJvYcCWLJHOJ0NzTAGO061tTm/TPFJiQfN7DxTTTIu9hDBrIr0N7ho/9iqZ0LbdB80TiSq3lYOvuh1oHcuLeqS7E@vger.kernel.org, AJvYcCXzi80VCHmIY+Bewu15DtrVc3D5lnezUoTi+ztelujOlDN5VW6ZJNwYyO8jzCl4/vCdMDWUaHd/T2wD@vger.kernel.org
X-Gm-Message-State: AOJu0YzE8J5oRE3p78IiqfmkpZpyfAD0ujDjlsbwILWeX1OFuC45MOkE
	/n9MXr9ZGzGxT0kZzmdOrCshbc/LLFTWLh+h9Tj5EuZmvKT69stHhKO1CA==
X-Gm-Gg: ASbGncv3UeEDJOnUKylOljseL3QUc0IkzHrLmgd2Rt5+Od7j1Hxs3ypnG8yASTYaEg3
	2HEQf4kfuci/BLELPisAPL8MPgNi+qdgLIXyBMh4MGFnfrQW/tyrZ5j/IYN8OM6rumD73Dt3BkZ
	k5BdXGCezWUcpRNnyKvLvnXHDJ3oz1EiszXFCFfld4btvD47iuPINAx98eQVSyy52kBfAr4/DbW
	4g1pQQoOB1HeEUiForKlY+U3LtvZjnW5jVwsS9VdnjagCdxbAdOtZRBtAsTPv/w+riOA9vxAMzY
	uwEyddreNwKJtxFfS0z5fdCewG15
X-Google-Smtp-Source: AGHT+IGn3W76KCgmgMIkQT/WdD1sCcWCm5LqI+wFsAmXytxdLRcHtMo25bA2WjiLnRFQbbwNF4GiZg==
X-Received: by 2002:a05:600c:3494:b0:434:a315:19c with SMTP id 5b1f17b1804b1-438dc3a85b3mr56757135e9.3.1738236244282;
        Thu, 30 Jan 2025 03:24:04 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:846f:7c2d:e5a5:73a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438d75de282sm49377315e9.2.2025.01.30.03.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2025 03:24:03 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,  "Jonathan Corbet"
 <corbet@lwn.net>,  linux-kernel@vger.kernel.org,  Bill Wendling
 <morbo@google.com>,  Justin Stitt <justinstitt@google.com>,  Nick
 Desaulniers <ndesaulniers@google.com>,  bpf@vger.kernel.org,
  llvm@lists.linux.dev,  workflows@vger.kernel.org
Subject: Re: [RFC 0/6] Raise the bar with regards to Python and Sphinx
 requirements
In-Reply-To: <cover.1738166451.git.mchehab+huawei@kernel.org> (Mauro Carvalho
	Chehab's message of "Wed, 29 Jan 2025 17:09:31 +0100")
Date: Thu, 30 Jan 2025 09:33:30 +0000
Message-ID: <m2zfj87ij9.fsf@gmail.com>
References: <cover.1738166451.git.mchehab+huawei@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> This series comes after https://lore.kernel.org/linux-doc/87a5b96296.fsf@trenco.lwn.net/T/#t
> It  increases the minimal requirements for Sphinx and Python.
>
> Sphinx release dates:
>
> 	Release 2.4.0 (released Feb 09, 2020)
> 	Release 2.4.4 (released Mar 05, 2020) (current minimal requirement)
> 	Release 3.4.0 (released Dec 20, 2020)
> 	Release 3.4.3 (released Jan 08, 2021)
>
> 	(https://www.sphinx-doc.org/en/master/changes/index.html)

It's worth mentioning here that my fix for the C performance regression
landed in Sphinx 7.4.0. All versions from 3.0.0 to 7.3.x are much slower
for building the kernel docs. See #12162 here:

https://www.sphinx-doc.org/en/master/changes/7.4.html#id7


