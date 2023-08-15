Return-Path: <bpf+bounces-7814-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B7E877CEC1
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 17:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE1631C20B8B
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 15:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E4214282;
	Tue, 15 Aug 2023 15:13:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF56713AEF;
	Tue, 15 Aug 2023 15:13:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091121991;
	Tue, 15 Aug 2023 08:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=3FVkfmimyGLe7ZQLw14Bh2D/6Fym3SH8k3h8yeiqRQU=; b=gmRUb9WNZ1BobTGE+WroBYMCGl
	VnvndwBnm8gMluT/dcWJcPsQAD6bVncAtBXWdu7gVyMZhWErV/7upSyu62pyq2QmzlFetaQpEnh2M
	UAb8l/5UoZkiUgaDvFfMjP1txW3ONUpohtdTUOj2IjbVjNAKiTqSls1orWH2rWDgiBtlpTidb38tr
	Sfm7/fYiBxZBX6F2CE3zRq4QPl/LOKga/QCiqtVXwh15V/rVBINul+ZkaL9ZpWYH6IHhMb/rirGkS
	V+I80XXGzu0dK1J6H1hWm1wG+n9pY2Z6MLNFBcyoeXBX7t3b1e10ibPoVQNVnOrrOkMxMoSAXPxi6
	TabqlluQ==;
Received: from [2601:1c2:980:9ec0::2764]
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qVviz-001pNO-13;
	Tue, 15 Aug 2023 15:12:49 +0000
Message-ID: <c52210ab-48a5-d6bf-26ee-b828df0f9408@infradead.org>
Date: Tue, 15 Aug 2023 08:12:47 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v6 5/6] page_pool: update document about frag API
Content-Language: en-US
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Alexander Duyck <alexander.duyck@gmail.com>,
 Liang Chen <liangchen.linux@gmail.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Eric Dumazet <edumazet@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>, linux-doc@vger.kernel.org,
 bpf@vger.kernel.org
References: <20230814125643.59334-1-linyunsheng@huawei.com>
 <20230814125643.59334-6-linyunsheng@huawei.com>
 <479a9c1f-9db7-61c8-3485-9b330f777930@infradead.org>
 <0cbf592e-2f21-30ca-799e-5cc15e89c3f8@huawei.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <0cbf592e-2f21-30ca-799e-5cc15e89c3f8@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/15/23 05:24, Yunsheng Lin wrote:
> On 2023/8/15 6:42, Randy Dunlap wrote:
>> Hi--
> Thanks for the reviewing.
> 
> ...
> 
>>> @@ -100,6 +115,14 @@ static inline struct page *page_pool_alloc_frag(struct page_pool *pool,
>>>       return __page_pool_alloc_frag(pool, offset, size, gfp);
>>>   }
>>>   +/**
>>> + * page_pool_dev_alloc_frag() - allocate a page frag.
>>> + * @pool[in]    pool from which to allocate
>>> + * @offset[out]    offset to the allocated page
>>> + * @size[in]    requested size
>> Please use kernel-doc syntax/notation here.
> Will change to:

Thanks. Those look good.

-- 
~Randy

