Return-Path: <bpf+bounces-43840-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6509BA775
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 19:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F1CC1C20B3B
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 18:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0B51632E0;
	Sun,  3 Nov 2024 18:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jyj2MzXw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF9413635E
	for <bpf@vger.kernel.org>; Sun,  3 Nov 2024 18:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730659310; cv=none; b=Xlo6Cxw9KW7TKAMxJSN92+a7FpYvzC9wqMaz4q7ci6TYaYK86HVd6gN7yGgZUMZXlU4XIku+FLp7T9vo+nkCJJZBhUnVZaxyYgOA8mNliDjcChcw1CdpdhlEeZ3GLSjWqIHj7Irl0eKx6d7WcQc3qJzWdnCfKG2ytRGj0hC0maQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730659310; c=relaxed/simple;
	bh=OpxLseP31MIrcx8z8lL8fCGjLhD3/vme2zR2Dl+zUcA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gRvL2jVCiiHQ2qY8xBnTFGXOxc4POETMHGJec9j0cpaJ0pcLh/HgD+cgNaCJQ2+CJFDhoZdvkgwg7QlQAPXNRgfWxGCieCQqKdzEG2w0Ai6Ot49LQ2COG5r83ccsQm0UIegWX8Q3BAV5ue03/TiMvs0ZuzLz+ew12d6JE+5Gd14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jyj2MzXw; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-37d8901cb98so2727088f8f.0
        for <bpf@vger.kernel.org>; Sun, 03 Nov 2024 10:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730659306; x=1731264106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uQ98f+e5LS5BQkUyQcAG4pWv8J9m0PRoLfibQEAhj6Y=;
        b=Jyj2MzXwOuFZDzM3y8kfUNr8TnaH9Jqgj9GfmMRNdgkx4DAJx/X7yLOF7925zWehk7
         gECT6TwNHwa/zUg1/YdNd82XgYOKIkeqH0TLahXVhxIcLUA2Yc+Pdo4FV3atuhV/2fzS
         Ra0rzS/SbOOvdOGVNnJKSTDHs/WAiwomXKONIQMp/YxxU1kC4TvFtjoJ68853wm2LuA3
         6z3MwdU56doBiCrhzGqfTJdny0whEFiZTVh4HblgjGKNTyqIirHa97h2r3S9wZDYe9FJ
         iPyMPlTlhidFq+H72gdxaFs4MG6nS0PW9QSfhLoVfA5WfhCl/6aOHGUZjV65pTBEPecB
         FF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730659306; x=1731264106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uQ98f+e5LS5BQkUyQcAG4pWv8J9m0PRoLfibQEAhj6Y=;
        b=UsD0nBgK3ltZb7GGpovjQyELdmAlpIEyr/zAVSoRNYp3eFMUAXuO91+V5JaHroDmcu
         mns89dg4jCK5HwxbwrTui5iTbgf74bGczMh4ub0rP/t+dkb2+5WWcZ4ONtE/REHnnKtN
         UDPAYuBuIqU1+z367P0iTJjEDgCiDt5XeW0HSI4h9IvLrjXp6d/9j4/X8VmKcR184u8Q
         i+fw530RGrSzwbpyD81aHjcAKPxcG8JtvTjPT2MFRqeF3SLYw6RyHLLlXI4erQQ/OjkB
         FzCyfen45UzjU+Yt4NfSFAiNXvY7vQSMjFhyz9DsI7OTgT90Ux4o+zRYIzKLej4URzvS
         WTtA==
X-Gm-Message-State: AOJu0Yza5eUW4y+fBkmuJNKRBKNqP8ZpFS8PWkuoIHYaODPwOX+SZc/p
	zZTcYLZQ5mS7ggvt808tV9cIuzk4uWoapirxHLJWBT8W5r8SdwOJuhc/83zjNejGnw==
X-Google-Smtp-Source: AGHT+IETR07bDznOGAeltDBaK2VwNYSLKkBEBtRMV1WKXWkk3YQe7tLnth/BJY2Vkbu/M6z/TP1Mpg==
X-Received: by 2002:a05:6000:178c:b0:374:b9ca:f1e8 with SMTP id ffacd0b85a97d-381c79e3c44mr8071566f8f.20.1730659305996;
        Sun, 03 Nov 2024 10:41:45 -0800 (PST)
