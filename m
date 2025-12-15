Return-Path: <bpf+bounces-76609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F0FCBE75F
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 16:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F046305D1D3
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 14:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537B7346FA0;
	Mon, 15 Dec 2025 14:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="js/ZpVUw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17640346E6D
	for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 14:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765809994; cv=none; b=ehEvpIAkpAsBI1flWXFNgH0yW0uJZR4zupDRLVhJRldrecIVDcvL+uyyIF+lKE/CtQIMMOxE10Kd9o1gzTCidpa5U4iucmG+XWHq4FuQcGok9xsdnY0XP2YqIyFmVtF2zdlbOtSq+zmCPSzPjpUCJbvCY//u4IhnUBgX9LTFABs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765809994; c=relaxed/simple;
	bh=Ht+IKKQHEG1PIRFlhRUVRARK+MWEIdJbyHUo4AUYWKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xrq+vztv9ZJgfWmq3/Bnx+hRgzhE5a/PKMHey9tCQphv6Rb6hely5RjbrN5RAabGub9rfXfTQqjyplm14pOBTE8CoiugLRDJzUtM+dZNIT+TMHe/29O7zic7kPgpNWvCrcuVeUfIL9AxrywtMqGVJboMnqIbRifd5BJ2DWNdqRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=js/ZpVUw; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a099233e8dso16314955ad.3
        for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 06:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765809992; x=1766414792; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NcZ0J3LsiiIX8WRILl25hAaX2Gq+7tYw9QQU7gkQf1g=;
        b=js/ZpVUwAxn7sEGboCaAtBFeSbqf/OzE7Jwx/0rdnwqwL8jizwMMthDhwg40KolvAQ
         lmViP+/AR1bm37ouySti1jw1TmiVrykI34rOeVyOaFsuzbECu7ZvI1ffDyPNawozMSu/
         yMw88n9X64QOiHBNUjyxznIEbTirNAibGz2ZwqBTRQCrpBZ56nzAYDAPUF9qljTa7MH7
         /7ircp70pfAi3gHJ0ElXP6CKnSavwMyIpO/fe4f1D3bPJD102J08qP5XtdEdxw+pEBOc
         YtrbAw++bxIXmXjrL8tGah/14RF/Z7Lu77vSqZeV9Jzaozf90q4YpEn6n+XmhPxYBNAo
         1jJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765809992; x=1766414792;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NcZ0J3LsiiIX8WRILl25hAaX2Gq+7tYw9QQU7gkQf1g=;
        b=jSfDN2737En7vJo0YE12X5VzAq0P1H7tOJOvVWFxvMoESQxkxFCtGoPsCfTAubjOx8
         Vj002S2jXo6pdQG9IuH5IULuB+yVfPV2LMj1U+AbuIGT4kIX7CMMfASsjFVUAF9DhML8
         PvSnFo/CmEE3Zn6KtpCBpocRDWMPcNd+s9/7kqsUIHbC4Na7dnrqtHUjLgeEOHQYe1n2
         U54hEk5btJRRftRSOLHDn+qMxOap9f0EcG0U2JFZvnFFY3TIfePevYnPJxTnRRTRGFBC
         ucEMl+hVqZsqToP4FCoXX8c8Ckn/YMfA+A5PaU3bMr3v+8qMb9KerAMQJR3mqm/TXnh4
         asig==
X-Forwarded-Encrypted: i=1; AJvYcCWliKbtI1G9h4FCOblsciGqbQ3tgHCtyKLuXCd2qQMqI9I9dVzBdRCZ+Cbf5lKrH74Q+hs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPN6xb8ZQHUz00K+7r3C3ct4fOJ7g2Xb7RF/mWDRANMzVshGSm
	ZP6it7CHkoxVDT6Ulwso+NohbPAQRMijtiqW8hDH6xkzpARqzIutItSD
