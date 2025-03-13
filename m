Return-Path: <bpf+bounces-53961-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E78A5FB2E
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 17:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29D611895372
	for <lists+bpf@lfdr.de>; Thu, 13 Mar 2025 16:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CE61EB191;
	Thu, 13 Mar 2025 16:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4S/qHLw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D10F2690E6
	for <bpf@vger.kernel.org>; Thu, 13 Mar 2025 16:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741882469; cv=none; b=EiLwW+juomtWoGLe8q/rLWo7pGuhYiQVkYnqO1QxsuebjobYdl8JSoGSqUFr2z6A1Pht+wX7R1lA2pOQzokob25Cgx7zpVABfKF9/dr+tJJjmySaR4MiNRWGhqugCyHTYyU4xC3Qy4ZeJcKVpWLwtL4ILRy4LPtqF21Z6adTOA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741882469; c=relaxed/simple;
	bh=ur/zKLOEFtwJ8Vl8tcgYsoXIySf/HKAMRVL/qbf+6zo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=PTHCdLZnBRLuku4rDexfedKZP2oGJPVyeA+YKQQNLLF1Fs2ZcxsylxZhVpggU8kFgPCut1bZ6dF1POfyUuvKNq6CMkn3T4/7cUraW+KuifKacg74cTddzt+2IdPzn3lO017sqDvwyh0V8ECzG7KzOlh1kRtco1HxF0k02/8QyWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4S/qHLw; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-476775df2f0so21904861cf.1
        for <bpf@vger.kernel.org>; Thu, 13 Mar 2025 09:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741882465; x=1742487265; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aLGVe2i5Mp+MPhg3XfD+na0VkC8w0Mpf/i0Hrh0ve3s=;
        b=N4S/qHLwq2JIidBBuxyCaQpu3l3SkdgF6QwOMNwQyJhVVSbqZA4yIExypPvW4RLNDK
         vnoZ5N/YLQsos0IiHeKPz0mILCfDQWyX+NwIMZq+4/7pvbvduaA3G6r85bcd3OZ2iy/y
         62CYapeBFJJ7n+ECOzCdDhZuHSbNmiIJOGfPJ6flo7MfpoRgcarzCp8QdJ08WbG4UJ+1
         w1ANkEzKyYrWU2bCe9jCEgkNWxSa+nVVJQIYON6pOCkRaCM22qCR+fnoSeJifkvqi3eL
         gAiTON0AB9XpbvaY5CtwO0rHVCSr9EzftqsOMebgc14D0qDsX0U4/DpkKX0/JtFbWGmE
         JSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741882465; x=1742487265;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aLGVe2i5Mp+MPhg3XfD+na0VkC8w0Mpf/i0Hrh0ve3s=;
        b=TUcMwlKzmHCDbU4TrbRG1sulvcQc07u/nudlzE8rVZGvDrbC5OeMYoP+qyzBv+mNPD
         EMF3uQ/N/EYpnOzs3hLX61pVW7tZD8lh3WuOync2JLmsUoBld8H0BlBhS1oZvESMo4bS
         BCzioUKB6GCLpVJvLKfNWa60+0ZV36wSzgQsVGep5ApBUKIyQ1zVjWM+HNsJcjAmGR0M
         ut7ZE4GWGuD0GkxCgdvJ1/HFVQoCoY/RBR/S8a3OBoi6yXO44C4K/ZFVXUgV2opYVMKS
         7Htoa986fUhssbeN2DJlxUhGVScLVY4UgKazbURmZCbA7piIj8Q2YX4uToiI1UGk/ycX
         lnzg==
X-Forwarded-Encrypted: i=1; AJvYcCWMfVqbFVdzD79Al7LHcn4dHJNT+twAiq/mCKiOkEKq0Q70h1OSez572k094EwxvROMDqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHxPWqNWtgUBMQWqnAh6lLBLAD7AywNNZyorvzYHlCVUZT2ocB
	AgLmjVFmYpGMlhmz4V/3wKvTvGRdeXCP+jVWGjHYKry6Xs1kCgM9thsndPJ92qcJVzdQqUkOwFg
	QzFyZCf5pREJU0LzWd2wqiLdDVVU=
X-Gm-Gg: ASbGncvJOnvnZTexyOt5K237yKcHrhFMsAFIrVOXL6S/lPvfRdByjeJxJv0UboywmwT
	nZi+7edoSE9o75Wu8/ImPmDK01WPF67tZxkIEAio14uJYU7kbkuIWfB9k6/q0vQMjGncGsEb9NV
	8yJiydxbI2cWIlJV5HtLRVf/ZZepVc+xrxnJQf
X-Google-Smtp-Source: AGHT+IF29J1iRwvPaJoMFWgKkhWvQBT9fSxl5u/fY31UtNW6vHJYxAuybxyoFYM8aA8e/CI7RX8haV0UB6Mjn2WlvIg=
X-Received: by 2002:ac8:5f93:0:b0:476:b1d1:471 with SMTP id
 d75a77b69052e-476babce743mr58280961cf.25.1741882465140; Thu, 13 Mar 2025
 09:14:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Thu, 13 Mar 2025 09:14:14 -0700
X-Gm-Features: AQ5f1Jpo2LLAWV5S3SasiqEYrtxEzlN5tAaHLddzVeIqCLzg9OT6VW6USKB2l7w
Message-ID: <CAK3+h2yfM9FTNiXvEQBkvtuoJrvzmN4c_NZsFXqEk4Cj1tsBNA@mail.gmail.com>
Subject: Loongarch JIT doesn't support bpf-to-bpf calls
To: loongarch@lists.linux.dev, bpf <bpf@vger.kernel.org>
Cc: Hengqi Chen <hengqi.chen@gmail.com>, Tiezhu Yang <yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"

Hi,

I  use xdp-loader to load XDP program [0] that  tails call XDP
synproxy program that was modified from kernel source [1] on Loongarch
platform, I got message "JIT doesn't support bpf-to-bpf call near the
bottom of the output below:

[root@fedora xdp-tools]# ./xdp-loader/xdp-loader load  -vvv lo -m skb
-P 80 -p /sys/fs/bpf/xdp-synproxy-tailcall -n synproxy_tailcall
./xdp-synproxy-tailcall/xdp_synproxy_tailcall.bpf.o

Current rlimit 8388608 already >= minimum 1048576
Loading 1 files on interface 'lo'.
  libbpf: loading object from
./xdp-synproxy-tailcall/xdp_synproxy_tailcall.bpf.o
  libbpf: elf: section(2) .text, size 888, link 0, flags 6, type=1
  libbpf: sec '.text': found program 'tscookie_tcpopt_parse_batch' at
insn offset 0 (0 bytes), code size 111 insns (888 bytes)
  libbpf: elf: section(3) xdp, size 7312, link 0, flags 6, type=1
  libbpf: sec 'xdp': found program 'syncookie_xdp' at insn offset 0 (0
bytes), code size 890 insns (7120 bytes)
  libbpf: sec 'xdp': found program 'synproxy_tailcall' at insn offset
