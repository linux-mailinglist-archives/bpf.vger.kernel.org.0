Return-Path: <bpf+bounces-79486-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BD0D3B621
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 19:48:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E95830E0889
	for <lists+bpf@lfdr.de>; Mon, 19 Jan 2026 18:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81A538F248;
	Mon, 19 Jan 2026 18:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOEf7mct"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EFC2F360A;
	Mon, 19 Jan 2026 18:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768848346; cv=none; b=QUQgv9oGkKzWnLn70yYzoeEv4nQwQZdKZ1lpvxw+yzL1x+MqPKWW55BoLtho/DPTrESgw73MXmspY/QXhXiGDIrvtZwJwNqkg+PFk83QSg2VCtxv0sZMNh8pi6hhP5UvCKE1yg7FDUO4ufBpSx+eQfnBkqrpL9VWWvAhFbb1Jls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768848346; c=relaxed/simple;
	bh=M79Vmns/Avz7hIWo4vceBKReeeeMlgF1ADBYBVpfZ5U=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=LqDbABucvjcaVC8hsK7z50NvCv/FtYdsRxTs5WLgg7gAHixbQ3ziQpSDY+Slnzx4MLLQNWWUgZrcIvjt5x4WhiAfHYb5IUZtwe+GG3ml5ayO3CJW8Ko6UE5OrE60WoSz3ssVThiYmcPiFiSv7bZhpRYcWIfNHvbPlYKwT7lQtl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOEf7mct; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9347C19424;
	Mon, 19 Jan 2026 18:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768848344;
	bh=M79Vmns/Avz7hIWo4vceBKReeeeMlgF1ADBYBVpfZ5U=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=tOEf7mctB/OB4YSV1G1w6GWJEIOYeaDQLk7gmK7o+1BTw68evq2hIzDx/9qUTys8J
	 6XWXzT7TwTfAhWIpt0yDcSudYX9G3TsvPSPXe3CVDIBtfcumXhssQJ7aSUTLTCQmbp
	 vl9RLb1MWiX/Ot6ogICswk1dYqN/IAMFMDDIamFYxm6SqqSDLFIY0hI7rvvFXDlcg7
	 Ac3YCRU/flPUXuNld6iKAzE4/WQywc5gOiGtVslXKlqhgAdUpvxV0TAohTSeXpL6a6
	 bP8H5XGjuo8Jdluz+xyLSN9KSajYIA3z8gbXUOq6dGJHjzdqgXjSXJlBLuOP4woVU3
	 FVxqzy5Es4Lcg==
Content-Type: multipart/mixed; boundary="===============5395468137030447417=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ac79262dc46cbfcc238dfb3bfbb5feaa804a2b3b3e8ce2ab1e4b096b6985bdec@mail.kernel.org>
In-Reply-To: <20260119032424.10781-2-piliu@redhat.com>
References: <20260119032424.10781-2-piliu@redhat.com>
Subject: Re: [PATCHv6 01/13] bpf: Introduce kfuncs to parser buffer content
From: bot+bpf-ci@kernel.org
To: piliu@redhat.com,bpf@vger.kernel.org
Cc: piliu@redhat.com,davem@davemloft.net,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,jeremy.linton@arm.com,catalin.marinas@arm.com,will@kernel.org,ardb@kernel.org,horms@kernel.org,kraxel@redhat.com,vkuznets@redhat.com,prudo@redhat.com,vmalik@redhat.com,kernel@jfarr.cc,bhe@redhat.com,dyoung@redhat.com,akpm@linux-foundation.org,kexec@lists.infradead.org,systemd-devel@lists.freedesktop.org,linux-kernel@vger.kernel.org,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 19 Jan 2026 18:45:43 +0000 (UTC)

--===============5395468137030447417==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/bpf_buffer_parser.c b/kernel/bpf/bpf_buffer_parser.c
> new file mode 100644
> index 000000000000..6acb4b5da71b
> --- /dev/null
> +++ b/kernel/bpf/bpf_buffer_parser.c

[ ... ]

> +static void release_bpf_parser_context(struct kref *kref)
> +{
> +	struct bpf_parser_context *ctx = container_of(kref, struct bpf_parser_context, ref);
> +
> +	if (!!ctx->buf) {
> +		vfree(ctx->buf->buf);
> +		kfree(ctx->buf);
> +	}

[ ... ]

> +struct bpf_parser_context *alloc_bpf_parser_context(bpf_parser_handler_t func,
> +		void *data)
> +{
> +	struct bpf_parser_context *ctx;
> +	unsigned int key;
> +
> +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);

ctx->buf is NULL here from kzalloc.

[ ... ]

> +__bpf_kfunc int bpf_buffer_parser(char *buf, int buf_sz,
> +		struct bpf_parser_context *context)
> +{
> +	struct bpf_parser_buf *parser_buf;
> +	int ret;
> +	char *b;
> +
> +	if (unlikely(context->func == NULL))
> +		return -EINVAL;
> +
> +	b = __vmalloc(buf_sz, GFP_KERNEL_ACCOUNT | __GFP_ZERO);
> +	if (!b)
> +		return -ENOMEM;
> +	ret = copy_from_kernel_nofault(b, buf, buf_sz);
> +	if (!!ret) {
> +		vfree(b);
> +		return ret;
> +	}
> +
> +	parser_buf = kmalloc(sizeof(struct bpf_parser_buf), GFP_KERNEL);
> +	if (!parser_buf) {
> +		vfree(b);
> +		return -ENOMEM;
> +	}
> +	parser_buf->buf = b;
> +	parser_buf->size = buf_sz;
> +	context->buf = parser_buf;

If bpf_buffer_parser() is called multiple times on the same context, does
this leak the previous parser_buf and its backing vmalloc buffer? The
assignment to context->buf overwrites any existing pointer without first
freeing it.

release_bpf_parser_context() will only free the final context->buf value
when the context is destroyed, so any intermediate buffers from prior
calls would be lost.

Should there be a check here to either return an error if context->buf is
already set, or free the old buffer before assigning the new one?

> +	ret = context->func(context);
> +
> +	return ret;
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21147860407

--===============5395468137030447417==--

