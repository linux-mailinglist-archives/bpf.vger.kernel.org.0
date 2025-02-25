Return-Path: <bpf+bounces-52579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BACA44F58
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 22:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAEE719C1E8B
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 21:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91A4212B0E;
	Tue, 25 Feb 2025 21:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fLJ6M/7N"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA0021171A
	for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 21:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740520705; cv=none; b=ZcyAxHtUKZngEJcIFX5NrxKSzm9hlH2fxU0En5oKfLK6JR9/ZJiu56dG7imlLuhsmWdrgafBWfW0GHs2Re8A0VGmJK8RazKRPIMK54jjActUWfvutDbN2U/hx7uYQJkbSEvVe4U5+0EkrVtmGdN//ycB6c9N8bfYwojpmFT0WVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740520705; c=relaxed/simple;
	bh=hcXGY5IaRLAN5LSuKd4tQ+6BZBdaCuDllfmAu9elClA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fQ8gERQZqI4+cP6wkpZ4iNnxgbwoiwYBHBF1j2dwB2T8vqJDKRRcUpBr1d0iWkv7d7rSb+X8YwdrcqHagWVWllYRTItvcGWkNwzjMTFNlPX7BBOG4xoRuyNu9AdKGvXGIJpuhkGcoPThAw0KCJPai9tQYKg6wwNUYj+N5LYkPos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fLJ6M/7N; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <313aff82-75c0-4575-ab3d-9a4037f47307@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740520701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pcicUQgZEcoxtexnm4nKyr7c92pvQrV/val7xsoI+Ts=;
	b=fLJ6M/7N5vE4M5X0I8EmZPquMCoZd+V9Eg3IvkdlmdqLf8ldisk0voDUYkCmpZ8aoI3TqZ
	ZJ1Rge8Br4Awd6zk0mU/7ibvrb8KVlmYQSuhWFdIbXNiRiyz3bcb9kSgfiyFFw2mbOYbp3
	p+l1cRT+5mhb0yHWCf39oCA3pbOQhOM=
Date: Tue, 25 Feb 2025 13:58:15 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Test gen_pro/epilogue that
 generate kfuncs
To: Amery Hung <ameryhung@gmail.com>
Cc: daniel@iogearbox.net, andrii@kernel.org, alexei.starovoitov@gmail.com,
 martin.lau@kernel.org, eddyz87@gmail.com, kernel-team@meta.com,
 bpf@vger.kernel.org
References: <20250225212915.145949-1-ameryhung@gmail.com>
 <20250225212915.145949-2-ameryhung@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250225212915.145949-2-ameryhung@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/25/25 1:29 PM, Amery Hung wrote:
> @@ -1411,6 +1496,13 @@ static void st_ops_unreg(void *kdata, struct bpf_link *link)
>   
>   static int st_ops_init(struct btf *btf)
>   {
> +	struct btf *kfunc_btf;
> +
> +	bpf_cgroup_from_id_id = bpf_find_btf_id("bpf_cgroup_from_id", BTF_KIND_FUNC, &kfunc_btf);
> +	bpf_cgroup_release_id = bpf_find_btf_id("bpf_cgroup_release", BTF_KIND_FUNC, &kfunc_btf);
> +	if (!bpf_cgroup_from_id_id || !bpf_cgroup_release_id)

Just noticed this. This should be "< 0" check. No need for "== 0" check because 
"id == 0" is reserved for "void" which is not BTF_KIND_FUNC.

With that,

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>