890 (7120 bytes), code size 24 insns (192 bytes)
  libbpf: elf: section(4) .relxdp, size 128, link 28, flags 40, type=9
  libbpf: elf: section(5) .maps, size 128, link 0, flags 3, type=1
  libbpf: elf: section(6) .rel.maps, size 16, link 28, flags 40, type=9
  libbpf: elf: section(7) license, size 4, link 0, flags 3, type=1
  libbpf: license of ./xdp-synproxy-tailcall/xdp_synproxy_tailcall.bpf.o is GPL
  libbpf: elf: section(8) .rodata, size 12, link 0, flags 2, type=1
  libbpf: elf: section(19) .BTF, size 9434, link 0, flags 0, type=1
  libbpf: elf: section(21) .BTF.ext, size 7628, link 0, flags 0, type=1
  libbpf: elf: section(28) .symtab, size 1656, link 1, flags 0, type=2
  libbpf: looking for externs among 69 symbols...
  libbpf: collected 2 externs total
  libbpf: extern (ksym) #0: symbol 63, name bpf_ct_release
  libbpf: extern (ksym) #1: symbol 62, name bpf_xdp_ct_lookup
  libbpf: map 'tail_call_tbl': at sec_idx 5, offset 0.
  libbpf: map 'tail_call_tbl': found type = 3.
  libbpf: map 'tail_call_tbl': found key_size = 4.
  libbpf: map 'tail_call_tbl': found value_size = 4.
  libbpf: map 'tail_call_tbl': found max_entries = 1.
  libbpf: map 'tail_call_tbl': found pinning = 1.
  libbpf: map 'values': at sec_idx 5, offset 48.
  libbpf: map 'values': found type = 2.
  libbpf: map 'values': found key [18], sz = 4.
  libbpf: map 'values': found value [21], sz = 8.
  libbpf: map 'values': found max_entries = 2.
  libbpf: map 'values': found pinning = 1.
  libbpf: map 'allowed_ports': at sec_idx 5, offset 88.
  libbpf: map 'allowed_ports': found type = 2.
  libbpf: map 'allowed_ports': found key [18], sz = 4.
  libbpf: map 'allowed_ports': found value [26], sz = 2.
  libbpf: map 'allowed_ports': found max_entries = 24.
  libbpf: map 'allowed_ports': found pinning = 1.
  libbpf: map 'xdp_synp.rodata' (global data): at sec_idx 8, offset 0, flags 80.
  libbpf: map 3 is "xdp_synp.rodata"
  libbpf: sec '.relxdp': collecting relocation for section(3) 'xdp'
  libbpf: sec '.relxdp': relo #0: insn #115 against 'bpf_xdp_ct_lookup'
  libbpf: prog 'syncookie_xdp': found extern #1 'bpf_xdp_ct_lookup'
(sym 62) for insn #115
  libbpf: sec '.relxdp': relo #1: insn #119 against 'bpf_ct_release'
  libbpf: prog 'syncookie_xdp': found extern #0 'bpf_ct_release' (sym
63) for insn #119
  libbpf: sec '.relxdp': relo #2: insn #138 against 'allowed_ports'
  libbpf: prog 'syncookie_xdp': found map 2 (allowed_ports, sec 5, off
88) for insn #138
  libbpf: sec '.relxdp': relo #3: insn #386 against '.text'
  libbpf: sec '.relxdp': relo #4: insn #450 against 'values'
  libbpf: prog 'syncookie_xdp': found map 1 (values, sec 5, off 48)
for insn #450
  libbpf: sec '.relxdp': relo #5: insn #600 against 'values'
  libbpf: prog 'syncookie_xdp': found map 1 (values, sec 5, off 48)
for insn #600
  libbpf: sec '.relxdp': relo #6: insn #883 against 'values'
  libbpf: prog 'syncookie_xdp': found map 1 (values, sec 5, off 48)
for insn #883
  libbpf: sec '.relxdp': relo #7: insn #908 against 'tail_call_tbl'
  libbpf: prog 'synproxy_tailcall': found map 0 (tail_call_tbl, sec 5,
off 0) for insn #18
  libbpf: .maps relo #0: for 61 value 0 rel->r_offset 40 name 189
('syncookie_xdp')
  libbpf: .maps relo #0: map 'tail_call_tbl' slot [0] points to prog
'syncookie_xdp'
 libxdp: Found func synproxy_tailcall matching synproxy_tailcall
 libxdp: DATASEC '.xdp_run_config' not found.
XDP program 0: Run prio: 80. Chain call actions: XDP_PASS
 libxdp: Generating multi-prog dispatcher for 1 programs
 libxdp: Checking for kernel frags support
 libxdp: Loading XDP program 'xdp-dispatcher.o' from embedded object file
  libbpf: loading object 'xdp-dispatcher.o' from buffer
  libbpf: elf: section(2) .text, size 528, link 0, flags 6, type=1
  libbpf: sec '.text': found program 'prog0' at insn offset 0 (0
bytes), code size 6 insns (48 bytes)
  libbpf: sec '.text': found program 'prog1' at insn offset 6 (48
bytes), code size 6 insns (48 bytes)
  libbpf: sec '.text': found program 'prog2' at insn offset 12 (96
bytes), code size 6 insns (48 bytes)
  libbpf: sec '.text': found program 'prog3' at insn offset 18 (144
bytes), code size 6 insns (48 bytes)
  libbpf: sec '.text': found program 'prog4' at insn offset 24 (192
bytes), code size 6 insns (48 bytes)
  libbpf: sec '.text': found program 'prog5' at insn offset 30 (240
bytes), code size 6 insns (48 bytes)
  libbpf: sec '.text': found program 'prog6' at insn offset 36 (288
bytes), code size 6 insns (48 bytes)
  libbpf: sec '.text': found program 'prog7' at insn offset 42 (336
bytes), code size 6 insns (48 bytes)
  libbpf: sec '.text': found program 'prog8' at insn offset 48 (384
bytes), code size 6 insns (48 bytes)
  libbpf: sec '.text': found program 'prog9' at insn offset 54 (432
bytes), code size 6 insns (48 bytes)
  libbpf: sec '.text': found program 'compat_test' at insn offset 60
(480 bytes), code size 6 insns (48 bytes)
  libbpf: elf: section(3) xdp, size 1160, link 0, flags 6, type=1
  libbpf: sec 'xdp': found program 'xdp_dispatcher' at insn offset 0
