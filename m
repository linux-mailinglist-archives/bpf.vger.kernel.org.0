Return-Path: <bpf+bounces-49559-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 565E0A19CF5
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 03:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB38616E1DE
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 02:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A2B20B22;
	Thu, 23 Jan 2025 02:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ow0+G1SS"
X-Original-To: bpf@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D12D3232;
	Thu, 23 Jan 2025 02:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737598917; cv=none; b=NZNR76JvU++ZJFa/F35sbskuZmIrtx3Eu6avr4SpbDGTMNQ+XLRPgP2m9y5AT8YbB4gzDOWNUIHt76qzY/6ZzjaQk5iBxY0vflas+quHgNrItKV2giyVgNXvwA+8Bqd268SaAv8aigAAbpDs4uB4jf2/1Ip9miZ252gGFjToMP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737598917; c=relaxed/simple;
	bh=O0004Fp/PwMUyShcBZvPfRbmhH7tY4eOGMWkdrheC70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XKFbszzEJ2TlAMaOk9Zl3G5OV/HZF3lmAYciOZ3SAyTFkH2z5XkezjPBDSluF3XetZiRNUTz59VxqgLm4PtP2bSg6QfmiteYoyiss16zIKYI0a7+P7gaKrFhEXtuLkJx9RL+pPunMmyJsnBEBcElj8yis+Bi5e9qTlH9YtPZhEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ow0+G1SS; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737598909; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=bOiM5BoMJqM/ebH3s2iqhNfCXeb+AKnDndw+EHGdh18=;
	b=Ow0+G1SS9EMK6zR8YxDsFYFW/gveA9ZhypFIEDNl+RTb7u7EsmW9CkfHAvPyhcL7QOOBGfNSyKrwsTQREMKa/71fQwpbegj9CI0ovFLy2VVvHq7djv1eGHy/FAJdwyymrHDlXZOCfDjOHr1tQZOfpNthOYu5Mn2IuGyaSHH8DTA=
Received: from 30.221.96.170(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0WOA2eXV_1737598906 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 23 Jan 2025 10:21:48 +0800
Message-ID: <437f3824-f6be-4053-acfe-7f3f1ebc626c@linux.alibaba.com>
Date: Thu, 23 Jan 2025 10:21:46 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v7 2/6] net/smc: fix UAF on smcsk after
 smc_listen_out()
To: "D. Wythe" <alibuda@linux.alibaba.com>, kgraul@linux.ibm.com,
 wenjia@linux.ibm.com, jaka@linux.ibm.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 pabeni@redhat.com, song@kernel.org, sdf@google.com, haoluo@google.com,
 yhs@fb.com, edumazet@google.com, john.fastabend@gmail.com,
 kpsingh@kernel.org, jolsa@kernel.org, guwen@linux.alibaba.com
Cc: kuba@kernel.org, davem@davemloft.net, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org, bpf@vger.kernel.org
References: <20250123015942.94810-1-alibuda@linux.alibaba.com>
 <20250123015942.94810-3-alibuda@linux.alibaba.com>
