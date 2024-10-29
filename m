Return-Path: <bpf+bounces-43371-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0729B4253
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 07:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C5A61C21838
	for <lists+bpf@lfdr.de>; Tue, 29 Oct 2024 06:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7038201030;
	Tue, 29 Oct 2024 06:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SpQYwOv6"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20909200B86
	for <bpf@vger.kernel.org>; Tue, 29 Oct 2024 06:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730182737; cv=none; b=s30ngWZzvTR37bGV/1RQD+aO3dOj0MVzQVWAOep8qjR0i92jei6i/KveuSqRT+SClAfHAN9IDaTMUnqN/DgjtvCKAwhrtF+eoZlTK9N1+L4hUrTrBJCeBIGJKiWPTRrK1FyB37FlXee1vFafBCbImiEctnGmazWU/wN4/Zv0zME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730182737; c=relaxed/simple;
	bh=+znrgeC+Hx9w0V6oO4OK3aGNa3UOUwG5EIw8cnG2iuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RhUin6HTUkwbaUWY80n9EvDQzBv1mOyuGYOP7NAa79DSkgYjrBphWqJrttHldP+u8Lz6agg5p/g5uHxLQ1xAPYdbnYCGV1doAEfPRi3eySRw0N/qHQn8L1vkbZMyN1nRTYk1Je/hAL0/YBNZLtHKLC+ut4llyRq5Ksw8Ovci6t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SpQYwOv6; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f4c533a8-0d5e-476a-96cb-e76b67a4d62c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730182732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JFlCvSQTPNeR40cEr2m/ROAIMIdtyk2h8qE5ubbMsl0=;
	b=SpQYwOv6fkvk2Ed4mat1VDceZz/55sgLxzAz0WPV6qcJskeWEPd9JJVaqKiIovRGGZvS19
	jf9n+BagfairG2hGhEcJzOiOwGap7kCAvQ8CCPf2lkkuExskkGXNA7Sp2+kDDegOk6FNuj
	HRp2EXoNKU1wqikWegNv1pnsfvCZfDo=
Date: Mon, 28 Oct 2024 23:18:40 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2 1/2] bpf: fix %p% runtime check in
 bpf_bprintf_prepare
Content-Language: en-GB
To: Ilya Shchipletsov <rabbelkin@mail.ru>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Florent Revest <revest@chromium.org>,
 Nikita Marushkin <hfggklm@gmail.com>, lvc-project@linuxtesting.org,
 linux-kernel@vger.kernel.org
References: <20241028195343.2104-1-rabbelkin@mail.ru>
 <20241028195343.2104-2-rabbelkin@mail.ru>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20241028195343.2104-2-rabbelkin@mail.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 10/28/24 12:53 PM, Ilya Shchipletsov wrote:
> Fuzzing reports a warning in format_decode()
>
> Please remove unsupported %� in format string
> WARNING: CPU: 0 PID: 5091 at lib/vsprintf.c:2680 format_decode+0x1193/0x1bb0 lib/vsprintf.c:2680
> Modules linked in:
> CPU: 0 PID: 5091 Comm: syz-executor879 Not tainted 6.10.0-rc1-syzkaller-00021-ge0cce98fe279 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
> RIP: 0010:format_decode+0x1193/0x1bb0 lib/vsprintf.c:2680
> Call Trace:
>   <TASK>
>   bstr_printf+0x137/0x1210 lib/vsprintf.c:3253
>   ____bpf_trace_printk kernel/trace/bpf_trace.c:390 [inline]
>   bpf_trace_printk+0x1a1/0x230 kernel/trace/bpf_trace.c:375
>   bpf_prog_21da1b68f62e1237+0x36/0x41
>   bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
>   __bpf_prog_run include/linux/filter.h:691 [inline]
>   bpf_prog_run include/linux/filter.h:698 [inline]
>   bpf_test_run+0x40b/0x910 net/bpf/test_run.c:425
>   bpf_prog_test_run_skb+0xafa/0x13a0 net/bpf/test_run.c:1066
>   bpf_prog_test_run+0x33c/0x3b0 kernel/bpf/syscall.c:4291
>   __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5705
>   __do_sys_bpf kernel/bpf/syscall.c:5794 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:5792 [inline]
>   __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5792
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> The problem occurs when trying to pass %p% at the end of format string,
> which would result in skipping last % and passing invalid format string
> down to format_decode() that would cause warning because of invalid
> character after %.
>
> Fix issue by advancing pointer only if next char is format modifier.
> If next char is null/space/punct, then just accept formatting as is,
> without advancing the pointer.
>
> Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
>
> Reported-by: syzbot+e2c932aec5c8a6e1d31c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=e2c932aec5c8a6e1d31c
> Fixes: 48cac3f4a96d ("bpf: Implement formatted output helpers with bstr_printf")
> Co-developed-by: Nikita Marushkin <hfggklm@gmail.com>
> Signed-off-by: Nikita Marushkin <hfggklm@gmail.com>
> Signed-off-by: Ilya Shchipletsov <rabbelkin@mail.ru>

Acked-by: Yonghong Song <yonghong.song@linux.dev>


