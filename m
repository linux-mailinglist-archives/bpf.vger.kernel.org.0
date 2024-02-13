Return-Path: <bpf+bounces-21812-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC5E85258C
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 02:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66A8E289E08
	for <lists+bpf@lfdr.de>; Tue, 13 Feb 2024 01:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4839CEBE;
	Tue, 13 Feb 2024 00:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyQhQyEe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DDE1CAA9
	for <bpf@vger.kernel.org>; Tue, 13 Feb 2024 00:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707785346; cv=none; b=BLJdwYvz5KUG9WJ65HZxBy2H7HuJT7mRfW56kPcCYLwemaFB30k4sjx53A6DdUSGxLRLlRAL3MfXTD0tvFScb/4K5pTyPMwZnX8FH1mWYDhsd0ZGXJSm6QwBiepaARM7f7Z9adLvRVO+GPgyQc9Wdfx/h373J/0o/hHM1eiO1ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707785346; c=relaxed/simple;
	bh=lu/brvjSSleY1eS2L23tlLVXTd19SBoAtmpY4CrDI7k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QjItWQmfHr43UwWChzxn/N5j86/1RWRb4gA1NSRtLWco06NzYR/i7OKeku5NSo2fsUnArHcdvRsFcVQmuQEK0+EQ1/iMV4kEeFiQXq/9qdIh01Ej1XlvktxZlXeiEj7ZNfvWPoj0OFroaQGBiSwSzgvVhcvQoqwMZdob+zNsp4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EyQhQyEe; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3cfacf0eadso17017466b.2
        for <bpf@vger.kernel.org>; Mon, 12 Feb 2024 16:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707785343; x=1708390143; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/dwE/gJs3UjhLkiVxd8ovvyGICgHNTOI+7wm4P8nOQE=;
        b=EyQhQyEenKIG3d0atL0FthiNDp3Vr9OFEl/p7OpM/mwn++NvrP/87QgJvtXIuT817H
         zoKOJMmo31hvc9ZiBmB5flv2NBAO8zK9MsOYh9W9vjyW2PJiVaNCDN9m5P0Ukg6dpnHV
         Sr3k/AcdkN9zJVm4rLS+neBVSG5RPlw8pahd28A08q/B0tH9M7Wyu6J95P/vfvdACNx/
         qi0ZkTm3ShNEVwkQO1yj1noGCnT++cx0Y7iwYS6gStGEF2gluTg9IlqfNE7gzoHK1yUL
         gDkB0d66EJIIjdk5GdX+K0AWNBkC5pwE7zO9XaJCcX6qvRTUReumg+ogcEXtxjl/wuNp
         Yn2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707785343; x=1708390143;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/dwE/gJs3UjhLkiVxd8ovvyGICgHNTOI+7wm4P8nOQE=;
        b=J4I9Dwisn9mye8VJmOP0+sVNofVq8/rb9CM2x/lxNOjO3cWVPqfhr+EWZZ7oPv663O
         v1YVfZdhvVDj6DlW+uEyGSNzCmS2NMoC9t2ZgrCN62vtHrr638k/4cM7Rpk7xkqQ3F3j
         U5y2MTpplJpQVreLr/XAQ+VqcjxBNeUPfKmBirlNDwY2BrHrfHLnDDWuZ+ZqdOfRQvXr
         NsNSQuHXR1SNeMmh6QISMsfVrHxXI5csKnH86m3Q5dprKVA41Vdn4LWMnLfPsb+R4ZwV
         PEqvogqGD6uYm23TbRw+hsjX4nnXi7ah+VWEotWEWyYfx3PObYSQw4797PlKRD8yHA3E
         a5bg==
X-Gm-Message-State: AOJu0YwDii6jsQJNtiVBqidn/aKEOfeJK9kUuzukcR30fWJFU9vlRGiE
	ITT7NtHHvHQHJvGM/MkQ1tv0aLJaFrO8pNtF667jGDhY7f37eVBb
X-Google-Smtp-Source: AGHT+IHIYyHIvasJPYh6N03Sm0e3bNL3POKRUz5X/TG+aZ7P3YoEygEh1A7UXrykLL0Pyj7ztfQTHQ==
X-Received: by 2002:a17:906:4c57:b0:a3c:8a77:e67d with SMTP id d23-20020a1709064c5700b00a3c8a77e67dmr3416738ejw.59.1707785343422;
        Mon, 12 Feb 2024 16:49:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWVEMAUG5ZdA41WmN+K04yTub5KSlMncD3n5y/BosNSomLGmeJorCc/JPjggPJoERPq1XsbF/iRV11XMdBfJwApx+ZzU/jsaqz/RkZyPJGA2n++LEOpcjMKoedEjBcAMma/PW3dKe05PwrZlMoiPbEifDGdhJHbnrLVB7Vrj657N/ZkIA1jGNcxYWZsGRCMqorOqHIDrT66IwGK5fuVBukWqbdMpz82sIAIaaJ8TcVYzyG4Ceq/YKClkOu7bbbxpHa4g+t+pcVI65rYsEBLehZL8yt3zR+nKYb+OjEyBV/9a9byxWogammXplD3HEKixlXqWnUZdOyQm5sF+A60ea9DOg5aZkikufHewV6gjxC74fnQ4d9iNMAjUQ==
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id gz3-20020a170906f2c300b00a3793959b4asm715477ejb.134.2024.02.12.16.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 16:49:03 -0800 (PST)
Message-ID: <d5b827ea37af7b5ac71bede71f17c96e8c434422.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 14/20] libbpf: Recognize __arena global
 varaibles.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi
 <memxor@gmail.com>, Tejun Heo <tj@kernel.org>,  Barret Rhoden
 <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Lorenzo Stoakes
 <lstoakes@gmail.com>,  Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Date: Tue, 13 Feb 2024 02:49:01 +0200
In-Reply-To: <CAADnVQKTHfRWxBm08O7CcKri1NOSTS8vby3+ez2gRVM_XYEfKg@mail.gmail.com>
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
	 <20240209040608.98927-15-alexei.starovoitov@gmail.com>
	 <d84964662e2e11e6c94da99c7c3e8a8591d1376c.camel@gmail.com>
	 <CAADnVQKTHfRWxBm08O7CcKri1NOSTS8vby3+ez2gRVM_XYEfKg@mail.gmail.com>
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

On Mon, 2024-02-12 at 16:44 -0800, Alexei Starovoitov wrote:
> > I hit a strange bug when playing with patch. Consider a simple example =
[0].
> > When the following BPF global variable:
> >=20
> >     int __arena * __arena bar;
> >=20
> > - is commented -- the test passes;
> > - is uncommented -- in the test fails because global variable 'shared' =
is NULL.
>=20
> Right. That's expected, because __uint(max_entries, 1);
> The test creates an area on 1 page and it's consumed
> by int __arena * __arena bar; variable.
> Of course, one variable doesn't take the whole page.
> There could have been many arena global vars.
> But that page is not available anymore to bpf_arena_alloc_pages,
> so it returns NULL.

My bad, thank you for explaining.

