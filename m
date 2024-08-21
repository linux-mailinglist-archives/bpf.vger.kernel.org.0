Return-Path: <bpf+bounces-37663-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFD79591ED
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 02:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B2601C21E3D
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 00:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204181803E;
	Wed, 21 Aug 2024 00:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2jwo8uS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EDC322B;
	Wed, 21 Aug 2024 00:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724200734; cv=none; b=aYcFcBifQnPauoswnGYFOkJBmE7KxgSyOmKsFjqmwx5VAGuPq5vUTEuRTbrIp0pH2e58UUExcZJVONMlw/nrEGduV6/DViJnTWDsSr7bOSOEo1WT38kjvgwRxbH91Nv+aIzb7K8zmC+Da7QSITXSQ4se1fzqIk7RjcjpTP9AviQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724200734; c=relaxed/simple;
	bh=hq3OolPJ/Dns4zh8ZEp09DDBmyZ6TzqgZIZ00Wawhoc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efcfMmdbusRwFkF8MtgffSYW9ZOavMLAD/+cRyI9cPOnWRYwtzJm8fbTEQ9y2tKXOJEzu+mi0Onsy78+x1W506UaP3f+mHQrMIDXU+1Z3nYVIui1r2xKgYNZhRzOasTdJLhgcmcWt+R5qCSFSP4+cEtQapMQ3ukH/M9Egw4uSWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2jwo8uS; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2021537a8e6so39981365ad.2;
        Tue, 20 Aug 2024 17:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724200732; x=1724805532; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iWNLYQwSynua2qkk7MnAHVz4T2JWtjpf9VLmAe4suoQ=;
        b=R2jwo8uSA8S1vDzcjuBbfjQ0ZEAMt7JTs1KirbGF0va2UA4acb1RI7OGO3phicl8nU
         Wi2n3ShVjlvrdpwA5Q71fq03nhBcfZY49ruiRMXT9X3AoyK9mzA1AUaayIoL2sLLqodf
         dI3mgoaL+3nqwcV5KeXvgd8hS3XLuEnlUI1m19oCysartulOAkrNS3x5IPZuKH2Fq1K+
         7BcT4KVkzfQgFqnOYQXTJ2wRUl+2tmgcNLtq9C/WJfUYnWGsbP0eqspi4RVBBrp6YZHx
         ReyghgEXOZ5c+Sr/FH2BlHiDMmd55gpiu1+AnIyvPmc058HVcW0xczgTJ+S5w+j8N6Bt
         pXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724200732; x=1724805532;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iWNLYQwSynua2qkk7MnAHVz4T2JWtjpf9VLmAe4suoQ=;
        b=vkDzTk5wRzoDtdkOgwP35AG1V4nof2Za5tkErQHDG571l1HnhyrESGccHBMGpoPq2I
         FHjmbidR/loHQmtWDGR0ztliLfhM0O7O9Pc7JrgWZ47KRMdvpzEzBrrQvuRikB2msFnA
         n6iLdSdraoqKi8T9c2WusdxTJIT+315F/g9ss/mV72+nSY3HPHGFWvLgRlRpo3l5qi+w
         7FUshBYVqTpjh0kYzTBM6mr4UD3lGcVjEi0EzIhpd51jU20qaU9xqBnrt868ixwhB735
         /lOXvcQTHZd/KhV7Kmw1/SarNOX610cfaIagGt8nmy/8uS6h1Es+Fd3S8P+rEouC7qs8
         LlpA==
X-Forwarded-Encrypted: i=1; AJvYcCXh6oiVnGlBA0++GwhhankpKO19hfGdN1XgvY/yACCt6nu6E1rv+rScFJh1qkGyvNQ0gec7p1SoyHUS@vger.kernel.org
X-Gm-Message-State: AOJu0YxUOSgjAhf8KKGZvT/iy78dmZVPtC+iPH4qbxaAnFiyfvbmzDmz
	9pnq6FdLeuzmzrDYpoStbm1hthpVyALAGbbU68zInCpuBKHxqD5exLm7mw==
