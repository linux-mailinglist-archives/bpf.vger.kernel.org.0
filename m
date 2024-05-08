Return-Path: <bpf+bounces-29096-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5BD8C0196
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 17:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 127C228B86F
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 15:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B923512AAC4;
	Wed,  8 May 2024 15:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KUiojH4L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF04128803
	for <bpf@vger.kernel.org>; Wed,  8 May 2024 15:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715183899; cv=none; b=WN5cvDEiWWzqCb2F3j+Kmlmhq5bvVOW8CKODU5iX35UwbdOGVqrb/8uDWzCQHUsuDLlBO2FMfaHO6pwmu0ixAoQAH67S7J/J8U7CSdT8VkZTyUBgMVQlUU4EecG03HmdABJXa1i79ObYCavhQvyjvmyCg3V3sCccS8CQ542QKus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715183899; c=relaxed/simple;
	bh=8Q0d5ghL7esSJXn5530BhC5obw3iPkePfl6coMCDXmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hK3d8YLCUDc2SZU8l/fdMf7XlAdoaqgsR63y538H5P0e3iVjDii+KmSdZLx7WJDSqgf8/WTyenyaBPz04EDrvn6SOIA1WlEaWNCzJ75/R6uzBDGXODx4p6LhfCNHYVPxzSBnqwkEXrat/WJDTtq/1VRZtFIidoaJw1kI05Smj7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=KUiojH4L; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-69b50b8239fso8750166d6.0
        for <bpf@vger.kernel.org>; Wed, 08 May 2024 08:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715183896; x=1715788696; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fqoHV1aKLMbHVQjAORL2ZSoTVMVXNqsiEWwcIT2cGHs=;
        b=KUiojH4LesQeeoO6quuwR7nVjh0RP2E6XcLvhsjVb4t5nlyf0ETS8m29ozIxD60OV0
         raxqXEVFi4A0cm5S6doHh9fCFJB2LZkXOCOZqdd0MWi1bG2I9fn6VQAc7aX9V9HyFjfm
         jkY4Voiau7v13ScYtwzTUFfWP1Z05UYDYHO8fLz8y5hI8Pz/5gVJMTNdgL7N+rkGVquI
         8DtYHnsIzd6IbHy0zAMZOMfF497TOkBvb4SM9uYKX7ms7wlWy879pnjeNolmq7Pyuv72
         ZlBEbrpqQhGGoUE8PIRfUuYPaEO8bg4Z/SiZRZ42jHR18qASdlV7o8rIEDN7Ufp8U7PI
         TgOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715183896; x=1715788696;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqoHV1aKLMbHVQjAORL2ZSoTVMVXNqsiEWwcIT2cGHs=;
        b=hpxu9JTNx0xhKRiHtWISqlu+6ffXULdMs/Nc/7NnzR+9Lw9GpP4Tfk6PfHt0Aa0Xoo
         X0kGwfXF0JkncVS2I4Zji/9usdJIVF5YcWb82fT/U5RQoYNOIaQIUNJNQ0CZU8Yss7Qf
         dOWimH4Aj50Y2XPKAwBOUy2BxG8zKVot5yhc5L/DJUS8RxaWAxOtLTAmeQo/1lGuRwxd
         gQtha2gbQN81OLALlQGJHyIbM0c/H652wg5FrACWk+kDx4weI4hvvDfJqWFkCEkMlqr/
         f6zhBEdKIXZHFfs00ek+f2whY944MzGEItEH91yEdgkV6bZPC0ifzKQmdzRhHZZexzYh
         0ENA==
X-Forwarded-Encrypted: i=1; AJvYcCWQAj4KIFa9tNWIcik9ErJEQABanHXBBuf9jzCvDYJS9Gs/ZH4CpbSKxfmOdKVomIRxUcTq9az6OaxGp3s7NcXhiQ/X
X-Gm-Message-State: AOJu0YxEKoalgAVMrx2jTm1SbHdruyVgDilZAKv75DNiWsMHxvcbsqKQ
	F8iKNRuUkBg6BbH1Gr2QSA5HiZ2HA/M/aDkxcuZd33aInP5uwKeRjCXCgu3f0nc=
X-Google-Smtp-Source: AGHT+IHoJL5JboSaZtdo3JuvhTrGDECSyt70uMsqmpWZo0ihNDCQjPgANHuq7+Znj7wAL/DbLTGC4Q==
X-Received: by 2002:ad4:5f85:0:b0:6a0:a4db:b297 with SMTP id 6a1803df08f44-6a15cc4e35amr1166676d6.23.1715183894191;
        Wed, 08 May 2024 08:58:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id pm21-20020ad446d5000000b006a0d057073bsm5684884qvb.58.2024.05.08.08.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 08:58:13 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s4jgL-001JCw-43;
	Wed, 08 May 2024 12:58:13 -0300
Date: Wed, 8 May 2024 12:58:13 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Mina Almasry <almasrymina@google.com>,
	Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org,
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
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
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
Message-ID: <20240508155813.GS4718@ziepe.ca>
References: <ZjpVfPqGNfE5N4bl@infradead.org>
 <CAHS8izPH+sRLSiZ7vbrNtRdHrFEf8XQ61XAyHuxRSL9Jjy8YbQ@mail.gmail.com>
 <20240507164838.GG4718@ziepe.ca>
 <0d5da361-cc7b-46e9-a635-9a7a4c208444@gmail.com>
 <20240507175644.GJ4718@ziepe.ca>
 <6a50d01a-b5b9-4699-9d58-94e5f8f81c13@gmail.com>
 <20240507233247.GK4718@ziepe.ca>
 <54830914-1ec9-4312-96ad-423ac0aeb233@gmail.com>
 <20240508142530.GR4718@ziepe.ca>
 <6f69694b-4281-45a6-92aa-d9d72b918df2@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f69694b-4281-45a6-92aa-d9d72b918df2@gmail.com>

On Wed, May 08, 2024 at 04:44:32PM +0100, Pavel Begunkov wrote:

> > like a weird and indirect way to get there. Why can't io_uring just be
> > the entity that does the final free and not mess with the logic
> > allocator?
> 
> Then the user has to do a syscall (e.g. via io_uring) to return pages,
> and there we'd need to care how to put the pages efficiently, i.e.
> hitting the page pool's fast path, e.g. by hoping napi is scheduled and
> scheduled for the CPU we're running on, or maybe transferring the pages
> to the right CPU first.
> 
> Compare it with userspace putting pages into a ring, and the allocator
> taking from there when needed without any extra synchronisation and
> hassle just because it's a sole consumer.

Wow, that sounds a bit terrifying for security, but I guess I can see
your point.

You are replacing the whole allocator logic if you are effectively
putting the free list in userspace memory.

Jason

