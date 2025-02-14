Return-Path: <bpf+bounces-51574-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC99EA36362
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 17:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AAB3188587C
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 16:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF1D26772E;
	Fri, 14 Feb 2025 16:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XM/IPhh9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5B02641CB
	for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 16:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739551532; cv=none; b=ofei4gy/xD75AnjL5lJh0ntX7C7OitfrU8POdTjZ7sy2eu2jJPtrQ3NuFdzqibyIVRmGdOi3U03PuJa3AJlKcsULP5RaIBSaezMsyIBK4bc8W7h4d3oFuRr0YDsqPyVQ8js35rRattw3EYi26zE9/M/gcd7ygoS6SM7vfiVOTJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739551532; c=relaxed/simple;
	bh=2GTh7jhY8rotk661pFk4m3G/sXhh1xKfbZ2egdahICY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AtTz937jO81BeDI3c+WJzz38L1Lg64TXWzN75HbZD8uS2NVf729qYUmjbXy+ydcFKkYVvodMtgfsXxLA8+jokNwruGnPM7RUMoyf1aTjmN7KuYmPlPIk8ohaobnly+/BZwEklPqfb2E1SxulQKIQxqpP8enSo07OlEX5iqOrsgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XM/IPhh9; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-220dc3831e3so30524475ad.0
        for <bpf@vger.kernel.org>; Fri, 14 Feb 2025 08:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739551530; x=1740156330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xNQd4NfiwgGrdsgm/6lApi6qvNg/udey62QthYurOjw=;
        b=XM/IPhh9VMpiF8yL9ptWzspq7E/i5JYO/wHk+oZjm9ba1NzHORoRe1QX/QUF8Dh5V1
         K5Ck0TgwtGqNihEqoFust/dvPeD3hhvCzk430nW8ZS+7oVklPnkXoZ5lvtyqeeLoDnpS
         IXLyuuZee2fQrImsWYsbWPUnybhqign7loefm2uKdyfZoo5e6vtXRzQEcbuZiuhWo5ev
         dnp0SKxOBvMXR0hxVYAIYB3UmLZxST0VJKc/XBKhCrQXL63b7e1CHUi17H0sK630EdDD
         qXGiDJWMbIsOOLy4sxkP41fuq90Bdrefx4aA7kMUpgkzDssMuM2UkRKqQ/xlV4a53CWy
         SpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739551530; x=1740156330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xNQd4NfiwgGrdsgm/6lApi6qvNg/udey62QthYurOjw=;
        b=A0M/T5xXhNSvPlmp0QkYJxHnMRMBlHBJTU+VS4wLuUdZQae1nmaINiTZRrSZK1TvoD
         KqhBNkNI+5VWwB6hK8HCB9oKdIoJYw6Fb+X8SvcTpmdtM2vqQwczRzSQxhp+0cm/aLsf
         iTO8C8641IvGBx65MP60dyFqGqhLTuxJoys83Sbf5bQgKThVGAWrKxw9xlzL8MKSbp+L
         WL7DvjI6AqHAqrPd3LZ3au0BkzyWxXiRPyTjdd43N0HVx5SQ7f/YuDJuYHfDmdbQprLC
         X2/Fsc4ikWZ8WST/fS1EVIk84FwHnc92OkYIPtd3pnRBJJAZnjJiIX/7R9T2IXyGQxRO
         9tWw==
X-Gm-Message-State: AOJu0Ywyecu+3KDv/QhAm3daY6DNtRcHeE44KEHMGHzFKAhjpnRNPx4M
	zxgYvafjJjyifZQFZGcln7BaGkPdct2K1KJLdm9SIlcdAZs8OXbHEw6z8g==
X-Gm-Gg: ASbGncv3kTbgOwkELY12Qnvqn3zY/t7Ud8mlP2bovzsk3gyP+7NMOwW3XDwx3eubDuk
	j1ckiRcqYmDVpt7dyfF5ipT6VBITePt2I5Fm+jKT0Fy4mN9KCkkxlsig3lvF1XQA4M9/3fL/Sbx
	Dc0odDYhdHk9iuZZp7lV7TuMvXxB0yCMmXCyytzBojleMvfNoIod0SIILfeDIJ9iBuiPHzFxQH5
	Xip/cnlvtNey3hupP08/gl17Boub7hBI71gFevVtQevIsfdtzIg9O0JR6wAWcJoXfKaWbblwONw
	/C0G2pz/M6P6kSr0OVWgcacQoPgCSL/6FpnEoyLtJlwGk54vE6/B8oMbcpwffPQQpg==
X-Google-Smtp-Source: AGHT+IF6CLMf6QFpHRinKB/NoyieEA86YiriPdynvPeQ8YRuN+2XVPK3RU91gll6oM668fXMvLnkDw==
X-Received: by 2002:a05:6a20:4311:b0:1ee:6aa9:2056 with SMTP id adf61e73a8af0-1ee6c6ad8c4mr11565429637.14.1739551529439;
        Fri, 14 Feb 2025 08:45:29 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adbf21517eesm2223346a12.13.2025.02.14.08.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 08:45:28 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 0/5] Extend struct_ops support for operators
Date: Fri, 14 Feb 2025 08:45:15 -0800
Message-ID: <20250214164520.1001211-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I am splitting the bpf qdisc patchset into smaller landable sets and
this is the first part.

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
v1
- Fix missing kfree for ctx_arg_info


Amery Hung (5):
  bpf: Make every prog keep a copy of ctx_arg_info
  bpf: Support getting referenced kptr from struct_ops argument
  selftests/bpf: Test referenced kptr arguments of struct_ops programs
  bpf: Allow struct_ops prog to return referenced kptr
  selftests/bpf: Test returning referenced kptr from struct_ops programs

 include/linux/bpf.h                           | 10 +-
 kernel/bpf/bpf_iter.c                         | 13 ++-
 kernel/bpf/bpf_struct_ops.c                   | 38 ++++++--
 kernel/bpf/btf.c                              |  1 +
 kernel/bpf/syscall.c                          |  2 +
 kernel/bpf/verifier.c                         | 96 +++++++++++++++----
 .../prog_tests/test_struct_ops_kptr_return.c  | 16 ++++
 .../prog_tests/test_struct_ops_refcounted.c   | 12 +++
 .../bpf/progs/struct_ops_kptr_return.c        | 30 ++++++
 ...uct_ops_kptr_return_fail__invalid_scalar.c | 26 +++++
 .../struct_ops_kptr_return_fail__local_kptr.c | 34 +++++++
 ...uct_ops_kptr_return_fail__nonzero_offset.c | 25 +++++
 .../struct_ops_kptr_return_fail__wrong_type.c | 30 ++++++
 .../bpf/progs/struct_ops_refcounted.c         | 31 ++++++
 ...ruct_ops_refcounted_fail__global_subprog.c | 39 ++++++++
 .../struct_ops_refcounted_fail__ref_leak.c    | 22 +++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    | 15 +++
 .../selftests/bpf/test_kmods/bpf_testmod.h    |  6 ++
 18 files changed, 413 insertions(+), 33 deletions(-)
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


