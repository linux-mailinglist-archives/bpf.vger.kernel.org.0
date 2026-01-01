Return-Path: <bpf+bounces-77664-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4662BCED440
	for <lists+bpf@lfdr.de>; Thu, 01 Jan 2026 19:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 924123000E82
	for <lists+bpf@lfdr.de>; Thu,  1 Jan 2026 18:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4C02F12CF;
	Thu,  1 Jan 2026 18:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpdqYfOM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91C52E54A3
	for <bpf@vger.kernel.org>; Thu,  1 Jan 2026 18:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767292009; cv=none; b=giKMhN18jHEO6JM/llkewsxTA4TCam6ilx6g3KCbypOYgTCwEBrAdIt2v/7UyecIdpHdnhxDpbggDZY8lJLvHTg7OhR910StUeFhrmR6PRqnty8vXbl3SzrYesV4n8BZTTLgiFhEAhMBob2esWsHzaNM7uYv4zPQTa3Xtq2G+LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767292009; c=relaxed/simple;
	bh=UoZu2RWFx5RR3ixW8aJGmpht6HfWVlSK9XwYIvRURzw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=EA7b/Q9orP2mG1D2Ics+TBvWHFl5sPu+bJadqdDK+aO0ELY/sITaX9B3t7IvyQ5Y7n2b2WWiAfE+zyaBbVWxacZC4AyTmBsSb3tnjw/7Fhz9j051EI7kYzPEIUpKST51pwZtMG3WJ2EHJthmqLu2dGa800NrQ71fLCH9WYtNcTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZpdqYfOM; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4f34c5f2f98so130364921cf.1
        for <bpf@vger.kernel.org>; Thu, 01 Jan 2026 10:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767292005; x=1767896805; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UoZu2RWFx5RR3ixW8aJGmpht6HfWVlSK9XwYIvRURzw=;
        b=ZpdqYfOMZRpq9mkUcxHbOtKfXCj5qPmnlCJCHwOAShcxKAQm9wlnWivdHgjleYQOB4
         WXy8ro3JzQn7M8WY6oLWeTpkoeYDZ+6EzT4yTf1JK4sTdYj2qbxBabiXM+CahorNfRJi
         tGf0N4RMezFs0RIPym0i5DVRgieqZZFJLvOAH49XAPZFMGHC/2v1e0LffQtRV8IItO6+
         LUuibUKQN6SVz+dP+UAH2Vib3WfK5S+5LeUkc/8vbVL5tViKnm9NF5XzHu/5LZTs1nuw
         ygOcTivNFlKvNpJowHjkYFWm6l4Bj+Yj99rVT7lA6wjn30yU5jlaj/T2XzeaKbt6CxRp
         gHkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767292005; x=1767896805;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UoZu2RWFx5RR3ixW8aJGmpht6HfWVlSK9XwYIvRURzw=;
        b=Ibv7CL49/nNNjHmNY4YMXK1Q0AqMDEeGKWHntzpfZ01ItRZaYBCdbriMoNCZ5TGApx
         gnpD5GWeo/UYC3NSSh6+aAr+RS9IipIBnXuYQmm1h7pv0Rcu8EGOljoD3NkA7zmjIFR+
         PT3ofPsKw8fZZ6+ubn3heDBig4Z0OrDU88EzPwI38HxvxS7Uiu1oqy+uc88hmrXnF7hO
         GzRDbGXIBT2EIJjO6eo53GaOrC6PoKSOX9TgMCgCS7OifFjqYPOFDdPNjewxkKzJ1Bdc
         UyBq9ankKSOTvkkqeRbC3E/lfWkKBBDazmf4lBWzhw9jKQrPBhA9Rv3rtYkZqgUi1YFq
         Mf9Q==
X-Gm-Message-State: AOJu0YxvAphZzwbzF9N7HekC+HepSHRWkzIp8BP+Bwi92KjDA6QoPP8n
	HMLRdoxVbB+J5FjP+wHvTOldiJ4vPrDpBLtdIMGj3twcgyCx+DPkgcgrJTULgmUwdv6qMWzZeeq
	/ZhJPuq/SjEqTuJyXERfw1FQba2s+GJha7sWT
X-Gm-Gg: AY/fxX73GhMoc+kyN96WQ01EzVBOPpzsiPebspYC59SbijcG9yYolyzoOACVy+e2jEs
	ZELBesyfBPwtJdXR9yNA8eG/jOMWxOjbJEumzVu4wzLNlYib9RMeV9Va1j2ML8cYFq7LJSqQJn6
	DzkY5ZL9Jg+eROZKuUGy+P+SZ1MBNmjDuYGUvemIt3NOarY6SNjmovgFUQrdxhrRhwzQkD3QsNV
	KIO7kf8QXGDhQwjpt1WOPhfWTLrNmbKkY1yZQGfeAIFDoeTtYc40F8vtvkHoE3JxNsyfUg=
