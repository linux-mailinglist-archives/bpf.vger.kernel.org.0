Return-Path: <bpf+bounces-45814-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D519DB248
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 05:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75683282B1F
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 04:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E5E13B58E;
	Thu, 28 Nov 2024 04:49:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail78-36.sinamail.sina.com.cn (mail78-36.sinamail.sina.com.cn [219.142.78.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBD1360
	for <bpf@vger.kernel.org>; Thu, 28 Nov 2024 04:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732769342; cv=none; b=ZF1hfFSYKdUszRRWJOt0F5kk/o6ve1hVDHlCA/mftesnZTTqhYsyg/++OUyhk9aUF+HWXQzczPSF/JNDUR8aGlZ+3tE98/xfQVvu5dpvA8XQzYruIoyK++cdROm0iSSqt5a8fwptmDhzKpcIgsUuNRJq0FUAbMaDINrqvSlfcGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732769342; c=relaxed/simple;
	bh=lYovyC6bUDmK5k8H62++FJhBXcWWLQTq/0mw0zvZCDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M5cFOKl7klVpbfyyBEOFruEK6li2gEaQDg3KHv/8nhFnJQxlc6//ZkUXxiCBh/z5ZpCJ7gOyaFzW6OwbsJJB94dvfTo8zJq7l6rOGM/HW55vJAucuJRMa+VWVxOdnbjIwCSDXkdoV/CIl0x11/IfSwdETsElWYqflFQL3QxLUN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.9.49])
	by sina.com (10.185.250.24) with ESMTP
	id 6747F62800003F5D; Thu, 28 Nov 2024 12:48:45 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 67710610748452
X-SMAIL-UIID: 43821B7CE5254581A666726971154BD0-20241128-124845-1
From: Hillf Danton <hdanton@sina.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ruan Bonan <bonan.ruan@u.nus.edu>,
	Steven Rostedt <rostedt@goodmis.org>,
	LKML <linux-kernel@vger.kernel.org>,
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
	Aleksandr Nogikh <nogikh@google.com>,
	BPF <bpf@vger.kernel.org>
Subject: Re: [BUG] possible deadlock in __schedule (with reproducer available)
Date: Thu, 28 Nov 2024 12:48:31 +0800
Message-Id: <20241128044831.1672-1-hdanton@sina.com>
In-Reply-To: <CAADnVQJ+eoczS6JK7aUZSWzUFggEyXW+w4oMiB4iY4F9FpMVRA@mail.gmail.com>
References: <CAEf4BzYHeh_=iHOYL88pXXdHGZuAmQNM0jM+9iPUou+7+YLjjQ@mail.gmail.com> <20241127230349.1619-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 27 Nov 2024 18:27:57 -0800 Alexei Starovoitov <alexei.starovoitov@gmail.com>
> On Wed, Nov 27, 2024 at 3:04 PM Hillf Danton <hdanton@sina.com> wrote:
> > On Tue, 26 Nov 2024 13:15:48 -0800 Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > > On Mon, Nov 25, 2024 at 1:44 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > > On Mon, Nov 25, 2024 at 05:24:05AM +0000, Ruan Bonan wrote:
> > > >
> > > > > From the discussion, it appears that the root cause might involve
> > > > > specific printk or BPF operations in the given context. To clarify and
> > > > > possibly avoid similar issues in the future, are there guidelines or
> > > > > best practices for writing BPF programs/hooks that interact with
> > > > > tracepoints, especially those related to scheduler events, to prevent
> > > > > such deadlocks?
> > > >
> > > > The general guideline and recommendation for all tracepoints is to be
> > > > wait-free. Typically all tracer code should be.
> > > >
> > > > Now, BPF (users) (ab)uses tracepoints to do all sorts and takes certain
> > > > liberties with them, but it is very much at the discretion of the BPF
> > > > user.
> > >
> > > We do assume that tracepoints are just like kprobes and can run in
> > > NMI. And in this case BPF is just a vehicle to trigger a
> > > promised-to-be-wait-free strncpy_from_user_nofault(). That's as far as
> > > BPF involvement goes, we should stop discussing BPF in this context,
> > > it's misleading.
> > >
> > Given known issue, syzbot should run without bpf enabled before it is fixed
> > to avoid more useless discussing and misleading.
> 
> If you cared to read the thread it would have been obvious
> that printk is the culprit. Tell syzbot to run without printk?
>
Printk is innocent, and it makes no sense to put the gun vendor into
jail simply because bpf shoot a sheriff in the cafeteira.

