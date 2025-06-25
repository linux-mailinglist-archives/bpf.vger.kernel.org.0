Return-Path: <bpf+bounces-61561-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9619EAE8C0B
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 20:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27B483A48F3
	for <lists+bpf@lfdr.de>; Wed, 25 Jun 2025 18:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230692D5C61;
	Wed, 25 Jun 2025 18:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bsc/Oi7a"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B64A1A3159
	for <bpf@vger.kernel.org>; Wed, 25 Jun 2025 18:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750875058; cv=none; b=FEoa/tP9lgzrcrz1JXDrZvboUNZCLK0a8J6V1707GlDiAiLKUtGWlj5upaJgXeEz5jTOUuC8aB/geHGW9CbxHVO3kAJw5xrwGnY1fDnBF5jTnfZC7BaLCehZceVya8N8V66DnR3Y8ebLj/H/xaRybRgMPO+boRAY++XMY1mcOQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750875058; c=relaxed/simple;
	bh=KYBOPxX3GFTtq0HNLMi3mgjXngev0izBaHxSiZGxFRg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=np5KHuFHEm/DqDGCHRQm/U2J1M6SpZ4AjU5zXudPyQFuvauwb8JJnpMTpjymuYBF56W8fFZNiyqQ3o6kmhOxX2j9mnp+4ZBIOI40jykIMwbCMfjdH5ZFG+zrvtVw5Rr6FoRoqpnA0z4cWRz0Fn9U37RGEUmZ3RCY2vX5aVUifEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bsc/Oi7a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750875056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/9NMhAJViuj1d9Wf05Bz/Ifw4S/GpLHKpGL5UhldLVE=;
	b=bsc/Oi7aIiJ7YNWKj7eG3ePfxXMshVirP028FBexMqbODVU3DEOnVAHX3SzB4IKPOez9nN
	ubGHnXF4cy0eenbbacFmfuNpHrFrBucmpBlNtPGEqOy+4UvkroBlJwOeTEN3iI74fwjtOt
	wwT5p5dmy6WgCIdUML1Bf1QdtffWsGI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-250-eZBAYtq8OyaIvcb7X-qHZA-1; Wed,
 25 Jun 2025 14:10:51 -0400
X-MC-Unique: eZBAYtq8OyaIvcb7X-qHZA-1
X-Mimecast-MFC-AGG-ID: eZBAYtq8OyaIvcb7X-qHZA_1750875047
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD77919560A6;
	Wed, 25 Jun 2025 18:10:46 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.45.225.238])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B37111956096;
	Wed, 25 Jun 2025 18:10:37 +0000 (UTC)
Date: Wed, 25 Jun 2025 20:10:33 +0200
From: Philipp Rudo <prudo@redhat.com>
To: Pingfan Liu <piliu@redhat.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jeremy Linton
 <jeremy.linton@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, Simon Horman
 <horms@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, Vitaly Kuznetsov
 <vkuznets@redhat.com>, Viktor Malik <vmalik@redhat.com>, Jan Hendrik Farr
 <kernel@jfarr.cc>, Baoquan He <bhe@redhat.com>, Dave Young
 <dyoung@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 kexec@lists.infradead.org, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>
Subject: Re: [PATCHv3 3/9] bpf: Introduce bpf_copy_to_kernel() to buffer the
 content from bpf-prog
Message-ID: <20250625201033.419d158a@rotkaeppchen>
In-Reply-To: <20250529041744.16458-4-piliu@redhat.com>
References: <20250529041744.16458-1-piliu@redhat.com>
	<20250529041744.16458-4-piliu@redhat.com>
Organization: Red Hat inc.
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hi Pingfan,
Hi Alexei,

sorry for the late reply.

On Thu, 29 May 2025 12:17:38 +0800
Pingfan Liu <piliu@redhat.com> wrote:

> In the security kexec_file_load case, the buffer which holds the kernel
> image is invisible to the userspace.
> 
> The common data flow in bpf scheme is from kernel to bpf-prog.  In the
> case of kexec_file_load, the kexec component needs to buffer the parsed
> result by bpf-prog (opposite the usual direction) to the next stage
> parsing. bpf_kexec_carrier() makes the opposite data flow possible. A
> bpf-prog can publish the parsed payload address to the kernel, and the
> latter can copy them for future use.
> 
> Signed-off-by: Pingfan Liu <piliu@redhat.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Song Liu <song@kernel.org>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Cc: Hao Luo <haoluo@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> To: bpf@vger.kernel.org
> ---
>  include/linux/bpf.h          |  23 +++++
>  kernel/bpf/Makefile          |   2 +-
>  kernel/bpf/helpers.c         |   2 +
>  kernel/bpf/helpers_carrier.c | 194 +++++++++++++++++++++++++++++++++++
>  4 files changed, 220 insertions(+), 1 deletion(-)
>  create mode 100644 kernel/bpf/helpers_carrier.c
> 

[...]

