Return-Path: <bpf+bounces-13134-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C50627D5440
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 16:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30775B20FB9
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 14:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD1E2FB6;
	Tue, 24 Oct 2023 14:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="ha9Ktr5Z"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF23E2C84E
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 14:45:59 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC25C10E4
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 07:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=f7Oda66J6WIHXXvYaHI8akWn5HSBliZ5S29tlblqDEw=; b=ha9Ktr5ZH4fNYZRfzk9mRwGgGo
	JekiwoJGAVxZTqCO2e+wxofWx1JOp9sGkXzIcP2Upjcw2fOi0L5pynA2Vpo89jlkhA/XOzB80PpGV
	vwfn9MVzClAGJszgS82n3mk7I6VJL5TUy/IgR04byLzIrYgfq0BBi7vMRcTN3NGocnwglH6DlEbZx
	Y3UJxPjROhJH5OBtfehgVXIS4ZmpIGvoJ5zptWIvHkEmid9slVZDAqFFzdUGYxQ4f9KH/ovJ5hbhQ
	iMZkqzxEF6rFt1Z7urQjSj7qDottVK9tJUORpzP94V/p10FCLLt9DLtVfujsU3lrSS7KyOBThOU4Q
	6+V5paUA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qvIfJ-0009og-Lg; Tue, 24 Oct 2023 16:45:53 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qvIfJ-0004QP-CL; Tue, 24 Oct 2023 16:45:53 +0200
Subject: Re: [PATCH v4 bpf-next 3/7] bpf: Add helpers for trampoline image
 management
To: Song Liu <song@kernel.org>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, martin.lau@kernel.org,
 kernel-team@meta.com, Ilya Leoshkevich <iii@linux.ibm.com>
References: <20231018180336.1696131-1-song@kernel.org>
 <20231018180336.1696131-4-song@kernel.org>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <c1e44b6f-f18d-8c30-3ff7-8af35a0706bf@iogearbox.net>
Date: Tue, 24 Oct 2023 16:45:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231018180336.1696131-4-song@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27071/Tue Oct 24 09:43:50 2023)

On 10/18/23 8:03 PM, Song Liu wrote:
[...]
> @@ -1040,6 +1038,38 @@ arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *image
>   	return -ENOTSUPP;
>   }
>   
> +void * __weak arch_alloc_bpf_trampoline(int size)
> +{
> +	void *image;
> +
> +	WARN_ON_ONCE(size > PAGE_SIZE || size <= 0);

non-blocking / can be follow-up, but why not:

if (WARN_ON_ONCE(size > PAGE_SIZE || size <= 0))
	return NULL

size could also be u32, then you don't need size <= 0 check ?

> +	image = bpf_jit_alloc_exec(PAGE_SIZE);
> +	if (image)
> +		set_vm_flush_reset_perms(image);
> +	return image;
> +}
> +
> +void __weak arch_free_bpf_trampoline(void *image, int size)
> +{
> +	/* bpf_jit_free_exec doesn't need "size", but
> +	 * bpf_prog_pack_free() needs it.
> +	 */
> +	bpf_jit_free_exec(image);
> +}
> +
> +void __weak arch_protect_bpf_trampoline(void *image, int size)
> +{
> +	WARN_ON_ONCE(size > PAGE_SIZE || size <= 0);
> +	set_memory_rox((long)image, 1);
> +}
> +
> +void __weak arch_unprotect_bpf_trampoline(void *image, int size)
> +{
> +	WARN_ON_ONCE(size > PAGE_SIZE || size <= 0);
> +	set_memory_nx((long)image, 1);
> +	set_memory_rw((long)image, 1);
> +}
> +
>   static int __init init_trampolines(void)
>   {
>   	int i;

