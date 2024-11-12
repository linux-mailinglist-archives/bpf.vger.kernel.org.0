Return-Path: <bpf+bounces-44578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D6B9C4C89
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 03:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07CC628C07B
	for <lists+bpf@lfdr.de>; Tue, 12 Nov 2024 02:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743FF1F7092;
	Tue, 12 Nov 2024 02:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bfYxQyaM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SQBfM083"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2184AF50F;
	Tue, 12 Nov 2024 02:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731378285; cv=none; b=u4KumY8geQF+BoZAmFlywiRBp85OwaU933qu5yfj24n8UJbjoUnhls8xFBmPJWNg3GIzj+dUJlGyIyQs/4zXo2fvNdXj2HWKfpzQwRIIs2DROmPA84huNCB1b5q74/30pXew4ohc7g2iaFz8Lmbd6nARQwkaorE0ta84nP4Af6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731378285; c=relaxed/simple;
	bh=KVKMXh4FE95DmyLC3d/lW+4dH0pIFisXMVeS2B6sp6E=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ko5+RCVNs6/qdFO4VPh0NzOzXqtoSUDoszLo/6ZeylTttR/4OGAUTg5jebBytKKt6bJEiB1btP/ML4DY7Uryl5KdIVZ4kEgkY0yEOWtT9csadlil9fe+x/Ol4ZWju1gdYLavw/UjpeBSBY8PeMrHzKRc4r6DepFof2XdJZKUllU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bfYxQyaM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SQBfM083; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731378280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7IraCr5pUZE8N7jYvVRfjYhiLHWwDnE2AZVmguY66tw=;
	b=bfYxQyaM6xtTIVfxxTpdJFe9HDFvDRvPhkyFDPZflCDx7MdxsmNvawiJI1msTlQqeU7O9G
	8MpkCBWHQ5hs1ywP1Odxao/x1ckYg10k7wzhzjZdFvJm5BDbGtwNReokD3py5xuXIoNYqW
	HjUMOCiMK6X5G5bqylNV/wk7v6ZG9/PmGqu241VYHFkObn0P3Fp1+XT9zjoT98W5oCAEAi
	cq1NLXDfdEM5OBCDpMJTtVMfOGwkf5NwoL8i2EtDLbdKHABuOODBCksl00PCedytj0ZV2N
	imXkfg3hCIzvxdkss+3Ysr4nYhdwC/jcEg+72tlco3Boa8rDoF+tlo26wOeYuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731378280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7IraCr5pUZE8N7jYvVRfjYhiLHWwDnE2AZVmguY66tw=;
	b=SQBfM083NBEYl8ahu8d9nwOH3//abzVN6ZdXA85A4oHHoFJzfSUIRLNYEr+NKKy+xPDumQ
	2iCqn6wLJHMLuQDA==
To: syzbot <syzbot+b506de56cbbb63148c33@syzkaller.appspotmail.com>,
 andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, frederic@kernel.org,
 haoluo@google.com, houtao@huaweicloud.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, peterz@infradead.org, sdf@fomichev.me,
 song@kernel.org, syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] WARNING: locking bug in trie_delete_elem
In-Reply-To: <672d2a52.050a0220.15a23d.01a1.GAE@google.com>
References: <672d2a52.050a0220.15a23d.01a1.GAE@google.com>
Date: Tue, 12 Nov 2024 03:24:44 +0100
Message-ID: <87bjylnq8j.ffs@tglx>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Nov 07 2024 at 13:00, syzbot wrote:
> syzbot has bisected this issue to:
>
> commit 4febce44cfebcb490b196d5d10ae9f403ca4c956
> Author: Thomas Gleixner <tglx@linutronix.de>
> Date:   Tue Oct 1 08:42:03 2024 +0000
>
>     posix-timers: Cure si_sys_private race
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=129f2d87980000
> start commit:   f9f24ca362a4 Add linux-next specific files for 20241031
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=169f2d87980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=328572ed4d152be9
> dashboard link: https://syzkaller.appspot.com/bug?extid=b506de56cbbb63148c33
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1387655f980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ac5540580000
>
> Reported-by: syzbot+b506de56cbbb63148c33@syzkaller.appspotmail.com
> Fixes: 4febce44cfeb ("posix-timers: Cure si_sys_private race")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

I seriously doubt that this bisection is even remotely correct.

This commit has absolutely nothing to do with the lockdep splat and
trie_delete_elem().

Thanks,

        tglx

