Return-Path: <bpf+bounces-75863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AAAC9A932
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 08:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DC6D3A6A31
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 07:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BC3303CB2;
	Tue,  2 Dec 2025 07:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NbOpdHIP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FB9303A3D
	for <bpf@vger.kernel.org>; Tue,  2 Dec 2025 07:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764662100; cv=none; b=DDpzCHW4lhOf/heK+I1Yhvs63Fi8ur1HHZGIeWe1xFGup5kzybzoLFPJc8+JafaLKaHYoG/ElOa1oBa4/Prs/eD65XVnxtpRwCPjv/RHVOjB4kvu9qAwjCJCCIJZRgOyc/AKW6yyRC4r+ATMsTKeIrH9aY4KjQ6MWtOPNaliF1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764662100; c=relaxed/simple;
	bh=kyTtfVPyqo4WaueoH4x+WDK8bxFY3WrcN67Pgl/mPRM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g+HJ2CRUuamkylBesPPyYk8h4hiohW4elZrDcXidw50J9x7ASrh96XW6yFbxKCvy+37uN8chGYq/k11HdEfOeRSr3JgbB+qvbXnbBpMya5qZqrx9mwxpp7lLreuSrrucWSXYLPzkx6RP6PLjXJzNDdeIuBDctt4uqXoh9pgBb9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NbOpdHIP; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-78a835353e4so56005267b3.2
        for <bpf@vger.kernel.org>; Mon, 01 Dec 2025 23:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764662098; x=1765266898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9HL+1MzYvl7+tplIAo6lCWeY0ZFqhV9UOUFQuiT16Mg=;
        b=NbOpdHIPyIVWkk1MQb865Ga0I3083/OWeiKX0wE0wVdwBzAet5UvLc159SDOhrhmxq
         gyf+nKdAN5p2BTj40OLomddqjJ9XuE1yDewTD5SCWsEmxKh65p0lME+yhaG7p/oyPD/D
         uVYJW0OfyST3SOnyXEnbPuUkGbajoawwToCG+nX0encEqAZr3qFj9DRqaUmzxjekvNdj
         A8NlE11nHEXgN2BwtpRDLDei5Pzp6ZlCevfJsWFw1Zki4NTKtuoqFDNrTDHr077SBjEa
         fIWXZhAWVt+3X8rG+mAsNrheQYNcDMjLomDoJiJfyrl0316sYISRlQAEscglsqvY8pZX
         SwZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764662098; x=1765266898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HL+1MzYvl7+tplIAo6lCWeY0ZFqhV9UOUFQuiT16Mg=;
        b=E9fAyPaWncHUWSLdKns8eWkVvA7hJ87l2MJZizI0loDXCmdPsnUzb2H7p3QbJbvx/j
         KhURXHRcPlHFCOtIMobD47bFNf5y0FoSfHmaWNjhACzt1lO7wkcKtwtOg6Qcyrvy//gq
         El9ySs6WQnLAk1g3lnWpD9DROzOtHgRoqkgkMw1zrUzIPx2UGC2K8zNHKjqODYSAfEBt
         kvSL5TcRL0sVEnHO8cW992vDIsRVLxxfnaNDYEIljqI8oFwztRSpyQwGDtmv09NvhR8I
         Wf+8Q9firerH4hzZD5bqYk0eQ3VGB4ZIEqLgKU9sS6G68GIFgfQmvrwlmc8qlCMrgipN
         075Q==
X-Forwarded-Encrypted: i=1; AJvYcCWw6PUyPLuoh2lKZ91bgff9GgSbLxpaE1ib8BI/GDYLOFWrUQlg1VpATMdnvrfBY5JkH2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YybX6nSCEtUrymy4EyrdEH0esJ2pXSX+LfGTEy6ju/69KSp+5EY
	jc4BQP+C8VyapPbnKThURolwrKHg1OVuapfUAC3z2Pqshypq6XWt24Z3
