Return-Path: <bpf+bounces-45085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DE79D0FDB
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 12:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7353F1F22EE6
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 11:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99E61991CF;
	Mon, 18 Nov 2024 11:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G7eNNTmO"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E57194A68
	for <bpf@vger.kernel.org>; Mon, 18 Nov 2024 11:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731929918; cv=none; b=CoqkQVQlMLAzFMpAF/4o5+It81ieew4I19g6Tu8xpWi+oaUxoAYj9vM7eUMI0CXemuadh80nAPZ7dATbsFGteLBC6fLZuj8VBlfMGPvLUt9q/RtxuHCy4Ev8J4AjKLz+vYWEaR30h+IFnmitZqIVNU6SiK8MoS1sRBWNGXprbsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731929918; c=relaxed/simple;
	bh=8gdflFgjNrJ0YOs0tfdGdr2zUIj1LGSP9Jx3xu2/Z2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NWYQ4rwxyZef2XHyJ8Balcau900RKxHs7nJ8x5pYsSGl+0veVJ+Zb6BGlaZJTrMZ2p8K9dfLEGbzzQKJL+hPTGh5fL1DG1oQVfC/CDbN8RktV5UUl+mzaM3xSJhLKdqLX9A3I1oKEaxODg9Tb7dW46LOEyI2K51hlN8M/o5riA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G7eNNTmO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731929915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gw5bD5S7SVN4RsLiLhtGKlhV9ZJYhsd8Se2piSJ4RY4=;
	b=G7eNNTmONSsOBetjlaO3+jnqUiOrAfSRoIytetmx9LIsBeYAxO2vazaaIJ1PX7/DRVWUkd
	uYen3Pf735k41L/Bcy4UhgzGa7Yz3aFMZN7Lf79DpD2Xl3oph7X4meo7tPaENz5zjI1Wxo
	rbgP6LHMbkFgPu93MH8+f43FncMYCoE=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-y2sZwYLCNpWLYmmJ7uB_Qw-1; Mon, 18 Nov 2024 06:38:34 -0500
X-MC-Unique: y2sZwYLCNpWLYmmJ7uB_Qw-1
X-Mimecast-MFC-AGG-ID: y2sZwYLCNpWLYmmJ7uB_Qw
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e381c19246fso5859279276.3
        for <bpf@vger.kernel.org>; Mon, 18 Nov 2024 03:38:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731929913; x=1732534713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gw5bD5S7SVN4RsLiLhtGKlhV9ZJYhsd8Se2piSJ4RY4=;
        b=jxXSnGQq2ZRe27b2QYko9Wymr17AwSOxn0MknigtfO1KOvw1/7DkTz/6kUNaybnUGK
         5kSzXgTjHQt57n3RJNKPSNfADTxBelT8HfK1NSZiNtm/uEI6YMMkACZMF8ElgxhyDJgF
         +V3WAHZzjwmk8POMVt2gf0unrRE+32fjxtWDfGjP6qwn9NkBZywexYX11Sb1CjUwXkZP
         NSzlaQLNat2Ms32OsDXzVMOgjSQig24fut2Ns5VTWDTqSieda+ahS0h8tojGehXKB21t
         +N9C0q+2fOs4cGAcOwXxkTavLxYUr8/CxHmRWBRUiNaE32ORqfqHFUi6ofCL/s2gwZHE
         fwcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvP1Fa9oDEBMqtsjIDgJlA05pVrqyCSeAHJY4yuaMnm5hDrWbbG/zoIhPyPpFOAugyMIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaX/zyZ6wrLzdKv9K9zHcsJY3ZBT+WkvQqO5L/1s24YZmuQuv5
	PKd2jku6J/BWuF5T4LsEEgYCQq4ztCqP1N3pJBsO2LMkklPVi6FYsMKUIEKNe8dYYtBgCIDOZ/n
	QE48c/IWYmYG645Qv23guwr/zsfiixTrdv+ft/W60MD6AbGj3Dg==
X-Received: by 2002:a05:6902:1109:b0:e38:a15d:409d with SMTP id 3f1490d57ef6-e38a15d4424mr2161032276.13.1731929913530;
        Mon, 18 Nov 2024 03:38:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGQnbgCNr3UNGZv40fiiuJH5q+gMcuQO3YMFlFbx+8I0jqkmXUewKgQYLeMIrdZYVymoVOu/g==
X-Received: by 2002:a05:6902:1109:b0:e38:a15d:409d with SMTP id 3f1490d57ef6-e38a15d4424mr2161024276.13.1731929913163;
        Mon, 18 Nov 2024 03:38:33 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d40da59a8dsm34584006d6.0.2024.11.18.03.38.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 03:38:32 -0800 (PST)