Content-Language: en-US
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
In-Reply-To: <20250123015942.94810-3-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025/1/23 09:59, D. Wythe wrote:
> BPF CI testing report a UAF issue:
> 
>   [   16.446633] BUG: kernel NULL pointer dereference, address: 000000000000003  0
>   [   16.447134] #PF: supervisor read access in kernel mod  e
>   [   16.447516] #PF: error_code(0x0000) - not-present pag  e
>   [   16.447878] PGD 0 P4D   0
>   [   16.448063] Oops: Oops: 0000 [#1] PREEMPT SMP NOPT  I
>   [   16.448409] CPU: 0 UID: 0 PID: 9 Comm: kworker/0:1 Tainted: G           OE      6.13.0-rc3-g89e8a75fda73-dirty #4  2
>   [   16.449124] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODUL  E
>   [   16.449502] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/201  4
>   [   16.450201] Workqueue: smc_hs_wq smc_listen_wor  k
>   [   16.450531] RIP: 0010:smc_listen_work+0xc02/0x159  0
>   [   16.452158] RSP: 0018:ffffb5ab40053d98 EFLAGS: 0001024  6
>   [   16.452526] RAX: 0000000000000001 RBX: 0000000000000002 RCX: 000000000000030  0
>   [   16.452994] RDX: 0000000000000280 RSI: 00003513840053f0 RDI: 000000000000000  0
>   [   16.453492] RBP: ffffa097808e3800 R08: ffffa09782dba1e0 R09: 000000000000000  5
>   [   16.453987] R10: 0000000000000000 R11: 0000000000000000 R12: ffffa0978274640  0
>   [   16.454497] R13: 0000000000000000 R14: 0000000000000000 R15: ffffa09782d4092  0
>   [   16.454996] FS:  0000000000000000(0000) GS:ffffa097bbc00000(0000) knlGS:000000000000000  0
>   [   16.455557] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003  3
>   [   16.455961] CR2: 0000000000000030 CR3: 0000000102788004 CR4: 0000000000770ef  0
>   [   16.456459] PKRU: 5555555  4
>   [   16.456654] Call Trace  :
>   [   16.456832]  <TASK  >
>   [   16.456989]  ? __die+0x23/0x7  0
>   [   16.457215]  ? page_fault_oops+0x180/0x4c  0
>   [   16.457508]  ? __lock_acquire+0x3e6/0x249  0
>   [   16.457801]  ? exc_page_fault+0x68/0x20  0
>   [   16.458080]  ? asm_exc_page_fault+0x26/0x3  0
>   [   16.458389]  ? smc_listen_work+0xc02/0x159  0
>   [   16.458689]  ? smc_listen_work+0xc02/0x159  0
>   [   16.458987]  ? lock_is_held_type+0x8f/0x10  0
>   [   16.459284]  process_one_work+0x1ea/0x6d  0
>   [   16.459570]  worker_thread+0x1c3/0x38  0
>   [   16.459839]  ? __pfx_worker_thread+0x10/0x1  0
>   [   16.460144]  kthread+0xe0/0x11  0
>   [   16.460372]  ? __pfx_kthread+0x10/0x1  0
>   [   16.460640]  ret_from_fork+0x31/0x5  0
>   [   16.460896]  ? __pfx_kthread+0x10/0x1  0
>   [   16.461166]  ret_from_fork_asm+0x1a/0x3  0
>   [   16.461453]  </TASK  >
>   [   16.461616] Modules linked in: bpf_testmod(OE) [last unloaded: bpf_testmod(OE)  ]
>   [   16.462134] CR2: 000000000000003  0
>   [   16.462380] ---[ end trace 0000000000000000 ]---
>   [   16.462710] RIP: 0010:smc_listen_work+0xc02/0x1590
> 
> The direct cause of this issue is that after smc_listen_out_connected(),
> newclcsock->sk may be NULL since it will releases the smcsk. Therefore,
> if the application closes the socket immediately after accept,
> newclcsock->sk can be NULL. A possible execution order could be as
> follows:
> 
> smc_listen_work                                 | userspace
> -----------------------------------------------------------------
> lock_sock(sk)                                   |
> smc_listen_out_connected()                      |
> | \- smc_listen_out                             |
> |    | \- release_sock                          |
>      | |- sk->sk_data_ready()                   |
>                                                 | fd = accept();
>                                                 | close(fd);
>                                                 |  \- socket->sk = NULL;
> /* newclcsock->sk is NULL now */
> SMC_STAT_SERV_SUCC_INC(sock_net(newclcsock->sk))
> 
> Since smc_listen_out_connected() will not fail, simply swapping the order
> of the code can easily fix this issue.
> 
> Fixes: 3b2dec2603d5 ("net/smc: restructure client and server code in af_smc")
> Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> ---
>  net/smc/af_smc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index c370efcfe3e8..9eebf7d0179e 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -2549,8 +2549,9 @@ static void smc_listen_work(struct work_struct *work)
>  			goto out_decl;
>  	}
>  
> -	smc_listen_out_connected(new_smc);
>  	SMC_STAT_SERV_SUCC_INC(sock_net(newclcsock->sk), ini);
> +	/* smc_listen_out() will release smcsk */
> +	smc_listen_out_connected(new_smc);
>  	goto out_free;
>  
>  out_unlock:

LGTM.
Reviewed-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>

