Return-Path: <bpf+bounces-76567-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6C2CBC585
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 04:43:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AB6330198BD
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 03:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A322BDC03;
	Mon, 15 Dec 2025 03:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWHuTGnh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69C6299A84
	for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 03:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765770163; cv=none; b=qDvXglvqgJSCohltgRLl208YWMA0gA6dwLk3nb4WSX70omV8vR3odv+/2a65/W4lyHergvPW4W+Lmj/wNBtUBw9kVnmZSiQTL/+KR5q92Hv7oe/dra6gYIx7fTo0uSwSiJHIowUaSFIMkMeY0ihRGQt2IYKgPdZR5k2Vv2PPzmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765770163; c=relaxed/simple;
	bh=ibIM4TX7cp7j5rzkpQcOwF+7GvfSSEk1s4Wm2vweWHo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ktUZd4s++jZftKW67XM7sGta1PESrMn2EsbwMW+9ocUElNOXc6eut6RWzqEs6VUW/BW3hCB1oauaepjQeszbq8+76ObLZvQRTBLo6azcH0PL3cG+WlkucZeSfSS/WHfilNqF0SUrj5rGtusQSI/hXiuAqjF5Gg7YK7aqlo3kENc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWHuTGnh; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34c61194e88so513855a91.2
        for <bpf@vger.kernel.org>; Sun, 14 Dec 2025 19:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765770161; x=1766374961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mtRB0zkJ3HG5Hdm3UQaSp1wc+rUL/O1jX3OIcn3vp+Q=;
        b=VWHuTGnhFa53AvFdwRgUXq0x+yCxRJdoj4y76EJMYnRCNt6DC5VmVsPZz2knZHNFcn
         57Ej8CUHZ6e7S/+rRZGgPcjd4wvy++WqaMvgNIrPlTc2YWjdtHKBlOnDp26OtPLJGaxb
         YVL29oD9FHw4Q+a7gD7NsPnmu7d/OSCgmRJk6ngRiqLO+f8O12ar8GfThXIWQY26AUri
         lXdh0KGM2fTRP1Wmeh7f8r6P0T85r6jGr1dhsdfxIEyLQ/8gYq2k1Z25pDkibwIuGvYg
         dcyFYE0ahXHUL+/kFo+qjkm0S7M8Jjt+doInTjqxO4lCCiV98Ovr8zO6snYSapaviJQ4
         zeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765770161; x=1766374961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtRB0zkJ3HG5Hdm3UQaSp1wc+rUL/O1jX3OIcn3vp+Q=;
        b=UEa/UFFDNduBc0Zb7pA6wi7+kbDfulnxcbRIoxR0DbosZo/I4vcLA9zD03+uOFPgTi
         8xLkJ4sLf/iEgROPLq+Uqr8cgo4Vt49MjumlTlM779K5yrDgsn6rLIgiSiqYtFr226yu
         5euM0TogS7n5Y6HoMjD5AAuwvUHPtxVMWaqa4CB/FanLiytnIwXcNgGGVZx07StyfOsE
         TvhmG6Y1WZfS5dHjDcwomlMc6CiMOOy8k09g9xiJi3qN5b6JWW8xEQ0y3DH/KZdUzXBO
         yki8kbjXRL3G9LsNO22csk/iBa8GrLFhIxS/H1WaGh8bajQhIdzIuhv+krpLiYC7YMhA
         CBeA==
X-Forwarded-Encrypted: i=1; AJvYcCUDn0IcmrEaD/uC8nV0WnkAlHR3XlyTvuBQ6GyJDoRmYxhjkP5RtnR0bdazEKibowXHGwM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz74bg5NhDF1Ns4p20JOy39GRgb6Zghqu88GvhB2SDaJBAWfdZw
	8SYpctXQq9QNz+ih8SFF/s7DlFthURzf8lcYOnevACwVVJkTWY/Q4O/G
X-Gm-Gg: AY/fxX5INDHxIymVsBkpgRsOVfKn8EJgZKWdsq4xxzTOdQgF+4PPCQNSqh3sbNUpXt8
	SCik2v948xPkE9kb4wtD/S2jG/JBu+wREtU2EflA4wzskR+Q12lAw09CXgJK5epQT7YXxEDSJ87
	bxLubKcLk7/qzBPrl1kcQ6f63FgbqoS0LoDG5EnnCyhaQTpCSOmmxkDzHj6xJRqpBtWkXs7Wkgq
	ai1jK0OVQau2MrHLVOW12kdHISRa5WAXxsHqGTncRtdkmRguK/MMuuVHedxbqbhVlMv1msFAeeE
	QkDMfMyVEpibKDZyYLR3B1SrxGRCz9P2tn+ZmZdh6ZuSz5rKqzbbCc4V91emRJvp8btPH3NBkUv
	Q4BzTBjr9ZmAGAy7lGKi2PTf0+Ts+zPD6O7BmXf2OzNMzB8nzCULOPGiLxQbnvaQxBI7XJViAud
	EzJDyaki2fRcLLMxXXmLflCuihauM=
