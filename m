Return-Path: <bpf+bounces-56066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30558A90DFD
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 23:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A86D1906342
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 21:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036BF22B8C1;
	Wed, 16 Apr 2025 21:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rvph1z7H"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCAD1DA634
	for <bpf@vger.kernel.org>; Wed, 16 Apr 2025 21:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744840167; cv=none; b=Tis2fEf9JIkb9aQGxlmejKppnQJUR+VJge864S083eYn0YpMx4PZsHwVorEp04eeNQIlv94jwLnmc+FxVJQnpY00lqGPkznZYoK1pXECID9hWqVdLGJeINdJdGNLMGe/STrBOUIeFOISJF2me9Pfe33tLFGC7oqMNyES6atM4y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744840167; c=relaxed/simple;
	bh=irvfiROJJ77zWKlczfqntZIzHYDqKMhCVQAloRfizMk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L6ANVUZv+zTV2gDz8iUsamzOkKirqFC2ZXai4n2mHyHtEcTqfmsaHBzZSSbIEjC9rdQ2RbpODogGEVk/NUaR32Ro/Iab98Ia08g+7bkCM/XSDtS3Pus9v5/11hIrqutEoZ3qdjZMV9J6dZlzfDgGgiHHnjtggrDkxNA2mFxccl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rvph1z7H; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4775ce8a4b0so1738611cf.1
        for <bpf@vger.kernel.org>; Wed, 16 Apr 2025 14:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744840165; x=1745444965; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I4CRCQSoaegLuDEy8cGx9LkacxrXKJuujWiVoIKBCW4=;
        b=Rvph1z7HCVD32VMUiHSV7W3n3bWR5Voh3suZO8HrB8dIhLWBAJjaLUEKA6LVeAj+E8
         YOo4sIUBQ+uLVbldJIprBwLmoRzs3qesH3Y5TEh2Q5Cq2XoNP3yl/FI6BeNKtEEN2Fil
         Tbri5UmGH7ZyuUBU+3nJoA6joaVETS6ImLBhKq9tNjPMtE2gssjLBwxc6WvTVCciWhhr
         z8yy+CzuIvfkNmhEt4tm6ySrEVuCAgLDAXg+9S3F+wyRDbi9ovUq9TzqjK3UOsglqldD
         l/icCCHpS0CdIvTsgSb9W/99TyNWwCbKhU6zPnFfZTYXLH2Af6Q6s/GrcTW+XwYzLjQz
         A/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744840165; x=1745444965;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4CRCQSoaegLuDEy8cGx9LkacxrXKJuujWiVoIKBCW4=;
        b=di71Sgn9HPPN8PMB1odituJR7zMN84a038tVjRMU9k1lqAdmysFInRHFgdCllS1cQJ
         k1NDLIhpworem1+xpi9rPq90ZpPJuMeQKZRWR2NUXYShsEhrY0c+Rt3BXC9A7XE5DiqL
         IjVd6ZE6jaXtRMHNPBXbqEfHgc4axiuobPWIS4aPZ/UNy2p/o2faipPkf+mjQ+5YPSJH
         oeLnJTnIe4txzsYVp5ZBt4GnMq5AMZTZq5ee5Rk+voW82n4B/y4G8aKkpKqWTL/lTcha
         ocmjbBJJSGjCg0MEXg68fF6IJfS77auINmw0b/jkCsrfnDVdJ0kin9u/8+d78KBypRXq
         /ZfA==
X-Gm-Message-State: AOJu0YwQ2qwx7JWXeTJ7TL/WHRghyHDWkxMb1AK94WAP2hHnSboFpDTF
	HEA1+F7oTU+Dc6gWGoPwJ84vnqbIa5q6io1XpCHrezKSLEHah2CX
