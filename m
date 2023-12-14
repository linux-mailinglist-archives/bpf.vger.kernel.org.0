Return-Path: <bpf+bounces-17806-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBA0812AC2
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 09:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FCF11C21519
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 08:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33E5249F2;
	Thu, 14 Dec 2023 08:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIv7/76L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BB2A0
	for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 00:52:06 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40c2c65e6aaso81768975e9.2
        for <bpf@vger.kernel.org>; Thu, 14 Dec 2023 00:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702543925; x=1703148725; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RRAVcXPHw/HRI2YNqlHW1PhOSIa9jujP44CyZ3ep1G8=;
        b=HIv7/76LQayaxzP3aTWInFmzU2EIQ/O2P+reDzpwTQ2Jk/oHsqyC6qaCyvpp7YNVOx
         kBAL6SJ8COqjIPeWhJ96WOzjROSp2ReqTnf2+RRVf1Q4QG2+fSe9MbHvahGOeUI3nTDu
         j2RWgy4RYj1i2I/YpjhP6L/CLixbR6ElBk+WsPwbG6X3Gj2R/xIenzQAuGE0BljkGnUS
         6kkXhQgG8feB3gEOLm8JhyP9YhIg7Yl7ZvN7cKMaHAaaCnKVhIVrxFxpoHKmM1528goA
         MaWv2Wn9l2Wfx7E+qU+t8c9Q0xLFFEm+UNW5OufxrTmOgZJ/tCBVWJmvx38zcvc0R6DX
         iRcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702543925; x=1703148725;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RRAVcXPHw/HRI2YNqlHW1PhOSIa9jujP44CyZ3ep1G8=;
        b=H78OjZhr8aRbLKtVjpYweXsw1l+Pp+JGdM4rcqaTiHfzh6gm+0y5R/A4HTTxKJ7S+R
         w/Ff+HonOdTwveRE8lEwLO7Wp/xxhUAd3ga7wPD0NT5AOb95o2oeyhynj6nLQ2YTjflL
         /ylCrpf/bHQ9ptNqptnew58iq7G3DRhYCbXRqSkFdEEXYVWUErPXLx5Jx0GRVSGuUjZ1
         NYptelYWzQ/OxJsFgC/83eaV/89kU5tLi79epFwZ4b+bBrcSaeovM9//brFZMgEcm6GT
         ov/6CaHncA/YcdQm6dJ4C5qoEvqg3Qsld25wYk3GPwzcvQ8pUaaWOXXPlCWgFMCkAJXY
         TCzA==
X-Gm-Message-State: AOJu0YzXWADgzLWYowk1v37rInTpbVNtUxLfLptxIlI1ZsoxD4a7d+UE
	zh9sLXsVBjpiiWDaC25EID8=
X-Google-Smtp-Source: AGHT+IH8gPu2NYRSq4yinL6aHG70TrwQVrEbT69D7wJRIGwm9ktxgvD5VkZOuRv+i5nW4GixhNiMKQ==
X-Received: by 2002:a05:600c:3c90:b0:40c:6160:98fb with SMTP id bg16-20020a05600c3c9000b0040c616098fbmr396668wmb.3.1702543924394;
        Thu, 14 Dec 2023 00:52:04 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id fl9-20020a05600c0b8900b0040b43da0bbasm23948852wmb.30.2023.12.14.00.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 00:52:03 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 14 Dec 2023 09:52:01 +0100
To: Hou Tao <houtao@huaweicloud.com>
Cc: Pengfei Xu <pengfei.xu@intel.com>, bpf@vger.kernel.org,
	heng.su@intel.com, andrii@kernel.org, laoar.shao@gmail.com,
	yonghong.song@linux.dev, ast@kernel.org, lkp@intel.com
Subject: Re: [Syzkaller & bisect] There is KASAN: global-out-of-bounds Read
 in bpf_link_show_fdinfo in v6.7-rc5
