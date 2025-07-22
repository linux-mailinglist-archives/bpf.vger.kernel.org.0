Return-Path: <bpf+bounces-64044-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10753B0DACB
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 15:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6558563B01
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 13:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5752EA49D;
	Tue, 22 Jul 2025 13:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="L8Rycg9Q"
X-Original-To: bpf@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB022E338B;
	Tue, 22 Jul 2025 13:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753190907; cv=none; b=W275R69pgAWmdUtbyKJBzPRq9wM0PybJ50WArJpY0W4X5anrAaEh+Gqg686ohZhZbYVxvyJmHZ3N/46e/o5Ie8d0jcofH3FwzUBy/72rq9JPrzS/Je7okltLUnE4GwBNusxAdWSS4o+8VXVp4kEY6TWC68obQ/36/vALoXUC7vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753190907; c=relaxed/simple;
	bh=UlPoVR5QC1KhInRk9vJr6g7Szxa5HcUjm/ee86z3yn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZRyrEXGXRTlzBonmdF3y93KrIzRXWV18lldFyxkuJr5IYb0sWA7mhnQ7h77n9Hs/K97AzfU4gOELpotbcLN1bhDPyM2Do1+TySi9c2RM0zuYUmwEvWnCePPgpyzOK+M7yDFGBIXSyHaDhcw/WW4cmaXModq45Va7Fo5kzI2+NfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=L8Rycg9Q; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cQbj0cQcdo0qq8guQgb1++o9RIM4pgMuhBXxGM8ddco=; b=L8Rycg9Qrn7ru2lad/IIluFfsQ
	TljNaD1lcdmbBIVU4EmLMl12zfqoVbR2y5U32E5r/s1IM/S0q7YlGJ/ztDOPIc2X3pqx08GT+B76l
	taeTyVtiuA9TX6kRIw9xaT4OeO0cFo9V3g6Ww1SSt9Qi9Fh3lQm+pBpl3NtvA4G+5vms=;
Received: from p5b2062ed.dip0.t-ipconnect.de ([91.32.98.237] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1ueD2U-00Fylh-0O;
	Tue, 22 Jul 2025 15:28:14 +0200
Message-ID: <2e267b4b-0540-45d8-9310-e127bf95fc63@nbd.name>
Date: Tue, 22 Jul 2025 15:28:13 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/1] bpf: fix WARNING in __bpf_prog_ret0_warn
 when jit failed
To: KaFai Wan <mannkafai@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250526133358.2594176-1-mannkafai@gmail.com>
From: Felix Fietkau <nbd@nbd.name>
Content-Language: en-US
Autocrypt: addr=nbd@nbd.name; keydata=
 xsDiBEah5CcRBADIY7pu4LIv3jBlyQ/2u87iIZGe6f0f8pyB4UjzfJNXhJb8JylYYRzIOSxh
 ExKsdLCnJqsG1PY1mqTtoG8sONpwsHr2oJ4itjcGHfn5NJSUGTbtbbxLro13tHkGFCoCr4Z5
 Pv+XRgiANSpYlIigiMbOkide6wbggQK32tC20QxUIwCg4k6dtV/4kwEeiOUfErq00TVqIiEE
 AKcUi4taOuh/PQWx/Ujjl/P1LfJXqLKRPa8PwD4j2yjoc9l+7LptSxJThL9KSu6gtXQjcoR2
 vCK0OeYJhgO4kYMI78h1TSaxmtImEAnjFPYJYVsxrhay92jisYc7z5R/76AaELfF6RCjjGeP
 wdalulG+erWju710Bif7E1yjYVWeA/9Wd1lsOmx6uwwYgNqoFtcAunDaMKi9xVQW18FsUusM
 TdRvTZLBpoUAy+MajAL+R73TwLq3LnKpIcCwftyQXK5pEDKq57OhxJVv1Q8XkA9Dn1SBOjNB
 l25vJDFAT9ntp9THeDD2fv15yk4EKpWhu4H00/YX8KkhFsrtUs69+vZQwc0cRmVsaXggRmll
 dGthdSA8bmJkQG5iZC5uYW1lPsJgBBMRAgAgBQJGoeQnAhsjBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQ130UHQKnbvXsvgCgjsAIIOsY7xZ8VcSm7NABpi91yTMAniMMmH7FRenEAYMa
 VrwYTIThkTlQzsFNBEah5FQQCACMIep/hTzgPZ9HbCTKm9xN4bZX0JjrqjFem1Nxf3MBM5vN
 CYGBn8F4sGIzPmLhl4xFeq3k5irVg/YvxSDbQN6NJv8o+tP6zsMeWX2JjtV0P4aDIN1pK2/w
 VxcicArw0VYdv2ZCarccFBgH2a6GjswqlCqVM3gNIMI8ikzenKcso8YErGGiKYeMEZLwHaxE
 Y7mTPuOTrWL8uWWRL5mVjhZEVvDez6em/OYvzBwbkhImrryF29e3Po2cfY2n7EKjjr3/141K
 DHBBdgXlPNfDwROnA5ugjjEBjwkwBQqPpDA7AYPvpHh5vLbZnVGu5CwG7NAsrb2isRmjYoqk
 wu++3117AAMFB/9S0Sj7qFFQcD4laADVsabTpNNpaV4wAgVTRHKV/kC9luItzwDnUcsZUPdQ
 f3MueRJ3jIHU0UmRBG3uQftqbZJj3ikhnfvyLmkCNe+/hXhPu9sGvXyi2D4vszICvc1KL4RD
 aLSrOsROx22eZ26KqcW4ny7+va2FnvjsZgI8h4sDmaLzKczVRIiLITiMpLFEU/VoSv0m1F4B
 FtRgoiyjFzigWG0MsTdAN6FJzGh4mWWGIlE7o5JraNhnTd+yTUIPtw3ym6l8P+gbvfoZida0
 TspgwBWLnXQvP5EDvlZnNaKa/3oBes6z0QdaSOwZCRA3QSLHBwtgUsrT6RxRSweLrcabwkkE
 GBECAAkFAkah5FQCGwwACgkQ130UHQKnbvW2GgCeMncXpbbWNT2AtoAYICrKyX5R3iMAoMhw
 cL98efvrjdstUfTCP2pfetyN