> diff --git a/kernel/bpf/helpers_carrier.c b/kernel/bpf/helpers_carrier.c
> new file mode 100644
> index 0000000000000..c4e45fdf0ebb8
> --- /dev/null
> +++ b/kernel/bpf/helpers_carrier.c
> @@ -0,0 +1,194 @@

[...]

> +__bpf_kfunc int bpf_mem_range_result_put(struct mem_range_result *result)

I'm concerned about the use of kfuncs for our use case. I don't believe
they provide the stability we need.

With kexec we deal with two different kernels. The 1st kernel, aka. the
one that executes kexec to load the 2nd kernel, and the 2nd kernel that
is being loaded. In general both kernels are built from different
versions with different configs and it is expected that kexec works
even when both kernels are years apart.

The problem is that in our design the bpf-prog is part of the
image of and built from the sources of the 2nd kernel, but runs in the
1st kernel. So the definitions of the kfuncs in both kernels have to
match. What makes it worse is that for it to work with secure boot the
kernel image, including the bpf-prog, needs to be signed. Which means
that the bpf-prog is fixed after build and can no longer be updated.

All in all I'm afraid we need a uapi-like stability for those kfuncs
for our design to work. Do you have any comments on my concern? Or any
idea how we could archive the stability despite using kfuncs?

Thanks
Philipp



> +{
> +	return mem_range_result_put(result);
> +}
> +
> +/*
> + * Cache the content in @buf into kernel
> + */
> +__bpf_kfunc int bpf_copy_to_kernel(const char *name, char *buf, int size)
> +{
> +	struct mem_range_result *range;
> +	struct mem_cgroup *memcg, *old_memcg;
> +	struct str_listener *item;
> +	resource_handler handler;
> +	bool kmalloc;
> +	char *kbuf;
> +	int id, ret = 0;
> +
> +	id = srcu_read_lock(&srcu);
> +	item = find_listener(name);
> +	if (!item) {
> +		srcu_read_unlock(&srcu, id);
> +		return -EINVAL;
> +	}
> +	kmalloc = item->kmalloc;
> +	handler = item->handler;
> +	srcu_read_unlock(&srcu, id);
> +	memcg = get_mem_cgroup_from_current();
> +	old_memcg = set_active_memcg(memcg);
> +	range = kmalloc(sizeof(struct mem_range_result), GFP_KERNEL);
> +	if (!range) {
> +		pr_err("fail to allocate mem_range_result\n");
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	kref_init(&range->ref);
> +	if (item->kmalloc)
> +		kbuf = kmalloc(size, GFP_KERNEL | __GFP_ACCOUNT);
> +	else
> +		kbuf = __vmalloc(size, GFP_KERNEL | __GFP_ACCOUNT);
> +	if (!kbuf) {
> +		kfree(range);
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +	ret = copy_from_kernel_nofault(kbuf, buf, size);
> +	if (unlikely(ret < 0)) {
> +		kfree(range);
> +		if (item->kmalloc)
> +			kfree(kbuf);
> +		else
> +			vfree(kbuf);
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +	range->kmalloc = item->kmalloc;
> +	range->buf = kbuf;
> +	range->buf_sz = size;
> +	range->data_sz = size;
> +	range->memcg = memcg;
> +	mem_cgroup_tryget(memcg);
> +	range->status = 0;
> +	ret = handler(name, range);
> +	mem_range_result_put(range);
> +err:
> +	set_active_memcg(old_memcg);
> +	mem_cgroup_put(memcg);
> +	return ret;
> +}
> +
> +int register_carrier_listener(struct carrier_listener *listener)
> +{
> +	struct str_listener *item;
> +	unsigned int hash;
> +	int ret;
> +
> +	if (!listener->name)
> +		return -EINVAL;
> +	item = kmalloc(sizeof(*item), GFP_KERNEL);
> +	if (!item)
> +		return -ENOMEM;
> +	item->str = kstrdup(listener->name, GFP_KERNEL);
> +	if (!item->str) {
> +		kfree(item);
> +		return -ENOMEM;
> +	}
> +	item->handler = listener->handler;
> +	item->kmalloc = listener->kmalloc;
> +	hash = jhash(item->str, strlen(item->str), 0);
> +	mutex_lock(&str_listeners_mutex);
> +	if (!find_listener(item->str)) {
> +		hash_add(str_listeners, &item->node, hash);
> +	} else {
> +		kfree(item->str);
> +		kfree(item);
> +		ret = -EBUSY;
> +	}
> +	mutex_unlock(&str_listeners_mutex);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(register_carrier_listener);
> +
> +int unregister_carrier_listener(char *str)
> +{
> +	struct str_listener *item;
> +	int ret = 0;
> +
> +	mutex_lock(&str_listeners_mutex);
> +	item = find_listener(str);
> +	if (!!item)
> +		hash_del(&item->node);
> +	else
> +		ret = -EINVAL;
> +	mutex_unlock(&str_listeners_mutex);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(unregister_carrier_listener);
> +


