Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C9F392D7B
	for <lists+bpf@lfdr.de>; Thu, 27 May 2021 14:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234395AbhE0ME2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 May 2021 08:04:28 -0400
Received: from outbound-smtp21.blacknight.com ([81.17.249.41]:55407 "EHLO
        outbound-smtp21.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234715AbhE0ME1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 27 May 2021 08:04:27 -0400
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp21.blacknight.com (Postfix) with ESMTPS id CA882CCC01
        for <bpf@vger.kernel.org>; Thu, 27 May 2021 13:02:52 +0100 (IST)
Received: (qmail 32327 invoked from network); 27 May 2021 12:02:52 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.23.168])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 27 May 2021 12:02:52 -0000
Date:   Thu, 27 May 2021 13:02:51 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Michal Suchanek <msuchanek@suse.de>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Hritik Vijay <hritikxx8@gmail.com>,
        Linux-BPF <bpf@vger.kernel.org>,
        Linux-Net <netdev@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>
Subject: [PATCH v2] mm/page_alloc: Work around a pahole limitation with
 zero-sized struct pagesets
Message-ID: <20210527120251.GC30378@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch replaces
mm-page_alloc-convert-per-cpu-list-protection-to-local_lock-fix.patch in
Andrew's tree.

Michal Suchanek reported the following problem with linux-next

  [    0.000000] Linux version 5.13.0-rc2-next-20210519-1.g3455ff8-vanilla (geeko@buildhost) (gcc (SUSE Linux) 10.3.0, GNU ld (GNU Binutils; openSUSE Tumbleweed) 2.36.1.20210326-3) #1 SMP Wed May 19 10:05:10 UTC 2021 (3455ff8)
  [    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.13.0-rc2-next-20210519-1.g3455ff8-vanilla root=UUID=ec42c33e-a2c2-4c61-afcc-93e9527 8f687 plymouth.enable=0 resume=/dev/disk/by-uuid/f1fe4560-a801-4faf-a638-834c407027c7 mitigations=auto earlyprintk initcall_debug nomodeset earlycon ignore_loglevel console=ttyS0,115200
...
  [   26.093364] calling  tracing_set_default_clock+0x0/0x62 @ 1
  [   26.098937] initcall tracing_set_default_clock+0x0/0x62 returned 0 after 0 usecs
  [   26.106330] calling  acpi_gpio_handle_deferred_request_irqs+0x0/0x7c @ 1
  [   26.113033] initcall acpi_gpio_handle_deferred_request_irqs+0x0/0x7c returned 0 after 3 usecs
  [   26.121559] calling  clk_disable_unused+0x0/0x102 @ 1
  [   26.126620] initcall clk_disable_unused+0x0/0x102 returned 0 after 0 usecs
  [   26.133491] calling  regulator_init_complete+0x0/0x25 @ 1
  [   26.138890] initcall regulator_init_complete+0x0/0x25 returned 0 after 0 usecs
  [   26.147816] Freeing unused decrypted memory: 2036K
  [   26.153682] Freeing unused kernel image (initmem) memory: 2308K
  [   26.165776] Write protecting the kernel read-only data: 26624k
  [   26.173067] Freeing unused kernel image (text/rodata gap) memory: 2036K
  [   26.180416] Freeing unused kernel image (rodata/data gap) memory: 1184K
  [   26.187031] Run /init as init process
  [   26.190693]   with arguments:
  [   26.193661]     /init
  [   26.195933]   with environment:
  [   26.199079]     HOME=/
  [   26.201444]     TERM=linux
  [   26.204152]     BOOT_IMAGE=/boot/vmlinuz-5.13.0-rc2-next-20210519-1.g3455ff8-vanilla
  [   26.254154] BPF:      type_id=35503 offset=178440 size=4
  [   26.259125] BPF:
  [   26.261054] BPF:Invalid offset
  [   26.264119] BPF:
  [   26.264119]
  [   26.267437] failed to validate module [efivarfs] BTF: -22

Andrii Nakryiko bisected the problem to the commit "mm/page_alloc: convert
per-cpu list protection to local_lock" currently staged in mmotm. In his
own words

  The immediate problem is two different definitions of numa_node per-cpu
  variable. They both are at the same offset within .data..percpu ELF
  section, they both have the same name, but one of them is marked as
  static and another as global. And one is int variable, while another
  is struct pagesets. I'll look some more tomorrow, but adding Jiri and
  Arnaldo for visibility.

  [110907] DATASEC '.data..percpu' size=178904 vlen=303
  ...
        type_id=27753 offset=163976 size=4 (VAR 'numa_node')
        type_id=27754 offset=163976 size=4 (VAR 'numa_node')

  [27753] VAR 'numa_node' type_id=27556, linkage=static
  [27754] VAR 'numa_node' type_id=20, linkage=global

  [20] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED

  [27556] STRUCT 'pagesets' size=0 vlen=1
        'lock' type_id=507 bits_offset=0

  [506] STRUCT '(anon)' size=0 vlen=0
  [507] TYPEDEF 'local_lock_t' type_id=506

The patch in question introduces a zero-sized per-cpu struct and while
this is not wrong, versions of pahole prior to 1.22 (unreleased) get
confused during BTF generation with two separate variables occupying the
same address.

This patch checks for older versions of pahole and only allows
DEBUG_INFO_BTF_MODULES if pahole supports zero-sized per-cpu structures.
DEBUG_INFO_BTF is still allowed as a KVM boot test passed with pahole
v1.19.  While pahole 1.22 does not exist yet, it is assumed that Hritik's
fix that allows DEBUG_INFO_BTF_MODULES to work will be included in that
release.

Reported-by: Michal Suchanek <msuchanek@suse.de>
Reported-by: Hritik Vijay <hritikxx8@gmail.com>
Debugged-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 lib/Kconfig.debug | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 678c13967580..51b355cbe6d7 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -313,9 +313,12 @@ config DEBUG_INFO_BTF
 config PAHOLE_HAS_SPLIT_BTF
 	def_bool $(success, test `$(PAHOLE) --version | sed -E 's/v([0-9]+)\.([0-9]+)/\1\2/'` -ge "119")
 
+config PAHOLE_HAS_ZEROSIZE_PERCPU_SUPPORT
+	def_bool $(success, test `$(PAHOLE) --version | sed -E 's/v([0-9]+)\.([0-9]+)/\1\2/'` -ge "122")
+
 config DEBUG_INFO_BTF_MODULES
 	def_bool y
-	depends on DEBUG_INFO_BTF && MODULES && PAHOLE_HAS_SPLIT_BTF
+	depends on DEBUG_INFO_BTF && MODULES && PAHOLE_HAS_SPLIT_BTF && PAHOLE_HAS_ZEROSIZE_PERCPU_SUPPORT
 	help
 	  Generate compact split BTF type information for kernel modules.
 
