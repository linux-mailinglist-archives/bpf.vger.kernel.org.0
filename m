Return-Path: <bpf+bounces-30019-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7C88C9880
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 05:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 365821F22586
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 03:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BCE12B73;
	Mon, 20 May 2024 03:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R6rxEuxy"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4CBF9FE
	for <bpf@vger.kernel.org>; Mon, 20 May 2024 03:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716176499; cv=none; b=cyaDwP6swF7zsA/TQjLWzWt4sojLXoEJIG5eGIxqxI9+fb7cfucfh1lizhfjC+EDaoooNlea9AevS5K22zGq+w8EuaZD13cWtT7ZhJWWTR7rqfB5U6moN+jJr20YTO6EdZfjAZcv0uYPM2tb3iAhC+dQoOhqRRIE6fEXXwPS3mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716176499; c=relaxed/simple;
	bh=58hXNC4mMLbn4FZL/nucZBkX5raEBPaBt9hpU97VHzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LYe6MnsWbe43RLuts7gIRNxUHI2TxkL92l1ohKGwZB3VLIrvfl/F8Nr0kdpvyId/J9X8GqyaRhdQULC0y7xJ7VYDMEzdpStqn8JwmPilx+IA3tDHZWzMdfWu/Mq3a/5u4MoVl3hXF2LP8HBZ0wCub54qK0p/ZpaI3vTJOjVkkpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R6rxEuxy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716176496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=p/bQvjIWsA9UOtJxjtZ9UofQNPMeAF67h3q2PgjKYn4=;
	b=R6rxEuxyuAv7XtZZwKUm9JrberbDceN84qwh7+TgIufWIdFm/VdDt70XlL5OBMXlsHx9xx
	7Y03ipYFgl5io190KOFnBTmXj6WrCtN+v7Co4hi6Pt1yFWsdBH0EFgUxL7N31vc1fui2zD
	OfEZvWs1u6b3Vw6Iv6As9J869y41BK4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-hel1pjmoNCO2YIkuSszUmw-1; Sun,
 19 May 2024 23:41:31 -0400
X-MC-Unique: hel1pjmoNCO2YIkuSszUmw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1B0D829AA38D;
	Mon, 20 May 2024 03:41:30 +0000 (UTC)
Received: from localhost (unknown [10.72.116.65])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 21FDF202701E;
	Mon, 20 May 2024 03:41:28 +0000 (UTC)
Date: Mon, 20 May 2024 11:41:24 +0800
From: Baoquan He <bhe@redhat.com>
To: Yuntao Wang <ytcoode@gmail.com>
Cc: pengfei.xu@intel.com, akpm@linux-foundation.org, andrii@kernel.org,
	ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
	eddyz87@gmail.com, haoluo@google.com, john.fastabend@gmail.com,
	jolsa@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org,
	martin.lau@linux.dev, sdf@google.com, song@kernel.org,
	syzbot+a7f061d2d16154538c58@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] possible deadlock in get_page_from_freelist
Message-ID: <ZkrGZOoUlitbwkvj@MiWiFi-R3L-srv>
References: <ZkcD9H0P8O7Me5Do@xpf.sh.intel.com>
 <20240518054026.11403-1-ytcoode@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240518054026.11403-1-ytcoode@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On 05/18/24 at 01:40pm, Yuntao Wang wrote:
> On Fri, 17 May 2024 15:15:00 +0800, Pengfei Xu <pengfei.xu@intel.com> wrote:
> 
> > Hi Yuntao,
> > 
> > Greeting!
> > 
> > On 2024-04-14 at 19:28:16 -0700, syzbot wrote:
> > > Hello,
> > > 
> > > syzbot found the following issue on:
> > > 
> > > HEAD commit:    7efd0a74039f Merge tag 'ata-6.9-rc4' of git://git.kernel.o..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=1358aeed180000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=285be8dd6baeb438
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=a7f061d2d16154538c58
> > > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> > > 
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > > 
> > 
> > I used syzkaller and could reproduce the similar issue "WARNING in
> > get_page_from_freelist" in v6.9 mainline kernel.
> > 
> > Bisected and found first bad commit:
> > "
> > 816d334afa85 kexec: modify the meaning of the end parameter in kimage_is_destination_range()
> > "
> > Revert above commit on top of v6.9 kernel this issue was gone.
> 
> Hi Pengfei,
> 
> I reviewed this commit multiple times, but I still couldn't figure out why this
> commit would cause this issue. Could someone else please take a look? Thank you
> very much!

I haven't got the root cause either. 

