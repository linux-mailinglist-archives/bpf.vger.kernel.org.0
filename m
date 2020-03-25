Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D79E1933AC
	for <lists+bpf@lfdr.de>; Wed, 25 Mar 2020 23:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbgCYWQY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Mar 2020 18:16:24 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:42583 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgCYWQX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Mar 2020 18:16:23 -0400
Received: by mail-ua1-f66.google.com with SMTP id m18so1392194uap.9
        for <bpf@vger.kernel.org>; Wed, 25 Mar 2020 15:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=zGD85hIlniFz+5musW3L+gkuJTQ3f/PYOYr9OKHfHF0=;
        b=jyxjYgw8bKKAd801FdPMttohXqBjY2cs6VgaPCSZ1g/GNaxPtSjutaWUIWIlSbk+zZ
         KyGTyaGkHM3hDhVrOFf8PuROqVQ+6itcpqQ9U5fjdrkKTILztEHW2qr1wneTZ2eMIY9m
         LPg1eVRyS2858WajXU+H7QKWOMLiKf6CvqrKxMKouKCWjSWQsgqxaGZaTGhvRklcJhCJ
         bFAi7P55eoi6qrAdoWM83fpWfoE8xtHJQ0LC94Rd4pKFQAOe6Ngr8EgD8s/orGYRo+oq
         ACxTH6oxwwx5L6c3z+TTywetzZFEOE2OZeDQFGKK+1UN+TToLx6L6wOn/gDCH7RHcy+F
         Mpng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=zGD85hIlniFz+5musW3L+gkuJTQ3f/PYOYr9OKHfHF0=;
        b=Wimg24ZibfwaneI7cEVW+va6k1qoWCMpKVG3SZmJ4kWwpmehhTfWIliWpkYljjiQUi
         0HiWjFAEIIEHS1YgTYyyaZvCc8l+u7w94sjXDN0Su7QJ7f0xs8YyTmnSC326bXlZtuTy
         DUBHblzqYDd3isKrbbSQBoChTxA6PT6BYkn7BAj3oQoegMu3XRgao6BVNnqRNOqX/egv
         L8KVIjwCcm2KfaIvsGe5L3Y4d0LbmJSONmhUlKGBTCE7Ebl66IpADQfhhUyWunNguv4x
         UHqH+vi9nGlqLlxmQjz26VP6i3pCNfTFKLkH+YfaWond/aUh3XagsxYzBsGkyrSJguHv
         QcJw==
X-Gm-Message-State: ANhLgQ0USsJRcHR09NOG9IeJtve0QIzf7VXn6rfGRnauMB/jnsrg5tqu
        fkngj55Hsud22rN+cinrWkCU0erCuP1uvspR4YSw7AOt
X-Google-Smtp-Source: ADFU+vu71zcDxfFqhF+SYXQv1ZM6WOo5A4cT795GnqbA4Nc51byvs/1CATectwE2LbaJgJUI6EAarWRDGSg68Ja6KG4=
X-Received: by 2002:ab0:5e44:: with SMTP id a4mr4200901uah.4.1585174581644;
 Wed, 25 Mar 2020 15:16:21 -0700 (PDT)
MIME-Version: 1.0
From:   Matt Cover <werekraken@gmail.com>
Date:   Wed, 25 Mar 2020 15:16:10 -0700
Message-ID: <CAGyo_hqRCs6hp7w6zWEf5RzEZF6zyXj_Bb_AgXVKgab7tg06NQ@mail.gmail.com>
Subject: libbpf/BTF loading issue with fentry/fexit selftests
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I'm looking to explore the bpf trampoline Alexei introduced for
tracing progs, but am encountering a libbpf/BTF issue with loading
the selftests. Hoping you guys might have a pointer or two.

The kernel build used pahole 1.15. All llvm-project components used
in compiling the selftests were 10.0.0-rc6.

I believe the following confirms that BTF is indeed present in this kernel.


