Return-Path: <bpf+bounces-48398-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82462A07981
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 15:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A3D9188B8FA
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 14:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9097321C17F;
	Thu,  9 Jan 2025 14:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="I0ekSmdq"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA39621764D;
	Thu,  9 Jan 2025 14:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736433700; cv=none; b=U8iF+RsqIY/QYGiLDyInHvthptk4uYIIhcxxbdoHZdzy0xg33zmNXZV9Dzrk4MdhHeHboBMh/My+3I7osBrbAsAVNuXgTf8Yz9VcSs35Rr2MrKUNUiX3TgNisQr4OCNZImgvgNnjPKj+uFA0V/1NaBIgmH0ObwWhvzyhtG3pScY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736433700; c=relaxed/simple;
	bh=xwebiABujpTv1kH6HSs+3ht0Gw1+Q0wxDUPau84O1ZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ykd5mHE/PU7Pbn1Xv1G+s6tXVixS91fVJb1JdWMCANZMHuLS912i0BcCbgqifforw7zBdlO1LBDNRvcgrJRwkQSNYIveziLEtGAG7JortMwnKlvTlN+R8aI6+FBy6Hhu0pj+457RneRYbozBrwG7fMqMW3FInSSz9IVn2SoMcOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=I0ekSmdq; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=7UpPfWJ/Yy7RSeIQsEMclF3qwwtPS9VmiyiHIvB/7eg=; b=I0ekSmdqsAF/0LpnA8kNJlxYpD
	y4wm1LUZog41u5K2tTI2lOuKIbcfCQqngM4w8y0leG8p0IFVg9wQOxGKNJX5sVqUCAFAIrtqHPXMS
	lcLcQHwtuX7KGE4AmMqfEnXHpiRLvad+TxwMMJscs0G33ww5/pbuIPNG7vRuyyJrjlNRLurvHG8TM
	575wFwh+b7pgnCXW+eZtwc490lOSCyLGZSbeSJN/uYkyLdx7KAX7Xed4wk1AoRnNbBm7O/5u8Ix7D
	itBRocf32PX5MbbxnGa/XgQx/WaiGFU5ga1XNrmDaTeLQPV6tXfOScGrofJsie0t9UHg+xpX0/p7P
	vB0s4t1w==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1tVtiy-000POt-0K; Thu, 09 Jan 2025 15:41:28 +0100
Received: from [178.197.248.23] (helo=[192.168.1.114])
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1tVtix-0005Qw-1C;
	Thu, 09 Jan 2025 15:41:27 +0100
