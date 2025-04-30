Return-Path: <bpf+bounces-57073-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEB0AA5280
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 19:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C415189EAEE
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 17:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466E6261372;
	Wed, 30 Apr 2025 17:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cstYuyrp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2139982C60
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 17:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746033604; cv=none; b=cTp2D8dKfp0JSb0AjOeBWCIOHajjp3vHrBoUdAhDMMoZ5g5fLsQSHjHC+zCghuWpBjyUz6kYLs2DyVzq7vtMN5YoCgDFDxrgwWv3++r7X+2/SUHPmDmwd3xXPYavDG7xfrqSVXPaZOf8d6v4Fo40wQT+kAVsNtFIH9b/QqVqmAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746033604; c=relaxed/simple;
	bh=4agHAlTJ10wgWbpiJMdV8wG+97KD0OqyVrP8cpo7qH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMST3ShUq+ktDoLIeSsl8ZH3Gb4YYKrCXkBnNZdmsDhq/nhm7AuD8qIehvfM2YjqSOW6WXYfLW3iFoArv8PdwmoLVASfzy1iP1X6C1OwvqeqFZiQKW6WPP0gSd0gEBwAsELtH3sQTR2wvFeZjYHMTZyDD4ARreOTXS0ZV14I6Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cstYuyrp; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-acb5ec407b1so7290966b.1
        for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 10:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746033601; x=1746638401; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vgw2UvbxdHasEXeiHFqTQG4znHWsZoNF+TbXCTZy7a4=;
        b=cstYuyrp30lEHnW4jHS3jCS8njyfBEG83GVIO95HCvv+bE9PH7SI8cIg0H4yiq4VGz
         +U/mrGNa/IHCfkKmsEfBD6CELu8Fil7CFtQ9TFVLKCbMORihWG7+Pwo1+Mh4BqqERJDg
         W86EqYGPw8501/aVpiKbvIwHhc5Qk0rQlKzKrp+l4ySOQQ9VKfqGQoKGHIGtp8DzwzuA
         nIAt0wkSmaN1K07MJ305kzFuYHd9RsR5dHgwWmodtFGbSh9Jfb6Pk4TAxYj3tlu+luwv
         4G+OBvXiREkCdFSZE7xuPg+evlV1Qc5yQJjdQuMTWB/+yJIktwv2BrLoutW5rK8W7e8E
         /5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746033601; x=1746638401;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vgw2UvbxdHasEXeiHFqTQG4znHWsZoNF+TbXCTZy7a4=;
        b=OqaSLATyaZbM195isdhkVNqDrduNMqM3Dc+OkJsHY6nmSw6a7YCzgxUGkNu2tHVvsJ
         TOVc6U6T9FZZu8Bofij/DSEbHw74G2tBvNvvIyXS5j8LGoYE1DC3qxXAjL7Gdq/BLpCK
         rV0tk7v1A+04YIesdJrRwDozO7A7NLebflqR6jChqpo5DVqtB7jIba0gwUq1Bkljj9Se
         sURYswyJsy/LlNR2j74VZ4TaSLX4qxkq6JtphKH2ZJKpbr+6XuMOdsmVZ4GUz9wbtYWU
         YDuSGCRl3WUxDPbh2tAt5nvFZqSNWn/lb4fDxVhIvCClXbq/2783ASHdZT59cBJRiLkp
         Luww==
X-Forwarded-Encrypted: i=1; AJvYcCVdkAGEcZrxHEgvHOPR6p3zL4c8Qc0CvsHA0+fAdweebOT1j/ihnL0tpe8pihEW4oB1wTA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq0dcakxjCc3xX8c2WCRnLQibXW+pD4SmDoJ7M+F+5O+poY3og
	k6JsaI458qyao4esOAP+AeYMZMMmQpL9Wi3RASaVxt82zV/I/aoZ
X-Gm-Gg: ASbGncvlKlhKrYj1/ueAwN0EbkYw3Rhpis0yumQll7ncOoM9vs4fURJZEdtLcp+yo8N
	tn6iELcKEmwkfyD766ndDitpUFLeOMSaS6kUlGUztAS7CzP/ltd5PF042gOyUBhsgvgyLVN/d4n
	f4RGygnQhxTaJZq6kaw+gDPQlhXLqFfM93v+bLl0J1TmZRfHwaGRidnYW1DJpJDJl8Wa9bk8D1a
	yb38KjFWDw/o1S5o2sab7CZ+EgC1NxP4MXAFJvyyYXch0EQk0ccZaTRc+d5+uzQ1l/BFIbwM+UN
	iaImcTSnagmhVMuR9vmw5OxvMQ5GPP/IBBifY+8UWTHwhJ5J8vY=
