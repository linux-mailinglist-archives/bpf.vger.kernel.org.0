Return-Path: <bpf+bounces-13705-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5A67DCCCB
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 13:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 175301C20C8A
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 12:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A0C1DA56;
	Tue, 31 Oct 2023 12:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lVD+F/+j"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C86B19BAD;
	Tue, 31 Oct 2023 12:17:08 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECA683;
	Tue, 31 Oct 2023 05:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=SqMSxHP9NBsij9leMlDv6zOZJhbmGz4JhFuyMu2sLfc=; b=lVD+F/+jCVWzaiJh61TNZhccqr
	JN9q6/f4nkgbfr2OmcqTo0WTdBcQMZYQVstPXZAQUYnUiuZR+vmxzTT6YRrJtBnlRIpE1MOSjuImC
	1NUBDnKpycS3AvBRTpKKSaiHIFJ+aeru1x2xlD3yroDV0xKjx5BdDm2khQKipedRIwuPvKjHNUHq1
	9XrnBbj3MkMJhQ/Z4hzUJG5GHPKm0MPwc3aHFKpHJUYLTDk7aUgzz5Dkv6YrUVWk+qi5Je1pEmBEk
	+GRQtEW95Z327/HRmgiVtJPWZ6QOwH3VodGk9OxKLQNQTNmRnC9pAIa7P+eHawcbcquf1slHPPbht
	6zfYDY4Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qxnfv-004oWX-1K;
	Tue, 31 Oct 2023 12:16:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 14FCB300473; Tue, 31 Oct 2023 13:16:51 +0100 (CET)
Date: Tue, 31 Oct 2023 13:16:51 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: syzbot <syzbot+756fe9affda890e892ae@syzkaller.appspotmail.com>
Cc: acme@kernel.org, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, bpf@vger.kernel.org,
	irogers@google.com, jolsa@kernel.org, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
	mingo@redhat.com, namhyung@kernel.org, netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [perf?] general protection fault in inherit_task_group
Message-ID: <20231031121651.GD35651@noisy.programming.kicks-ass.net>
References: <000000000000d9483d060901f460@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000d9483d060901f460@google.com>

On Tue, Oct 31, 2023 at 05:04:27AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    c17cda15cc86 Merge tag 'net-6.6-rc8' of git://git.kernel.o..
> git tree:       bpf
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=151ab177680000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7d1f30869bb78ec6
> dashboard link: https://syzkaller.appspot.com/bug?extid=756fe9affda890e892ae
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=103b572b680000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=143a82c3680000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/d47cb341912c/disk-c17cda15.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/f37f0cf41858/vmlinux-c17cda15.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/e256afecf3c3/bzImage-c17cda15.xz
> 
> The issue was bisected to:
> 
> commit 32671e3799ca2e4590773fd0e63aaa4229e50c06
> Author: Peter Zijlstra <peterz@infradead.org>
> Date:   Wed Oct 18 11:56:54 2023 +0000
> 
>     perf: Disallow mis-matched inherited group reads
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10fdf71d680000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=12fdf71d680000
> console output: https://syzkaller.appspot.com/x/log.txt?x=14fdf71d680000

a71ef31485bb51b846e8db8b3a35e432cc15afb5 upstream