Message-ID: <ZXrCMe8ugo5OtXbr@krava>
References: <ZXptoKRSLspnk2ie@xpf.sh.intel.com>
 <09058391-0016-77b5-a44e-fffad18b52cb@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09058391-0016-77b5-a44e-fffad18b52cb@huaweicloud.com>

On Thu, Dec 14, 2023 at 02:33:34PM +0800, Hou Tao wrote:
> Hi,
> 
> On 12/14/2023 10:51 AM, Pengfei Xu wrote:
> > Hi Jiri Olsa,
> >
> > Greeting!
> >
> > There is KASAN: global-out-of-bounds Read in bpf_link_show_fdinfo in v6.7-rc5
> > kernel in vm.
> 
> It seems that the out-of-bound access is due to
> BPF_LINK_TYPE_UPROBE_MULTI and other link types don't define
> BPF_LINK_TYPE(type, name) in linux/bpf_types.h, so the content and the
> length of bpf_link_type_strs array is unexpected. But I will leave the
> fixes to Jiri and I have to continue on the fix of the warning during
> bpf ma initialization.

right, that seems to be the case.. will send the fix

thanks,
jirka

> >
> > All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/231213_090512_bpf_link_show_fdinfo
> > Syzkaller reproduced code: https://github.com/xupengfe/syzkaller_logs/blob/main/231213_090512_bpf_link_show_fdinfo/repro.c
> > Syzkaller syscall reproduced steps: https://github.com/xupengfe/syzkaller_logs/blob/main/231213_090512_bpf_link_show_fdinfo/repro.prog
> > Kconfig(make olddefconfig): https://github.com/xupengfe/syzkaller_logs/blob/main/231213_090512_bpf_link_show_fdinfo/kconfig_origin
> > Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/231213_090512_bpf_link_show_fdinfo/bisect_info.log
> > Issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/231213_090512_bpf_link_show_fdinfo/a39b6ac3781d46ba18193c9dbb2110f31e9bffe9_dmesg.log
> > bzImage: https://github.com/xupengfe/syzkaller_logs/raw/main/231213_090512_bpf_link_show_fdinfo/bzImage_a39b6ac3781d46ba18193c9dbb2110f31e9bffe9.tar.gz
> >
> > Bisected and related commit is as follows:
> > "
> > 0b779b61f651 bpf: Add cookies support for uprobe_multi link
> > "
> > Make the revert the commit on top of v6.7-rc5 kernel failed, could not double
> > confirm for the suspected commit.
> >
> >
> > [   20.624445] repro[731]: segfault at 0 ip 0000000000000000 sp 0000000020000288 error 14 in repro[400000+1000] likely on CPU 0 (core 0, socket 0)
> > [   20.625349] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> > [   20.631427] repro[734]: segfault at 0 ip 0000000000000000 sp 0000000020000288 error 14 in repro[400000+1000] likely on CPU 1 (core 1, socket 0)
> > [   20.632325] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> > [   20.665797] repro[737]: segfault at 0 ip 0000000000000000 sp 0000000020000288 error 14 in repro[400000+1000] likely on CPU 0 (core 0, socket 0)
> > [   20.666718] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> > [   20.671614] ==================================================================
> > [   20.672115] BUG: KASAN: global-out-of-bounds in bpf_link_show_fdinfo+0x30b/0x330
> > [   20.672598] Read of size 8 at addr ffffffff8593c9e0 by task systemd-coredum/732
> > [   20.673066] 
> > [   20.673179] CPU: 0 PID: 732 Comm: systemd-coredum Not tainted 6.7.0-rc5-a39b6ac3781d+ #1
> > [   20.673687] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > [   20.674381] Call Trace:
> > [   20.674552]  <TASK>
> > [   20.674701]  dump_stack_lvl+0xaa/0x110
> > [   20.674964]  print_report+0xcf/0x620
> > [   20.675209]  ? bpf_link_show_fdinfo+0x30b/0x330
> > [   20.675514]  ? kasan_addr_to_slab+0x11/0xb0
> > [   20.675794]  ? bpf_link_show_fdinfo+0x30b/0x330
> > [   20.676103]  kasan_report+0xcd/0x110
> > [   20.676342]  ? bpf_link_show_fdinfo+0x30b/0x330
> > [   20.676651]  __asan_report_load8_noabort+0x18/0x20
> > [   20.676960]  bpf_link_show_fdinfo+0x30b/0x330
> > [   20.677253]  ? __pfx_bpf_link_show_fdinfo+0x10/0x10
> > [   20.677569]  ? locks_remove_file+0x6d0/0x790
> > [   20.677861]  ? __pfx_bpf_link_show_fdinfo+0x10/0x10
> > [   20.678169]  seq_show+0x581/0x890
> > [   20.678402]  seq_read_iter+0x51a/0x1300
> > [   20.678672]  ? iov_iter_init+0x55/0x200
> > [   20.678939]  seq_read+0x171/0x210
> > [   20.679172]  ? __pfx_seq_read+0x10/0x10
> > [   20.679438]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
> > [   20.679784]  ? fsnotify_perm.part.0+0x260/0x5f0
> > [   20.680087]  ? security_file_permission+0xc5/0xf0
> > [   20.680399]  vfs_read+0x202/0x930
> > [   20.680626]  ? __pfx_seq_read+0x10/0x10
> > [   20.680884]  ? __pfx_vfs_read+0x10/0x10
> > [   20.681137]  ? __pfx_lock_release+0x10/0x10
> > [   20.681398]  ? ktime_get_coarse_real_ts64+0x4d/0xf0
> > [   20.681706]  ? __this_cpu_preempt_check+0x21/0x30
> > [   20.681997]  ? seqcount_lockdep_reader_access.constprop.0+0xb4/0xd0
> > [   20.682379]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
> > [   20.682722]  ksys_read+0x14f/0x290
> > [   20.682956]  ? __pfx_ksys_read+0x10/0x10
> > [   20.683226]  __x64_sys_read+0x7b/0xc0
> > [   20.683473]  ? syscall_enter_from_user_mode+0x53/0x70
> > [   20.683790]  do_syscall_64+0x42/0xf0
> > [   20.684027]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> > [   20.684327] RIP: 0033:0x7f688893eaf2
> > [   20.684556] Code: c0 e9 b2 fe ff ff 50 48 8d 3d ca 0c 08 00 e8 35 eb 01 00 0f 1f 44 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89 54 24
> > [   20.685647] RSP: 002b:00007ffde2a29e58 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> > [   20.686108] RAX: ffffffffffffffda RBX: 0000562b794752d0 RCX: 00007f688893eaf2
> > [   20.686527] RDX: 0000000000000400 RSI: 0000562b79475530 RDI: 0000000000000006
> > [   20.686964] RBP: 00007f68889f75e0 R08: 0000000000000006 R09: 00007f68889b14e0
> > [   20.687401] R10: 0000000000001000 R11: 0000000000000246 R12: 00007f688863c9c8
> > [   20.687837] R13: 0000000000000d68 R14: 00007f68889f69e0 R15: 0000000000000d68
> > [   20.688309]  </TASK>
> > [   20.688465] 
> > [   20.688571] The buggy address belongs to the variable:
> > [   20.688885]  bpf_link_type_strs+0x60/0x80
> > [   20.689145] 
> > [   20.689251] The buggy address belongs to the physical page:
> > [   20.689611] page:00000000449bb84f refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x593c
> > [   20.690184] flags: 0xfffffc0004000(reserved|node=0|zone=1|lastcpupid=0x1fffff)
> > [   20.690601] page_type: 0xffffffff()
> > [   20.690824] raw: 000fffffc0004000 ffffea0000164f08 ffffea0000164f08 0000000000000000
> > [   20.691307] raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
> > [   20.691795] page dumped because: kasan: bad access detected
> > [   20.692152] 
> > [   20.692254] Memory state around the buggy address:
> > [   20.692552]  ffffffff8593c880: 04 f9 f9 f9 f9 f9 f9 f9 05 f9 f9 f9 f9 f9 f9 f9
> > [   20.693008]  ffffffff8593c900: 00 05 f9 f9 f9 f9 f9 f9 00 03 f9 f9 f9 f9 f9 f9
> > [   20.693432] >ffffffff8593c980: 00 00 00 00 00 00 00 00 00 00 f9 f9 f9 f9 f9 f9
> > [   20.693877]                                                        ^
> > [   20.694265]  ffffffff8593ca00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > [   20.694707]  ffffffff8593ca80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > [   20.695158] ==================================================================
> > [   20.695666] Disabling lock debugging due to kernel taint
> > [   20.720062] repro[741]: segfault at 0 ip 0000000000000000 sp 0000000020000288 error 14 in repro[400000+1000] likely on CPU 0 (core 0, socket 0)
> > [   20.720827] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> > [   20.724913] repro[744]: segfault at 0 ip 0000000000000000 sp 0000000020000288 error 14 in repro[400000+1000] likely on CPU 1 (core 1, socket 0)
> > [   20.725791] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> > [   20.732282] repro[747]: segfault at 0 ip 0000000000000000 sp 0000000020000288 error 14 in repro[400000+1000] likely on CPU 1 (core 1, socket 0)
> > [   20.733148] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> > [   20.770165] repro[750]: segfault at 0 ip 0000000000000000 sp 0000000020000288 error 14 in repro[400000+1000] likely on CPU 1 (core 1, socket 0)
> > [   20.771018] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> > [   20.820152] repro[757]: segfault at 0 ip 0000000000000000 sp 0000000020000288 error 14 in repro[400000+1000] likely on CPU 1 (core 1, socket 0)
> > [   20.820984] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> > [   20.837880] repro[760]: segfault at 0 ip 0000000000000000 sp 0000000020000288 error 14 in repro[400000+1000] likely on CPU 1 (core 1, socket 0)
> > [   20.838815] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> > [   20.839423] repro[755]: segfault at 0 ip 0000000000000000 sp 0000000020000288 error 14 in repro[400000+1000] likely on CPU 0 (core 0, socket 0)
> > [   20.840255] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> > [   21.068187] Pid 786(repro) over core_pipe_limit
> > [   21.068503] Skipping core dump
> >
> > I hope it's helpful.
> >
> > ---
> >
> > If you don't need the following environment to reproduce the problem or if you
> > already have one reproduced environment, please ignore the following information.
> >
> > How to reproduce:
> > git clone https://gitlab.com/xupengfe/repro_vm_env.git
> > cd repro_vm_env
> > tar -xvf repro_vm_env.tar.gz
> > cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
> >   // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
> >   // You could change the bzImage_xxx as you want
> >   // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
> > You could use below command to log in, there is no password for root.
> > ssh -p 10023 root@localhost
> >
> > After login vm(virtual machine) successfully, you could transfer reproduced
> > binary to the vm by below way, and reproduce the problem in vm:
> > gcc -pthread -o repro repro.c
> > scp -P 10023 repro root@localhost:/root/
> >
> > Get the bzImage for target kernel:
> > Please use target kconfig and copy it to kernel_src/.config
> > make olddefconfig
> > make -jx bzImage           //x should equal or less than cpu num your pc has
> >
> > Fill the bzImage file into above start3.sh to load the target kernel in vm.
> >
> >
> > Tips:
> > If you already have qemu-system-x86_64, please ignore below info.
> > If you want to install qemu v7.1.0 version:
> > git clone https://github.com/qemu/qemu.git
> > cd qemu
> > git checkout -f v7.1.0
> > mkdir build
> > cd build
> > yum install -y ninja-build.x86_64
> > yum -y install libslirp-devel.x86_64
> > ../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
> > make
> > make install
> >
> > Best Regards,
> > Thanks!
> >
> > .
> 
> 

