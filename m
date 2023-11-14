Return-Path: <bpf+bounces-15035-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F727EA93C
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 04:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 837B01C209BC
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 03:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E768F76;
	Tue, 14 Nov 2023 03:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7656D8F45;
	Tue, 14 Nov 2023 03:53:59 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E1C1A7;
	Mon, 13 Nov 2023 19:53:57 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4STsq34j5yz4f3l8P;
	Tue, 14 Nov 2023 11:53:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 29D591A016F;
	Tue, 14 Nov 2023 11:53:54 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgC3xkZM71JlmyybAw--.8532S2;
	Tue, 14 Nov 2023 11:53:51 +0800 (CST)
Subject: Re: [bug report] BUG: KASAN: slab-use-after-free in
 sock_def_readable+0x101/0x450
From: Hou Tao <houtao@huaweicloud.com>
To: bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>
References: <edda3930-bbb7-c927-578d-c3bd51da7384@huaweicloud.com>
Message-ID: <24a82a26-41d9-2754-4966-73f6eaf6471e@huaweicloud.com>
Date: Tue, 14 Nov 2023 11:53:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <edda3930-bbb7-c927-578d-c3bd51da7384@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgC3xkZM71JlmyybAw--.8532S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw4DXr4kWryxtryDtrWUurg_yoW8Kw1fpr
	nYyFWxX3y3try0qw1ftr17KryDG3yxtr1UCrn7A3WxuF4fGr98Wa4jqr1j9rn09FZ7uryf
	Wa4DXr13JayYq3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

Hi,

On 11/13/2023 10:12 PM, Hou Tao wrote:
> Hi,
>
> I got the following kasan report when running test_progs on bpf-tree
> (commit 100888fb6d8a):
>
> [  212.183985]
> ==================================================================
> [  212.184699] BUG: KASAN: slab-use-after-free in
> sock_def_readable+0x101/0x450
> [  212.185375] Read of size 8 at addr ffff88812d9f1860 by task
> kworker/4:1/67
>
> [  212.186195] CPU: 4 PID: 67 Comm: kworker/4:1 Tainted: G          
> O       6.6.0+ #9
> [  212.186942] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [  212.188044] Workqueue: events sk_psock_backlog
> [  212.188496] Call Trace:
> [  212.188746]  <TASK>
> [  212.188967]  dump_stack_lvl+0x4a/0x90
> [  212.189342]  print_report+0xd2/0x620
> [  212.189706]  ? kasan_complete_mode_report_info+0x7c/0x210
> [  212.190241]  kasan_report+0xd1/0x110
> [  212.190599]  ? sock_def_readable+0x101/0x450
> [  212.191022]  ? sock_def_readable+0x101/0x450
> [  212.191452]  kasan_check_range+0x101/0x1c0
> [  212.191852]  __kasan_check_read+0x11/0x20
> [  212.192253]  sock_def_readable+0x101/0x450
> [  212.192656]  unix_stream_sendmsg+0x3cc/0xaa0
> [  212.193093]  ? __pfx_unix_stream_sendmsg+0x10/0x10
> [  212.193565]  ? __pfx___lock_acquire+0x10/0x10
> [  212.194034]  sock_sendmsg+0x219/0x230
> [  212.194400]  ? __pfx_sock_sendmsg+0x10/0x10
> [  212.194813]  ? lock_acquire+0x180/0x420
> [  212.195193]  ? sk_psock_backlog+0x3c/0x600
> [  212.195598]  ? __pfx_lock_acquire+0x10/0x10
> [  212.196014]  ? lock_is_held_type+0x97/0x100
> [  212.196436]  ? __asan_storeN+0x12/0x20
> [  212.196808]  __skb_send_sock+0x53b/0x660
> [  212.197204]  ? __pfx_sendmsg_unlocked+0x10/0x10
> [  212.197653]  ? sk_psock_backlog+0x3c/0x600
> [  212.198057]  ? __pfx___skb_send_sock+0x10/0x10
> [  212.198499]  ? __mutex_unlock_slowpath+0x122/0x410
> [  212.198990]  skb_send_sock+0x15/0x20

It seems I hit the send button too soon. There is already pending fixes
for the problem [1]. Please ignore the bug report.

[1]:
https://lore.kernel.org/bpf/20231016190819.81307-1-john.fastabend@gmail.com/


