Return-Path: <bpf+bounces-29998-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 170A18C8FB7
	for <lists+bpf@lfdr.de>; Sat, 18 May 2024 07:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F326B223A4
	for <lists+bpf@lfdr.de>; Sat, 18 May 2024 05:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BC18BFC;
	Sat, 18 May 2024 05:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjAg0WoO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EB6523D;
	Sat, 18 May 2024 05:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716010844; cv=none; b=r96zHHjAZNE3UrocYVNIx9WeKBmK9h727FtYoDctTUSiwXcNyl6L9OPu6f0EJJ1hPt6Cs8wsuJH4VWy0DrKW6SnmWDt8ra4ijZd3bvKSj+qwBc0T0G6jIvn7BJYyJNxyz/rWYcnT7Bqkk22lG3hJNv7zwQNsLUJPO6vnICNpTMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716010844; c=relaxed/simple;
	bh=HD52gDCOrUkqBdzT3ynZLLQRIvzC1v/8VLQeYpKURbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fohGs4pUZ1o3bCw1UQjuVj4ZKvWoWS/55VTy8si78A0FGyCBxg+UOXiyH4Wgdj2rdocgE/jWj6cmZNigiHB8nZjdjv/LFdogKJJpmpUhQBzr9wdMvpNYp5OPVdOsmxlf3cBrhIvNOBY30A8jkv7pJnInobVHm7f5Bw9zfyr9yb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjAg0WoO; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-36c90b7f4c8so11146685ab.2;
        Fri, 17 May 2024 22:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716010841; x=1716615641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=78D6VdgqzOe5nSwTTlHYHjECeKnG6UTTZkpI6SuphkY=;
        b=YjAg0WoODQleuQtLDpmj4B4zUtLi3Q175piLhjxE1vkhn+8yCMxoUJaJMgQ5F8SMf7
         G3c8JSzV9OnHLGarpuDv/axFypAMeQIGNE+k3mHR3UCTEE7krb8sbt8FPtdByCSGwKQe
         XWBoooLmvCHrNMCuPwWMbol4bMx0R2isAWYB78Cks+/v/R/OXZOh7bBBtyDTFMuFezlH
         hECaADb82wtR18F9yVpSZhp6690rsB1DzionBpz8xyAdtDHk3WF4RsLViAYmPNrYmgu2
         kZmRnQgv2wX9f7pXEOsDwNYdcYy22+sFS609x3hy2+8eMjQshxuAob6Kkb8TkT73lBvO
         vx9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716010841; x=1716615641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=78D6VdgqzOe5nSwTTlHYHjECeKnG6UTTZkpI6SuphkY=;
        b=VqDd3gjyXNPoFGAiN24xg0OxxeeeV8YbnwYh2sift/QEvlWbMZBNvf/o2ql2x+Kiny
         TZpXuMq7JMiUOQmp6YPwolEG016PYE2UDaLo+spq3bnxCLoV5pJqjzOje0cRCptAxfi/
         yTUDYq6NEZqhimI2iiOPMu/CqTwkaLlroBqFFbYRcXJZf+PhYy1Dpah1UwHFjqHPJkI+
         h7Dy6+XqBHX9ZqYev/ThEv5d/kIdqazs8kz2B9ptecAZQNC2OKZ2UkmsqqiIEd8/0UYr
         lhuerDHE330KSKqK6FvXGJGoxaTLIFL3MfvvtL31+IWL9x1FVsWTGdN1vOuhxorcUW7V
         ykaw==
X-Forwarded-Encrypted: i=1; AJvYcCVsXxt/03FuMHjsKNhByqwsyUOpHzIVcnag4yyGgQwk+hS3Fmel0ZfPi26YQT5my4eIlDpL2OjnEhdXUEv5UdTxI5bcepjVCeEzFllOm41BEWuSuLtFRzhDcJ/w6OiLft2t
X-Gm-Message-State: AOJu0YyO8Ih9qUR7rvOheWUo0yZh6fCsih1V5sMTZl0bjm4NO0f5mp+5
	iZDZzyXWZT//pugOq3WDVFqq8KKLv1K3JH16OLm2FBKKXPVmaZnn