Message-ID: <af5b64ae-3917-4083-930b-b8e41d3a98d7@iogearbox.net>
Date: Thu, 9 Jan 2025 15:41:26 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] uprobes: Fix race in uprobe_free_utask
To: Jiri Olsa <jolsa@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Andrii Nakryiko <andrii@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: Max Makarov <maxpain@linux.com>, bpf@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20250109141440.2692173-1-jolsa@kernel.org>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 xsFNBGNAkI0BEADiPFmKwpD3+vG5nsOznvJgrxUPJhFE46hARXWYbCxLxpbf2nehmtgnYpAN
 2HY+OJmdspBntWzGX8lnXF6eFUYLOoQpugoJHbehn9c0Dcictj8tc28MGMzxh4aK02H99KA8
 VaRBIDhmR7NJxLWAg9PgneTFzl2lRnycv8vSzj35L+W6XT7wDKoV4KtMr3Szu3g68OBbp1TV
 HbJH8qe2rl2QKOkysTFRXgpu/haWGs1BPpzKH/ua59+lVQt3ZupePpmzBEkevJK3iwR95TYF
 06Ltpw9ArW/g3KF0kFUQkGXYXe/icyzHrH1Yxqar/hsJhYImqoGRSKs1VLA5WkRI6KebfpJ+
 RK7Jxrt02AxZkivjAdIifFvarPPu0ydxxDAmgCq5mYJ5I/+BY0DdCAaZezKQvKw+RUEvXmbL
 94IfAwTFA1RAAuZw3Rz5SNVz7p4FzD54G4pWr3mUv7l6dV7W5DnnuohG1x6qCp+/3O619R26
 1a7Zh2HlrcNZfUmUUcpaRPP7sPkBBLhJfqjUzc2oHRNpK/1mQ/+mD9CjVFNz9OAGD0xFzNUo
 yOFu/N8EQfYD9lwntxM0dl+QPjYsH81H6zw6ofq+jVKcEMI/JAgFMU0EnxrtQKH7WXxhO4hx
 3DFM7Ui90hbExlFrXELyl/ahlll8gfrXY2cevtQsoJDvQLbv7QARAQABzSZEYW5pZWwgQm9y
 a21hbm4gPGRhbmllbEBpb2dlYXJib3gubmV0PsLBkQQTAQoAOxYhBCrUdtCTcZyapV2h+93z
 cY/jfzlXBQJjQJCNAhsDBQkHhM4ACAsJCAcNDAsKBRUKCQgLAh4BAheAAAoJEN3zcY/jfzlX
 dkUQAIFayRgjML1jnwKs7kvfbRxf11VI57EAG8a0IvxDlNKDcz74mH66HMyhMhPqCPBqphB5
 ZUjN4N5I7iMYB/oWUeohbuudH4+v6ebzzmgx/EO+jWksP3gBPmBeeaPv7xOvN/pPDSe/0Ywp
 dHpl3Np2dS6uVOMnyIsvmUGyclqWpJgPoVaXrVGgyuer5RpE/a3HJWlCBvFUnk19pwDMMZ8t
 0fk9O47HmGh9Ts3O8pGibfdREcPYeGGqRKRbaXvcRO1g5n5x8cmTm0sQYr2xhB01RJqWrgcj
 ve1TxcBG/eVMmBJefgCCkSs1suriihfjjLmJDCp9XI/FpXGiVoDS54TTQiKQinqtzP0jv+TH
 1Ku+6x7EjLoLH24ISGyHRmtXJrR/1Ou22t0qhCbtcT1gKmDbTj5TcqbnNMGWhRRTxgOCYvG0
 0P2U6+wNj3HFZ7DePRNQ08bM38t8MUpQw4Z2SkM+jdqrPC4f/5S8JzodCu4x80YHfcYSt+Jj
 ipu1Ve5/ftGlrSECvy80ZTKinwxj6lC3tei1bkI8RgWZClRnr06pirlvimJ4R0IghnvifGQb
 M1HwVbht8oyUEkOtUR0i0DMjk3M2NoZ0A3tTWAlAH8Y3y2H8yzRrKOsIuiyKye9pWZQbCDu4
 ZDKELR2+8LUh+ja1RVLMvtFxfh07w9Ha46LmRhpCzsFNBGNAkI0BEADJh65bNBGNPLM7cFVS
 nYG8tqT+hIxtR4Z8HQEGseAbqNDjCpKA8wsxQIp0dpaLyvrx4TAb/vWIlLCxNu8Wv4W1JOST
 wI+PIUCbO/UFxRy3hTNlb3zzmeKpd0detH49bP/Ag6F7iHTwQQRwEOECKKaOH52tiJeNvvyJ
 pPKSKRhmUuFKMhyRVK57ryUDgowlG/SPgxK9/Jto1SHS1VfQYKhzMn4pWFu0ILEQ5x8a0RoX
 k9p9XkwmXRYcENhC1P3nW4q1xHHlCkiqvrjmWSbSVFYRHHkbeUbh6GYuCuhqLe6SEJtqJW2l
 EVhf5AOp7eguba23h82M8PC4cYFl5moLAaNcPHsdBaQZznZ6NndTtmUENPiQc2EHjHrrZI5l
 kRx9hvDcV3Xnk7ie0eAZDmDEbMLvI13AvjqoabONZxra5YcPqxV2Biv0OYp+OiqavBwmk48Z
 P63kTxLddd7qSWbAArBoOd0wxZGZ6mV8Ci/ob8tV4rLSR/UOUi+9QnkxnJor14OfYkJKxot5
 hWdJ3MYXjmcHjImBWplOyRiB81JbVf567MQlanforHd1r0ITzMHYONmRghrQvzlaMQrs0V0H
 5/sIufaiDh7rLeZSimeVyoFvwvQPx5sXhjViaHa+zHZExP9jhS/WWfFE881fNK9qqV8pi+li
 2uov8g5yD6hh+EPH6wARAQABwsF8BBgBCgAmFiEEKtR20JNxnJqlXaH73fNxj+N/OVcFAmNA
 kI0CGwwFCQeEzgAACgkQ3fNxj+N/OVfFMhAA2zXBUzMLWgTm6iHKAPfz3xEmjtwCF2Qv/TT3
 KqNUfU3/0VN2HjMABNZR+q3apm+jq76y0iWroTun8Lxo7g89/VDPLSCT0Nb7+VSuVR/nXfk8
 R+OoXQgXFRimYMqtP+LmyYM5V0VsuSsJTSnLbJTyCJVu8lvk3T9B0BywVmSFddumv3/pLZGn
 17EoKEWg4lraXjPXnV/zaaLdV5c3Olmnj8vh+14HnU5Cnw/dLS8/e8DHozkhcEftOf+puCIl
 Awo8txxtLq3H7KtA0c9kbSDpS+z/oT2S+WtRfucI+WN9XhvKmHkDV6+zNSH1FrZbP9FbLtoE
 T8qBdyk//d0GrGnOrPA3Yyka8epd/bXA0js9EuNknyNsHwaFrW4jpGAaIl62iYgb0jCtmoK/
 rCsv2dqS6Hi8w0s23IGjz51cdhdHzkFwuc8/WxI1ewacNNtfGnorXMh6N0g7E/r21pPeMDFs
 rUD9YI1Je/WifL/HbIubHCCdK8/N7rblgUrZJMG3W+7vAvZsOh/6VTZeP4wCe7Gs/cJhE2gI
 DmGcR+7rQvbFQC4zQxEjo8fNaTwjpzLM9NIp4vG9SDIqAm20MXzLBAeVkofixCsosUWUODxP
 owLbpg7pFRJGL9YyEHpS7MGPb3jSLzucMAFXgoI8rVqoq6si2sxr2l0VsNH5o3NgoAgJNIg=
