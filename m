Return-Path: <bpf+bounces-78153-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BAD7CFFABF
	for <lists+bpf@lfdr.de>; Wed, 07 Jan 2026 20:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 303ED3452824
	for <lists+bpf@lfdr.de>; Wed,  7 Jan 2026 18:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367DD331A44;
	Wed,  7 Jan 2026 18:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SO++xmxz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB7C22A4FE;
	Wed,  7 Jan 2026 18:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767810701; cv=none; b=FayYlo63fqAtMWfU/ucM0XJVnBKa6ekeaDiYd4xuawkDhwWgiIBy6nLTAZ3va+TwXxdHZ06f0rwfbiV0UNTmawvKvB+BHKfOJvzZjN4i0ZygsoSHgGTNmBdtw6Xk1df5nJukPPWwT8d7fTx9X2akcJbpOe+cm01rGKJPJjti4F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767810701; c=relaxed/simple;
	bh=tiWz7ZyYMf9ScXUa+wyIt+0EmMop/T91xq6X1lu4fp0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=K7mkT4TKPZmTTObIdQOCSqnn4USnhKU3BI26tilurOk6Ez7T2dXNUprHprp4bTmKoTXNaWbQ3jOKg9VoPKpG3VBp7mypNTZvAXmcC394T4/HgBng3KvhLquCvu6/LfKRFfJRI1w7Y2nz5wo/hFmy9HqESJdbdZ+9q03BLsjN8ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SO++xmxz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320ABC4CEF7;
	Wed,  7 Jan 2026 18:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767810698;
	bh=tiWz7ZyYMf9ScXUa+wyIt+0EmMop/T91xq6X1lu4fp0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=SO++xmxzPDQhvT0ukuzFTp50glP8aCmy3aPwcO4/kTEtFhrloNlmyM5miDINAYfSv
	 DAhCWxxOO85tpM1in4P24usWMMv/l89qpWPVbDkgRfvcubP5nxyDxS3yTwUGjCj1PN
	 8CXCSIkNa4fGTPFqJNSw5mmRvTNzrXloQ2bJJuHRkym0dOVbZ82fd4QJ7p0Regnv+J
	 UdNQxejJVBwNJaeccRpPsoYxwAigKX6Ze1YWt2QhkWXJb/gd1OzwRSSx5V69YFH48O
	 9NuX4C7ndr1SWfiL82UuwfKUc2n8e/EZgDS6b7hx9BuJ3Y0ooLx4Qi5vZctar7GC4j
	 +YosWtw4YHuDw==
Content-Type: multipart/mixed; boundary="===============7187549189809104809=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f0c89037c4870388696751365cec002fe3ded78c7ef260bd99e1934ceb245acd@mail.kernel.org>
In-Reply-To: <20260107181237.1075490-1-contact@arnaud-lcm.com>
References: <20260107181237.1075490-1-contact@arnaud-lcm.com>
Subject: Re: [PATCH v2] bpf-next: Prevent out of bound buffer write in __bpf_get_stack
From: bot+bpf-ci@kernel.org
To: contact@arnaud-lcm.com,syzbot+d1b7fa1092def3628bd7@syzkaller.appspotmail.com
Cc: andrii@kernel.org,ast@kernel.org,bpf@vger.kernel.org,contact@arnaud-lcm.com,daniel@iogearbox.net,eddyz87@gmail.com,haoluo@google.com,john.fastabend@gmail.com,jolsa@kernel.org,kpsingh@kernel.org,linux-kernel@vger.kernel.org,martin.lau@linux.dev,netdev@vger.kernel.org,sdf@fomichev.me,song@kernel.org,syzkaller-bugs@googlegroups.com,yonghong.song@linux.dev,listout@listout.xyz,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  7 Jan 2026 18:31:38 +0000 (UTC)

--===============7187549189809104809==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index da3d328f5c15..c0a430f9eafb 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -465,7 +465,6 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>
>  	if (trace_in) {
>  		trace = trace_in;
> -		trace->nr = min_t(u32, trace->nr, max_depth);
>  	} else if (kernel && task) {
>  		trace = get_callchain_entry_for_task(task, max_depth);
>  	} else {
> @@ -473,13 +472,15 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
>  					   crosstask, false, 0);
>  	}
>
> +	trace_nr = min(trace->nr, max_depth);
                       ^^^^^^^^

Can this dereference trace when it is NULL? Both get_callchain_entry_for_task()
and get_perf_callchain() can return NULL, and several callers pass trace_in as
NULL (bpf_get_stack, bpf_get_stack_sleepable, __bpf_get_task_stack, and one
path in bpf_get_stack_pe).

The NULL check below comes after this dereference:

> +
> +	if (unlikely(!trace) || trace_nr < skip) {
                    ^^^^^^

This check is now ineffective because trace->nr was already dereferenced above.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20791981532

--===============7187549189809104809==--

