Return-Path: <bpf+bounces-76235-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA34CABC9F
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 03:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4968F300F325
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 02:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4424A26C385;
	Mon,  8 Dec 2025 02:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMVArSOw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C23F23815D
	for <bpf@vger.kernel.org>; Mon,  8 Dec 2025 02:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765159256; cv=none; b=AxXHj0SjIe7oCC38VbaSpXGji9IRpw+Z1eYt8PvcPl9kqd6C1JwuTQl/rT0ctZOXu57KGmMbUynRCfKf86wVE48O2g2L1EpsqwMZUST8Stm0koVW36cAlRgvELiyzHVnTbquu4TLIzxMj71MTQFEo7cwUdgl2+JInAjpYzNCJls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765159256; c=relaxed/simple;
	bh=9S6f3dCmJdZR5TslQlvdASejPaIrU7K74K9I5wM6FAc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mhZyqPAHmPOIwS2bMgtReB3amAzwzqrOgEYWVUOG2i1n6rAN3EkZySaHszIo5FkCX+qGFQzljSYpORwM2wpDb7AZwhzQIQWhvpZ5DrB/XG8M5D0NZZVBuBAFPKmfejrPUok3wz1Y/6pJB205rrRjiilA4MWpJgRnGLQXglAl8+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMVArSOw; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3436d6bdce8so4248672a91.3
        for <bpf@vger.kernel.org>; Sun, 07 Dec 2025 18:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765159254; x=1765764054; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K3cwZubwx6tiLCwjBGGoPyra8d40S7H604vShVe7laU=;
        b=dMVArSOwbF7SQ0CrHCPqUUFLlsUc1LL6N3KOmptqFcHVjh21AIy0MrKVY2jRwz1olH
         zsI1QxCPxmIFLtQg6n90pbVcFWNaAIENwyds3hhCQVupgEGMj4wZ7QQnymI/xY6BZtgw
         a1ucPchVP124459rLzQMq7sG5NJePADOMubq2c60weE/pedHWAgPJPjuh9K5TNSwyY7T
         qUdDapqMP76xFifRVVI4nxPafvcS6BoHYiopUaHXQTQv4a+R0NZo3VSb6CG24CmKOyJf
         cWAsu7YS8ZKBwj3q/4sa/LdSFq2s8YCqTew3mCAyB5Qie1LKhT4kEfOdIq6jLypOFjBC
         nrIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765159254; x=1765764054;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K3cwZubwx6tiLCwjBGGoPyra8d40S7H604vShVe7laU=;
        b=I9a9n9CQzMQIzDb0iWXn61wwZf96gU2jaeESyrPrY9dRvAFNGe25ARv9KY1l426Ko4
         tAocwYTj9XolcFWLRmvW/hplNZuEubm6OK7zQoagCKNuXpl26Rp4kQRjGthOUS0fwhiV
         2GNM4oxOH/29ps4DRIJ/yzAoltYGy4FZph8e8nGfI64WNdlEgPImkjdvNG3erMpzgW3k
         wGEs3O64YsivaxISZXypRi4kL0xOOYQLhdsH6ljpMVpbY3fGjPZ85cannIH9DU7lkHR/
         +LvB1Om+7WFEUEdpBNDkkrwTSdSskWkwfWvq+fmsjGU849cdGyXCayjPOWbZirkaOLr4
         4RUQ==
X-Gm-Message-State: AOJu0YwgXUjUUzOspcOI1Iyzr9LlT5E7H+7EuitWzmPkXipzR6GK2VqA
	TX3DaHjup7uhmtQ6HvHuJ3kxCwVHrINO/u4xowSQVtTvZDeelnSSGYs5f8hTeUrp