X-Google-Smtp-Source: AGHT+IFi5jroYyRz6pYmQj8Xdp/C+RiWW9SoWcfbHItkyedW7gNDXv+HvM6BWMidM17EwyD+AJe8rA==
X-Received: by 2002:a17:907:970a:b0:aca:95e7:ec59 with SMTP id a640c23a62f3a-acee21af132mr359525766b.19.1746033601183;
        Wed, 30 Apr 2025 10:20:01 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acec668dd9csm301217166b.96.2025.04.30.10.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 10:20:00 -0700 (PDT)
Date: Wed, 30 Apr 2025 17:24:46 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v2 bpf-next] bpf: fix uninitialized values in
 BPF_{CORE,PROBE}_READ
Message-ID: <aBJc3hrKnKA8jiM0@mail.gmail.com>
References: <20250429142241.1943022-1-a.s.protopopov@gmail.com>
 <CAEf4BzYeKLgqn+yq3Mt+Vv-9t6qmzQqimb31zD=y-Cw474LU5w@mail.gmail.com>
 <aBJQ6lsZfg8xlM5e@mail.gmail.com>
 <CAADnVQJV5SMRvt_0YvdRdCys4oBR-x3baqBBmp1mxAeUx=EtJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJV5SMRvt_0YvdRdCys4oBR-x3baqBBmp1mxAeUx=EtJw@mail.gmail.com>

On 25/04/30 09:34AM, Alexei Starovoitov wrote:
> On Wed, Apr 30, 2025 at 9:29 AM Anton Protopopov
> <a.s.protopopov@gmail.com> wrote:
> >
> > On 25/04/30 09:00AM, Andrii Nakryiko wrote:
> > > On Tue, Apr 29, 2025 at 7:19 AM Anton Protopopov
> > > <a.s.protopopov@gmail.com> wrote:
> > > >
> > > > With the latest LLVM bpf selftests build will fail with
> > > > the following error message:
> > > >
> > > >     progs/profiler.inc.h:710:31: error: default initialization of an object of type 'typeof ((parent_task)->real_cred->uid.val)' (aka 'const unsigned int') leaves the object uninitialized and is incompatible with C++ [-Werror,-Wdefault-const-init-unsafe]
> > >
> > > this is BPF-side code, what does C++ have to do with this, I'm confused...
> >
> > This I am not sure about why exactly, but clang (wihout ++) emits this warning
> > now (try smth like `clang -c -x c - <<<'void foo(void) {const int x;}'`).
> > When sending patch, I though that CORE* macros also can be used by ++ progs.
> > For C, maybe, this is a problem with clang that it enables -Wdefault-const-init-unsafe?
> >
> > >
> > > Also, why using __u8[] is suddenly ok, and using the actual type
> > > isn't? Eventually it all is initialized by bpf_probe_read_kernel(), so
> > > compiler is wrong or I am misunderstanding something... Can you please
> > > help me understand this?
> >
> > So, when a const sneaks in, one have BPF_CORE_READ expanded into
> > say smth like this:
> >
> >     ({
> >     typeof(((parent_task)->real_cred->uid.val)) __r;
> >     BPF_CORE_READ_INTO(&__r, (src), a, ##__VA_ARGS__);
> >     __r;
> >     })
> >
> > It happens that real_cred is a pointer to const, so __r becomes const,
> > and thus the warning (if enabled) is legit.
> >
> > With __u8 this turns into (let T = typeof(((parent_task)->real_cred->uid.val)))
> >
> >     ({
> >     __u8 __r[sizeof(T)];
> >     BPF_CORE_READ_INTO(&__r, (src), a, ##__VA_ARGS__);
> >     * (T *) __r;
> >     })
> >
> > So here we do not care if T is const or not, as __r is not in any case.
> 
> The problem with __u8 approach is that it's losing alignment.
> Have you tried typeof_unqual instead ?
> Modern gcc and clang support it directly.

Yes, thanks, typeof_unqual should work.

> For older compilers we have __unqual_typeof() in bpf_atomic.h

Older compilers aren't a problem, as build only fails on modern
(LLVM added -Wdefault-const-init-unsafe for C just a few days ago).