[vagrant@localhost bpf]$ uname -r
5.5.9-1.btf.el7.x86_64
[vagrant@localhost bpf]$ grep CONFIG_DEBUG_INFO_BTF /boot/config-`uname -r`
CONFIG_DEBUG_INFO_BTF=y
[vagrant@localhost bpf]$ ~/bpftool btf dump file ~/vmlinux-`uname -r`
| grep -i fexit
    'BPF_TRAMP_FEXIT' val=1
    'BPF_TRACE_FEXIT' val=25
[vagrant@localhost bpf]$ ~/bpftool btf dump file
/sys/kernel/btf/vmlinux | grep -i fexit
    'BPF_TRAMP_FEXIT' val=1
    'BPF_TRACE_FEXIT' val=25


The fexit_test.o file also has BTF information.


[vagrant@localhost bpf]$ ~/bpftool btf dump file fexit_test.o | grep FUNC_PROTO
[4] FUNC_PROTO '(anon)' ret_type_id=5 vlen=1
[7] FUNC_PROTO '(anon)' ret_type_id=5 vlen=1
[9] FUNC_PROTO '(anon)' ret_type_id=5 vlen=1
[11] FUNC_PROTO '(anon)' ret_type_id=5 vlen=1
[13] FUNC_PROTO '(anon)' ret_type_id=5 vlen=1
[15] FUNC_PROTO '(anon)' ret_type_id=5 vlen=1


However, I get libbpf/BTF load errors when trying to run any
fentry/fexit tests.


[vagrant@localhost bpf]$ sudo ./test_progs -t fexit_test | grep '^libbpf\|FAIL'
libbpf: Error loading BTF: Invalid argument(22)
libbpf: magic: 0xeb9f
libbpf: Error loading .BTF into kernel: -22.
libbpf: Error loading BTF: Invalid argument(22)
libbpf: magic: 0xeb9f
libbpf: Error loading .BTF into kernel: -22.
libbpf: fexit/bpf_fentry_test1 is not found in vmlinux BTF
test_fexit_test:FAIL:prog_load fail err -2 errno 22
#10 fexit_test:FAIL
Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED


I saw in a similar thread that -vvv output was requested. Figured the
same applies here.


