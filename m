Return-Path: <bpf+bounces-65725-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 835C9B27968
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 08:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8EC83BB98C
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 06:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE88929ACC4;
	Fri, 15 Aug 2025 06:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGxU90Pt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA43212D67;
	Fri, 15 Aug 2025 06:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755240443; cv=none; b=D/mYL5we0Tu7spMzW6cf8a3vFVcDRA9Dl1K9F/dJeT6Sc1VotY51UslwqdXDopvSLCKWwBnYV4xJHKHOdk8zg3uK2nhISTtQxBNAlNhoVvw7ZfYA94N7oCwFEvFn1pwllYRR1Endb4jHfBUVi3dUqkJTid+8bzTOALMPteHKDmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755240443; c=relaxed/simple;
	bh=IZlWbT96BcnyBIqxmeZraeIj7dUKCNgtkn5HFxMGtNU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VvSDaLuY9rZcr2XI2CbIiMLfyk6FkW8QiO5q9hzLNPwTVMzO3lgRutYm/5Hd8J74j0hYVtNcEMApVcy8G3dwHi/lCGTR2R+wiP/0xJ6y8Rk7B7nEDUm5X63Hkh+l6z5ZWB8bNRmF2E3v2OtOx/Vd5f/WGdBlb+lWy1wK6cZ4RLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGxU90Pt; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-2430c5b1b32so19527405ad.1;
        Thu, 14 Aug 2025 23:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755240441; x=1755845241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8D70S+AlgpjGQTjMoF1noskRlhNiso9HH6KSBHGeLzM=;
        b=lGxU90PtW9HrU1igCdU76rQq5cJh811pnwbg9wvXCiBGdvrCzVvnRBCLt/xkFxKBu+
         /+Ys96xnshYmZBiMoFYJ6OzHDE3XqqK1OZQ3tCzyAe0VQ3Wiz9KHF/zMVwZM5CLI3gIz
         IPh7+iMijrQDmPKCQxOyVB/4PD4w1LgEAsQpKA8Iq6ueyub8uOiwGsOk8e0HYqvC/KgA
         hedGhq9EnLbYCmR5cKaxFCgom/648wsYXwvYLgE+ECgn47sjCWqHXwYIZcJzVfcVVryP
         zjL/w5jfg5VCDBugbVbn4tHGelbH74cakpb2Hf/Hq6DNPT75/umRR7b67VouCK8AsZcd
         yeUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755240441; x=1755845241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8D70S+AlgpjGQTjMoF1noskRlhNiso9HH6KSBHGeLzM=;
        b=qjO243OtQvFgp5lv8rht19AJ2bXy2NblmyCPTzNuGDWshi5AAfuhzLHG1wSbQoztPL
         ixY3Sw+2Q5uyDZee4+W3Oig7yudRAZkhedwbczEJvan5nDjlTMWZ4PVE8IDCNqv1/HhY
         erZARM1k9h8JLdSqkCHPGbGQGu281wX49c0SJItaLdUcyypTZUpURCMYIf1cIeIvOQ31
         diKdv6gvCDja4HxSs49BSoXoAEyXQo4Mf/XLMjB9oylkGS6yBlja0ILruCG8z8T+FTgf
         iErfwVTwaR/r2X8/yDEpfNZ8QqDGB1Fel2D+23BBqmq1OiA7BEUGJLGbpfzKyu/VAaoO
         a57g==
X-Forwarded-Encrypted: i=1; AJvYcCUPTQ50TgJAgn/MJabs+UNYnPs+7osj5FNMfGIYLWYM9vjGtOtnDJgi+LJNMUnxdHltnXf4u/Bgq3sfDk6cJPmx45Ua@vger.kernel.org, AJvYcCWaRI9xI9yDBtIjw/P2Qmk1CVwNiUoTcKcphGFeY4B5gN9YiNuSHCktc4Q+cGQ1nhSti3O/bayedx5hASkY@vger.kernel.org, AJvYcCXX1BMFD+LXWuI0VOG50e4NabWsZEWSrCoEOk9iq8/zgY5uDEeAsmVdZghMNpHJu80fT6E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu3LQBs3kOKWUsohO1casZu/WN9xyGxMAph2B0s/l7bpdsj3gK
	377cX9cTLp4ZO5MzSCxatVat2gmNDcymYHX3XXjwkUZVQHDs234Zo9Ro
X-Gm-Gg: ASbGncscE6LBIXIMupaSH+4ks43ZMeuugH2FoZkElDGOToeBJ2nCjeOAz665pn7pwc3
	Qq7S7+aGktffyxiT5At2NLBU1r+qskITmJkcXt66Hfpc8eSv72FpUOluDPhmTuoRyoq3/xvguHk
	Ovgu0IlHAic/y27zVvLMoXe+doM4PmS/Zk/YgT/QV32JKmPu4kSxmQYSZHs9AS+nQhTtK7EtALp
	17QDmYKfqQ2kjrtqZNV2ozs4FmGu+63ucVYkGsPslMK3ehuPuMgiQQwG83JR9atV6cCUU398fFU
	PO9/hqW6bdpvRFR2t5YJY6WeMJ7YSq64QNwG9xX933EMMoJkbhzCzpp+UAOLg82bTY/dyYVh+68
	Dl3W9lIns9bX0EV+yUTU=
