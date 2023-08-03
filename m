Return-Path: <bpf+bounces-6908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D50C76F64F
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 01:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBE9E280AC4
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 23:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1094126B2A;
	Thu,  3 Aug 2023 23:54:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB88C26B0F;
	Thu,  3 Aug 2023 23:54:29 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566B23A9F;
	Thu,  3 Aug 2023 16:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=N9elADnWrm4cJ4f9oUZ36GkwYA0bwMMwg3o7Dskq/4w=; b=Z4LY9lkZ+dag5auQrZm5IzJeTv
	jwAUrr05VW2FFzjyJAM7D3VV1lzMqanZz2s1gvTeac2JuK0G/T4Zwqa89cdcY8AE+hjDQacPUB5AP
	ifWrDeJnP1XkuHg3T89xKaTOLsztJclV1viLAqjfxCiaXE57ic1BMnxPTeg8B047IfSIJWdId7wZl
	UvojykDRwvJvMoSD0WbuuFlmNOumixMypRyr089cBR6uNL2HZbMVdtLtiVUjJ3tkFuKRVZVdQAM3a
	h9sZACXjru+KNVIL13R7IN35bbj9X0sCbZPdQNYpdwXL3RCdDpP55N2f/TIiDMA1MH58isEXVVjql
	6gmbrvHA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qRi97-000ESw-Bp; Fri, 04 Aug 2023 01:54:21 +0200
Received: from [206.83.118.151] (helo=localhost.localdomain)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qRi96-000QD2-Ey; Fri, 04 Aug 2023 01:54:21 +0200
Subject: Re: [PATCH net-next] tcx: Fix splat in ingress_destroy upon
 tcx_entry_free
To: Gal Pressman <gal@nvidia.com>, kuba@kernel.org
Cc: ast@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
 syzbot+bdcf141f362ef83335cf@syzkaller.appspotmail.com,
 syzbot+b202b7208664142954fa@syzkaller.appspotmail.com,
 syzbot+14736e249bce46091c18@syzkaller.appspotmail.com
References: <20230721233330.5678-1-daniel@iogearbox.net>
 <bdfc2640-8f65-5b56-4472-db8e2b161aab@nvidia.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <96b33f76-de8e-54ce-fcef-47924d797013@iogearbox.net>
Date: Fri, 4 Aug 2023 01:54:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <bdfc2640-8f65-5b56-4472-db8e2b161aab@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26989/Thu Aug  3 09:31:03 2023)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Gal,

On 8/3/23 1:10 PM, Gal Pressman wrote:
[...]
> Our nightly regression testing picked up new memory leaks which were
> bisected to this commit.
> Unfortunately, I do not know the exact repro steps to trigger it, maybe
> the attached kmemeleak logs can help?

Is this on latest net-next? Do you have some more info on what the test
is doing? Does it trigger on qdisc cleanup only? Also, is there a way to
run the regression suite?

Thanks,
Daniel

