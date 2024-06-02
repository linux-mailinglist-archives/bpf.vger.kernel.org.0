Return-Path: <bpf+bounces-31109-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 893E08D7335
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 05:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1EC71C20C4F
	for <lists+bpf@lfdr.de>; Sun,  2 Jun 2024 03:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FD28C04;
	Sun,  2 Jun 2024 03:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRMkliUx"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770578BF3;
	Sun,  2 Jun 2024 03:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717297794; cv=none; b=RPfhaEAPlWi0rRf7dyzqfSj5zbaJ5u48TrEdTMY+F/aNhUt8OH8iqoAWUG+JmB7fBtTCXMfAevcuvS9yssXB5ptqLm0ktAEaE10h8IVDhqJCfRTcUkdjka1y6YkcqwUDFhjdOjrUhEZrmvfWk9uI0ZRGlq19uefT8Dh6UabhPiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717297794; c=relaxed/simple;
	bh=mxKHFv4b0GpvtdP6ln5iryWXR3VuD8H8Rh5UyDDSVWQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mdKxp7hr1HBluD3WWoGoCxDxHxMTOgjOCoaJDpOnXLO8efgcz0z2SA9q9GFuTHXYvql0EEBURwThVS5K3XHYTcpaDv1htg4YKZrz9/pwH2RHZ4IjzsM12G+XKfrNXbqUHtOHdfzRgqffpk4lg/b43yRLL4j8AcMUj2wQuUTOV08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRMkliUx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C58EC3277B;
	Sun,  2 Jun 2024 03:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717297794;
	bh=mxKHFv4b0GpvtdP6ln5iryWXR3VuD8H8Rh5UyDDSVWQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QRMkliUxoT2FNriuvjGQ2nm0MZSVY7Z9ZR9LUhy+haKlUOpl2Vxu4nErbAuUZKCq+
	 dL7X+XVZOVH0T33b+1Ba1aesvMtb81r3MMj+shFRdUYz9bgWDjRVA+GvPAvqx2TUDa
	 VgyWqhV+18C/KmGCi1MJe41B76zLqcTVzrPikbr9Q52VpnBBNj8UxRyUjDUuL7611q
	 I9Sbre88fye0ZgIs2Eu6JT1FGZtOxkgYWE1jdjHZ9fWJTCXj3tA2AxnPcPNDySrrYD
	 GJL2p6d+NM7UnnXGCdjEVci+QMAaVrknXSVHmpJXDEmuAL7D6/0KyQlZTlIgkc644Y
	 0mSM49r3kA04Q==
Date: Sun, 2 Jun 2024 12:09:50 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: syzbot <syzbot+list0820d438c1905c75bc71@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, bpf@vger.kernel.org
Subject: Re: [syzbot] Monthly trace report (May 2024)
Message-Id: <20240602120950.8f08ef16ad9c485db374c08d@kernel.org>
In-Reply-To: <00000000000061fac40619ba66f6@google.com>
References: <00000000000061fac40619ba66f6@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 May 2024 23:50:32 -0700
syzbot <syzbot+list0820d438c1905c75bc71@syzkaller.appspotmail.com> wrote:

> Hello trace maintainers/developers,
> 
> This is a 31-day syzbot report for the trace subsystem.
> All related reports/information can be found at:
> https://syzkaller.appspot.com/upstream/s/trace
> 
> During the period, 1 new issues were detected and 0 were fixed.
> In total, 10 issues are still open and 35 have been fixed so far.
> 
> Some of the still happening issues:
> 
> Ref Crashes Repro Title
> <1> 705     Yes   WARNING in format_decode (3)
>                   https://syzkaller.appspot.com/bug?extid=e2c932aec5c8a6e1d31c

Could you send this to bpf folks? It seems bpf_trace_printk caused this errror.
(Maybe skipping fmt string check?)

> <2> 26      Yes   INFO: task hung in blk_trace_ioctl (4)
>                   https://syzkaller.appspot.com/bug?extid=ed812ed461471ab17a0c

This looks like debugfs_mutex lock leakage. Need to rerun with lockdep.

> <3> 7       Yes   WARNING in get_probe_ref
>                   https://syzkaller.appspot.com/bug?extid=8672dcb9d10011c0a160

Hm, fail on register_trace_block_rq_insert(). blktrace issue.

> <4> 6       Yes   INFO: task hung in blk_trace_remove (2)
>                   https://syzkaller.appspot.com/bug?extid=2373f6be3e6de4f92562

This looks like debugfs_mutex lock leakage too.

> <5> 5       Yes   general protection fault in bpf_get_attach_cookie_tracing
>                   https://syzkaller.appspot.com/bug?extid=3ab78ff125b7979e45f9

This is also BPF problem.

Thank you,

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


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

