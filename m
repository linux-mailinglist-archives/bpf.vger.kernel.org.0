Return-Path: <bpf+bounces-73352-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1F2C2C38A
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 14:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0930D4EE23C
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 13:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555C630DD14;
	Mon,  3 Nov 2025 13:39:59 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA93230DED4;
	Mon,  3 Nov 2025 13:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762177198; cv=none; b=qfVgpZ0vn/PpBlG8+mDk2O/AFwXpNr9KumtLqWcMQ3UDExH+JF2YL5hXOKPjxI9rH4pQjNBvxqKD3n/MliHLEYkuqwqmijZBj+YCV8xXPeB7/SDLnXHAnlhsEZVJyDWenAobt0GcB1zaHGjYeEwsAOFYbU7oEL2TtFvBFD5IUII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762177198; c=relaxed/simple;
	bh=vZQQeXvsMwwdNR+QwClddEdli/wv3INn7ueWC38q2kI=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=CVMmhnaKuyrdy7swb3bakztKGbnuY5aCLxNnj6eGB2LvmmghwSVDLP5TN4Q20QF+5pK+sqevrceoZugBohk4YvTbiATjrV6Lwt6zTJTSGqYstfKoT5n+b/i4Lsy8gfJ+zawOCk5JDtKczRZKInVXLAIyRVHGKiEeToIT0eCH8FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 5A3Ddluc028933;
	Mon, 3 Nov 2025 22:39:47 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 5A3DdlFB028930
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 3 Nov 2025 22:39:47 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <8b470fda-515e-4ca8-89d4-3dcd7088f58b@I-love.SAKURA.ne.jp>
Date: Mon, 3 Nov 2025 22:39:45 +0900
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: unregister_netdevice: waiting for lo to become free. Usage count =
 6659
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav403.rs.sakura.ne.jp

Hello.

A syzbot report at 2025/11/03 12:00 in
https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84 showed
a huge refcount leak. The kernel commit is v6.18-rc4 of linux.git tree.
When is this refcount supposed to be released?

unregister_netdevice: waiting for lo to become free. Usage count = 6659
ref_tracker: netdev@ffff88805f84a618 has 6658/6658 users at
     __netdev_tracker_alloc include/linux/netdevice.h:4375 [inline]
     netdev_hold include/linux/netdevice.h:4404 [inline]
     dst_init+0xda/0x580 net/core/dst.c:52
     dst_alloc+0xbb/0x1a0 net/core/dst.c:93
     rt_dst_alloc+0x35/0x3a0 net/ipv4/route.c:1646
     ip_route_input_slow+0x16cb/0x3fa0 net/ipv4/route.c:2424
     ip_route_input_rcu net/ipv4/route.c:2538 [inline]
     ip_route_input_noref+0x120/0x2e0 net/ipv4/route.c:2549
     ip_rcv_finish_core+0x46f/0x2290 net/ipv4/ip_input.c:368
     ip_list_rcv_finish+0x1b8/0x780 net/ipv4/ip_input.c:619
     ip_sublist_rcv net/ipv4/ip_input.c:644 [inline]
     ip_list_rcv+0x335/0x450 net/ipv4/ip_input.c:678
     __netif_receive_skb_list_ptype net/core/dev.c:6122 [inline]
     __netif_receive_skb_list_core+0x752/0x950 net/core/dev.c:6169
     __netif_receive_skb_list net/core/dev.c:6221 [inline]
     netif_receive_skb_list_internal+0x75f/0xdc0 net/core/dev.c:6312
     netif_receive_skb_list net/core/dev.c:6364 [inline]
     netif_receive_skb_list+0x4d/0x4b0 net/core/dev.c:6354
     xdp_recv_frames net/bpf/test_run.c:269 [inline]
     xdp_test_run_batch.constprop.0+0x146b/0x1ad0 net/bpf/test_run.c:350
     bpf_test_run_xdp_live+0x365/0x770 net/bpf/test_run.c:379
     bpf_prog_test_run_xdp+0xd38/0x1660 net/bpf/test_run.c:1320
     bpf_prog_test_run kernel/bpf/syscall.c:4688 [inline]
     __sys_bpf+0x1035/0x4980 kernel/bpf/syscall.c:6167
     __do_sys_bpf kernel/bpf/syscall.c:6259 [inline]
     __se_sys_bpf kernel/bpf/syscall.c:6257 [inline]
     __ia32_sys_bpf+0x76/0xe0 kernel/bpf/syscall.c:6257

