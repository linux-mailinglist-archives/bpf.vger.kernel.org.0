Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0B562597BD
	for <lists+bpf@lfdr.de>; Tue,  1 Sep 2020 18:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731829AbgIAQRw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Sep 2020 12:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728299AbgIAQR1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Sep 2020 12:17:27 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25A5C061245
        for <bpf@vger.kernel.org>; Tue,  1 Sep 2020 09:17:26 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id b13so778314qvl.2
        for <bpf@vger.kernel.org>; Tue, 01 Sep 2020 09:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rwcR0ryYllRVf0nYQgJZbwDVN9tCvZmWsjGT3VuokhE=;
        b=e5Uv35fii6eYNzL3wfJDqI7KhS4v7n7ARMfHm9kw/QkfjuRn+f+nt9jlc17x/90HwR
         W/LQH1H8GpffAqsosVWL3dynzKJzQFaN4X3saN6x0ZjjSKcCGiGOD3CSLwvGkvjWLObR
         s76Y3KpkBHn6R7daGy2TR+GHoX1J+IzSybjYRAuLMI6DeSHgsW05v2RbTJwmpZLxTcbd
         Dbn/XzCR8Cj5DS7IddPTCP4nOKoSYMU+affxcT9pTu3efOthLZYGuIhjVVbr1eChJyV6
         LOEf1rm36ykGlVrdNNqD8Q/17oaegLuCPL+z64ZJ9SYD9NtETd8QOgtpf2X85LKr3gIj
         MA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rwcR0ryYllRVf0nYQgJZbwDVN9tCvZmWsjGT3VuokhE=;
        b=LzHu7uYVRukJdL0HBSkuk9Z+YgyLPTAtZiDz3xs812IHpFVuoqjC0mzg84ZiWGCCrj
         38kztLxVEaum/K8297FqkU2aVDNKnqnRxqgxm+/4+ZvOXoWVZ13vr+7YDv8mMAITfiPW
         8b8WPB1eAw6Hj1fZWeYd3gxmKdbORM1k9zDTDixBPBdYGPNZrFhnPnLle4RWyCSOPUqF
         7VbNWGzyBJ1h0+ctlG71nvLYxxzurt7q7yrgH6uFTHkZQUCOwMCI8ej6yKkm9RGP9ajY
         jJdEAXoSA9qWkKgCHSid0wIjV4Wz7EPTskoc3ZIkVOOzr9hZ4NxfnwbWYgly8mkOYRr7
         86zg==
X-Gm-Message-State: AOAM530tKR5T5e7wlIOkSeLfbTp9WpNTnVjNtOLXgnAVCSzTDWRoJp5a
        U2dp56IJVVbtawgM7fdn3WCo5w==
X-Google-Smtp-Source: ABdhPJy7Ck2GQ6553yYjTWrNgCmgftvFPuWAGEN5vb7wrbn4puVjtj1Hq8yZrMy533aOFZuZbD294w==
X-Received: by 2002:a0c:e989:: with SMTP id z9mr2732027qvn.81.1598977046007;
        Tue, 01 Sep 2020 09:17:26 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q185sm2151899qke.25.2020.09.01.09.17.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 09:17:24 -0700 (PDT)
Subject: Re: [PATCH bpf-next v2 1/2] bpf: avoid iterating duplicated files for
 task_file iterator
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Andrii Nakryiko <andriin@fb.com>
References: <20200828053815.817726-1-yhs@fb.com>
 <20200828053815.817806-1-yhs@fb.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <b3a4062d-1f8b-ee6a-66a8-90709be778a1@toxicpanda.com>
Date:   Tue, 1 Sep 2020 12:17:22 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200828053815.817806-1-yhs@fb.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 8/28/20 1:38 AM, Yonghong Song wrote:
> Currently, task_file iterator iterates all files from all tasks.
> This may potentially visit a lot of duplicated files if there are
> many tasks sharing the same files, e.g., typical pthreads
> where these pthreads and the main thread are sharing the same files.
> 
> This patch changed task_file iterator to skip a particular task
> if that task shares the same files as its group_leader (the task
> having the same tgid and also task->tgid == task->pid).
> This will preserve the same result, visiting all files from all
> tasks, and will reduce runtime cost significantl, e.g., if there are
> a lot of pthreads and the process has a lot of open files.
> 
> Suggested-by: Andrii Nakryiko <andriin@fb.com>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>   kernel/bpf/task_iter.c | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
> 
> It would be good if somebody familar with sched code can help check
> whether I missed anything or not (e.g., locks, etc.)
> for the code change
>    task->files == task->group_leader->files
> 
> Note the change in this patch might have conflicts with
> e60572b8d4c3 ("bpf: Avoid visit same object multiple times")
> which is merged into bpf/net sometimes back.
> 
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index 232df29793e9..0c5c96bb6964 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -22,7 +22,8 @@ struct bpf_iter_seq_task_info {
>   };
>   
>   static struct task_struct *task_seq_get_next(struct pid_namespace *ns,
> -					     u32 *tid)
> +					     u32 *tid,
> +					     bool skip_if_dup_files)
>   {
>   	struct task_struct *task = NULL;
>   	struct pid *pid;
> @@ -32,7 +33,10 @@ static struct task_struct *task_seq_get_next(struct pid_namespace *ns,
>   	pid = idr_get_next(&ns->idr, tid);
>   	if (pid) {
>   		task = get_pid_task(pid, PIDTYPE_PID);
> -		if (!task) {
> +		if (!task ||
> +		    (skip_if_dup_files &&
> +		     task->tgid != task->pid &&
> +		     task->files == task->group_leader->files)) {

This is fine, we're not deref'ing files, if we were you'd need 
get_files_struct().  You can deref task->group_leader here because you got the 
task so this is safe.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
