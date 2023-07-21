Return-Path: <bpf+bounces-5591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 798C375C1B9
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 10:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 992541C21607
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 08:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7A62100;
	Fri, 21 Jul 2023 08:32:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63557FD
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 08:32:30 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E888121
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 01:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689928348;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vr0wryO8MnQwRE8jPvHjsolatVlQYIMnbiPdRghbqvM=;
	b=TrdHkqugve0HFh8y0gvk/l4MZQNQL253+N0TGMKiP4bDYkrfAqL6LFTfhOOageob8CqkU0
	6RRZ8+SvRRSwYOXWfIvg9ITgOdtfR3U1cfkyq8uQIYXaqXuMWYqaMWFLQSUGG2teH0Kz/G
	56tn9qXD21mIv8MhK5PDG+xmwzkZG0I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-413-Gv193BZ3PR-GfMPgmNrkig-1; Fri, 21 Jul 2023 04:32:23 -0400
X-MC-Unique: Gv193BZ3PR-GfMPgmNrkig-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 59F9280C4FD;
	Fri, 21 Jul 2023 08:32:22 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.193])
	by smtp.corp.redhat.com (Postfix) with SMTP id 45226492B02;
	Fri, 21 Jul 2023 08:32:19 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 21 Jul 2023 10:31:45 +0200 (CEST)
Date: Fri, 21 Jul 2023 10:31:41 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv4 bpf-next 05/28] bpf: Add pid filter support for
 uprobe_multi link
Message-ID: <20230721083140.GA10521@redhat.com>
References: <20230720113550.369257-1-jolsa@kernel.org>
 <20230720113550.369257-6-jolsa@kernel.org>
 <CALOAHbB3_qTzi+2_0=pFjyDXFUh_MGMJt6gz7eh0Z=He4guPow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALOAHbB3_qTzi+2_0=pFjyDXFUh_MGMJt6gz7eh0Z=He4guPow@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07/21, Yafang Shao wrote:
>
> On Thu, Jul 20, 2023 at 7:36 PM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding support to specify pid for uprobe_multi link and the uprobes
> > are created only for task with given pid value.
>
> Is it possible to use tgid as the filter?
> It would be helpful when we uprobe a library file but want to filter
> out a multi-threaded task only.

I leave this to you and Jiri, just some notes...

I think it is possible but needs some complications.

uprobe_prog_run() needs a trivial change,

	-	if (link->task && current != link->task)
	+	if (link->task && same_thread_group(current, link->task)

->signal is tied to task_struct so this should work even if link->task has
already exited.


bpf_uprobe_multi_link_attach() should probably use

	get_pid_task(find_vpid(pid), PIDTYPE_TGID);

to ensure that 'pid' is actually tgid.


But. uprobe_multi_link_filter() can return F if the group leader has already
exited, in this case uprobe->link->task->mm == NULL.

Perhaps we can simply ignore this case, a zombie group-leader is not that common.

Or we can add uprobe->link->mm = get_task_mm(uprobe->link->task->mm) for
uprobe_multi_link_filter().

Or. We can simply kill uprobe_multi_link_filter(). In this case uprobe_register()
can touch CLONE_VM'ed mm's we are not interested in, but everything should work
correctly.

Oleg.