Received: from localhost (fwdproxy-cln-034.fbsv.net. [2a03:2880:31ff:22::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c116ad3fsm11100518f8f.95.2024.11.03.10.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 10:41:45 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jiri Olsa <olsajiri@gmail.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v2 0/3] Handle possible NULL trusted raw_tp arguments
Date: Sun,  3 Nov 2024 10:41:41 -0800
Message-ID: <20241103184144.3765700-1-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3513; h=from:subject; bh=OpxLseP31MIrcx8z8lL8fCGjLhD3/vme2zR2Dl+zUcA=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnJ8POm39dFxRxG6vLMpwBmrgElaBIgwZj5JT5cNyI sNq5V0eJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZyfDzgAKCRBM4MiGSL8RylPqD/ 9sU3CGTRlDGT+mEeOjGeBVEEa9AiEYyxO0GphRZUb7/vz58/5FvKuWh1HlwDdDS14HCJnZXWbp3wKw hwkVgC4xTOoVNLSkE4NxOXa6jDlrIbNFuPuv5JvUhC4kEkDvSl83zRZ6kp+80j14XIrJp7Lu5UyHQy lnbCx3z45UPAIrnLuxMl1pH3IoaqTtlvD9ys3Grn919mUioh7z4TYHl/fzZ4w0FDkvEk3G7byZBLt2 1iOiEzLF6IFyw2rNuNWB3eOsWqxJD8rrQFZOkognoBijA3HAH9GFTf5AZdC+0xejeCBaOvFpEYuVvs 4XRw7kU19RnC18HRQpQNL7/3mqOnKcX2Kwb03Vswg+g+QP5YefvLed+UH0N4AyWygkZKRKj6FS/yLC tS9XBsdO4ItwQfe9TaRP8x68QBJgdYw2f56NUBMqQholrBjY4CnfxWoWv8jDC0zVkJBrzYHN8XNyoS +OPumE0tHIZolZzWuDd2w130ztH+amq+cwCAa922IEDSyVuEM2gK1sk2whCE5olkBlLRhgvOkqDYhy RXNQovZyq10jp+546SATqpCi93Yd8O0y+Bzz7KXbbv36uff0pwbbTb9xoxIj/o6BFw9CVoQoE4iZec Bfm7SeQCfKXhDjM1wMnRah5xftP8/rZF8txq0AMdB/xN5dWdOYj8guL2oTqw==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

More context is available in [0], but the TLDR; is that the verifier
incorrectly assumes that any raw tracepoint argument will always be
non-NULL. This means that even when users correctly check possible NULL
arguments, the verifier can remove the NULL check due to incorrect
knowledge of the NULL-ness of the pointer. Secondly, kernel helpers or
kfuncs taking these trusted tracepoint arguments incorrectly assume that
all arguments will always be valid non-NULL.

In this set, we mark raw_tp arguments as PTR_MAYBE_NULL on top of
PTR_TRUSTED, but special case their behavior when dereferencing them or
pointer arithmetic over them is involved. When passing trusted args to
helpers or kfuncs, raw_tp programs are permitted to pass possibly NULL
pointers in such cases.

Any loads into such maybe NULL trusted PTR_TO_BTF_ID is promoted to a
PROBE_MEM load to handle emanating page faults. The verifier will ensure
NULL checks on such pointers are preserved and do not lead to dead code
elimination.

This new behavior is not applied when ref_obj_id is non-zero, as those
pointers do not belong to raw_tp arguments, but instead acquired
objects.

Since helpers and kfuncs already require attention for PTR_TO_BTF_ID
(non-trusted) pointers, we do not implement any protection for such
cases in this patch set, and leave it as future work for an upcoming
series.

A selftest is included with this patch set to verify the new behavior,
and it crashes the kernel without the first patch.

 [0]: https://lore.kernel.org/bpf/CAADnVQLMPPavJQR6JFsi3dtaaLHB816JN4HCV_TFWohJ61D+wQ@mail.gmail.com

Changelog:
----------
v1 -> v2
v1: https://lore.kernel.org/bpf/20241101000017.3424165-1-memxor@gmail.com

 * Add patch to clean up users of gettid (Andrii)
 * Avoid nested blocks in sefltest (Andrii)
 * Prevent code motion optimization in selftest using barrier()

Kumar Kartikeya Dwivedi (3):
  bpf: Mark raw_tp arguments with PTR_MAYBE_NULL
  selftests/bpf: Clean up open-coded gettid syscall invocations
  selftests/bpf: Add tests for raw_tp null handling

 include/linux/bpf.h                           |  6 ++
 kernel/bpf/btf.c                              |  5 +-
 kernel/bpf/verifier.c                         | 75 +++++++++++++++++--
 .../selftests/bpf/benchs/bench_trigger.c      |  3 +-
 .../bpf/bpf_testmod/bpf_testmod-events.h      |  8 ++
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  2 +
 tools/testing/selftests/bpf/bpf_util.h        |  9 +++
 .../bpf/map_tests/task_storage_map.c          |  3 +-
 .../selftests/bpf/prog_tests/bpf_cookie.c     |  2 +-
 .../selftests/bpf/prog_tests/bpf_iter.c       |  6 +-
 .../bpf/prog_tests/cgrp_local_storage.c       | 10 +--
 .../selftests/bpf/prog_tests/core_reloc.c     |  2 +-
 .../selftests/bpf/prog_tests/linked_funcs.c   |  2 +-
 .../bpf/prog_tests/ns_current_pid_tgid.c      |  2 +-
 .../selftests/bpf/prog_tests/raw_tp_null.c    | 25 +++++++
 .../selftests/bpf/prog_tests/rcu_read_lock.c  |  4 +-
 .../bpf/prog_tests/task_local_storage.c       | 10 +--
 .../bpf/prog_tests/uprobe_multi_test.c        |  2 +-
 .../testing/selftests/bpf/progs/raw_tp_null.c | 32 ++++++++
 .../bpf/progs/test_tp_btf_nullable.c          |  6 +-
 20 files changed, 183 insertions(+), 31 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/raw_tp_null.c
 create mode 100644 tools/testing/selftests/bpf/progs/raw_tp_null.c


base-commit: e626a13f6fbb4697f8734333432dca577628d09a
-- 
2.43.5


