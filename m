Return-Path: <bpf+bounces-58349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9534FAB8F53
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 20:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A13E1BC2EB9
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 18:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EFC28A3ED;
	Thu, 15 May 2025 18:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nai52/T5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1F727FD6E;
	Thu, 15 May 2025 18:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747335047; cv=none; b=bF+4J+SREiF6bjpgVygN/W3E2fPAzpeyecJQIlz+NgyV+OqGa8NV1MrY9PtEap3Z0STYlvixnLjESQGyk/ExpXf8yIYoq9dn/245g5SAIhs6DUfsPGGJ6nEAlQS9utnHps1Si+5u7eh3NRCeTEtgawpqiHwpDp8dCt9BJjWVm6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747335047; c=relaxed/simple;
	bh=Ws8/Z7Kgvnnt5oC4+iZ3vidlwcn919kh/dai80ylbzM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cAZcrdHYMN9n81ox21pid6r325n2xUUVa8pFMb+VXOILbrZnIQ8HTm+0NFyIwbIJUFLKYINxTA2ErzsZ1BF8KYhwb8x7jRBEIQOnhcyp32dM/LhjKvoYWoEFJR7FvniBHeaRuP4fE9eozvLYKmAcGwucj9bLijIzjSMxTLCcoyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nai52/T5; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-73c17c770a7so1566559b3a.2;
        Thu, 15 May 2025 11:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747335045; x=1747939845; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ws8/Z7Kgvnnt5oC4+iZ3vidlwcn919kh/dai80ylbzM=;
        b=nai52/T56MiNRDVbRxTxkIRyDfD5alfGpC1DGFXBr3KQeWfC71I70IerVtcJ3y4CAF
         JWRc7R7BC50+p1mcW2O/8M32pSUK8XwsDoPIvX0q7BR4OPAfvzNle+T0AvSYed6lzb4n
         q/gGXz56zyfFpUeHToM0x0JMgzav5YX92o8YPrpid/wO/R/X395f6CYX4GGlRB5UeZ61
         p5g2QXJdY2ypN2oXhdeC7QOocnIiaIFzR6gn6g5IQ14oZwbkTweVYpMS6C0AzpVfZBxv
         bpqvM8y6ll6pJ3x+9+by0gB1Yx1H1DBqiCeSzaUOWgg8aQiEK9DDYe0vbodQ2rKj3DHz
         YlVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747335045; x=1747939845;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ws8/Z7Kgvnnt5oC4+iZ3vidlwcn919kh/dai80ylbzM=;
        b=IbkticTSwT6n2TTLLucEh8G/3qwn1JUZtLq2Phyg2/6+2RpEvg23nZS6Pe3tS7PAb2
         U2m+xpBWqB1DBKx28HT5YUKAdE5WBWfn9PvW9DFtTbOaKUmauT6jFmv9RaFXUWW2FLeR
         TA1B1Ta5MWVPMY0IvDaK2Xe1l7NomMQKVGj2d4fWEv6R0aJGT9JUR34qA09LMSNx/yaK
         g4wAwUwOYRztrYaWo98Y/8vtOATj5svLNO5r8HaSMRKqzfifh5et+l33NIMPZA+FXxKr
         GiGfT2+TJcxYftysMrIGeeTKf18WB5aZr8kbhKO/NvMHkr8/ewjzj1hYNfguGYPv7poQ
         yhbg==
X-Forwarded-Encrypted: i=1; AJvYcCUV1x06/EDDdXAxYDTBbvII9D9Kd7Xgzu/kl2Nc+w2G+PJH/KOQZH40/MTmJEnIWuHCftY=@vger.kernel.org, AJvYcCUvHPatjutpIe+zChMeZ7RLY9h0SN3LBTMSilwJvUNBYlwy6Iz1iR2yMHi+xNiApWlF3W9TjoWq/H+Hg/h3gD9M@vger.kernel.org, AJvYcCWI2MLs2rkh+MkhHVbj68Ld29iLcs/OYkSt2zyh4xaXgTYc6vCrTvNgoVtDc6366xeTAZP4EG55ESuJ/J0o@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/nNTLfLoUj+1cqjZOqqUODwFtix/Ecw40FO/4qA4gpbpg0Bx2
	V2d0z07JP5El1xIzYd30+HzlUJRAcRye6B9q75MhatKnYb6k4zs22DUC
X-Gm-Gg: ASbGncse1F9E+u3v5lMS+qIhW1gW/ivlSxtn5VIxVH4xHp2yo5yZND8n2INIY93E+zC
	YwN0VQscR2nEjte3QVz7C4ZkScS9v6oDdd1h3X/bOkXFNcvgbuqbB5Fs79yWwFFa3xbxlWArQXc
	BBU5MgRvFoa8ME85+hUHgJIqO1GCUcd6qCmdVdYZbhTUTJIM6PALCdnj5s0xlF4fza0zTZmauSK
	dwwDGkiNZ0ZXDwmU64YuwNnMHOKVPrQANqrwuUFAoPoE93vVDeIKNuq9PGljplzt/9lq4h7WFgc
	DoqByS8TCnI7P0oVU+fyBwB2avQ9XnlGWEw50HeTjgUtQUE=
X-Google-Smtp-Source: AGHT+IFyglqdQsJAvhEcHUgfaGZ2S9LjIKZpapciKX/19nJergmaqDbkE4Y1cB3JY49TnJc4utrqKw==
X-Received: by 2002:a05:6a21:3392:b0:1fd:f55f:881e with SMTP id adf61e73a8af0-216219f90f5mr941597637.36.1747335044979;
        Thu, 15 May 2025 11:50:44 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eaf8a199sm214842a12.33.2025.05.15.11.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 11:50:44 -0700 (PDT)
Message-ID: <e3eca3902ed9a68c5732d1be5792be9cda3471ed.camel@gmail.com>
Subject: Re: [REGRESSION] bpf verifier slowdown due to vrealloc() change
 since 6.15-rc6
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kees Cook <kees@kernel.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Shung-Hsi Yu	
 <shung-hsi.yu@suse.com>, bpf@vger.kernel.org, linux-mm@kvack.org, Andrii
 Nakryiko	 <andrii@kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>,
 Andrew Morton	 <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>,
 Vlastimil Babka	 <vbabka@suse.cz>, Uladzislau Rezki <urezki@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	regressions@lists.linux.dev, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  Alexei Starovoitov	 <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>
Date: Thu, 15 May 2025 11:50:42 -0700
In-Reply-To: <202505151116.4FFA176B8@keescook>
References: 
	<20250515-bpf-verifier-slowdown-vwo2meju4cgp2su5ckj@6gi6ssxbnfqg>
	 <C66C764E-C898-457D-93F0-A680983707F0@kernel.org>
	 <202505150911.1254C695D@keescook> <20250515171821.6je7a4uvmttcdiia@desk>
	 <202505151039.DAA202A@keescook>
	 <CAEf4Bzb4LZK5p08t1y-32wAFDGoRGKR1w1T_je6+a_EOE2uSYQ@mail.gmail.com>
	 <202505151116.4FFA176B8@keescook>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-05-15 at 11:24 -0700, Kees Cook wrote:

[...]

> Linux ToT fails to build, -next fails to build. v6.14.6 fails build,
> each in different ways. :(

I posted recipe [1] some time ago.
Checked it right now, everything worked w/o modifications.
Can be used as a baseline for build environment.

[1] https://lore.kernel.org/bpf/62b54401510477eebdb6e1272ba4308ee121c215.ca=
mel@gmail.com/

[...]


