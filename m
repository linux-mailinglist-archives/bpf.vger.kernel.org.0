Return-Path: <bpf+bounces-39300-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C265697139F
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 11:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4491E1F22D0D
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 09:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A861B5EAE;
	Mon,  9 Sep 2024 09:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecqXSOc/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43191B583E;
	Mon,  9 Sep 2024 09:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725874113; cv=none; b=AkERejZrvu25/IOq3dyntt8epiF3cLyphygGFqdBJ6gquXcNE6fRllS7tysBkIsSuCyFetN9k3jJHINYtsrAvExxQBNymqnvXBAWUeUlkvb6ccuQD7Yua9UHEmihVzvrJutu7twiXZunnVZC0IyZvvm671cDUDhdz0RDbXtu+/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725874113; c=relaxed/simple;
	bh=kZH5eo/1uAd5WCreOVMSYm+T3MJidsStra30feYvEUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BbsHLd3Fd1iUCrHqZ49O9Q2hYVHTzGRnFh9d5jvLl21C3OqyWhywUA3k54yXBSxUARFSda5DHXdMulVf7bC17PMyIS5ZYIHigm/yVHbjO4ArVuzCZPFa0mDWNv/9WH8aCJmnuiwpsZFjqV1DGg3OJpK6QVt4iBKfLeJpPC5KMxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecqXSOc/; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42c79deb7c4so35090305e9.3;
        Mon, 09 Sep 2024 02:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725874110; x=1726478910; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+FFw/GaDw/HIOFJV8gzwucJA51cqMscpFl4auNoY6JM=;
        b=ecqXSOc/h0B9J4Qeic49MnU0Ek/KMz9onkB+UGmm96Ec7CHr8GvcSc6MkDzK0Ae7pR
         TDcZtwvwVChajVEQ5vGHkhAveUgmBgyVMJcZCuSKkOYhILFxVo/5Mx7d0JcuSWP48zDV
         LEXsegFih8rR0cwgAkMC8rj0Q30hAnd8EZBXmaYYiWJvFmTKqIGnqM/ilOMEAY7K+pgS
         ioYNv3/+lOBQ/HRTCiJK0f5xPB2mYDrqt/qMMZ34RI+KGVc09ZQUhDCEuvgzuVDV0kOK
         Oq3+jDk/xjlAVgebs2AUjKowx4qx2VFxi970dWZ72AIY23Xd8o7pBF9msVitFBXp6UmY
         XUKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725874110; x=1726478910;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+FFw/GaDw/HIOFJV8gzwucJA51cqMscpFl4auNoY6JM=;
        b=adcyaX2VEpOaxhF4W+5klbqTRcu/7Vnfd/d4bldm/0pGc6pcH4btx5y+cPhJgDLadc
         Brii1jQ+CY0mSbUHahWuH5nG/240MokQeoKHNV+9aENxXIMbg5OG6Y1sA3UyqfMvDY4E
         ERUy0UaR+ZK+xPM6WC0/ftgN4Fe4+yvutq6ViOvOlfG+dRBKugQsQ3hteetm0FRr9Oxh
         ygS0Mn/BJRTimNe9+1oP00p7Oif+hAXEv1LKnlLsLqwBbWQNWySp9w08wDzpDETXIdDa
         3YuJ0f+YNuXOFHIIxGDodCtjPZlIXsVhGsudnAjbLkq3vD1jHEhGZBcrtMriPc1fOU6n
         DRhw==
X-Forwarded-Encrypted: i=1; AJvYcCWapHYv3dGR8TfAUWzbgvSVnUJHOlSJdALdTIwcAz+rEKab+wFL9j8k9YrurQri0e3TOSCkkzAMxHSO6tCOavyD@vger.kernel.org, AJvYcCWoBb8gg2g1l4SkFvrnHcPHqaUkvRHitfphrGLCMrF+u3ugnpm3uceESHRPusBM46jZDEo=@vger.kernel.org, AJvYcCXbqSanhPDhPQiXHdw87ZWXcwNSsSvmFxnETWQNGmR2QgZXdGe+7PBgXzmidWgFULAwBzJNTw8uyqhSM2kA@vger.kernel.org
X-Gm-Message-State: AOJu0Yxptj5Ir1Skb3tc9nVVZNP74BAxkITU1EyHfacgzd6Jn6gOuP1Q
	1K1FSGWguSGGqdKRQ9BOph3tlaniYnc76kvDijiJ0iKwPS+wZx3Q
X-Google-Smtp-Source: AGHT+IHpORaL/4UNQ1S4rW8l3O60M5C7KaPil4A0ODWWppQcQFsD2mGT2mvaxVw4vxct4diWzTtvGg==
X-Received: by 2002:a7b:c858:0:b0:42c:af06:71b with SMTP id 5b1f17b1804b1-42caf060978mr41865625e9.28.1725874109169;
        Mon, 09 Sep 2024 02:28:29 -0700 (PDT)
Received: from void.void ([141.226.14.150])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d3765sm5522076f8f.74.2024.09.09.02.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 02:28:28 -0700 (PDT)
Date: Mon, 9 Sep 2024 12:28:25 +0300
From: Andrew Kreimer <algonell@gmail.com>
To: Quentin Monnet <qmo@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] bpftool: Fix a typo
Message-ID: <Zt6_uUdXRE33PdFk@void.void>
References: <20240907231028.53027-1-algonell@gmail.com>
 <c63c6c0d-80f0-4e44-8e02-b12ff365f4eb@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c63c6c0d-80f0-4e44-8e02-b12ff365f4eb@kernel.org>

On Sun, Sep 08, 2024 at 08:20:01PM +0100, Quentin Monnet wrote:
> On 08/09/2024 00:10, Andrew Kreimer wrote:
> > Fix a typo in documentation.
> > 
> > Reported-by: Matthew Wilcox <willy@infradead.org>
> > Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> > ---
> >  tools/bpf/bpftool/Documentation/bpftool-gen.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/bpf/bpftool/Documentation/bpftool-gen.rst b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
> > index c768e6d4ae09..6c3f98c64cee 100644
> > --- a/tools/bpf/bpftool/Documentation/bpftool-gen.rst
> > +++ b/tools/bpf/bpftool/Documentation/bpftool-gen.rst
> > @@ -172,7 +172,7 @@ bpftool gen min_core_btf *INPUT* *OUTPUT* *OBJECT* [*OBJECT*...]
> >      CO-RE based application, turning the application portable to different
> >      kernel versions.
> >  
> > -    Check examples bellow for more information how to use it.
> > +    Check examples below for more information how to use it.
> Thanks! Since we're at it, would you mind fixing the rest of the
> sentence, too?
> “Check _the_ examples below for more information _on_ how to use it”

Done.

> 
> Quentin