X-Gm-Gg: ASbGncs2LdBTRCcGYb2kWLDwNz7mXYKFjvjsHu/6oWFCYAiyY4otV6Oq+FEmpZxkPJ5
	YuPFxoAfZjkJ/h6Iw0vRAS7fpjkHqVYkb51oP2S0Lc4InjfxDlOfqcv53c5CQ70xfYwUpjPd+Y+
	eOaf4LyraDXdLGiC/B6S1O0Kv7Mfpvl21fRVAI0MfMqVZQJdF61D8W6qAiCZB3vFm2BYlCMs1uj
	NNMSJllDfaVuY+auU5794tlR0IWS2EhHuYNtjr8ntlpDkDu46L+1sA21Ca09FSwn2PjEwO7sgfy
	bBK6ceVpNGl8y3u5dK7LwVHHcB76u3f9WmepcDknnbY=
X-Google-Smtp-Source: AGHT+IFS0NNt618AFSuv644GrG8/w9XR6TIxDTlUtMCq4nbHkqUj4aCokEunfEyHLe/NvfAvURKVXA==
X-Received: by 2002:a05:622a:1a24:b0:476:add4:d2cf with SMTP id d75a77b69052e-47ad80b5b13mr49485521cf.16.1744840164735;
        Wed, 16 Apr 2025 14:49:24 -0700 (PDT)
