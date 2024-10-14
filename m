Return-Path: <bpf+bounces-41886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 518DB99D8F4
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 23:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 706CC1C21438
	for <lists+bpf@lfdr.de>; Mon, 14 Oct 2024 21:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE411D0F5D;
	Mon, 14 Oct 2024 21:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jgqrMoIQ"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5526F1CC173
	for <bpf@vger.kernel.org>; Mon, 14 Oct 2024 21:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728941351; cv=none; b=pWdQeLOcb99rH9EtQTm/iR4rSpx/Q66itkOlwcALe6T0Yz75D/RT/1bpcOkyfPum1fNwKsiv69ojnkEN0amCRlLHioa+0eIcGlKVqyB14eA9QJRHidBEfxwg40ToKji+8MmcN2raa9kja4FzyliPX5FZXMGb6jgALPKpJvxflZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728941351; c=relaxed/simple;
	bh=+Fc5ELzw9cgbeRfJfp6d6rq0NL1HERYLDqAlzClUUlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d6HrhNcwA7ZMdZkM+7rp5iorSHfSSTbxWgTqyVmaTbsNfv/eKGisZnU8Tra3L7HHgqsi0CVgPgbZtCE8WbnpBtDTx6Wpe24nbM6ypl1hfWn0zPjA2dL5N9OsWc7ycOjraIHLYsWmk6bvjzksR4qTIYEqorOFEFJvAkbo1zJgEz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jgqrMoIQ; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <06260b1f-7fce-446f-9b06-309001bdae58@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728941346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X2a/12gQx2FXChpTRAlFQ1e3CeEIxB8iEuXXSpY+6VI=;
	b=jgqrMoIQqaF1pLbSzpjBtMFN0/JXD7YVcGDTTvm+Fnce8KRDkP1lD/IvkLN9NGnuT787Pi
	NEhNzIM2IAWTqHrIK/LB8BfsxDr7/GHW1IpryuRHEX/xya1TjGSzxhH15eaIWRnfNmFifd
	WXbp0sbYzxB4e9DT6VnsNhsYoAIcT+g=
Date: Mon, 14 Oct 2024 14:28:59 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf: fix %p% runtime check in bpf_bprintf_prepare
Content-Language: en-GB
To: Ilya Shchipletsov <rabbelkin@mail.ru>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, linux-kernel@vger.kernel.org,
 Florent Revest <revest@chromium.org>, Nikita Marushkin <hfggklm@gmail.com>,
 lvc-project@linuxtesting.org
References: <9679a031-3858-4fef-bb8e-1cf436696095@mail.ru>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <9679a031-3858-4fef-bb8e-1cf436696095@mail.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 10/9/24 3:57 AM, Ilya Shchipletsov wrote:
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

Indeed, in kernel doing
   printk("%p%");
will have following compilation failure.

/home/yhs/work/bpf-next/kernel/bpf/helpers.c:830:10: error: more '%' conversions than data arguments [-Werror,-Wformat-insufficient-args]
   830 | printk("%p%");
       |         ~^
/home/yhs/work/bpf-next/include/linux/printk.h:490:53: note: expanded from macro 'printk'
   490 | #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
       |                                                     ^~~
/home/yhs/work/bpf-next/include/linux/printk.h:462:11: note: expanded from macro 'printk_index_wrap'
   462 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
       |                         ^~~~
1 error generated.

>
> Fix issue by advancing pointer only if next char is format modifier.
> If next char is null/space/punct, then just accept formatting as is,
> without advancing the pointer.
>
> Fixes: 48cac3f4a96d ("bpf: Implement formatted output helpers with bstr_printf")
> Co-developed-by: Nikita Marushkin <hfggklm@gmail.com>
> Signed-off-by: Nikita Marushkin <hfggklm@gmail.com>
> Signed-off-by: Ilya Shchipletsov <rabbelkin@mail.ru>

LGTM with some comments and nits below.

Acked-by: Yonghong Song <yonghong.song@linux.dev>

> ---
>   kernel/bpf/helpers.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index c9e235807cac..bd771d6aacdb 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -892,14 +892,19 @@ int bpf_bprintf_prepare(char *fmt, u32 fmt_size, const u64 *raw_args,
>   				goto fmt_str;
>   			}
>   
> +			if (fmt[i + 1] == 'K' || fmt[i + 1] == 'x' ||
> +			    fmt[i + 1] == 's' || fmt[i + 1] == 'S') {
> +				if (tmp_buf)
> +					cur_arg = raw_args[num_spec];
> +				i++;
> +				goto nocopy_fmt;
> +			}
> +
>   			if (fmt[i + 1] == 0 || isspace(fmt[i + 1]) ||
> -			    ispunct(fmt[i + 1]) || fmt[i + 1] == 'K' ||
> -			    fmt[i + 1] == 'x' || fmt[i + 1] == 's' ||
> -			    fmt[i + 1] == 'S') {
> +			    ispunct(fmt[i + 1])) {
>   				/* just kernel pointers */
>   				if (tmp_buf)
>   					cur_arg = raw_args[num_spec];
> -				i++;
>   				goto nocopy_fmt;
>   			}

We could do ispunct(fmt[i + 1]) only in the above 'if' statement.
But your implementation is right too and maybe cleaner, so let us
keep your above implementation.

Could you move comment '/* just kernel pointers */' to previous
if statement.

Also could you add Reported-by mentioned by Florent Revest
in the next revision?


