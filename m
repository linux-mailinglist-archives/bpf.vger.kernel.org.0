Return-Path: <bpf+bounces-75199-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 19447C767C5
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 23:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 641954E37CB
	for <lists+bpf@lfdr.de>; Thu, 20 Nov 2025 22:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4B035E52C;
	Thu, 20 Nov 2025 22:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GwAPoNFy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B52A35B146;
	Thu, 20 Nov 2025 22:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763677429; cv=none; b=neSVCQSdw6mDb2JltGuCXWJp8K8w66Tsl9ZOA1LOqXNfyzVjavwduJSyJxvemBEsTzMawBmm0wSn2w60OkjJYUX6oS2oANRkg0w5O7KMvhMVAjS/fbClZRhB1KfH6xLnEhl961im4BtVRHoCWOPasq7/kuh/4EsrKM79L9UoMJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763677429; c=relaxed/simple;
	bh=RfmZ0q3dpeM9+27uKN9f18dW33MgVedYGjvrAMkwrSg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Fq1+Y1I8fZa4760x8O1BcYkg+mYtD97GoVmCKHqebjvh5OhFMPTMVqbWSjFPISA/7Oh/vcldsY0keuaeU++drDRgCCV9ZZwmBrOoAHf+QzcM7sQB9TqKBdONmDigDVlI0fC7qyHk8VGo3Se3fk58RXPvTzd6pJYS9Rzk+It75LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GwAPoNFy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2369C4CEF1;
	Thu, 20 Nov 2025 22:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763677428;
	bh=RfmZ0q3dpeM9+27uKN9f18dW33MgVedYGjvrAMkwrSg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=GwAPoNFyP6d2be4hxlHSIwrE/pEwofx3MPNIqaAZmPlKX5rSMZ66kmg+l8VunbIXf
	 AtpkULDNEgj9C6El/6GtczMVlcVkRkEV8S4+ZgFZLWYv9+pQjAx8vs0IMLJrLYvpOj
	 I48LcFUeC/uHmBI9yhAMqL4KuBJiUll9x1s00O17Nx1EgjFQe4BXToczZdZUop3j/V
	 vNl2wBf0fLchc1pC4yT3wlP0FI55pHphMfW6wcnPBD1PXRpqqM1pqLFGgrDt9mIqsU
	 a8uOxlzpIuyp3Qvfhr6bhg8Oh6xgEhLkmSoh4+lymm2GsdLGYEHmHqNrwbcRt07niE
	 JqfliggfbRXvQ==
Content-Type: multipart/mixed; boundary="===============8823332936014851221=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a302c70bc1914835ea69c8b30105741b1d1d06d549ef95b9650d0827e0ca276a@mail.kernel.org>
In-Reply-To: <20251120212402.466524-6-jolsa@kernel.org>
References: <20251120212402.466524-6-jolsa@kernel.org>
Subject: Re: [PATCHv3 bpf-next 5/8] ftrace: Add update_ftrace_direct_mod function
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,rostedt@kernel.org,revest@google.com,mark.rutland@arm.com
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-trace-kernel@vger.kernel.org,linux-arm-kernel@lists.infradead.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,menglong8.dong@gmail.com,song@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 20 Nov 2025 22:23:47 +0000 (UTC)

--===============8823332936014851221==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> index c571deeff..4e2c0ed76 100644
> --- a/include/linux/ftrace.h
> +++ b/include/linux/ftrace.h

[ ... ]

> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index cc730a8fd..5243aefb6 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c

[ ... ]

> @@ -6486,6 +6486,74 @@ int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
>  	return err;
>  }
>
> +int update_ftrace_direct_mod(struct ftrace_ops *ops, struct ftrace_hash *hash, bool do_direct_lock)
> +{
> +	struct ftrace_hash *orig_hash = ops->func_hash->filter_hash;
                                             ^^^^^^^^^^^^^^^^

Can this crash if ops->func_hash is NULL?  In update_ftrace_direct_add()
and update_ftrace_direct_del(), there's a defensive check:

    old_filter_hash = ops->func_hash ? ops->func_hash->filter_hash : NULL;

But update_ftrace_direct_mod() dereferences ops->func_hash before any
validation checks occur. The check_direct_multi(ops) validation happens
later, but the dereference occurs first at function entry.

> +	struct ftrace_func_entry *entry, *tmp;
> +	static struct ftrace_ops tmp_ops = {
> +		.func		= ftrace_stub,
> +		.flags		= FTRACE_OPS_FL_STUB,
> +	};
> +	unsigned long size, i;
> +	int err;
> +
> +	if (!hash_count(hash))
> +		return -EINVAL;
> +	if (check_direct_multi(ops))
> +		return -EINVAL;

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19552032346

--===============8823332936014851221==--

