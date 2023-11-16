Return-Path: <bpf+bounces-15150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C095E7ED9DD
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 04:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 776551F2371D
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 03:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAFF6FD9;
	Thu, 16 Nov 2023 03:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="btCmsGt0"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [IPv6:2001:41d0:203:375::b8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E252199
	for <bpf@vger.kernel.org>; Wed, 15 Nov 2023 19:14:02 -0800 (PST)
Message-ID: <c768aae4-1c41-41ef-895d-33556b99dc15@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700104441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LVTbIWjaYj/Zzkxn6Ukw8lgVfPfXoOn5/TENdtMr4GY=;
	b=btCmsGt0X6sFafJDU5gd7nnPc2QMLVpFrf6LWdb3nrmMtMuOSwWpcruiVM5Jy1nXiU7ZwM
	nZtGRfjQ6PE3QXk/UOC/NKm6GGwEq/IsL5w6mIimemiQ3+1FwRl9tA8wuc1rTDoOE28kEw
	YvELle5WYIK2ZVjQhlheSAuVK71UnP8=
Date: Wed, 15 Nov 2023 22:13:52 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] bpf: kernel/bpf/task_iter.c: don't abuse
 next_thread()
To: Oleg Nesterov <oleg@redhat.com>, Alexei Starovoitov <ast@kernel.org>
Cc: Chuyi Zhou <zhouchuyi@bytedance.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Kui-Feng Lee <kuifeng@fb.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20231114163211.GA874@redhat.com>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231114163211.GA874@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 11/14/23 11:32 AM, Oleg Nesterov wrote:
> Compile tested.
>
> Every lockless usage of next_thread() was wrong, bpf/task_iter.c is
> the last user and is no exception.

It would be great if you can give more information in the commit message
about why the usage of next_thread() is wrong in bpf/task_iter.c.
IIUC, some information is presented in :
   https://lore.kernel.org/all/20230824143112.GA31208@redhat.com/

Also, please add 'bpf' in the subject tag ([PATCH bpf 0/3]) to
make it clear the patch should be applied to bpf tree.

>
> Oleg.
> ---
>
>   kernel/bpf/task_iter.c | 29 +++++++++++------------------
>   1 file changed, 11 insertions(+), 18 deletions(-)
>