X-Google-Smtp-Source: AGHT+IGYojEoAow03/C1XMb81tlilpAyiYKfshQGfmIvgeANdsGwOeuKOwfaidwKuKQjGLGtrN+Sqg==
X-Received: by 2002:a17:902:f548:b0:242:fea2:8bf2 with SMTP id d9443c01a7336-24459484defmr83374065ad.5.1755240441031;
        Thu, 14 Aug 2025 23:47:21 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d539032sm7161665ad.109.2025.08.14.23.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 23:47:20 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: mhiramat@kernel.org,
	olsajiri@gmail.com
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	hca@linux.ibm.com,
	revest@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v4 0/4] fprobe: use rhashtable for fprobe_ip_table
Date: Fri, 15 Aug 2025 14:47:06 +0800
Message-ID: <20250815064712.771089-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

For now, the budget of the hash table that is used for fprobe_ip_table is
fixed, which is 256, and can cause huge overhead when the hooked functions
is a huge quantity.

In this series, we use rhltable for fprobe_ip_table to reduce the
overhead.

Meanwhile, we also add the benchmark testcase "kprobe-multi-all" and, which
will hook all the kernel functions during the testing. Before this series,
the performance is:
  usermode-count :  889.269 ± 0.053M/s
  kernel-count   :  437.149 ± 0.501M/s
  syscall-count  :   31.618 ± 0.725M/s
  fentry         :  135.591 ± 0.129M/s
  fexit          :   68.127 ± 0.062M/s
  fmodret        :   71.764 ± 0.098M/s
  rawtp          :  198.375 ± 0.190M/s
  tp             :   79.770 ± 0.064M/s
  kprobe         :   54.590 ± 0.021M/s
  kprobe-multi   :   57.940 ± 0.044M/s
  kprobe-multi-all:   12.151 ± 0.020M/s
  kretprobe      :   21.945 ± 0.163M/s
  kretprobe-multi:   28.199 ± 0.018M/s
  kretprobe-multi-all:    9.667 ± 0.008M/s

With this series, the performance is:
  usermode-count :  888.863 ± 0.378M/s
  kernel-count   :  429.339 ± 0.136M/s
  syscall-count  :   31.215 ± 0.019M/s
  fentry         :  135.604 ± 0.118M/s
  fexit          :   68.470 ± 0.074M/s
  fmodret        :   70.957 ± 0.016M/s
  rawtp          :  202.650 ± 0.304M/s
  tp             :   80.428 ± 0.053M/s
  kprobe         :   55.915 ± 0.074M/s
  kprobe-multi   :   54.015 ± 0.039M/s
  kprobe-multi-all:   46.381 ± 0.024M/s
  kretprobe      :   22.234 ± 0.050M/s
  kretprobe-multi:   27.946 ± 0.016M/s
  kretprobe-multi-all:   24.439 ± 0.016M/s

The benchmark of "kprobe-multi-all" increase from 12.151M/s to 46.381M/s.

I don't know why, but the benchmark result for "kprobe-multi-all" is much
better in this version for the legacy case(without this series). In V2,
the benchmark increase from 6.283M/s to 54.487M/s, but it become
12.151M/s to 46.381M/s in this version. Maybe it has some relation with
the compiler optimization :/

The result of this version should be more accurate, which is similar to
Jiri's result: from 3.565 ± 0.047M/s to 11.553 ± 0.458M/s.

Changes since V3:

* replace rhashtable_walk_enter with rhltable_walk_enter in the 1st patch

Changes since V2:

* some format optimization, and handle the error that returned from
  rhltable_insert in insert_fprobe_node for the 1st patch
* add "kretprobe-multi-all" testcase to the 4th patch
* attach a empty kprobe-multi prog to the kernel functions, which don't
  call incr_count(), to make the result more accurate in the 4th patch

Changes Since V1:

* use rhltable instead of rhashtable to handle the duplicate key.


Menglong Dong (4):
  fprobe: use rhltable for fprobe_ip_table
  selftests/bpf: move get_ksyms and get_addrs to trace_helpers.c
  selftests/bpf: skip recursive functions for kprobe_multi
  selftests/bpf: add benchmark testing for kprobe-multi-all

 include/linux/fprobe.h                        |   3 +-
 kernel/trace/fprobe.c                         | 155 +++++++-----
 tools/testing/selftests/bpf/bench.c           |   4 +
 .../selftests/bpf/benchs/bench_trigger.c      |  54 ++++
 .../selftests/bpf/benchs/run_bench_trigger.sh |   4 +-
 .../bpf/prog_tests/kprobe_multi_test.c        | 220 +----------------
 .../selftests/bpf/progs/trigger_bench.c       |  12 +
 tools/testing/selftests/bpf/trace_helpers.c   | 233 ++++++++++++++++++
 tools/testing/selftests/bpf/trace_helpers.h   |   3 +
 9 files changed, 402 insertions(+), 286 deletions(-)

-- 
2.50.1


