Return-Path: <bpf+bounces-64474-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B5AB1338E
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 06:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C2BA7A9024
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 04:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747DF21578F;
	Mon, 28 Jul 2025 04:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhTtnYjm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944F345038;
	Mon, 28 Jul 2025 04:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753675982; cv=none; b=A2ICGmJt1HoLikwUfcDqZ25ijyfAkpUzKhmGtKgYX6LQr+Doj6g+vvYo4rgP4hl7UN2n2vMf8yNUeHmjJm/kOco3nZ6belQiCidCuIJJe43q1maCglukaYG8zVErU4crAxUX/LJ4pUf+tiHRKHermidcCw71cvKt8zkxlKpqu98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753675982; c=relaxed/simple;
	bh=P/PichhOLi2hHPK2QFhXjEtN6Z2+SvejzH2jq8CIUao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E1ZoTvTZTcMfMw+XSAP6nGq8OBMvmKYSV3nRgpglFepeLSh3lgEoBPhdVJgAuIvzwfbBus2WLgn+Tp/XRMQlPIdFduCuh8NIgkktUTUnUvonz5MXKU3kXsTCntCjPvS/aGCs3gbsghsdzd1IaLLBkTdEEArm+eFzKzl/UdI5uzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhTtnYjm; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-b34ab678931so3047504a12.0;
        Sun, 27 Jul 2025 21:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753675980; x=1754280780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=49wuBF4kwjRWDzJQK9NYqp+wEnf5GToY6o8GT5CE1sk=;
        b=BhTtnYjmgdciSrzKj3t9dEbTXrv3Koahe5DryPexTWmnvbqmdPsJ8bYs94AnS51qRl
         1r1JrW6KsYs9c0YQpMdVHF3w0wdMpGbPRXHZC3bFHmme3HZLonnP/PlzeI/KMWiktPfQ
         hPxmHGLydd0EH5W0Lwpvw7Wn+I2TNf7hspTrofwK7OwD4AK4dKsa50Yz4Hu6E4dNVd6M
         lVPusKX5pYoD8rGu8c+MeyfuXsMU/QXoHC2XXPgS5TV0iVD1FDZUoK++/Zb+CketcWYA
         Ro8Uq7o6GphtI+ZLUKx1zClaM/eYZz3sYaLwnCWpLWQTroQzX5JVxNRvPivlpOJDQOvc
         448w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753675980; x=1754280780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=49wuBF4kwjRWDzJQK9NYqp+wEnf5GToY6o8GT5CE1sk=;
        b=iG2gITRaA3WuxT265HJadf7eM0hLs7Fix0fI3wzuvcB7lq9fsdF2aoYeIB5tHuf6IK
         dF1NyZ23GWQMwiw/EQcTybFdF0rpmQkEN7677DkxMJx0RvSxeYRsaDCDBGbPAqb4ipZw
         6XlphpcSRK5tDyX4R13EhVFb9JRVJCGBdjrmRO7Ong0LhfUtmBZwciBFEJLhaJ1UBc0s
         JA5/p4aw6wXfScyhnMTueKXSpMR8Y1qVWKYd4edw8q509rzskF/CexywmTWoxV0sCeN/
         C6rsSuBrZyF33DarHzSnSzR/y9qqa8HXcPI/12nkFhEZnO+NYWfCGopwYr/fWBZexLpm
         NV3g==
X-Forwarded-Encrypted: i=1; AJvYcCUvWJDVoZALko8xiwa7ZT4j5IsoTRly4QVgFmNiiILmYhTooO4b0UNLm31Jv6COdXEcbtNsVq3q1Ob2uQzc@vger.kernel.org, AJvYcCWyAIzITjmOOwux0c9i98sQcro5YM88dmxqHXAO3ZfltfkculJieIkDqTlBnvgKIiSZCruhrGLxQlPEWgw9Y7FkcSPX@vger.kernel.org, AJvYcCXvKxP7jlR1LAb3tXohwJKpDEcum1zhpHVNsZYcXO/R9uopu71kfgj0aNaAvlT0rboIaZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyIopCNlKbrHqFT6FIq1U1gGrT/3rHUlnXNe5NBqqSiu8yOVWn
	JS7VENU11JWh0svZTu+xDlHLViX8uZYYCqErkOiF/lt/kwP6JGO5snkA
