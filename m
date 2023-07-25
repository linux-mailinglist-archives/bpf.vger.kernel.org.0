Return-Path: <bpf+bounces-5888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7427762753
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 01:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E84261C20EE3
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 23:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25EB2770F;
	Tue, 25 Jul 2023 23:29:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A299B8BE1
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 23:29:31 +0000 (UTC)
Received: from out-39.mta1.migadu.com (out-39.mta1.migadu.com [95.215.58.39])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D830F1BDA
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 16:29:29 -0700 (PDT)
Message-ID: <d5bce711-cef0-2929-2126-50105b6d807e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690327768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vOEjSRPghqZUXU6a9KIFU0/2bAuZPx1SXHj+MlsTBQk=;
	b=GJ9xevCEq1sj4q4o69h/sQv1iIDXDIAysRTshJHIo4iErGxicFq8ZauC/jMaNJ6wA6Q8Uo
	wpa1DKrj/9QkQiuc1N67YRt7AyxByTMojBAGQQj8QPMHvkiZV6fXq6xfxY7Z4Cd3LjuyVl
	+8TNH+5uypaT3rame/2Q5+oBXwZuwiM=
Date: Tue, 25 Jul 2023 16:29:21 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] btf: Remove unnecessary header file inclusions
Content-Language: en-US
To: George Guo <guodongtai@kylinos.cn>
References: <20230721075007.4100863-1-guodongtai@kylinos.cn>
Cc: masahiroy@kernel.org, nathan@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20230721075007.4100863-1-guodongtai@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/21/23 12:50 AM, George Guo wrote:
> Remove unnecessary header file inclusions in btf.c
> 
> Signed-off-by: George Guo <guodongtai@kylinos.cn>
> ---
>   kernel/bpf/btf.c | 16 ----------------
>   1 file changed, 16 deletions(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 817204d53372..e5ea729ba6b8 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -1,20 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /* Copyright (c) 2018 Facebook */
>   
> -#include <uapi/linux/btf.h>
> -#include <uapi/linux/bpf.h>
> -#include <uapi/linux/bpf_perf_event.h>
> -#include <uapi/linux/types.h>
> -#include <linux/seq_file.h>
> -#include <linux/compiler.h>
> -#include <linux/ctype.h>
> -#include <linux/errno.h>
> -#include <linux/slab.h>
>   #include <linux/anon_inodes.h>
> -#include <linux/file.h>
> -#include <linux/uaccess.h>
> -#include <linux/kernel.h>
> -#include <linux/idr.h>
>   #include <linux/sort.h>
>   #include <linux/bpf_verifier.h>
>   #include <linux/btf.h>
> @@ -22,9 +9,6 @@
>   #include <linux/bpf_lsm.h>
>   #include <linux/skmsg.h>
>   #include <linux/perf_event.h>
> -#include <linux/bsearch.h>
> -#include <linux/kobject.h>
> -#include <linux/sysfs.h>

What is the reason that needs this change and only to this file? There are other 
files that can do this kind of removal. Are you planning to make all the changes 
also?

afaict, they are here because this file is using something defined in them. Now 
it is depending on other header files implicitly including the removed headers.

>   
>   #include <net/netfilter/nf_bpf_link.h>
>   