X-Google-Smtp-Source: AGHT+IFHQg0nG0eaEMFYLqFjAh0XJlieab08wMM2OPaHkz2hikpL5OI5rx5DrsbcKn+EMOjGsc0iroENmFKu4ceHvaQ=
X-Received: by 2002:a05:622a:198b:b0:4ee:1bc7:9d7b with SMTP id
 d75a77b69052e-4f4abd8cc1fmr533103801cf.39.1767292005551; Thu, 01 Jan 2026
 10:26:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Thu, 1 Jan 2026 10:26:34 -0800
X-Gm-Features: AQt7F2pVzbJ9zAGkBOcdfnBaj7HK-VnOGc1cyoB5TONH_Az28I5f_Ok9niKqqEo
Message-ID: <CAK3+h2yu+XkEMWz6FOHiDEEQw-G_iKG2KHP=F=1CiqLr0mCgNA@mail.gmail.com>
Subject: [BUG?]: bpf/selftests: ns_bpf_qdisc libbpf: loading object 'tc_bpf'
 from buffer
To: bpf <bpf@vger.kernel.org>, loongarch@lists.linux.dev
Cc: ast <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Hengqi Chen <hengqi.chen@gmail.com>, 
	Chenghao Duan <duanchenghao@kylinos.cn>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

I used AI to enhance my message, hope it helps :)

I am reporting test failures observed while running BPF selftests on a
LoongArch machine. Both the ns_bpf_qdisc and xdp_synproxy tests
exhibit WATCHDOG timeouts and eventual failures. The issue appears
architecture-specific but I am not sure.

Issue Summary:
When building and running 6.19.0-rc3 BPF selftests on a LoongArch machine:

The "ns_bpf_qdisc/attach to mq" test fails with a WATCHDOG timeout
after 120 seconds, followed by SIGSEGV.

The xdp_synproxy test shows similar failure symptoms.

During the failing ns_bpf_qdisc test, I see this log message:
libbpf: loading object 'tc_bpf' from buffer
This message is NOT present when the same test passes on an x86 build
machine or on other LoongArch machines. The xdp_synproxy test likely
has a similar loading message.

Key Observations:

Architecture Dependency Suspected:

Both failures occur only on my LoongArch setup.

The log message "libbpf: loading object 'tc_bpf' from buffer" appears
only in the failing cases.

Others have successfully run these tests on LoongArch machines without
seeing this message.

Source of the 'tc_bpf' Object:

From reading libbpf.c, this message indicates loading an object from a
BPF skeleton. However, I cannot find a skeleton named 'tc_bpf' in the
bpf selftests skeleton source tree.

A grep search shows skeletons like 'tc_bpf2bpf' and 'test_tc_bpf', but
no exact 'tc_bpf' match.

Grep results for 'tc_bpf' in skeletons:
[root@fedora bpf]# grep -r 'tc_bpf' * | grep 's->name'
cpuv4/tc_bpf2bpf.skel.h: s->name = "tc_bpf2bpf";
cpuv4/test_tc_bpf.skel.h: s->name = "test_tc_bpf";
no_alu32/tc_bpf2bpf.skel.h: s->name = "tc_bpf2bpf";
no_alu32/test_tc_bpf.skel.h: s->name = "test_tc_bpf";
tc_bpf2bpf.skel.h: s->name = "tc_bpf2bpf";
test_tc_bpf.skel.h: s->name = "test_tc_bpf";

Test Output:

The test runs until the WATCHDOG triggers, then terminates with a
segmentation fault.

Relevant output section is included below.

Questions / Next Steps:

Could the 'tc_bpf' object be dynamically generated? If so, why does it
only appear in the failing LoongArch cases?

How can I debug this further? Should I enable more logging or check
for missing dependencies?

Are these two test failures (ns_bpf_qdisc and xdp_synproxy) related,
given they both show similar timeout patterns?

Environment:

Kernel: 6.19.0-rc3

Architecture: LoongArch

Test Command: ./test_progs -t ns_bpf_qdisc

Full Test Output Snippet for ns_bpf_qdisc:

