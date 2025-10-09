Return-Path: <bpf+bounces-70646-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E192FBC7D6E
	for <lists+bpf@lfdr.de>; Thu, 09 Oct 2025 09:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 985804E4AA2
	for <lists+bpf@lfdr.de>; Thu,  9 Oct 2025 07:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88DF2D12E2;
	Thu,  9 Oct 2025 07:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iaFeIjlp"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86064222586
	for <bpf@vger.kernel.org>; Thu,  9 Oct 2025 07:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759996756; cv=none; b=WOuh8CB0HCRnddoJa+bh3mTdkudqpccHcXw9LcFTg6ifSPjGJSF05PshVAh6QBRgMQDeyOAKz9q8dsNgmdTbVSHqliYHDRq0e7XkQ6tI0IQa2oOStUbYTQmPFuwmdNM5F7oxQb7A/jysyQd7plwNMNC56MEledOosKpxrXYwt3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759996756; c=relaxed/simple;
	bh=DmoHCKA9QRZ6fagdRrHcExT4WkF9ThbvgfbABd/Nju0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VAMTyxnYPS2E27dLX3wqeDMWDlW+OP4XEJzUSFBSg7BOm3zMkgrccU4Qmx/SF/koL1ax/C3l1PvFhfAfmxUgDSZC9oorRB5NMQGqjcKHSUDtz10+t6BJNZsy9oQhRPrqyTym84xsrMoOn65c5f/xFheJSxh4LOjdiJ0CKix9O0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iaFeIjlp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759996753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rNvHCFmqH/PxFbRPiws/BcWGB5k9JVo7ax3HwuCgdPw=;
	b=iaFeIjlpvS4VarLGkE+p1RVMW/Zt4llj7MAq7MqMDPsBnrh8P6OZiaPPGhEoRLgveQ0DgU
	hAWCu61LNJ7ji+UxfmMAq3Jp9o/QnXVIgepeXd3bbbzhWIPK6gMwAHyDcLDBeD77oNkTQ8
	d1wGIno2lR5WsBFG4yOHTIKQh3mlijM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-_7dQ9boTO3y5a99qC5AFpw-1; Thu, 09 Oct 2025 03:59:11 -0400
X-MC-Unique: _7dQ9boTO3y5a99qC5AFpw-1
X-Mimecast-MFC-AGG-ID: _7dQ9boTO3y5a99qC5AFpw_1759996750
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ece0fd841cso691285f8f.0
        for <bpf@vger.kernel.org>; Thu, 09 Oct 2025 00:59:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759996750; x=1760601550;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rNvHCFmqH/PxFbRPiws/BcWGB5k9JVo7ax3HwuCgdPw=;
        b=KVIvBDGGK6UoFaG9fnkAqhQSQjqK37oWmvgpWCyq9gEvJG+7ddOvHUaMab/+By66Kq
         WtMpHoXEm6OBD4X/LDuHtX7hE3uckq48aiq0hJIuNdZCLDdEWMwocSpDfe7o67EYf8fv
         EslL8e1V3UNWlYWKVMd7VGTnmocIovG1ucH3tWYQkWVDcgen8waoW2iazShAulTYbOtF
         G4PTQ+YC+n7ENxAG2Z1iJCXJ+lE1OWtp3ieEaLBs1fsLqqWrhYWxDipJQU0ZbnkxwmRS
         Sts1FWNsQJ0+mgPluIzcLYhJ9kuxpZ27K9+e83ffQrndPc0U0RBX3VXjJ1k6OfyF28LF
         4LzA==
X-Forwarded-Encrypted: i=1; AJvYcCUYKF/MYyjZ+HcRC9tD6fSy5/vBDVMa0y3Jyj4N0BWbi17MWxcrQSCyca8rPyXmgqtx26s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKq5a/deomMut7t6vL6lSrgh/3ey4NE1KxwxpbAyAlmwuacMc9
	/2Nk2zcvDTV6VlofHjvmC4N3oD7r7zodDeMdvnNbqcvrMEgwxmnhFAL4LQk8Zh5MXLsVbvbof6q
	LmChMtPlgVBzJauI+GpGnICIJFzahD2b/ABby5DcrE96lrW2fFWv+XQ==
