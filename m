Return-Path: <bpf+bounces-17537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B8B80EEAF
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 15:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12B30281ACE
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 14:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4E073195;
	Tue, 12 Dec 2023 14:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UIduafO1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55359D3
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 06:27:05 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-54cdef4c913so13617066a12.1
        for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 06:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702391224; x=1702996024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bCZPRFlYELlSqnd7f+LApbuWWSOTUwHuWf2lhre3cTY=;
        b=UIduafO1DT3E/9yl00OWV+EjecVJ2FWvoAE4REaS2pOQdZ5ihOPnmfePL8xZYamHU+
         0bXdkQaFPcH+FNZUpV7sZkEfd1gxLFPT7iafcK+X1tDXmEDEmcxRpFnLgOAi5rKjJSJE
         kPh9hyCUmvQcO6XQlE9+02ZQ9DAaghh/c0BDDAnoU0hXa9ki1ZKwacHa16PIjHxqmaqU
         wx1GQSmZ2SY8SXxd7oAzT5MhZ2IaE6sVCFpAlw4lA3vJU6CF9WDBKObpxNNV3XxiTls4
         qYzMjNmnbxO2y0Fdcv2yT4IOj3kaBYFvTAcGYv5O4HzqMn0R7j8VITzuWnP+Jdg5UaMy
         +51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702391224; x=1702996024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bCZPRFlYELlSqnd7f+LApbuWWSOTUwHuWf2lhre3cTY=;
        b=LZYXbfGjPjUbDjwygD5c502+deF8PJrTZBonb2laxF1dg6idksGpPY/3G/GTudVghv
         iGAdbm0lal7gKUdOGwHUzt6pE1n5JWgAWjpLnxbSPLA/IaqptrWdQ2wYkIY8DtkKhjZx
         71DLh0v34U5lTH5E//M4AgI1GYrOG0Ypu+EZqsHi77rICXa7Q8I/LMIdH1MYcL7ltpjO
         4P9nH/5r08UHjvj61A8LCSHJkyrhEV6n1/fTW2tG/JfcX0iceh/VRoVkzsNT1CdAzuoT
         Wd5a3nxU6JcDVLuM9VpnFio/ae/48JH8esNn+QXo8Tlyq6z07pd4I8sDU1EfWcu5dcUw
         +MYw==
X-Gm-Message-State: AOJu0YyZoxMCnZ/FK0apYyW15JccXFO22vv4ZbnZLNXx3qf7LNeZdbgm
	dKuw1VkmPWjRrFn7fyNX442urb+3AtyBEVF1oxZvmQ==
X-Google-Smtp-Source: AGHT+IEOyCkF2DgwL7RBhVnTjCksBIhJaDTVsJX1VcMmek5dl3277Sns8cp70gbrdUy6r5MpVMdk0OJS5kwbSqhfdhU=
X-Received: by 2002:a17:906:51de:b0:9f2:859f:713e with SMTP id
 v30-20020a17090651de00b009f2859f713emr7079811ejk.3.1702391223630; Tue, 12 Dec
 2023 06:27:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208005250.2910004-1-almasrymina@google.com>
 <20231208005250.2910004-9-almasrymina@google.com> <20231212122535.GA3029808@nvidia.com>
In-Reply-To: <20231212122535.GA3029808@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 12 Dec 2023 06:26:51 -0800
Message-ID: <CAHS8izMVMx0fpT=dWsnD7piqs1g7Fam8Xf5dK3iOFNxeOQD9vQ@mail.gmail.com>
Subject: Re: [net-next v1 08/16] memory-provider: dmabuf devmem memory provider
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Shailend Chand <shailend@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	David Ahern <dsahern@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeelb@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>, Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 4:25=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Thu, Dec 07, 2023 at 04:52:39PM -0800, Mina Almasry wrote:
>
> > +static inline struct page_pool_iov *page_to_page_pool_iov(struct page =
*page)
> > +{
> > +     if (page_is_page_pool_iov(page))
> > +             return (struct page_pool_iov *)((unsigned long)page & ~PP=
_IOV);
> > +
> > +     DEBUG_NET_WARN_ON_ONCE(true);
> > +     return NULL;
> > +}
>
> We already asked not to do this, please do not allocate weird things
> can call them 'struct page' when they are not. It undermines the
> maintainability of the mm to have things mis-typed like
> this. Introduce a new type for your thing so the compiler can check it
> properly.
>

There is a new type introduced, it's the page_pool_iov. We set the LSB
on page_pool_iov* and cast it to page* only to avoid the churn of
renaming page* to page_pool_iov* in the page_pool and all the net
drivers using it. Is that not a reasonable compromise in your opinion?
Since the LSB is set on the resulting page pointers, they are not
actually usuable as pages, and are never passed to mm APIs per your
requirement.

--=20
Thanks,
Mina