X-Google-Smtp-Source: AGHT+IGeau3ao+6xHm9AkOhfO7rXtTXbYEf+yKU6grsiOmblRejz+ckM0tTLxMTWZMcDFLNC0BM6yg==
X-Received: by 2002:a17:90b:1d04:b0:336:b60f:3936 with SMTP id 98e67ed59e1d1-34abd7be51cmr9537815a91.12.1765770160988;
        Sun, 14 Dec 2025 19:42:40 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe23a207sm3420562a91.1.2025.12.14.19.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 19:42:39 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v4 0/3] Use BTF to trim return values
Date: Mon, 15 Dec 2025 11:41:50 +0800
Message-Id: <20251215034153.2367756-1-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

This patch series addresses two limitations of the funcgraph-retval feature:

1. Void-returning functions still print a return value, creating misleading
   noise in the trace output.

2. For functions returning narrower types (e.g., char, short), the displayed
   value can be incorrect because high bits of the register may contain
   undefined data.

By leveraging BTF to obtain precise return type information, we now:

1. Void function filtering: Functions with void return type no longer
   display any return value in the trace output, eliminating unnecessary
   clutter.

2. Type-aware value formatting: The return value is now properly truncated to
   match the actual width of the return type before being displayed.
   Additionally, the value is formatted according to its type for better human
   readability.

Here is an output comparison:

Before:
 # perf ftrace -G vfs_read --graph-opts retval
 ...
 1)               |   touch_atime() {
 1)               |     atime_needs_update() {
 1)   0.069 us    |       make_vfsuid(); /* ret=0x0 */
 1)   0.067 us    |       make_vfsgid(); /* ret=0x0 */
 1)               |       current_time() {
 1)   0.197 us    |         ktime_get_coarse_real_ts64_mg(); /* ret=0x187f886aec3ed6f5 */
 1)   0.352 us    |       } /* current_time ret=0x69380753 */
 1)   0.792 us    |     } /* atime_needs_update ret=0x0 */
 1)   0.937 us    |   } /* touch_atime ret=0x0 */

After:
 # perf ftrace -G vfs_read --graph-opts retval
 ...
 2)               |   touch_atime() {
 2)               |     atime_needs_update() {
 2)   0.070 us    |       make_vfsuid(); /* ret=0x0 */
 2)   0.070 us    |       make_vfsgid(); /* ret=0x0 */
 2)               |       current_time() {
 2)   0.162 us    |         ktime_get_coarse_real_ts64_mg();
 2)   0.312 us    |       } /* current_time ret=0x69380649(trunc) */
 2)   0.753 us    |     } /* atime_needs_update ret=false */
 2)   0.899 us    |   } /* touch_atime */

Note: enabling funcgraph-retval now adds overhead due to repeated btf_find_by_name_kind()
calls during trace output. A separate series [1] optimizes this function with
binary search (O(log n) vs current O(n)), which will greatly reduce the impact.

Here is a performance comparison:

1. Original funcgraph-retval:
# time cat trace | wc -l
101024

real    0m0.682s
user    0m0.000s
sys     0m0.695s

2. Enhanced funcgraph-retval:
# time cat trace | wc -l
99326

real    0m12.886s
user    0m0.010s
sys     0m12.680s

3. Enhanced funcgraph-retval + optimizined btf_find_by_name_kind:
# time cat trace | wc -l
102922

real    0m0.794s
user    0m0.000s
sys     0m0.810s

We can see that after optimizing btf_find_by_name_kind, the overhead
becomes negligible.

Changelog:
v4:
- Build trace_btf.c only when CONFIG_DEBUG_INFO_BTF is enabled
- Remove the redundant dependency of CONFIG_PROBE_EVENTS_BTF_ARGS
- Update related documentation and the cover letter

v3:
- Link: https://lore.kernel.org/all/20251209121349.525641-1-dolinux.peng@gmail.com/
- Print the return value based on its type for human readability, thanks Masami
- Update documentation and cover letter

v2:
- Link: https://lore.kernel.org/all/20251208131917.2444620-1-dolinux.peng@gmail.com/
- Update the funcgraph-retval documentation
- Revise the cover letter

v1:
- Link: https://lore.kernel.org/all/20251207142742.229924-1-dolinux.peng@gmail.com/

[1] https://lore.kernel.org/all/20251208062353.1702672-1-dolinux.peng@gmail.com/

pengdonglin (3):
  ftrace: Build trace_btf.c when CONFIG_DEBUG_INFO_BTF is enabled
  fgraph: Enhance funcgraph-retval with BTF-based type-aware output
  tracing: Update funcgraph-retval documentation

 Documentation/trace/ftrace.rst       |  88 +++++++++++--------
 kernel/trace/Kconfig                 |   2 +-
 kernel/trace/Makefile                |   2 +-
 kernel/trace/trace_functions_graph.c | 124 ++++++++++++++++++++++++---
 4 files changed, 163 insertions(+), 53 deletions(-)

-- 
2.34.1


