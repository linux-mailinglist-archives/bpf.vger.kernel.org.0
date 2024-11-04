Return-Path: <bpf+bounces-43905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E32649BBBA8
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 18:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EA9E1C21F32
	for <lists+bpf@lfdr.de>; Mon,  4 Nov 2024 17:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF161C4A33;
	Mon,  4 Nov 2024 17:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kffPYKbr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC9A1C07DB
	for <bpf@vger.kernel.org>; Mon,  4 Nov 2024 17:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730740805; cv=none; b=Bemm2dszp0flElOpbhB4zGOKdNorvuW1iXuws/P3RIWgKYQKuiYbLS/kCBUP0JGtwocPll2aGxkcehfrTnSDeLzFWPrIthwDt5cZMEtCmNlXKsI1WPkgOrv6mcneOoFy0eRrxvIxidUd3AJqOD6yxUj9StCWur4gEnitO0YpDzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730740805; c=relaxed/simple;
	bh=HtXQ09vGsm/4nc2VtUtcCO2S9uR+SFBkidYHAGzB19s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VZayPpl6H3keRMmORMXMCT2qCy9IsuBZlGOri33tnVtqkovwjRNgPNzBKLXtdMRKNky3PpA1ISclM8PYJLUF9Q5+6JBGqDpktF6qM7ApFGeHtzAypK03zw/tPwj7cNI4laRwO4IC2UlBpd8nCpWAXBJSqsm0+Ef05S+kMetHRR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kffPYKbr; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-431481433bdso39696685e9.3
        for <bpf@vger.kernel.org>; Mon, 04 Nov 2024 09:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730740801; x=1731345601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=crRtd8b59WQuWtElbDnVkfEK1NxnolxocTNX6rz46Js=;
        b=kffPYKbrblJJIiYjPuzH+Es7E+nUysw+fcej0dtdFqshp7MDPlhl6IXRADnQIBK3RM
         2w1USErw2hE/1aoJCjS5ML3G0glgDa6pix5N99RPSHDT2St6H3OOXSlURnVcA4aI4tPu
         ulemmOACpyzX0g4si/HQdoG+itsGilwXwH+YWB9GoNXEIrFdeHjEX2mLTGytdNF7NA41
         rGQd9ErdQ1gOkOK8lqEtqH25IGx68cCjtF+Szxo9sZKCEkmMvhZfXOrZLwn1k1230hEx
         sHVrEEg6NsCFVLkgAaHoxY/R25o1Y4fgYQJz0HSLhD1VRmg1ho7lYsIdaPTKbWYfv2s3
         aYeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730740801; x=1731345601;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=crRtd8b59WQuWtElbDnVkfEK1NxnolxocTNX6rz46Js=;
        b=ghHyytKB0JImnERODeyHLWHiz+O87UreIMj7wlnAG4OUR0yU6deoPpM6UN8+JMQhe8
         +rnNqTikfudiuz25Pz/qJ5prT8ep6NNYKoiJcn42S0ysAL8elkjsI2TELxEfyirKkCVe
         z99Fyadg8bgJ1DXNx3plAQmUMEc0lIej2E/2k1zXDP7XHlVOUgermAhXyMuknwCrh9Wi
         8xDlpjnInR8sC6e236958lKqPMk2OlRQpmlu/LTGLJZ+Fr3BLK/izBo8oMErEdM3PUa8
         zuLQpZqjYKHYLPx1ktf7TJn2r++nu0kRxu7GuKv2c1PuxTw4jIAh5uMSMu1ecu08DI1u
         9Qpw==
X-Gm-Message-State: AOJu0Yzalm1xmDXYERuM/EQ8On9GSuLffnvMdZewXJAU82x4npgh4lIC
	2jF5DdojvB6xsIUY9M+T+UR7iZsFe2f8P3c8aMYVtUFPKtWErxch5KtFnx/2jgcr5w==
