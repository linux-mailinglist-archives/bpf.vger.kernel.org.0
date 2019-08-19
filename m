Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1C6994C9A
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2019 20:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbfHSSWY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Aug 2019 14:22:24 -0400
Received: from mga18.intel.com ([134.134.136.126]:53390 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727957AbfHSSWX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Aug 2019 14:22:23 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Aug 2019 11:22:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,405,1559545200"; 
   d="gz'50?scan'50,208,50";a="378280570"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 19 Aug 2019 11:22:19 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hzmIN-000IfS-5A; Tue, 20 Aug 2019 02:22:19 +0800
Date:   Tue, 20 Aug 2019 02:22:13 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     kbuild-all@01.org, bpf@vger.kernel.org, songliubraving@fb.com,
        yhs@fb.com, andriin@fb.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, Daniel Xu <dxu@dxuuu.xyz>, ast@fb.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v3 bpf-next 1/4] tracing/probe: Add
 PERF_EVENT_IOC_QUERY_PROBE ioctl
Message-ID: <201908200208.K4BucdIQ%lkp@intel.com>
References: <20190816223149.5714-2-dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="jqv55zog5ji7egne"
Content-Disposition: inline
In-Reply-To: <20190816223149.5714-2-dxu@dxuuu.xyz>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


--jqv55zog5ji7egne
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Daniel,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on bpf-next/master]

