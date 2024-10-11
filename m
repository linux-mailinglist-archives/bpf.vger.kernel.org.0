Return-Path: <bpf+bounces-41753-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1CF99A887
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 18:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 538B21F25697
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 16:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7E5198A3F;
	Fri, 11 Oct 2024 16:00:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69BD8002A;
	Fri, 11 Oct 2024 16:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728662420; cv=none; b=TRKR8yUcjhyrAfKisC0Kj7Vxk4ktOjvgvYoF3QyUjVZf1FAje0g7NLlNHLIDwVPMn7oRXWR5l8J595ToRoUE12AMcoSCTeJk5jwLGzf65JUwVbZ2DuwmfIbvXu9OHcDScuzHpO+JD4LI1UqStrSpA0VGTEcSPqRmuPFq+kd4QAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728662420; c=relaxed/simple;
	bh=+Z0USPv7t42JmSxqVwA+aZ0L2/6J/9w7Iymbl0jaVtc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kFdAVd6N2E6hoNsKe5UkZzmV11t38B7OCWRYiXGeWVxHWK9GvhAT80FlVaJk+y+Iks6QqcoXKf0Wd/RboL32hyx6010C6HCxNVOoPB0JDfsrHA0F6Wr/QkD6Oms9IQSoBQM/M9EeFsaXlyeBVIzlKwN0yMJeaA9u/y9dE3LWRVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE51FC4CEC3;
	Fri, 11 Oct 2024 16:00:18 +0000 (UTC)
Date: Fri, 11 Oct 2024 12:00:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: syzbot <syzbot+list3bf21e6ac0139f8d008d@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mhiramat@kernel.org, syzkaller-bugs@googlegroups.com, Jens Axboe
 <axboe@kernel.dk>, linux-block@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [syzbot] Monthly trace report (Oct 2024)
Message-ID: <20241011120028.1e4ed71c@gandalf.local.home>
In-Reply-To: <67094369.050a0220.4cbc0.000d.GAE@google.com>
References: <67094369.050a0220.4cbc0.000d.GAE@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Oct 2024 08:25:29 -0700
syzbot <syzbot+list3bf21e6ac0139f8d008d@syzkaller.appspotmail.com> wrote:

> Hello trace maintainers/developers,
> 
> This is a 31-day syzbot report for the trace subsystem.
> All related reports/information can be found at:
> https://syzkaller.appspot.com/upstream/s/trace
> 
> During the period, 1 new issues were detected and 0 were fixed.
> In total, 10 issues are still open and 38 have been fixed so far.
> 
> Some of the still happening issues:
> 
> Ref Crashes Repro Title
> <1> 34      Yes   INFO: task hung in blk_trace_ioctl (4)
>                   https://syzkaller.appspot.com/bug?extid=ed812ed461471ab17a0c

If you check the maintainers file, blktrace.c has:

BLOCK LAYER
M:      Jens Axboe <axboe@kernel.dk>
L:      linux-block@vger.kernel.org



> <2> 32      Yes   WARNING in bpf_get_stack_raw_tp
>                   https://syzkaller.appspot.com/bug?extid=ce35de20ed6652f60652

bpf_trace.c has:

M:      Alexei Starovoitov <ast@kernel.org>
M:      Daniel Borkmann <daniel@iogearbox.net>
M:      Andrii Nakryiko <andrii@kernel.org>
R:      Martin KaFai Lau <martin.lau@linux.dev>
R:      Eduard Zingerman <eddyz87@gmail.com>
R:      Song Liu <song@kernel.org>
R:      Yonghong Song <yonghong.song@linux.dev>
R:      John Fastabend <john.fastabend@gmail.com>
R:      KP Singh <kpsingh@kernel.org>
R:      Stanislav Fomichev <sdf@fomichev.me>
R:      Hao Luo <haoluo@google.com>
R:      Jiri Olsa <jolsa@kernel.org>
L:      bpf@vger.kernel.org

> <3> 13      Yes   WARNING in get_probe_ref
>                   https://syzkaller.appspot.com/bug?extid=8672dcb9d10011c0a160
> <4> 6       Yes   INFO: task hung in blk_trace_remove (2)
>                   https://syzkaller.appspot.com/bug?extid=2373f6be3e6de4f92562
> <5> 4       Yes   possible deadlock in __mod_timer (4)
>                   https://syzkaller.appspot.com/bug?extid=83a876aef81c9a485ae8

None of these look like they are tracing infrastructure related.

-- Steve


> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> To disable reminders for individual bugs, reply with the following command:
> #syz set <Ref> no-reminders
> 
> To change bug's subsystems, reply with:
> #syz set <Ref> subsystems: new-subsystem
> 
> You may send multiple commands in a single email message.