X-Google-Smtp-Source: AGHT+IFSkkT388fcE7v/5rulgLmUZOERq5TmfaJFwQL7x3fDx47At1N3YFtvZcHYZgGsEkgz0Pp8Eg==
X-Received: by 2002:a05:600c:46cf:b0:431:58bc:ad5e with SMTP id 5b1f17b1804b1-4327b80c8bamr127459115e9.28.1730740801161;
        Mon, 04 Nov 2024 09:20:01 -0800 (PST)
Received: from localhost (fwdproxy-cln-027.fbsv.net. [2a03:2880:31ff:1b::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5e7c8bsm163305925e9.26.2024.11.04.09.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 09:20:00 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v3 0/3] Handle possible NULL trusted raw_tp arguments
Date: Mon,  4 Nov 2024 09:19:56 -0800
Message-ID: <20241104171959.2938862-1-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3773; h=from:subject; bh=HtXQ09vGsm/4nc2VtUtcCO2S9uR+SFBkidYHAGzB19s=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnKQEylgRfdzyEgYKbCHowntyrs9Oaa29zcRISD2bA d47tJtiJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZykBMgAKCRBM4MiGSL8RyiseD/ 9lqdGDvOkkHxbNEMOVNcIBSVysBYDBairLGdTzDWPbRM4BiiF+xDWbW/Ugtfdz+RmKjzF0qaYEwagy +eppvrot+TsfqETymJ3mf9JCxooc83iKWwxDi0+tIxYwmZGt/vROtvsmmplpYUvNmqRWsYAb0qr9v3 /pT4bqueHEH3/vxfNTqkXTquaS7tzQqHaB4EwW7/ToQ/BzSAG+nIz5sZxtc89Yek2VJyGNPYuGRHST d+hlDFDc/LBhWQu53Go0sAEU7E+FL8FrV/ROyoktygfy/hyXXaso8D1R6ygGXPwgK+QpFvRLihJCYd iIBsA9x8R72q2Z5DoA6VZ4d9lmp9VXprIm8EpBGi5BoYqAwkHY4eX1cCQE/U4yN2h3e7IwULFACW/i hS/Uz9MmJRM6Iu1bEb+gZ0dQ7DDsWWzU7lom3v58tJkUWnqOO0LHXixMAXOXTKZOuFkjyVM6ezOFrW s74xsBTbkN5HDvGPoin3WLmEIrQyi+cY7QZ75+2QvPNQZGxjCz8gUkgFmyNoeETnYaHX8YS8nPAvMr +OBbtNahwxlbryWApmngTZYl5e/LmdVMO4n4BQRcdP2LCQwngp+YG/duAxswYyGtHMs+MU+zotEqL+ /dsXSBslRV4M4fPTngfzdu0KKLzI8uSBvvhoq8ednegSYDJToobDZeOjYb1w==
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
v2 -> v3
v2: https://lore.kernel.org/bpf/20241103184144.3765700-1-memxor@gmail.com

 * Fix lenient check around check_ptr_to_btf_access allowing any
   PTR_TO_BTF_ID with PTR_MAYBE_NULL to be deref'd.
 * Add Juri and Jiri's Tested-by, Reviewed-by resp.

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
 kernel/bpf/verifier.c                         | 79 +++++++++++++++++--
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
 .../selftests/bpf/prog_tests/raw_tp_null.c    | 25 ++++++
 .../selftests/bpf/prog_tests/rcu_read_lock.c  |  4 +-
 .../bpf/prog_tests/task_local_storage.c       | 10 +--
 .../bpf/prog_tests/uprobe_multi_test.c        |  2 +-
 .../testing/selftests/bpf/progs/raw_tp_null.c | 32 ++++++++
 .../bpf/progs/test_tp_btf_nullable.c          |  6 +-
 20 files changed, 187 insertions(+), 31 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/raw_tp_null.c
 create mode 100644 tools/testing/selftests/bpf/progs/raw_tp_null.c


base-commit: f2daa5a577e95f4be4e9ffae17b5bbf1ffe7a852
-- 
2.43.5


