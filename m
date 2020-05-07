Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420051C9668
	for <lists+bpf@lfdr.de>; Thu,  7 May 2020 18:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgEGQZA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 May 2020 12:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726467AbgEGQZA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 7 May 2020 12:25:00 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F92C05BD43
        for <bpf@vger.kernel.org>; Thu,  7 May 2020 09:24:59 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h9so7152821wrt.0
        for <bpf@vger.kernel.org>; Thu, 07 May 2020 09:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ei25SAoNmdoor457m3D9/YMJ4sg6YlbpIa8mqF9WPzY=;
        b=e0qRsdlDbA7/XhZrabJc+LtHgQmLDePs4jn44CwlAQ0eKUMzRjynTwvOPg85/e/83K
         cKktsX29t6781A7gqdpkwWqH7Pm3REbrPIYueJhieg1/gFpqT9Ep1EwJXAwX2K6wCk+T
         AiXHx8RhgcKoII7mMfF5Akz0SxlOjRfjs48TU6DujGSpUWQnhjcw7c8CbZgT4DYDcq8+
         4v3vNQ128co8/ufAT5avMZHj0xmk+brU1+y01Pg+81GAGuXn1soTrrohBChjmLYZSmGx
         I2/lpUxdP89tdP+uhp+wIG9v7zf+gNJxdnfAYNa7OAicAyc0k4jdsSKqvW7t8GP4xwqV
         PJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ei25SAoNmdoor457m3D9/YMJ4sg6YlbpIa8mqF9WPzY=;
        b=YBGbnHUwee5rG5wh75e6s3taD+nQ1Dae3TFR/DvbEIGZSHsadL7Vr0KpqiL0b+IiVt
         IkeHG46o+OtiEGN4bbjxI1AYCvJWIJd+JSrpjKq82ZsErtma6RoCGl8qm2MYgmRO5M9A
         B/W8BijWlDJybQ1LxTQsBI7cym0CHlL0gOOJMeR2TyaqbSqS9ONvNNgexpi/7lqk7ct4
         rNh57p2C85mSr8KtuHb4SMFjenEQUVOlxEAHsCvC6iHeOW2Gu8ro8MxqCALWrRkninGa
         7Pxe0S71RQfgFWYmpty4cwCNjYgc1pJxbT6f7kliGaZZBwQtET2Yovqa0QQPlK5N8S+2
         NoNA==
X-Gm-Message-State: AGi0PuZb2zfhcy64LiG7E9Pk4NUdjiH4IiB/FTQFZjm/9d4HwJv5MxJN
        McfWpo45Wmj4e51y078B/oSoEaTlBM1SiU3lMzU4SgQ=
X-Google-Smtp-Source: APiQypLBSW6GTLjl5yqeFPrxlh/nqTqTmRzV5Lsd8EP+UR+/93JFn9kmGtaiAGJSoJe1E4PFEORlfdgNsP4YI7tmmZM=
X-Received: by 2002:a5d:42c1:: with SMTP id t1mr16934181wrr.18.1588868696738;
 Thu, 07 May 2020 09:24:56 -0700 (PDT)
MIME-Version: 1.0
References: <3ab505db-9e04-366b-d602-6b2935739f54@intel.com>
 <CAEf4BzZXA3pDwqLGTnrDAn7cH67Ei6tp8PRZwVAmsT-nTMA0gA@mail.gmail.com> <CAFLU3KuU6zFs7+xQ-=vy9WEx-4U=cTSW9VXNMyxRdwY3LHc9HA@mail.gmail.com>
In-Reply-To: <CAFLU3KuU6zFs7+xQ-=vy9WEx-4U=cTSW9VXNMyxRdwY3LHc9HA@mail.gmail.com>
From:   KP Singh <kpsingh@google.com>
Date:   Thu, 7 May 2020 18:24:40 +0200
Message-ID: <CAFLU3KuUm_1HBjyQdypuWCa4soKwXF7zEic-4=e4pvTBbuwd+A@mail.gmail.com>
Subject: Re: bprm_count and stack_mprotect error when testing BPF LSM on v5.7-rc3
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Ma Xinjian <max.xinjian@intel.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding the list back after an HTML/text mess up.