X-Google-Smtp-Source: AGHT+IGRk1/ryu9WmlDA81J+QPM+OTKp/tleOcUE4OxIVe4buwxRIr+xaDiZ0NM8QN1S7AzhDl9fGw==
X-Received: by 2002:a05:6e02:1d0b:b0:36b:fa00:7171 with SMTP id e9e14a558f8ab-36cc146536bmr306987455ab.15.1716010837812;
        Fri, 17 May 2024 22:40:37 -0700 (PDT)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-63f149765efsm10883290a12.16.2024.05.17.22.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 22:40:37 -0700 (PDT)
From: Yuntao Wang <ytcoode@gmail.com>
To: pengfei.xu@intel.com
Cc: akpm@linux-foundation.org,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	sdf@google.com,
	song@kernel.org,
	syzbot+a7f061d2d16154538c58@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev,
	ytcoode@gmail.com,
	Baoquan He <bhe@redhat.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in get_page_from_freelist
Date: Sat, 18 May 2024 13:40:19 +0800
Message-ID: <20240518054026.11403-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <ZkcD9H0P8O7Me5Do@xpf.sh.intel.com>
References: <ZkcD9H0P8O7Me5Do@xpf.sh.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 17 May 2024 15:15:00 +0800, Pengfei Xu <pengfei.xu@intel.com> wrote:

> Hi Yuntao,
> 
> Greeting!
> 
> On 2024-04-14 at 19:28:16 -0700, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    7efd0a74039f Merge tag 'ata-6.9-rc4' of git://git.kernel.o..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1358aeed180000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=285be8dd6baeb438
> > dashboard link: https://syzkaller.appspot.com/bug?extid=a7f061d2d16154538c58
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> > 
> > Unfortunately, I don't have any reproducer for this issue yet.
> > 
> 
> I used syzkaller and could reproduce the similar issue "WARNING in
> get_page_from_freelist" in v6.9 mainline kernel.
> 
> Bisected and found first bad commit:
> "
> 816d334afa85 kexec: modify the meaning of the end parameter in kimage_is_destination_range()
> "
> Revert above commit on top of v6.9 kernel this issue was gone.

Hi Pengfei,

I reviewed this commit multiple times, but I still couldn't figure out why this
commit would cause this issue. Could someone else please take a look? Thank you
very much!

Thanks,
Yuntao

