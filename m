Return-Path: <bpf+bounces-47334-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC20B9F7F0B
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 17:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B742166DED
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 16:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A89227BBB;
	Thu, 19 Dec 2024 16:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XM249I5r"
X-Original-To: bpf@vger.kernel.org
Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C42E227567
	for <bpf@vger.kernel.org>; Thu, 19 Dec 2024 16:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734624687; cv=none; b=pYG0mJNCkh6vQPnQeJRVfH1H/93GmPlCIDY6QlriQtoYPxqf3uncPmVTw20shWSMHrhP5+ZaYcq9Enu9CwSRWgkX/yIPtjw7Wwclvq6Ah4tFO1tUofF9Sf9KZZ7xVzWn0EDunT3jtNw9DGa+pd7hAjmjIPqHUOOCXpTI8QfJ5Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734624687; c=relaxed/simple;
	bh=mWVH3rAsk5h3ckz3gNoSdBBBTkSCZ9BSG+hyNch2g3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vD3rN0fnlzXLsN8JsA1Juu03Pd50wmXJ0nCgPlAZZ2BHwjc3STkuyNbzt1Yc0fXeT4Vs6HaxUpkIZYV2ryb17RrHb6qiRzV/oAJRyChiMdkuUaeEUE5CoqLdE38eIBuftpFznLZwfXhmcXz/a2sYHVsVpdeIyshYBcIf60KOL1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XM249I5r; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <09256acb-9b23-4a25-a260-a4063d219899@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734624681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7UovLRK5y6ohnM8T6CZvegkTaxuziaYqQQ/0lf+o36A=;
	b=XM249I5r/a0K+DJ29HlMkFWuV4T21RQctWitV/3T5jB/4TT6oTCtBGNj4pzVQmZ4Jnt4xg
	FdYee6uZZm9ZTSdMzHIyBVDfpqMT4mkqMHfNXukGuzuCekg+e71YJXPY4auBkslde62N1Q
	6AaNqDiZlu3OwK6eJi+0lsrNKioTzIw=
Date: Thu, 19 Dec 2024 08:11:12 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v6 0/5] bpf: Add open-coded style process file
 iterator and bpf_fget_task() kfunc
Content-Language: en-GB
To: Juntong Deng <juntong.deng@outlook.com>, ast@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 memxor@gmail.com, snorcht@gmail.com, brauner@kernel.org
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <AM6PR03MB5080DC63013560E26507079E99042@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <AM6PR03MB5080DC63013560E26507079E99042@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT




On 12/17/24 3:34 PM, Juntong Deng wrote:
> This patch series adds open-coded style process file iterator
> bpf_iter_task_file and bpf_fget_task() kfunc, and corresponding
> selftests test cases.
>
> In addition, since fs kfuncs is generic and useful for scenarios
> other than LSM, this patch makes fs kfuncs available for SYSCALL
> program type.
>
> Although iter/task_file already exists, for CRIB we still need the
> open-coded iterator style process file iterator, and the same is true
> for other bpf iterators such as iter/tcp, iter/udp, etc.
>
> The traditional bpf iterator is more like a bpf version of procfs, but
> similar to procfs, it is not suitable for CRIB scenarios that need to
> obtain large amounts of complex, multi-level in-kernel information.
>
> The following is from previous discussions [1].
>
> [1]: https://lore.kernel.org/bpf/AM6PR03MB5848CA34B5B68C90F210285E99B12@AM6PR03MB5848.eurprd03.prod.outlook.com/
>
> This is because the context of bpf iterators is fixed and bpf iterators
> cannot be nested. This means that a bpf iterator program can only
> complete a specific small iterative dump task, and cannot dump
> multi-level data.
>
> An example, when we need to dump all the sockets of a process, we need
> to iterate over all the files (sockets) of the process, and iterate over
> the all packets in the queue of each socket, and iterate over all data
> in each packet.
>
> If we use bpf iterator, since the iterator can not be nested, we need to
> use socket iterator program to get all the basic information of all
> sockets (pass pid as filter), and then use packet iterator program to
> get the basic information of all packets of a specific socket (pass pid,
> fd as filter), and then use packet data iterator program to get all the
> data of a specific packet (pass pid, fd, packet index as filter).
>
> This would be complicated and require a lot of (each iteration)
> bpf program startup and exit (leading to poor performance).
>
> By comparison, open coded iterator is much more flexible, we can iterate
> in any context, at any time, and iteration can be nested, so we can
> achieve more flexible and more elegant dumping through open coded
> iterators.
>
> With open coded iterators, all of the above can be done in a single
> bpf program, and with nested iterators, everything becomes compact
> and simple.
>
> Also, bpf iterators transmit data to user space through seq_file,
> which involves a lot of open (bpf_iter_create), read, close syscalls,
> context switching, memory copying, and cannot achieve the performance
> of using ringbuf.
>
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> ---
> v5 -> v6:
> * Remove local variable in bpf_fget_task.
>
> * Remove KF_RCU_PROTECTED from bpf_iter_task_file_new.
>
> * Remove bpf_fs_kfunc_set from being available for TRACING.
>
> * Use get_task_struct in bpf_iter_task_file_new.
>
> * Use put_task_struct in bpf_iter_task_file_destroy.
>
> v4 -> v5:
> * Add file type checks in test cases for process file iterator
>    and bpf_fget_task().
>
> * Use fentry to synchronize tests instead of waiting in a loop.
>
> * Remove path_d_path_kfunc_non_lsm test case.
>
> * Replace task_lookup_next_fdget_rcu() with fget_task_next().
>
> * Remove future merge conflict section in cover letter (resolved).
>
> v3 -> v4:
> * Make all kfuncs generic, not CRIB specific.
>
> * Move bpf_fget_task to fs/bpf_fs_kfuncs.c.
>
> * Remove bpf_iter_task_file_get_fd and bpf_get_file_ops_type.
>
> * Use struct bpf_iter_task_file_item * as the return value of
>    bpf_iter_task_file_next.
>
> * Change fd to unsigned int type and add next_fd.
>
> * Add KF_RCU_PROTECTED to bpf_iter_task_file_new.
>
> * Make fs kfuncs available to SYSCALL and TRACING program types.
>
> * Update all relevant test cases.
>
> * Remove the discussion section from cover letter.
>
> v2 -> v3:
> * Move task_file open-coded iterator to kernel/bpf/helpers.c.
>
> * Fix duplicate error code 7 in test_bpf_iter_task_file().
>
> * Add comment for case when bpf_iter_task_file_get_fd() returns -1.
>
> * Add future plans in commit message of "Add struct file related
>    CRIB kfuncs".
>
> * Add Discussion section to cover letter.
>
> v1 -> v2:
> * Fix a type definition error in the fd parameter of
>    bpf_fget_task() at crib_common.h.
>
> Juntong Deng (5):
>    bpf: Introduce task_file open-coded iterator kfuncs
>    selftests/bpf: Add tests for open-coded style process file iterator
>    bpf: Add bpf_fget_task() kfunc
>    bpf: Make fs kfuncs available for SYSCALL program type
>    selftests/bpf: Add tests for bpf_fget_task() kfunc
>
>   fs/bpf_fs_kfuncs.c                            | 38 ++++----
>   kernel/bpf/helpers.c                          |  3 +
>   kernel/bpf/task_iter.c                        | 91 +++++++++++++++++++
>   .../testing/selftests/bpf/bpf_experimental.h  | 15 +++
>   .../selftests/bpf/prog_tests/fs_kfuncs.c      | 46 ++++++++++
>   .../testing/selftests/bpf/prog_tests/iters.c  | 79 ++++++++++++++++
>   .../selftests/bpf/progs/fs_kfuncs_failure.c   | 33 +++++++
>   .../selftests/bpf/progs/iters_task_file.c     | 86 ++++++++++++++++++
>   .../bpf/progs/iters_task_file_failure.c       | 91 +++++++++++++++++++
>   .../selftests/bpf/progs/test_fget_task.c      | 63 +++++++++++++
>   .../selftests/bpf/progs/verifier_vfs_reject.c | 10 --
>   11 files changed, 529 insertions(+), 26 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/progs/fs_kfuncs_failure.c
>   create mode 100644 tools/testing/selftests/bpf/progs/iters_task_file.c
>   create mode 100644 tools/testing/selftests/bpf/progs/iters_task_file_failure.c
>   create mode 100644 tools/testing/selftests/bpf/progs/test_fget_task.c

There are quite some CI failures.

    https://github.com/kernel-patches/bpf/actions/runs/12403224240/job/34626610882?pr=8266

Please investigate.