(0 bytes), code size 143 insns (1144 bytes)
  libbpf: sec 'xdp': found program 'xdp_pass' at insn offset 143 (1144
bytes), code size 2 insns (16 bytes)
  libbpf: elf: section(4) .relxdp, size 336, link 27, flags 40, type=9
  libbpf: elf: section(5) .rodata, size 124, link 0, flags 2, type=1
  libbpf: elf: section(6) license, size 4, link 0, flags 3, type=1
  libbpf: license of xdp-dispatcher.o is GPL
  libbpf: elf: section(7) xdp_metadata, size 8, link 0, flags 3, type=1
  libbpf: elf: skipping unrecognized data section(7) xdp_metadata
  libbpf: elf: section(18) .BTF, size 3248, link 0, flags 0, type=1
  libbpf: elf: section(20) .BTF.ext, size 2112, link 0, flags 0, type=1
  libbpf: elf: section(27) .symtab, size 1008, link 1, flags 0, type=2
  libbpf: looking for externs among 42 symbols...
  libbpf: collected 0 externs total
  libbpf: map 'xdp_disp.rodata' (global data): at sec_idx 5, offset 0, flags 80.
  libbpf: map 0 is "xdp_disp.rodata"
  libbpf: sec '.relxdp': collecting relocation for section(3) 'xdp'
  libbpf: sec '.relxdp': relo #0: insn #1 against '.rodata'
  libbpf: prog 'xdp_dispatcher': found data map 0 (xdp_disp.rodata,
sec 5, off 0) for insn 1
  libbpf: sec '.relxdp': relo #1: insn #7 against 'prog0'
  libbpf: sec '.relxdp': relo #2: insn #18 against 'prog1'
  libbpf: sec '.relxdp': relo #3: insn #19 against '.rodata'
  libbpf: prog 'xdp_dispatcher': found data map 0 (xdp_disp.rodata,
sec 5, off 0) for insn 19
  libbpf: sec '.relxdp': relo #4: insn #32 against 'prog2'
  libbpf: sec '.relxdp': relo #5: insn #33 against '.rodata'
  libbpf: prog 'xdp_dispatcher': found data map 0 (xdp_disp.rodata,
sec 5, off 0) for insn 33
  libbpf: sec '.relxdp': relo #6: insn #45 against 'prog3'
  libbpf: sec '.relxdp': relo #7: insn #46 against '.rodata'
  libbpf: prog 'xdp_dispatcher': found data map 0 (xdp_disp.rodata,
sec 5, off 0) for insn 46
  libbpf: sec '.relxdp': relo #8: insn #59 against 'prog4'
  libbpf: sec '.relxdp': relo #9: insn #60 against '.rodata'
  libbpf: prog 'xdp_dispatcher': found data map 0 (xdp_disp.rodata,
sec 5, off 0) for insn 60
  libbpf: sec '.relxdp': relo #10: insn #72 against 'prog5'
  libbpf: sec '.relxdp': relo #11: insn #73 against '.rodata'
  libbpf: prog 'xdp_dispatcher': found data map 0 (xdp_disp.rodata,
sec 5, off 0) for insn 73
  libbpf: sec '.relxdp': relo #12: insn #86 against 'prog6'
  libbpf: sec '.relxdp': relo #13: insn #87 against '.rodata'
  libbpf: prog 'xdp_dispatcher': found data map 0 (xdp_disp.rodata,
sec 5, off 0) for insn 87
  libbpf: sec '.relxdp': relo #14: insn #99 against 'prog7'
  libbpf: sec '.relxdp': relo #15: insn #100 against '.rodata'
  libbpf: prog 'xdp_dispatcher': found data map 0 (xdp_disp.rodata,
sec 5, off 0) for insn 100
  libbpf: sec '.relxdp': relo #16: insn #113 against 'prog8'
  libbpf: sec '.relxdp': relo #17: insn #114 against '.rodata'
  libbpf: prog 'xdp_dispatcher': found data map 0 (xdp_disp.rodata,
sec 5, off 0) for insn 114
  libbpf: sec '.relxdp': relo #18: insn #126 against 'prog9'
  libbpf: sec '.relxdp': relo #19: insn #127 against '.rodata'
  libbpf: prog 'xdp_dispatcher': found data map 0 (xdp_disp.rodata,
sec 5, off 0) for insn 127
  libbpf: sec '.relxdp': relo #20: insn #140 against 'compat_test'
 libxdp: DATASEC '.xdp_run_config' not found.
  libbpf: object 'xdp-dispatcher.': failed (-95) to create BPF token
from '/sys/fs/bpf', skipping optional step...
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'prog0'
  libbpf: prog 'xdp_dispatcher': insn #7 relocated, imm 135 points to
subprog 'prog0' (now at 143 offset)
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'prog1'
  libbpf: prog 'xdp_dispatcher': insn #18 relocated, imm 130 points to
subprog 'prog1' (now at 149 offset)
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'prog2'
  libbpf: prog 'xdp_dispatcher': insn #32 relocated, imm 122 points to
subprog 'prog2' (now at 155 offset)
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'prog3'
  libbpf: prog 'xdp_dispatcher': insn #45 relocated, imm 115 points to
subprog 'prog3' (now at 161 offset)
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'prog4'
  libbpf: prog 'xdp_dispatcher': insn #59 relocated, imm 107 points to
subprog 'prog4' (now at 167 offset)
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'prog5'
  libbpf: prog 'xdp_dispatcher': insn #72 relocated, imm 100 points to
subprog 'prog5' (now at 173 offset)
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'prog6'
  libbpf: prog 'xdp_dispatcher': insn #86 relocated, imm 92 points to
subprog 'prog6' (now at 179 offset)
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'prog7'
  libbpf: prog 'xdp_dispatcher': insn #99 relocated, imm 85 points to
subprog 'prog7' (now at 185 offset)
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'prog8'
  libbpf: prog 'xdp_dispatcher': insn #113 relocated, imm 77 points to
subprog 'prog8' (now at 191 offset)
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'prog9'
  libbpf: prog 'xdp_dispatcher': insn #126 relocated, imm 70 points to
subprog 'prog9' (now at 197 offset)
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'compat_test'
  libbpf: prog 'xdp_dispatcher': insn #140 relocated, imm 62 points to
subprog 'compat_test' (now at 203 offset)
  libbpf: map 'xdp_disp.rodata': created successfully, fd=3
 libxdp: Loaded XDP program xdp_pass, got fd 10
 libxdp: Duplicated fd 10 to 11 for prog xdp_pass
 libxdp: Kernel supports XDP programs with frags
 libxdp: Loading XDP program 'xdp-dispatcher.o' from embedded object file
  libbpf: loading object 'xdp-dispatcher.o' from buffer
  libbpf: elf: section(2) .text, size 528, link 0, flags 6, type=1
  libbpf: sec '.text': found program 'prog0' at insn offset 0 (0
bytes), code size 6 insns (48 bytes)
  libbpf: sec '.text': found program 'prog1' at insn offset 6 (48
bytes), code size 6 insns (48 bytes)
  libbpf: sec '.text': found program 'prog2' at insn offset 12 (96
bytes), code size 6 insns (48 bytes)
  libbpf: sec '.text': found program 'prog3' at insn offset 18 (144
bytes), code size 6 insns (48 bytes)
  libbpf: sec '.text': found program 'prog4' at insn offset 24 (192
bytes), code size 6 insns (48 bytes)
  libbpf: sec '.text': found program 'prog5' at insn offset 30 (240
bytes), code size 6 insns (48 bytes)
  libbpf: sec '.text': found program 'prog6' at insn offset 36 (288
bytes), code size 6 insns (48 bytes)
  libbpf: sec '.text': found program 'prog7' at insn offset 42 (336
bytes), code size 6 insns (48 bytes)
  libbpf: sec '.text': found program 'prog8' at insn offset 48 (384
bytes), code size 6 insns (48 bytes)
  libbpf: sec '.text': found program 'prog9' at insn offset 54 (432
bytes), code size 6 insns (48 bytes)
  libbpf: sec '.text': found program 'compat_test' at insn offset 60
(480 bytes), code size 6 insns (48 bytes)
  libbpf: elf: section(3) xdp, size 1160, link 0, flags 6, type=1
  libbpf: sec 'xdp': found program 'xdp_dispatcher' at insn offset 0