X-Gm-Gg: ASbGncvD3HgSRFy7BT0PzC9/NdQmwWcvTuZkjrFylLA2gXdrI9Yy3zQ6/+G5Uy31V6S
	WGz+1uunCLzUI43hoTaAXCSvEx6PWtNMjWlXsofrE7hrHsFRUrgQk/9yOU/ENuFuA4/1Es3dpaw
	hYqBD1Hpm8W6V4Ha8IE6AngYZ//ej3xUX1wydCdttmntXTH++IVhQsMRFQoYCGgDkkTTwpjseER
	aV09W2vo/3m12AyhV8UTMjH/FqEZWw7ZABdDD3eeeAcP84aMfkIrcOlD+U5Qn6ADKjkWbTL9tll
	nLpGBNwMbtcOe5rQed4PRXgxKyti8m0smej5DyUO8NOn4TuZAJpf5P5DScay3PSbW/xpHL80ZED
	rNxeK4hzoDK2q2CWhzA==
X-Received: by 2002:a05:6000:4014:b0:3ec:e152:e2ce with SMTP id ffacd0b85a97d-4266e7e0149mr4118841f8f.32.1759996750012;
        Thu, 09 Oct 2025 00:59:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2Ne9LNH5ThjILsmk10mm9vW/PMkSzQqs9OomnIOh7VVzCbkr8uET7wMOcyPA3GmuKzSE5nA==
X-Received: by 2002:a05:6000:4014:b0:3ec:e152:e2ce with SMTP id ffacd0b85a97d-4266e7e0149mr4118816f8f.32.1759996749610;
        Thu, 09 Oct 2025 00:59:09 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e9719sm34106869f8f.31.2025.10.09.00.59.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 00:59:09 -0700 (PDT)
Message-ID: <6ea5bc8e-5d77-4a9a-9a8d-72a8dc71ac38@redhat.com>
Date: Thu, 9 Oct 2025 09:59:07 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpf, sockmap: Update tp->rcv_nxt in sk_psock_skb_ingress
To: zhengguoyong <zhenggy@chinatelecom.cn>, john.fastabend@gmail.com,
 jakub@cloudflare.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org
