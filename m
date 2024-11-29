Return-Path: <bpf+bounces-45861-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 644AF9DC093
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 09:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11AB9B22850
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 08:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8C51662F6;
	Fri, 29 Nov 2024 08:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="appCYFW/"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B9014B088;
	Fri, 29 Nov 2024 08:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732869360; cv=none; b=D0obNquZM/Rcs9PP+tTK9JKdoujByXaZtfuTUOgTMjP946n9/jGA9oXEPS2cRa4K8EduhMzIIEiPIvXJNTgEpgZcq+c0Xq1moHuEmoefyBBtUUUuuDpcEMfpL9zPcpczqZc+HIbo2m87AWL0ag3JOTbvh5NH0r60qFaCfkCFlPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732869360; c=relaxed/simple;
	bh=1AkRArlPvOhjQTdT/PiFCY7HmB/jjJr3KRQ785jqxDY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Vb1ZvJTIRHEKvFNGWZ8b93hthAaYtrurK/go66sy1ZTbboMYbGIAaPphSX/CLOZCE94mc0JNpPpC8/DGVLr+GWBXtGzq7WyiFirUIz6CZsUoObdly8C4RUCeUmbQgrRXyeQnpFYH72J7x7s+w2NchFV0z5ci4ZErJqETHxlKEEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=appCYFW/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56A0EC4CECF;
	Fri, 29 Nov 2024 08:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732869360;
	bh=1AkRArlPvOhjQTdT/PiFCY7HmB/jjJr3KRQ785jqxDY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=appCYFW/MTYNonIsbMs4g1oEJraLYsnwNPejObwAgyFECUb4kvnYv1ryonkHx6x3v
	 B/DIA5w5f3AEAY14UgCKShlvfOYn5+jr8BwecuEvOv+G0+Tbd++tedBlrfqTff/PSX
	 njqegRn5Z36RVrfHWPvNmJ5cLBVq7mSIDboFgmqP09wcSGNCBNvtWj7KzRXfqb3SIx
	 T6oaIQZhxtyeIzzGvKCgs/a3/MltaXvD7DiJ68fFJc9tBpi27FUO5uAlT56UbAZBq8
	 qY5auJ/ploEXyLpQgYuMrMVZDV3ewtdQYd52QGkOcPvPuxqC//ZHlZFSzNnJKpHIr2
	 YwbyzjuW8JW6Q==
Date: Fri, 29 Nov 2024 17:35:54 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Ruan Bonan <bonan.ruan@u.nus.edu>
Cc: "peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com"
 <mingo@redhat.com>, "will@kernel.org" <will@kernel.org>,
 "longman@redhat.com" <longman@redhat.com>, "boqun.feng@gmail.com"
 <boqun.feng@gmail.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "kpsingh@kernel.org" <kpsingh@kernel.org>,
 "mattbobrowski@google.com" <mattbobrowski@google.com>, "ast@kernel.org"
 <ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "andrii@kernel.org" <andrii@kernel.org>, "martin.lau@linux.dev"
 <martin.lau@linux.dev>, "eddyz87@gmail.com" <eddyz87@gmail.com>,
 "song@kernel.org" <song@kernel.org>, "yonghong.song@linux.dev"
 <yonghong.song@linux.dev>, "john.fastabend@gmail.com"
 <john.fastabend@gmail.com>, "sdf@fomichev.me" <sdf@fomichev.me>,
 "haoluo@google.com" <haoluo@google.com>, "jolsa@kernel.org"
 <jolsa@kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
 "mathieu.desnoyers@efficios.com" <mathieu.desnoyers@efficios.com>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Fu Yeqi
 <e1374359@u.nus.edu>
Subject: Re: [BUG] possible deadlock in __schedule (with reproducer
 available)
Message-Id: <20241129173554.11e3b2b2f5126c2b72c6a78e@kernel.org>
In-Reply-To: <24481522-69BF-4CE7-A05D-1E7398400D80@u.nus.edu>
References: <24481522-69BF-4CE7-A05D-1E7398400D80@u.nus.edu>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 23 Nov 2024 03:39:45 +0000
Ruan Bonan <bonan.ruan@u.nus.edu> wrote:

> 
>        vprintk_emit+0x414/0xb90 kernel/printk/printk.c:2406
>        _printk+0x7a/0xa0 kernel/printk/printk.c:2432
>        fail_dump lib/fault-inject.c:46 [inline]
>        should_fail_ex+0x3be/0x570 lib/fault-inject.c:154
>        strncpy_from_user+0x36/0x230 lib/strncpy_from_user.c:118
>        strncpy_from_user_nofault+0x71/0x140 mm/maccess.c:186
>        bpf_probe_read_user_str_common kernel/trace/bpf_trace.c:215 [inline]
>        ____bpf_probe_read_user_str kernel/trace/bpf_trace.c:224 [inline]

Hmm, this is a combination issue of BPF and fault injection.

static void fail_dump(struct fault_attr *attr)
{
        if (attr->verbose > 0 && __ratelimit(&attr->ratelimit_state)) {
                printk(KERN_NOTICE "FAULT_INJECTION: forcing a failure.\n"
                       "name %pd, interval %lu, probability %lu, "
                       "space %d, times %d\n", attr->dname,
                       attr->interval, attr->probability,
                       atomic_read(&attr->space),
                       atomic_read(&attr->times));

This printk() acquires console lock under rq->lock has been acquired.

This can happen if we use fault injection and trace event too because
the fault injection caused printk warning.
I think this should be a bug of the fault injection, not tracing/BPF.
And to solve this issue, we may be able to check the context and if
it is tracing/NMI etc, fault injection should NOT make it failure.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