X-Gm-Gg: AY/fxX4WUNIejawd/ncCEMXaeEbc7Iv7YNn8lCveg1ZZHuXM7N6fCQXKYV+JrtEVj5Z
	Gu4ffE+7oQEBvsCOFklY5W9H7ef3SSa1B6vY5/JXq9bL0grkTzCytn94tq9rlQnuqYzVs8Wb58X
	1l1vqPyEIdogteajCbpcZaJw3iXINLUGIVYaa3wgc2w0srhVLUHQ5XLDXhn5ITJVvIe4pgcoTpa
	ojoYG4rEo1Mlu63Dksjq1gYyvbJ/K2NWgdAikAltl8wRKZZIypsQyCu7jQfNnNIFFlKYmGroEut
	6eOzG8J7LFo+cHdhBXeab41Nlo7yWNsUJs9IaSQNVANXPI7mm45rZkem1DrHZPY2kc3Nl2h4jCA
	loJI06fx7cJlGR29M+HBrenSGp4+CEkqu3NNGxP6eB4gIVSwbzzl7kw28NLw3A5CePhV49ydW46
	rcyNwqqaqNv+JP2TSyOQ26BIVLa5mSscS00A==
X-Google-Smtp-Source: AGHT+IHaj0rZnTfRchf42pHwEH4oso1q++vaImKxuXj2se0FzWTlVQrogvv3Nx2HrQOMkNoRB+PKcQ==
X-Received: by 2002:a05:7300:2315:b0:2a4:874e:70cb with SMTP id 5a478bee46e88-2ac30106903mr8586110eec.26.1765809991810;
        Mon, 15 Dec 2025 06:46:31 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ac191e1eabsm29549772eec.4.2025.12.15.06.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:46:31 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 15 Dec 2025 06:46:29 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"D. Wythe" <alibuda@linux.alibaba.com>, bpf@vger.kernel.org,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Subject: Re: Linux 6.19-rc1
Message-ID: <516deeb7-102d-42ae-b925-64bba6281f14@roeck-us.net>
References: <CAHk-=wgizos80st3bL3EoEoh0+07u9zRjsw45M+RS-js-bcwag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wgizos80st3bL3EoEoh0+07u9zRjsw45M+RS-js-bcwag@mail.gmail.com>

