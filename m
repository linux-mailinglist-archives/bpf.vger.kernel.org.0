Return-Path: <bpf+bounces-65834-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8829FB29130
	for <lists+bpf@lfdr.de>; Sun, 17 Aug 2025 04:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DF67204D64
	for <lists+bpf@lfdr.de>; Sun, 17 Aug 2025 02:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024DE1EFF80;
	Sun, 17 Aug 2025 02:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Afsn1Nrl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7FB3C1F;
	Sun, 17 Aug 2025 02:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755398775; cv=none; b=imIB5cyKjdis43912tPDqxKl4taAJ8JybXqkJv1h1/qivSPlkhUrcw1O4HV3kRAcj+50Mlm2Qjw1O+hnnv7M91fUmFB6MmadZtMZ1aGep52W+vUD9yG4AlFNKiaTYAlGKOGj1Oj48UbYXFejOmMfjoTrDLZw/uxBJA4oAQ5U8vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755398775; c=relaxed/simple;
	bh=nwI5eaYUv9jw6Y4QtFpKylKB7dNuEDwo5rWB/1eL9+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MwArOXDBa80fwYL4eijb6mqM2XlmRbRb+mCOFOLrvfmDNfJv7Bik3z54wr4ZoRZJcr/Sa/PSbwvK/vwH/sxSQAAifzryNnv1OD+7X4T9YPQA6Xn1e82oGWHERJ54us9zlavrUva4OUBwn3d1r7HC2t7w7uRBeEcB8BkttqyVn2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Afsn1Nrl; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-b4716fa7706so2193281a12.0;
        Sat, 16 Aug 2025 19:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755398773; x=1756003573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sRIUhw/IEhGIf+A2O36A7GMxHFcX5npoB41N/97cUcY=;
        b=Afsn1NrlDYsxOgx92XP/UFgf/yJh9tjQxkeVrVje62uT6x/rO5OcpF5Rl7urXVYozw
         x1UX14pXzjVqLNzWd3z/seb5kNeHy9JX5yQU6baEp3+IdUMYIHX0xMdkmpTobE7B787b
         8nhZOAZlYxTxzkEVyH5PF0bxEdCny5x6+17a13w6+cOHm9dfKpkE7wcJiBBCOmDQaaMK
         irNIwmQ10Xg0t+6UNEv9H+m/kIMZU2ewstDVpfUr5xge4ZGn9NwV4AGHsODUscYr8thF
         F1J9A9A2EIuG2yKt/VZr0wrbBs4oHDo9QhDc8kQi7akaI2B1bnSO2Ohq4YPDzoVbGu0c
         fv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755398773; x=1756003573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sRIUhw/IEhGIf+A2O36A7GMxHFcX5npoB41N/97cUcY=;
        b=sAKFCYcne5nSWdSaEcwn0b1W/KyIA0IzhXpqr7GdAEqkFoSMjuIZm5lqKA/2NOL3nt
         VmlETunBt/dmEoqyU9oyujWZQI6ra2YGCD3pwvhZKQwIsZ3PeNBobHbQX6x0myYDbALY
         1blnJQ2H9vjTBqtsMqZYIiJZ1GSQmVuG0N7pnnWQzF3QmH+KL0ZAamqAxqx0yri0qPPm
         B62paKO56zhdgtDyNGhapTYNQ5JK8Ovrn+hoQ2/ASDgiXI/xhJyN5G/CIDQ+rSZCM27+
         7UGkn4q1+zBVEqYrIbF6oOC06le1T6FGBPBWYb+6+bG+wbFXr4UqFJuLLOcgVpqtHmPU
         rTQg==
X-Forwarded-Encrypted: i=1; AJvYcCU+aEcgEwXM54DWx165hZk/xAj6D2lgD7dy0gNNvBvZ7qT89ZdK2y4r1uUC5Gez8S0PiEZOXzmKrzyzN281nJmw19u1@vger.kernel.org, AJvYcCUviE6qDz9b3Bf5NKdzxdWCjewFss+qNkwS/qqen+rG25kxKI4YvLu6Lhv/t4eWGrdm+hfUjrh7FO4rFkyC@vger.kernel.org, AJvYcCWbF3IQouq3QUSaiHCJAbUYZ5dzVPW4qI7Iedgd7mya5ovLlztAoMZ4q/894I1xYHbQuM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YylEppHj8FUYgNIciPRu7Pr2sQcgwCU2/5ssLYUG7QvBgijLG+3
	4yTmbvIsSwJjmZ4x1wChtqByNtoNpognjYHgb4MRwkT7zs0AMb+6nmaPPOlVeYKLikg=
X-Gm-Gg: ASbGncusnvE6X9WAS8Firzl2FH8ANs8fGN9SXxksvIkf3Da3xzcb2Qb2JBiIC7canWH
	tur6IF/BGBc4n+cVgnEvHez7QL2pNMnAEjb8jXJ2dFjYrI+1ut0bhZUZv6Sc+J8MmI72AxnNtAY
	5UCHL1RFiEbCxEskhwMuOir/cuGFNqHLUFcddWUq7iyi5jNWU5Ew7UmEkpE4nPBonR7nWNLMurD
	vq8FPoCf+RxF2sMl4rbX1cHf64pVPI+nFy+Ye3+mffBuWjQ3vLLK/SVhgDanQpay3+RgY+YC+oU
	kZf3kMURqhTW5s7a5WXWJvCQOuJfCbtQ4LfvBFtzxjm6H1MpZ5fqXJSGWXwizX3oyj3WDvvWtOi
	yMmUfUoLbEQsozyOVU+s=
X-Google-Smtp-Source: AGHT+IHaCa5OM6bFowuy2VX9T1JhM6lMRmHltQXFa3fSS043WIVPaWo2NZl/fCRWqPB0VA4yvzt3jw==
X-Received: by 2002:a17:903:1b6d:b0:242:9bc5:31a1 with SMTP id d9443c01a7336-244790079d7mr54687305ad.57.1755398773212;
        Sat, 16 Aug 2025 19:46:13 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d50f382sm45009845ad.79.2025.08.16.19.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 19:46:12 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	hca@linux.ibm.com,
	revest@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v5 0/4] fprobe: use rhashtable for fprobe_ip_table
Date: Sun, 17 Aug 2025 10:46:01 +0800
Message-ID: <20250817024607.296117-1-dongml2@chinatelecom.cn>
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

Changes since V4:

* remove unnecessary rcu_read_lock in fprobe_entry

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
 kernel/trace/fprobe.c                         | 151 +++++++-----
 tools/testing/selftests/bpf/bench.c           |   4 +
 .../selftests/bpf/benchs/bench_trigger.c      |  54 ++++
 .../selftests/bpf/benchs/run_bench_trigger.sh |   4 +-
 .../bpf/prog_tests/kprobe_multi_test.c        | 220 +----------------
 .../selftests/bpf/progs/trigger_bench.c       |  12 +
 tools/testing/selftests/bpf/trace_helpers.c   | 233 ++++++++++++++++++
 tools/testing/selftests/bpf/trace_helpers.h   |   3 +
 9 files changed, 398 insertions(+), 286 deletions(-)

-- 
2.50.1


