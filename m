Return-Path: <bpf+bounces-49610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F37A1ABA0
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 21:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 422543A8730
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2025 20:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E3C1C3F34;
	Thu, 23 Jan 2025 20:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="TrE7G3/7"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BBE15A843;
	Thu, 23 Jan 2025 20:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737665734; cv=none; b=FMmJtnsgSBu45cKpiyAcAZlbFVBigYfBBm2XlTt3iVsQ5LSAAhCo9DT9BJ+f7vVqWafYy9OdIWb59vWz7KN75gskVyf9NixS5SiRS+B87Hx0P6jWg/Uo/1xRYqifrH7+bpQEKnn2nkRhjyGGxLawyyquu1t2TDau7r46CSOfixE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737665734; c=relaxed/simple;
	bh=cSCSxSMcps1bRgmUx+OFw5mI6FDEIEX0c4n9fLb6krA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zqmf7riP3ys6iGk40wlK310DNyaFy/yXu1nvvMfrcL1KWI6pt/hkXoD+fbKFa/10Vl8Fu/g978LDlrgQRhrQCWn0+Xw0nR4cezxFTLIvkRiHRlSbOoETFQqCJ3mvbdox8X/0a5cUdAoXeyb5RhwwlhD4C2RG1KDo9yrmzlMlumU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=TrE7G3/7; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=BrXeBk1bKk5IsEDpSnUvpvo4xc1YNnjHmYUJh4jHJLA=; b=TrE7G3/7htM4M5xvy6js3LcWqQ
	NumzRCKL8vLY+rqBsRLTMsRzgGIaKto48uvV2kShiK9zBFLpb9zMju3bWNVPCCtjYiYqpOaT2u+Na
	u4FaSm+KCJtMYVXMn8TB2L1bsOkDDseZ1nFSsXRmMX/qFByS9x4YSFa0c55YjkvH5tg4DLjgWQUcB
	nWeo9eytk+5LN3DHq0TeO8PaU85B/UX9LFWA6EM/K2d629CuEiOEwOwn57L6mGSLqC9CR9z4XQOnG
	CC2Of1/Qb3+aK8Wj6uwczBIcgTu5Azd9Cp8vQWJvxOn8yIHPwLoZ87Qd8Ud4KnRX1pc4HjbhEo4h7
	vu7rlkfA==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1tb4ES-000HLH-2T;
	Thu, 23 Jan 2025 21:55:21 +0100
Received: from [85.1.206.226] (helo=[192.168.1.114])
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1tb4ER-0007NB-34;
	Thu, 23 Jan 2025 21:55:20 +0100
Message-ID: <a6db73c9-e495-45db-b9c6-a6564f68cef0@iogearbox.net>
Date: Thu, 23 Jan 2025 21:55:19 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2 1/2] bpf, test_run: Fix use-after-free issue in
 eth_skb_pkt_type()
To: Shigeru Yoshida <syoshida@redhat.com>, ast@kernel.org, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, hawk@kernel.org, lorenzo@kernel.org,
 toke@redhat.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 stfomichev@gmail.com, syzkaller <syzkaller@googlegroups.com>
References: <20250121150643.671650-1-syoshida@redhat.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <20250121150643.671650-1-syoshida@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 1.0.7/27527/Thu Jan 23 10:44:17 2025)

On 1/21/25 4:06 PM, Shigeru Yoshida wrote:
> KMSAN reported a use-after-free issue in eth_skb_pkt_type()[1]. The
> cause of the issue was that eth_skb_pkt_type() accessed skb's data
> that didn't contain an Ethernet header. This occurs when
> bpf_prog_test_run_xdp() passes an invalid value as the user_data
> argument to bpf_test_init().
> 
> Fix this by returning an error when user_data is less than ETH_HLEN in
> bpf_test_init(). Additionally, remove the check for "if (user_size >
> size)" as it is unnecessary.
> 
> [1]
> BUG: KMSAN: use-after-free in eth_skb_pkt_type include/linux/etherdevice.h:627 [inline]
> BUG: KMSAN: use-after-free in eth_type_trans+0x4ee/0x980 net/ethernet/eth.c:165
>   eth_skb_pkt_type include/linux/etherdevice.h:627 [inline]
>   eth_type_trans+0x4ee/0x980 net/ethernet/eth.c:165
>   __xdp_build_skb_from_frame+0x5a8/0xa50 net/core/xdp.c:635
>   xdp_recv_frames net/bpf/test_run.c:272 [inline]
>   xdp_test_run_batch net/bpf/test_run.c:361 [inline]
>   bpf_test_run_xdp_live+0x2954/0x3330 net/bpf/test_run.c:390
>   bpf_prog_test_run_xdp+0x148e/0x1b10 net/bpf/test_run.c:1318
>   bpf_prog_test_run+0x5b7/0xa30 kernel/bpf/syscall.c:4371
>   __sys_bpf+0x6a6/0xe20 kernel/bpf/syscall.c:5777
>   __do_sys_bpf kernel/bpf/syscall.c:5866 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:5864 [inline]
>   __x64_sys_bpf+0xa4/0xf0 kernel/bpf/syscall.c:5864
>   x64_sys_call+0x2ea0/0x3d90 arch/x86/include/generated/asm/syscalls_64.h:322
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xd9/0x1d0 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> Uninit was created at:
>   free_pages_prepare mm/page_alloc.c:1056 [inline]
>   free_unref_page+0x156/0x1320 mm/page_alloc.c:2657
>   __free_pages+0xa3/0x1b0 mm/page_alloc.c:4838
>   bpf_ringbuf_free kernel/bpf/ringbuf.c:226 [inline]
>   ringbuf_map_free+0xff/0x1e0 kernel/bpf/ringbuf.c:235
>   bpf_map_free kernel/bpf/syscall.c:838 [inline]
>   bpf_map_free_deferred+0x17c/0x310 kernel/bpf/syscall.c:862
>   process_one_work kernel/workqueue.c:3229 [inline]
>   process_scheduled_works+0xa2b/0x1b60 kernel/workqueue.c:3310
>   worker_thread+0xedf/0x1550 kernel/workqueue.c:3391
>   kthread+0x535/0x6b0 kernel/kthread.c:389
>   ret_from_fork+0x6e/0x90 arch/x86/kernel/process.c:147
>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> 
> CPU: 1 UID: 0 PID: 17276 Comm: syz.1.16450 Not tainted 6.12.0-05490-g9bb88c659673 #8
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-3.fc41 04/01/2014
> 
> Fixes: be3d72a2896c ("bpf: move user_size out of bpf_test_init")
> Reported-by: syzkaller <syzkaller@googlegroups.com>
> Suggested-by: Martin KaFai Lau <martin.lau@linux.dev>
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>

Acked-by: Daniel Borkmann <daniel@iogearbox.net>

