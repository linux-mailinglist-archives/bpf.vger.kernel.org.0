Return-Path: <bpf+bounces-8170-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5720078304D
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 20:35:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07700280E72
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 18:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3DD4A17;
	Mon, 21 Aug 2023 18:35:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D4D19F
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 18:35:41 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA8742A6
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 11:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692642939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VnozOf1ZSQALyFb1iX/34LT/2tx9Fp66PH2IuRGYQt0=;
	b=M9mmt0cdgARhYyl64CKcOGHu74DTDzA+VhcU8nGtY6oqMHcCFnbeidFWAYeCQ49hqoCNr4
	i4zH8WUOIHodx3cgaJLqpt6my/unfvQMpTkw4n716Ho8FJDVXYSC1ZgrOqGaEpRJDxN0fV
	tpxxUvDYvNTPrJNSONmdGrc2vrftMbk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-510-mt3hkESpNAmYolWgawQYDg-1; Mon, 21 Aug 2023 14:35:32 -0400
X-MC-Unique: mt3hkESpNAmYolWgawQYDg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E39E2101B450;
	Mon, 21 Aug 2023 18:35:31 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.99])
	by smtp.corp.redhat.com (Postfix) with SMTP id D53E72166B25;
	Mon, 21 Aug 2023 18:35:29 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 21 Aug 2023 20:34:46 +0200 (CEST)
Date: Mon, 21 Aug 2023 20:34:43 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: Yonghong Song <yhs@fb.com>, Kui-Feng Lee <kuifeng@fb.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: task_group_seq_get_next: cleanup the usage of
 next_thread()
Message-ID: <20230821183443.GA12526@redhat.com>
References: <20230821150909.GA2431@redhat.com>
 <e0c71c5c-09e6-d94e-6db3-3acf3ee502d6@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0c71c5c-09e6-d94e-6db3-3acf3ee502d6@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 08/21, Kui-Feng Lee wrote:
>
>
> On 8/21/23 08:09, Oleg Nesterov wrote:
> >1. find_pid_ns() + get_pid_task() under rcu_read_lock() guarantees that we
> >    can safely iterate the task->thread_group list. Even if this task exits
> >    right after get_pid_task() (or goto retry) and pid_alive() returns 0 >
> >    Kill the unnecessary pid_alive() check.
>
> This function will return next_task holding a refcount, and release the
> refcount until the next time calling the same function. Meanwhile,
> the returned task A may be killed, and its next task B may be
> killed after A as well, before calling this function again.
> However, even task B is destroyed (free), A's next is still pointing to
> task B. When this function is called again for the same iterator,
> it doesn't promise that B is still there.

Not sure I understand...

OK, if we have a task pointer with incremented refcount and do not hold
rcu lock, then yes, you can't remove the pid_alive() check in this code:

	rcu_read_lock();
	if (pid_alive(task))
		do_something(next_thread(task));
	rcu_read_unlock();

because task and then task->next can exit and do call_rcu(delayed_put_task_struct)
before we take rcu_read_lock().

But if you do something like

	rcu_read_lock();

	task = find_task_in_some_rcu_protected_list();
	do_something(next_thread(task));

	rcu_read_unlock();

then next_thread(task) should be safe without pid_alive().

And iiuc task_group_seq_get_next() always does

	rcu_read_lock();	// the caller does lock/unlock

	task = get_pid_task(pid, PIDTYPE_PID);
	if (!task)
		return;
	
	next_task = next_thread(task);

	rcu_read_unlock();

Yes, both task and task->next can exit right after get_pid_task(), but since
can only happen after we took rcu_read_lock(), delayed_put_task_struct() can't
be called until we drop rcu lock.

What have I missed?

Oleg.


