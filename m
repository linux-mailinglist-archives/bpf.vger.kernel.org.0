Return-Path: <bpf+bounces-43020-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD87D9ADB7C
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 07:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EC3B28226D
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 05:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624C0175568;
	Thu, 24 Oct 2024 05:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U07BvVPd"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852041714CA
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 05:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729747393; cv=none; b=nGNkUfA7JnE8Oc5i9QzOgt/w3wnedMF5FEBpFvwJJh6cuCQGFHdpj86ZrS3dJOrjXnTas7h7EIY4E9VgSFkghIEr7vu33IsFPrNgahYw32OrSryqxUt1JCSJ92tCXj3nao03TFF4DIRyslFuCBnYSIu/TNFAAaO9oiHcHqWx1GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729747393; c=relaxed/simple;
	bh=Xu4HHqzTybX85DtBDiGS2lT7ee06t3784viaivK/QWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mi6s7uvjkoY+M3VvEI3x170v4qwnSZ3tEy6ucg/OiI9faEw2d2wwGWiG7ffnvM+KGZYKpL/fk+dG+WBdkfAno3II1l6ZQdF1CfArxBYbw3ODge4Xwys71/oT8akuQQpSlOp7z4HKPnYmUPpC0e+hfWq/OPciydiM7EPMO6I2T6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U07BvVPd; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 23 Oct 2024 22:23:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729747388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IRhqr75O4a6C4a8zm8j8sqwx+Mv66SJ15nHUK/iyHcs=;
	b=U07BvVPdAdAHSZAoF5VG0w7wjGc8Y5fKfZUMe6V53xnaWkpgQ7mbkowtMO/O7a5wwuwY17
	lLfmtsZJ1QRE11xKc5JSAgmW/MhnQ18j2ylS1P8rd2xM+Kecwj+QWt7jfc+2bgUizwSu+7
	ehN/I4f7qasr5xEFy51Jjhpul4fsHY8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kui-Feng Lee <thinker.li@gmail.com>, kernel-team@meta.com, linux-mm@kvack.org
Subject: Re: [PATCH v6 bpf-next 06/12] bpf: Add uptr support in the map_value
 of the task local storage.
Message-ID: <ekhwssykkei5lkwgrd3mdpzbrlzo6fbyn2e3xnsoykffyjjla2@eqmbywxsaffp>
References: <20241023234759.860539-1-martin.lau@linux.dev>
 <20241023234759.860539-7-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023234759.860539-7-martin.lau@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Wed, Oct 23, 2024 at 04:47:53PM GMT, Martin KaFai Lau wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> This patch adds uptr support in the map_value of the task local storage.
> 
> struct map_value {
> 	struct user_data __uptr *uptr;
> };
> 
> struct {
> 	__uint(type, BPF_MAP_TYPE_TASK_STORAGE);
> 	__uint(map_flags, BPF_F_NO_PREALLOC);
> 	__type(key, int);
> 	__type(value, struct value_type);
> } datamap SEC(".maps");
> 
> A new bpf_obj_pin_uptrs() is added to pin the user page and
> also stores the kernel address back to the uptr for the
> bpf prog to use later. It currently does not support
> the uptr pointing to a user struct across two pages.
> It also excludes PageHighMem support to keep it simple.
> As of now, the 32bit bpf jit is missing other more crucial bpf
> features. For example, many important bpf features depend on
> bpf kfunc now but so far only one arch (x86-32) supports it
> which was added by me as an example when kfunc was first
> introduced to bpf.
> 
> The uptr can only be stored to the task local storage by the
> syscall update_elem. Meaning the uptr will not be considered
> if it is provided by the bpf prog through
> bpf_task_storage_get(BPF_LOCAL_STORAGE_GET_F_CREATE).
> This is enforced by only calling
> bpf_local_storage_update(swap_uptrs==true) in
> bpf_pid_task_storage_update_elem. Everywhere else will
> have swap_uptrs==false.
> 
> This will pump down to bpf_selem_alloc(swap_uptrs==true). It is
> the only case that bpf_selem_alloc() will take the uptr value when
> updating the newly allocated selem. bpf_obj_swap_uptrs() is added
> to swap the uptr between the SDATA(selem)->data and the user provided
> map_value in "void *value". bpf_obj_swap_uptrs() makes the
> SDATA(selem)->data takes the ownership of the uptr and the user space
> provided map_value will have NULL in the uptr.
> 
> The bpf_obj_unpin_uptrs() is called after map->ops->map_update_elem()
> returning error. If the map->ops->map_update_elem has reached
> a state that the local storage has taken the uptr ownership,
> the bpf_obj_unpin_uptrs() will be a no op because the uptr
> is NULL. A "__"bpf_obj_unpin_uptrs is added to make this
> error path unpin easier such that it does not have to check
> the map->record is NULL or not.
> 
> BPF_F_LOCK is not supported when the map_value has uptr.
> This can be revisited later if there is a use case. A similar
> swap_uptrs idea can be considered.
> 
> The final bit is to do unpin_user_page in the bpf_obj_free_fields().
> The earlier patch has ensured that the bpf_obj_free_fields() has
> gone through the rcu gp when needed.
> 
> Cc: linux-mm@kvack.org
> Cc: Shakeel Butt <shakeel.butt@linux.dev>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