From the log and code reading, it's using kexec_load to load kernel
for kexec rebooting. And the loading is being done when 2G memory is
being exhausted. Currently, the kexec_load will load memory at the top
of system RAM, near 2G. The left free memory should scatter in all
over the system RAM. While, seems the allocated page via
kimage_alloc_pages() are mostly destination pages, or the
kimage_is_destination_range() function incorrectly, then the while loop
will last very long and cost many pages, then causing the deadlock.

I will read code again when I am in very clear headed state.

> 
> > All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/240517_085953_get_page_from_freelist
> > mount_*.gz are in above link.
> > Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/240517_085953_get_page_from_freelist/rep.c
> > Syzkaller syscall repro steps: https://github.com/xupengfe/syzkaller_logs/blob/main/240517_085953_get_page_from_freelist/repro.prog
> > Syzkaller report: https://github.com/xupengfe/syzkaller_logs/blob/main/240517_085953_get_page_from_freelist/repro.report
> > Kconfig(make olddefconfig): https://github.com/xupengfe/syzkaller_logs/blob/main/240517_085953_get_page_from_freelist/kconfig_origin
> > Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/240517_085953_get_page_from_freelist/bisect_info.log
> > v6.9 dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/240517_085953_get_page_from_freelist/a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6_dmesg.log
> > v6.9 bzImage: https://github.com/xupengfe/syzkaller_logs/raw/main/240517_085953_get_page_from_freelist/bzImage_a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6.tar.gz
> > 
> > [   17.436013] loop0: detected capacity change from 0 to 1024
> > [   17.456160] I/O error, dev loop0, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
> > [   17.456746] loop0: detected capacity change from 0 to 1024
> > [   17.456809] I/O error, dev loop0, sector 16 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
> > [   17.457548] EXT4-fs: Invalid want_extra_isize 0
> > [   17.575984] repro: page allocation failure: order:1, mode:0x10cc0(GFP_KERNEL|__GFP_NORETRY), nodemask=(null),cpuset=/,mems_allowed=0
> > [   17.576621] CPU: 1 PID: 726 Comm: repro Not tainted 6.9.0-a38297e3fb01+ #1
> > [   17.576930] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > [   17.577412] Call Trace:
> > [   17.577526]  <TASK>
> > [   17.577626]  dump_stack_lvl+0x121/0x150
> > [   17.577813]  dump_stack+0x19/0x20
> > [   17.577969]  warn_alloc+0x218/0x350
> > [   17.578133]  ? __pfx_warn_alloc+0x10/0x10
> > [   17.578317]  ? __alloc_pages_direct_compact+0x130/0xa00
> > [   17.578552]  ? __pfx___alloc_pages_direct_compact+0x10/0x10
> > [   17.578803]  ? __drain_all_pages+0x27b/0x480
> > [   17.579021]  __alloc_pages_slowpath.constprop.0+0x1b62/0x2160
> > [   17.579291]  ? __pfx___alloc_pages_slowpath.constprop.0+0x10/0x10
> > [   17.579569]  ? __pfx_get_page_from_freelist+0x10/0x10
> > [   17.579802]  ? prepare_alloc_pages.constprop.0+0x15b/0x4f0
> > [   17.580032]  __alloc_pages+0x48f/0x580
> > [   17.580212]  ? __pfx___alloc_pages+0x10/0x10
> > [   17.580392]  ? kasan_save_stack+0x40/0x60
> > [   17.580583]  ? kasan_save_stack+0x2c/0x60
> > [   17.580772]  ? kasan_save_track+0x18/0x40
> > [   17.580946]  ? _find_first_bit+0x95/0xc0
> > [   17.581114]  ? policy_nodemask+0xf9/0x450
> > [   17.581300]  alloc_pages_mpol+0x296/0x590
> > [   17.581487]  ? __pfx_alloc_pages_mpol+0x10/0x10
> > [   17.581695]  ? arch_kexec_post_alloc_pages+0x37/0x70
> > [   17.581924]  ? __pfx_write_comp_data+0x10/0x10
> > [   17.582133]  alloc_pages+0x13f/0x160
> > [   17.582302]  kimage_alloc_pages+0x79/0x240
> > [   17.582498]  kimage_alloc_control_pages+0x1cb/0xa60
> > [   17.582727]  ? __pfx_kimage_alloc_control_pages+0x10/0x10
> > [   17.582973]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
> > [   17.583224]  do_kexec_load+0x337/0x750
> > [   17.583406]  __x64_sys_kexec_load+0x1cc/0x240
> > [   17.583619]  x64_sys_call+0x1aa2/0x20c0
> > [   17.583807]  do_syscall_64+0x6f/0x150
> > [   17.583988]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [   17.584217] RIP: 0033:0x7f4f2ec3ee5d
> > [   17.584382] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 93 af 1b 00 f7 d8 64 89 01 48
> > [   17.585171] RSP: 002b:00007ffd101da888 EFLAGS: 00000246 ORIG_RAX: 00000000000000f6
> > [   17.585500] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f4f2ec3ee5d
> > [   17.585985] RDX: 00000000200003c0 RSI: 0000000000000002 RDI: 0000000000000000
> > [   17.586346] RBP: 00007ffd101da8a0 R08: 0000000000000800 R09: 0000000000000800
> > [   17.586656] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd101da9b8
> > [   17.587001] R13: 0000000000402862 R14: 0000000000412e08 R15: 00007f4f2ef30000
> > [   17.587381]  </TASK>
> > [   17.587559] Mem-Info:
> > [   17.587667] active_anon:117 inactive_anon:14235 isolated_anon:0
> > [   17.587667]  active_file:25278 inactive_file:25394 isolated_file:0
> > [   17.587667]  unevictable:0 dirty:82 writeback:189
> > [   17.587667]  slab_reclaimable:14774 slab_unreclaimable:23678
> > [   17.587667]  mapped:13500 shmem:1187 pagetables:846
> > [   17.587667]  sec_pagetables:0 bounce:0
> > [   17.587667]  kernel_misc_reclaimable:0
> > [   17.587667]  free:13396 free_pcp:37 free_cma:0
> > [   17.589349] Node 0 active_anon:468kB inactive_anon:56940kB active_file:101112kB inactive_file:101576kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:54000kB dirty:328kB writeback:756kB shmem:4748kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:5504kB pagetables:3384kB sec_pagetables:0kB all_unreclaimable? no
> > [   17.590712] Node 0 DMA free:6664kB boost:0kB min:424kB low:528kB high:632kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> > [   17.591848] lowmem_reserve[]: 0 1564 1564 1564 1564
> > [   17.592075] Node 0 DMA32 free:46920kB boost:0kB min:44628kB low:55784kB high:66940kB reserved_highatomic:0KB active_anon:468kB inactive_anon:56940kB active_file:101072kB inactive_file:101568kB unevictable:0kB writepending:1504kB present:2080640kB managed:1620324kB mlocked:0kB bounce:0kB free_pcp:468kB local_pcp:0kB free_cma:0kB
> > [   17.593443] lowmem_reserve[]: 0 0 0 0 0
> > [   17.593624] Node 0 DMA: 0*4kB 2*8kB (UM) 1*16kB (M) 1*32kB (M) 1*64kB (M) 1*128kB (M) 1*256kB (M) 2*512kB (UM) 1*1024kB (M) 0*2048kB 1*4096kB (M) = 6656kB
> > [   17.594261] Node 0 DMA32: 770*4kB (UME) 193*8kB (UME) 121*16kB (UME) 72*32kB (UME) 39*64kB (UME) 15*128kB (ME) 7*256kB (UM) 4*512kB (ME) 2*1024kB (UM) 4*2048kB (UME) 5*4096kB (M) = 47840kB
> > [   17.595020] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
> > [   17.595399] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
> > [   17.595774] 51855 total pagecache pages
> > [   17.595949] 0 pages in swap cache
> > [   17.596170] Free swap  = 0kB
> > [   17.596304] Total swap = 0kB
> > [   17.596440] 524158 pages RAM
> > [   17.596589] 0 pages HighMem/MovableOnly
> > [   17.596767] 115237 pages reserved
> > [   17.596934] 0 pages cma reserved
> > [   17.597149] 0 pages hwpoisoned
> > [   17.645660] kexec: Could not allocate control_code_buffer
> > [   17.785654] loop0: detected capacity change from 0 to 65536
> > [   17.787652] =======================================================
> > [   17.787652] WARNING: The mand mount option has been deprecated and
> > [   17.787652]          and is ignored by this kernel. Remove the mand
> > [   17.787652]          option from the mount to silence this warning.
> > [   17.787652] =======================================================
> > [   17.801532] XFS (loop0): cannot change alignment: superblock does not support data alignment
> > [   17.878479] loop0: detected capacity change from 0 to 1024
> > [   17.888666] I/O error, dev loop0, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
> > [   17.894988] loop0: detected capacity change from 0 to 1024
> > [   17.895613] EXT4-fs: Invalid want_extra_isize 0
> > [   17.909948] loop0: detected capacity change from 0 to 128
> > [   18.105190] kexec: Could not allocate control_code_buffer


