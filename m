Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B611CBE78
	for <lists+bpf@lfdr.de>; Sat,  9 May 2020 09:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgEIHl6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 9 May 2020 03:41:58 -0400
Received: from mga04.intel.com ([192.55.52.120]:28080 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbgEIHl6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 9 May 2020 03:41:58 -0400
IronPort-SDR: 0jsez6Tw+9xQ/hiD4+clKTQDkvFwNpVXBtm/8LQ6P+6Qwx8IGeQt1rfZDAWWdq3/7TEPKhEDk2
 hVhULOVon1sQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2020 00:41:57 -0700
IronPort-SDR: eOZ46vkZPJb/4AmwQfDDWV/ecRVeDAad3W8sg+zvXA4aSFEF4DXCUI0uo/ISzDzdnyjM4m3qZJ
 JwNuczPSgGVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,370,1583222400"; 
   d="scan'208";a="250674683"
Received: from waikeung-mobl.ccr.corp.intel.com (HELO [10.255.28.12]) ([10.255.28.12])
  by fmsmga007.fm.intel.com with ESMTP; 09 May 2020 00:41:56 -0700
Subject: Re: bprm_count and stack_mprotect error when testing BPF LSM on
 v5.7-rc3
To:     KP Singh <kpsingh@google.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
References: <3ab505db-9e04-366b-d602-6b2935739f54@intel.com>
 <CAEf4BzZXA3pDwqLGTnrDAn7cH67Ei6tp8PRZwVAmsT-nTMA0gA@mail.gmail.com>
 <CAFLU3KuU6zFs7+xQ-=vy9WEx-4U=cTSW9VXNMyxRdwY3LHc9HA@mail.gmail.com>
 <CAFLU3KuUm_1HBjyQdypuWCa4soKwXF7zEic-4=e4pvTBbuwd+A@mail.gmail.com>
From:   Ma Xinjian <max.xinjian@intel.com>
Message-ID: <65526c26-c94b-d5dd-7143-b1af7071dbf9@intel.com>
Date:   Sat, 9 May 2020 15:41:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <CAFLU3KuUm_1HBjyQdypuWCa4soKwXF7zEic-4=e4pvTBbuwd+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On 5/8/20 12:24 AM, KP Singh wrote:
> Adding the list back after an HTML/text mess up.
>
> On Thu, May 7, 2020 at 6:23 PM KP Singh <kpsingh@google.com> wrote:
>> Can you check if you have the following fix:
>>
>> https://lore.kernel.org/bpf/20200430155240.68748-1-kpsingh@chromium.org/
>>
>> The test fails because the "bpf" is not in the LSM string which means the file_mprotect hook does not return a -EPERM error.
>>
>> - KP

I have rebuilt kernel with this fix.

root@lkp-skl-d01 ~# grep "ENOPARAM" 
/usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-bpf-lsm-2-79dede78c0573618e3137d3d8cbf78c84e25fabd/include/linux/lsm_hook_defs.h
LSM_HOOK(int, -ENOPARAM, fs_context_parse_param, struct fs_context *fc,

But still the same issue, and error message are exactly the same.

Anything else I can check in my env?


Ma

>>
>> On Thu, May 7, 2020 at 6:16 PM Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>>> On Wed, May 6, 2020 at 10:21 PM Ma Xinjian <max.xinjian@intel.com> wrote:
>>>> Hi,
>>>>
>>>> When I test bpf lsm with (/test_progs -vv  -t test_lsm ), failed with
>>>> below issue:
>>>>
>>>> root@lkp-skl-d01
>>>> /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-bpf-lsm-2-6a8b55ed4056ea5559ebe4f6a4b247f627870d4c/tools/testing/selftests/bpf#
>>>> ./test_progs -vv  -t test_lsm
>>>>
>>>> libbpf: loading object 'lsm' from buffer
>>>> libbpf: section(1) .strtab, size 306, link 0, flags 0, type=3
>>>> libbpf: skip section(1) .strtab
>>>> libbpf: section(2) .text, size 0, link 0, flags 6, type=1
>>>> libbpf: skip section(2) .text
>>>> libbpf: section(3) lsm/file_mprotect, size 192, link 0, flags 6, type=1
>>>> libbpf: found program lsm/file_mprotect
>>>> libbpf: section(4) .rellsm/file_mprotect, size 32, link 25, flags 0, type=9
>>>> libbpf: section(5) lsm/bprm_committed_creds, size 104, link 0, flags 6,
>>>> type=1
>>>> libbpf: found program lsm/bprm_committed_creds
>>>> libbpf: section(6) .rellsm/bprm_committed_creds, size 32, link 25, flags
>>>> 0, type=9
>>>> libbpf: section(7) license, size 4, link 0, flags 3, type=1
>>>> libbpf: license of lsm is GPL
>>>> libbpf: section(8) .bss, size 12, link 0, flags 3, type=8
>>>> libbpf: section(9) .debug_loc, size 383, link 0, flags 0, type=1
>>>> libbpf: skip section(9) .debug_loc
>>>> libbpf: section(10) .rel.debug_loc, size 112, link 25, flags 0, type=9
>>>> libbpf: skip relo .rel.debug_loc(10) for section(9)
>>>> libbpf: section(11) .debug_abbrev, size 901, link 0, flags 0, type=1
>>>> libbpf: skip section(11) .debug_abbrev
>>>> libbpf: section(12) .debug_info, size 237441, link 0, flags 0, type=1
>>>> libbpf: skip section(12) .debug_info
>>>> libbpf: section(13) .rel.debug_info, size 112, link 25, flags 0, type=9
>>>> libbpf: skip relo .rel.debug_info(13) for section(12)
>>>> libbpf: section(14) .debug_ranges, size 96, link 0, flags 0, type=1
>>>> libbpf: skip section(14) .debug_ranges
>>>> libbpf: section(15) .rel.debug_ranges, size 128, link 25, flags 0, type=9
>>>> libbpf: skip relo .rel.debug_ranges(15) for section(14)
>>>> libbpf: section(16) .debug_str, size 142395, link 0, flags 30, type=1
>>>> libbpf: skip section(16) .debug_str
>>>> libbpf: section(17) .BTF, size 5634, link 0, flags 0, type=1
>>>> libbpf: section(18) .rel.BTF, size 64, link 25, flags 0, type=9
>>>> libbpf: skip relo .rel.BTF(18) for section(17)
>>>> libbpf: section(19) .BTF.ext, size 484, link 0, flags 0, type=1
>>>> libbpf: section(20) .rel.BTF.ext, size 416, link 25, flags 0, type=9
>>>> libbpf: skip relo .rel.BTF.ext(20) for section(19)
>>>> libbpf: section(21) .debug_frame, size 64, link 0, flags 0, type=1
>>>> libbpf: skip section(21) .debug_frame
>>>> libbpf: section(22) .rel.debug_frame, size 32, link 25, flags 0, type=9
>>>> libbpf: skip relo .rel.debug_frame(22) for section(21)
>>>> libbpf: section(23) .debug_line, size 227, link 0, flags 0, type=1
>>>> libbpf: skip section(23) .debug_line
>>>> libbpf: section(24) .rel.debug_line, size 32, link 25, flags 0, type=9
>>>> libbpf: skip relo .rel.debug_line(24) for section(23)
>>>> libbpf: section(25) .symtab, size 288, link 1, flags 0, type=2
>>>> libbpf: looking for externs among 12 symbols...
>>>> libbpf: collected 0 externs total
>>>> libbpf: map 'lsm.bss' (global data): at sec_idx 8, offset 0, flags 400.
>>>> libbpf: map 0 is "lsm.bss"
>>>> libbpf: collecting relocating info for: 'lsm/file_mprotect'
>>>> libbpf: relo for shdr 8, symb 8, value 0, type 1, bind 1, name 232
>>>> ('monitored_pid'), insn 12
>>>> libbpf: found data map 0 (lsm.bss, sec 8, off 0) for insn 12
>>>> libbpf: relo for shdr 8, symb 9, value 4, type 1, bind 1, name 34
>>>> ('mprotect_count'), insn 17
>>>> libbpf: found data map 0 (lsm.bss, sec 8, off 0) for insn 17
>>>> libbpf: collecting relocating info for: 'lsm/bprm_committed_creds'
>>>> libbpf: relo for shdr 8, symb 8, value 0, type 1, bind 1, name 232
>>>> ('monitored_pid'), insn 1
>>>> libbpf: found data map 0 (lsm.bss, sec 8, off 0) for insn 1
>>>> libbpf: relo for shdr 8, symb 7, value 8, type 1, bind 1, name 49
>>>> ('bprm_count'), insn 6
>>>> libbpf: found data map 0 (lsm.bss, sec 8, off 0) for insn 6
>>>> libbpf: loading kernel BTF '/sys/kernel/btf/vmlinux': 0
>>>> libbpf: created map lsm.bss: fd=4
>>>> libbpf: loading kernel BTF '/sys/kernel/btf/vmlinux': 0
>>>> libbpf: prog 'lsm/file_mprotect': performing 4 CO-RE offset relocs
>>>> libbpf: prog 'lsm/file_mprotect': relo #0: kind 0, spec is [6]
>>>> vm_area_struct + 0:6 => 64.0 @ &x[0].vm_mm
>>>> libbpf: [6] vm_area_struct: found candidate [329] vm_area_struct
>>>> libbpf: prog 'lsm/file_mprotect': relo #0: matching candidate #0
>>>> vm_area_struct against spec [329] vm_area_struct + 0:6 => 64.0 @
>>>> &x[0].vm_mm: 1
>>>> libbpf: prog 'lsm/file_mprotect': relo #0: patched insn #5 (LDX/ST/STX)
>>>> off 64 -> 64
>>>> libbpf: prog 'lsm/file_mprotect': relo #1: kind 0, spec is [32]
>>>> mm_struct + 0:0:35 => 304.0 @ &x[0].start_stack
>>>> libbpf: [32] mm_struct: found candidate [308] mm_struct
>>>> libbpf: prog 'lsm/file_mprotect': relo #1: matching candidate #0
>>>> mm_struct against spec [308] mm_struct + 0:0:35 => 304.0 @
>>>> &x[0].start_stack: 1
>>>> libbpf: prog 'lsm/file_mprotect': relo #1: patched insn #7 (LDX/ST/STX)
>>>> off 304 -> 304
>>>> libbpf: prog 'lsm/file_mprotect': relo #2: kind 0, spec is [6]
>>>> vm_area_struct + 0:0 => 0.0 @ &x[0].vm_start
>>>> libbpf: prog 'lsm/file_mprotect': relo #2: matching candidate #0
>>>> vm_area_struct against spec [329] vm_area_struct + 0:0 => 0.0 @
>>>> &x[0].vm_start: 1
>>>> libbpf: prog 'lsm/file_mprotect': relo #2: patched insn #8 (LDX/ST/STX)
>>>> off 0 -> 0
>>>> libbpf: prog 'lsm/file_mprotect': relo #3: kind 0, spec is [6]
>>>> vm_area_struct + 0:1 => 8.0 @ &x[0].vm_end
>>>> libbpf: prog 'lsm/file_mprotect': relo #3: matching candidate #0
>>>> vm_area_struct against spec [329] vm_area_struct + 0:1 => 8.0 @
>>>> &x[0].vm_end: 1
>>>> libbpf: prog 'lsm/file_mprotect': relo #3: patched insn #10 (LDX/ST/STX)
>>>> off 8 -> 8
>>>> test_test_lsm:PASS:skel_load 0 nsec
>>>> test_test_lsm:PASS:attach 0 nsec
>>>> test_test_lsm:PASS:exec_cmd 0 nsec
>>>> test_test_lsm:FAIL:bprm_count bprm_count = 0
>>>> test_test_lsm:FAIL:stack_mprotect want err=EPERM, got 0
>>>> #70 test_lsm:FAIL
>>>> Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED
>>>>
>>>>
>>>> kconfig:
>>>>
>>>> CONFIG_BPF_LSM=y
>>>>
>>>> CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"
>>>>
>>>> besides:
>>>>
>>>> when I add bpf to CONFIG_LSM, then boot failed.
>>>>
>>>> boot error:
>>>>
>>>> ```
>>>>
>>>> Cannot determine cgroup we are running in: No data available
>>>> Failed to allocate manager object: No data available
>>>> [!!!!!!] Failed to allocate manager object, freezing.
>>>> Freezing execution.
>>>>
>>>> ```
>>>>
>>>> seems bpf in CONFIG_LSM and CONFIG_BPF_LSM conflict.
>>>>
>>>>
>>>> clang version: v11.0.0
>>>>
>>>> commit: 54b35c066417d4856e9d53313f7e98b354274584
>>>>
>>>> # pahole --version
>>>> v1.17
>>>>
>>> It might be due to bug in default return value of one of the
>>> functions, which KP recently fixed. But just to be sure, KP, could you
>>> please take a look?
>>>
>>>> --
>>>> Best Regards.
>>>> Ma Xinjian
>>>>
-- 
Best Regards.
Ma Xinjian

