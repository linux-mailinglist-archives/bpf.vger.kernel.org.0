Return-Path: <bpf+bounces-22209-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CCA858F3C
	for <lists+bpf@lfdr.de>; Sat, 17 Feb 2024 13:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28DB11C20DC7
	for <lists+bpf@lfdr.de>; Sat, 17 Feb 2024 12:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058206A01C;
	Sat, 17 Feb 2024 12:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WfhWbkGj"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C48629ED
	for <bpf@vger.kernel.org>; Sat, 17 Feb 2024 12:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708171506; cv=none; b=Z+WFl63avuuuyIZEPYeNOmi3xeZ7g9mqDtVqVe07oLR0cyD4d+ebHsuD5Gl5DneWil9XZu8xhcUpRM1YYLYslgDzB2x9BmGLgHS+XTPnmW2CKvhW6dU3SE0xJh7khueCEcrmLEE5+WLlUIzSXyYJEM0bBZqQQxglVDGCfAK0Mnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708171506; c=relaxed/simple;
	bh=BX6e6hiBTnGSalv/9HIVusi20VfWVEw4yj4oii3v4ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMTeiubmppYUw3CDrni/RdhDPiu+nIvf9j29D4OX6EEq2PNtvJ0OeEHgD2oPCT+Iamtt7jQIej9BRFYj8R6KXLMzSi04v3f/5slUybvI4j+l6aFWCwl5BjF2SFAj8n4ms+Y4c9S2Wswvc+ztVbtLE0WSeI68QkS1KUNSGSW+q+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WfhWbkGj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708171503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hjeMVE/jd7HxmGs4iR7IXp3QfULUw904tPe7/0WHtQI=;
	b=WfhWbkGjvslnZXEKjPXZoidOwGXVvL69tkw/26YWat1ibGD6MRf7Zt2pHyiwyXNKChezgL
	dKzl5AKmjKmrhQgxf4LbfT2tEehXKMR9I5kgF8tOUbMi0TFQc8JvkWRW9ny+Jxzb1zjMZK
	OlRYMDRU34VRn78ZwLgS5LbkrlD/MJo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-7vO-qyLaOHOuoLEWRkWBkQ-1; Sat,
 17 Feb 2024 07:04:56 -0500
X-MC-Unique: 7vO-qyLaOHOuoLEWRkWBkQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1FDC33C0008A;
	Sat, 17 Feb 2024 12:04:55 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.33])
	by smtp.corp.redhat.com (Postfix) with SMTP id 0A5CA112132A;
	Sat, 17 Feb 2024 12:04:51 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sat, 17 Feb 2024 13:03:37 +0100 (CET)
Date: Sat, 17 Feb 2024 13:03:33 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
	sdf@google.com, haoluo@google.com, jolsa@kernel.org,
	bpf@vger.kernel.org, Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Fix an issue due to uninitialized
 bpf_iter_task
Message-ID: <20240217120333.GC10393@redhat.com>
References: <20240217114152.1623-1-laoar.shao@gmail.com>
 <20240217114152.1623-2-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240217114152.1623-2-laoar.shao@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

On 02/17, Yafang Shao wrote:
>
> Failure to initialize it->pos, coupled with the presence of an invalid
> value in the flags variable, can lead to it->pos referencing an invalid
> task, potentially resulting in a kernel panic. To mitigate this risk, it's
> crucial to ensure proper initialization of it->pos to NULL.
>
> Fixes: ac8148d957f5 ("bpf: bpf_iter_task_next: use next_task(kit->task) rather than next_task(kit->pos)")

Confused...

Does this mean that bpf_iter_task_next() (the only user of ->pos) can be
called even if bpf_iter_task_new() returns -EINVAL ?

Oleg.

> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> Cc: Chuyi Zhou <zhouchuyi@bytedance.com>
> Cc: Oleg Nesterov <oleg@redhat.com>
> ---
>  kernel/bpf/task_iter.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index e5c3500443c6..ec4e97c61eef 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -978,6 +978,8 @@ __bpf_kfunc int bpf_iter_task_new(struct bpf_iter_task *it,
>  	BUILD_BUG_ON(__alignof__(struct bpf_iter_task_kern) !=
>  					__alignof__(struct bpf_iter_task));
>  
> +	kit->pos = NULL;
> +
>  	switch (flags) {
>  	case BPF_TASK_ITER_ALL_THREADS:
>  	case BPF_TASK_ITER_ALL_PROCS:
> -- 
> 2.39.1
> 


