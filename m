Return-Path: <bpf+bounces-15156-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D827EDA42
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 04:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B39B28107F
	for <lists+bpf@lfdr.de>; Thu, 16 Nov 2023 03:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056B58F6A;
	Thu, 16 Nov 2023 03:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mtUJYffo"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4AF1A7;
	Wed, 15 Nov 2023 19:31:14 -0800 (PST)
Message-ID: <34440ea4-3780-45e4-9e7c-1b36b535171b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700105471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FTxwzSEDi784ojOMTYlXzDGW+u2ti6TGSVNgjCMMJoI=;
	b=mtUJYffom2JJWEk5h7mVxM6l9zknyavpRxNkyEAWnr042eNFmUWCzDqLXP07gK34USqP5L
	Fn7JJ6JdXQd4tPcnTnp+VpNi4clUTHdVPs/7+sA3yUGwb/B4EKBjIFt34RPIgDs+rdY00d
	FCTfUp92uRGdjOJ3nwM3tCM/rKVhnvA=
Date: Wed, 15 Nov 2023 22:31:03 -0500
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] bpf: task_group_seq_get_next: use __next_thread()
 rather than next_thread()
Content-Language: en-GB
To: Oleg Nesterov <oleg@redhat.com>, Alexei Starovoitov <ast@kernel.org>
Cc: Chuyi Zhou <zhouchuyi@bytedance.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Kui-Feng Lee <kuifeng@fb.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20231114163234.GA890@redhat.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20231114163234.GA890@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 11/14/23 11:32 AM, Oleg Nesterov wrote:
> Lockless use of next_thread() should be avoided, kernel/bpf/task_iter.c
> is the last user and the usage is wrong.
>
> task_group_seq_get_next() can return the group leader twice if it races
> with mt-thread exec which changes the group->leader's pid.
>
> Change the main loop to use __next_thread(), kill "next_tid == common->pid"
> check.
>
> __next_thread() can't loop forever, we can also change this code to retry
> if next_tid == 0.
>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>   kernel/bpf/task_iter.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index 26082b97894d..51ae15e2b290 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -70,15 +70,13 @@ static struct task_struct *task_group_seq_get_next(struct bpf_iter_seq_task_comm
>   		return NULL;
>   
>   retry:
> -	task = next_thread(task);
> +	task = __next_thread(task);
> +	if (!task)
> +		return NULL;
>   
>   	next_tid = __task_pid_nr_ns(task, PIDTYPE_PID, common->ns);
> -	if (!next_tid || next_tid == common->pid) {
> -		/* Run out of tasks of a process.  The tasks of a
> -		 * thread_group are linked as circular linked list.
> -		 */
> -		return NULL;
> -	}
> +	if (!next_tid)
> +		goto retry;

Look at the code. Looks like next_tid should never be 0 unless some
task is migrated to other namespace which I think is not possible.

common->ns is assigned as below:
   common->ns = get_pid_ns(task_active_pid_ns(current))
so we are searching tasks in the *current* namespace.

Look at:
pid_t pid_nr_ns(struct pid *pid, struct pid_namespace *ns)
{
         struct upid *upid;
         pid_t nr = 0;

         if (pid && ns->level <= pid->level) {
                 upid = &pid->numbers[ns->level];
                 if (upid->ns == ns)
                         nr = upid->nr;
         }
         return nr;
}

pid_t __task_pid_nr_ns(struct task_struct *task, enum pid_type type,
                         struct pid_namespace *ns)
{
         pid_t nr = 0;

         rcu_read_lock();
         if (!ns)
                 ns = task_active_pid_ns(current);
         nr = pid_nr_ns(rcu_dereference(*task_pid_ptr(task, type)), ns);
         rcu_read_unlock();
         
         return nr;
}

In func pid_nr_ns(), ns->level should be equal to pid->level if pid is
in input parameter 'ns'. and in this case the return value 'nr'
should be none zero.

If this is the case, could you remove
	if (!next_tid)
		goto retry;

Other than above, the change looks good to me.

>   
>   	if (skip_if_dup_files && task->files == task->group_leader->files)
>   		goto retry;

