Return-Path: <bpf+bounces-1102-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B338E70E18D
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 18:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F9C21C20DD0
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 16:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C992068A;
	Tue, 23 May 2023 16:20:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A231F19E
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 16:20:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6D0E4F
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 09:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684858774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ta0TTukxf/yuFKWKhRvQkdmYEgZbKYn62o9tRnW5LPY=;
	b=ioVqdfgC2kDKt9lJodnnkwIYX0KhE4XYRNubylkr6T0HySwtbiM7H7FBOvdGElp5LKPp0K
	G3XE7LkiikFxKnFJaXU+f1V86A2G2pxGtWeJnmWrXDW+Z9T16idYpApfj2PYWkYBl94M9g
	6Z7NQMEgFQm77+5fi1aCEheIaLmfciA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-HIql68vvNWWTIpORTKj3LA-1; Tue, 23 May 2023 12:19:32 -0400
X-MC-Unique: HIql68vvNWWTIpORTKj3LA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9715654ab36so103602266b.0
        for <bpf@vger.kernel.org>; Tue, 23 May 2023 09:19:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684858771; x=1687450771;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ta0TTukxf/yuFKWKhRvQkdmYEgZbKYn62o9tRnW5LPY=;
        b=Kd9SaoaBToIUDylFjoUy4y+vO97zPr4kCGwGCuqqZ2wISqCpSjQFXca3fh4jZFRGjJ
         66mBxdw2B+ldhysVuMB9Bu5ZRvF+4VlHFzVb1k/mxIUVzgwxv15OXhRCLfAJB3Ik0cV6
         BXx3B64lQruMAAWpec1wIQCrRxj58mdzw2gM+dM4i62nRLjziDlUWcyaKhw/rrsTUPCS
         9iyuvp3/LxrmYtGXmmAMqUULaNVz3SfopUJBbLsQYzoBczbbE1jjz4Mxo6V3lZBpHlGs
         9DFkqDBQx6f10ClUEO0K9FOFVnl1+jrE+7QP6SYgptJOxoDwVHoea6zYnaiLtyMdS8v9
         HV5A==
X-Gm-Message-State: AC+VfDwulG2XAeyScug6tgM9W+A98dqp7xr2jW7/UiyRGLi+UTW70mvK
	PcVkfhJjBcKaYDiQGjim2V+CXDKwq+8NMhnoTUNTriKq2y7vSiW3zoe6UKLdGPknKUKfYSE8qOU
	9icgEt9wSjfC7
X-Received: by 2002:a17:906:da89:b0:95e:d3f5:3d47 with SMTP id xh9-20020a170906da8900b0095ed3f53d47mr12106898ejb.48.1684858771260;
        Tue, 23 May 2023 09:19:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7KAbuTxsTAfHexWrricZ1m12j1S3s66Y0eWlvhqdzPPLrB7v6BV4ymSdnU+urffEnjwfE7PA==
X-Received: by 2002:a17:906:da89:b0:95e:d3f5:3d47 with SMTP id xh9-20020a170906da8900b0095ed3f53d47mr12106869ejb.48.1684858770773;
        Tue, 23 May 2023 09:19:30 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id u7-20020a170906950700b0096f71ace804sm4576112ejx.99.2023.05.23.09.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 09:19:30 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 430B6BBC9CB; Tue, 23 May 2023 18:16:15 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <brouer@redhat.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, netdev@vger.kernel.org, Eric Dumazet
 <eric.dumazet@gmail.com>, linux-mm@kvack.org, Mel Gorman
 <mgorman@techsingularity.net>
Cc: Jesper Dangaard Brouer <brouer@redhat.com>, lorenzo@kernel.org,
 linyunsheng@huawei.com, bpf@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 willy@infradead.org
Subject: Re: [PATCH RFC net-next/mm V4 2/2] page_pool: Remove workqueue in
 new shutdown scheme
In-Reply-To: <168485357834.2849279.8073426325295894331.stgit@firesoul>
References: <168485351546.2849279.13771638045665633339.stgit@firesoul>
 <168485357834.2849279.8073426325295894331.stgit@firesoul>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 23 May 2023 18:16:15 +0200
Message-ID: <87h6s3nhv4.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>  void page_pool_destroy(struct page_pool *pool)
>  {
> +	unsigned int flags;
> +	u32 release_cnt;
> +	u32 hold_cnt;
> +
>  	if (!pool)
>  		return;
>  
> @@ -868,11 +894,45 @@ void page_pool_destroy(struct page_pool *pool)
>  	if (!page_pool_release(pool))
>  		return;
>  
> -	pool->defer_start = jiffies;
> -	pool->defer_warn  = jiffies + DEFER_WARN_INTERVAL;
> +	/* PP have pages inflight, thus cannot immediately release memory.
> +	 * Enter into shutdown phase, depending on remaining in-flight PP
> +	 * pages to trigger shutdown process (on concurrent CPUs) and last
> +	 * page will free pool instance.
> +	 *
> +	 * There exist two race conditions here, we need to take into
> +	 * account in the following code.
> +	 *
> +	 * 1. Before setting PP_FLAG_SHUTDOWN another CPU released the last
> +	 *    pages into the ptr_ring.  Thus, it missed triggering shutdown
> +	 *    process, which can then be stalled forever.
> +	 *
> +	 * 2. After setting PP_FLAG_SHUTDOWN another CPU released the last
> +	 *    page, which triggered shutdown process and freed pool
> +	 *    instance. Thus, its not safe to dereference *pool afterwards.
> +	 *
> +	 * Handling races by holding a fake in-flight count, via artificially
> +	 * bumping pages_state_hold_cnt, which assures pool isn't freed under
> +	 * us.  Use RCU Grace-Periods to guarantee concurrent CPUs will
> +	 * transition safely into the shutdown phase.
> +	 *
> +	 * After safely transition into this state the races are resolved.  For
> +	 * race(1) its safe to recheck and empty ptr_ring (it will not free
> +	 * pool). Race(2) cannot happen, and we can release fake in-flight count
> +	 * as last step.
> +	 */
> +	hold_cnt = READ_ONCE(pool->pages_state_hold_cnt) + 1;
> +	WRITE_ONCE(pool->pages_state_hold_cnt, hold_cnt);
> +	synchronize_rcu();
> +
> +	flags = READ_ONCE(pool->p.flags) | PP_FLAG_SHUTDOWN;
> +	WRITE_ONCE(pool->p.flags, flags);
> +	synchronize_rcu();

Hmm, synchronize_rcu() can be quite expensive; why do we need two of
them? Should be fine to just do one after those two writes, as long as
the order of those writes is correct (which WRITE_ONCE should ensure)?

Also, if we're adding this (blocking) operation in the teardown path we
risk adding latency to that path (network interface removal,
BPF_PROG_RUN syscall etc), so not sure if this actually ends up being an
improvement anymore, as opposed to just keeping the workqueue but
dropping the warning?

-Toke