url:    https://github.com/0day-ci/linux/commits/Daniel-Xu/tracing-probe-Add-PERF_EVENT_IOC_QUERY_PROBE-ioctl/20190820-003910
base:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/bpf/bpf-next.git master
config: i386-alldefconfig (attached as .config)
compiler: gcc-7 (Debian 7.4.0-10) 7.4.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: init/do_mounts.o: in function `perf_kprobe_event_query':
>> do_mounts.c:(.text+0x80): multiple definition of `perf_kprobe_event_query'; init/main.o:main.c:(.text+0x80): first defined here
   ld: init/do_mounts.o: in function `perf_uprobe_event_query':
>> do_mounts.c:(.text+0x90): multiple definition of `perf_uprobe_event_query'; init/main.o:main.c:(.text+0x90): first defined here
   ld: init/noinitramfs.o: in function `perf_kprobe_event_query':
   noinitramfs.c:(.text+0x0): multiple definition of `perf_kprobe_event_query'; init/main.o:main.c:(.text+0x80): first defined here
   ld: init/noinitramfs.o: in function `perf_uprobe_event_query':
   noinitramfs.c:(.text+0x10): multiple definition of `perf_uprobe_event_query'; init/main.o:main.c:(.text+0x90): first defined here
   ld: arch/x86/entry/common.o: in function `perf_kprobe_event_query':
   common.c:(.text+0x2c0): multiple definition of `perf_kprobe_event_query'; init/main.o:main.c:(.text+0x80): first defined here
   ld: arch/x86/entry/common.o: in function `perf_uprobe_event_query':
   common.c:(.text+0x2d0): multiple definition of `perf_uprobe_event_query'; init/main.o:main.c:(.text+0x90): first defined here
   ld: arch/x86/kernel/process_32.o: in function `perf_kprobe_event_query':
   process_32.c:(.text+0x0): multiple definition of `perf_kprobe_event_query'; init/main.o:main.c:(.text+0x80): first defined here
   ld: arch/x86/kernel/process_32.o: in function `perf_uprobe_event_query':
   process_32.c:(.text+0x10): multiple definition of `perf_uprobe_event_query'; init/main.o:main.c:(.text+0x90): first defined here
   ld: arch/x86/kernel/signal.o: in function `perf_kprobe_event_query':
   signal.c:(.text+0x2e0): multiple definition of `perf_kprobe_event_query'; init/main.o:main.c:(.text+0x80): first defined here
   ld: arch/x86/kernel/signal.o: in function `perf_uprobe_event_query':
   signal.c:(.text+0x2f0): multiple definition of `perf_uprobe_event_query'; init/main.o:main.c:(.text+0x90): first defined here
   ld: arch/x86/kernel/ioport.o: in function `perf_kprobe_event_query':
   ioport.c:(.text+0x0): multiple definition of `perf_kprobe_event_query'; init/main.o:main.c:(.text+0x80): first defined here
   ld: arch/x86/kernel/ioport.o: in function `perf_uprobe_event_query':
   ioport.c:(.text+0x10): multiple definition of `perf_uprobe_event_query'; init/main.o:main.c:(.text+0x90): first defined here
   ld: arch/x86/kernel/ldt.o: in function `perf_kprobe_event_query':
   ldt.c:(.text+0x500): multiple definition of `perf_kprobe_event_query'; init/main.o:main.c:(.text+0x80): first defined here
   ld: arch/x86/kernel/ldt.o: in function `perf_uprobe_event_query':
   ldt.c:(.text+0x510): multiple definition of `perf_uprobe_event_query'; init/main.o:main.c:(.text+0x90): first defined here
   ld: arch/x86/kernel/process.o: in function `perf_kprobe_event_query':
   process.c:(.text+0xe0): multiple definition of `perf_kprobe_event_query'; init/main.o:main.c:(.text+0x80): first defined here
   ld: arch/x86/kernel/process.o: in function `perf_uprobe_event_query':
   process.c:(.text+0xf0): multiple definition of `perf_uprobe_event_query'; init/main.o:main.c:(.text+0x90): first defined here
   ld: arch/x86/kernel/tls.o: in function `perf_kprobe_event_query':
   tls.c:(.text+0x2c0): multiple definition of `perf_kprobe_event_query'; init/main.o:main.c:(.text+0x80): first defined here
   ld: arch/x86/kernel/tls.o: in function `perf_uprobe_event_query':
   tls.c:(.text+0x2d0): multiple definition of `perf_uprobe_event_query'; init/main.o:main.c:(.text+0x90): first defined here
   ld: kernel/fork.o: in function `perf_kprobe_event_query':
   fork.c:(.text+0x510): multiple definition of `perf_kprobe_event_query'; init/main.o:main.c:(.text+0x80): first defined here
   ld: kernel/fork.o: in function `perf_uprobe_event_query':
   fork.c:(.text+0x520): multiple definition of `perf_uprobe_event_query'; init/main.o:main.c:(.text+0x90): first defined here
   ld: kernel/exec_domain.o: in function `perf_kprobe_event_query':
   exec_domain.c:(.text+0x20): multiple definition of `perf_kprobe_event_query'; init/main.o:main.c:(.text+0x80): first defined here
   ld: kernel/exec_domain.o: in function `perf_uprobe_event_query':
   exec_domain.c:(.text+0x30): multiple definition of `perf_uprobe_event_query'; init/main.o:main.c:(.text+0x90): first defined here
   ld: kernel/cpu.o: in function `perf_kprobe_event_query':
   cpu.c:(.text+0x1b0): multiple definition of `perf_kprobe_event_query'; init/main.o:main.c:(.text+0x80): first defined here
   ld: kernel/cpu.o: in function `perf_uprobe_event_query':
   cpu.c:(.text+0x1c0): multiple definition of `perf_uprobe_event_query'; init/main.o:main.c:(.text+0x90): first defined here
   ld: kernel/exit.o: in function `perf_kprobe_event_query':
   exit.c:(.text+0x260): multiple definition of `perf_kprobe_event_query'; init/main.o:main.c:(.text+0x80): first defined here
   ld: kernel/exit.o: in function `perf_uprobe_event_query':
   exit.c:(.text+0x270): multiple definition of `perf_uprobe_event_query'; init/main.o:main.c:(.text+0x90): first defined here
   ld: kernel/sysctl.o: in function `perf_kprobe_event_query':
   sysctl.c:(.text+0x1790): multiple definition of `perf_kprobe_event_query'; init/main.o:main.c:(.text+0x80): first defined here
   ld: kernel/sysctl.o: in function `perf_uprobe_event_query':
   sysctl.c:(.text+0x17a0): multiple definition of `perf_uprobe_event_query'; init/main.o:main.c:(.text+0x90): first defined here
   ld: kernel/sysctl_binary.o: in function `perf_kprobe_event_query':
   sysctl_binary.c:(.text+0x0): multiple definition of `perf_kprobe_event_query'; init/main.o:main.c:(.text+0x80): first defined here
   ld: kernel/sysctl_binary.o: in function `perf_uprobe_event_query':
   sysctl_binary.c:(.text+0x10): multiple definition of `perf_uprobe_event_query'; init/main.o:main.c:(.text+0x90): first defined here
   ld: kernel/capability.o: in function `perf_kprobe_event_query':
   capability.c:(.text+0x170): multiple definition of `perf_kprobe_event_query'; init/main.o:main.c:(.text+0x80): first defined here
   ld: kernel/capability.o: in function `perf_uprobe_event_query':
   capability.c:(.text+0x180): multiple definition of `perf_uprobe_event_query'; init/main.o:main.c:(.text+0x90): first defined here
   ld: kernel/ptrace.o: in function `perf_kprobe_event_query':
   ptrace.c:(.text+0x680): multiple definition of `perf_kprobe_event_query'; init/main.o:main.c:(.text+0x80): first defined here
   ld: kernel/ptrace.o: in function `perf_uprobe_event_query':
   ptrace.c:(.text+0x690): multiple definition of `perf_uprobe_event_query'; init/main.o:main.c:(.text+0x90): first defined here
   ld: kernel/signal.o: in function `perf_kprobe_event_query':
   signal.c:(.text+0x810): multiple definition of `perf_kprobe_event_query'; init/main.o:main.c:(.text+0x80): first defined here
   ld: kernel/signal.o: in function `perf_uprobe_event_query':
   signal.c:(.text+0x820): multiple definition of `perf_uprobe_event_query'; init/main.o:main.c:(.text+0x90): first defined here
   ld: kernel/sys.o: in function `perf_kprobe_event_query':
   sys.c:(.text+0xa40): multiple definition of `perf_kprobe_event_query'; init/main.o:main.c:(.text+0x80): first defined here
   ld: kernel/sys.o: in function `perf_uprobe_event_query':
   sys.c:(.text+0xa50): multiple definition of `perf_uprobe_event_query'; init/main.o:main.c:(.text+0x90): first defined here
   ld: kernel/umh.o: in function `perf_kprobe_event_query':
   umh.c:(.text+0x4b0): multiple definition of `perf_kprobe_event_query'; init/main.o:main.c:(.text+0x80): first defined here
   ld: kernel/umh.o: in function `perf_uprobe_event_query':
   umh.c:(.text+0x4c0): multiple definition of `perf_uprobe_event_query'; init/main.o:main.c:(.text+0x90): first defined here
   ld: kernel/pid.o: in function `perf_kprobe_event_query':
   pid.c:(.text+0x0): multiple definition of `perf_kprobe_event_query'; init/main.o:main.c:(.text+0x80): first defined here
   ld: kernel/pid.o: in function `perf_uprobe_event_query':
   pid.c:(.text+0x10): multiple definition of `perf_uprobe_event_query'; init/main.o:main.c:(.text+0x90): first defined here
   ld: kernel/nsproxy.o: in function `perf_kprobe_event_query':
   nsproxy.c:(.text+0x1e0): multiple definition of `perf_kprobe_event_query'; init/main.o:main.c:(.text+0x80): first defined here
   ld: kernel/nsproxy.o: in function `perf_uprobe_event_query':
   nsproxy.c:(.text+0x1f0): multiple definition of `perf_uprobe_event_query'; init/main.o:main.c:(.text+0x90): first defined here
   ld: kernel/reboot.o: in function `perf_kprobe_event_query':
   reboot.c:(.text+0x90): multiple definition of `perf_kprobe_event_query'; init/main.o:main.c:(.text+0x80): first defined here
   ld: kernel/reboot.o: in function `perf_uprobe_event_query':
   reboot.c:(.text+0xa0): multiple definition of `perf_uprobe_event_query'; init/main.o:main.c:(.text+0x90): first defined here
   ld: kernel/groups.o: in function `perf_kprobe_event_query':
   groups.c:(.text+0x20): multiple definition of `perf_kprobe_event_query'; init/main.o:main.c:(.text+0x80): first defined here
   ld: kernel/groups.o: in function `perf_uprobe_event_query':
   groups.c:(.text+0x30): multiple definition of `perf_uprobe_event_query'; init/main.o:main.c:(.text+0x90): first defined here
   ld: kernel/sched/core.o: in function `perf_kprobe_event_query':
   core.c:(.text+0xdf0): multiple definition of `perf_kprobe_event_query'; init/main.o:main.c:(.text+0x80): first defined here
   ld: kernel/sched/core.o: in function `perf_uprobe_event_query':
   core.c:(.text+0xe00): multiple definition of `perf_uprobe_event_query'; init/main.o:main.c:(.text+0x90): first defined here
   ld: kernel/sched/loadavg.o: in function `perf_kprobe_event_query':
   loadavg.c:(.text+0x0): multiple definition of `perf_kprobe_event_query'; init/main.o:main.c:(.text+0x80): first defined here
   ld: kernel/sched/loadavg.o: in function `perf_uprobe_event_query':
   loadavg.c:(.text+0x10): multiple definition of `perf_uprobe_event_query'; init/main.o:main.c:(.text+0x90): first defined here

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--jqv55zog5ji7egne
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--jqv55zog5ji7egne--