(0 bytes), code size 143 insns (1144 bytes)
  libbpf: sec 'xdp': found program 'xdp_pass' at insn offset 143 (1144
bytes), code size 2 insns (16 bytes)
  libbpf: elf: section(4) .relxdp, size 336, link 27, flags 40, type=9
  libbpf: elf: section(5) .rodata, size 124, link 0, flags 2, type=1
  libbpf: elf: section(6) license, size 4, link 0, flags 3, type=1
  libbpf: license of xdp-dispatcher.o is GPL
  libbpf: elf: section(7) xdp_metadata, size 8, link 0, flags 3, type=1
  libbpf: elf: skipping unrecognized data section(7) xdp_metadata
  libbpf: elf: section(18) .BTF, size 3248, link 0, flags 0, type=1
  libbpf: elf: section(20) .BTF.ext, size 2112, link 0, flags 0, type=1
  libbpf: elf: section(27) .symtab, size 1008, link 1, flags 0, type=2
  libbpf: looking for externs among 42 symbols...
  libbpf: collected 0 externs total
  libbpf: map 'xdp_disp.rodata' (global data): at sec_idx 5, offset 0, flags 80.
  libbpf: map 0 is "xdp_disp.rodata"
  libbpf: sec '.relxdp': collecting relocation for section(3) 'xdp'
  libbpf: sec '.relxdp': relo #0: insn #1 against '.rodata'
  libbpf: prog 'xdp_dispatcher': found data map 0 (xdp_disp.rodata,
sec 5, off 0) for insn 1
  libbpf: sec '.relxdp': relo #1: insn #7 against 'prog0'
  libbpf: sec '.relxdp': relo #2: insn #18 against 'prog1'
  libbpf: sec '.relxdp': relo #3: insn #19 against '.rodata'
  libbpf: prog 'xdp_dispatcher': found data map 0 (xdp_disp.rodata,
sec 5, off 0) for insn 19
  libbpf: sec '.relxdp': relo #4: insn #32 against 'prog2'
  libbpf: sec '.relxdp': relo #5: insn #33 against '.rodata'
  libbpf: prog 'xdp_dispatcher': found data map 0 (xdp_disp.rodata,
sec 5, off 0) for insn 33
  libbpf: sec '.relxdp': relo #6: insn #45 against 'prog3'
  libbpf: sec '.relxdp': relo #7: insn #46 against '.rodata'
  libbpf: prog 'xdp_dispatcher': found data map 0 (xdp_disp.rodata,
sec 5, off 0) for insn 46
  libbpf: sec '.relxdp': relo #8: insn #59 against 'prog4'
  libbpf: sec '.relxdp': relo #9: insn #60 against '.rodata'
  libbpf: prog 'xdp_dispatcher': found data map 0 (xdp_disp.rodata,
sec 5, off 0) for insn 60
  libbpf: sec '.relxdp': relo #10: insn #72 against 'prog5'
  libbpf: sec '.relxdp': relo #11: insn #73 against '.rodata'
  libbpf: prog 'xdp_dispatcher': found data map 0 (xdp_disp.rodata,
sec 5, off 0) for insn 73
  libbpf: sec '.relxdp': relo #12: insn #86 against 'prog6'
  libbpf: sec '.relxdp': relo #13: insn #87 against '.rodata'
  libbpf: prog 'xdp_dispatcher': found data map 0 (xdp_disp.rodata,
sec 5, off 0) for insn 87
  libbpf: sec '.relxdp': relo #14: insn #99 against 'prog7'
  libbpf: sec '.relxdp': relo #15: insn #100 against '.rodata'
  libbpf: prog 'xdp_dispatcher': found data map 0 (xdp_disp.rodata,
sec 5, off 0) for insn 100
  libbpf: sec '.relxdp': relo #16: insn #113 against 'prog8'
  libbpf: sec '.relxdp': relo #17: insn #114 against '.rodata'
  libbpf: prog 'xdp_dispatcher': found data map 0 (xdp_disp.rodata,
sec 5, off 0) for insn 114
  libbpf: sec '.relxdp': relo #18: insn #126 against 'prog9'
  libbpf: sec '.relxdp': relo #19: insn #127 against '.rodata'
  libbpf: prog 'xdp_dispatcher': found data map 0 (xdp_disp.rodata,
sec 5, off 0) for insn 127
  libbpf: sec '.relxdp': relo #20: insn #140 against 'compat_test'
 libxdp: DATASEC '.xdp_run_config' not found.
 libxdp: At least one attached program doesn't support frags,
disabling it for the dispatcher
 libxdp: Loading multiprog dispatcher for 1 programs without frags support
  libbpf: object 'xdp-dispatcher.': failed (-95) to create BPF token
from '/sys/fs/bpf', skipping optional step...
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'prog0'
  libbpf: prog 'xdp_dispatcher': insn #7 relocated, imm 135 points to
subprog 'prog0' (now at 143 offset)
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'prog1'
  libbpf: prog 'xdp_dispatcher': insn #18 relocated, imm 130 points to
subprog 'prog1' (now at 149 offset)
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'prog2'
  libbpf: prog 'xdp_dispatcher': insn #32 relocated, imm 122 points to
subprog 'prog2' (now at 155 offset)
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'prog3'
  libbpf: prog 'xdp_dispatcher': insn #45 relocated, imm 115 points to
subprog 'prog3' (now at 161 offset)
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'prog4'
  libbpf: prog 'xdp_dispatcher': insn #59 relocated, imm 107 points to
subprog 'prog4' (now at 167 offset)
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'prog5'
  libbpf: prog 'xdp_dispatcher': insn #72 relocated, imm 100 points to
subprog 'prog5' (now at 173 offset)
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'prog6'
  libbpf: prog 'xdp_dispatcher': insn #86 relocated, imm 92 points to
subprog 'prog6' (now at 179 offset)
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'prog7'
  libbpf: prog 'xdp_dispatcher': insn #99 relocated, imm 85 points to
subprog 'prog7' (now at 185 offset)
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'prog8'
  libbpf: prog 'xdp_dispatcher': insn #113 relocated, imm 77 points to
subprog 'prog8' (now at 191 offset)
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'prog9'
  libbpf: prog 'xdp_dispatcher': insn #126 relocated, imm 70 points to
subprog 'prog9' (now at 197 offset)
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'compat_test'
  libbpf: prog 'xdp_dispatcher': insn #140 relocated, imm 62 points to
subprog 'compat_test' (now at 203 offset)
  libbpf: map 'xdp_disp.rodata': created successfully, fd=3
 libxdp: Loaded XDP program xdp_dispatcher, got fd 9
 libxdp: Duplicated fd 9 to 11 for prog xdp_dispatcher
 libxdp: Checking dispatcher compatibility
 libxdp: Loading XDP program 'xdp-dispatcher.o' from embedded object file
  libbpf: loading object 'xdp-dispatcher.o' from buffer
  libbpf: elf: section(2) .text, size 528, link 0, flags 6, type=1
  libbpf: sec '.text': found program 'prog0' at insn offset 0 (0
bytes), code size 6 insns (48 bytes)
  libbpf: sec '.text': found program 'prog1' at insn offset 6 (48
bytes), code size 6 insns (48 bytes)
  libbpf: sec '.text': found program 'prog2' at insn offset 12 (96
bytes), code size 6 insns (48 bytes)
  libbpf: sec '.text': found program 'prog3' at insn offset 18 (144
bytes), code size 6 insns (48 bytes)
  libbpf: sec '.text': found program 'prog4' at insn offset 24 (192
bytes), code size 6 insns (48 bytes)
  libbpf: sec '.text': found program 'prog5' at insn offset 30 (240
bytes), code size 6 insns (48 bytes)
  libbpf: sec '.text': found program 'prog6' at insn offset 36 (288
bytes), code size 6 insns (48 bytes)
  libbpf: sec '.text': found program 'prog7' at insn offset 42 (336
bytes), code size 6 insns (48 bytes)
  libbpf: sec '.text': found program 'prog8' at insn offset 48 (384
bytes), code size 6 insns (48 bytes)
  libbpf: sec '.text': found program 'prog9' at insn offset 54 (432
bytes), code size 6 insns (48 bytes)
  libbpf: sec '.text': found program 'compat_test' at insn offset 60
