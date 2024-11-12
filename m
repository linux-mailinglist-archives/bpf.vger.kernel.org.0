Return-Path: <bpf+bounces-44677-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 747A09C64C7
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 00:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97ED6B32904
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 23:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF5821B44A;
	Tue, 12 Nov 2024 23:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G+9XjOSw"
X-Original-To: bpf@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232B921A6F0
	for <bpf@vger.kernel.org>; Tue, 12 Nov 2024 23:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731452458; cv=none; b=ebTOkiTJYdFMVqdXZMppYF5VZ9Z2elfa5OzRNR6vpma8RXIikYUp65r3h+TBgP0dsdt0tI62tFVTb/U5lx1vydtWMDwJpLSre2B6P32MdUB/0jSvNFp3EXXQORYxWQFttKkCjBEH6MiUWGnRvDnf58PdPqDiHTJLVMda112jdqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731452458; c=relaxed/simple;
	bh=vKviNln8+HqiyyQDyWlEiTh1attruNE8dCnzglGdyMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=De2sl0bVN89lkJV724+75i2X1DPrNPe9HZ3eRa/ESEF6bl5BMXZDoGQedLpvuqcSmkfHiz6Hn+hZr0bsoM2uELN9DqkDrIcxfc63TfmDc0wsYAt6lzxP7jU4sImbLq2HXDvEJTNP3YGXE1miG9Qy6EJ5cNr102bRvRu4CgnX6C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G+9XjOSw; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2cb0cd4f-5d78-4b7f-b280-2a3377ffbc21@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731452454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=60ywXsma7A1FQGRCvG3j7Xi4+6xd1zwISgp42e7ZGx0=;
	b=G+9XjOSwFph0ZOLrgRvd7ZcnuhRiwfya8guYFzC1634yyBde4sKQbJyiA7UbbMlIr1AIJ1
	QVRTjA1JG/OzDn65CLKRAX6agSwjjputUbgGzNfUwfNPUZqaUIx4vyjKzHQKBE4c1oqKwV
	Caiu6p2/68Xv08w8tXeZDnJymVBxcuw=
Date: Tue, 12 Nov 2024 15:00:48 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 2/4] bpf: Make bpf inode storage available to
 tracing program
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
 kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, kpsingh@kernel.org, mattbobrowski@google.com,
 amir73il@gmail.com, repnop@google.com, jlayton@kernel.org,
 josef@toxicpanda.com, mic@digikod.net, gnoack@google.com
References: <20241112083700.356299-1-song@kernel.org>
 <20241112083700.356299-3-song@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20241112083700.356299-3-song@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/12/24 12:36 AM, Song Liu wrote:
>   void __destroy_inode(struct inode *inode)
>   {
>   	BUG_ON(inode_has_buffers(inode));
> +	bpf_inode_storage_free(inode);

Not sure if this is done in the rcu callback (i.e. after the rcu gp). Please check.

>   	inode_detach_wb(inode);
>   	security_inode_free(inode);
>   	fsnotify_inode_delete(inode);

[ ... ]

> @@ -136,12 +119,7 @@ BPF_CALL_5(bpf_inode_storage_get, struct bpf_map *, map, struct inode *, inode,
>   	if (flags & ~(BPF_LOCAL_STORAGE_GET_F_CREATE))
>   		return (unsigned long)NULL;
>   
> -	/* explicitly check that the inode_storage_ptr is not
> -	 * NULL as inode_storage_lookup returns NULL in this case and
> -	 * bpf_local_storage_update expects the owner to have a
> -	 * valid storage pointer.
> -	 */
> -	if (!inode || !inode_storage_ptr(inode))
> +	if (!inode)
>   		return (unsigned long)NULL;

There is an atomic_read in this function:

	/* only allocate new storage, when the inode is refcounted */
	if (atomic_read(&inode->i_count) &&
	    flags & BPF_LOCAL_STORAGE_GET_F_CREATE) {

If the bpf_inode_storage_free is not done after rcu gp, this will need a 
inc_not_zero like how the sk storage does. I think moving the storage_free to 
the inode rcu call back may be easier if it is not the case now.