On Thu, May 7, 2020 at 6:23 PM KP Singh <kpsingh@google.com> wrote:
>
> Can you check if you have the following fix:
>
> https://lore.kernel.org/bpf/20200430155240.68748-1-kpsingh@chromium.org/
>
> The test fails because the "bpf" is not in the LSM string which means the file_mprotect hook does not return a -EPERM error.
>
> - KP
>
> On Thu, May 7, 2020 at 6:16 PM Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>>
>> On Wed, May 6, 2020 at 10:21 PM Ma Xinjian <max.xinjian@intel.com> wrote:
>> >
>> > Hi,
>> >
>> > When I test bpf lsm with (/test_progs -vv  -t test_lsm ), failed with
>> > below issue:
>> >
>> > root@lkp-skl-d01
>> > /usr/src/perf_selftests-x86_64-rhel-7.6-kselftests-bpf-lsm-2-6a8b55ed4056ea5559ebe4f6a4b247f627870d4c/tools/testing/selftests/bpf#
>> > ./test_progs -vv  -t test_lsm
>> >
>> > libbpf: loading object 'lsm' from buffer
>> > libbpf: section(1) .strtab, size 306, link 0, flags 0, type=3
>> > libbpf: skip section(1) .strtab
>> > libbpf: section(2) .text, size 0, link 0, flags 6, type=1
>> > libbpf: skip section(2) .text
>> > libbpf: section(3) lsm/file_mprotect, size 192, link 0, flags 6, type=1
>> > libbpf: found program lsm/file_mprotect
>> > libbpf: section(4) .rellsm/file_mprotect, size 32, link 25, flags 0, type=9
>> > libbpf: section(5) lsm/bprm_committed_creds, size 104, link 0, flags 6,
>> > type=1
>> > libbpf: found program lsm/bprm_committed_creds
>> > libbpf: section(6) .rellsm/bprm_committed_creds, size 32, link 25, flags
>> > 0, type=9
>> > libbpf: section(7) license, size 4, link 0, flags 3, type=1
>> > libbpf: license of lsm is GPL
>> > libbpf: section(8) .bss, size 12, link 0, flags 3, type=8
>> > libbpf: section(9) .debug_loc, size 383, link 0, flags 0, type=1
>> > libbpf: skip section(9) .debug_loc
>> > libbpf: section(10) .rel.debug_loc, size 112, link 25, flags 0, type=9
>> > libbpf: skip relo .rel.debug_loc(10) for section(9)
>> > libbpf: section(11) .debug_abbrev, size 901, link 0, flags 0, type=1
>> > libbpf: skip section(11) .debug_abbrev
>> > libbpf: section(12) .debug_info, size 237441, link 0, flags 0, type=1
>> > libbpf: skip section(12) .debug_info
>> > libbpf: section(13) .rel.debug_info, size 112, link 25, flags 0, type=9
>> > libbpf: skip relo .rel.debug_info(13) for section(12)
>> > libbpf: section(14) .debug_ranges, size 96, link 0, flags 0, type=1
>> > libbpf: skip section(14) .debug_ranges
>> > libbpf: section(15) .rel.debug_ranges, size 128, link 25, flags 0, type=9
>> > libbpf: skip relo .rel.debug_ranges(15) for section(14)
>> > libbpf: section(16) .debug_str, size 142395, link 0, flags 30, type=1
>> > libbpf: skip section(16) .debug_str
>> > libbpf: section(17) .BTF, size 5634, link 0, flags 0, type=1
>> > libbpf: section(18) .rel.BTF, size 64, link 25, flags 0, type=9
>> > libbpf: skip relo .rel.BTF(18) for section(17)
>> > libbpf: section(19) .BTF.ext, size 484, link 0, flags 0, type=1
>> > libbpf: section(20) .rel.BTF.ext, size 416, link 25, flags 0, type=9
>> > libbpf: skip relo .rel.BTF.ext(20) for section(19)
>> > libbpf: section(21) .debug_frame, size 64, link 0, flags 0, type=1
>> > libbpf: skip section(21) .debug_frame
>> > libbpf: section(22) .rel.debug_frame, size 32, link 25, flags 0, type=9
>> > libbpf: skip relo .rel.debug_frame(22) for section(21)
>> > libbpf: section(23) .debug_line, size 227, link 0, flags 0, type=1
>> > libbpf: skip section(23) .debug_line
>> > libbpf: section(24) .rel.debug_line, size 32, link 25, flags 0, type=9
>> > libbpf: skip relo .rel.debug_line(24) for section(23)
>> > libbpf: section(25) .symtab, size 288, link 1, flags 0, type=2
>> > libbpf: looking for externs among 12 symbols...
>> > libbpf: collected 0 externs total
>> > libbpf: map 'lsm.bss' (global data): at sec_idx 8, offset 0, flags 400.
>> > libbpf: map 0 is "lsm.bss"
>> > libbpf: collecting relocating info for: 'lsm/file_mprotect'
>> > libbpf: relo for shdr 8, symb 8, value 0, type 1, bind 1, name 232
>> > ('monitored_pid'), insn 12
>> > libbpf: found data map 0 (lsm.bss, sec 8, off 0) for insn 12
>> > libbpf: relo for shdr 8, symb 9, value 4, type 1, bind 1, name 34
>> > ('mprotect_count'), insn 17
>> > libbpf: found data map 0 (lsm.bss, sec 8, off 0) for insn 17
>> > libbpf: collecting relocating info for: 'lsm/bprm_committed_creds'
>> > libbpf: relo for shdr 8, symb 8, value 0, type 1, bind 1, name 232
>> > ('monitored_pid'), insn 1
>> > libbpf: found data map 0 (lsm.bss, sec 8, off 0) for insn 1
>> > libbpf: relo for shdr 8, symb 7, value 8, type 1, bind 1, name 49
>> > ('bprm_count'), insn 6
>> > libbpf: found data map 0 (lsm.bss, sec 8, off 0) for insn 6
>> > libbpf: loading kernel BTF '/sys/kernel/btf/vmlinux': 0
>> > libbpf: created map lsm.bss: fd=4
>> > libbpf: loading kernel BTF '/sys/kernel/btf/vmlinux': 0
>> > libbpf: prog 'lsm/file_mprotect': performing 4 CO-RE offset relocs
>> > libbpf: prog 'lsm/file_mprotect': relo #0: kind 0, spec is [6]
>> > vm_area_struct + 0:6 => 64.0 @ &x[0].vm_mm
>> > libbpf: [6] vm_area_struct: found candidate [329] vm_area_struct
>> > libbpf: prog 'lsm/file_mprotect': relo #0: matching candidate #0
>> > vm_area_struct against spec [329] vm_area_struct + 0:6 => 64.0 @
>> > &x[0].vm_mm: 1
>> > libbpf: prog 'lsm/file_mprotect': relo #0: patched insn #5 (LDX/ST/STX)
>> > off 64 -> 64
>> > libbpf: prog 'lsm/file_mprotect': relo #1: kind 0, spec is [32]
>> > mm_struct + 0:0:35 => 304.0 @ &x[0].start_stack
>> > libbpf: [32] mm_struct: found candidate [308] mm_struct
>> > libbpf: prog 'lsm/file_mprotect': relo #1: matching candidate #0
>> > mm_struct against spec [308] mm_struct + 0:0:35 => 304.0 @
>> > &x[0].start_stack: 1
>> > libbpf: prog 'lsm/file_mprotect': relo #1: patched insn #7 (LDX/ST/STX)
>> > off 304 -> 304
>> > libbpf: prog 'lsm/file_mprotect': relo #2: kind 0, spec is [6]
>> > vm_area_struct + 0:0 => 0.0 @ &x[0].vm_start
>> > libbpf: prog 'lsm/file_mprotect': relo #2: matching candidate #0
>> > vm_area_struct against spec [329] vm_area_struct + 0:0 => 0.0 @
>> > &x[0].vm_start: 1
>> > libbpf: prog 'lsm/file_mprotect': relo #2: patched insn #8 (LDX/ST/STX)
>> > off 0 -> 0
>> > libbpf: prog 'lsm/file_mprotect': relo #3: kind 0, spec is [6]
>> > vm_area_struct + 0:1 => 8.0 @ &x[0].vm_end
>> > libbpf: prog 'lsm/file_mprotect': relo #3: matching candidate #0
>> > vm_area_struct against spec [329] vm_area_struct + 0:1 => 8.0 @
>> > &x[0].vm_end: 1
>> > libbpf: prog 'lsm/file_mprotect': relo #3: patched insn #10 (LDX/ST/STX)
>> > off 8 -> 8
>> > test_test_lsm:PASS:skel_load 0 nsec
>> > test_test_lsm:PASS:attach 0 nsec
>> > test_test_lsm:PASS:exec_cmd 0 nsec
>> > test_test_lsm:FAIL:bprm_count bprm_count = 0
>> > test_test_lsm:FAIL:stack_mprotect want err=EPERM, got 0
>> > #70 test_lsm:FAIL
>> > Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED
>> >
>> >
>> > kconfig:
>> >
>> > CONFIG_BPF_LSM=y
>> >
>> > CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"
>> >
>> > besides:
>> >
>> > when I add bpf to CONFIG_LSM, then boot failed.
>> >
>> > boot error:
>> >
>> > ```
>> >
>> > Cannot determine cgroup we are running in: No data available
>> > Failed to allocate manager object: No data available
>> > [!!!!!!] Failed to allocate manager object, freezing.
>> > Freezing execution.
>> >
>> > ```
>> >
>> > seems bpf in CONFIG_LSM and CONFIG_BPF_LSM conflict.
>> >
>> >
>> > clang version: v11.0.0
>> >
>> > commit: 54b35c066417d4856e9d53313f7e98b354274584
>> >
>> > # pahole --version
>> > v1.17
>> >
>>
>> It might be due to bug in default return value of one of the
>> functions, which KP recently fixed. But just to be sure, KP, could you
>> please take a look?
>>
>> >
>> > --
>> > Best Regards.
>> > Ma Xinjian
>> >
