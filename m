Return-Path: <bpf+bounces-38439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0DF964DC7
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 20:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3F701F2230B
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 18:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CAF1B9B2B;
	Thu, 29 Aug 2024 18:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jzohJklw"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD341B8E82
	for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 18:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724956613; cv=none; b=W/ySQ6BqvbdF5+DXd54cVPtS3UCp2LskOOPnVcL/5M6IVH/Ba5AMSkhNx/x3wThO5E95DnvWKiUMwtK+c9LT4sk/6denpb60bVSjx5qUjJpsg/sbL/vjonIND/bSuXbMsz2fSdkhMr4Zy6G+DSy7mkhj5XCZOihcxD/li0QiTzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724956613; c=relaxed/simple;
	bh=UG5Iz04w+jmc9PEZj5ckMSLR1y1w55Zb/fhYhq0ly30=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sGU3LNpVd6YavpfR1P1Z2arDiDVKIPuhc1FZZFqxRkgU4HWPfZyngSYcJGNP9d5H0ht77MYzk7usJceDsmjTFdUgFs+SsxuIz/ppb+aouDbDZrLpcR+K1t8RQQRUKdwQaGBU6ugdaJc4XBmqgNOgA9MUD3bD3TrQzPzj0i5V6/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jzohJklw; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3864f6ed-deb5-4dc8-b351-53ba9dcb18bc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724956609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lv1dzFKxvInUi+QXVnM3dkpGcjD6bo+MpA58P4puN4U=;
	b=jzohJklwUSV76+jjq0I5g5oJ0ktSoamn1w0ACIVXNQSAINg6nfXn1G0m+u2AlQTcOxtLdW
	IIBbHbUMkdB8IvPVClI0bbSATZb/SRRYtsQSElIdjA/Y9sgocDw93AywrrC40PfM6yRXX9
	+c8QexpvdeC7/JfmXDFWqnqWtlyIVkg=
Date: Thu, 29 Aug 2024 11:36:41 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Patch bpf] tcp_bpf: fix return value of tcp_bpf_sendmsg()
To: Cong Wang <xiyou.wangcong@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 Cong Wang <cong.wang@bytedance.com>,
 John Fastabend <john.fastabend@gmail.com>, Simon Horman <horms@kernel.org>,
 syzbot+58c03971700330ce14d8@syzkaller.appspotmail.com,
 Jakub Sitnicki <jakub@cloudflare.com>
References: <20240821030744.320934-1-xiyou.wangcong@gmail.com>
 <20240821145533.GA2164@kernel.org> <ZsaLFVB0HyQfXBXy@pop-os.localdomain>
 <66c7a37fd0270_1b1420837@john.notmuch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <66c7a37fd0270_1b1420837@john.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/22/24 1:45 PM, John Fastabend wrote:
