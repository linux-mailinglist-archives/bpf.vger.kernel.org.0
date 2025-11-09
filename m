Return-Path: <bpf+bounces-74017-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09322C444DC
	for <lists+bpf@lfdr.de>; Sun, 09 Nov 2025 19:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49AF03AF788
	for <lists+bpf@lfdr.de>; Sun,  9 Nov 2025 18:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D6A121ABAC;
	Sun,  9 Nov 2025 18:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNhCo7pK"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7839222759C
	for <bpf@vger.kernel.org>; Sun,  9 Nov 2025 18:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762711642; cv=none; b=C7FKkC0eO68stGEyTYW17scS3kDLluEHLpcmeMPMSMpPT+gU4lXrz7KggszePZqTJGYW/4IwiYP9UQIigt/dP0XNHkS+LGzl76UR2mw52qtN1Ty8lUKC2faPsG1CJYhGleDROfN+yZqo8PZa5b8MtcKp2AMb26qsNbIUwbne5ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762711642; c=relaxed/simple;
	bh=ye0CO/kkqILqfF1Gx12zmwAZ0r0QGwJ7R/Ukr+ZVkn0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=rnOmHtafvj+e4PspQcRDrLjTQlHqPNbC+IaFuciQ6GkaRQLMiYrobmW6iD4hIB6RSVJrWUkfooyKA/HrUWl7vJRYP5r8Ob1qYpfpEJARBz6M9gSQA31mNuxybs4nuVvi0AWeLKVXGnBjzXWw59zSj3Nuy2H55+87LCbfYmIorjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNhCo7pK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891C8C2BC9E;
	Sun,  9 Nov 2025 18:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762711642;
	bh=ye0CO/kkqILqfF1Gx12zmwAZ0r0QGwJ7R/Ukr+ZVkn0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=BNhCo7pK9QgIs7uXqvUhJTCBslNe1hFB7lI07LGmJWFFH5nUiHxV9mYha7LeXrw01
	 3Rc3zDO4/PVvVhBTQefUN4v+zgg2rXzLHx83kE5L0LqKAD8lvggM1hIXJcff+xQOC9
	 9MKWkHfaZbqSelOFoEG/i8N0XkgrAqPBA2VPjTC+1k+iN5PgaqhLajKDTf/BmM8D9j
	 Q+QUgMble9CI3zZ70y6ZaaWVRSVu2mQltiGlK+LA357XuS5Y3GCdqy3UUrMYJJLcRF
	 ppQMPJwV5D/q+mVjaRddX6pxpb14Q1PgnsbNQfUbSqw9qaXUoV4Yml/JkGEqiuA9YB
	 oZLVmKAfTI9UQ==
Content-Type: multipart/mixed; boundary="===============5538435541198330922=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <588e208637619b6c256f2a70dc35faeafda1a843b6410def9fa53ef8876a46e8@mail.kernel.org>
In-Reply-To: <20251109173648.401996-1-chandna.sahil@gmail.com>
References: <20251109173648.401996-1-chandna.sahil@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: use preempt_disable/enable() to protect bpf_bprintf_buffers nesting
From: bot+bpf-ci@kernel.org
To: chandna.sahil@gmail.com,yonghong.song@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,bigeasy@linutronix.de,bpf@vger.kernel.org
Cc: chandna.sahil@gmail.com,syzbot+b0cff308140f79a9c4cb@syzkaller.appspotmail.comi,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun,  9 Nov 2025 18:07:21 +0000 (UTC)

--===============5538435541198330922==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 865b0dae3..99780b654 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -774,9 +774,11 @@ int bpf_try_get_buffers(struct bpf_bprintf_buffers **bufs)
>  {
>  	int nest_level;
>
> +	preempt_disable();
>  	nest_level = this_cpu_inc_return(bpf_bprintf_nest_level);
>  	if (WARN_ON_ONCE(nest_level > MAX_BPRINTF_NEST_LEVEL)) {
>  		this_cpu_dec(bpf_bprintf_nest_level);
> +		preempt_enable();
>  		return -EBUSY;
>  	}
>  	*bufs = this_cpu_ptr(&bpf_bprintf_bufs[nest_level - 1]);
> @@ -786,9 +788,12 @@ int bpf_try_get_buffers(struct bpf_bprintf_buffers **bufs)
>
>  void bpf_put_buffers(void)
>  {
> -	if (WARN_ON_ONCE(this_cpu_read(bpf_bprintf_nest_level) == 0))
> +	if (WARN_ON_ONCE(this_cpu_read(bpf_bprintf_nest_level) == 0)) {
> +		preempt_enable();
                 ^^^^^^^^^^^^^^

Can this cause a preempt count underflow? The WARN_ON_ONCE checks for
nest_level==0, which means bpf_try_get_buffers() was never successfully
called. In that case, preempt_disable() was never called either, so calling
preempt_enable() here would underflow the preempt count.

In the normal calling pattern, bpf_try_get_buffers() either succeeds
(disabling preemption) or fails before reaching bpf_put_buffers(). But this
WARN exists to catch programming bugs where the get/put contract is violated.
If such a bug occurs, adding preempt_enable() here makes it worse by
introducing a preempt count imbalance on top of the original error.

> +		return;
> +	}
>  	this_cpu_dec(bpf_bprintf_nest_level);
> +	preempt_enable();
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19212189476

--===============5538435541198330922==--

