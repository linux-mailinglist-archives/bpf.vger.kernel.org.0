Return-Path: <bpf+bounces-8662-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D07F8788D8F
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 19:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AB4B1C20DE2
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 17:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D251802D;
	Fri, 25 Aug 2023 17:05:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D72107A8
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 17:05:02 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A852B1FF7
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 10:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692983100;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5qKjBMHo1biiz/911STwdoJBuoMd8e2rBpwqZ/FJnf4=;
	b=dQ83ny07etZ5yf3h0fIY7E5y/zPy0P0Y3844p/ZiaDUrW+uwMw7dnHecwIuu8XKMfaa0M9
	n/TAWACumdCLXJJcg8yxsxN06oyVuXFRr3I2VE4RsXV0oEM3P5lJB7dI4ydd1w/VbdWPfc
	kurtX96BbyMGOxZMxtxtIPTysfMS4gk=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-199-45FaRmCbMZGoY5f6GRu2PA-1; Fri, 25 Aug 2023 13:04:56 -0400
X-MC-Unique: 45FaRmCbMZGoY5f6GRu2PA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E6FA928088AE;
	Fri, 25 Aug 2023 17:04:55 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.136])
	by smtp.corp.redhat.com (Postfix) with SMTP id 752C56B2B2;
	Fri, 25 Aug 2023 17:04:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 25 Aug 2023 19:04:09 +0200 (CEST)
Date: Fri, 25 Aug 2023 19:04:06 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>, Yonghong Song <yhs@fb.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kui-Feng Lee <kuifeng@fb.com>, Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] bpf: task_group_seq_get_next: fix the
 skip_if_dup_files check
Message-ID: <20230825170406.GA16800@redhat.com>
References: <20230825161842.GA16750@redhat.com>
 <20230825161947.GA16871@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825161947.GA16871@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Forgot to mention in the changelog...

In any case this doesn't look right. ->group_leader can exit before other
threads, call exit_files(), and in this case task_group_seq_get_next() will
check task->files == NULL.

On 08/25, Oleg Nesterov wrote:
>
> Unless I am notally confused it is wrong. We are going to return or
> skip next_task so we need to check next_task-files, not task->files.
>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  kernel/bpf/task_iter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index 1589ec3faded..2264870ae3fc 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -82,7 +82,7 @@ static struct task_struct *task_group_seq_get_next(struct bpf_iter_seq_task_comm
>
>  	common->pid_visiting = *tid;
>
> -	if (skip_if_dup_files && task->files == task->group_leader->files) {
> +	if (skip_if_dup_files && next_task->files == next_task->group_leader->files) {
>  		task = next_task;
>  		goto retry;
>  	}
> --
> 2.25.1.362.g51ebf55