> Cong Wang wrote:
>> On Wed, Aug 21, 2024 at 03:55:33PM +0100, Simon Horman wrote:
>>> On Tue, Aug 20, 2024 at 08:07:44PM -0700, Cong Wang wrote:
>>>> From: Cong Wang <cong.wang@bytedance.com>
>>>>
>>>> When we cork messages in psock->cork, the last message triggers the
>>>> flushing will result in sending a sk_msg larger than the current
>>>> message size. In this case, in tcp_bpf_send_verdict(), 'copied' becomes
>>>> negative at least in the following case:
>>>>
>>>> 468         case __SK_DROP:
>>>> 469         default:
>>>> 470                 sk_msg_free_partial(sk, msg, tosend);
>>>> 471                 sk_msg_apply_bytes(psock, tosend);
>>>> 472                 *copied -= (tosend + delta); // <==== HERE
>>>> 473                 return -EACCES;
>>>>
>>>> Therefore, it could lead to the following BUG with a proper value of
>>>> 'copied' (thanks to syzbot). We should not use negative 'copied' as a
>>>> return value here.
>>>>
>>>>    ------------[ cut here ]------------
>>>>    kernel BUG at net/socket.c:733!
>>>>    Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
>>>>    Modules linked in:
>>>>    CPU: 0 UID: 0 PID: 3265 Comm: syz-executor510 Not tainted 6.11.0-rc3-syzkaller-00060-gd07b43284ab3 #0
>>>>    Hardware name: linux,dummy-virt (DT)
>>>>    pstate: 61400009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
>>>>    pc : sock_sendmsg_nosec net/socket.c:733 [inline]
>>>>    pc : sock_sendmsg_nosec net/socket.c:728 [inline]
>>>>    pc : __sock_sendmsg+0x5c/0x60 net/socket.c:745
>>>>    lr : sock_sendmsg_nosec net/socket.c:730 [inline]
>>>>    lr : __sock_sendmsg+0x54/0x60 net/socket.c:745
>>>>    sp : ffff800088ea3b30
>>>>    x29: ffff800088ea3b30 x28: fbf00000062bc900 x27: 0000000000000000
>>>>    x26: ffff800088ea3bc0 x25: ffff800088ea3bc0 x24: 0000000000000000
>>>>    x23: f9f00000048dc000 x22: 0000000000000000 x21: ffff800088ea3d90
>>>>    x20: f9f00000048dc000 x19: ffff800088ea3d90 x18: 0000000000000001
>>>>    x17: 0000000000000000 x16: 0000000000000000 x15: 000000002002ffaf
>>>>    x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
>>>>    x11: 0000000000000000 x10: ffff8000815849c0 x9 : ffff8000815b49c0
>>>>    x8 : 0000000000000000 x7 : 000000000000003f x6 : 0000000000000000
>>>>    x5 : 00000000000007e0 x4 : fff07ffffd239000 x3 : fbf00000062bc900
>>>>    x2 : 0000000000000000 x1 : 0000000000000000 x0 : 00000000fffffdef
>>>>    Call trace:
>>>>     sock_sendmsg_nosec net/socket.c:733 [inline]
>>>>     __sock_sendmsg+0x5c/0x60 net/socket.c:745
>>>>     ____sys_sendmsg+0x274/0x2ac net/socket.c:2597
>>>>     ___sys_sendmsg+0xac/0x100 net/socket.c:2651
>>>>     __sys_sendmsg+0x84/0xe0 net/socket.c:2680
>>>>     __do_sys_sendmsg net/socket.c:2689 [inline]
>>>>     __se_sys_sendmsg net/socket.c:2687 [inline]
>>>>     __arm64_sys_sendmsg+0x24/0x30 net/socket.c:2687
>>>>     __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>>>>     invoke_syscall+0x48/0x110 arch/arm64/kernel/syscall.c:49
>>>>     el0_svc_common.constprop.0+0x40/0xe0 arch/arm64/kernel/syscall.c:132
>>>>     do_el0_svc+0x1c/0x28 arch/arm64/kernel/syscall.c:151
>>>>     el0_svc+0x34/0xec arch/arm64/kernel/entry-common.c:712
>>>>     el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:730
>>>>     el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:598
>>>>    Code: f9404463 d63f0060 3108441f 54fffe81 (d4210000)
>>>>    ---[ end trace 0000000000000000 ]---
>>>>
>>>> Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
>>>> Reported-by: syzbot+58c03971700330ce14d8@syzkaller.appspotmail.com
>>>> Cc: John Fastabend <john.fastabend@gmail.com>
>>>> Cc: Jakub Sitnicki <jakub@cloudflare.com>
>>>> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
>>>> ---
>>>>   net/ipv4/tcp_bpf.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
>>>> index 53b0d62fd2c2..fe6178715ba0 100644
>>>> --- a/net/ipv4/tcp_bpf.c
>>>> +++ b/net/ipv4/tcp_bpf.c
>>>> @@ -577,7 +577,7 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
>>>>   		err = sk_stream_error(sk, msg->msg_flags, err);
>>>>   	release_sock(sk);
>>>>   	sk_psock_put(sk, psock);
>>>> -	return copied ? copied : err;
>>>> +	return copied > 0 ? copied : err;
>>>
>>> Does it make more sense to make the condition err:
>>> is err 0 iif everything is ok? (completely untested!)
>>
>> Mind to elaborate?
>>
>>  From my point of view, 'copied' is to handle partial transmission, for
>> example:
>>
>> 0. User wants to send 2 * 1K bytes with sendmsg()
>> 1. Kernel already sent the first 1K successfully
>> 2. Kernel got some error when sending the 2nd 1K
>>
>> In this scenario, we should return 1K instead of the error to the caller to
>> indicate this partial transmission situation, otherwise we could not
>> distinguish it with a compete failure (that is, 0 byte sent).
> 
> Yep, if we don't return the positive value on partial send we will confuse
> apps and they will probably resent data.
> 
>  From my side this looks good.
> 
> Reviewed-by: John Fastabend <john.fastabend@gmail.com>

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>

Jakub, can you directly land it to the net tree?


