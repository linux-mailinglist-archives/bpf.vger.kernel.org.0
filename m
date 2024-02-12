Return-Path: <bpf+bounces-21767-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0719851E94
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 21:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E7B02816FD
	for <lists+bpf@lfdr.de>; Mon, 12 Feb 2024 20:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9755481B8;
	Mon, 12 Feb 2024 20:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7yg78Ty"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B334E482C0
	for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 20:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707769298; cv=none; b=gTayIX+HEgV90n5+ar9R/8GXi6/UzMf7LnuKAtjxZ8Xgy3U8THfvlm3s6BgJowiGkaICL46eHoghiZBb/S+0N60clEVs2Qhs+BQSK3nh5kBx/ZLyVFGB0Sh05BvQhuYH8fJMyaS3laqs0ElKpqooXqIrGrSY3qPH1FeeBaXFNuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707769298; c=relaxed/simple;
	bh=N66AZoaKzq/CEvQ+la0vd6qQhVz2VqCbjeOFzoIccak=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nJbyB8DitejcZBcNjoxrCJvRZckJEZXyvpmi27r8/RyX3HIbkvATBJpnL5cSQmuEFDjYbXsZ6yd2VfKPeW6DWPyX0LcgXTOmEl0O25fJlIa+C6bipLRkqkRLKiiQ/Bw9Y9t8x4oLnBQNw/ixyhck3ExigvG6AORAOV07H73Br2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7yg78Ty; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d107133b6fso287651fa.3
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 12:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707769295; x=1708374095; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N66AZoaKzq/CEvQ+la0vd6qQhVz2VqCbjeOFzoIccak=;
        b=R7yg78TyRbm4lqMmKnv6BhssrgJWxLNPwmeKWV/QbhcP1nYL+eDC49FvpdFqiyGf0v
         3rvzGgs1jwQz4l5P1G8C54h3VSvSzLZj+TO67K0ixyRmMmWW9gkrZzvxzPKITGiPvRDo
         olQI0AzE5GIzXGUjLVvXUpoR6eAsgWdwKwpOVSWMITDIAy/Pgv8wap0k8f92b9dmnchp
         iM5PuQqFC4XUwFm8bUSaepkej/e2Q7uZFLpGckJ8GO+rfEYAKgXdp7phbJou1eypDGS4
         ObZA0AFEKic/mdiLqmy9G2lcFGbhkWDVIoQVVJYPvxi2pnXEfqjGplIjWr6tfvCKutDC
         Ilpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707769295; x=1708374095;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N66AZoaKzq/CEvQ+la0vd6qQhVz2VqCbjeOFzoIccak=;
        b=jcrmWy/ttRdQyWdiwLS+AOL7pVjdZRjUkwxuoixElooYvcEBBEysXG4YpmMCADhstw
         gnWpeIqrqt45Csh6aexA+XGzyZMXkNVlCkxM2GeYPNRn9iGPh793d85zcd4bhaoI9qBQ
         TArMzzWJis14qmBdpExZ7hpQORbOBxb9sJD7A5l6J7nvdxdpSzjWLuCdRh+w47lVyi6r
         NlFrg0KRCfM5u2a6LMnvuoIBU22k+OWfpVtdsdV7PfC0lPZ9PjAco1VwnL7X3CmNl+2N
         fTXs7/YKfJpR05a/kWWMme3ua/JWcRcvHlk6eBxrJ3iYUwH2TOXr1aIVJhG4vGxL166c
         ZLOQ==
X-Gm-Message-State: AOJu0Yyxvmjn7/Y2G3cJakhdumYGiP0xA8Ijf2GkwtfYzuZqgORfPmUJ
	TxQx0fPaSzblfEK3+hGJ2o2jYdAL6QM5etn/HXItf062vRMZtni5
X-Google-Smtp-Source: AGHT+IFjrSM9jU90iQ6jQrUhRh/xONekQternGuenadDAIZmdAuq7Yzy8KrWKQrdZvGsVpLYGY4REw==
X-Received: by 2002:a2e:95cc:0:b0:2d0:aecf:3a3 with SMTP id y12-20020a2e95cc000000b002d0aecf03a3mr5892400ljh.14.1707769294490;
        Mon, 12 Feb 2024 12:21:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXMDtfvzQnlKRt1UQxQfe7eOjvXCa6s0VDzY7RMf3NGA319djDlsNE5PnaEswaQIG7082pQjY9aGrdm8wPpkbxRfknmD9Z8VAmWBkkQ5gg/Fd9BtHPM+9GJN2Rro+lWAgws3J3i3ZD7gTT4URm/07yUSo5sBornrocRlTXQwMYf88D0VT3Eo8M5X9Kh/NLXiLi8DAPV0UOyw9opw/9PJUW8gGxGn4C/fBDpVo/8inAHVOyVahci+zMgF0ShzNsZDUKVSwvqPSzJEthHbE+gbhbGlK9zZ13TCw8hk52uLpOpnZtGxWAwCMJKZlxG3GLCSdXyMxFDIlsd0W0PaEC0WTGbRZDRLgSkd0zjrV3cUrRZYRQcFqatBFZCZA==
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id s7-20020a05640217c700b005602346c3f5sm3061213edy.79.2024.02.12.12.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 12:21:33 -0800 (PST)
Message-ID: <76ec9b657e4a16ad29b928114fbc207318c6e53b.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 12/20] libbpf: Add support for bpf_arena.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, Tejun Heo <tj@kernel.org>,  Barret Rhoden
 <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Lorenzo Stoakes
 <lstoakes@gmail.com>,  Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Date: Mon, 12 Feb 2024 22:21:27 +0200
In-Reply-To: <CAADnVQLxymxv5TGsu94=FznK9qqZjSLfwq4k2BSxg-v0FCVuSA@mail.gmail.com>
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
	 <20240209040608.98927-13-alexei.starovoitov@gmail.com>
	 <59623808ebfd5ecd48cdb4c07a28326d777e7769.camel@gmail.com>
	 <CAADnVQLxymxv5TGsu94=FznK9qqZjSLfwq4k2BSxg-v0FCVuSA@mail.gmail.com>
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

On Mon, 2024-02-12 at 12:14 -0800, Alexei Starovoitov wrote:

[...]

> It doesn't and doesn't work for ringbuf either.
> I guess we can add a filter by map type, but I'm not sure
> how big this can of worms (extra checks) will be.
> There are probably many libbpf apis that can be misused.
> Like bpf_map__set_type()

Right, probably such extra checks should be a subject of a different
patch-set (if any).

