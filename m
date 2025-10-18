Return-Path: <bpf+bounces-71277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE275BED132
	for <lists+bpf@lfdr.de>; Sat, 18 Oct 2025 16:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 079DE34DE62
	for <lists+bpf@lfdr.de>; Sat, 18 Oct 2025 14:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D25D2580FF;
	Sat, 18 Oct 2025 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U33tU0ss"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E771A9F91
	for <bpf@vger.kernel.org>; Sat, 18 Oct 2025 14:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760797298; cv=none; b=X/GS/bjpTk/SJL19ZsjD7S9HwHkxMGwR3MZuJHaNsC2Y8h/I+lbGd+srXw2mIFr8rWAygbCwswDn/e5PU6GUunnQGayFqfftsEr3InwOCZr/nl38e9J9YNM6Wqyc5LfLJKzX1USdoVrc3S1jhh7kO57nftrTz6S4VfwZJQfBzLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760797298; c=relaxed/simple;
	bh=UFACQNUcFGNUr3LbQlJ73ptXjK7M7y+BaajbPTYSAJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZL7n1cj1QVoYViNAJssfZ/l4cu7hdkmKtJXlRNu7YO9i9xYs2uiSGtykP0WP8amsBVI9iMbz64568PgzaO7oL4MeslGoJ6NoebHU2fWiI3Q5W7JoQmWybodp6IIEY4NovVbyazbXAJuZPddH5IyfitiDNRggmTKeyeq6Pb4CI3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U33tU0ss; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-793021f348fso2686910b3a.1
        for <bpf@vger.kernel.org>; Sat, 18 Oct 2025 07:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760797297; x=1761402097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wdkh50aQpwH1ME0yDbaQNHLQF1BCMimilG3lPugeXHw=;
        b=U33tU0ssJpu6X3LCm9p+k1g4w+oJNg1Upb/ixdRFZIBm4yRi3sgo3Nu60N0dePr2eT
         7JpSHXZ2kNeEDvRgsnL8+arbGuUBBQLtUvqcTxRGt78kJpGVXbTiE9m5vTKP5ZOlrumE
         rLC1d8B7d0lfy2Hs0JXV85aV8BqBNgwoHfUk64qxPRTMvGtn1zE01OynS8Ie/rhHGjIJ
         cLSTUAbqJK8gPuGE+MrIHhAiNq+oulUbddLifPqhX/BQnDcw7s2jlkIcGaCe/eC76uXm
         faD8LkBQn03tq/PebNzbvZdHg0wL2Es+1ItlCBDy9HSW+rStQJ5KL3GQwCE0ru50V4qM
         hbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760797297; x=1761402097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wdkh50aQpwH1ME0yDbaQNHLQF1BCMimilG3lPugeXHw=;
        b=ePxWLU2qFsKgEfhEt75xOgurhlh0RBD1OaJPfroA8RctQfLPRNfYS6HONZ/hbLn8ye
         PNXFiLDSIePhkawsBsgSsxmL0FN64WY2g+PhlN01ZsF36EpU/LxGXIGRCW4MEY99R8Jk
         fLn8i0to44Jh5ySrfezeyqp6iVuypLw4ve/Eh7SCzICgoUQozX2xP7Pl0tRnYXFVegUK
         KGSIM1kC7SRoSuVDEa7DOD6vqgt7RgVdOkidRZbLQV4NfWRpnSet2DwTIKO4QJc5FqnH
         e9qFwGdiN7pd9mIfXNykfCE3lZnPZQUugxn1QNUzQL7K5bEFzA3sqOqhPu68/7MMTYQI
         esHg==
X-Forwarded-Encrypted: i=1; AJvYcCUVL8jyzRZ9edFVtnJa9lJHd8zqn2oGX/+EiGFBuyP0wl8k1cdSSEbiWHeZvbW58ez3Tjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFcisYdb93WtWOGHoPVGgCkViuKO/pWE4jb9PI7TYCASJsAdPr
	hkE32pAhJMBs6rAWIVWLQpm5oYyTWnm7eXa18xvWIbTn0hTFrAAWpHhu