[vagrant@localhost bpf]$ sudo ./test_progs -vvv -t fexit_test | grep
'^libbpf\|FAIL'
libbpf: loading ./test_pkt_access.o
libbpf: section(1) .strtab, size 290, link 0, flags 0, type=3
libbpf: skip section(1) .strtab
libbpf: section(2) .text, size 48, link 0, flags 6, type=1
libbpf: found program .text
libbpf: section(3) classifier/test_pkt_access, size 448, link 0, flags 6, type=1
libbpf: found program classifier/test_pkt_access
libbpf: section(4) .relclassifier/test_pkt_access, size 32, link 22,
flags 0, type=9
libbpf: section(5) version, size 4, link 0, flags 3, type=1
libbpf: kernel version of ./test_pkt_access.o is 1
libbpf: section(6) .debug_str, size 1151, link 0, flags 30, type=1
libbpf: skip section(6) .debug_str
libbpf: section(7) .debug_loc, size 605, link 0, flags 0, type=1
libbpf: skip section(7) .debug_loc
libbpf: section(8) .rel.debug_loc, size 144, link 22, flags 0, type=9
libbpf: skip relo .rel.debug_loc(8) for section(7)
libbpf: section(9) .debug_abbrev, size 390, link 0, flags 0, type=1
libbpf: skip section(9) .debug_abbrev
libbpf: section(10) .debug_info, size 2122, link 0, flags 0, type=1
libbpf: skip section(10) .debug_info
libbpf: section(11) .rel.debug_info, size 128, link 22, flags 0, type=9
libbpf: skip relo .rel.debug_info(11) for section(10)
libbpf: section(12) .debug_ranges, size 48, link 0, flags 0, type=1
libbpf: skip section(12) .debug_ranges
libbpf: section(13) .rel.debug_ranges, size 64, link 22, flags 0, type=9
libbpf: skip relo .rel.debug_ranges(13) for section(12)
libbpf: section(14) .BTF, size 2070, link 0, flags 0, type=1
libbpf: section(15) .rel.BTF, size 16, link 22, flags 0, type=9
libbpf: skip relo .rel.BTF(15) for section(14)
libbpf: section(16) .BTF.ext, size 752, link 0, flags 0, type=1
libbpf: section(17) .rel.BTF.ext, size 704, link 22, flags 0, type=9
libbpf: skip relo .rel.BTF.ext(17) for section(16)
libbpf: section(18) .debug_frame, size 88, link 0, flags 0, type=1
libbpf: skip section(18) .debug_frame
libbpf: section(19) .rel.debug_frame, size 48, link 22, flags 0, type=9
libbpf: skip relo .rel.debug_frame(19) for section(18)
libbpf: section(20) .debug_line, size 496, link 0, flags 0, type=1
libbpf: skip section(20) .debug_line
libbpf: section(21) .rel.debug_line, size 32, link 22, flags 0, type=9
libbpf: skip relo .rel.debug_line(21) for section(20)
libbpf: section(22) .symtab, size 288, link 1, flags 0, type=2
libbpf: Error loading BTF: Invalid argument(22)
libbpf: magic: 0xeb9f
libbpf: Error loading .BTF into kernel: -22.
libbpf: collecting relocating info for: 'classifier/test_pkt_access'
libbpf: relo for shdr 2, symb 8, value 0, type 3, bind 0, name 0 (''), insn 32
libbpf: relo for shdr 2, symb 8, value 0, type 3, bind 0, name 0 (''), insn 37
libbpf: added 6 insn from .text to prog classifier/test_pkt_access
libbpf: verifier log:
libbpf: loading ./fexit_test.o
libbpf: section(1) .strtab, size 503, link 0, flags 0, type=3
libbpf: skip section(1) .strtab
libbpf: section(2) .text, size 0, link 0, flags 6, type=1
libbpf: skip section(2) .text
libbpf: section(3) fexit/bpf_fentry_test1, size 112, link 0, flags 6, type=1
libbpf: found program fexit/bpf_fentry_test1
libbpf: section(4) .relfexit/bpf_fentry_test1, size 16, link 33, flags 0, type=9
libbpf: section(5) fexit/bpf_fentry_test2, size 152, link 0, flags 6, type=1
libbpf: found program fexit/bpf_fentry_test2
libbpf: section(6) .relfexit/bpf_fentry_test2, size 16, link 33, flags 0, type=9
libbpf: section(7) fexit/bpf_fentry_test3, size 200, link 0, flags 6, type=1
libbpf: found program fexit/bpf_fentry_test3
libbpf: section(8) .relfexit/bpf_fentry_test3, size 16, link 33, flags 0, type=9
libbpf: section(9) fexit/bpf_fentry_test4, size 152, link 0, flags 6, type=1
libbpf: found program fexit/bpf_fentry_test4
libbpf: section(10) .relfexit/bpf_fentry_test4, size 16, link 33,
flags 0, type=9
libbpf: section(11) fexit/bpf_fentry_test5, size 168, link 0, flags 6, type=1
libbpf: found program fexit/bpf_fentry_test5
libbpf: section(12) .relfexit/bpf_fentry_test5, size 16, link 33,
flags 0, type=9
libbpf: section(13) fexit/bpf_fentry_test6, size 184, link 0, flags 6, type=1
libbpf: found program fexit/bpf_fentry_test6
libbpf: section(14) .relfexit/bpf_fentry_test6, size 16, link 33,
flags 0, type=9
libbpf: section(15) license, size 4, link 0, flags 3, type=1
libbpf: license of ./fexit_test.o is GPL
libbpf: section(16) .bss, size 48, link 0, flags 3, type=8
libbpf: section(17) .debug_str, size 362, link 0, flags 30, type=1
libbpf: skip section(17) .debug_str
libbpf: section(18) .debug_loc, size 1326, link 0, flags 0, type=1
libbpf: skip section(18) .debug_loc
libbpf: section(19) .rel.debug_loc, size 416, link 33, flags 0, type=9
libbpf: skip relo .rel.debug_loc(19) for section(18)
libbpf: section(20) .debug_abbrev, size 211, link 0, flags 0, type=1
libbpf: skip section(20) .debug_abbrev
libbpf: section(21) .debug_info, size 1170, link 0, flags 0, type=1
libbpf: skip section(21) .debug_info
libbpf: section(22) .rel.debug_info, size 208, link 33, flags 0, type=9
libbpf: skip relo .rel.debug_info(22) for section(21)
libbpf: section(23) .debug_ranges, size 544, link 0, flags 0, type=1
libbpf: skip section(23) .debug_ranges
libbpf: section(24) .rel.debug_ranges, size 864, link 33, flags 0, type=9
libbpf: skip relo .rel.debug_ranges(24) for section(23)
libbpf: section(25) .BTF, size 1732, link 0, flags 0, type=1
libbpf: section(26) .rel.BTF, size 112, link 33, flags 0, type=9
libbpf: skip relo .rel.BTF(26) for section(25)
libbpf: section(27) .BTF.ext, size 1208, link 0, flags 0, type=1
libbpf: section(28) .rel.BTF.ext, size 1120, link 33, flags 0, type=9
libbpf: skip relo .rel.BTF.ext(28) for section(27)
libbpf: section(29) .debug_frame, size 160, link 0, flags 0, type=1
libbpf: skip section(29) .debug_frame
libbpf: section(30) .rel.debug_frame, size 96, link 33, flags 0, type=9
libbpf: skip relo .rel.debug_frame(30) for section(29)
libbpf: section(31) .debug_line, size 494, link 0, flags 0, type=1
libbpf: skip section(31) .debug_line
libbpf: section(32) .rel.debug_line, size 96, link 33, flags 0, type=9
libbpf: skip relo .rel.debug_line(32) for section(31)
libbpf: section(33) .symtab, size 792, link 1, flags 0, type=2
libbpf: map 'fexit_te.bss' (global data): at sec_idx 16, offset 0, flags 400.
libbpf: map 0 is "fexit_te.bss"
libbpf: Error loading BTF: Invalid argument(22)
libbpf: magic: 0xeb9f
libbpf: Error loading .BTF into kernel: -22.
libbpf: collecting relocating info for: 'fexit/bpf_fentry_test1'
libbpf: relo for shdr 16, symb 22, value 0, type 1, bind 1, name 99
('test1_result'), insn 9
libbpf: found data map 0 (fexit_te.bss, sec 16, off 0) for insn 9
libbpf: collecting relocating info for: 'fexit/bpf_fentry_test2'
libbpf: relo for shdr 16, symb 24, value 8, type 1, bind 1, name 86
('test2_result'), insn 14
libbpf: found data map 0 (fexit_te.bss, sec 16, off 0) for insn 14
libbpf: collecting relocating info for: 'fexit/bpf_fentry_test3'
libbpf: relo for shdr 16, symb 26, value 16, type 1, bind 1, name 73
('test3_result'), insn 20
libbpf: found data map 0 (fexit_te.bss, sec 16, off 0) for insn 20
libbpf: collecting relocating info for: 'fexit/bpf_fentry_test4'
libbpf: relo for shdr 16, symb 28, value 24, type 1, bind 1, name 60
('test4_result'), insn 14
libbpf: found data map 0 (fexit_te.bss, sec 16, off 0) for insn 14
libbpf: collecting relocating info for: 'fexit/bpf_fentry_test5'
libbpf: relo for shdr 16, symb 30, value 32, type 1, bind 1, name 47
('test5_result'), insn 16
libbpf: found data map 0 (fexit_te.bss, sec 16, off 0) for insn 16
libbpf: collecting relocating info for: 'fexit/bpf_fentry_test6'
libbpf: relo for shdr 16, symb 32, value 40, type 1, bind 1, name 34
('test6_result'), insn 18
libbpf: found data map 0 (fexit_te.bss, sec 16, off 0) for insn 18
libbpf: loading kernel BTF '/sys/kernel/btf/vmlinux': 0
libbpf: fexit/bpf_fentry_test1 is not found in vmlinux BTF
test_fexit_test:FAIL:prog_load fail err -2 errno 22
#10 fexit_test:FAIL
Summary: 0/0 PASSED, 0 SKIPPED, 1 FAILED


Any hints on the issue?

-Matt C.