(480 bytes), code size 6 insns (48 bytes)
  libbpf: elf: section(3) xdp, size 1160, link 0, flags 6, type=1
  libbpf: sec 'xdp': found program 'xdp_dispatcher' at insn offset 0
(0 bytes), code size 143 insns (1144 bytes)
  libbpf: sec 'xdp': found program 'xdp_pass' at insn offset 143 (1144
bytes), code size 2 insns (16 bytes)
  libbpf: elf: section(4) .relxdp, size 336, link 27, flags 40, type=9
  libbpf: elf: section(5) .rodata, size 124, link 0, flags 2, type=1
  libbpf: elf: section(6) license, size 4, link 0, flags 3, type=1
  libbpf: license of xdp-dispatcher.o is GPL
  libbpf: elf: section(7) xdp_metadata, size 8, link 0, flags 3, type=1
  libbpf: elf: skipping unrecognized data section(7) xdp_metadata
  libbpf: elf: section(18) .BTF, size 3248, link 0, flags 0, type=1
  libbpf: elf: section(20) .BTF.ext, size 2112, link 0, flags 0, type=1
  libbpf: elf: section(27) .symtab, size 1008, link 1, flags 0, type=2
  libbpf: looking for externs among 42 symbols...
  libbpf: collected 0 externs total
  libbpf: map 'xdp_disp.rodata' (global data): at sec_idx 5, offset 0, flags 80.
  libbpf: map 0 is "xdp_disp.rodata"
  libbpf: sec '.relxdp': collecting relocation for section(3) 'xdp'
  libbpf: sec '.relxdp': relo #0: insn #1 against '.rodata'
  libbpf: prog 'xdp_dispatcher': found data map 0 (xdp_disp.rodata,
sec 5, off 0) for insn 1
  libbpf: sec '.relxdp': relo #1: insn #7 against 'prog0'
  libbpf: sec '.relxdp': relo #2: insn #18 against 'prog1'
  libbpf: sec '.relxdp': relo #3: insn #19 against '.rodata'
  libbpf: prog 'xdp_dispatcher': found data map 0 (xdp_disp.rodata,
sec 5, off 0) for insn 19
  libbpf: sec '.relxdp': relo #4: insn #32 against 'prog2'
  libbpf: sec '.relxdp': relo #5: insn #33 against '.rodata'
  libbpf: prog 'xdp_dispatcher': found data map 0 (xdp_disp.rodata,
sec 5, off 0) for insn 33
  libbpf: sec '.relxdp': relo #6: insn #45 against 'prog3'
  libbpf: sec '.relxdp': relo #7: insn #46 against '.rodata'
  libbpf: prog 'xdp_dispatcher': found data map 0 (xdp_disp.rodata,
sec 5, off 0) for insn 46
  libbpf: sec '.relxdp': relo #8: insn #59 against 'prog4'
  libbpf: sec '.relxdp': relo #9: insn #60 against '.rodata'
  libbpf: prog 'xdp_dispatcher': found data map 0 (xdp_disp.rodata,
sec 5, off 0) for insn 60
  libbpf: sec '.relxdp': relo #10: insn #72 against 'prog5'
  libbpf: sec '.relxdp': relo #11: insn #73 against '.rodata'
  libbpf: prog 'xdp_dispatcher': found data map 0 (xdp_disp.rodata,
sec 5, off 0) for insn 73
  libbpf: sec '.relxdp': relo #12: insn #86 against 'prog6'
  libbpf: sec '.relxdp': relo #13: insn #87 against '.rodata'
  libbpf: prog 'xdp_dispatcher': found data map 0 (xdp_disp.rodata,
sec 5, off 0) for insn 87
  libbpf: sec '.relxdp': relo #14: insn #99 against 'prog7'
  libbpf: sec '.relxdp': relo #15: insn #100 against '.rodata'
  libbpf: prog 'xdp_dispatcher': found data map 0 (xdp_disp.rodata,
sec 5, off 0) for insn 100
  libbpf: sec '.relxdp': relo #16: insn #113 against 'prog8'
  libbpf: sec '.relxdp': relo #17: insn #114 against '.rodata'
  libbpf: prog 'xdp_dispatcher': found data map 0 (xdp_disp.rodata,
sec 5, off 0) for insn 114
  libbpf: sec '.relxdp': relo #18: insn #126 against 'prog9'
  libbpf: sec '.relxdp': relo #19: insn #127 against '.rodata'
  libbpf: prog 'xdp_dispatcher': found data map 0 (xdp_disp.rodata,
sec 5, off 0) for insn 127
  libbpf: sec '.relxdp': relo #20: insn #140 against 'compat_test'
 libxdp: DATASEC '.xdp_run_config' not found.
 libxdp: Loading XDP program 'xdp-dispatcher.o' from embedded object file
  libbpf: loading object 'xdp-dispatcher.o' from buffer
  libbpf: elf: section(2) .text, size 528, link 0, flags 6, type=1
  libbpf: sec '.text': found program 'prog0' at insn offset 0 (0
bytes), code size 6 insns (48 bytes)
  libbpf: sec '.text': found program 'prog1' at insn offset 6 (48
bytes), code size 6 insns (48 bytes)
  libbpf: sec '.text': found program 'prog2' at insn offset 12 (96
bytes), code size 6 insns (48 bytes)
  libbpf: sec '.text': found program 'prog3' at insn offset 18 (144
bytes), code size 6 insns (48 bytes)
  libbpf: sec '.text': found program 'prog4' at insn offset 24 (192
bytes), code size 6 insns (48 bytes)
  libbpf: sec '.text': found program 'prog5' at insn offset 30 (240
bytes), code size 6 insns (48 bytes)
  libbpf: sec '.text': found program 'prog6' at insn offset 36 (288
bytes), code size 6 insns (48 bytes)
  libbpf: sec '.text': found program 'prog7' at insn offset 42 (336
bytes), code size 6 insns (48 bytes)
  libbpf: sec '.text': found program 'prog8' at insn offset 48 (384
bytes), code size 6 insns (48 bytes)
  libbpf: sec '.text': found program 'prog9' at insn offset 54 (432
bytes), code size 6 insns (48 bytes)
  libbpf: sec '.text': found program 'compat_test' at insn offset 60
(480 bytes), code size 6 insns (48 bytes)
  libbpf: elf: section(3) xdp, size 1160, link 0, flags 6, type=1
  libbpf: sec 'xdp': found program 'xdp_dispatcher' at insn offset 0