[root@fedora bpf]# ./test_progs -t ns_bpf_qdisc
libbpf: loading object 'tc_bpf' from buffer
libbpf: elf: section(2) .symtab, size 168, link 1, flags 0, type=2
libbpf: elf: section(3) tc, size 144, link 0, flags 6, type=1
libbpf: sec 'tc': found program 'tc_ingress' at insn offset 0 (0
bytes), code size 18 insns (144 bytes)
libbpf: elf: section(4) .rodata, size 36, link 0, flags 2, type=1
libbpf: elf: section(5) license, size 4, link 0, flags 3, type=1
libbpf: license of tc_bpf is GPL
libbpf: elf: section(6) .reltc, size 16, link 2, flags 40, type=9
libbpf: elf: section(7) .BTF, size 2108, link 0, flags 0, type=1
libbpf: elf: section(8) .BTF.ext, size 284, link 0, flags 0, type=1
libbpf: looking for externs among 7 symbols...
libbpf: collected 0 externs total
libbpf: map 'tc_bpf.rodata' (global data): at sec_idx 4, offset 0, flags 80.
libbpf: map 0 is "tc_bpf.rodata"
libbpf: sec '.reltc': collecting relocation for section(3) 'tc'
libbpf: sec '.reltc': relo #0: insn #12 against '.rodata'
libbpf: prog 'tc_ingress': found data map 0 (tc_bpf.rodata, sec 4, off
0) for insn 12
libbpf: object 'tc_bpf': failed (-95) to create BPF token from
'/sys/fs/bpf', skipping optional step...
libbpf: loaded kernel BTF from '/sys/kernel/btf/vmlinux'
libbpf: sec 'tc': found 5 CO-RE relocations
libbpf: CO-RE relocating [2] struct __sk_buff: found target candidate
[10675] struct __sk_buff in [vmlinux]
libbpf: prog 'tc_ingress': relo #0: <byte_off> [2] struct
__sk_buff.protocol (0:4 @ offset 16)
libbpf: prog 'tc_ingress': relo #0: matching candidate #0 <byte_off>
[10675] struct __sk_buff.protocol (0:4 @ offset 16)
libbpf: prog 'tc_ingress': relo #0: patched insn #0 (LDX/ST/STX) off 16 -> 16
libbpf: prog 'tc_ingress': relo #1: <byte_off> [2] struct
__sk_buff.data (0:15 @ offset 76)
libbpf: prog 'tc_ingress': relo #1: matching candidate #0 <byte_off>
[10675] struct __sk_buff.data (0:15 @ offset 76)
libbpf: prog 'tc_ingress': relo #1: patched insn #2 (LDX/ST/STX) off 76 -> 76
libbpf: prog 'tc_ingress': relo #2: <byte_off> [2] struct
__sk_buff.data_end (0:16 @ offset 80)
libbpf: prog 'tc_ingress': relo #2: matching candidate #0 <byte_off>
[10675] struct __sk_buff.data_end (0:16 @ offset 80)
libbpf: prog 'tc_ingress': relo #2: patched insn #3 (LDX/ST/STX) off 80 -> 80
libbpf: CO-RE relocating [19] struct iphdr: found target candidate
[28807] struct iphdr in [vmlinux]
libbpf: prog 'tc_ingress': relo #3: <byte_off> [19] struct iphdr.ttl
(0:6 @ offset 8)
libbpf: prog 'tc_ingress': relo #3: matching candidate #0 <byte_off>
[28807] struct iphdr.ttl (0:6 @ offset 8)
libbpf: prog 'tc_ingress': relo #3: patched insn #9 (LDX/ST/STX) off 8 -> 8
libbpf: prog 'tc_ingress': relo #4: <byte_off> [19] struct
iphdr.tot_len (0:3 @ offset 2)
libbpf: prog 'tc_ingress': relo #4: matching candidate #0 <byte_off>
[28807] struct iphdr.tot_len (0:3 @ offset 2)
libbpf: prog 'tc_ingress': relo #4: patched insn #10 (LDX/ST/STX) off 2 -> 2
libbpf: map 'tc_bpf.rodata': created successfully, fd=5
Successfully started! Please run sudo cat
/sys/kernel/debug/tracing/trace_pipe to see output of the BPF program.
..........WATCHDOG: test case ns_bpf_qdisc/attach to mq executes for
10 seconds...
..............................................................................................................WATCHDOG:
test case ns_bpf_qdisc/attach to mq executes for 120 seconds,
terminating with SIGSEGV
#219 ns_bpf_qdisc:FAIL
Caught signal #11!
Stack trace:
./test_progs(crash_handler+0x28)[0x1205b7e34]
linux-vdso.so.1(__vdso_rt_sigreturn+0x0)[0x7ffffd058ac4]
/lib64/libc.so.6(wait4+0x84)[0x7ffff1f84b98]
/lib64/libc.so.6(+0x4da54)[0x7ffff1ef5a54]
./test_progs[0x120197fdc]
./test_progs(test_ns_bpf_qdisc+0x58)[0x12019982c]
./test_progs[0x1205b8574]
./test_progs(main+0x6c0)[0x1205ba5f8]
/lib64/libc.so.6(+0x2882c)[0x7ffff1ed082c]
/lib64/libc.so.6(__libc_start_main+0xa8)[0x7ffff1ed0918]
./test_progs(_start+0x48)[0x12013a0e0]

I would appreciate any insights or guidance on these issues. Please
let me know if you need more information.

Thanks

Vincent

