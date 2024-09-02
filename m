Return-Path: <bpf+bounces-38696-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC1896813A
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 10:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A56C0281477
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 08:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE57417F4F2;
	Mon,  2 Sep 2024 08:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ealrXrQP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ARJT3Xlr"
X-Original-To: bpf@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33E4155739;
	Mon,  2 Sep 2024 08:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725264157; cv=none; b=M0UlGiKUF5XMnvx0lLpw8jxP3amQelgqfnHgBlEzWKsGATiasm7FVOhj9rxrSqBb5nME6Ud0BXvybHwWfwf4yibFsSGZ8ReqCT8Ip7FzrlsbnEGF9+ns+dYQSGXcjX7biP3CU38SlwjGPIZDZl/zzPSTuLRqnxVJ7tsoJU4FGLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725264157; c=relaxed/simple;
	bh=C9b/4f8IouEI8tV3Ua4AGgB2h5GR5GZG1FJD8tyI7Zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkRYzxMiOl2/Yjwzaq2PimIM0rNv1z8btuE732KbjHHLK3aizGI70ZCPLQg+VxhCX6v4wcX1qm1JZK6NgOulaOV5j7e3WE5fH5XHuMhDeoIDzrGMMbA5VM+sOQA1lByz9buifJrfMJftTuzhkBkfSKrprIdxNS6KRtdT19crj5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ealrXrQP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ARJT3Xlr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 2 Sep 2024 10:02:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725264153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QWvZIOhLORWof3jiLa850xZV6SIDdy3yFYNAHu46Bhg=;
	b=ealrXrQPiqd6PqR1a0taRQvV4xrN6y48md2kYA8fO40zz93SUbAmJJ/LEydmZ8nG/pmLNm
	A69Bo+e+MWdyxabGqcwrZNp0Co3qbwe8Cqj1DImPgVkaHKg7RsSaJrW14KHeCD4eiBjEXH
	ojaOwKikqHmAdkKPPYWA23TW9pR7e7e6YEB3/c6dqUmY7dUwOUPujig8Qbqte+97dpaGCZ
	CPTTyH9E1HO+QIZnx9mSc2UmBwZuRAFfOwh5lhOhfqCMJ0TpohwYn5Kr/SZvxkf1AFyhbx
	xniMkZ0NYIlz6DFZQnGorfywAo8TBx8LByMqsnvXoqXFw3MY3r26T1KnkOfFQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725264153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QWvZIOhLORWof3jiLa850xZV6SIDdy3yFYNAHu46Bhg=;
	b=ARJT3XlrKeAcaPioHwanooS814wM55eAUlrq7HicEyZ9VjcvfdBZGOOyFDlW+tqZjW8hwM
	N0a6/EoHBq4X4rBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: syzbot <syzbot+cca39e6e84a367a7e6f6@syzkaller.appspotmail.com>
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org,
	bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
	eddyz87@gmail.com, haoluo@google.com, hawk@kernel.org,
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
	kuba@kernel.org, linux-kernel@vger.kernel.org, martin.lau@linux.dev,
	michal.switala@infogain.com, netdev@vger.kernel.org,
	revest@google.com, sdf@fomichev.me, sdf@google.com, song@kernel.org,
	syzkaller-bugs@googlegroups.com, toke@redhat.com,
	yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] [net?] general protection fault in
 dev_map_enqueue (2)
Message-ID: <20240902080232.wnhtxiWK@linutronix.de>
References: <00000000000099cf25061964d113@google.com>
 <000000000000ebe92a062100eb94@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000000000000ebe92a062100eb94@google.com>

On 2024-08-31 13:55:02 [-0700], syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 401cb7dae8130fd34eb84648e02ab4c506df7d5e
> Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Date:   Thu Jun 20 13:22:04 2024 +0000
> 
>     net: Reference bpf_redirect_info via task_struct on PREEMPT_RT.
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12597c63980000
> start commit:   36534d3c5453 tcp: use signed arithmetic in tcp_rtx_probe0_..
> git tree:       bpf
> kernel config:  https://syzkaller.appspot.com/x/.config?x=333ebe38d43c42e2
> dashboard link: https://syzkaller.appspot.com/bug?extid=cca39e6e84a367a7e6f6
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13390aea980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10948741980000

This looks like ri->tgt_value is a NULL pointer (dst in
dev_map_enqueue()). The commit referenced by syz should not have fixed
that.
It is possible that there were leftovers in bpf_redirect_info (from a
previous invocation) which were memset(,0,) during the switch from
per-CPU to stack usage and now it does not trigger anymore. 

Sebastian

