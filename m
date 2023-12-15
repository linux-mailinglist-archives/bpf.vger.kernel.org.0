Return-Path: <bpf+bounces-17928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F3F813F56
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 02:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B5E5B21E38
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 01:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45C8804;
	Fri, 15 Dec 2023 01:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPJ8PLMA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EBC10F3;
	Fri, 15 Dec 2023 01:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40c2c65e6aaso1974805e9.2;
        Thu, 14 Dec 2023 17:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702604614; x=1703209414; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZPXPBhj6r6wn/s7iUr6Ov+9BGjRNtkcDIxrWuGzYqqU=;
        b=RPJ8PLMAbBBFLXfhdNL/hD+S1YytfI9setztdjqgghfH4hCHL7rwAGWSzd0x/wiuFB
         Zr9D04NK+L/Rqqyb0/ShhhU4wgA7Koii5vaMmMl+6UfdSv1NW5p/gk1gdARneZZw38S1
         L02bynZhEyQ0cQ/XoIQgxI9wGgoWLCv5OCN22TBax0ARRGCOmwo1+X4Sv/qAAv6Wop+I
         bckt045hU1ZgA9Y/XeXYfyvD0d7PDabxgLbbdz7JrTe91XgFqWqS+hKF2VLdQ1b665gz
         qjEZI3ztMO25Bf4FYl3l5WTEeo/pXX3jzFDrYkq7GAv/3W59ZXfJNVCiwLYeiUJEsDam
         N1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702604614; x=1703209414;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPXPBhj6r6wn/s7iUr6Ov+9BGjRNtkcDIxrWuGzYqqU=;
        b=Uj3L5Yfd4EwLg6DOsObRHIDPOy4A5CWzFD3yrRK+CJT8V1FPnOWUEIcF0bUga0b6uM
         FLR4VCYiy3a7/jK8UG7/uuiYUPn/hhfUnJZkn5/3F7qnXxRo3RoUSsP0b0ccP5lRk3k+
         4RCT+EwkYIIO9d9JXRl5XAHe7pwfay1Oa58Jbj1kdw9DvkHvzsTqKHe4Q+8xyY84bQKW
         xMhaa/klsDjWFIeukTBoSsKZUHVaOoUADc4OBhrwm2AibUE8FZraL77nzrGIneyRYgW2
         cdPu02A+HAH4rvwD+7YRdz8mQgfDdk5z6pnyI/Dim83Oz9Efpd8hfR+bjjl7ApOI0Czi
         XkMQ==
X-Gm-Message-State: AOJu0YzvH4m9GjNxfOS+qIntgoWn/1my6vZGTkZgB2GSDwGaaBaAnmsS
	/+5xgHwNN/4eRSZ2vcyktu4=
X-Google-Smtp-Source: AGHT+IGHbvX/KwnnFSDijk7FhPD1SJcKVFFkFn1IWOSVYXK88SCVtOeGj0OJgpawZ/uIv8bh4y5CIQ==
X-Received: by 2002:a05:600c:1913:b0:40b:5e21:bde8 with SMTP id j19-20020a05600c191300b0040b5e21bde8mr5092782wmq.119.1702604614043;
        Thu, 14 Dec 2023 17:43:34 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id p18-20020a5d6392000000b003333a216682sm17313271wru.97.2023.12.14.17.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 17:43:33 -0800 (PST)
Message-ID: <feffb6294801f156ed049d47483164e0d51aa77b.camel@gmail.com>
Subject: Re: [Bug Report] bpf: incorrectly pruning runtime execution path
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Hao Sun <sunhao.th@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>
Date: Fri, 15 Dec 2023 03:43:32 +0200
In-Reply-To: <2b49b96de9f8a1cd6d78cc5aebe7c35776cd2c19.camel@gmail.com>
References: 
	<CACkBjsbj4y4EhqpV-ZVt645UtERJRTxfEab21jXD1ahPyzH4_g@mail.gmail.com>
	 <CAEf4BzZ0xidVCqB47XnkXcNhkPWF6_nTV7yt+_Lf0kcFEut2Mg@mail.gmail.com>
	 <CACkBjsaEQxCaZ0ERRnBXduBqdw3MXB5r7naJx_anqxi0Wa-M_Q@mail.gmail.com>
	 <480a5cfefc23446f7c82c5b87eef6306364132b9.camel@gmail.com>
	 <917DAD9F-8697-45B8-8890-D33393F6CDF1@gmail.com>
	 <9dee19c7d39795242c15b2f7aa56fb4a6c3ebffa.camel@gmail.com>
	 <73d021e3f77161668aae833e478b210ed5cd2f4d.camel@gmail.com>
	 <CAEf4BzYuV3odyj8A77ZW8H9jyx_YLhAkSiM+1hkvtH=OYcHL3w@mail.gmail.com>
	 <526d4ac8f6788d3323d29fdbad0e0e5d09a534db.camel@gmail.com>
	 <2b49b96de9f8a1cd6d78cc5aebe7c35776cd2c19.camel@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-12-15 at 03:24 +0200, Eduard Zingerman wrote:
[...]
> Here is an option that would fix the test in question, but I'm not
> sure if it covers all cases:
> 1. At the last instruction of each state (first instruction to be
>    backtracked) we know the set of IDs that should be tracked for
>    precision, as currently marked by mark_precise_scalar_ids().
> 2. In jump history we can record IDs for src and dst registers when new
>    entry is pushed.
> 3. While backtracking 'if' statement, if one of the recorded IDs is in
>    the set identified at (1), add src/dst regs to precise registers set.

Nah... this won't work for "second order" ids.

    --- suppose r2.id =3D=3D r3.id here
    if r3 > 10 goto exit;
    r1 +=3D r2
    ... use r1 as precise ...

