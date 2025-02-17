Return-Path: <bpf+bounces-51770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C09A38BF3
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 20:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFFF418949E6
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 19:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41074236458;
	Mon, 17 Feb 2025 19:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7f6gCAF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CA2236455
	for <bpf@vger.kernel.org>; Mon, 17 Feb 2025 19:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739819212; cv=none; b=b8PXubOja6CaJ9ZXLMmBKGsswdDxFOKqdsiOAfq60eUeusbs2euGnLmIWHbP81wgjjNiVbiVJNBuJu9Dcr8GKo89lQV0W9XQN8uJhUK0AglxnxYaUQ/dz4vRDAx8/5u6NZ3xSV5ZqxYbAPFpmJq4mX2x5zl+JTUniCusP9NqtQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739819212; c=relaxed/simple;
	bh=WbypvJ2dwprxDRB829ZlrhGbOcmYF9V+PJr2D3njo4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U3iUfW+nr+XTwaoM+w9cK/rUDEBrthvwdsAPontKtRCNaPVQPJBtd+ff6D2PuXwm75Ca/sMovfg4qYICfUpPpXdp+jjfKXzScuB0ninv0QPTVoTejRtlRzsXLq0AeoH/ruZJhNBTDqIt2HdEubu/yAiw18G13UY9tnhibMHSJsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7f6gCAF; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21c2f1b610dso117887455ad.0
        for <bpf@vger.kernel.org>; Mon, 17 Feb 2025 11:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739819210; x=1740424010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kMwIcj0wlSKRDNMJHFL4kxgf83/oD5TuuDumxuTDKuw=;
        b=l7f6gCAF3oIv03cLZb+XJDXcXLDAa/560PJ6KR9UvRZSJ1parIwdHHrfDbOEIBQlUX
         tigF6z5TUadE0JCXUpX2jE8oLwAKZcBaYjZLKeOKYvwgns4HFuEEhmSI+Q2oixfFHOH+
         aP0oWD1jeW3mfkdCQJfqAFa86C2Z4OBNXN50RiRPFC0mEtxhTTVddTq+Wj8CNurc6ld/
         M32KWA6cuy6U18wZpqtLBAFfEJZYbvBLNX55YUgCAFs9TNmLKAaHM27FEdl1fUXO2dZL
         mQqn7JL5X+geELpMgD/dlK4C5MrGcsvKEAb2c3ufgHNscHWLDQLCFImfPtjPrf71g06X
         aKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739819210; x=1740424010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kMwIcj0wlSKRDNMJHFL4kxgf83/oD5TuuDumxuTDKuw=;
        b=dlyAdDEAi7mX5wgHVVDRwuuOxGTGfpQvtyTJLeb97LI1VEOxTfOmVlWZ19Mjfg+waP
         uY8weCIUAa9MnhNYgw+SGdRBP2dYDuYv5Hp5uBtpm6tqbVOIzj20iFI4qa42wijy3jRv
         88ZvsIuUNjbr+1kVaVFzgixoUYv43t2ajM/P82pstaBQaD5U9xsr2nfPLwyVBzab0Hxx
         Q3zb5iAUDf5HqMUui69KGvW1lYkCfxKeVlRUpo2pnU5bkeNjOkItDtkT8Cor9uhA1MC4
         VkFXA1mpl1S7enSQyMSXNT/gcUxT9f6VSMbtVihQjao6M5e67VWYTVhYju0vwgXz/jE7
         erTw==
X-Gm-Message-State: AOJu0YzdTIZ1LG/xYp4KSyPktF++KSTTSPg6YaBsW4gypIhDhP5JmdIp
	Iao3L6qr31vM3/nQjmcRdUATDDpKdd4oJxNwYIS93r1Ml0CH02Ic8T1MSg==
X-Gm-Gg: ASbGncuL02bS6wBnbhiNIGgVe0wU0dTRWprKUIckZ/yO1VOiEFK9StaHJnuHA5yNOXW
	nVzSy8Z/8Ep3KFI22fpIdGATjfjpWOIio2ykiFEAz+6YDXUgRN2mKO7fYBbbrdeAoF677ozv2VA
	EeLkmvOAxz+NtBD7uctHuYuopkWwjtMJoKsP4CLEIN4d8xYE3CBe4Kwu+VxXe+tzkL7NRvsZoIa
	AjQH7m03UWE0IhNpLX80cxxVeUMtPr9vFw74HtGGCUWwkNJx0LVrW7xdXZBWI7tifFZUpFwh5cV
	27yJPIxO+KHBvzHauhyJow3TMhKO9aUFPFtQnrXOVDCcGhtKVgD/950fT3qP62Y/0w==
