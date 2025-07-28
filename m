Return-Path: <bpf+bounces-64480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB57B135AB
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 09:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14F833A8167
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 07:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CC322A817;
	Mon, 28 Jul 2025 07:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dm0m8TbL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265DF1F2B8D;
	Mon, 28 Jul 2025 07:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753687608; cv=none; b=TV5w7Ny1FbXVQUzFdXh8XNuJ0JVduIgLAfB2m2km47WvKB0LryoFkJewC2m4kYllhoQU145KwNgHhZGZJuhDsWX/o1K76PrBXI1Yeq8XbCgr93tcHNNvJAGCkvkTdU3wwAV49hGdsC75iJY7kqTm3dKEOqMresQp1z9B/rfdO6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753687608; c=relaxed/simple;
	bh=WKvlZPyL1Fm7MpFp9b4s0A0mkEyPyIUelorUTt08R+U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OI8KO1aCawhEUN5vzr6z6rHMhRJ4A8ZHpwlgPBb5ZZHP8L5VlC6+qLlu/wg6nyhnlHuNvUdvumCklq8ZFPV8tQZp82uJWVrqgWZts1PqwZtfBph0PK2rJw5CEVgMSuRHH5cT/RmU+I1FpKtzTraiCYR+cuhGz31iPEGNNOljN9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dm0m8TbL; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-b3507b63c6fso4440233a12.2;
        Mon, 28 Jul 2025 00:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753687606; x=1754292406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=apq8PjwosLySfRJXp9P4tlu1kD8EEX224uWUFDuZDCQ=;
        b=dm0m8TbL5o4EsBZSjJ5rqNICQ40NCbYJZY4fKaAk9uwSnLEeSTbERF/wN1KYCeKHEb
         TgpRc3xqmxJYQ1OSPhfP72wraO+J+PKfP1//lBCx+1Q/+OOLVupTY48Z6IazUN+NNCbA
         1OU4rLfOiAJeVRcf9vZpSMKARvt5pwq39hskql9pP9b7z8tYh6vtzHEaBBZopn+a5coe
         luxbX3bJiXUh7znkRyvE6nKY/Yo4JVpLhyD54T4TyH+PTDxe68ak8DtX9VKWb3G2b5sD
         7AhnKT0dC0g9AEbYoMP9dPReQvA4N6mX1giWgxa+J4HPzgCjuxYZjf53m0/ANkrNl+0u
         Drgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753687606; x=1754292406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=apq8PjwosLySfRJXp9P4tlu1kD8EEX224uWUFDuZDCQ=;
        b=bszXDnjzWYZccXatjg5tjPv5VqcUNOK/yBC15WkDzk6n3yBu4Eg1aRp7sNT5PIYNa0
         ILBMYU17vul8mfndq06jqHpQybJx2Jb67qpG/K/H+GIlha8kgiXtS7DYfaBB8dt5Nb29
         oE/rI36VhP8Z8ng3uBvJNPzbqPt8HiYmkJlyHPfNJOBf6Mge8V3XKuM1ts2O9e98/Opm
         D44qZRVh8ti+kYfdQFtUBqgoM90VzhxhojQNWtteBmtnVjXbg6cxojWUvOpfrIvNXQ4J
         lSiSNP82/HzVPATyGNo7HPHf5SmXByWnvr7MV42nEPKDV7YhDef2wtx93rax14iaBswm
         uQ8A==
X-Forwarded-Encrypted: i=1; AJvYcCVUTlWYkMB/hdFDoGqGnUuGiyp7j1pMm+D3pAMCzv2oUhR6ncSMKfGccZkEUFj/6S7sw/Q=@vger.kernel.org, AJvYcCW8pG3IZ0nN+9m1mzoKEEk9CAXVC5ldOjccH4+AwJNG9qs+8vGmKd6FcjUzKerXri36gOOmwqKKe/47juO8@vger.kernel.org, AJvYcCXDWn7jiGmOjCIdQhrEcphhIoRpir9CQrHCteplZNqC/qhi+A8EUXBX+yJmh3N39Pd+rLqFJ/nB19KaJUo+Yfr1Ez0K@vger.kernel.org
X-Gm-Message-State: AOJu0YyqwLpRfVmnYO9V4FpNpFxsyUdIRUIt7ViTP4IacVuOcef3USlA
	cQB9BUeAUX74dP7SeANB0ce/BgPXU6Hf16BYZWcnF1R+3qujt2llUDudRqCRvXTlrg4=
