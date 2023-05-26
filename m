Return-Path: <bpf+bounces-1288-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99475711FA0
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 08:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30DC6281673
	for <lists+bpf@lfdr.de>; Fri, 26 May 2023 06:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1EC5243;
	Fri, 26 May 2023 06:07:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AAE3D8C
	for <bpf@vger.kernel.org>; Fri, 26 May 2023 06:07:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BEA125;
	Thu, 25 May 2023 23:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=YeHMLKYZLktUZXoDtbAI9yhcE3xWnVS3PncgW4EqLBk=; b=tp+xdtdyNF52jXyBTcVwA1UTER
	ZuU7JzwtKRd6UMNN3BdJWzAfzZqtz6GRytU0kpiOcqNNLK2rCmWCn9w+qXB3n9UOtLLZqCaQv8fle
	tBBwVRhJ2MOcTef6ttqqlWJmkY+vCfYImEz/OjOmME1PSJyjkVOLiUpFQ8eQupVwFZv/0oU3hlz6h
	QBtuLCIU+Lsta0ApEeb4HVGYUIanGdPiT1w00CMZOA0D05bRF2sm50VrJRbiTzuhZXxW7kae1ARb9
	VP0fc5eiUj1I2Jg9N0S2oz8kbSy5vIOczWoVOWVr+SOuO3EpnBtmHFppW6QamVJd39TuiQmLXwYLE
	Pjsy6i8Q==;
Received: from [2601:1c2:980:9ec0::2764]
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1q2Qbr-001CCa-0O;
	Fri, 26 May 2023 06:07:31 +0000
Message-ID: <b6c6eab1-9e81-4247-ee92-4684dae78c15@infradead.org>
Date: Thu, 25 May 2023 23:07:30 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] module: Introduce module_alloc_type
Content-Language: en-US
To: Song Liu <song@kernel.org>, linux-kernel@vger.kernel.org
Cc: bpf@vger.kernel.org, mcgrof@kernel.org, peterz@infradead.org,
 tglx@linutronix.de, x86@kernel.org, rppt@kernel.org,
 kent.overstreet@linux.dev
References: <20230526051529.3387103-1-song@kernel.org>
 <20230526051529.3387103-2-song@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230526051529.3387103-2-song@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi--

On 5/25/23 22:15, Song Liu wrote:
> +/**
> + * struct vmalloc_params - Parameters to call __vmalloc_node_range()
> + * @start:          Address space range start
> + * @end:            Address space range end
> + * @gfp_mask:       The gfp_t mask used for this range
> + * @pgprot:         The page protection for this range
> + * @vm_flags        The vm_flag used for this range

    * @vm_flags:

> + */
> +struct vmalloc_params {
> +	unsigned long	start;
> +	unsigned long	end;
> +	gfp_t		gfp_mask;
> +	pgprot_t	pgprot;
> +	unsigned long	vm_flags;
> +};

-- 
~Randy