Message-ID: <f95ec5a6-72c5-4c99-91b9-8317ca5d7207@redhat.com>
Date: Mon, 18 Nov 2024 12:38:28 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ip: fix unexpected return in
 fib_validate_source()
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Menglong Dong <dongml2@chinatelecom.cn>,
 syzbot+52fbd90f020788ec7709@syzkaller.appspotmail.com
References: <20241118091427.2164345-1-dongml2@chinatelecom.cn>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241118091427.2164345-1-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/24 10:14, Menglong Dong wrote:
> The errno should be replaced with drop reasons in fib_validate_source(),
> and the "-EINVAL" shouldn't be returned. And this causes a warning, which
> is reported by syzkaller:
> 
> netlink: 'syz-executor371': attribute type 4 has an invalid length.
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 5842 at net/core/skbuff.c:1219 __sk_skb_reason_drop net/core/skbuff.c:1216 [inline]
> WARNING: CPU: 0 PID: 5842 at net/core/skbuff.c:1219 sk_skb_reason_drop+0x87/0x380 net/core/skbuff.c:1241
> Modules linked in:
> CPU: 0 UID: 0 PID: 5842 Comm: syz-executor371 Not tainted 6.12.0-rc6-syzkaller-01362-ga58f00ed24b8 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
> RIP: 0010:__sk_skb_reason_drop net/core/skbuff.c:1216 [inline]
> RIP: 0010:sk_skb_reason_drop+0x87/0x380 net/core/skbuff.c:1241
> Code: 00 00 00 fc ff df 41 8d 9e 00 00 fc ff bf 01 00 fc ff 89 de e8 ea 9f 08 f8 81 fb 00 00 fc ff 77 3a 4c 89 e5 e8 9a 9b 08 f8 90 <0f> 0b 90 eb 5e bf 01 00 00 00 89 ee e8 c8 9f 08 f8 85 ed 0f 8e 49
> RSP: 0018:ffffc90003d57078 EFLAGS: 00010293
> RAX: ffffffff898c3ec6 RBX: 00000000fffbffea RCX: ffff8880347a5a00
> RDX: 0000000000000000 RSI: 00000000fffbffea RDI: 00000000fffc0001
> RBP: dffffc0000000000 R08: ffffffff898c3eb6 R09: 1ffff110023eb7d4
> R10: dffffc0000000000 R11: ffffed10023eb7d5 R12: dffffc0000000000
> R13: ffff888011f5bdc0 R14: 00000000ffffffea R15: 0000000000000000
> FS:  000055557d41e380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000056519d31d608 CR3: 000000007854e000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  kfree_skb_reason include/linux/skbuff.h:1263 [inline]
>  ip_rcv_finish_core+0xfde/0x1b50 net/ipv4/ip_input.c:424
>  ip_list_rcv_finish net/ipv4/ip_input.c:610 [inline]
>  ip_sublist_rcv+0x3b1/0xab0 net/ipv4/ip_input.c:636
>  ip_list_rcv+0x42b/0x480 net/ipv4/ip_input.c:670
>  __netif_receive_skb_list_ptype net/core/dev.c:5715 [inline]
>  __netif_receive_skb_list_core+0x94e/0x980 net/core/dev.c:5762
>  __netif_receive_skb_list net/core/dev.c:5814 [inline]
>  netif_receive_skb_list_internal+0xa51/0xe30 net/core/dev.c:5905
>  netif_receive_skb_list+0x55/0x4b0 net/core/dev.c:5957
>  xdp_recv_frames net/bpf/test_run.c:280 [inline]
>  xdp_test_run_batch net/bpf/test_run.c:361 [inline]
>  bpf_test_run_xdp_live+0x1b5e/0x21b0 net/bpf/test_run.c:390
>  bpf_prog_test_run_xdp+0x805/0x11e0 net/bpf/test_run.c:1318
>  bpf_prog_test_run+0x2e4/0x360 kernel/bpf/syscall.c:4266
>  __sys_bpf+0x48d/0x810 kernel/bpf/syscall.c:5671
>  __do_sys_bpf kernel/bpf/syscall.c:5760 [inline]
>  __se_sys_bpf kernel/bpf/syscall.c:5758 [inline]
>  __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5758
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f18af25a8e9
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffee4090af8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f18af25a8e9
> RDX: 0000000000000048 RSI: 0000000020000600 RDI: 000000000000000a
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> 
> Fix it by returning "-SKB_DROP_REASON_IP_LOCAL_SOURCE" instead of
> "-EINVAL" in fib_validate_source().
> 
> Reported-by: syzbot+52fbd90f020788ec7709@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6738e539.050a0220.e1c64.0002.GAE@google.com/
> Fixes: 82d9983ebeb8 ("net: ip: make ip_route_input_noref() return drop reasons")
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>

Thanks for the quick turnaround!

Acked-by: Paolo Abeni <pabeni@redhat.com>