References: <3b78ca04-f4b9-4d12-998d-4e21a3a8397f@chinatelecom.cn>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <3b78ca04-f4b9-4d12-998d-4e21a3a8397f@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/9/25 5:07 AM, zhengguoyong wrote:
> When using sockmap to forward TCP traffic to the application
> layer of the peer socket, the peer socket's tcp_bpf_recvmsg_parser
> processing flow will synchronously update the tp->copied_seq field.
> This causes tp->rcv_nxt to become less than tp->copied_seq.
> 
> Later, when this socket receives SKB packets from the protocol stack,
> in the call chain tcp_data_ready → tcp_epollin_ready, the function
> tcp_epollin_ready will return false, preventing the socket from being
> woken up to receive new packets.
> 
> Therefore, it is necessary to synchronously update the tp->rcv_nxt
> information in sk_psock_skb_ingress.
> 
> Signed-off-by: GuoYong Zheng <zhenggy@chinatelecom.cn>
> ---
>  net/core/skmsg.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 9becadd..e9d841c 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -576,6 +576,7 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
>  	struct sock *sk = psock->sk;
>  	struct sk_msg *msg;
>  	int err;
> +	u32 seq;
> 
>  	/* If we are receiving on the same sock skb->sk is already assigned,
>  	 * skip memory accounting and owner transition seeing it already set
> @@ -595,8 +596,15 @@ static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb,
>  	 */
>  	skb_set_owner_r(skb, sk);
>  	err = sk_psock_skb_ingress_enqueue(skb, off, len, psock, sk, msg, true);
> -	if (err < 0)
> +	if (err < 0) {
>  		kfree(msg);
> +	} else {
> +		bh_lock_sock_nested(sk);

Apparently this is triggering deadlock in our CI:

  WARNING: inconsistent lock state
  6.17.0-gb9bdadc5b6ca-dirty #8 Tainted: G           OE
  --------------------------------
  inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
  kworker/1:36/3777 [HC0[0]:SC0[0]:HE1:SE1] takes:
  00000000b80163e8 (slock-AF_INET/1){+.?.}-{2:2}, at:
sk_psock_backlog+0x656/0xf18
  {IN-SOFTIRQ-W} state was registered at:
    __lock_acquire+0x4dc/0xd58
    lock_acquire.part.0+0x114/0x278
    lock_acquire+0x9c/0x160
    _raw_spin_lock_nested+0x58/0xa8
    tcp_v4_rcv+0x23a0/0x32a8
    ip_protocol_deliver_rcu+0x6c/0x418
    ip_local_deliver_finish+0x364/0x5d0
    ip_local_deliver+0x17a/0x3f8
    ip_rcv+0xd6/0x318
    __netif_receive_skb_one_core+0x11c/0x158
    process_backlog+0x58c/0x1618
    __napi_poll+0x86/0x488
    net_rx_action+0x482/0xb08
    handle_softirqs+0x3cc/0xc88
    do_softirq+0x1fc/0x248
    __local_bh_enable_ip+0x332/0x3a0
    __dev_queue_xmit+0x90a/0x1738
    neigh_resolve_output+0x4c4/0x848
    ip_finish_output2+0x728/0x1bc8
    ip_output+0x1ea/0x5d0
    __ip_queue_xmit+0x71a/0x1088
    __tcp_transmit_skb+0x118c/0x2470
    tcp_connect+0x10ca/0x18b8
    tcp_v4_connect+0x11cc/0x1788
    __inet_stream_connect+0x324/0xc00
    inet_stream_connect+0x70/0xb8
    __sys_connect+0xea/0x148
    __do_sys_socketcall+0x2b4/0x4c0
    __do_syscall+0x138/0x3e0
    system_call+0x6e/0x90
  irq event stamp: 531707
  hardirqs last  enabled at (531707): [<0008bdf65ac55ad2>]
__local_bh_enable_ip+0x23a/0x3a0
  hardirqs last disabled at (531705): [<0008bdf65ac55b6a>]
__local_bh_enable_ip+0x2d2/0x3a0
  softirqs last  enabled at (531706): [<0008bdf65c31f142>]
sk_psock_skb_ingress_enqueue+0x2aa/0x468
  softirqs last disabled at (531704): [<0008bdf65c31f112>]
sk_psock_skb_ingress_enqueue+0x27a/0x468

  other info that might help us debug this:
   Possible unsafe locking scenario:

         CPU0
         ----
    lock(slock-AF_INET/1);
    <Interrupt>
      lock(slock-AF_INET/1);

   *** DEADLOCK ***

  3 locks held by kworker/1:36/3777:
   #0: 0000000080042158 ((wq_completion)events){+.+.}-{0:0}, at:
process_one_work+0x766/0x15e0
   #1: 0008bd765cbffba8
((work_completion)(&(&psock->work)->work)){+.+.}-{0:0}, at:
process_one_work+0x794/0x15e0
   #2: 000000008eb583c8 (&psock->work_mutex){+.+.}-{3:3}, at:
sk_psock_backlog+0x198/0xf18

  stack backtrace:
  CPU: 1 UID: 0 PID: 3777 Comm: kworker/1:36 Tainted: G           OE
  6.17.0-gb9bdadc5b6ca-dirty #8 NONE
  Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
  Hardware name: IBM 8561 LT1 400 (KVM/Linux)
  Workqueue: events sk_psock_backlog
  Call Trace:
   [<0008bdf65aaca9de>] dump_stack_lvl+0x106/0x168
   [<0008bdf65adb5990>] print_usage_bug.part.0+0x2e8/0x398
   [<0008bdf65adb616a>] mark_lock_irq+0x72a/0x9c0
   [<0008bdf65adb670e>] mark_lock+0x30e/0x7c0
   [<0008bdf65adb6f38>] mark_usage+0xc8/0x178
   [<0008bdf65adb819c>] __lock_acquire+0x4dc/0xd58
   [<0008bdf65adb8b2c>] lock_acquire.part.0+0x114/0x278
   [<0008bdf65adb8d2c>] lock_acquire+0x9c/0x160
   [<0008bdf65cbc6498>] _raw_spin_lock_nested+0x58/0xa8
   [<0008bdf65c323716>] sk_psock_backlog+0x656/0xf18
   [<0008bdf65ac9b236>] process_one_work+0x83e/0x15e0
   [<0008bdf65ac9c790>] worker_thread+0x7b8/0x1020
   [<0008bdf65acbb0f8>] kthread+0x3c0/0x6e8
   [<0008bdf65aad02f4>] __ret_from_fork+0xdc/0x800
   [<0008bdf65cbc7fd2>] ret_from_fork+0xa/0x30
  INFO: lockdep is turned off.

More details at:

https://github.com/kernel-patches/bpf/actions/runs/18367014116/job/52322106520

/P