X-Gm-Gg: ASbGncuElYxYaq9+WyGDEEZzZtVJ9taQqcgS+G73jEXtIImf1W74+iH5W22u26em1AK
	qmhjTWlO48CmMWJUrC7ZNVhZ2RNl/hrYv2X3IsMelJadNxYyDzO7AYT1wouDRUzVl6IfbMLIvNr
	Q6LlCOI3U2cSiK7JKKuNQqYi8brrMDP2/SgvtBzNdlNZIGCgqKY5DsiKZPiADQCI+xxNRBm1MYy
	dNDNnLlGCOki3zXlpcq2shk5fuuW7gybO5IBHkGezecvFaweYarD/mt695c5A/JcgdQrLyahLcC
	tcr/To2G9wgLjVcT9TsxJpvj2NEVb0yOIgXxr4Pe4sedFZzSeCa3/MA5V5hG0coKY8BEjJSnewE
	IWTcczLT8huR+4362kOLCJwLZbA3t93W5d3GUKjrMpdb4KscYnueulvSLFA2eApG4pmtkD2kSp4
	hxNWAshjVv+S99Vuu/
X-Google-Smtp-Source: AGHT+IFmV6N6EPSMTFvRpPITdooicJalXoAaLj19UT9EO7/J9Bng73hrPRk+tbk9LHIcEBf/IRTRAQ==
X-Received: by 2002:a17:90b:2f83:b0:349:9d76:fa25 with SMTP id 98e67ed59e1d1-349a25e00cemr4802273a91.31.1765159254384;
        Sun, 07 Dec 2025 18:00:54 -0800 (PST)
Received: from Tunnel ([64.104.44.99])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-349129bcf41sm6452132a91.1.2025.12.07.18.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Dec 2025 18:00:53 -0800 (PST)
Date: Mon, 8 Dec 2025 11:00:49 +0900
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH bpf-next 0/8] bpf: Introduce verifier test oracle
Message-ID: <cover.1765158924.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patchset introduces a test oracle for the BPF verifier, to help
fuzzers detect false negatives.

At the moment, although several fuzzers cover BPF and its verifier,
they report very few soundness issues. These issues can lead to false
negatives and are typically silent. This patchset aims to make such
bugs noisy, by emitting a kernel warning when they happen.

The idea is relatively simple: when the test oracle is enabled, the
verifier will save some information on variables (registers and stack
slots) at regular points throughout the program. This information can
then be compared at runtime with the concrete values to ensure that the
verifier's information is correct.

This patchset implements this idea for registers and saves their ranges
into array maps at pruning points. The interpreter then compares the
runtime values of registers with their expected ranges. The idea can be
extended to stack slots and JIT compiles in the future.

I'm sending this as an RFC to have a concrete base for discussion at
Linux Plumbers [1] even if some of the patches still need some
work/cleanup. The end of this cover letter lists different limitations
and aspects that may require discussion.

[1] https://lpc.events/event/19/contributions/2164/

Example
=======

The test oracle can be easily tested by reverting commit 811c363645b3
("bpf: Fix check_stack_write_fixed_off() to correctly spill imm") and
loading the following program:

  0: r2 = r10;
  1: *(u64*)(r2 -40) = -44;
  2: r6 = *(u64*)(r2 - 40);
  3: call 7;
  4: r0 = 0;
  5: exit;

As shown below, without the fix, the verifier will lose the sign
information when spilling -44 to the stack. It thus expects R6 to be
equal to 0xffffffd4.

  0: R1=ctx() R10=fp0
  0: (bf) r2 = r10                      ; R2=fp0 R10=fp0
  1: (7a) *(u64 *)(r2 -40) = -44        ; R2=fp0 fp-40=0xffffffd4
  2: (79) r6 = *(u64 *)(r2 -40)         ; R2=fp0 R6=0xffffffd4 fp-40=0xffffffd4
  3: (85) call bpf_get_prandom_u32#7    ; R0=scalar()
  4: (b7) r0 = 0                        ; R0=0
  5: (95) exit
  processed 6 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0

The call at instruction 3 simply provides us with a pruning point. At
the moment, it is required to trigger the test oracle (but not to
reproduce the bug).

