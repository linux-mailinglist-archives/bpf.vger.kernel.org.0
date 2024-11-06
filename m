Return-Path: <bpf+bounces-44114-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 042A49BE138
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 09:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84D70B24DCF
	for <lists+bpf@lfdr.de>; Wed,  6 Nov 2024 08:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751E41D54F2;
	Wed,  6 Nov 2024 08:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="OMonIA7i"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C6F199243;
	Wed,  6 Nov 2024 08:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730882545; cv=none; b=IySYGs4E2Qo31Gole/d/b1AIDmikLPCSdx8hPCYDwzf22iwX+plGov0Sxn1yCBpY4pDZxpPLe6xD1lfnTYgHU7oWprpRMkfdye6zkjdqyvFfPNlG67OgYkYOWW99sT4YzEVpkdEA62x7qMm8L8IaTlGQGKHrQTIotvxZkIDJU/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730882545; c=relaxed/simple;
	bh=Jte0gfLZsslumFo3T7tW236NNEQ+MdUH9kSgX4TgCfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ca+KL7EiptursFKW3qFeVW1NH9da2UtyblcjSfTt8g/WN1sxXLZscfqQBCsceeHULwDTHPSXAev5KsPd3u6fC7vqUHH2eMrg78ttg+npSHWgdWRIELkUi/zFYMV6HJ1O8GdjKvoG1AZy9hL9tjjssPU/gDu1OKXkB5eCAZrDsbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=OMonIA7i; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fedor-21d0 (unknown [5.228.116.177])
	by mail.ispras.ru (Postfix) with ESMTPSA id 465E14076182;
	Wed,  6 Nov 2024 08:42:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 465E14076182
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1730882532;
	bh=lVX427mKZLJm8d+EqoMyWKoFhrPazyuzoZYzNO11s0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OMonIA7iS8PTafh7Y1trunda3UMge5bviOnqaE7U1GrSy43kQCFbCmCe246O96Wjc
	 zFlKya2Mb9KZvzXGdZL1ZJc44o59vUDsdqPX3iO6UoH9FFMoakq1n60Dor9KsJ786L
	 z8ic+L3jl4kxholcIY2zjoblhK8dr9frVz5im9xY=
Date: Wed, 6 Nov 2024 11:42:06 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Florent Revest <revest@chromium.org>, bpf@vger.kernel.org
Cc: Yonghong Song <yonghong.song@linux.dev>, Hao Luo <haoluo@google.com>, 
	lvc-project@linuxtesting.org, Daniel Borkmann <daniel@iogearbox.net>, 
	Song Liu <song@kernel.org>, Ilya Shchipletsov <rabbelkin@mail.ru>, 
	John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Nikita Marushkin <hfggklm@gmail.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf v2 1/2] bpf: fix %p% runtime check in
 bpf_bprintf_prepare
Message-ID: <20241106-3cf34ee84cd6c77a84785574-pchelkin@ispras.ru>
References: <20241028195343.2104-1-rabbelkin@mail.ru>
 <20241028195343.2104-2-rabbelkin@mail.ru>
 <f4c533a8-0d5e-476a-96cb-e76b67a4d62c@linux.dev>
 <CABRcYm+fR0qRk1FS8edB0zNFtg+GXt3vp025HU4eq-vCR52rRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABRcYm+fR0qRk1FS8edB0zNFtg+GXt3vp025HU4eq-vCR52rRg@mail.gmail.com>

On Thu, 31. Oct 17:17, Florent Revest wrote:
> Acked-by: Florent Revest <revest@chromium.org>
> 
> On Tue, Oct 29, 2024 at 7:18 AM Yonghong Song <yonghong.song@linux.dev> wrote:
> > On 10/28/24 12:53 PM, Ilya Shchipletsov wrote:
> > > Fuzzing reports a warning in format_decode()
> > >
> > > Please remove unsupported %� in format string
> > > WARNING: CPU: 0 PID: 5091 at lib/vsprintf.c:2680 format_decode+0x1193/0x1bb0 lib/vsprintf.c:2680
> > > Modules linked in:
> > > CPU: 0 PID: 5091 Comm: syz-executor879 Not tainted 6.10.0-rc1-syzkaller-00021-ge0cce98fe279 #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
> > > RIP: 0010:format_decode+0x1193/0x1bb0 lib/vsprintf.c:2680
> > > Call Trace:
> > >   <TASK>
> > >   bstr_printf+0x137/0x1210 lib/vsprintf.c:3253
> > >   ____bpf_trace_printk kernel/trace/bpf_trace.c:390 [inline]
> > >   bpf_trace_printk+0x1a1/0x230 kernel/trace/bpf_trace.c:375
> > >   bpf_prog_21da1b68f62e1237+0x36/0x41
> > >   bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
> > >   __bpf_prog_run include/linux/filter.h:691 [inline]
> > >   bpf_prog_run include/linux/filter.h:698 [inline]
> > >   bpf_test_run+0x40b/0x910 net/bpf/test_run.c:425
> > >   bpf_prog_test_run_skb+0xafa/0x13a0 net/bpf/test_run.c:1066
> > >   bpf_prog_test_run+0x33c/0x3b0 kernel/bpf/syscall.c:4291
> > >   __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5705
> > >   __do_sys_bpf kernel/bpf/syscall.c:5794 [inline]
> > >   __se_sys_bpf kernel/bpf/syscall.c:5792 [inline]
> > >   __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5792
> > >   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > >   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> > >   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > >
> > > The problem occurs when trying to pass %p% at the end of format string,
> > > which would result in skipping last % and passing invalid format string
> > > down to format_decode() that would cause warning because of invalid
> > > character after %.
> > >
> > > Fix issue by advancing pointer only if next char is format modifier.
> > > If next char is null/space/punct, then just accept formatting as is,
> > > without advancing the pointer.
> > >
> > > Found by Linux Verification Center (linuxtesting.org) with Syzkaller.
> > >
> > > Reported-by: syzbot+e2c932aec5c8a6e1d31c@syzkaller.appspotmail.com
> > > Closes: https://syzkaller.appspot.com/bug?extid=e2c932aec5c8a6e1d31c
> > > Fixes: 48cac3f4a96d ("bpf: Implement formatted output helpers with bstr_printf")
> > > Co-developed-by: Nikita Marushkin <hfggklm@gmail.com>
> > > Signed-off-by: Nikita Marushkin <hfggklm@gmail.com>
> > > Signed-off-by: Ilya Shchipletsov <rabbelkin@mail.ru>
> >
> > Acked-by: Yonghong Song <yonghong.song@linux.dev>
> >

The patches of the series are marked as "Changes Requested" in Patchwork.
They've been acked twice. And there've been no additional comment posted
on mailing lists explaining the "Changes Required" status.

Is there anything to improve in the series? Or it can be applied as is?

--
Thanks,
Fedor

