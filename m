Return-Path: <bpf+bounces-6915-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8277976F70D
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 03:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B25111C216AF
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 01:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673911101;
	Fri,  4 Aug 2023 01:42:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F5DA4E
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 01:42:06 +0000 (UTC)
Received: from out-92.mta1.migadu.com (out-92.mta1.migadu.com [IPv6:2001:41d0:203:375::5c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDC14495
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 18:42:00 -0700 (PDT)
Message-ID: <38f076e4-908f-d1be-a3f6-4b276d5cd6bd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691113318; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FRBM8zFCaEBy6/h+KUtIaHcP9OX7lIKzN8F4Z0dq7W8=;
	b=jwIhnUS4w91HWALTxdRZlFfjJuzQYuIk/2r+2da2lZW6QQoOym2vDTwBg7ZXR6HyMxzW1D
	utUTA8xZWEdGOq/t7XSJQSBlnqE12dQUP4fR+GrKCfJ03s/f7StuTtVTgjscNVljMxPQco
	h3/WD/Nfyh8OfDmqTZdcsxXTOuNm3f4=
Date: Thu, 3 Aug 2023 18:41:53 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next] bpf: fix inconsistent return types of
 bpf_xdp_copy_buf().
Content-Language: en-US
To: thinker.li@gmail.com, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org
Cc: sinquersw@gmail.com, kuifeng@meta.com,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <20230804005101.1534505-1-thinker.li@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20230804005101.1534505-1-thinker.li@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/3/23 5:51 PM, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Fix inconsistent return types in two implementations of bpf_xdp_copy_buf().
> 
> There are two implementations: one is an empty implementation whose return
> type does not match the actual implementation.
> 
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>

Looks like a fix tag is not needed as the old code won't cause
compilation warnings or runtime errors despite the signature mismatch.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   include/linux/filter.h | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 2d6fe30bad5f..761af6b3cf2b 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -1572,10 +1572,9 @@ static inline void *bpf_xdp_pointer(struct xdp_buff *xdp, u32 offset, u32 len)
>   	return NULL;
>   }
>   
> -static inline void *bpf_xdp_copy_buf(struct xdp_buff *xdp, unsigned long off, void *buf,
> -				     unsigned long len, bool flush)
> +static inline void bpf_xdp_copy_buf(struct xdp_buff *xdp, unsigned long off, void *buf,
> +				    unsigned long len, bool flush)
>   {
> -	return NULL;
>   }
>   #endif /* CONFIG_NET */
>   

