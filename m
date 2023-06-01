Return-Path: <bpf+bounces-1557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA757718F86
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 02:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FEF81C20FC0
	for <lists+bpf@lfdr.de>; Thu,  1 Jun 2023 00:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2554EEDE;
	Thu,  1 Jun 2023 00:29:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C3EA55
	for <bpf@vger.kernel.org>; Thu,  1 Jun 2023 00:29:25 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 17C22124;
	Wed, 31 May 2023 17:29:24 -0700 (PDT)
Received: from W11-BEAU-MD.localdomain (unknown [76.135.27.212])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4232520FC4D7;
	Wed, 31 May 2023 17:29:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4232520FC4D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1685579363;
	bh=Z1v23pKuDidufXUFzDrQNxKmqMUYtqq8BJ7JNDupZo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qmYGJlSoh7f0xBpo5W3+HkiMx/HVXZWbN4pUegNCqMEK11HYXZgDC7HVEmqmPsjr7
	 xyyg+bFpoSa6kk3bscIa7QVMDSVKydbvV6rnGr90w6Kt1G1YfkCVmrhlpsUReHZ9OZ
	 sSer5LjpQbfPzKKgIMCWbSnYqzenSWiCWRGMX8xQ=
Date: Wed, 31 May 2023 17:29:17 -0700
From: Beau Belgrave <beaub@linux.microsoft.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, ast@kernel.org,
	dcook@linux.microsoft.com, brauner@kernel.org,
	dthaler@microsoft.com, bpf@vger.kernel.org
Subject: Re: [PATCH 0/5] tracing/user_events: Add auto-del flag for events
Message-ID: <20230601002917.GA25634@W11-BEAU-MD.localdomain>
References: <20230530235304.2726-1-beaub@linux.microsoft.com>
 <20230531214444.5dqcbclgycfk3q77@MacBook-Pro-8.local>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531214444.5dqcbclgycfk3q77@MacBook-Pro-8.local>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 31, 2023 at 02:44:44PM -0700, Alexei Starovoitov wrote:
> On Tue, May 30, 2023 at 04:52:59PM -0700, Beau Belgrave wrote:
> > As part of the discussions for user_events aligning to be used with eBPF
> > it became clear [1] we needed a way to delete events without having to rely
> > upon the delete IOCTL. Steven suggested that we simply have an owner
> 
> This patch set is not addressing the issues I pointed out earlier.
> It adds a new flag and new api. It's not a fix.
> 

Can you point out the scenario you are worried about?

For example, if anything is using a per-FD event, it cannot be deleted,
it will return -EBUSY. If perf, ftrace, or any user-process still has a
reference to the event, the delete will not go through (even without
these changes).

I read your previous issues as, we cannot let anyone delete events while
others are using them. And I also heard Steven state, we need to not let
things pile up, since manual deletes are unlikely.

> > for the event, however, the event can be held by more than just the
> > first register FD, such as perf/ftrace or additional registers. In order
> > to handle all those cases, we must only delete after all references are
> > gone from both user and kernel space.
> > 
> > This series adds a new register flag, USER_EVENT_REG_AUTO_DEL, which
> > causes the event to delete itself upon the last put reference. We cannot
> 
> Do not introduce a new flag. Make this default.
> 

If this is to be default, then I would have to have a flag for
persistent events, which seems reasonable.

> > fully drop the delete IOCTL, since we still want to enable events to be
> > registered early via dynamic_events and persist. If the auto delete flag
> > was used during dynamic_events, the event would delete immediately.
> 
> You have to delete this broken "delete via ioctl" api.
> For persistent events you need a different api in its own name scope,
> so it doesn't conflict with per-fd events.
> 

We have certain events we want persistent, that don't go away if the
process crashes, etc. and we don't yet have a ring buffer up via
perf_events.

In these cases, we want the name to be the same for all processes, since
it's a common event. An example is a common library that emits out
assert messages. We want to watch for any asserts on the system,
regardless of which process emits them.

I'm not sure I understand how you think they would conflict?

Another process cannot come in and register the same event name while
it's in use. They can only do so once everything has been closed down.

If another process uses the same name for an event, it must match the
previous events arguments, and is treated as the same event. If they
don't match then the register fails. The only way to get a conflict is
to delete the event and then create a new one, but that only works if
no one is still using it at all.

Thanks,
-Beau

> > We have a few key events that we enable immediately after boot and are
> > monitored in our environments. Today this is done via dynamic events,
> > however, it could also be done directly via the ABI by not passing the
> > auto delete flag.
> >
> > NOTE: I'll need to merge this work once we take these [2] [3] patches
> > into for-next. I'm happy to do so once they land there.
> > 
> > 1: https://lore.kernel.org/linux-trace-kernel/20230518093600.3f119d68@rorschach.local.home/
> > 2: https://lore.kernel.org/linux-trace-kernel/20230529032100.286534-1-sunliming@kylinos.cn/
> > 3: https://lore.kernel.org/linux-trace-kernel/20230519230741.669-1-beaub@linux.microsoft.com/
> > 
> > Beau Belgrave (5):
> >   tracing/user_events: Store register flags on events
> >   tracing/user_events: Track refcount consistently via put/get
> >   tracing/user_events: Add flag to auto-delete events
> >   tracing/user_events: Add self-test for auto-del flag
> >   tracing/user_events: Add auto-del flag documentation
> > 
> >  Documentation/trace/user_events.rst           |  21 +-
> >  include/uapi/linux/user_events.h              |  10 +-
> >  kernel/trace/trace_events_user.c              | 183 ++++++++++++++----
> >  .../testing/selftests/user_events/abi_test.c  | 115 ++++++++++-
> >  4 files changed, 278 insertions(+), 51 deletions(-)
> > 
> > 
> > base-commit: 3862f86c1529fa0016de6344eb974877b4cd3838
> > -- 
> > 2.25.1
> > 

