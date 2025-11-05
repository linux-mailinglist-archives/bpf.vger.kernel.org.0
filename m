Return-Path: <bpf+bounces-73637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 538BFC35F16
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 15:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 762693A34E7
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 13:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254C3320CC2;
	Wed,  5 Nov 2025 13:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDSyN06L"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96574314B74
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 13:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762351066; cv=none; b=arG8bldALjI5kiKnxAuqGeTxhhDfXnSXpRYGx2GnTR2IMI72jmzIXEimyEsuP2Pi40cU1ndfyvms5K3h4zAuUhVffT56yOd9A7Ue70lvtAMjJI/eJ+m65bupzlCzkAdWh597cS6XcFFukSfv/JDe+hwnrcAFzJj66ZKbGKOHb/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762351066; c=relaxed/simple;
	bh=SLRqwWQrS00g4sqKJVWWr4pojKE1Fi7BaSDxFtLNluU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=DsFebIaSBY7QBdb5uDxiVZsmEw4dIqwJ04+mOi4JMQOeDEvcgm2rhDFoChbmNhFE20cI42odJzJTcyJ0tHGKagbMsA9wnbWn4+42rw02ghKfFvcmEFVyqo43OPLAfghN5JEEdP+gl8PljxAZFC0JA2w6+X24OufIJBW1xswqKxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDSyN06L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D634BC4CEF5;
	Wed,  5 Nov 2025 13:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762351066;
	bh=SLRqwWQrS00g4sqKJVWWr4pojKE1Fi7BaSDxFtLNluU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=DDSyN06LxWH8VxrtBMHosK2SWrR80gL9m7zduzuKGtQksZhtR1UAvhV5wDU9RQoLN
	 NOeL+n1qzF3PvIZwxMuW55rCV3L6NgeRJggbLPZ8Hyo2ozgeJrhHCwjeSLU2qJBIYn
	 CqucqLKDdwkaxPX23S4IFRaUECO1OnPBbbgpzx+KJpNal2pElpf4QEcAJ4f/0kCx1H
	 dQhr0vHaxFByZbbiKOapgAwlbXtJb79wtQYWuJ3dL0kv8kxU0MeRXnKdZfj6nRNKHI
	 PnqnWzgW1rbCi1gCB11tbGpNaVMy1gNCj7CtTDnoFdrxgjK3L7en3pRWE1kEhUamYH
	 mfrMHYUIQvmDw==
Content-Type: multipart/mixed; boundary="===============7580735533768235636=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f4a48080a1d7a53289bcc83ba73ac6a8065dd3b921b6b1d390bf4fd8e0c3ab6a@mail.kernel.org>
In-Reply-To: <20251105132105.597344-1-mykyta.yatsenko5@gmail.com>
References: <20251105132105.597344-1-mykyta.yatsenko5@gmail.com>
Subject: Re: [PATCH bpf-next v1] selftests/bpf: align kfuncs renamed in bpf tree
From: bot+bpf-ci@kernel.org
To: mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,kafai@meta.com,kernel-team@meta.com
Cc: yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  5 Nov 2025 13:57:45 +0000 (UTC)

--===============7580735533768235636==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/file_reader.c b/tools/testing/selftests/bpf/progs/file_reader.c
> index 166c3ac69..4d756b623 100644
> --- a/tools/testing/selftests/bpf/progs/file_reader.c
> +++ b/tools/testing/selftests/bpf/progs/file_reader.c
> @@ -77,7 +77,7 @@ int on_open_validate_file_read(void *c)
>  		err = 1;
>  		return 0;
>  	}
> -	bpf_task_work_schedule_signal(task, &work->tw, &arrmap, task_work_callback, NULL);
> +	bpf_task_work_schedule_signal_impl(task, &work->tw, &arrmap, task_work_callback, NULL);
                                         ^^^^

Are the _impl kfuncs defined in this tree? A search of kernel/bpf/helpers.c
shows only bpf_task_work_schedule_signal() at line 4286 and
bpf_task_work_schedule_resume() at line 4303, without the _impl suffix.

The commit message says "It should go on top of [1] when applying on
bpf-next", suggesting this patch depends on another patch that hasn't
been applied yet. Without the dependency, these BPF programs will fail
verification when the verifier cannot find the _impl kfunc declarations.

>  	return 0;
>  }
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c b/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c
> index 96ff67491..7efa95211 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c
> @@ -156,7 +156,7 @@ int task_work_non_sleepable_prog(void *ctx)
>  	if (!task)
>  		return 0;
>
> -	bpf_task_work_schedule_resume(task, &val->tw, &task_work_map, task_work_cb, NULL);
> +	bpf_task_work_schedule_resume_impl(task, &val->tw, &task_work_map, task_work_cb, NULL);
                                         ^^^^

Same issue here in task_work_non_sleepable_prog() and also at the next
call site below in task_work_sleepable_prog().

>  	return 0;
>  }
>
> @@ -176,6 +176,6 @@ int task_work_sleepable_prog(void *ctx)
>  	if (!task)
>  		return 0;
>
> -	bpf_task_work_schedule_resume(task, &val->tw, &task_work_map, task_work_cb, NULL);
> +	bpf_task_work_schedule_resume_impl(task, &val->tw, &task_work_map, task_work_cb, NULL);
>  	return 0;
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19103767001

--===============7580735533768235636==--