X-Gm-Gg: ASbGnctTq+6KsiD+ltOOeorIvxKTagrklAenAursqrZKUlSRedBSyi1kzQB7ow730sq
	nZ3QD9+gWQU41ObnZZf5XKCJm8n7DjZdcENwBjQXpzR5xfwm2zNin2UfM25+QPJ7mS300WhFyxM
	W9rPf38X23O2rrc82xQnAjexJRLL5z7XONFKyUR01rp7sgAEwh6yl6N6Xo1DVQGGhWqKivNofic
	odrcxlfQNYjKFnakNUi95iwxRfu6JsSVTxad+V9NOAemxhbC+VIgbWPWadlQypxHHq2trq9wjVg
	sSqMfTYBHKDJCqPkdGxTK7pheWLdeCHrwaZe3R7B0LXwob+vphgWnIRnA5LwUqUyTjns+7Jh2EK
	UYEQ0XWevLM8UYZ2YAko4TGtJH5EGcuUrS0fS4mF/ndUgqWK6T7LDqtTiolWiCzja45IZrpPGOd
	BGnRTlpynWkcZUXbKHZJEcqxJq7+fHHlyJNngz+PFk6lukEyKthmQ=
X-Google-Smtp-Source: AGHT+IHYFszBo6ArLl+E3lTGk8xWpJ8CaGWtpce3cqenGwdU5nNL0vqJKRlijuCx3cW1rCiiTx5D2w==
X-Received: by 2002:a05:690e:120c:b0:643:1961:c600 with SMTP id 956f58d0204a3-6431961c686mr29024639d50.2.1764662098134;
        Mon, 01 Dec 2025 23:54:58 -0800 (PST)
Received: from localhost.localdomain (45.62.117.175.16clouds.com. [45.62.117.175])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6433c050d98sm6008225d50.2.2025.12.01.23.54.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 01 Dec 2025 23:54:57 -0800 (PST)
From: Shuran Liu <electronlsr@gmail.com>
To: song@kernel.org,
	mattbobrowski@google.com,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	electronlsr@gmail.com
Subject: [PATCH bpf v2 0/2] bpf: fix bpf_d_path() helper prototype
Date: Tue,  2 Dec 2025 15:54:39 +0800
Message-ID: <20251202075441.1409-1-electronlsr@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

this series fixes a verifier regression for bpf_d_path() introduced by
commit 37cce22dbd51 ("bpf: verifier: Refactor helper access type
tracking") and adds a small selftest to exercise the helper from an
LSM program.

Commit 37cce22dbd51 started distinguishing read vs write accesses
performed by helpers. bpf_d_path()'s buffer argument was left as
ARG_PTR_TO_MEM without MEM_WRITE, so the verifier could incorrectly
assume that the buffer contents are unchanged across the helper call
and base its optimizations on this wrong assumption.

In practice this showed up as a misbehaving LSM BPF program that calls
bpf_d_path() and then does a simple prefix comparison on the returned
path: the program would sometimes take the "mismatch" branch even
though both bytes being compared were actually equal.

Patch 1 fixes bpf_d_path()'s helper prototype by marking the buffer
argument as ARG_PTR_TO_MEM | MEM_WRITE, so that the verifier correctly
models the write to the caller-provided buffer.

Patch 2 adds a regression test that exercises bpf_d_path() from an LSM
program attached to bprm_check_security. The test verifies that pathname
prefix comparisons behave correctly with the fix applied.

Changes in v2:
- Merge the new test into the existing d_path selftest rather than
creating new files.
- Add PID filtering in the LSM program to avoid nondeterministic failures
due to unrelated processes triggering bprm_check_security.
- Synchronize child execution using a pipe to ensure deterministic
updates to the PID.

Thanks,
Shuran Liu

Shuran Liu (2):
  bpf: mark bpf_d_path() buffer as writeable
  selftests/bpf: fix and consolidate d_path LSM regression test

 kernel/trace/bpf_trace.c                      |  2 +-
 .../testing/selftests/bpf/prog_tests/d_path.c | 64 +++++++++++++++++++
 .../testing/selftests/bpf/progs/test_d_path.c | 33 ++++++++++
 3 files changed, 98 insertions(+), 1 deletion(-)

-- 
2.52.0