In-Reply-To: <20250109141440.2692173-1-jolsa@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 1.0.7/27513/Thu Jan  9 10:53:02 2025)

On 1/9/25 3:14 PM, Jiri Olsa wrote:
> Max Makarov reported kernel panic [1] in perf user callchain code.
> 
> The reason for that is the race between uprobe_free_utask and bpf
> profiler code doing the perf user stack unwind and is triggered
> within uprobe_free_utask function:
>    - after current->utask is freed and
>    - before current->utask is set to NULL
> 
>   general protection fault, probably for non-canonical address 0x9e759c37ee555c76: 0000 [#1] SMP PTI
>   RIP: 0010:is_uprobe_at_func_entry+0x28/0x80
>   ...
>    ? die_addr+0x36/0x90
>    ? exc_general_protection+0x217/0x420
>    ? asm_exc_general_protection+0x26/0x30
>    ? is_uprobe_at_func_entry+0x28/0x80
>    perf_callchain_user+0x20a/0x360
>    get_perf_callchain+0x147/0x1d0
>    bpf_get_stackid+0x60/0x90
>    bpf_prog_9aac297fb833e2f5_do_perf_event+0x434/0x53b
>    ? __smp_call_single_queue+0xad/0x120
>    bpf_overflow_handler+0x75/0x110
>    ...
>    asm_sysvec_apic_timer_interrupt+0x1a/0x20
>   RIP: 0010:__kmem_cache_free+0x1cb/0x350
>   ...
>    ? uprobe_free_utask+0x62/0x80
>    ? acct_collect+0x4c/0x220
>    uprobe_free_utask+0x62/0x80
>    mm_release+0x12/0xb0
>    do_exit+0x26b/0xaa0
>    __x64_sys_exit+0x1b/0x20
>    do_syscall_64+0x5a/0x80
> 
> It can be easily reproduced by running following commands in
> separate terminals:
> 
>    # while :; do bpftrace -e 'uprobe:/bin/ls:_start  { printf("hit\n"); }' -c ls; done
>    # bpftrace -e 'profile:hz:100000 { @[ustack()] = count(); }'
> 
> Fixing this by making sure current->utask pointer is set to NULL
> before we start to release the utask object.

Lets add Fixes tag for stable team:

Fixes: cfa7f3d2c526 ("perf,x86: avoid missing caller address in stack traces captured in uprobe")

> [1] https://github.com/grafana/pyroscope/issues/3673
> Reported-by: Max Makarov <maxpain@linux.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

fwiw, the other version we were potentially thinking of was below, but
just moving the t->utask NULL assignment seemed better.

Thanks,
Daniel

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index c75c482d4c52..05f9cedf2691 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -2835,6 +2835,8 @@ static bool is_uprobe_at_func_entry(struct pt_regs *regs)

         if (!current->utask)
                 return false;
+       if (!current->utask->active_uprobe)
+               return false;

         auprobe = current->utask->auprobe;
         if (!auprobe)