(0 bytes), code size 143 insns (1144 bytes)
  libbpf: sec 'xdp': found program 'xdp_pass' at insn offset 143 (1144
bytes), code size 2 insns (16 bytes)
  libbpf: elf: section(4) .relxdp, size 336, link 27, flags 40, type=9
  libbpf: elf: section(5) .rodata, size 124, link 0, flags 2, type=1
  libbpf: elf: section(6) license, size 4, link 0, flags 3, type=1
  libbpf: license of xdp-dispatcher.o is GPL
  libbpf: elf: section(7) xdp_metadata, size 8, link 0, flags 3, type=1
  libbpf: elf: skipping unrecognized data section(7) xdp_metadata
  libbpf: elf: section(18) .BTF, size 3248, link 0, flags 0, type=1
  libbpf: elf: section(20) .BTF.ext, size 2112, link 0, flags 0, type=1
  libbpf: elf: section(27) .symtab, size 1008, link 1, flags 0, type=2
  libbpf: looking for externs among 42 symbols...
  libbpf: collected 0 externs total
  libbpf: map 'xdp_disp.rodata' (global data): at sec_idx 5, offset 0, flags 80.
  libbpf: map 0 is "xdp_disp.rodata"
  libbpf: sec '.relxdp': collecting relocation for section(3) 'xdp'
  libbpf: sec '.relxdp': relo #0: insn #1 against '.rodata'
  libbpf: prog 'xdp_dispatcher': found data map 0 (xdp_disp.rodata,
sec 5, off 0) for insn 1
  libbpf: sec '.relxdp': relo #1: insn #7 against 'prog0'
  libbpf: sec '.relxdp': relo #2: insn #18 against 'prog1'
  libbpf: sec '.relxdp': relo #3: insn #19 against '.rodata'
  libbpf: prog 'xdp_dispatcher': found data map 0 (xdp_disp.rodata,
sec 5, off 0) for insn 19
  libbpf: sec '.relxdp': relo #4: insn #32 against 'prog2'
  libbpf: sec '.relxdp': relo #5: insn #33 against '.rodata'
  libbpf: prog 'xdp_dispatcher': found data map 0 (xdp_disp.rodata,
sec 5, off 0) for insn 33
  libbpf: sec '.relxdp': relo #6: insn #45 against 'prog3'
  libbpf: sec '.relxdp': relo #7: insn #46 against '.rodata'
  libbpf: prog 'xdp_dispatcher': found data map 0 (xdp_disp.rodata,
sec 5, off 0) for insn 46
  libbpf: sec '.relxdp': relo #8: insn #59 against 'prog4'
  libbpf: sec '.relxdp': relo #9: insn #60 against '.rodata'
  libbpf: prog 'xdp_dispatcher': found data map 0 (xdp_disp.rodata,
sec 5, off 0) for insn 60
  libbpf: sec '.relxdp': relo #10: insn #72 against 'prog5'
  libbpf: sec '.relxdp': relo #11: insn #73 against '.rodata'
  libbpf: prog 'xdp_dispatcher': found data map 0 (xdp_disp.rodata,
sec 5, off 0) for insn 73
  libbpf: sec '.relxdp': relo #12: insn #86 against 'prog6'
  libbpf: sec '.relxdp': relo #13: insn #87 against '.rodata'
  libbpf: prog 'xdp_dispatcher': found data map 0 (xdp_disp.rodata,
sec 5, off 0) for insn 87
  libbpf: sec '.relxdp': relo #14: insn #99 against 'prog7'
  libbpf: sec '.relxdp': relo #15: insn #100 against '.rodata'
  libbpf: prog 'xdp_dispatcher': found data map 0 (xdp_disp.rodata,
sec 5, off 0) for insn 100
  libbpf: sec '.relxdp': relo #16: insn #113 against 'prog8'
  libbpf: sec '.relxdp': relo #17: insn #114 against '.rodata'
  libbpf: prog 'xdp_dispatcher': found data map 0 (xdp_disp.rodata,
sec 5, off 0) for insn 114
  libbpf: sec '.relxdp': relo #18: insn #126 against 'prog9'
  libbpf: sec '.relxdp': relo #19: insn #127 against '.rodata'
  libbpf: prog 'xdp_dispatcher': found data map 0 (xdp_disp.rodata,
sec 5, off 0) for insn 127
  libbpf: sec '.relxdp': relo #20: insn #140 against 'compat_test'
 libxdp: DATASEC '.xdp_run_config' not found.
  libbpf: object 'xdp-dispatcher.': failed (-95) to create BPF token
from '/sys/fs/bpf', skipping optional step...
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'prog0'
  libbpf: prog 'xdp_dispatcher': insn #7 relocated, imm 135 points to
subprog 'prog0' (now at 143 offset)
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'prog1'
  libbpf: prog 'xdp_dispatcher': insn #18 relocated, imm 130 points to
subprog 'prog1' (now at 149 offset)
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'prog2'
  libbpf: prog 'xdp_dispatcher': insn #32 relocated, imm 122 points to
subprog 'prog2' (now at 155 offset)
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'prog3'
  libbpf: prog 'xdp_dispatcher': insn #45 relocated, imm 115 points to
subprog 'prog3' (now at 161 offset)
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'prog4'
  libbpf: prog 'xdp_dispatcher': insn #59 relocated, imm 107 points to
subprog 'prog4' (now at 167 offset)
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'prog5'
  libbpf: prog 'xdp_dispatcher': insn #72 relocated, imm 100 points to
subprog 'prog5' (now at 173 offset)
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'prog6'
  libbpf: prog 'xdp_dispatcher': insn #86 relocated, imm 92 points to
subprog 'prog6' (now at 179 offset)
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'prog7'
  libbpf: prog 'xdp_dispatcher': insn #99 relocated, imm 85 points to
subprog 'prog7' (now at 185 offset)
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'prog8'
  libbpf: prog 'xdp_dispatcher': insn #113 relocated, imm 77 points to
subprog 'prog8' (now at 191 offset)
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'prog9'
  libbpf: prog 'xdp_dispatcher': insn #126 relocated, imm 70 points to
subprog 'prog9' (now at 197 offset)
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'compat_test'
  libbpf: prog 'xdp_dispatcher': insn #140 relocated, imm 62 points to
subprog 'compat_test' (now at 203 offset)
  libbpf: map 'xdp_disp.rodata': created successfully, fd=12
 libxdp: Loaded XDP program xdp_pass, got fd 16
 libxdp: Duplicated fd 16 to 17 for prog xdp_pass
  libbpf: object 'xdp-dispatcher.': failed (-95) to create BPF token
from '/sys/fs/bpf', skipping optional step...
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'prog0'
  libbpf: prog 'xdp_dispatcher': insn #7 relocated, imm 135 points to
subprog 'prog0' (now at 143 offset)
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'prog1'
  libbpf: prog 'xdp_dispatcher': insn #18 relocated, imm 130 points to
subprog 'prog1' (now at 149 offset)
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'prog2'
  libbpf: prog 'xdp_dispatcher': insn #32 relocated, imm 122 points to
subprog 'prog2' (now at 155 offset)
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'prog3'
  libbpf: prog 'xdp_dispatcher': insn #45 relocated, imm 115 points to
subprog 'prog3' (now at 161 offset)
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'prog4'
  libbpf: prog 'xdp_dispatcher': insn #59 relocated, imm 107 points to
subprog 'prog4' (now at 167 offset)
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'prog5'
  libbpf: prog 'xdp_dispatcher': insn #72 relocated, imm 100 points to
subprog 'prog5' (now at 173 offset)
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'prog6'
  libbpf: prog 'xdp_dispatcher': insn #86 relocated, imm 92 points to
subprog 'prog6' (now at 179 offset)
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'prog7'
  libbpf: prog 'xdp_dispatcher': insn #99 relocated, imm 85 points to
subprog 'prog7' (now at 185 offset)
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'prog8'
  libbpf: prog 'xdp_dispatcher': insn #113 relocated, imm 77 points to