> unreferenced object 0xffff88811ce37b80 (size 224):
>    comm "kworker/14:1", pid 7451, jiffies 4295350041 (age 64.444s)
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>      00 e0 69 29 81 88 ff ff 00 3a 39 0d 81 88 ff ff  ..i).....:9.....
>    backtrace:
>      [<00000000a0f098fe>] __alloc_skb+0x1f4/0x2b0
>      [<000000000dabee54>] alloc_skb_with_frags+0x7a/0x6c0
>      [<00000000e681c78a>] sock_alloc_send_pskb+0x63f/0x7d0
>      [<00000000a4774143>] mld_newpack.isra.0+0x1ad/0x800
>      [<0000000060e32100>] add_grhead+0x271/0x320
>      [<00000000040e7099>] add_grec+0xc8b/0x1120
>      [<000000009853483c>] mld_ifc_work+0x387/0xae0
>      [<0000000079d8299d>] process_one_work+0x86a/0x1430
>      [<000000001968010b>] worker_thread+0x5b0/0xf00
>      [<0000000090c285b0>] kthread+0x2dd/0x3b0
>      [<000000001f322d79>] ret_from_fork+0x2d/0x70
>      [<000000008ad6bd7b>] ret_from_fork_asm+0x11/0x20
> unreferenced object 0xffff888153058640 (size 224):
>    comm "softirq", pid 0, jiffies 4295350849 (age 61.212s)
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>      00 e0 69 29 81 88 ff ff c0 32 39 0d 81 88 ff ff  ..i).....29.....
>    backtrace:
>      [<00000000a0f098fe>] __alloc_skb+0x1f4/0x2b0
>      [<00000000bb2ddb4c>] ndisc_alloc_skb+0x133/0x340
>      [<0000000009614816>] ndisc_send_rs+0x1e0/0x4b0
>      [<000000004bc1b8be>] addrconf_rs_timer+0x25a/0x720
>      [<000000004d021706>] call_timer_fn+0x167/0x3d0
>      [<0000000088aa76a3>] __run_timers.part.0+0x546/0x8b0
>      [<0000000066f62ff3>] run_timer_softirq+0x6a/0x100
>      [<000000003732ddfb>] __do_softirq+0x264/0x80c
> unreferenced object 0xffff888155d0a500 (size 224):
>    comm "softirq", pid 0, jiffies 4295352832 (age 53.328s)
>    hex dump (first 32 bytes):
>      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>      00 e0 69 29 81 88 ff ff c0 32 39 0d 81 88 ff ff  ..i).....29.....
>    backtrace:
>      [<00000000a0f098fe>] __alloc_skb+0x1f4/0x2b0
>      [<00000000bb2ddb4c>] ndisc_alloc_skb+0x133/0x340
>      [<0000000009614816>] ndisc_send_rs+0x1e0/0x4b0
>      [<000000004bc1b8be>] addrconf_rs_timer+0x25a/0x720
>      [<000000004d021706>] call_timer_fn+0x167/0x3d0
>      [<0000000088aa76a3>] __run_timers.part.0+0x546/0x8b0
>      [<0000000066f62ff3>] run_timer_softirq+0x6a/0x100
>      [<000000003732ddfb>] __do_softirq+0x264/0x80c
> unreferenced object 0xffff88814e3f6040 (size 576):
>    comm "softirq", pid 0, jiffies 4295352832 (age 53.328s)
>    hex dump (first 32 bytes):
>      00 00 33 33 00 00 00 02 e8 eb d3 98 21 bc 86 dd  ..33........!...
>      60 00 00 00 00 10 3a ff fe 80 00 00 00 00 00 00  `.....:.........
>    backtrace:
>      [<00000000525ad98b>] kmalloc_reserve+0x118/0x1f0
>      [<000000008d146183>] __alloc_skb+0x105/0x2b0
>      [<00000000bb2ddb4c>] ndisc_alloc_skb+0x133/0x340
>      [<0000000009614816>] ndisc_send_rs+0x1e0/0x4b0
>      [<000000004bc1b8be>] addrconf_rs_timer+0x25a/0x720
>      [<000000004d021706>] call_timer_fn+0x167/0x3d0
>      [<0000000088aa76a3>] __run_timers.part.0+0x546/0x8b0
>      [<0000000066f62ff3>] run_timer_softirq+0x6a/0x100
>      [<000000003732ddfb>] __do_softirq+0x264/0x80c
> unreferenced object 0xffff88812acdebc0 (size 16):
>    comm "umount.nfs", pid 11626, jiffies 4295354796 (age 45.472s)
>    hex dump (first 16 bytes):
>      73 65 72 76 65 72 2d 32 00 eb cd 2a 81 88 ff ff  server-2...*....
>    backtrace:
>      [<0000000010fb5130>] __kmalloc_node_track_caller+0x4c/0x170
>      [<00000000b866a733>] kvasprintf+0xb0/0x130
>      [<00000000b3564fca>] kasprintf+0xa6/0xd0
>      [<00000000f01d6cb3>] nfs_sysfs_move_sb_to_server+0x49/0xd0
>      [<000000009608708f>] nfs_kill_super+0x5f/0x90
>      [<0000000090d4108b>] deactivate_locked_super+0x80/0x130
>      [<000000000856aeb1>] cleanup_mnt+0x258/0x370
>      [<0000000040582e39>] task_work_run+0x12c/0x210
>      [<00000000378ea041>] exit_to_user_mode_prepare+0x1a0/0x1b0
>      [<00000000025e63dd>] syscall_exit_to_user_mode+0x19/0x50
>      [<00000000f34ad3ee>] do_syscall_64+0x4a/0x90
>      [<000000009d3e2403>] entry_SYSCALL_64_after_hwframe+0x46/0xb0
> 


