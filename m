Return-Path: <bpf+bounces-74840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8C0C66D54
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 02:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C8B3934E298
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 01:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED6B307496;
	Tue, 18 Nov 2025 01:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8n8wVUb"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB7621E0BA;
	Tue, 18 Nov 2025 01:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763429267; cv=none; b=dPC7dGoQ4EoaNm+h5o07zrhMBbZ7HljavjXPkpKQ9qVEXov9xNCbNTFy2P6iF5AQuSYX0+TBCJSzNL69ERpyUx6RiVqDMZJoWnoqQs9XfBAxLtmTr9V9PIv6YhEQjZYriDoxaNEG8hI2j2WB8R61fZL4vr4Ah4DaRGQjWxUJRvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763429267; c=relaxed/simple;
	bh=0oteIb+X1fJCyo+Zxr4nkUcxMjcvmBQGKU7OiOe0rpY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=kn4YlGEzL8ouiZHMgiKSdF+jSI6PYRERN6kj3Bo+liZYmtZt5CpNHX9dd5b/ng3vC0SsuVL5B1zrS+5TMZQFT9rsj6v8v1msWexh2yV/+Hj7S5SagNoGaD4nzt4mUMAyaxAlCpD81qoLJRZgQMQLW2uQF9UyyrfeVOdyp094shY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8n8wVUb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB32C2BC9E;
	Tue, 18 Nov 2025 01:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763429267;
	bh=0oteIb+X1fJCyo+Zxr4nkUcxMjcvmBQGKU7OiOe0rpY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=G8n8wVUbDy9xMoxpRV8pACQkfp9whBlQYQ78z1mHVC+Tv+BDltUo0t5oda21AUDCY
	 T5DNkpifz6tSITK5L4rpTl211NX7Bj1hexmjiJ4XK6DOHTZ4Q+KFKt+tcEofcurJwv
	 i1LLbAZI4MmVtRlBIkWPeNo1GRfaPm60Cv8CmoDYEtU279u8RhX81DoCg4ZuTZv92n
	 vMWp9X9lpd5LH1IKOrDg4ULRstBc2OAZ7vKF54PSE29eCRV33uUQsyGHtdO5h5GsxU
	 Um54PFFFXeSQdvMIWVq5baqALXlJuFHx6nOngKATHyhNX2SsBXUgnlMvWYiYf8Kc84
	 hLa4GMK9a05rA==
Content-Type: multipart/mixed; boundary="===============1479139858118383586=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ad3ea8d7ccb10a7972db01b58d2596b425d60718ec09450a1ed6d7839488af51@mail.kernel.org>
In-Reply-To: <20251118005305.27058-2-jordan@jrife.io>
References: <20251118005305.27058-2-jordan@jrife.io>
Subject: Re: [RFC PATCH bpf-next 1/7] bpf: Set up update_prog scaffolding for bpf_tracing_link_lops
From: bot+bpf-ci@kernel.org
To: jordan@jrife.io,bpf@vger.kernel.org
Cc: jordan@jrife.io,linux-arm-kernel@lists.infradead.org,linux-s390@vger.kernel.org,x86@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,puranjay@kernel.org,iii@linux.ibm.com,mingo@redhat.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 18 Nov 2025 01:27:45 +0000 (UTC)

--===============1479139858118383586==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 09d5dc541..23fcbcd26 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h

[ ... ]

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index a2a441185..14dd8be7b 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c

[ ... ]

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 04104397c..d2fd02e10 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -607,6 +607,35 @@ int bpf_trampoline_link_prog(struct bpf_tramp_link *link,
>  	return err;
>  }
>
> +static int __bpf_trampoline_update_prog(struct bpf_tramp_link *link,
> +					struct bpf_prog *new_prog,
> +					struct bpf_trampoline *tr)
> +{
> +	return -ENOTSUPP;
> +}
> +
> +int bpf_trampoline_update_prog(struct bpf_tramp_link *link,
> +			       struct bpf_prog *new_prog,
> +			       struct bpf_trampoline *tr)
> +{
> +	struct bpf_prog *old_prog;
> +	int err;
> +
> +	mutex_lock(&tr->mutex);
> +	err = __bpf_trampoline_update_prog(link, new_prog, tr);
> +	if (!err) {
> +		/* If a program update was successful, switch the program
> +		 * in the link before releasing tr->mutex; otherwise, another
> +		 * operation could come along and update the trampoline with
> +		 * the link still pointing at the old program.
> +		 */
> +		old_prog = xchg(&link->link.prog, new_prog);
> +		bpf_prog_put(old_prog);
> +	}
> +	mutex_unlock(&tr->mutex);
> +	return err;
> +}
> +

Can bpf_prog_put() be called while holding tr->mutex?

When bpf_prog_put()->__bpf_prog_put() drops the program's refcount to
zero and we're not in IRQ context (which we aren't when holding a regular
mutex), it directly calls bpf_prog_put_deferred(). This eventually calls
bpf_trampoline_put(), which takes trampoline_mutex.

The existing code in bpf_trampoline_link_cgroup_shim() carefully unlocks
tr->mutex before calling bpf_trampoline_put() (see the comment "have to
release tr while _not_ holding its mutex"). Additionally,
bpf_trampoline_put() has WARN_ON_ONCE(mutex_is_locked(&tr->mutex)) to
catch this pattern.

Should bpf_prog_put() be moved after mutex_unlock(&tr->mutex)?

>  static int __bpf_trampoline_unlink_prog(struct bpf_tramp_link *link,
>  					struct bpf_trampoline *tr,
>  					struct bpf_prog *tgt_prog)

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19450205468

--===============1479139858118383586==--