subprog 'prog8' (now at 191 offset)
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'prog9'
  libbpf: prog 'xdp_dispatcher': insn #126 relocated, imm 70 points to
subprog 'prog9' (now at 197 offset)
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'compat_test'
  libbpf: prog 'xdp_dispatcher': insn #140 relocated, imm 62 points to
subprog 'compat_test' (now at 203 offset)
  libbpf: map 'xdp_disp.rodata': created successfully, fd=13
 libxdp: Loaded XDP program xdp_pass, got fd 20
 libxdp: Duplicated fd 20 to 21 for prog xdp_pass
 libxdp: Failed to attach test program to dispatcher: Unknown error 524
 libxdp: Compatibility check for dispatcher program failed: Unknown error 524
 libxdp: Falling back to loading single prog without dispatcher
 libxdp: Checking for kernel frags support
 libxdp: Loading XDP program 'xdp-dispatcher.o' from embedded object file
  libbpf: loading object 'xdp-dispatcher.o' from buffer
  libbpf: elf: section(2) .text, size 528, link 0, flags 6, type=1
  libbpf: sec '.text': found program 'prog0' at insn offset 0 (0
bytes), code size 6 insns (48 bytes)
  libbpf: sec '.text': found program 'prog1' at insn offset 6 (48
bytes), code size 6 insns (48 bytes)
  libbpf: sec '.text': found program 'prog2' at insn offset 12 (96
bytes), code size 6 insns (48 bytes)
  libbpf: sec '.text': found program 'prog3' at insn offset 18 (144
bytes), code size 6 insns (48 bytes)
  libbpf: sec '.text': found program 'prog4' at insn offset 24 (192
bytes), code size 6 insns (48 bytes)
  libbpf: sec '.text': found program 'prog5' at insn offset 30 (240
bytes), code size 6 insns (48 bytes)
  libbpf: sec '.text': found program 'prog6' at insn offset 36 (288
bytes), code size 6 insns (48 bytes)
  libbpf: sec '.text': found program 'prog7' at insn offset 42 (336
bytes), code size 6 insns (48 bytes)
  libbpf: sec '.text': found program 'prog8' at insn offset 48 (384
bytes), code size 6 insns (48 bytes)
  libbpf: sec '.text': found program 'prog9' at insn offset 54 (432
bytes), code size 6 insns (48 bytes)
  libbpf: sec '.text': found program 'compat_test' at insn offset 60
(480 bytes), code size 6 insns (48 bytes)
  libbpf: elf: section(3) xdp, size 1160, link 0, flags 6, type=1
  libbpf: sec 'xdp': found program 'xdp_dispatcher' at insn offset 0
(0 bytes), code size 143 insns (1144 bytes)
  libbpf: sec 'xdp': found program 'xdp_pass' at insn offset 143 (1144
bytes), code size 2 insns (16 bytes)
  libbpf: elf: section(4) .relxdp, size 336, link 27, flags 40, type=9
  libbpf: elf: section(5) .rodata, size 124, link 0, flags 2, type=1
  libbpf: elf: section(6) license, size 4, link 0, flags 3, type=1
  libbpf: license of xdp-dispatcher.o is GPL
  libbpf: elf: section(7) xdp_metadata, size 8, link 0, flags 3, type=1
  libbpf: elf: skipping unrecognized data section(7) xdp_metadata
  libbpf: elf: section(18) .BTF, size 3248, link 0, flags 0, type=1
  libbpf: elf: section(20) .BTF.ext, size 2112, link 0, flags 0, type=1
  libbpf: elf: section(27) .symtab, size 1008, link 1, flags 0, type=2
  libbpf: looking for externs among 42 symbols...
  libbpf: collected 0 externs total
  libbpf: map 'xdp_disp.rodata' (global data): at sec_idx 5, offset 0, flags 80.
  libbpf: map 0 is "xdp_disp.rodata"
  libbpf: sec '.relxdp': collecting relocation for section(3) 'xdp'
  libbpf: sec '.relxdp': relo #0: insn #1 against '.rodata'
  libbpf: prog 'xdp_dispatcher': found data map 0 (xdp_disp.rodata,
sec 5, off 0) for insn 1
  libbpf: sec '.relxdp': relo #1: insn #7 against 'prog0'
  libbpf: sec '.relxdp': relo #2: insn #18 against 'prog1'
  libbpf: sec '.relxdp': relo #3: insn #19 against '.rodata'
  libbpf: prog 'xdp_dispatcher': found data map 0 (xdp_disp.rodata,
sec 5, off 0) for insn 19
  libbpf: sec '.relxdp': relo #4: insn #32 against 'prog2'
  libbpf: sec '.relxdp': relo #5: insn #33 against '.rodata'
  libbpf: prog 'xdp_dispatcher': found data map 0 (xdp_disp.rodata,
sec 5, off 0) for insn 33
  libbpf: sec '.relxdp': relo #6: insn #45 against 'prog3'
  libbpf: sec '.relxdp': relo #7: insn #46 against '.rodata'
  libbpf: prog 'xdp_dispatcher': found data map 0 (xdp_disp.rodata,
sec 5, off 0) for insn 46
  libbpf: sec '.relxdp': relo #8: insn #59 against 'prog4'
  libbpf: sec '.relxdp': relo #9: insn #60 against '.rodata'
  libbpf: prog 'xdp_dispatcher': found data map 0 (xdp_disp.rodata,
sec 5, off 0) for insn 60
  libbpf: sec '.relxdp': relo #10: insn #72 against 'prog5'
  libbpf: sec '.relxdp': relo #11: insn #73 against '.rodata'
  libbpf: prog 'xdp_dispatcher': found data map 0 (xdp_disp.rodata,
sec 5, off 0) for insn 73
  libbpf: sec '.relxdp': relo #12: insn #86 against 'prog6'
  libbpf: sec '.relxdp': relo #13: insn #87 against '.rodata'
  libbpf: prog 'xdp_dispatcher': found data map 0 (xdp_disp.rodata,
sec 5, off 0) for insn 87
  libbpf: sec '.relxdp': relo #14: insn #99 against 'prog7'
  libbpf: sec '.relxdp': relo #15: insn #100 against '.rodata'
  libbpf: prog 'xdp_dispatcher': found data map 0 (xdp_disp.rodata,
sec 5, off 0) for insn 100
  libbpf: sec '.relxdp': relo #16: insn #113 against 'prog8'
  libbpf: sec '.relxdp': relo #17: insn #114 against '.rodata'
  libbpf: prog 'xdp_dispatcher': found data map 0 (xdp_disp.rodata,
sec 5, off 0) for insn 114
  libbpf: sec '.relxdp': relo #18: insn #126 against 'prog9'
  libbpf: sec '.relxdp': relo #19: insn #127 against '.rodata'
  libbpf: prog 'xdp_dispatcher': found data map 0 (xdp_disp.rodata,
sec 5, off 0) for insn 127
  libbpf: sec '.relxdp': relo #20: insn #140 against 'compat_test'
 libxdp: DATASEC '.xdp_run_config' not found.
  libbpf: object 'xdp-dispatcher.': failed (-95) to create BPF token
from '/sys/fs/bpf', skipping optional step...
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'prog0'
  libbpf: prog 'xdp_dispatcher': insn #7 relocated, imm 135 points to
subprog 'prog0' (now at 143 offset)
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'prog1'
  libbpf: prog 'xdp_dispatcher': insn #18 relocated, imm 130 points to