X-Gm-Gg: ASbGncuwg0pnSlY0bPy7Ay8EgABbnWEwWS4JnXZvhAqbvXAra3ZATfH9PmoLx7gP+4v
	wfHeZvW9qAeEvOTrP6/5x6FZdRTHTxmM5qXk71MPQycyj0KeLUYER196z9L1mzZPpyFiWux1PEB
	LAV4NhNwkWGHNOhPZnDnNDyPnuYZzFJjm4j/sSn1wuL+FvW6BBgvO75u9yeJV84cABaLsj+twLt
	Mhz50lzFlLlFbLYqaWC6j03Z/PtrFgLsQgK4oWiKfrmsVkUZvULgddpAfIib36YwWqSifFeM11t
	4lwjwoUCSDigljV3RjyaBfbaqyTOZ3o9wDpB8iccnPIYSVSiyVKk9C54enWxk5xRXkIhxoBdG83
	AVhMVMP7VNQfx87vRMoE=
X-Google-Smtp-Source: AGHT+IFJMRzQt1dnKwV8TwKyyxpmmXahPcp38uihTtwXhKNLljVtIBA6+++mLJ6BI6hQ77P1Qg2LEQ==
X-Received: by 2002:a17:90b:3ec6:b0:31c:3669:3bd8 with SMTP id 98e67ed59e1d1-31e77adba28mr17312945a91.21.1753687604213;
        Mon, 28 Jul 2025 00:26:44 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31e949bbf7asm4459599a91.9.2025.07.28.00.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 00:26:43 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com,
	mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	hca@linux.ibm.com,
	revest@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH RFC bpf-next v2 0/4] fprobe: use rhashtable for fprobe_ip_table
Date: Mon, 28 Jul 2025 15:22:49 +0800
Message-ID: <20250728072637.1035818-1-dongml2@chinatelecom.cn>
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

Meanwhile, we also add the benchmark testcase "kprobe-multi-all", which
will hook all the kernel functions during the testing. Before this series,
the performance is:
  usermode-count :  875.380 ± 0.366M/s 
  kernel-count   :  435.924 ± 0.461M/s 
  syscall-count  :   31.004 ± 0.017M/s 
  fentry         :  134.076 ± 1.752M/s 
  fexit          :   68.319 ± 0.055M/s 
  fmodret        :   71.530 ± 0.032M/s 
  rawtp          :  202.751 ± 0.138M/s 
  tp             :   79.562 ± 0.084M/s 
  kprobe         :   55.587 ± 0.028M/s 
  kprobe-multi   :   56.481 ± 0.043M/s 
  kprobe-multi-all:    6.283 ± 0.005M/s << look this
  kretprobe      :   22.378 ± 0.028M/s 
  kretprobe-multi:   28.205 ± 0.025M/s

With this series, the performance is:
  usermode-count :  902.387 ± 0.762M/s 
  kernel-count   :  427.356 ± 0.368M/s 
  syscall-count  :   30.830 ± 0.016M/s 
  fentry         :  135.554 ± 0.064M/s 
  fexit          :   68.317 ± 0.218M/s 
  fmodret        :   70.633 ± 0.275M/s 
  rawtp          :  193.404 ± 0.346M/s 
  tp             :   80.236 ± 0.068M/s 
  kprobe         :   55.200 ± 0.359M/s 
  kprobe-multi   :   54.304 ± 0.092M/s 
  kprobe-multi-all:   54.487 ± 0.035M/s << look this
  kretprobe      :   22.381 ± 0.075M/s 
  kretprobe-multi:   27.926 ± 0.034M/s

The benchmark of "kprobe-multi-all" increase from 6.283M/s to 54.487M/s.

The locking is not handled properly in the first patch. In the
fprobe_entry, we should use RCU when we access the rhlist_head. However,
we can't use RCU for __fprobe_handler, as it can sleep. In the origin
logic, it seems that the usage of hlist_for_each_entry_from_rcu() is not
protected by rcu_read_lock neither, isn't it? I don't know how to handle
this part ;(

Menglong Dong (4):
  fprobe: use rhltable for fprobe_ip_table
  selftests/bpf: move get_ksyms and get_addrs to trace_helpers.c
  selftests/bpf: skip recursive functions for kprobe_multi
  selftests/bpf: add benchmark testing for kprobe-multi-all

 include/linux/fprobe.h                        |   2 +-
 kernel/trace/fprobe.c                         | 141 ++++++-----
 tools/testing/selftests/bpf/bench.c           |   2 +
 .../selftests/bpf/benchs/bench_trigger.c      |  30 +++
 .../selftests/bpf/benchs/run_bench_trigger.sh |   2 +-
 .../bpf/prog_tests/kprobe_multi_test.c        | 220 +----------------
 tools/testing/selftests/bpf/trace_helpers.c   | 230 ++++++++++++++++++
 tools/testing/selftests/bpf/trace_helpers.h   |   3 +
 8 files changed, 348 insertions(+), 282 deletions(-)

-- 
2.50.1


