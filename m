Return-Path: <bpf+bounces-28907-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FCD8BEA62
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 19:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 031F8B22E05
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 17:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159FC16C69B;
	Tue,  7 May 2024 17:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="DbOoRlzU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA58116C44A
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 17:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715102394; cv=none; b=OktEliCE6s2TKs9cvAP7u3Rz32gsxrM9InHtijWKNxx127AnI8/izUZhXM8GSW+e6/DOfYeewp2ikEWyGACqnPmguMmRwQMlYiCUgfkdwyKcCByfIiBgSluu16L6LsWpaOvKBsL4inNJ5xBNh98KKJkE12gnfv3EUhJ+yCx7uXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715102394; c=relaxed/simple;
	bh=hki5D+Qvj+YNsq8Oqb0RxIzlOFGOD1jr6olQST48t2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EpRmK3CGo9eeg2HnNRZM22+djng06IzJotM18yCTclZHMn8uiT7EFzblSG7xM7UOff0+mElYe8f5Zt7oWaRF+BA8nxjylWUrHPzOMQoZtysz4injqGe2XjUSz3IR3FqhbwgpFTmx2GXU7PCSHrTEvuIaVhTe4vmjEkP4e9npUGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=DbOoRlzU; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-34aa836b948so814061f8f.3
        for <bpf@vger.kernel.org>; Tue, 07 May 2024 10:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1715102391; x=1715707191; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bM/Dw+slNgawZzGt48alAXy5N8w9IYCinYKDze4Obec=;
        b=DbOoRlzUXnytxDtn5IiQed5xXYB0O51ofSNRbsp+JOs7CXqXMLIyzOwIJWjhzXYDrN
         jab9rWWBG2ZgohVzF80qh858zCy5Uaok54YjNATrQYoaVqrfh3kwV4r0mcPk2fNR4Zuo
         Ypa2f4r6YSgVN8RtieAjGX59c1LrTCnlGhQsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715102391; x=1715707191;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bM/Dw+slNgawZzGt48alAXy5N8w9IYCinYKDze4Obec=;
        b=tLdS87sO+3zZ7Zpgd/2gD/3XwAFe/Mh8KBiJsF+zJmbevd1X4NhHGuIrScM4UJWmHk
         5Ozij5I+ypQgg8XMlEomwIbjQpswdkPdS72cK9Ynk4y4NKXQwH8N1n9AxTIzlRACxW+F
         6e+k/1/MNOqjUHmT58NsM6zFqD/paxG1M/BsMw53vsuA6/z4ae8YLHAgutYsL+LDaUf0
         t1UZlLC/Q49JZXb8s+QJZM5qy8qErjD2VyVNGwMQBB0I8gwUZKfYX6i65/2jBno9Jlm/
         L2w7ri93Z1dFSJbulhCIcKghgvVYlo1C0YgqL22pv2ITFoxADMTKRYyE6wDIwf+C9yEW
         GF4g==
X-Forwarded-Encrypted: i=1; AJvYcCVE8hkDMDuivLW3CugpUZReivBf9WSHVsrOEYNv94YKBxnpn8hKcOiujizxLi5iemgtC8t2LTMe2ZO1eKHaltBco110
X-Gm-Message-State: AOJu0YyOMFMc0b8ZbjLhifA9IP3pLxr+tlPZDv5GjTG4ICAxVJBu8Vj5
	Yaxpub4H/hVnCIv4Hj1cVhGa2zM1JMhquqUZagFf5Ar5czjSN2ypnVpUv6jOOB8=
X-Google-Smtp-Source: AGHT+IGjYrAFJPkOT/+jV38wR5mJiJ3AoSBk6cawRCaea6OsXoRTzzuMP8kcLArTQhqp2IAKTK96/Q==
X-Received: by 2002:a05:600c:1ca0:b0:41a:bc88:b84 with SMTP id 5b1f17b1804b1-41f71cc26f6mr3013945e9.1.1715102390920;
        Tue, 07 May 2024 10:19:50 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id c10-20020adfef4a000000b0034a3a0a753asm13300068wrp.100.2024.05.07.10.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 10:19:50 -0700 (PDT)