subprog 'prog1' (now at 149 offset)
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'prog2'
  libbpf: prog 'xdp_dispatcher': insn #32 relocated, imm 122 points to
subprog 'prog2' (now at 155 offset)
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'prog3'
  libbpf: prog 'xdp_dispatcher': insn #45 relocated, imm 115 points to
subprog 'prog3' (now at 161 offset)
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'prog4'
  libbpf: prog 'xdp_dispatcher': insn #59 relocated, imm 107 points to
subprog 'prog4' (now at 167 offset)
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'prog5'
  libbpf: prog 'xdp_dispatcher': insn #72 relocated, imm 100 points to
subprog 'prog5' (now at 173 offset)
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'prog6'
  libbpf: prog 'xdp_dispatcher': insn #86 relocated, imm 92 points to
subprog 'prog6' (now at 179 offset)
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'prog7'
  libbpf: prog 'xdp_dispatcher': insn #99 relocated, imm 85 points to
subprog 'prog7' (now at 185 offset)
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'prog8'
  libbpf: prog 'xdp_dispatcher': insn #113 relocated, imm 77 points to
subprog 'prog8' (now at 191 offset)
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'prog9'
  libbpf: prog 'xdp_dispatcher': insn #126 relocated, imm 70 points to
subprog 'prog9' (now at 197 offset)
  libbpf: prog 'xdp_dispatcher': added 6 insns from sub-prog 'compat_test'
  libbpf: prog 'xdp_dispatcher': insn #140 relocated, imm 62 points to
subprog 'compat_test' (now at 203 offset)
  libbpf: map 'xdp_disp.rodata': created successfully, fd=3
 libxdp: Loaded XDP program xdp_pass, got fd 10
 libxdp: Duplicated fd 10 to 11 for prog xdp_pass
 libxdp: Kernel supports XDP programs with frags
  libbpf: object 'xdp_synproxy_ta': failed (-95) to create BPF token
from '/sys/fs/bpf', skipping optional step...
  libbpf: loaded kernel BTF from '/sys/kernel/btf/vmlinux'
  libbpf: extern (func ksym) 'bpf_ct_release': resolved to nf_conntrack [154930]
  libbpf: extern (func ksym) 'bpf_xdp_ct_lookup': resolved to
nf_conntrack [154938]
  libbpf: sec 'xdp': found 2 CO-RE relocations
  libbpf: CO-RE relocating [38] struct nf_conn: found target candidate
[70052] struct nf_conn in [vmlinux]
  libbpf: CO-RE relocating [38] struct nf_conn: found target candidate
[70063] struct nf_conn___init in [vmlinux]
  libbpf: prog 'syncookie_xdp': relo #0: <byte_off> [38] struct
nf_conn.status (0:0 @ offset 0)
  libbpf: prog 'syncookie_xdp': relo #0: matching candidate #0
<byte_off> [70052] struct nf_conn.status (0:4 @ offset 128)
  libbpf: prog 'syncookie_xdp': relo #0: non-matching candidate #1
<byte_off> [70063] struct nf_conn___init (0 @ offset 0)
  libbpf: prog 'syncookie_xdp': relo #0: patched insn #117
(LDX/ST/STX) off 0 -> 128
  libbpf: CO-RE relocating [49] struct bpf_ct_opts___local: found
target candidate [154911] struct bpf_ct_opts in [nf_conntrack]
  libbpf: prog 'syncookie_xdp': relo #1: <byte_off> [49] struct
bpf_ct_opts___local.error (0:1 @ offset 4)
  libbpf: prog 'syncookie_xdp': relo #1: matching candidate #0
<byte_off> [154911] struct bpf_ct_opts.error (0:1 @ offset 4)
  libbpf: prog 'syncookie_xdp': relo #1: patched insn #182
(LDX/ST/STX) off 4 -> 4
  libbpf: prog 'syncookie_xdp': added 111 insns from sub-prog
'tscookie_tcpopt_parse_batch'
  libbpf: prog 'syncookie_xdp': insn #386 relocated, imm 503 points to
subprog 'tscookie_tcpopt_parse_batch' (now at 890 offset)
  libbpf: found no pinned map to reuse at
'/sys/fs/bpf/xdp-synproxy-tailcall/tail_call_tbl'
  libbpf: map 'tail_call_tbl': created successfully, fd=4
  libbpf: pinned map '/sys/fs/bpf/xdp-synproxy-tailcall/tail_call_tbl'
  libbpf: found no pinned map to reuse at
'/sys/fs/bpf/xdp-synproxy-tailcall/values'
  libbpf: map 'values': created successfully, fd=5
  libbpf: pinned map '/sys/fs/bpf/xdp-synproxy-tailcall/values'
  libbpf: found no pinned map to reuse at
'/sys/fs/bpf/xdp-synproxy-tailcall/allowed_ports'
  libbpf: map 'allowed_ports': created successfully, fd=6
  libbpf: pinned map '/sys/fs/bpf/xdp-synproxy-tailcall/allowed_ports'
  libbpf: map 'xdp_synp.rodata': created successfully, fd=7
  libbpf: prog 'syncookie_xdp': BPF program load failed: Invalid argument
  libbpf: prog 'syncookie_xdp': -- BEGIN PROG LOAD LOG --
JIT doesn't support bpf-to-bpf calls
calling kernel functions are not allowed in non-JITed programs
processed 19083 insns (limit 1000000) max_states_per_insn 15
total_states 525 peak_states 291 mark_read 35
-- END PROG LOAD LOG --
  libbpf: prog 'syncookie_xdp': failed to load: -22
  libbpf: unpinned map 'tail_call_tbl' from
'/sys/fs/bpf/xdp-synproxy-tailcall/tail_call_tbl'
  libbpf: unpinned map 'values' from '/sys/fs/bpf/xdp-synproxy-tailcall/values'
  libbpf: unpinned map 'allowed_ports' from
'/sys/fs/bpf/xdp-synproxy-tailcall/allowed_ports'
  libbpf: failed to load object
'./xdp-synproxy-tailcall/xdp_synproxy_tailcall.bpf.o'
Couldn't attach XDP program on iface 'lo': Invalid argument(-22)

How to reproduce:

git clone https://github.com/vincentmli/xdp-tools.git
cd xdp-tools; make
./xdp-loader/xdp-loader load  -vvv lo -m skb -P 80 -p
/sys/fs/bpf/xdp-synproxy-tailcall -n synproxy_tailcall
./xdp-synproxy-tailcall/xdp_synproxy_tailcall.bpf.o

I have another XDP program [2] also tail calls other XDP program, it
works fine https://github.com/vincentmli/xdp-tools/tree/master/xdp-tailcall

[root@fedora xdp-tools]# ./xdp-loader/xdp-loader load  -v lo -m skb -P
80 -p /sys/fs/bpf/xdp-tailcall -n xdp_tailcall
./xdp-tailcall/xdp_tailcall.bpf.o

Current rlimit 8388608 already >= minimum 1048576
Loading 1 files on interface 'lo'.
XDP program 0: Run prio: 80. Chain call actions: XDP_PASS
 libxdp: Compatibility check for dispatcher program failed: Unknown error 524
 libxdp: Falling back to loading single prog without dispatcher

[0] https://github.com/vincentmli/xdp-tools/tree/master/xdp-synproxy-tailcall
[1] https://elixir.bootlin.com/linux/v6.14-rc5/source/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c
[2] https://github.com/vincentmli/xdp-tools/tree/master/xdp-tailcall


Vincent

