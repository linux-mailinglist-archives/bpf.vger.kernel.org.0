Return-Path: <bpf+bounces-8810-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD8178A15B
	for <lists+bpf@lfdr.de>; Sun, 27 Aug 2023 22:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B5431C208B7
	for <lists+bpf@lfdr.de>; Sun, 27 Aug 2023 20:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC471427F;
	Sun, 27 Aug 2023 20:20:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8176D14014
	for <bpf@vger.kernel.org>; Sun, 27 Aug 2023 20:20:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D57310C
	for <bpf@vger.kernel.org>; Sun, 27 Aug 2023 13:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693167604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zk+jyHlS4udgyaumJ7ZOq9OxrkbOZbwqog5PMYG+ER8=;
	b=YSxQYE9GClDQnMpo3GmK1J60cO9xw1E3QdpjRMbmeh4b1uG1keFRhc7qkvwsilXLXGfc4k
	JIua/HtSdSJnxjUB0JopuXm+JKc4YK5igyo4EDprIxHEgyTrI5LYZqufUm2Yxvux+w2EJF
	MMwwg1ytBp66rGT9aqHUAWSeB6/X+nY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-127--ufNaDsjO_W_5yWqcC5DDg-1; Sun, 27 Aug 2023 16:20:02 -0400
X-MC-Unique: -ufNaDsjO_W_5yWqcC5DDg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7259E85CCE0;
	Sun, 27 Aug 2023 20:20:01 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.39])
	by smtp.corp.redhat.com (Postfix) with SMTP id F37C0401051;
	Sun, 27 Aug 2023 20:19:58 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Sun, 27 Aug 2023 22:19:13 +0200 (CEST)
Date: Sun, 27 Aug 2023 22:19:10 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yonghong Song <yhs@fb.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kui-Feng Lee <kuifeng@fb.com>, Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] bpf: task_group_seq_get_next: fix the
 skip_if_dup_files check
Message-ID: <20230827201909.GC28645@redhat.com>
References: <20230825161842.GA16750@redhat.com>
 <20230825161947.GA16871@redhat.com>
 <20230825170406.GA16800@redhat.com>
 <e254a6db-66eb-8bfc-561f-464327a1005a@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e254a6db-66eb-8bfc-561f-464327a1005a@linux.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 08/25, Yonghong Song wrote:
>
> On 8/25/23 10:04 AM, Oleg Nesterov wrote:
> >Forgot to mention in the changelog...
> >
> >In any case this doesn't look right. ->group_leader can exit before other
> >threads, call exit_files(), and in this case task_group_seq_get_next() will
> >check task->files == NULL.
>
> It is okay. This won't be affecting correctness. We will end with
> calling bpf program for 'next_task'.

Well, I didn't mean it is necessarily wrong, I simply do not know.

But let's suppose that we have a thread group with the main thread M + 1000
sub-threads. In the likely case they all have the same ->files, CLONE_THREAD
without CLONE_FILES is not that common.

Let's assume the BPF_TASK_ITER_TGID case for simplicity.

Now lets look at task_file_seq_get_next() which passes skip_if_dup_files == 1
to task_seq_get_next() and thus to task_group_seq_get_next().

Now, in this case task_seq_get_next() will return non-NULL only once (OK, unless
task_file_seq_ops.stop() was called), it will return the group leader M first,
then after task_file_seq_get_next() "reports" all the fd's of M and increments
info->tid, the next task_seq_get_next(&info->tid, true) should return NULL because
of the skip_if_dup_files check in task_group_seq_get_next().

Right?

But. if the group leader M exits then M->files == NULL. And in this case
task_seq_get_next() will need to "inspect" all the sub-threads even if they all
have the same ->files pointer.

No?

Again, I am not saying this is a bug and quite possibly I misread this code, but
in any case the skip_if_dup_files logic looks sub-optimal and confusing to me.

Nevermind, please forget. This is minor even if I am right.

Thanks for rewiev!

Oleg.