X-Gm-Gg: ASbGncsTDFTh6MatZ91x2qYdYYUV4OHmIJRZMN2KZpeGJvN+iqhsjlEt0Tkahyu3BCb
	hU9EiiFSK2GagGbgdkDmAl7Q9Jh0SFZjG4uB6yHGfMTAgx65uLm7ROtLtQX0f5uEuUWKdZF2NAB
	EPdjOMKZGHw4M//qh/2nCF4Xmz89ArTOU7K8AXI28mWXsOZIb4KbaYeni2HHg6jMqOXRcaobGpb
	jCQVo7sGmZRLUowqHXNBZZliHsQyPxWpImDSdnXFXHdExOWFJCMvW5MdB2kKrzk2nzuof9Ivhb5
	2pp38pK4/OPh/mOcC33/PXPxJt9SKcgraQfyylyH+62eSb+NX/K+UfBg30tGjvPg6rlRD0CCC9E
	xcRZufgj7S0rRbxzi06NPitlRxNFAwZ1n/V3sXDo9X3NPpuvVkRJr5McmwA5YgfG5IMBV3aDNXp
	0Y
X-Google-Smtp-Source: AGHT+IFwjUau4e7L7ur+mPitSfhfWL2QhmxUZ49vo3pktk9QgW3ghR615Qec4S+Rounyw7PCrdwbOA==
X-Received: by 2002:a05:6a21:6da1:b0:324:b245:bb8e with SMTP id adf61e73a8af0-334a856e811mr11163187637.26.1760797296653;
        Sat, 18 Oct 2025 07:21:36 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23010d818sm2913589b3a.53.2025.10.18.07.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 07:21:36 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	jolsa@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	leon.hwang@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH RFC bpf-next 0/5] bpf: tracing session supporting
Date: Sat, 18 Oct 2025 22:21:19 +0800
Message-ID: <20251018142124.783206-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes, we need to hook both the entry and exit of a function with
TRACING. Therefore, we need define a FENTRY and a FEXIT for the target
function, which is not convenient.

Therefore, we add a tracing session support for TRACING. Generally
speaking, it's similar to kprobe session, which can hook both the entry
and exit of a function with a single BPF program. Meanwhile, it can also
control the execution of the fexit with the return value of the fentry.
session cookie is not supported yet, and I'm not sure if it's necessary.

For now, only x86_64 is supported. Other architectures will be supported
later.

Menglong Dong (5):
  bpf: add tracing session support
  bpf: add kfunc bpf_tracing_is_exit for TRACE_SESSION
  bpf,x86: add tracing session supporting for x86_64
  libbpf: add support for tracing session
  selftests/bpf: add testcases for tracing session

 arch/arm64/net/bpf_jit_comp.c                 |   3 +
 arch/loongarch/net/bpf_jit.c                  |   3 +
 arch/powerpc/net/bpf_jit_comp.c               |   3 +
 arch/riscv/net/bpf_jit_comp64.c               |   3 +
 arch/s390/net/bpf_jit_comp.c                  |   3 +
 arch/x86/net/bpf_jit_comp.c                   | 115 ++++++++++-
 include/linux/bpf.h                           |   1 +
 include/uapi/linux/bpf.h                      |   1 +
 kernel/bpf/btf.c                              |   2 +
 kernel/bpf/syscall.c                          |   2 +
 kernel/bpf/trampoline.c                       |   5 +-
 kernel/bpf/verifier.c                         |  17 +-
 kernel/trace/bpf_trace.c                      |  43 ++++-
 net/bpf/test_run.c                            |   1 +
 net/core/bpf_sk_storage.c                     |   1 +
 tools/bpf/bpftool/common.c                    |   1 +
 tools/include/uapi/linux/bpf.h                |   1 +
 tools/lib/bpf/bpf.c                           |   2 +
 tools/lib/bpf/libbpf.c                        |   3 +
 .../selftests/bpf/prog_tests/fsession_test.c  | 132 +++++++++++++
 .../selftests/bpf/progs/fsession_test.c       | 178 ++++++++++++++++++
 21 files changed, 511 insertions(+), 9 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fsession_test.c
 create mode 100644 tools/testing/selftests/bpf/progs/fsession_test.c

-- 
2.51.0


