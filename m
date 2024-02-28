Return-Path: <bpf+bounces-22892-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5DC86B5F9
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 18:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03E851F2203B
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 17:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F03C12F38F;
	Wed, 28 Feb 2024 17:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0wcDoDv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6430B3FBA2
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 17:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709141340; cv=none; b=Pd7t3s1C+HNMSUDIsDH6qs4wCvDkg1DKf59gl3g5y6z+L/cJJtCg8AvgyNTcju+AlK86+9X2oLSA6LencFKygXDXe8jfq3zHOI7EefILjmWeoFhEU6p53Yu7Lf1zaU1Kdj5WpJFUZd+QJ08eim4LsrmYszdZiV/ITaaJiRhq7N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709141340; c=relaxed/simple;
	bh=ZdjAHQ8Oxt7GE6y8YnkR0dRVjsCIBJ9ZrHeONo1lXrA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YiLz/AP6Wnv6LIEFA0nrl7xTQJS4rReMcvxtRjOWAiThanK3zpFDE+McBWik2VdxMkHdVPUL4IJNXryr/vdsw+ic1ipL6ukdTudRK5ut7qufBxSuBYnY35A0/RglSiIf71tO6t2rwm72TkpJ1Xn/MxI5+E+RYyfKUNpeszAHINw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0wcDoDv; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51320ca689aso319576e87.2
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 09:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709141336; x=1709746136; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZdjAHQ8Oxt7GE6y8YnkR0dRVjsCIBJ9ZrHeONo1lXrA=;
        b=g0wcDoDvqe4FNldHjGKN9Jg4AwYa3+Z1mdKWcx6p++fiNH/pGwjeZLKRIB73rP23eJ
         ZFMCLG0CH17sNoQi0gw8DAb/K/ouMiX3r8OV/5aEfk3Pv3CH3k6PJ4PGs73kfPUzbkK7
         umU3UVkKJd6DDJdJnXPoQydyhhkZ36MXJrNq02I9zkQ1ZGwFLlC1MHnS3YI76CD8HNua
         uitXvn0rSavyr68Tf7YOkdZxQDrAAuHn4IksD5EUdXiZHTz+i8ZJDSE+wTZZJZTe2rC/
         PAe8ZBPFaQ+FHivpF9WnUuXiTO/iWsCnIiUsI4D9g20X44eszQhJnbKfaSDMBu0iwo+k
         rZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709141336; x=1709746136;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZdjAHQ8Oxt7GE6y8YnkR0dRVjsCIBJ9ZrHeONo1lXrA=;
        b=plyqg9U0LLnqBNwnVjpHY0CZ1I4VqjOfSdpkWD8FYSEY9kosjB1Xsg8DJ3dZBA1ti2
         w+JiVQOprlgYh/LnRgRS1bV7utq7GY8FOyCold16HiZLUu3BOfmYs8NLOQ3p+cagIDQv
         yzwZCvIrpXNITW/cPLtas/tbUTykqCw2fmz9hra+PsiKxSl3/R2eg0VVMF3y4J8lzrIF
         yPO5nYysKfUYkVceTrRWRvq2q+LLbvfj5fzTrwfctdUZQ4AEsmh3T9hnfUTtYM8L7xYd
         Aa3/28Yy+xd7xabEwY4Z4oMs8/ghISolOfPovYsyV4prb7UiD65hKmm1G9pwBDEOHS1k
         50Gw==
X-Gm-Message-State: AOJu0YxT6VyXeNKqImQLshLGZNtHFWkJIJlV+mxeVocDE4zgIlBOdOc5
	5MS6iGgC7ffXxjkMDjEoujrHJgzp2Fh6jC2kLk8GRglKmtR+P289
X-Google-Smtp-Source: AGHT+IFIT94ZXT/5pRJcdxIyygfbMl208sMte8sjIpMr4uabgOAvCMKng+2aAWlNr0GKkbPEWWnq+w==
X-Received: by 2002:a19:4357:0:b0:512:e4f4:bf2f with SMTP id m23-20020a194357000000b00512e4f4bf2fmr233000lfj.15.1709141336300;
        Wed, 28 Feb 2024 09:28:56 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id q8-20020ac25a08000000b005132040de84sm72369lfn.111.2024.02.28.09.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 09:28:55 -0800 (PST)
Message-ID: <a369e0b2cd129cbfc8e33d2c61ed78265c21982d.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 1/8] libbpf: allow version suffixes
 (___smth) for struct_ops types
From: Eduard Zingerman <eddyz87@gmail.com>
To: David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev
Date: Wed, 28 Feb 2024 19:28:49 +0200
In-Reply-To: <20240228162936.GA148327@maniforge>
References: <20240227204556.17524-1-eddyz87@gmail.com>
	 <20240227204556.17524-2-eddyz87@gmail.com>
	 <20240228162936.GA148327@maniforge>
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

On Wed, 2024-02-28 at 10:29 -0600, David Vernet wrote:
[...]

> Modulo the leak pointed out by Kui-Feng in another thread. It would be ni=
ce if
> we could just do this on the stack, but I guess there's no static max siz=
e for
> a tname.

GCC documents [0] that it does not impose name length limits.
Skimming through libbpf's btf.c it looks like it does not impose limits eit=
her.
I can add a name buffer and a fallback to strdup logic if tname is too long=
,
but I don't think this code would ever be on the hot path.

[0] https://gcc.gnu.org/onlinedocs/gcc/Identifiers-implementation.html#Iden=
tifiers-implementation