On Sun, Dec 14, 2025 at 04:42:49PM +1200, Linus Torvalds wrote:
> So it's Sunday afternoon in the part of the world where I am now, so
> if somebody was looking at trying to limbo under the merge window
> timing with one last pull request and is taken by surprise by the
> slightly unusual timing of the rc1 release, that failed.
> 
> Teaching moment, or random capricious acts? You be the judge.
> 
> Anyway, this merge window was slightly unusual in how we had a number
> of kernel maintainers on the road the last week due to the yearly
> maintainer summit, but also in how some of the core pull requests were
> about various conversions to expand on and use more of our automatic
> compiler cleanup infrastructure. That happened in several subsystems,
> but the VFS layer stands out.
> 
> And on the Rust front, we are now starting to see several actual
> drivers starting to take form. The "mainly preparation and
> infrastructure" phase is starting to become "actual driver and
> subsystems development".
> 
> That said, despite a few unusual patterns, the big picture really
> looks pretty normal: half the rc1 patch is driver updates (gpu,
> networking, media and sound stand out as big subsystems as usual, but
> there's pretty much everything in there). The rest is all over the
> map, with architecture updates, tooling, Rust support, tooling,
> documentation, and core kernel (mm, scheduler, networking) updates.
> 

Initial test results below. I've looked into the build failures, but the
boot failures are too many and will take a significant amount of time to
analyze. The test results are at https://kerneltests.org/builders for
those interested in further details.

Guenter

---
Build results:
	total: 155 pass: 142 fail: 13
Failed builds:
	csky:allmodconfig
	m68k:allmodconfig
	mips:db1xxx_defconfig
	mips:mtx1_defconfig
	openrisc:allmodconfig
	sh:allnoconfig
	sh:tinyconfig
	sh:se7619_defconfig
	x86_64:defconfig
	x86_64:allyesconfig
	x86_64:allmodconfig
	x86_64:allnoconfig
	x86_64:tinyconfig
Qemu test results:
	total: 610 pass: 568 fail: 42
Failed tests:
	arm:realview-pbx-a9:realview_defconfig:realview_pb:net=default:arm-realview-pbx-a9:initrd
	arm:integratorcp:integrator_defconfig:mem128:net=default:integratorcp:initrd
	arm:integratorcp:integrator_defconfig:mem128:sd:net=default:integratorcp:ext2
	arm:integratorcp:integrator_defconfig:mem128:sd:net=default:integratorcp:cramfs
	arm:vexpress-a15:multi_v7_defconfig:nolocktests:sd:mem128:net=default:vexpress-v2p-ca15-tc1:ext2
	arm:fuji-bmc:aspeed_g5_defconfig:net=nic:aspeed-bmc-facebook-fuji:initrd
	arm:fuji-bmc:aspeed_g5_defconfig:sd2:net=nic:aspeed-bmc-facebook-fuji:ext2
	arm:fuji-bmc:aspeed_g5_defconfig:usb1:net=nic:aspeed-bmc-facebook-fuji:ext2
	arm:bletchley-bmc:aspeed_g5_defconfig:net=nic:aspeed-bmc-facebook-bletchley:initrd
	arm:bletchley-bmc:aspeed_g5_defconfig:usb0:net=nic:aspeed-bmc-facebook-bletchley:ext2
	arm:bletchley-bmc:aspeed_g5_defconfig:usb1:net=nic:aspeed-bmc-facebook-bletchley:ext2
	arm:bletchley-bmc:aspeed_g5_defconfig:mmc:net=nic:aspeed-bmc-facebook-bletchley:ext2
	m68k:mcf5208evb:m5208:m5208evb_defconfig:initrd
	parisc:C3700:net=tulip:scsi[AM53C974]:btrfs
	parisc:C3700:net=tulip:scsi[DC395]:f2fs
	parisc:C3700:net=tulip:usb-ohci:f2fs
	parisc:C3700:net=virtio-net:usb-ehci:ext2
	parisc:C3700:net=pcnet:usb-xhci:ext4
	parisc:C3700:net=usb-ohci:usb-uas-ehci:btrfs
	parisc:C3700:net=rtl8139:usb-uas-xhci:f2fs
	ppc64:ppce500:corenet64_smp_defconfig:e5500:net=rtl8139:initrd
	ppc64:ppce500:corenet64_smp_defconfig:e5500:net=tulip:scsi[53C895A]:rootfs
	ppc64:ppce500:corenet64_smp_defconfig:e5500:net=i82562:sata-sii3112:rootfs
	sh:rts7751r2dplus_defconfig:net=rtl8139:initrd
	sh:rts7751r2dplus_defconfig:flash16,2304K,3:net=usb-ohci:rootfs
	sh:rts7751r2dplus_defconfig:ata:net=virtio-net:rootfs
	sh:rts7751r2dplus_defconfig:sdhci-mmc:net=i82801:rootfs
	sh:rts7751r2dplus_defconfig:nvme:net=tulip:rootfs
	sh:rts7751r2dplus_defconfig:usb:net=i82550:rootfs
	sh:rts7751r2dplus_defconfig:usb-hub:net=rtl8139:rootfs
	sh:rts7751r2dplus_defconfig:usb-ohci:net=i82557a:rootfs
	sh:rts7751r2dplus_defconfig:usb-ehci:net=i82562:rootfs
	sh:rts7751r2dplus_defconfig:usb-xhci:net=rtl8139:rootfs
	sh:rts7751r2dplus_defconfig:usb-uas-ehci:net=rtl8139:rootfs
	sh:rts7751r2dplus_defconfig:usb-uas-xhci:net=rtl8139:rootfs
	sh:rts7751r2dplus_defconfig:scsi[53C810]:net=rtl8139:rootfs
	sh:rts7751r2dplus_defconfig:scsi[53C895A]:net=rtl8139:rootfs
	sh:rts7751r2dplus_defconfig:scsi[DC395]:net=rtl8139:rootfs
	sh:rts7751r2dplus_defconfig:scsi[AM53C974]:net=rtl8139:rootfs
	sh:rts7751r2dplus_defconfig:scsi[FUSION]:net=rtl8139:rootfs
	x86_64:q35:SandyBridge:defconfig:rt:smp4:net=ne2k_pci:efi32:mem1G:usb:fstest=nilfs2:squashfs
	x86_64:q35:SandyBridge:defconfig:rt:smp8:net=ne2k_pci:mem1G:usb-hub:f2fs
Unit test results:
	pass: 745749 fail: 56

=====================================
Build failure details:

Building csky:allmodconfig ... failed
Building m68k:allmodconfig ... failed
Building openrisc:allmodconfig ... failed
--------------
Error log:
In file included from include/linux/bpf_verifier.h:7,
                 from net/smc/smc_hs_bpf.c:13:
net/smc/smc_hs_bpf.c: In function 'bpf_smc_hs_ctrl_init':
include/linux/bpf.h:2068:50: error: statement with no effect [-Werror=unused-value]
 2068 | #define register_bpf_struct_ops(st_ops, type) ({ (void *)(st_ops); 0; })
      |                                                  ^~~~~~~~~~~~~~~~
net/smc/smc_hs_bpf.c:139:16: note: in expansion of macro 'register_bpf_struct_ops'
  139 |         return register_bpf_struct_ops(&bpf_smc_hs_ctrl_ops, smc_hs_ctrl);

Introduced by commit 15f295f55656 ("net/smc: bpf: Introduce generic hook for
handshake flow").

-----------------------------------------
Building mips:db1xxx_defconfig ... failed
Building mips:mtx1_defconfig ... failed

--------------
Error log:
In file included from include/linux/pgtable.h:6,
                 from include/linux/mm.h:31,
                 from arch/mips/alchemy/common/setup.c:30:
arch/mips/include/asm/pgtable.h:608:32: error: static declaration of 'io_remap_pfn_range_pfn' follows non-static declaration
  608 | #define io_remap_pfn_range_pfn io_remap_pfn_range_pfn
      |                                ^~~~~~~~~~~~~~~~~~~~~~
arch/mips/alchemy/common/setup.c:97:29: note: in expansion of macro 'io_remap_pfn_range_pfn'
   97 | static inline unsigned long io_remap_pfn_range_pfn(unsigned long pfn,
      |                             ^~~~~~~~~~~~~~~~~~~~~~
arch/mips/include/asm/pgtable.h:607:15: note: previous declaration of 'io_remap_pfn_range_pfn' with type 'long unsigned int(long unsigned int,  long unsigned int)'
  607 | unsigned long io_remap_pfn_range_pfn(unsigned long pfn, unsigned long size);
      |               ^~~~~~~~~~~~~~~~~~~~~~

Probably caused by commit c707a68f9468 ("mm: abstract io_remap_pfn_range()
based on PFN") or related patches. Still bisecting.

-----------------------------------------
Building sh:allnoconfig ... failed
Building sh:tinyconfig ... failed
Building sh:se7619_defconfig ... failed

ICE:

during RTL pass: final
In file included from kernel/nstree.c:8:
kernel/nstree.c: In function '__se_sys_listns':
include/linux/syscalls.h:262:9: internal compiler error: in change_address_1, at emit-rtl.cc:2299
  262 |         }                                                               \
      |         ^
include/linux/syscalls.h:237:9: note: in expansion of macro '__SYSCALL_DEFINEx'
  237 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
      |         ^~~~~~~~~~~~~~~~~
include/linux/syscalls.h:229:36: note: in expansion of macro 'SYSCALL_DEFINEx'
  229 | #define SYSCALL_DEFINE4(name, ...) SYSCALL_DEFINEx(4, _##name, __VA_ARGS__)
      |                                    ^~~~~~~~~~~~~~~
kernel/nstree.c:784:1: note: in expansion of macro 'SYSCALL_DEFINE4'
  784 | SYSCALL_DEFINE4(listns, const struct ns_id_req __user *, req,

Seen with gcc 12, 13, 14, and 15. No idea what to do about it.
I may have to stop building those targets.

-----------------------------------------
Building x86_64:defconfig ... failed
Building x86_64:allyesconfig ... failed
Building x86_64:allmodconfig ... failed
Building x86_64:allnoconfig ... failed
Building x86_64:tinyconfig ... failed
--------------
Error log:
In file included from disas.c:17:
tools/include/tools/dis-asm-compat.h:19:39: error: ‘enum disassembler_style’ declared inside parameter list will not be visible outside of this definition or declaration
    x86_64:defconfig
    x86_64:allyesconfig
    x86_64:allmodconfig
    x86_64:allnoconfig
    x86_64:tinyconfig

The problem is that the system's version of binutils (2.38) and the
toolchain verison of binutils (2.44) don't match. The tools build
evaluates binutils features using the toolchain provided, but then tries
to build disas.o using the system toolchain which does not have the same
features, causing the build failure.

The problem is seen if, for example, Ubuntu 22.04 or older is installed
and a toolchain using a more recent version of binutils is used to
build the kernel.

Long story short, the toolchain binutils version and the system binutils
version must now match closely enough for kernel builds to succeed.
I am in the process of updating all my test systems to Ubuntu 24.04,
so this is just informational and I won't report it again.

Introduced by commit 59953303827e ("objtool: Disassemble code with
libopcodes instead of running objdump").