Date: Tue, 7 May 2024 19:19:46 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Mina Almasry <almasrymina@google.com>,
	Christoph Hellwig <hch@infradead.org>,
	Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Kaiyuan Zhang <kaiyuanz@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Simon Horman <horms@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Florian Westphal <fw@strlen.de>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Jens Axboe <axboe@kernel.dk>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Aleksander Lobakin <aleksander.lobakin@intel.com>,
	Michael Lass <bevan@bi-co.net>, Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Richard Gobert <richardbgobert@gmail.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Breno Leitao <leitao@debian.org>, David Wei <dw@davidwei.uk>,
	Shailend Chand <shailend@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>
Subject: Re: [RFC PATCH net-next v8 02/14] net: page_pool: create hooks for
 custom page providers
Message-ID: <ZjpisrsAZdqTXuLT@phenom.ffwll.local>
Mail-Followup-To: Jason Gunthorpe <jgg@ziepe.ca>,
	Mina Almasry <almasrymina@google.com>,
	Christoph Hellwig <hch@infradead.org>,
	Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Kaiyuan Zhang <kaiyuanz@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Simon Horman <horms@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Florian Westphal <fw@strlen.de>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Jens Axboe <axboe@kernel.dk>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Aleksander Lobakin <aleksander.lobakin@intel.com>,
	Michael Lass <bevan@bi-co.net>, Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Richard Gobert <richardbgobert@gmail.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Breno Leitao <leitao@debian.org>, David Wei <dw@davidwei.uk>,
	Shailend Chand <shailend@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>
References: <20240403002053.2376017-1-almasrymina@google.com>
 <20240403002053.2376017-3-almasrymina@google.com>
 <ZjH1QaSSQ98mw158@infradead.org>
 <CAHS8izM0=xc2UhUxhnF_BixuFs5VaDV9W1jbso1K+Rg=35NzeA@mail.gmail.com>
 <ZjjHUh1eINPg1wkn@infradead.org>
 <20b1c2d9-0b37-414c-b348-89684c0c0998@gmail.com>
 <20240507161857.GA4718@ziepe.ca>
 <ZjpVfPqGNfE5N4bl@infradead.org>
 <CAHS8izPH+sRLSiZ7vbrNtRdHrFEf8XQ61XAyHuxRSL9Jjy8YbQ@mail.gmail.com>
 <20240507164838.GG4718@ziepe.ca>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240507164838.GG4718@ziepe.ca>
X-Operating-System: Linux phenom 6.6.15-amd64 

On Tue, May 07, 2024 at 01:48:38PM -0300, Jason Gunthorpe wrote:
> On Tue, May 07, 2024 at 09:42:05AM -0700, Mina Almasry wrote:
> 
> > 1. Align with devmem TCP to use udmabuf for your io_uring memory. I
> > think in the past you said it's a uapi you don't link but in the face
> > of this pushback you may want to reconsider.
> 
> dmabuf does not force a uapi, you can acquire your pages however you
> want and wrap them up in a dmabuf. No uapi at all.
> 
> The point is that dmabuf already provides ops that do basically what
> is needed here. We don't need ops calling ops just because dmabuf's
> ops are not understsood or not perfect. Fixup dmabuf.
> 
> If io_uring wants to take its existing memory pre-registration it can
> wrap that in a dmbauf, and somehow pass it to the netstack. Userspace
> doesn't need to know a dmabuf is being used in the background.

So roughly the current dma-buf design considerations for the users of the
dma-api interfaces:

- It's a memory buffer of fixed length.

- Either that memory is permanently nailed into place with dma_buf_pin
  (and if we add more users than just drm display then we should probably
  figure out the mlock account question for these). For locking hierarchy
  dma_buf_pin uses dma_resv_lock which nests within mmap_sem/vma locks but
  outside of any reclaim/alloc contexts.

- Or the memory is more dynamic, in which case case you need to be able to
  dma_resv_lock when you need the memory and make a promise (as a
  dma_fence) that you'll release the memory within finite time and without
  any further allocations once you've unlocked the dma_buf (because
  dma_fence is in GFP_NORECLAIM). That promise can be waiting for memory
  access to finish, but it can also be a pte invalidate+tlb flush, or some
  kind of preemption, or whatever your hw can do really.

  Also, if you do this dynamic model and need to atomically reserve more
  than one dma_buf, you get to do the wait/wound mutex dance, but that's
  really just a bunch of funny looking error handling code and not really
  impacting the overall design or locking hierarchy.

Everything else we can adjust, but I think the above three are not really
changeable or dma-buf becomes unuseable for gpu drivers.

Note that exporters of dma-buf can pretty much do whatever they feel like,
including rejecting all the generic interfaces/ops, because we also use
dma-buf as userspace handles for some really special memory.
-Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