X-Google-Smtp-Source: AGHT+IHNzPxOTw1nxx0pRZ5dW68uzHb5paiyAnsPlM7dwv74dbP1KaBlA/2atW+bjzTuI2iDGG8ASg==
X-Received: by 2002:a17:902:f545:b0:201:feb8:342d with SMTP id d9443c01a7336-20367d32780mr7287365ad.9.1724200731813;
        Tue, 20 Aug 2024 17:38:51 -0700 (PDT)
Received: from kodidev-ubuntu (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f0375631sm83128345ad.154.2024.08.20.17.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 17:38:51 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
X-Google-Original-From: Tony Ambardar <Tony.Ambardar@gmail.com>
Date: Tue, 20 Aug 2024 17:38:49 -0700
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: bpf@vger.kernel.org, linux-s390@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>
Subject: Re: Problem testing with S390x under QEMU on x86_64
Message-ID: <ZsU3GdK5t6KEOr0g@kodidev-ubuntu>
References: <ZsEcsaa3juxxQBUf@kodidev-ubuntu>
 <180f4c27ebfb954d6b0fd2303c9fb7d5f21dae04.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <180f4c27ebfb954d6b0fd2303c9fb7d5f21dae04.camel@linux.ibm.com>

On Mon, Aug 19, 2024 at 11:15:40AM +0200, Ilya Leoshkevich wrote:
> On Sat, 2024-08-17 at 14:57 -0700, Tony Ambardar wrote:
> > Hello all,
> > 
> > I'd appreciate some help from the BPF and s390x communities...
> > 
> > Some background: I'm finalizing a patch series enabling full cross-
> > endian
> > support for libbpf and selftests/bpf, and testing with mips64 so far.
> > This
> > arch makes switching the build byte-order trivial and has been very
> > handy
> > for A/B testing, but lacks some basic support (bpf2bpf call, kfuncs,
> > etc.)
> > making for poor selftests coverage.
> > 
> > To finish testing I thought (optimistically?) to cross-build kernel
> > and
> > bpf selftests from x86_64 to s390x. That configuration might also be
> > used
> > later on bpf-ci for regression testing endian support and sharing the
> > load
> > of s390x builds.
> > 
> > Locally, the build succeeds but when running it under QEMU I see
> > kernel
> > crashes trying to load any modules (e.g. prng or bpf_testmod).
> > 
> > 
> > The build/test setup uses Ubuntu and gcc: 
> > 
> > kodidev:~/linux$ lsb_release -d
> > Description:    Ubuntu 22.04.4 LTS
> > 
> > kodidev:~/linux$ s390x-linux-gnu-gcc --version
> > s390x-linux-gnu-gcc (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0
> > Copyright (C) 2021 Free Software Foundation, Inc.
> > This is free software; see the source for copying conditions.  There
> > is NO
> > warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR
> > PURPOSE.
> > 
> > 
> > The code targets bpf/master, and I've researched QEMU/s390x usage
> > details
> > online but mainly follow https://docs.kernel.org/bpf/s390.html. For
> > rootfs
> > I take the same s390x image used by the kernel-patches bpf-ci.
> > 
> > 
> > The kernel .config used is attached, and the QEMU command-line is
> > below:
> > 
> > qemu-system-s390x -cpu max,zpci=on -smp 2 -nographic -m 1G \
> > -object rng-random,filename=/dev/urandom,id=rng0 \
> > -device virtio-rng-ccw,rng=rng0 \
> > -device virtio-net-ccw,netdev=eth0 \
> > -netdev user,id=eth0,hostfwd=tcp::2224-:22 \
> > -serial mon:stdio \
> > -nodefaults \
> > -kernel bzImage-s390x \
> > -drive file=root-s390x-glibc.qcow2,if=virtio,format=qcow2   \
> > -append "rootwait root=/dev/vda rw net.ifnames=0 biosdevname=0
> > console=ttyS1"
> > 
> > 
> > After successfully booting, the crashes are easily reproduced:
> > 
> > root@(none):/# uname -a
> > Linux (none) 6.10.0-12706-g853081e84612-dirty #111 SMP Sat Aug 17
> > 00:49:23
> > PDT 2024 s390x GNU/Linux
> > 
> > # modprobe prng
> > Unable to handle kernel pointer dereference in virtual kernel address
> > space
> > Failing address: 000003fee0011000 TEID: 000003fee0011803
> > Fault in home space mode while using kernel ASCE.
> > AS:0000000001dac007 R3:0000000000000024
> > Oops: 003b ilc:1 [#1] SMP
> > Modules linked in: prng(+)
> > CPU: 1 UID: 0 PID: 81 Comm: modprobe Not tainted 6.10.0-12691-
> > g52e8c345c9f0 #106
> > Hardware name: QEMU 3906 QEMU (KVM/Linux)
> > Krnl PSW : 0704d00180000000 000003fee0011ea0 (0x3fee0011ea0)
> >            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 RI:0
> > EA:3
> > Krnl GPRS: 000002f2820db180 000003ffe1ca49a8 0000000000000000
> > 000003ff6000f498
> >            0000000000000000 0000000000000a22 0000000000000000
> > 0000000000000000
> >            000003ffe18111e0 000002f2806a48e8 000003ff6000f498
> > 0000000000000000
> >            000003ff8eaacfa8 000002aa0bbafa00 000003ff6000f4be
> > 0000037fe0c33b58
> > Krnl Code: Bad PSW.
> > Call Trace:
> >  [<000003fee0011ea0>] 0x3fee0011ea0
> >  [<000003ffe0000b24>] do_one_initcall+0x64/0x258
> >  [<000003ffe01566e8>] do_init_module+0x78/0x258
> >  [<000003ffe0158160>] init_module_from_file+0x88/0xa8
> >  [<000003ffe01582e8>] idempotent_init_module+0x168/0x230
> >  [<000003ffe0158430>] __s390x_sys_finit_module+0x80/0xb8
> >  [<000003ffe0b6f58a>] __do_syscall+0x232/0x2b0
> >  [<000003ffe0b81b90>] system_call+0x70/0x98
> > INFO: lockdep is turned off.
> > Last Breaking-Event-Address:
> >  [<000003ff6000f4b8>]
> > cpu_feature_match_S390_CPU_FEATURE_MSA_init+0x20/0xb68 [prng]
> > Kernel panic - not syncing: Fatal exception: panic_on_oops
> > 
> > 
> > and also:
> > 
> > # ./test_progs -a xdpwall
> > bpf_testmod: loading out-of-tree module taints kernel.
> > Unable to handle kernel pointer dereference in virtual kernel address
> > space
> > Failing address: 000003fee0293000 TEID: 000003fee0293803
> > Fault in home space mode while using kernel ASCE.
> > AS:0000000001dac007 R3:0000000000000024
> > Oops: 003b ilc:1 [#1] SMP
> > Modules linked in: bpf_testmod(O+)
> > CPU: 2 UID: 0 PID: 91 Comm: test_progs Tainted: G           O      
> > 6.10.0-12691-g52e8c345c9f0 #106
> > Tainted: [O]=OOT_MODULE
> > Hardware name: QEMU 3906 QEMU (KVM/Linux)
> > Krnl PSW : 0704d00180000000 000003fee0293998 (0x3fee0293998)
> >            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 RI:0
> > EA:3
> > Krnl GPRS: 000002f20374e760 0001677600016805 0000000000000000
> > 000003ff6000e288
> >            0000000000000000 000000000000007a 0000000000000000
> > 0000000000000000
> >            000003ffe18111e0 000002f204c6d2e8 000003ff6000ab90
> > 0000000000000000
> >            000003ffb73acfa8 0000000000000000 000003ff6000abce
> > 0000037fe0803b50
> > Krnl Code: Bad PSW.
> > Call Trace:
> >  [<000003fee0293998>] 0x3fee0293998
> >  [<000003ffe0000b24>] do_one_initcall+0x64/0x258
> >  [<000003ffe01566e8>] do_init_module+0x78/0x258
> >  [<000003ffe0158160>] init_module_from_file+0x88/0xa8
> >  [<000003ffe01582e8>] idempotent_init_module+0x168/0x230
> >  [<000003ffe0158430>] __s390x_sys_finit_module+0x80/0xb8
> >  [<000003ffe0b6f58a>] __do_syscall+0x232/0x2b0
> >  [<000003ffe0b81b90>] system_call+0x70/0x98
> > INFO: lockdep is turned off.
> > Last Breaking-Event-Address:
> >  [<000003ff6000abc8>] bpf_testmod_init+0x38/0x160 [bpf_testmod]
> > Kernel panic - not syncing: Fatal exception: panic_on_oops
> > 
> > 
> > Has anyone encountered this before, or is able to reproduce?
> > Could someone share a "known good" kernel .config working in the
> > past?
> > 
> > I'd be grateful for any advice or helpful suggestions.
> > 
> > Thanks,
> > Tony
> 
> Hi,
> 
> I assume you are using the distro qemu v6.2?
> Could you please try v9.1.0-rc2?
> It contains quite a few emulation bugfixes.
> 
> Best regards,
> Ilya

Hi Ilya,

Thanks for following up. As it happens, I did this the day before out of
desperation after trying various kernel config and rootfs changes
with no luck, and can confirm the system runs faster and without the
kernel crashes noted above. Certainly the latest QEMU seems mandatory.

The good news is that 99% of tests with my cross-compiled test_progs
work as expected out of the box, and some of the failing ones helped
troubleshoot a few hidden libbpf issues. I'll outline the remaining
failures for your feedback and comparison with native-built tests.

I used the command line:
    ./test_progs -d get_stack_raw_tp,stacktrace_build_id,verifier_iterating_callbacks,tailcalls

which includes the current DENYLIST.s390x as well as 'tailcalls', which
is also excluded by the kernel-patches/bpf s390x CI. I note the CI
excludes several more tests that seem to work. Any idea why that is?

For reference, the issue with 'tailcalls/tailcall_hierarchy_count' is an
RCU stall and kernel hang:

root@(none):/usr/libexec/kselftests-bpf# ./test_progs -v --debug -n 332/19
bpf_testmod.ko is already unloaded.
Loading bpf_testmod.ko...
Successfully loaded bpf_testmod.ko.
test_tailcall_hierarchy_count:PASS:load obj 0 nsec
test_tailcall_hierarchy_count:PASS:find entry prog 0 nsec
test_tailcall_hierarchy_count:PASS:prog_fd 0 nsec
test_tailcall_hierarchy_count:PASS:find jmp_table 0 nsec
test_tailcall_hierarchy_count:PASS:map_fd 0 nsec
test_tailcall_hierarchy_count:PASS:update jmp_table 0 nsec
test_tailcall_hierarchy_count:PASS:find data_map 0 nsec
test_tailcall_hierarchy_count:PASS:open fentry_obj file 0 nsec
test_tailcall_hierarchy_count:PASS:find fentry prog 0 nsec
test_tailcall_hierarchy_count:PASS:set_attach_target subprog_tail 0 nsec
test_tailcall_hierarchy_count:PASS:load fentry_obj 0 nsec
test_tailcall_hierarchy_count:PASS:attach_trace 0 nsec
rcu: INFO: rcu_sched self-detected stall on CPU
rcu:    0-....: (1 GPs behind) idle=4eb4/1/0x4000000000000000 softirq=527/528 fqs=1050
rcu:    (t=2100 jiffies g=-379 q=20 ncpus=2)
CPU: 0 UID: 0 PID: 84 Comm: test_progs Tainted: G           O       6.10.0-12706-g853081e84612-dirty #111
Tainted: [O]=OOT_MODULE
Hardware name: QEMU 8561 QEMU (KVM/Linux)
Krnl PSW : 0704f00180000000 000003ffe00f8fca (lock_release+0xf2/0x190)
           R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:3 PM:0 RI:0 EA:3
Krnl GPRS: 00000000b298dd12 0000000000000000 000002f23fd767c8 000003ffe1848800
           0000000000000001 0000037fe034edbc 0000037fe034fd74 0000000000000001
           0700037fe034edc8 000003ffe0249e48 000003ffe1848800 000003ffe19ba7c8
           000003ff9f7a7f90 0000037fe034ef00 000003ffe00f8f96 0000037fe034ed78
Krnl Code: 000003ffe00f8fbe: a7820300           tmhh    %r8,768
           000003ffe00f8fc2: a7840004           brc     8,000003ffe00f8fca
          #000003ffe00f8fc6: ad03f0a0           stosm   160(%r15),3
          >000003ffe00f8fca: eb8ff0a80004       lmg     %r8,%r15,168(%r15)
           000003ffe00f8fd0: 07fe               bcr     15,%r14
           000003ffe00f8fd2: c0e500011057       brasl   %r14,000003ffe011b080
           000003ffe00f8fd8: ec26ffa6007e       cij     %r2,0,6,000003ffe00f8f24
           000003ffe00f8fde: c01000b78b96       larl    %r1,000003ffe17ea70a
Call Trace:
 [<000003ffe00f8fca>] lock_release+0xf2/0x190
([<000003ffe00f8f96>] lock_release+0xbe/0x190)
 [<000003ffe0249ea4>] __bpf_prog_exit_recur+0x5c/0x68
 [<000003ff6001e0b0>] bpf_trampoline_73014444060+0xb0/0xd2
 [<000003ff60024d14>] bpf_prog_eb7edc599e93dcc8_entry+0x5c/0xc8
 [<000003ff60024d14>] bpf_prog_eb7edc599e93dcc8_entry+0x5c/0xc8
 [<000003ff60024d14>] bpf_prog_eb7edc599e93dcc8_entry+0x5c/0xc8
 [<000003ff60024d2a>] bpf_prog_eb7edc599e93dcc8_entry+0x72/0xc8
 [<000003ff60024d2a>] bpf_prog_eb7edc599e93dcc8_entry+0x72/0xc8
 [<000003ff60024d14>] bpf_prog_eb7edc599e93dcc8_entry+0x5c/0xc8
 [<000003ff60024d14>] bpf_prog_eb7edc599e93dcc8_entry+0x5c/0xc8
 [<000003ff60024d14>] bpf_prog_eb7edc599e93dcc8_entry+0x5c/0xc8
 [<000003ffe084ecee>] bpf_test_run+0x216/0x3a8
 [<000003ffe084f9cc>] bpf_prog_test_run_skb+0x21c/0x630
 [<000003ffe0202ad2>] __sys_bpf+0x7ea/0xbb0
 [<000003ffe0203114>] __s390x_sys_bpf+0x44/0


Another curiosity is with 'uprobe_multi_test/attach_uprobe_fails',
which usually succeeds but generates an inode warning in
kernel/events/uprobes.c: (with cross-compiled and native test_progs)

#416     uprobe_autoattach:OK
ref_ctr_offset mismatch. inode: 0x73c7 offset: 0x3c9b78 ref_ctr_offset(old): 0x464d7be ref_ctr_offset(new): 0x464d7bc
#417/1   uprobe_multi_test/skel_api:OK
#417/2   uprobe_multi_test/attach_api_pattern:OK
#417/3   uprobe_multi_test/attach_api_syms:OK
#417/4   uprobe_multi_test/link_api:OK
#417/5   uprobe_multi_test/bench_uprobe:OK
#417/6   uprobe_multi_test/bench_usdt:OK
#417/7   uprobe_multi_test/attach_api_fails:OK
#417/8   uprobe_multi_test/attach_uprobe_fails:OK
#417/9   uprobe_multi_test/consumers:OK
#417     uprobe_multi_test:OK

but occasionally I see this kernel fault:

#416     uprobe_autoattach:OK
User process fault: interruption code 0001 ilc:1 in test_progs[3c9ba2,2aa3b580000+cc5000]
CPU: 0 UID: 0 PID: 165 Comm: new_name Tainted: G           OE      6.10.0-12707-g8189b8007d01 #114
Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
Hardware name: QEMU 8561 QEMU (KVM/Linux)
User PSW : 0705000180000000 000002aa3b949ba2
           R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:1 AS:0 CC:0 PM:0 RI:0 EA:3
User GPRS: cccccccccccccccd 0000000000000000 000003ffbe080000 0000000000000000
           000003ffbeb74828 0000000000000006 0000000000000000 000002aa3c245928
           000003ffbeb2cbc0 000003ffbeb2d020 0000000000000003 000003ffdb379f20
           000003ffbeb2cf98 0000000000000000 000002aa3b94a400 000003ffdb379f20
User Code:>000002aa3b949ba2: 0000               illegal
           000002aa3b949ba4: 0700               bcr     0,%r0
           000002aa3b949ba6: b3cd00b0           lgdr    %r11,%f0
           000002aa3b949baa: 07fe               bcr     15,%r14
           000002aa3b949bac: 0707               bcr     0,%r7
           000002aa3b949bae: 0707               bcr     0,%r7
           000002aa3b949bb0: ebbff0580024       stmg    %r11,%r15,88(%r15)
           000002aa3b949bb6: e3f0ff48ff71       lay     %r15,-184(%r15)
Last Breaking-Event-Address:
 [<000002aa3b94a3fa>] test_progs[3ca3fa,2aa3b580000+cc5000]


Have you seen this fault before? Is the inode warning expected by the
test?

Aside from the tests above, I see only 3 failing tests:

All error logs:
test_map_ptr:PASS:skel_open 0 nsec
test_map_ptr:FAIL:skel_load unexpected error: -22 (errno 22)
#165     map_ptr:FAIL
subtest_userns:PASS:socketpair 0 nsec
subtest_userns:PASS:fork 0 nsec
recvfd:PASS:recvmsg 0 nsec
recvfd:PASS:cmsg_null 0 nsec
recvfd:PASS:cmsg_len 0 nsec
recvfd:PASS:cmsg_level 0 nsec
recvfd:PASS:cmsg_type 0 nsec
parent:PASS:recv_bpffs_fd 0 nsec
materialize_bpffs_fd:PASS:fs_cfg_cmds 0 nsec
materialize_bpffs_fd:PASS:fs_cfg_maps 0 nsec
materialize_bpffs_fd:PASS:fs_cfg_progs 0 nsec
materialize_bpffs_fd:PASS:fs_cfg_attachs 0 nsec
parent:PASS:materialize_bpffs_fd 0 nsec
sendfd:PASS:sendmsg 0 nsec
parent:PASS:send_mnt_fd 0 nsec
recvfd:PASS:recvmsg 0 nsec
recvfd:PASS:cmsg_null 0 nsec
recvfd:PASS:cmsg_len 0 nsec
recvfd:PASS:cmsg_level 0 nsec
recvfd:PASS:cmsg_type 0 nsec
parent:PASS:recv_token_fd 0 nsec
parent:FAIL:waitpid_child unexpected error: 22 (errno 3)
#402/9   token/obj_priv_implicit_token_envvar:FAIL
#402     token:FAIL
libbpf: prog 'on_event': BPF program load failed: Bad address
libbpf: prog 'on_event': -- BEGIN PROG LOAD LOG --
The sequence of 8193 jumps is too complex.
verification time 2816240 usec
stack depth 360
processed 116096 insns (limit 1000000) max_states_per_insn 1 total_states 5061 peak_states 5061 mark_read 2540
-- END PROG LOAD LOG --
libbpf: prog 'on_event': failed to load: -14
libbpf: failed to load object 'pyperf600.bpf.o'
scale_test:FAIL:expect_success unexpected error: -14 (errno 14)
#525     verif_scale_pyperf600:FAIL
Summary: 559/4166 PASSED, 98 SKIPPED, 3 FAILED


The test 'token/obj_priv_implicit_token_envvar' fails with both cross
and native-compiled test_progs, so unrelated to my patch. A quick strace
suggests like the child exits before it's waited for, and errno 3 is
'No such process'. Does that sound familiar? Maybe a race?

The 'verif_scale_pyperf600' and 'map_ptr' test failures both succeed if
run by native-compiled test_progs (copied from kernel-patches/bpf CI),
so I'm now trying to troubleshoot and compare native vs. cross-compiled
tests. The 'map_ptr' test uses a "light skeleton", and is proving tricky
to debug.

In any case, I'll also send out my patch series given the overall good
test results, and hope an eagle-eyed expert can spot something.

I'd appreciate anyone's thoughts or advice on troubleshooting these
errors. (CCing Alexei on light skeleton)

Thanks
Tony