Received: from ezingerman-mba ([2620:10d:c090:500::4:24a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c7a8a0dcfbsm1100815085a.98.2025.04.16.14.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 14:49:24 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,  Andrii
 Nakryiko <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  Martin KaFai Lau <martin.lau@kernel.org>,  Emil Tsalapatis
 <emil@etsalapatis.com>,  Barret Rhoden <brho@google.com>,  kkd@meta.com,
  kernel-team@meta.com
Subject: Re: [RFC PATCH bpf-next/net v1 07/13] bpf: Introduce per-prog
 stdout/stderr streams
In-Reply-To: <20250414161443.1146103-8-memxor@gmail.com> (Kumar Kartikeya
	Dwivedi's message of "Mon, 14 Apr 2025 09:14:37 -0700")
References: <20250414161443.1146103-1-memxor@gmail.com>
	<20250414161443.1146103-8-memxor@gmail.com>
Date: Wed, 16 Apr 2025 14:49:20 -0700
Message-ID: <m2plhbu68v.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> Introduce a set of kfuncs to implement per BPF program stdout and stderr
> streams. This is implemented as a linked list of dynamically allocated
> strings whenever a message is printed. This can be done by the kernel or
> the program itself using the bpf_prog_stream_vprintk kfunc. In-kernel
> wrappers are provided over streams to ease the process.
>
> The idea is that everytime messages need to be dumped, the reader would
> pull out the whole batch of messages from the stream at once, and then
> pop each string one by one and start printing it out (how exactly is
> left up to the BPF program reading the log, but usually it will be
> streaming data back into a ring buffer that is consumed by user space).
>
> The use of a lockless list warrants that we be careful about the
> ordering of messages. When being added, the order maintained is new to
> old, therefore after deletion, we must reverse the list before iterating
> and popping out elements from it.
>
> Overall, this infrastructure provides NMI-safe any context printing
> built on top of the NMI-safe any context bpf_mem_alloc() interface.
>
> Later patches will add support for printing splats in case of BPF arena
> page faults, rqspinlock deadlocks, and cond_break timeouts.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

[...]

> diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
> new file mode 100644
> index 000000000000..2019ce134310
> --- /dev/null
> +++ b/kernel/bpf/stream.c

[...]

> +static int bpf_stream_page_check_room(struct bpf_stream_page *stream_page, int len)
                                                                              ^^^^^^^
                                                                     len is never used
> +{
> +	int min = offsetof(struct bpf_stream_elem, str[0]);
> +	int consumed = stream_page->consumed;
> +	int total = BPF_STREAM_PAGE_SZ;
> +	int rem = max(0, total - consumed - min);
> +
> +	/* Let's give room of at least 8 bytes. */
> +	WARN_ON_ONCE(rem % 8 != 0);
> +	return rem < 8 ? 0 : rem;
> +}

[...]

> +static struct bpf_stream_elem *bpf_stream_elem_alloc(int len)
> +{
> +	const int max_len = ARRAY_SIZE((struct bpf_bprintf_buffers){}.buf);
> +	struct bpf_stream_elem *elem;
> +
> +	/*
> +	 * We may overflow, but we should never need more than one page size
> +	 * worth of memory. This can be lifted, but we'd need to adjust the
> +	 * other code to keep allocating more pages to overflow messages.
> +	 */
> +	BUILD_BUG_ON(max_len > BPF_STREAM_PAGE_SZ);
> +	/*
> +	 * Length denotes the amount of data to be written as part of stream element,
> +	 * thus includes '\0' byte. We're capped by how much bpf_bprintf_buffers can
> +	 * accomodate, therefore deny allocations that won't fit into them.
> +	 */
> +	if (len < 0 || len > max_len)
> +		return NULL;
> +
> +	elem = bpf_stream_elem_alloc_from_bpf_ma(len);
> +	if (!elem)
> +		elem = bpf_stream_elem_alloc_from_stream_page(len);

So, the stream page is a backup mechanism, right?
I'm curious, did you compare how many messages are dropped if there is
no such backup? Also, how much memory is wasted if there is no
"spillover" mechanism (BPF_STREAM_ELEM_F_NEXT).
Are these complications absolutely necessary?

> +	return elem;
> +}
> +
> +__bpf_kfunc_start_defs();
> +
> +static int bpf_stream_push_str(struct bpf_stream *stream, const char *str, int len)
> +{

This function accumulates elements in &stream->log w/o a cap.
Why is this not a problem if e.g. user space never flushes streams for
the program?

> +	struct bpf_stream_elem *elem, *next = NULL;
> +	int room = 0, rem = 0;
> +
> +	/*
> +	 * Allocate a bpf_prog_stream_elem and push it to the bpf_prog_stream
> +	 * log, elements will be popped at once and reversed to print the log.
> +	 */
> +	elem = bpf_stream_elem_alloc(len);
> +	if (!elem)
> +		return -ENOMEM;
> +	room = elem->mem_slice.len;
> +	if (elem->flags & BPF_STREAM_ELEM_F_NEXT) {
> +		next = (struct bpf_stream_elem *)((unsigned long)elem->next & ~BPF_STREAM_ELEM_F_MASK);
> +		rem = next->mem_slice.len;
> +	}
> +
> +	memcpy(elem->str, str, room);
> +	if (next)
> +		memcpy(next->str, str + room, rem);
> +
> +	if (next) {
> +		elem->node.next = &next->node;
> +		next->node.next = NULL;
> +
> +		llist_add_batch(&elem->node, &next->node, &stream->log);
> +	} else {
> +		llist_add(&elem->node, &stream->log);
> +	}
> +
> +	return 0;
> +}

[...]

> +BTF_KFUNCS_START(stream_consumer_kfunc_set)
> +BTF_ID_FLAGS(func, bpf_stream_next_elem_batch, KF_ACQUIRE | KF_RET_NULL | KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_stream_free_elem_batch, KF_RELEASE)
> +BTF_ID_FLAGS(func, bpf_stream_next_elem, KF_ACQUIRE | KF_RET_NULL | KF_TRUSTED_ARGS)
> +BTF_ID_FLAGS(func, bpf_stream_free_elem, KF_RELEASE)
> +BTF_ID_FLAGS(func, bpf_prog_stream_get, KF_ACQUIRE | KF_RET_NULL)
> +BTF_ID_FLAGS(func, bpf_prog_stream_put, KF_RELEASE)
> +BTF_KFUNCS_END(stream_consumer_kfunc_set)

This is a complicated API.
If we anticipate that users intend to write this info to ring buffers
maybe just provide a function doing that and do not expose complete API?

[...]

I'll continue reading the patch-set tomorrow...

