Return-Path: <bpf+bounces-11517-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6CD7BB1FB
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 09:09:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7D8A28226D
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 07:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC3063C6;
	Fri,  6 Oct 2023 07:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wkfpe55G"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE89DEBB;
	Fri,  6 Oct 2023 07:09:44 +0000 (UTC)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8E2F2;
	Fri,  6 Oct 2023 00:09:42 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99de884ad25so320935666b.3;
        Fri, 06 Oct 2023 00:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696576181; x=1697180981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=V5ladE5tkTaw6kg06jFlVzHqN5oLjCVd34OCxyKLMKo=;
        b=Wkfpe55GrPAvLwktd4peSsGxo8mvBHJBkOxUeMIMg6OWyLIqp7l+vIhpO8iBcMoP1K
         1OO5Ty+22T9tU9mDDFSi0XaB+oaIdaeLSM7rRj2wGHmAn520zEAZmcJc2dyephNj+JMY
         A12M0ZhJKfE/H4EXOKZw5Qiez3sx10z6DZgXIoi2h+HItuEMkifC5KOuxuHp9mkztsJd
         nNbc1ZPMFClPWrNWnOfJHG0d0rQ58yC3tjM/IC7M/Tpxd4AvjMRLlyDwrzV7QK8MRYbx
         xeCsvwashLlXpiGQjrAQTxqyrDft8y1ebveN2EaeEqdmFt7EtCrBJfAVEOl9Vl/I0ctb
         STwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696576181; x=1697180981;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5ladE5tkTaw6kg06jFlVzHqN5oLjCVd34OCxyKLMKo=;
        b=UQxF0lsFqns816LKH7CWRuez/eTQ8CS7Y4b4xfRkSw6VGvqqm+HWQl7hNu+7BTLFBW
         w92FHB11AQa+NVBic0DJ6uxi6k2+LOjXEQ0p3LDsCMTyDMSjKLnk26dlXmUj8E8XpGwV
         S+wOMbBHCRKwjolf40ocjb04o1pwZLKoVK8ARCJtZj1tZzSKN76nTRh3jhshL+bYUUMj
         2OPUM7/d2ytLKmbLp5SlZ7Th3dEnR6bjOB700AtJVnLaMyLD8j1vKaUjr0BbQqfo2hPd
         ZWTrAgrzBDRWY98Kok1pg9i2qPnzbpLCAPGlXPUKEEeU6dF1MK4s0bADdQbxTc6/5Jxg
         W52g==
X-Gm-Message-State: AOJu0YzSVt04aBn82zZQNVWkg5eUYamGk9OwivN2evdWd8rPM2Cx8CVJ
	kdz8jE7OQn/5TFyi4q/zsWQdZ25avbLLhuPk
X-Google-Smtp-Source: AGHT+IEhkKlWhY9En4mCZRCfskhgcjCs7rAtjGq2BhW+LxJgq8JJ78L9ycc/ObnygNJjxQHecLZ7+A==
X-Received: by 2002:a05:6512:282b:b0:505:7371:ec83 with SMTP id cf43-20020a056512282b00b005057371ec83mr7661985lfb.48.1696576169648;
        Fri, 06 Oct 2023 00:09:29 -0700 (PDT)
Received: from akanner-r14. ([77.222.24.57])
        by smtp.gmail.com with ESMTPSA id r26-20020ac25a5a000000b00502c6dc612fsm184811lfn.219.2023.10.06.00.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 00:09:28 -0700 (PDT)
Message-ID: <651fb2a8.c20a0220.8d6c3.0fd9@mx.google.com>
X-Google-Original-Message-ID: <ZR+yfWLkv4rrr0i6@akanner-r14.>
Date: Fri, 6 Oct 2023 10:09:20 +0300
From: Andrew Kanner <andrew.kanner@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: linux-kernel-mentees@lists.linuxfoundation.org, netdev@vger.kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+fae676d3cf469331fc89@syzkaller.appspotmail.com,
	syzbot+b132693e925cbbd89e26@syzkaller.appspotmail.com,
	bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, aleksander.lobakin@intel.com,
	xuanzhuo@linux.alibaba.com, ast@kernel.org, hawk@kernel.org,
	john.fastabend@gmail.com, daniel@iogearbox.net
Subject: Re: [PATCH bpf v3] net/xdp: fix zero-size allocation warning in
 xskq_create()
References: <20231005193548.515-1-andrew.kanner@gmail.com>
 <7aa47549-5a95-22d7-1d03-ffdd251cec6d@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7aa47549-5a95-22d7-1d03-ffdd251cec6d@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 05, 2023 at 06:00:46PM -0700, Martin KaFai Lau wrote:
[...]
> > diff --git a/net/xdp/xsk_queue.c b/net/xdp/xsk_queue.c
> > index f8905400ee07..c7e8bbb12752 100644
> > --- a/net/xdp/xsk_queue.c
> > +++ b/net/xdp/xsk_queue.c
> > @@ -34,6 +34,11 @@ struct xsk_queue *xskq_create(u32 nentries, bool umem_queue)
> >   	q->ring_mask = nentries - 1;
> >   	size = xskq_get_ring_size(q, umem_queue);
> > +	if (unlikely(size == SIZE_MAX)) {
> 
> What if "size" is SIZE_MAX-1? Would it still overflow the PAGE_ALIGN below?
> 
> > +		kfree(q);
> > +		return NULL;
> > +	}
> > +
> >   	size = PAGE_ALIGN(size);
> >   	q->ring = vmalloc_user(size);
> 

I asked myself the same question before v1. E.g. thinking about the
check: (size > SIZE_MAX - PAGE_SIZE + 1)

But xskq_create() is called after the check for
!is_power_of_2(entries) in xsk_init_queue(). So I tried the same
reproducer and divided the (nentries) value by 2 in a loop - it hits
either SIZE_MAX case or the normal cases without overflow (sometimes
throwing vmalloc error complaining about size which exceed total pages
in my arm setup).

So I can't see a way size will be SIZE_MAX-1, etc. Correct me if I'm
wrong, please.

PS: In the output below the first 2 values of (nentries) hit SIZE_MAX
case, the rest hit the normal case, vmalloc_user() is complaining
about 1 allocation:

0x20000000
0x10000000
0x8000000
[   41.759195][ T2807] pre PAGE_ALIGN size = 2147483968 (0x80000140), PAGE_SIZE = 4096 (0x1000)
[   41.759621][ T2807] repro-iter: vmalloc error: size 2147487744, exceeds total pages, mode:0xdc0(GFP_KERNEL|__GFP_ZERO), nodemask=(null),cpuset=/,mems_allowed=0
[...]
0x4000000
0x2000000
0x1000000
0x800000
0x400000
0x200000
0x100000
0x80000
0x40000
0x20000
0x10000
0x8000
0x4000
0x2000
0x1000
0x800
0x400
0x200
0x100
0x80
0x40
0x20
0x10
0x8
0x4
0x2

-- 
Andrew Kanner

