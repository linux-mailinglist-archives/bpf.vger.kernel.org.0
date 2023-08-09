Return-Path: <bpf+bounces-7404-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FBF776BF8
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 00:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E36F9281B4A
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 22:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA341DDE3;
	Wed,  9 Aug 2023 22:10:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C496D24535
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 22:10:14 +0000 (UTC)
Received: from out-79.mta0.migadu.com (out-79.mta0.migadu.com [IPv6:2001:41d0:1004:224b::4f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0DBFE
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 15:10:13 -0700 (PDT)
Message-ID: <99204aea-b71a-a1f9-ab28-4155de5c0523@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691619011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m1UPSZrX3ndpiU8kSGTKgal0W9awdzjGsiT90+acZPs=;
	b=RBrfk5p1xhypUIMLIaq59q3VXDQrnAjHSGH5dCHapy9nJcC3giUaIdKx4gEPTiy4nupw2r
	LdzmZz81dJ4qykbHxF3Rgq/s413+VLSSD2Oq5EuQaC9+SjioDCdcd3NeKks4JjUrtnPHEo
	rgAf2Td7OpFMczdZ3PtwoZbN+beF6Vw=
Date: Wed, 9 Aug 2023 15:10:05 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Remove unused declaration
 bpf_link_new_file()
Content-Language: en-US
To: Yue Haibing <yuehaibing@huawei.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org
References: <20230809140556.45836-1-yuehaibing@huawei.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230809140556.45836-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/9/23 7:05 AM, Yue Haibing wrote:
> Commit a3b80e107894 ("bpf: Allocate ID for bpf_link")
> removed the implementation but not the declaration.

It is good to remove unimplemented function. However, how many more of this you 
have already discovered? Unless it is like hundred line changes, can you please 
batch them all together and send them in one patch?

> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>   include/linux/bpf.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index db3fe5a61b05..cfabbcf47bdb 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2120,7 +2120,6 @@ void bpf_link_cleanup(struct bpf_link_primer *primer);
>   void bpf_link_inc(struct bpf_link *link);
>   void bpf_link_put(struct bpf_link *link);
>   int bpf_link_new_fd(struct bpf_link *link);
> -struct file *bpf_link_new_file(struct bpf_link *link, int *reserved_fd);
>   struct bpf_link *bpf_link_get_from_fd(u32 ufd);
>   struct bpf_link *bpf_link_get_curr_or_next(u32 *id);
>   