X-Google-Smtp-Source: AGHT+IGy//1bujCFDseLknkBirWbjqFGtPNOKvaknxWdfZYu5szGn8qCT+3r0GMYw6t205Kvvh8KRQ==
X-Received: by 2002:a05:6a21:4cc7:b0:1ee:b8bc:3d2f with SMTP id adf61e73a8af0-1eeb8bdbd8amr5245323637.4.1739819210170;
        Mon, 17 Feb 2025 11:06:50 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73265f98e18sm5039118b3a.106.2025.02.17.11.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 11:06:49 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 0/5] Extend struct_ops support for operators
Date: Mon, 17 Feb 2025 11:06:35 -0800
Message-ID: <20250217190640.1748177-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patchset supports struct_ops operators that acquire kptrs through
arguments and operators that return a kptr. A coming new struct_ops use
case, bpf qdisc [0], has two operators that are not yet supported by
current struct_ops infrastructure. Qdisc_ops::enqueue requires getting
referenced skb kptr from the argument; Qdisc_ops::dequeue needs to return
a referenced skb kptr. This patchset will allow bpf qdisc and other
potential struct_ops implementers to do so.

For struct_ops implementers:

- To get a kptr from an argument, a struct_ops implementer needs to
  annotate the argument name in the stub function with "__ref" suffix.

- The kptr return will automatically work as we now allow operators that
  return a struct pointer.

- The verifier allows returning a null pointer. More control can be
  added later if there is a future struct_ops implementer only expecting
  valid pointers.

For struct_ops users:

- The referenced kptr acquired through the argument needs to be released
  or xchged into maps just like ones acquired via kfuncs.

- To return a referenced kptr in struct_ops,
  1) The type of the pointer must matches the return type
  2) The pointer must comes from the kernel (not locally allocated), and
  3) The pointer must be in its unmodified form


[0] https://lore.kernel.org/bpf/20250210174336.2024258-1-ameryhung@gmail.com/

---
v2
- Replace kcalloc+memcpy with kmemdup_array in
  bpf_prog_ctx_arg_info_init() 
- Remove unnecessary checks when kfree-ing ctx_arg_info
- Remove conditional assignment of ref_obj_id in btf_ctx_access()

v1
- Link: https://lore.kernel.org/bpf/20250214164520.1001211-1-ameryhung@gmail.com/
- Fix missing kfree for ctx_arg_info

Amery Hung (5):
  bpf: Make every prog keep a copy of ctx_arg_info
  bpf: Support getting referenced kptr from struct_ops argument
  selftests/bpf: Test referenced kptr arguments of struct_ops programs
  bpf: Allow struct_ops prog to return referenced kptr
  selftests/bpf: Test returning referenced kptr from struct_ops programs

 include/linux/bpf.h                           | 10 +-
 kernel/bpf/bpf_iter.c                         | 13 ++-
 kernel/bpf/bpf_struct_ops.c                   | 39 ++++++--
 kernel/bpf/btf.c                              |  1 +
 kernel/bpf/syscall.c                          |  1 +
 kernel/bpf/verifier.c                         | 93 +++++++++++++++----
 .../prog_tests/test_struct_ops_kptr_return.c  | 16 ++++
 .../prog_tests/test_struct_ops_refcounted.c   | 12 +++
 .../bpf/progs/struct_ops_kptr_return.c        | 30 ++++++
 ...uct_ops_kptr_return_fail__invalid_scalar.c | 26 ++++++
 .../struct_ops_kptr_return_fail__local_kptr.c | 34 +++++++
 ...uct_ops_kptr_return_fail__nonzero_offset.c | 25 +++++
 .../struct_ops_kptr_return_fail__wrong_type.c | 30 ++++++
 .../bpf/progs/struct_ops_refcounted.c         | 31 +++++++
 ...ruct_ops_refcounted_fail__global_subprog.c | 39 ++++++++
 .../struct_ops_refcounted_fail__ref_leak.c    | 22 +++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 15 +++
 .../selftests/bpf/test_kmods/bpf_testmod.h    |  6 ++
 18 files changed, 410 insertions(+), 33 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_kptr_return.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_refcounted.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__invalid_scalar.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__local_kptr.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__nonzero_offset.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_kptr_return_fail__wrong_type.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_refcounted.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__global_subprog.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_refcounted_fail__ref_leak.c

-- 
2.47.1


