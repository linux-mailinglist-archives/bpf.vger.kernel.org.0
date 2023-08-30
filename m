Return-Path: <bpf+bounces-8962-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE2278D35D
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 08:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77950281386
	for <lists+bpf@lfdr.de>; Wed, 30 Aug 2023 06:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE241859;
	Wed, 30 Aug 2023 06:28:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248D315A0
	for <bpf@vger.kernel.org>; Wed, 30 Aug 2023 06:28:27 +0000 (UTC)
Received: from out-250.mta0.migadu.com (out-250.mta0.migadu.com [91.218.175.250])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A892ECC
	for <bpf@vger.kernel.org>; Tue, 29 Aug 2023 23:28:21 -0700 (PDT)
Message-ID: <9b84dc6f-2723-a3c0-7eba-143c4fd9c30b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1693376900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OgjqBi1IMQoDkcUKlt/WUIRB7l78sm9ZxnPnGD+kee0=;
	b=n3R8nuR94EzDL6DfX9K93RTMgcAsMBcBXOYMNv0sLA2lEmLaoGFG4y82hOAYaf1ETbxFuK
	Lnm1sFTC4LhhzV3ZR53Fryu9DAqfgAbh7m8MHNOI/f6CdZocdDg9QFVWck/4eiJimZsJHt
	Wan54Auk3FIpg44hDGunYmgNxuOHJbQ=
Date: Tue, 29 Aug 2023 23:28:17 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 3/9] bpf: Add bpf_sock_addr_set() to allow
 writing sockaddr len from bpf
Content-Language: en-US
To: Daan De Meyer <daan.j.demeyer@gmail.com>
Cc: kernel-team@meta.com, bpf@vger.kernel.org
References: <20230829101838.851350-1-daan.j.demeyer@gmail.com>
 <20230829101838.851350-4-daan.j.demeyer@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230829101838.851350-4-daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/29/23 3:18 AM, Daan De Meyer wrote:
> +__bpf_kfunc int bpf_sock_addr_set_addr(struct bpf_sock_addr_kern *sa_kern,
> +				       const u8 *addr, u32 addrlen__sz)
> +{
> +	struct sockaddr *sa = sa_kern->uaddr;
> +	struct sockaddr_in *sa4;
> +	struct sockaddr_in6 *sa6;
> +	struct sockaddr_un *un;
> +
> +	switch (sa->sa_family) {

The sa_family could be AF_UNSPEC here for inet addr (eg. take a look at 
__inet_bind checking AF_UNSPEC). Test the sa_kern->sk->sk_family instead.

> +	case AF_INET:
> +		if (addrlen__sz != 4)
> +			return -EINVAL;
> +		sa4 = (struct sockaddr_in *)sa;
> +		sa4->sin_addr.s_addr = *(__be32 *)addr;
> +		break;
> +	case AF_INET6:
> +		if (addrlen__sz != 16)
> +			return -EINVAL;
> +		sa6 = (struct sockaddr_in6 *)sa;
> +		memcpy(sa6->sin6_addr.s6_addr, addr, 16);
> +		break;
> +	default:
> +		WARN_ON_ONCE(1);

The above switch case will test sk_family instead, so this WARN should never 
happen and should be removed.

> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
>   __diag_pop();