When running this program with JIT disabled and the test oracle
enabled, it will throw the following kernel warning:

  [ 29.845786] ------------[ cut here ]------------
  [ 29.846696] oracle caught invalid states in oracle_map[id:22]: r6=0xffffffffffffffd4
  [ 29.847857] WARNING: kernel/bpf/oracle.c:368 at 0x0, CPU#1: minimal/544

The "bpftool oracle" command introduced at the end of this patchset
shows the information saved on registers:

  # bpftool oracle dump id 22
  State 0:
  R0=scalar(u64=[0; 18446744073709551615], s64=[-9223372036854775808; 9223372036854775807], u32=[0; 4294967295], s32=[-2147483648; 2147483647], var_off=(0; 0xffffffffffffffff)
  R6=scalar(u64=[4294967252; 4294967252], s64=[4294967252; 4294967252], u32=[4294967252; 4294967252], s32=[-44; -44], var_off=(0xffffffd4; 0)

  Found 1 state

Our small example contains a single path and a single state at the
pruning point, but the oracle isn't limited to that. If there are
several saved states, it will compare concrete runtime values with each
state and warn only if none of them match the concrete values.


Limitations and other considerations
====================================

- The current version uses a special LDIMM64 instruction to encode the
  map addresses in the bytecode for lookups from the interpreter. This
  is very hackish, so I'd like to replace it with something else. One
  option is to use a new instruction closer to BPF_ST_NOSPEC. Another
  option is to avoid adding any instruction and lookup the maps from
  the hashmap of maps. We however need the instruction index for that,
  so it would mean keeping a count of instruction indexes in the
  interpreter.

- The oracle test is enabled via a new kernel config. This feels like
  the easiest option for fuzzers as they can enable it once and for all
  in their test VM images. Other, runtime options may require a bit
  more work as we'd potentially need to remember which programs have
  been loaded with the oracle enabled.

- The current version doesn't support subprogs. I'm not seeing any
  blocker, except that we don't have the callchain at runtime. We would
  therefore need to save states for different calls under the same key
  (the instruction index) and would likely lose some precision.

- As shown in the example above, we currently need pruning points to
  detect bugs. There's a tradeoff here between saving information too
  often (high memory usage) vs. not often enough (lower precision).
  Pruning points felt like a good middle ground, but we can also choose
  a different heuristic (ex., jump targets + exits).


Paul Chaignon (8):
  bpf: Save pruning point states in oracle
  bpf: Patch bytecode with oracle check instructions
  bpf: Create inner oracle maps
  bpf: Populate inner oracle maps
  bpf: Create and populate oracle map
  bpf: Check oracle in interpreter
  bpf: Introduce CONFIG_BPF_ORACLE
  bpftool: Dump oracle maps

 include/linux/bpf.h               |   6 +
 include/linux/bpf_verifier.h      |  45 ++++
 include/linux/tnum.h              |   3 +
 include/uapi/linux/bpf.h          |  10 +
 kernel/bpf/Kconfig                |  14 ++
 kernel/bpf/Makefile               |   1 +
 kernel/bpf/core.c                 |  14 +-
 kernel/bpf/disasm.c               |   3 +-
 kernel/bpf/hashtab.c              |   6 +-
 kernel/bpf/oracle.c               | 387 ++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c              |  12 +-
 kernel/bpf/tnum.c                 |   5 +
 kernel/bpf/verifier.c             |  40 ++-
 tools/bpf/bpftool/main.c          |   3 +-
 tools/bpf/bpftool/main.h          |   1 +
 tools/bpf/bpftool/oracle.c        | 154 ++++++++++++
 tools/bpf/bpftool/xlated_dumper.c |   3 +
 tools/include/uapi/linux/bpf.h    |  10 +
 18 files changed, 695 insertions(+), 22 deletions(-)
 create mode 100644 kernel/bpf/oracle.c
 create mode 100644 tools/bpf/bpftool/oracle.c

-- 
2.43.0


