Return-Path: <bpf+bounces-6286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A8C767928
	for <lists+bpf@lfdr.de>; Sat, 29 Jul 2023 01:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 313742827D0
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 23:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A565320FBA;
	Fri, 28 Jul 2023 23:52:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB1F525C
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 23:52:28 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C579422B
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 16:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690588346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BY29vbVRSLrx1jOwy2KzcUw26TLcuFDuJxFn8li9iP8=;
	b=I5TVp4Z4fyIxi0ElQdQXx8CM2+C8vKKQCb3oL5hpxCFWT5iibygkVfGRqwGYRqapuaxIRA
	1zY8BAViCDxW379lKgzcWVBv/tZs0/PEewyodULj9Pdmp44SvutgGw14A23iziO6lfcHtI
	rEOrJnvINtCyUBAvjruUVkItYGuHQPM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-344-QF0H11mpOgSewz_eLPmuog-1; Fri, 28 Jul 2023 19:52:22 -0400
X-MC-Unique: QF0H11mpOgSewz_eLPmuog-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B356185A78B;
	Fri, 28 Jul 2023 23:52:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.131])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A857F400F36;
	Fri, 28 Jul 2023 23:52:20 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20230718160737.52c68c73@kernel.org>
References: <20230718160737.52c68c73@kernel.org> <000000000000881d0606004541d1@google.com> <0000000000001416bb06004ebf53@google.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: dhowells@redhat.com,
    syzbot <syzbot+f527b971b4bdc8e79f9e@syzkaller.appspotmail.com>,
    bpf@vger.kernel.org, brauner@kernel.org, davem@davemloft.net,
    dsahern@kernel.org, edumazet@google.com,
    linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
    netdev@vger.kernel.org, pabeni@redhat.com,
    syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [fs?] INFO: task hung in pipe_release (4)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <550502.1690588340.1@warthog.procyon.org.uk>
Date: Sat, 29 Jul 2023 00:52:20 +0100
Message-ID: <550503.1690588340@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Jakub Kicinski <kuba@kernel.org> wrote:

> Hi David, any ideas about this one? Looks like it triggers on fairly
> recent upstream?

I've managed to reproduce it finally.  Instrumenting the pipe_lock/unlock
functions, splice_to_socket() and pipe_release() seems to show that
pipe_release() is being called whilst splice_to_socket() is still running.

I *think* syzbot is arranging things such that splice_to_socket() takes a
significant amount of time so that another thread can close the socket as it
exits.

In this sample logging, the pipe is created by pid 7101:

[   66.205719] --pipe 7101
[   66.209942] lock
[   66.212526] locked
[   66.215344] unlock
[   66.218103] unlocked

splice begins in 7101 also and locks the pipe:

[   66.221057] ==>splice_to_socket() 7101
[   66.225596] lock
[   66.228177] locked

but for some reason, pid 7100 then tries to release it:

[   66.377781] release 7100

and hangs on the __pipe_lock() call in pipe_release():

[   66.381059] lock

The syz reproducer does weird things with threading - and I'm wondering if
there's a file struct refcount bug here.  Note that splice_to_socket() can't
access the pipe file structs to alter the refcount, and the involved pipe
isn't communicated to udp_sendmsg() in any way - so if there is a refcount
bug, it must be somewhere in the VFS, the pipe driver or the splice
infrastructure:-/.

I'm also not sure what's going on inside udp_sendmsg() as yet.  It doesn't
show a stack in /proc/7101/stacks, which means it doesn't hit a schedule().

David