In-Reply-To: <20250526133358.2594176-1-mannkafai@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 26.05.25 15:33, KaFai Wan wrote:
> syzkaller reported an issue:
> 
> WARNING: CPU: 3 PID: 217 at kernel/bpf/core.c:2357 __bpf_prog_ret0_warn+0xa/0x20 kernel/bpf/core.c:2357
> Modules linked in:
> CPU: 3 UID: 0 PID: 217 Comm: kworker/u32:6 Not tainted 6.15.0-rc4-syzkaller-00040-g8bac8898fe39 #0 PREEMPT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> Workqueue: ipv6_addrconf addrconf_dad_work
> RIP: 0010:__bpf_prog_ret0_warn+0xa/0x20 kernel/bpf/core.c:2357
> RSP: 0018:ffffc900031f6c18 EFLAGS: 00010293
> RAX: 0000000000000000 RBX: ffffc9000006e000 RCX: 1ffff9200000dc06
> RDX: ffff8880234ba440 RSI: ffffffff81ca6979 RDI: ffff888031e93040
> RBP: ffffc900031f6cb8 R08: 0000000000000001 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: ffff88802b61e010
> R13: ffff888031e93040 R14: 00000000000000a0 R15: ffff88802c3d4800
> FS:  0000000000000000(0000) GS:ffff8880d6ce2000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055557b6d2ca8 CR3: 000000002473e000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <TASK>
>   bpf_dispatcher_nop_func include/linux/bpf.h:1316 [inline]
>   __bpf_prog_run include/linux/filter.h:718 [inline]
>   bpf_prog_run include/linux/filter.h:725 [inline]
>   cls_bpf_classify+0x74a/0x1110 net/sched/cls_bpf.c:105
>   ...
> 
> When creating bpf program, 'fp->jit_requested' depends on bpf_jit_enable.
> Currently the value of bpf_jit_enable is available from 0 to 2, 0 means use
> interpreter and not jit, 1 and 2 means need to jit. When
> CONFIG_BPF_JIT_ALWAYS_ON is enabled, bpf_jit_enable is permanently set
> to 1, when it's not set or disabled, we can set bpf_jit_enable via proc.
> 
> This issue is triggered because of CONFIG_BPF_JIT_ALWAYS_ON is not set
> and bpf_jit_enable is set to 1, causing the arch to attempt JIT the prog,
> but jit failed due to FAULT_INJECTION. As a result, incorrectly
> treats the program as valid, when the program runs it calls
> `__bpf_prog_ret0_warn` and triggers the WARN_ON_ONCE(1).
> 
> Reported-by: syzbot+0903f6d7f285e41cdf10@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/bpf/6816e34e.a70a0220.254cdc.002c.GAE@google.com
> Fixes: fa9dd599b4da ("bpf: get rid of pure_initcall dependency to enable jits")
> Signed-off-by: KaFai Wan <mannkafai@gmail.com>

I think this patch may have caused a regression in configurations with 
CONFIG_BPF_JIT_DEFAULT_ON=y when programs can't be JITed. Attaching the 
program fails with error -ENOTSUPP.

Please see https://github.com/openwrt/openwrt/issues/19405 for more 
information.

- Felix