> All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/240517_085953_get_page_from_freelist
> mount_*.gz are in above link.
> Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/240517_085953_get_page_from_freelist/rep.c
> Syzkaller syscall repro steps: https://github.com/xupengfe/syzkaller_logs/blob/main/240517_085953_get_page_from_freelist/repro.prog
> Syzkaller report: https://github.com/xupengfe/syzkaller_logs/blob/main/240517_085953_get_page_from_freelist/repro.report
> Kconfig(make olddefconfig): https://github.com/xupengfe/syzkaller_logs/blob/main/240517_085953_get_page_from_freelist/kconfig_origin
> Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/240517_085953_get_page_from_freelist/bisect_info.log
> v6.9 dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/240517_085953_get_page_from_freelist/a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6_dmesg.log
> v6.9 bzImage: https://github.com/xupengfe/syzkaller_logs/raw/main/240517_085953_get_page_from_freelist/bzImage_a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6.tar.gz
> 
> [   17.436013] loop0: detected capacity change from 0 to 1024
> [   17.456160] I/O error, dev loop0, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
> [   17.456746] loop0: detected capacity change from 0 to 1024
> [   17.456809] I/O error, dev loop0, sector 16 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
> [   17.457548] EXT4-fs: Invalid want_extra_isize 0
> [   17.575984] repro: page allocation failure: order:1, mode:0x10cc0(GFP_KERNEL|__GFP_NORETRY), nodemask=(null),cpuset=/,mems_allowed=0
> [   17.576621] CPU: 1 PID: 726 Comm: repro Not tainted 6.9.0-a38297e3fb01+ #1
> [   17.576930] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [   17.577412] Call Trace:
> [   17.577526]  <TASK>
> [   17.577626]  dump_stack_lvl+0x121/0x150
> [   17.577813]  dump_stack+0x19/0x20
> [   17.577969]  warn_alloc+0x218/0x350
> [   17.578133]  ? __pfx_warn_alloc+0x10/0x10
> [   17.578317]  ? __alloc_pages_direct_compact+0x130/0xa00
> [   17.578552]  ? __pfx___alloc_pages_direct_compact+0x10/0x10
> [   17.578803]  ? __drain_all_pages+0x27b/0x480
> [   17.579021]  __alloc_pages_slowpath.constprop.0+0x1b62/0x2160
> [   17.579291]  ? __pfx___alloc_pages_slowpath.constprop.0+0x10/0x10
> [   17.579569]  ? __pfx_get_page_from_freelist+0x10/0x10
> [   17.579802]  ? prepare_alloc_pages.constprop.0+0x15b/0x4f0
> [   17.580032]  __alloc_pages+0x48f/0x580
> [   17.580212]  ? __pfx___alloc_pages+0x10/0x10
> [   17.580392]  ? kasan_save_stack+0x40/0x60
> [   17.580583]  ? kasan_save_stack+0x2c/0x60
> [   17.580772]  ? kasan_save_track+0x18/0x40
> [   17.580946]  ? _find_first_bit+0x95/0xc0
> [   17.581114]  ? policy_nodemask+0xf9/0x450
> [   17.581300]  alloc_pages_mpol+0x296/0x590
> [   17.581487]  ? __pfx_alloc_pages_mpol+0x10/0x10
> [   17.581695]  ? arch_kexec_post_alloc_pages+0x37/0x70
> [   17.581924]  ? __pfx_write_comp_data+0x10/0x10
> [   17.582133]  alloc_pages+0x13f/0x160
> [   17.582302]  kimage_alloc_pages+0x79/0x240
> [   17.582498]  kimage_alloc_control_pages+0x1cb/0xa60
> [   17.582727]  ? __pfx_kimage_alloc_control_pages+0x10/0x10
> [   17.582973]  ? __sanitizer_cov_trace_const_cmp1+0x1e/0x30
> [   17.583224]  do_kexec_load+0x337/0x750
> [   17.583406]  __x64_sys_kexec_load+0x1cc/0x240
> [   17.583619]  x64_sys_call+0x1aa2/0x20c0
> [   17.583807]  do_syscall_64+0x6f/0x150
> [   17.583988]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   17.584217] RIP: 0033:0x7f4f2ec3ee5d
> [   17.584382] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 93 af 1b 00 f7 d8 64 89 01 48
> [   17.585171] RSP: 002b:00007ffd101da888 EFLAGS: 00000246 ORIG_RAX: 00000000000000f6
> [   17.585500] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f4f2ec3ee5d
> [   17.585985] RDX: 00000000200003c0 RSI: 0000000000000002 RDI: 0000000000000000
> [   17.586346] RBP: 00007ffd101da8a0 R08: 0000000000000800 R09: 0000000000000800
> [   17.586656] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd101da9b8
> [   17.587001] R13: 0000000000402862 R14: 0000000000412e08 R15: 00007f4f2ef30000
> [   17.587381]  </TASK>
> [   17.587559] Mem-Info:
> [   17.587667] active_anon:117 inactive_anon:14235 isolated_anon:0
> [   17.587667]  active_file:25278 inactive_file:25394 isolated_file:0
> [   17.587667]  unevictable:0 dirty:82 writeback:189
> [   17.587667]  slab_reclaimable:14774 slab_unreclaimable:23678
> [   17.587667]  mapped:13500 shmem:1187 pagetables:846
> [   17.587667]  sec_pagetables:0 bounce:0
> [   17.587667]  kernel_misc_reclaimable:0
> [   17.587667]  free:13396 free_pcp:37 free_cma:0
> [   17.589349] Node 0 active_anon:468kB inactive_anon:56940kB active_file:101112kB inactive_file:101576kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:54000kB dirty:328kB writeback:756kB shmem:4748kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kernel_stack:5504kB pagetables:3384kB sec_pagetables:0kB all_unreclaimable? no
> [   17.590712] Node 0 DMA free:6664kB boost:0kB min:424kB low:528kB high:632kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> [   17.591848] lowmem_reserve[]: 0 1564 1564 1564 1564
> [   17.592075] Node 0 DMA32 free:46920kB boost:0kB min:44628kB low:55784kB high:66940kB reserved_highatomic:0KB active_anon:468kB inactive_anon:56940kB active_file:101072kB inactive_file:101568kB unevictable:0kB writepending:1504kB present:2080640kB managed:1620324kB mlocked:0kB bounce:0kB free_pcp:468kB local_pcp:0kB free_cma:0kB
> [   17.593443] lowmem_reserve[]: 0 0 0 0 0
> [   17.593624] Node 0 DMA: 0*4kB 2*8kB (UM) 1*16kB (M) 1*32kB (M) 1*64kB (M) 1*128kB (M) 1*256kB (M) 2*512kB (UM) 1*1024kB (M) 0*2048kB 1*4096kB (M) = 6656kB
> [   17.594261] Node 0 DMA32: 770*4kB (UME) 193*8kB (UME) 121*16kB (UME) 72*32kB (UME) 39*64kB (UME) 15*128kB (ME) 7*256kB (UM) 4*512kB (ME) 2*1024kB (UM) 4*2048kB (UME) 5*4096kB (M) = 47840kB
> [   17.595020] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
> [   17.595399] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
> [   17.595774] 51855 total pagecache pages
> [   17.595949] 0 pages in swap cache
> [   17.596170] Free swap  = 0kB
> [   17.596304] Total swap = 0kB
> [   17.596440] 524158 pages RAM
> [   17.596589] 0 pages HighMem/MovableOnly
> [   17.596767] 115237 pages reserved
> [   17.596934] 0 pages cma reserved
> [   17.597149] 0 pages hwpoisoned
> [   17.645660] kexec: Could not allocate control_code_buffer
> [   17.785654] loop0: detected capacity change from 0 to 65536
> [   17.787652] =======================================================
> [   17.787652] WARNING: The mand mount option has been deprecated and
> [   17.787652]          and is ignored by this kernel. Remove the mand
> [   17.787652]          option from the mount to silence this warning.
> [   17.787652] =======================================================
> [   17.801532] XFS (loop0): cannot change alignment: superblock does not support data alignment
> [   17.878479] loop0: detected capacity change from 0 to 1024
> [   17.888666] I/O error, dev loop0, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
> [   17.894988] loop0: detected capacity change from 0 to 1024
> [   17.895613] EXT4-fs: Invalid want_extra_isize 0
> [   17.909948] loop0: detected capacity change from 0 to 128
> [   18.105190] kexec: Could not allocate control_code_buffer
> 
> Hope it's helpful.
> 
> Thanks!
> 
> ---
> 
> If you don't need the following environment to reproduce the problem or if you
> already have one reproduced environment, please ignore the following information.
> 
> How to reproduce:
> git clone https://gitlab.com/xupengfe/repro_vm_env.git
> cd repro_vm_env
> tar -xvf repro_vm_env.tar.gz
> cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
>   // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
>   // You could change the bzImage_xxx as you want
>   // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
> You could use below command to log in, there is no password for root.
> ssh -p 10023 root@localhost
> 
> After login vm(virtual machine) successfully, you could transfer reproduced
> binary to the vm by below way, and reproduce the problem in vm:
> gcc -pthread -o repro repro.c
> scp -P 10023 repro root@localhost:/root/
> 
> Get the bzImage for target kernel:
> Please use target kconfig and copy it to kernel_src/.config
> make olddefconfig
> make -jx bzImage           //x should equal or less than cpu num your pc has
> 
> Fill the bzImage file into above start3.sh to load the target kernel in vm.
> 
> 
> Tips:
> If you already have qemu-system-x86_64, please ignore below info.
> If you want to install qemu v7.1.0 version:
> git clone https://github.com/qemu/qemu.git
> cd qemu
> git checkout -f v7.1.0
> mkdir build
> cd build
> yum install -y ninja-build.x86_64
> yum -y install libslirp-devel.x86_64
> ../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
> make
> make install
> 
> Best Regards,
> Thanks!
> 
> 
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-7efd0a74.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/39eb4e17e7f0/vmlinux-7efd0a74.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/b9a08c36e0ca/bzImage-7efd0a74.xz
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+a7f061d2d16154538c58@syzkaller.appspotmail.com
> > 
> > ======================================================
> > WARNING: possible circular locking dependency detected
> > 6.9.0-rc3-syzkaller-00355-g7efd0a74039f #0 Not tainted
> > ------------------------------------------------------
> > syz-executor.2/7645 is trying to acquire lock:
> > ffff88807ffd7d58 (&zone->lock){-.-.}-{2:2}, at: rmqueue_buddy mm/page_alloc.c:2730 [inline]
> > ffff88807ffd7d58 (&zone->lock){-.-.}-{2:2}, at: rmqueue mm/page_alloc.c:2911 [inline]
> > ffff88807ffd7d58 (&zone->lock){-.-.}-{2:2}, at: get_page_from_freelist+0x4b9/0x3780 mm/page_alloc.c:3314
> > 
> > but task is already holding lock:
> > ffff88802c8739f8 (&trie->lock){-.-.}-{2:2}, at: trie_update_elem+0xc8/0xdd0 kernel/bpf/lpm_trie.c:324
> > 
> > which lock already depends on the new lock.
> > 
> > 
> > the existing dependency chain (in reverse order) is:
> > 
> > -> #1 (&trie->lock){-.-.}-{2:2}:
> >        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
> >        _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
> >        trie_delete_elem+0xb0/0x7e0 kernel/bpf/lpm_trie.c:451
> >        ___bpf_prog_run+0x3e51/0xabd0 kernel/bpf/core.c:1997
> >        __bpf_prog_run32+0xc1/0x100 kernel/bpf/core.c:2236
> >        bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
> >        __bpf_prog_run include/linux/filter.h:657 [inline]
> >        bpf_prog_run include/linux/filter.h:664 [inline]
> >        __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
> >        bpf_trace_run2+0x151/0x420 kernel/trace/bpf_trace.c:2420
> >        __bpf_trace_contention_end+0xca/0x110 include/trace/events/lock.h:122
> >        trace_contention_end.constprop.0+0xea/0x170 include/trace/events/lock.h:122
> >        __pv_queued_spin_lock_slowpath+0x266/0xc80 kernel/locking/qspinlock.c:560
> >        pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:584 [inline]
> >        queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
> >        queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
> >        do_raw_spin_lock+0x210/0x2c0 kernel/locking/spinlock_debug.c:116
> >        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:111 [inline]
> >        _raw_spin_lock_irqsave+0x42/0x60 kernel/locking/spinlock.c:162
> >        rmqueue_bulk mm/page_alloc.c:2131 [inline]
> >        __rmqueue_pcplist+0x5a8/0x1b00 mm/page_alloc.c:2826
> >        rmqueue_pcplist mm/page_alloc.c:2868 [inline]
> >        rmqueue mm/page_alloc.c:2905 [inline]
> >        get_page_from_freelist+0xbaa/0x3780 mm/page_alloc.c:3314
> >        __alloc_pages+0x22b/0x2460 mm/page_alloc.c:4575
> >        __alloc_pages_node include/linux/gfp.h:238 [inline]
> >        alloc_pages_node include/linux/gfp.h:261 [inline]
> >        alloc_slab_page mm/slub.c:2175 [inline]
> >        allocate_slab mm/slub.c:2338 [inline]
> >        new_slab+0xcc/0x3a0 mm/slub.c:2391
> >        ___slab_alloc+0x66d/0x1790 mm/slub.c:3525
> >        __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3610
> >        __slab_alloc_node mm/slub.c:3663 [inline]
> >        slab_alloc_node mm/slub.c:3835 [inline]
> >        __do_kmalloc_node mm/slub.c:3965 [inline]
> >        __kmalloc_node_track_caller+0x367/0x470 mm/slub.c:3986
> >        kmalloc_reserve+0xef/0x2c0 net/core/skbuff.c:599
> >        __alloc_skb+0x164/0x380 net/core/skbuff.c:668
> >        alloc_skb include/linux/skbuff.h:1313 [inline]
> >        nsim_dev_trap_skb_build drivers/net/netdevsim/dev.c:748 [inline]
> >        nsim_dev_trap_report drivers/net/netdevsim/dev.c:805 [inline]
> >        nsim_dev_trap_report_work+0x2a4/0xc80 drivers/net/netdevsim/dev.c:850
> >        process_one_work+0x9a9/0x1ac0 kernel/workqueue.c:3254
> >        process_scheduled_works kernel/workqueue.c:3335 [inline]
> >        worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
> >        kthread+0x2c1/0x3a0 kernel/kthread.c:388
> >        ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
> >        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> > 
> > -> #0 (&zone->lock){-.-.}-{2:2}:
> >        check_prev_add kernel/locking/lockdep.c:3134 [inline]
> >        check_prevs_add kernel/locking/lockdep.c:3253 [inline]
> >        validate_chain kernel/locking/lockdep.c:3869 [inline]
> >        __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
> >        lock_acquire kernel/locking/lockdep.c:5754 [inline]
> >        lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
> >        __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
> >        _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
> >        rmqueue_buddy mm/page_alloc.c:2730 [inline]
> >        rmqueue mm/page_alloc.c:2911 [inline]
> >        get_page_from_freelist+0x4b9/0x3780 mm/page_alloc.c:3314
> >        __alloc_pages+0x22b/0x2460 mm/page_alloc.c:4575
> >        __alloc_pages_node include/linux/gfp.h:238 [inline]
> >        alloc_pages_node include/linux/gfp.h:261 [inline]
> >        __kmalloc_large_node+0x7f/0x1a0 mm/slub.c:3911
> >        __do_kmalloc_node mm/slub.c:3954 [inline]
> >        __kmalloc_node.cold+0x5/0x5f mm/slub.c:3973
> >        kmalloc_node include/linux/slab.h:648 [inline]
> >        bpf_map_kmalloc_node+0x98/0x4a0 kernel/bpf/syscall.c:422
> >        lpm_trie_node_alloc kernel/bpf/lpm_trie.c:291 [inline]
> >        trie_update_elem+0x1ef/0xdd0 kernel/bpf/lpm_trie.c:333
> >        bpf_map_update_value+0x2c1/0x6c0 kernel/bpf/syscall.c:203
> >        map_update_elem+0x623/0x910 kernel/bpf/syscall.c:1641
> >        __sys_bpf+0xab9/0x4b40 kernel/bpf/syscall.c:5648
> >        __do_sys_bpf kernel/bpf/syscall.c:5767 [inline]
> >        __se_sys_bpf kernel/bpf/syscall.c:5765 [inline]
> >        __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5765
> >        do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >        do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
> >        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > 
> > other info that might help us debug this:
> > 
> >  Possible unsafe locking scenario:
> > 
> >        CPU0                    CPU1
> >        ----                    ----
> >   lock(&trie->lock);
> >                                lock(&zone->lock);
> >                                lock(&trie->lock);
> >   lock(&zone->lock);
> > 
> >  *** DEADLOCK ***
> > 
> > 2 locks held by syz-executor.2/7645:
> >  #0: ffffffff8d7b0e20 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
> >  #0: ffffffff8d7b0e20 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
> >  #0: ffffffff8d7b0e20 (rcu_read_lock){....}-{1:2}, at: bpf_map_update_value+0x24b/0x6c0 kernel/bpf/syscall.c:202
> >  #1: ffff88802c8739f8 (&trie->lock){-.-.}-{2:2}, at: trie_update_elem+0xc8/0xdd0 kernel/bpf/lpm_trie.c:324
> > 
> > stack backtrace:
> > CPU: 1 PID: 7645 Comm: syz-executor.2 Not tainted 6.9.0-rc3-syzkaller-00355-g7efd0a74039f #0
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
> >  check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2187
> >  check_prev_add kernel/locking/lockdep.c:3134 [inline]
> >  check_prevs_add kernel/locking/lockdep.c:3253 [inline]
> >  validate_chain kernel/locking/lockdep.c:3869 [inline]
> >  __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
> >  lock_acquire kernel/locking/lockdep.c:5754 [inline]
> >  lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
> >  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
> >  _raw_spin_lock_irqsave+0x3a/0x60 kernel/locking/spinlock.c:162
> >  rmqueue_buddy mm/page_alloc.c:2730 [inline]
> >  rmqueue mm/page_alloc.c:2911 [inline]
> >  get_page_from_freelist+0x4b9/0x3780 mm/page_alloc.c:3314
> >  __alloc_pages+0x22b/0x2460 mm/page_alloc.c:4575
> >  __alloc_pages_node include/linux/gfp.h:238 [inline]
> >  alloc_pages_node include/linux/gfp.h:261 [inline]
> >  __kmalloc_large_node+0x7f/0x1a0 mm/slub.c:3911
> >  __do_kmalloc_node mm/slub.c:3954 [inline]
> >  __kmalloc_node.cold+0x5/0x5f mm/slub.c:3973
> >  kmalloc_node include/linux/slab.h:648 [inline]
> >  bpf_map_kmalloc_node+0x98/0x4a0 kernel/bpf/syscall.c:422
> >  lpm_trie_node_alloc kernel/bpf/lpm_trie.c:291 [inline]
> >  trie_update_elem+0x1ef/0xdd0 kernel/bpf/lpm_trie.c:333
> >  bpf_map_update_value+0x2c1/0x6c0 kernel/bpf/syscall.c:203
> >  map_update_elem+0x623/0x910 kernel/bpf/syscall.c:1641
> >  __sys_bpf+0xab9/0x4b40 kernel/bpf/syscall.c:5648
> >  __do_sys_bpf kernel/bpf/syscall.c:5767 [inline]
> >  __se_sys_bpf kernel/bpf/syscall.c:5765 [inline]
> >  __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5765
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7fdb1c27de69
> > Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007fdb1d0210c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
> > RAX: ffffffffffffffda RBX: 00007fdb1c3abf80 RCX: 00007fdb1c27de69
> > RDX: 0000000000000020 RSI: 0000000020001400 RDI: 0000000000000002
> > RBP: 00007fdb1c2ca47a R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 000000000000000b R14: 00007fdb1c3abf80 R15: 00007ffe7cd30f08
> >  </TASK>
> > loop2: detected capacity change from 0 to 512
> > ext4: Unknown parameter '���������������3;�{\C	_r���f�gD\x19Z*��ג�Md�;�s�8)V^[�Z�-#��S%\x19�SY�E`1t\x10AS�>�>���\x0ed]�x��h'
> > 
> > 
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > 
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > 
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> > 
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> > 
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> > 
> > If you want to undo deduplication, reply with:
> > #syz undup