X-Gm-Gg: ASbGncu+DyBtHMA+CTkfzcj3hQ8F0duMmPqa0woB7JKNwLuafMtRQYrURX8uhwRqTTU
	nSL1EJh2/+KKdc0ou3IyUqzy7q1u37XgSonSOUZ6G71oXwH5g7tBQ4nWjJdfv65FF72dQWAt8T4
	DJS1PFZEQXOETEciakzS8dPh1q5coDm4nEW8xxsy00s1NmwPJh6gImd2ETI/QmwZewLtVYv4CYw
	LruEwXmvsDytWz2y5Perl7siqFej3cv64vJYnWWW51dZ9xImzseYVD9tlLpHbUxY4eXvW5hCW9i
	uFlDNsJnvMpQmx/W3OS70vykDeRI/3Zk5NcZlQtFdm23/I/aoWIk5WIh0MLqkarqgQ0aye6NHd4
	32KHKL6ZxNTa/368DIBwNFNhlffQisA==
X-Google-Smtp-Source: AGHT+IFmntsjJe2mTLVOva2YkqW63Lp/8vbsMQhSFzuszLmldvG94Z2uQnwUps32cHU7XEOlgUAW0g==
X-Received: by 2002:a17:902:c94f:b0:23f:f6e0:b3c7 with SMTP id d9443c01a7336-23ff6e0b6a4mr83657805ad.45.1753675979548;
        Sun, 27 Jul 2025 21:12:59 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24008efc073sm20599175ad.58.2025.07.27.21.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 21:12:59 -0700 (PDT)
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
Subject: [PATCH bpf-next 0/4] fprobe: use rhashtable for fprobe_ip_table
Date: Mon, 28 Jul 2025 12:12:47 +0800
Message-ID: <20250728041252.441040-1-dongml2@chinatelecom.cn>
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

In this series, we use rhashtable for fprobe_ip_table to reduce the
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
  usermode-count :  897.083 ± 5.347M/s 
  kernel-count   :  431.638 ± 1.781M/s 
  syscall-count  :   30.807 ± 0.057M/s 
  fentry         :  134.803 ± 1.045M/s 
  fexit          :   68.763 ± 0.018M/s 
  fmodret        :   71.444 ± 0.052M/s 
  rawtp          :  202.344 ± 0.149M/s 
  tp             :   79.644 ± 0.376M/s 
  kprobe         :   55.480 ± 0.108M/s 
  kprobe-multi   :   57.302 ± 0.119M/s 
  kprobe-multi-all:   57.855 ± 0.144M/s << look this
  kretprobe      :   22.265 ± 0.023M/s 
  kretprobe-multi:   27.740 ± 0.023M/s

The benchmark of "kprobe-multi-all" increase from 6.283M/s to 57.855M/s.

Menglong Dong (4):
  fprobe: use rhashtable
  selftests/bpf: move get_ksyms and get_addrs to trace_helpers.c
  selftests/bpf: add benchmark testing for kprobe-multi-all
  selftests/bpf: skip recursive functions for kprobe_multi

 include/linux/fprobe.h                        |   2 +-
 kernel/trace/fprobe.c                         | 144 ++++++-----
 tools/testing/selftests/bpf/bench.c           |   2 +
 .../selftests/bpf/benchs/bench_trigger.c      |  30 +++
 .../selftests/bpf/benchs/run_bench_trigger.sh |   2 +-
 .../bpf/prog_tests/kprobe_multi_test.c        | 220 +----------------
 tools/testing/selftests/bpf/trace_helpers.c   | 230 ++++++++++++++++++
 tools/testing/selftests/bpf/trace_helpers.h   |   3 +
 8 files changed, 351 insertions(+), 282 deletions(-)

-- 
2.50.1


