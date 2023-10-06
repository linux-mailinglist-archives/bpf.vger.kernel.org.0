Return-Path: <bpf+bounces-11594-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E24447BC328
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 01:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CEAC282292
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 23:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FDC47361;
	Fri,  6 Oct 2023 23:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bRp8bZaQ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7785C47355
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 23:58:34 +0000 (UTC)
Received: from out-198.mta1.migadu.com (out-198.mta1.migadu.com [IPv6:2001:41d0:203:375::c6])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5D3BE
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 16:58:32 -0700 (PDT)
Message-ID: <eb61966f-8666-80f6-1eab-c89bffe496b8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1696636709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dDT9aDLVsvLOYEEw3RfZqvCDnW1m/iupVkMyeiBZkag=;
	b=bRp8bZaQOTZ0RK9xi0lir38QHE8v8QBKgJcvmeoeYaNR/IEA1nPc6gk1SCWnOrW3geE8q5
	SFeTWujgrha+ovCuE032fSZ5wTFtw5twahhoma/m66jMNpq33ud9K9jtJClu9970B1GWn+
	XA3wZYQCtHyiI655HDSBavI2iGp6Mfg=
Date: Fri, 6 Oct 2023 16:58:18 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v3] net/xdp: fix zero-size allocation warning in
 xskq_create()
Content-Language: en-US
To: Andrew Kanner <andrew.kanner@gmail.com>
Cc: linux-kernel-mentees@lists.linuxfoundation.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+fae676d3cf469331fc89@syzkaller.appspotmail.com,
 syzbot+b132693e925cbbd89e26@syzkaller.appspotmail.com, bjorn@kernel.org,
 magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
 jonathan.lemon@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, aleksander.lobakin@intel.com,
 xuanzhuo@linux.alibaba.com, ast@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, daniel@iogearbox.net
References: <20231005193548.515-1-andrew.kanner@gmail.com>
 <7aa47549-5a95-22d7-1d03-ffdd251cec6d@linux.dev>
 <651fb2a8.c20a0220.8d6c3.0fd9@mx.google.com>
 <57c35480-983d-2056-1d72-f6e555069b83@linux.dev>
 <6520971d.a70a0220.758e3.8cf7@mx.google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <6520971d.a70a0220.758e3.8cf7@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/6/23 4:24 PM, Andrew Kanner wrote:
>> Thanks for the explanation, so iiuc it means it will overflow the
>> struct_size() first because of the is_power_of_2(nentries) requirement?
>> Could you help adding some comment to explain? Thanks.
>>
> The overflow happens because there's no upper limit for nentries
> (userspace input). Let me add more context, e.g. from net/xdp/xsk.c:
> 
> static int xsk_setsockopt(struct socket *sock, int level, int optname,
>                            sockptr_t optval, unsigned int optlen)
> {
> [...]
>                  if (copy_from_sockptr(&entries, optval, sizeof(entries)))
>                          return -EFAULT;
> [...]
>                  err = xsk_init_queue(entries, q, false);
> [...]
> }
> 
> 'entries' is passed to xsk_init_queue() and there're 2 checks: for 0
> and is_power_of_2() only, no upper bound check:
> 
> static int xsk_init_queue(u32 entries, struct xsk_queue **queue,
>                            bool umem_queue)
> {
>          struct xsk_queue *q;
> 
>          if (entries == 0 || *queue || !is_power_of_2(entries))
>                  return -EINVAL;
> 
>          q = xskq_create(entries, umem_queue);
>          if (!q)
>                  return -ENOMEM;
> [...]
> }
> 
> The 'entries' value is next passed to struct_size() in
> net/xdp/xsk_queue.c. If it's large enough - SIZE_MAX will be returned.

All make sense. I was mostly asking to add a comment at the "if (unlikely(size 
== SIZE_MAX)" check to explain this details on why checking SIZE_MAX is enough.

