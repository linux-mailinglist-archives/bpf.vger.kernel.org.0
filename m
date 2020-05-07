Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7C81C817D
	for <lists+bpf@lfdr.de>; Thu,  7 May 2020 07:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbgEGFUY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 May 2020 01:20:24 -0400
Received: from mga14.intel.com ([192.55.52.115]:42017 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbgEGFUY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 May 2020 01:20:24 -0400
IronPort-SDR: gyv1YDhOGHMn8I1r4LqSupOq9Iq+E/x37/PN1HuqXvgJuJs9BZouK+yrvvXA+H4C6cWsm5WdQ7
 EAfZj+sKrX4A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 22:20:23 -0700
IronPort-SDR: gdDFospjotObt+Bfvr4m9JoONfqPIonuioR93iuCDRUhDNgw0leD5kDFY4Gct5mT/6xZ6dyvHC
 bLVRg82E0rSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,362,1583222400"; 
   d="scan'208";a="249994158"
Received: from yyin5-mobl1.ccr.corp.intel.com (HELO [10.255.30.83]) ([10.255.30.83])
  by fmsmga007.fm.intel.com with ESMTP; 06 May 2020 22:20:22 -0700
To:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
From:   Ma Xinjian <max.xinjian@intel.com>
Subject: bprm_count and stack_mprotect error when testing BPF LSM on v5.7-rc3
Message-ID: <3ab505db-9e04-366b-d602-6b2935739f54@intel.com>
Date:   Thu, 7 May 2020 13:19:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

When I test bpf lsm with (/test_progs -vv  -t test_lsm ), failed with 
below issue:

root@lkp-skl-d01 
/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-bpf-lsm-2-6a8b55ed4056ea5559ebe4f6a4b247f627870d4c/tools/testing/selftests/bpf# 
./test_progs -vv  -t test_lsm

libbpf: loading object 'lsm' from buffer
libbpf: section(1) .strtab, size 306, link 0, flags 0, type=3
libbpf: skip section(1) .strtab
libbpf: section(2) .text, size 0, link 0, flags 6, type=1
libbpf: skip section(2) .text
libbpf: section(3) lsm/file_mprotect, size 192, link 0, flags 6, type=1
libbpf: found program lsm/file_mprotect
libbpf: section(4) .rellsm/file_mprotect, size 32, link 25, flags 0, type=9
libbpf: section(5) lsm/bprm_committed_creds, size 104, link 0, flags 6, 
type=1
libbpf: found program lsm/bprm_committed_creds
libbpf: section(6) .rellsm/bprm_committed_creds, size 32, link 25, flags 
0, type=9
libbpf: section(7) license, size 4, link 0, flags 3, type=1
libbpf: license of lsm is GPL
libbpf: section(8) .bss, size 12, link 0, flags 3, type=8
libbpf: section(9) .debug_loc, size 383, link 0, flags 0, type=1
libbpf: skip section(9) .debug_loc
libbpf: section(10) .rel.debug_loc, size 112, link 25, flags 0, type=9
libbpf: skip relo .rel.debug_loc(10) for section(9)
libbpf: section(11) .debug_abbrev, size 901, link 0, flags 0, type=1
libbpf: skip section(11) .debug_abbrev
libbpf: section(12) .debug_info, size 237441, link 0, flags 0, type=1
libbpf: skip section(12) .debug_info
libbpf: section(13) .rel.debug_info, size 112, link 25, flags 0, type=9
libbpf: skip relo .rel.debug_info(13) for section(12)
libbpf: section(14) .debug_ranges, size 96, link 0, flags 0, type=1
libbpf: skip section(14) .debug_ranges
libbpf: section(15) .rel.debug_ranges, size 128, link 25, flags 0, type=9
libbpf: skip relo .rel.debug_ranges(15) for section(14)
libbpf: section(16) .debug_str, size 142395, link 0, flags 30, type=1
libbpf: skip section(16) .debug_str
libbpf: section(17) .BTF, size 5634, link 0, flags 0, type=1
libbpf: section(18) .rel.BTF, size 64, link 25, flags 0, type=9
libbpf: skip relo .rel.BTF(18) for section(17)
libbpf: section(19) .BTF.ext, size 484, link 0, flags 0, type=1
libbpf: section(20) .rel.BTF.ext, size 416, link 25, flags 0, type=9
libbpf: skip relo .rel.BTF.ext(20) for section(19)
libbpf: section(21) .debug_frame, size 64, link 0, flags 0, type=1
libbpf: skip section(21) .debug_frame
libbpf: section(22) .rel.debug_frame, size 32, link 25, flags 0, type=9
libbpf: skip relo .rel.debug_frame(22) for section(21)
libbpf: section(23) .debug_line, size 227, link 0, flags 0, type=1
libbpf: skip section(23) .debug_line
libbpf: section(24) .rel.debug_line, size 32, link 25, flags 0, type=9
libbpf: skip relo .rel.debug_line(24) for section(23)
libbpf: section(25) .symtab, size 288, link 1, flags 0, type=2
libbpf: looking for externs among 12 symbols...
libbpf: collected 0 externs total
libbpf: map 'lsm.bss' (global data): at sec_idx 8, offset 0, flags 400.
libbpf: map 0 is "lsm.bss"
libbpf: collecting relocating info for: 'lsm/file_mprotect'
libbpf: relo for shdr 8, symb 8, value 0, type 1, bind 1, name 232 
('monitored_pid'), insn 12
libbpf: found data map 0 (lsm.bss, sec 8, off 0) for insn 12
libbpf: relo for shdr 8, symb 9, value 4, type 1, bind 1, name 34 
('mprotect_count'), insn 17
libbpf: found data map 0 (lsm.bss, sec 8, off 0) for insn 17
libbpf: collecting relocating info for: 'lsm/bprm_committed_creds'
libbpf: relo for shdr 8, symb 8, value 0, type 1, bind 1, name 232 
('monitored_pid'), insn 1
libbpf: found data map 0 (lsm.bss, sec 8, off 0) for insn 1
libbpf: relo for shdr 8, symb 7, value 8, type 1, bind 1, name 49 
('bprm_count'), insn 6
libbpf: found data map 0 (lsm.bss, sec 8, off 0) for insn 6
libbpf: loading kernel BTF '/sys/kernel/btf/vmlinux': 0
libbpf: created map lsm.bss: fd=4
libbpf: loading kernel BTF '/sys/kernel/btf/vmlinux': 0
libbpf: prog 'lsm/file_mprotect': performing 4 CO-RE offset relocs
libbpf: prog 'lsm/file_mprotect': relo #0: kind 0, spec is [6] 
vm_area_struct + 0:6 => 64.0 @ &x[0].vm_mm
libbpf: [6] vm_area_struct: found candidate [329] vm_area_struct
libbpf: prog 'lsm/file_mprotect': relo #0: matching candidate #0 
vm_area_struct against spec [329] vm_area_struct + 0:6 => 64.0 @ 
&x[0].vm_mm: 1
libbpf: prog 'lsm/file_mprotect': relo #0: patched insn #5 (LDX/ST/STX) 
off 64 -> 64
libbpf: prog 'lsm/file_mprotect': relo #1: kind 0, spec is [32] 
mm_struct + 0:0:35 => 304.0 @ &x[0].start_stack
libbpf: [32] mm_struct: found candidate [308] mm_struct
libbpf: prog 'lsm/file_mprotect': relo #1: matching candidate #0 
mm_struct against spec [308] mm_struct + 0:0:35 => 304.0 @ 
&x[0].start_stack: 1
libbpf: prog 'lsm/file_mprotect': relo #1: patched insn #7 (LDX/ST/STX) 
off 304 -> 304
libbpf: prog 'lsm/file_mprotect': relo #2: kind 0, spec is [6] 
vm_area_struct + 0:0 => 0.0 @ &x[0].vm_start
libbpf: prog 'lsm/file_mprotect': relo #2: matching candidate #0 
vm_area_struct against spec [329] vm_area_struct + 0:0 => 0.0 @ 
&x[0].vm_start: 1
libbpf: prog 'lsm/file_mprotect': relo #2: patched insn #8 (LDX/ST/STX) 
off 0 -> 0
libbpf: prog 'lsm/file_mprotect': relo #3: kind 0, spec is [6] 
vm_area_struct + 0:1 => 8.0 @ &x[0].vm_end
libbpf: prog 'lsm/file_mprotect': relo #3: matching candidate #0 
vm_area_struct against spec [329] vm_area_struct + 0:1 => 8.0 @ 
&x[0].vm_end: 1
libbpf: prog 'lsm/file_mprotect': relo #3: patched insn #10 (LDX/ST/STX) 
off 8 -> 8
test_test_lsm:PASS:skel_load 0 nsec
test_test_lsm:PASS:attach 0 nsec
test_test_lsm:PASS:exec_cmd 0 nsec
test_test_lsm:FAIL:bprm_count bprm_count = 0
test_test_lsm:FAIL:stack_mprotect want err=EPERM, got 0
#70 test_lsm:FAIL
Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED


kconfig:

CONFIG_BPF_LSM=y

CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"

besides:

when I add bpf to CONFIG_LSM, then boot failed.

boot error:

```

Cannot determine cgroup we are running in: No data available
Failed to allocate manager object: No data available
[!!!!!!] Failed to allocate manager object, freezing.
Freezing execution.

```

seems bpf in CONFIG_LSM and CONFIG_BPF_LSM conflict.


clang version: v11.0.0

commit: 54b35c066417d4856e9d53313f7e98b354274584

# pahole --version
v1.17


-- 
Best Regards.
Ma Xinjian

