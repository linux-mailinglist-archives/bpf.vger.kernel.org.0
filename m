Return-Path: <bpf+bounces-10987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB90C7B0ED6
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 00:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 6A4D31C20833
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 22:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 281A14CFD5;
	Wed, 27 Sep 2023 22:20:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB52F519
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 22:20:08 +0000 (UTC)
Received: from out-199.mta1.migadu.com (out-199.mta1.migadu.com [IPv6:2001:41d0:203:375::c7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56499FB
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 15:20:07 -0700 (PDT)
Message-ID: <f7ba8d47-f768-4a5d-e333-725f7bae1c6e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1695853205;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5MP+1maPm8QSxdc4TGIpGTvKnrRhGUT8DoWGrDciI6E=;
	b=XheXC4inVaOL4/YZGe/7oP7t3WpqmB4buH9CxZzU8FESPpcGD76+s359cXU2qVZ+EOsqXz
	r9/DgKQYIWr9nrNKW+d8TbdPoJr7sYAoAsXIpX9/MCmYEjowPduU7Q2tpaDwXs7itvqQbt
	+t38gBoBeN5Mr3xHA7RJj9Rw1u03UaM=
Date: Wed, 27 Sep 2023 15:19:58 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Subject: Re: [PATCH bpf-next v6 2/9] bpf: Propagate modified uaddrlen from
 cgroup sockaddr programs
To: Daan De Meyer <daan.j.demeyer@gmail.com>
Cc: kernel-team@meta.com, netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20230926202753.1482200-1-daan.j.demeyer@gmail.com>
 <20230926202753.1482200-3-daan.j.demeyer@gmail.com>
Content-Language: en-US
In-Reply-To: <20230926202753.1482200-3-daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/26/23 1:27 PM, Daan De Meyer wrote:
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 5b2741aa0d9b..ba2c57cf4046 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -1449,6 +1449,7 @@ EXPORT_SYMBOL(__cgroup_bpf_run_filter_sk);
>    *                                       provided by user sockaddr
>    * @sk: sock struct that will use sockaddr
>    * @uaddr: sockaddr struct provided by user
> + * @uaddrlen: Pointer to the size of the sockaddr struct provided by user

This set cannot be applied cleanly. Please rebase. It has a conflict with:

commit 214bfd267f4929722b374b43fda456c21cd6f016
Author:     Randy Dunlap <rdunlap@infradead.org>
AuthorDate: Mon Sep 11 23:08:12 2023

>    * @type: The type of program to be executed
>    * @t_ctx: Pointer to attach type specific context
>    * @flags: Pointer to u32 which contains higher bits of BPF program

While updating the comment for __cgroup_bpf_run_filter_sock_addr, please also 
mention that the uaddrlen is readonly for AF_INET[6] and will not be changed.


> @@ -1461,6 +1462,7 @@ EXPORT_SYMBOL(__cgroup_bpf_run_filter_sk);
>    */
>   int __cgroup_bpf_run_filter_sock_addr(struct sock *sk,
>   				      struct sockaddr *uaddr,
> +				      int *uaddrlen,
>   				      enum cgroup_bpf_attach_type atype,
>   				      void *t_ctx,
>   				      u32 *flags)


