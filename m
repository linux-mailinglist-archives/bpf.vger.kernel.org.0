Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50951C7A49
	for <lists+bpf@lfdr.de>; Wed,  6 May 2020 21:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbgEFT25 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 May 2020 15:28:57 -0400
Received: from mga18.intel.com ([134.134.136.126]:9870 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728953AbgEFT25 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 May 2020 15:28:57 -0400
IronPort-SDR: DvxgFDC9fsFnGY1P2TkXVaA/JoGS8eM5RtSwc1lXjtvBL39/5v4BwmFHveNwxQU0vt7Tw4pcNE
 lXnUFIQpIOaw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 12:28:56 -0700
IronPort-SDR: k1fQzu1Kac8pTP6KYxvHLHlOWXwYAy1opnRX/lDE0w6dnU2YYj01qjbAsT8LP0NTsBieWWWz4c
 OQ3LIaP+L5eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,360,1583222400"; 
   d="scan'208";a="369885478"
Received: from mstoisox-wtg9.ger.corp.intel.com (HELO [10.252.41.26]) ([10.252.41.26])
  by fmsmga001.fm.intel.com with ESMTP; 06 May 2020 12:28:55 -0700
Subject: Re: -EBUSY with some selftests on 5.7-rcX
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
References: <e5ec787d-2fca-4701-ca2e-2b590a59fb6f@linux.intel.com>
 <CAEf4BzYHuJi5BE6=jYXuKynK8ViRfNjxSgkTiixp+ZQX9TyjAA@mail.gmail.com>
From:   Mikko Ylinen <mikko.ylinen@linux.intel.com>
Message-ID: <2408eda9-b001-3c34-d037-f7b5762bf7d7@linux.intel.com>
Date:   Wed, 6 May 2020 22:28:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAEf4BzYHuJi5BE6=jYXuKynK8ViRfNjxSgkTiixp+ZQX9TyjAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

On 01/05/2020 23:18, Andrii Nakryiko wrote:
> On Tue, Apr 28, 2020 at 3:33 AM Mikko Ylinen
> <mikko.ylinen@linux.intel.com> wrote:
>>
>> Hi,
>>
>> I'm testing BPF LSM and wanted to verify my setup by running the
>> test_lsm selftests (./test_progs -vv -t test_lsm) but it fails:
>>
>> libbpf: loading object 'lsm' from buffer
>> libbpf: section(1) .strtab, size 306, link 0, flags 0, type=3
>> libbpf: skip section(1) .strtab
>> libbpf: section(2) .text, size 0, link 0, flags 6, type=1
>> libbpf: skip section(2) .text
>> libbpf: section(3) lsm/file_mprotect, size 192, link 0, flags 6, type=1
>> libbpf: found program lsm/file_mprotect
>> libbpf: section(4) .rellsm/file_mprotect, size 32, link 25, flags 0, type=9
>> libbpf: section(5) lsm/bprm_committed_creds, size 104, link 0, flags 6,
>> type=1
>> libbpf: found program lsm/bprm_committed_creds
>> libbpf: section(6) .rellsm/bprm_committed_creds, size 32, link 25, flags
>> 0, type=9
>> libbpf: section(7) license, size 4, link 0, flags 3, type=1
>> libbpf: license of lsm is GPL
>> libbpf: section(8) .bss, size 12, link 0, flags 3, type=8
>> libbpf: section(9) .debug_str, size 133448, link 0, flags 30, type=1
>> libbpf: skip section(9) .debug_str
>> libbpf: section(10) .debug_loc, size 428, link 0, flags 0, type=1
>> libbpf: skip section(10) .debug_loc
>> libbpf: section(11) .rel.debug_loc, size 112, link 25, flags 0, type=9
>> libbpf: skip relo .rel.debug_loc(11) for section(10)
>> libbpf: section(12) .debug_abbrev, size 901, link 0, flags 0, type=1
>> libbpf: skip section(12) .debug_abbrev
>> libbpf: section(13) .debug_info, size 223699, link 0, flags 0, type=1
>> libbpf: skip section(13) .debug_info
>> libbpf: section(14) .rel.debug_info, size 112, link 25, flags 0, type=9
>> libbpf: skip relo .rel.debug_info(14) for section(13)
>> libbpf: section(15) .debug_ranges, size 96, link 0, flags 0, type=1
>> libbpf: skip section(15) .debug_ranges
>> libbpf: section(16) .rel.debug_ranges, size 128, link 25, flags 0, type=9
>> libbpf: skip relo .rel.debug_ranges(16) for section(15)
>> libbpf: section(17) .BTF, size 5421, link 0, flags 0, type=1
>> libbpf: section(18) .rel.BTF, size 64, link 25, flags 0, type=9
>> libbpf: skip relo .rel.BTF(18) for section(17)
>> libbpf: section(19) .BTF.ext, size 484, link 0, flags 0, type=1
>> libbpf: section(20) .rel.BTF.ext, size 416, link 25, flags 0, type=9
>> libbpf: skip relo .rel.BTF.ext(20) for section(19)
>> libbpf: section(21) .debug_frame, size 64, link 0, flags 0, type=1
>> libbpf: skip section(21) .debug_frame
>> libbpf: section(22) .rel.debug_frame, size 32, link 25, flags 0, type=9
>> libbpf: skip relo .rel.debug_frame(22) for section(21)
>> libbpf: section(23) .debug_line, size 227, link 0, flags 0, type=1
>> libbpf: skip section(23) .debug_line
>> libbpf: section(24) .rel.debug_line, size 32, link 25, flags 0, type=9
>> libbpf: skip relo .rel.debug_line(24) for section(23)
>> libbpf: section(25) .symtab, size 288, link 1, flags 0, type=2
>> libbpf: looking for externs among 12 symbols...
>> libbpf: collected 0 externs total
>> libbpf: map 'lsm.bss' (global data): at sec_idx 8, offset 0, flags 400.
>> libbpf: map 0 is "lsm.bss"
>> libbpf: collecting relocating info for: 'lsm/file_mprotect'
>> libbpf: relo for shdr 8, symb 8, value 0, type 1, bind 1, name 232
>> ('monitored_pid'), insn 12
>> libbpf: found data map 0 (lsm.bss, sec 8, off 0) for insn 12
>> libbpf: relo for shdr 8, symb 9, value 4, type 1, bind 1, name 34
>> ('mprotect_count'), insn 17
>> libbpf: found data map 0 (lsm.bss, sec 8, off 0) for insn 17
>> libbpf: collecting relocating info for: 'lsm/bprm_committed_creds'
>> libbpf: relo for shdr 8, symb 8, value 0, type 1, bind 1, name 232
>> ('monitored_pid'), insn 1
>> libbpf: found data map 0 (lsm.bss, sec 8, off 0) for insn 1
>> libbpf: relo for shdr 8, symb 7, value 8, type 1, bind 1, name 49
>> ('bprm_count'), insn 6
>> libbpf: found data map 0 (lsm.bss, sec 8, off 0) for insn 6
>> libbpf: loading kernel BTF '/sys/kernel/btf/vmlinux': 0
>> libbpf: created map lsm.bss: fd=4
>> libbpf: loading kernel BTF '/sys/kernel/btf/vmlinux': 0
>> libbpf: prog 'lsm/file_mprotect': performing 4 CO-RE offset relocs
>> libbpf: prog 'lsm/file_mprotect': relo #0: kind 0, spec is [6]
>> vm_area_struct + 0:6 => 64.0 @ &x[0].vm_mm
>> libbpf: [6] vm_area_struct: found candidate [465] vm_area_struct
>> libbpf: prog 'lsm/file_mprotect': relo #0: matching candidate #0
>> vm_area_struct against spec [465] vm_area_struct + 0:6 => 64.0 @
>> &x[0].vm_mm: 1
>> libbpf: prog 'lsm/file_mprotect': relo #0: patched insn #5 (LDX/ST/STX)
>> off 64 -> 64
>> libbpf: prog 'lsm/file_mprotect': relo #1: kind 0, spec is [31]
>> mm_struct + 0:0:35 => 304.0 @ &x[0].start_stack
>> libbpf: [31] mm_struct: found candidate [260] mm_struct
>> libbpf: prog 'lsm/file_mprotect': relo #1: matching candidate #0
>> mm_struct against spec [260] mm_struct + 0:0:35 => 304.0 @
>> &x[0].start_stack: 1
>> libbpf: prog 'lsm/file_mprotect': relo #1: patched insn #7 (LDX/ST/STX)
>> off 304 -> 304
>> libbpf: prog 'lsm/file_mprotect': relo #2: kind 0, spec is [6]
>> vm_area_struct + 0:0 => 0.0 @ &x[0].vm_start
>> libbpf: prog 'lsm/file_mprotect': relo #2: matching candidate #0
>> vm_area_struct against spec [465] vm_area_struct + 0:0 => 0.0 @
>> &x[0].vm_start: 1
>> libbpf: prog 'lsm/file_mprotect': relo #2: patched insn #8 (LDX/ST/STX)
>> off 0 -> 0
>> libbpf: prog 'lsm/file_mprotect': relo #3: kind 0, spec is [6]
>> vm_area_struct + 0:1 => 8.0 @ &x[0].vm_end
>> libbpf: prog 'lsm/file_mprotect': relo #3: matching candidate #0
>> vm_area_struct against spec [465] vm_area_struct + 0:1 => 8.0 @
>> &x[0].vm_end: 1
>> libbpf: prog 'lsm/file_mprotect': relo #3: patched insn #10 (LDX/ST/STX)
>> off 8 -> 8
>> test_test_lsm:PASS:skel_load 0 nsec
>> libbpf: program 'lsm/file_mprotect': failed to attach: Device or
>> resource busy
>> libbpf: failed to auto-attach program 'test_int_hook': -16
>> test_test_lsm:FAIL:attach lsm attach failed: -16
>> #70 test_lsm:FAIL
>> Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED
>>
>> I get -EBUSY with fentry_fexit test too:
> 
> -EBUSY in fentry/fexit kernel code most probably means that there is
> either extension program (freplace) installed for that target program
> or that same program is already attached through previous fentry/fexit
> attachment. See code in bpf_trampoline_link_prog(). If you can, can
> you please add a bunch of printk() statements in corresponding error
> handling code paths to figure out which one it is?

The error seems to come from register_fentry() but I don't yet have
good logs what goes wrong.

> 
> Also, I wonder if this happens right after you restart your kernel/OS?
> Is it happening deterministically or just from time to time?

I haven't seen a PASS at all yet. I run the tests right after booting 
the VM.

> 
>>
>> # ./test_progs -t fentry_fexit
>> test_fentry_fexit:PASS:fentry_skel_load 0 nsec
>> test_fentry_fexit:PASS:fexit_skel_load 0 nsec
>> libbpf: program 'fentry/bpf_fentry_test1': failed to attach: Device or
>> resource busy
>> libbpf: failed to auto-attach program 'test1': -16
>> test_fentry_fexit:FAIL:fentry_attach fentry attach failed: -16
>> #13 fentry_fexit:FAIL
>> Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED
>>
>> However, btf_dump is OK:
>>
>> # ./test_progs -t btf_dump
>> #5/1 btf_dump: syntax:OK
>> #5/2 btf_dump: ordering:OK
>> #5/3 btf_dump: padding:OK
>> #5/4 btf_dump: packing:OK
>> #5/5 btf_dump: bitfields:OK
>> #5/6 btf_dump: multidim:OK
>> #5/7 btf_dump: namespacing:OK
>> #5 btf_dump:OK
>> Summary: 1/7 PASSED, 0 SKIPPED, 0 FAILED
>>
> 
> btf_dump is completely irrelevant test here, it tests libbpf's BTF
> dumping capabilities and doesn't touch anything in kernel, so this
> doesn't give any extra hint, unfortunately.
> 
>> Any feedback what to check? I don't have any other tests
>> running in parallel.
> 
> After this test fails, run `sudo bpftool prog show` and `sudo bpftool
> link show`, see if there is anything suspicious. bpftool link show is
> available with latest master in bpf-next tree, so you'd have to
> rebuild your kernel. If nothing catches your eye and helps resolve
> this, please post output here as well.

I applied the 'bpf_link observability API' series. bpftool link show
prints nothing.

> 
>>
>> # clang --version
>> clang version 10.0.0
>> Target: x86_64-generic-linux
>> Thread model: posix
>> InstalledDir: /usr/bin
>> # pahole --version
>> v1.16
>>
>> 5.7-rc3
>>

-- Regards, Mikko
