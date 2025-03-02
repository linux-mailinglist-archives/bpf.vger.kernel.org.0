Return-Path: <bpf+bounces-52998-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77013A4B4A1
	for <lists+bpf@lfdr.de>; Sun,  2 Mar 2025 21:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 657A97A5FF2
	for <lists+bpf@lfdr.de>; Sun,  2 Mar 2025 20:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3B31EBA19;
	Sun,  2 Mar 2025 20:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvgeLk2N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5DEE8821
	for <bpf@vger.kernel.org>; Sun,  2 Mar 2025 20:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740946437; cv=none; b=EK4hrD6TrHFwWyZu/y3lE+beMcLmmpJqVgf71NAGDChrFm5nyOuDiG5PaIAKGD1vt1dltRUGA4H1TizA4uoGkFKmfZIO3dowWM0AKDvsdWakcV/XIhMONOF35P5TBhGjKqF0dAQOOX2B+rE4q0N+SgdQwRkZzyL0eXCbVSi+3BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740946437; c=relaxed/simple;
	bh=B71gomAIG70VswU6WlK461LllWRM/YTbXteZsJPyQu8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pTUtZaPxRlXzl15vKeHXk+Ic1KCxj3KMtXQ1Efik5A5Po1wDvPK57casJUQSusSX+eAvv/Er43+Cf1X4JuKUE8JhV8AqZAw2khESuvelm9JH/92SbY6qWADTZLveaucWWl+5lqeSYQPVA9r1wmX+MXglLM/v01NUWJpq6tWmI2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvgeLk2N; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4399deda4bfso23449235e9.0
        for <bpf@vger.kernel.org>; Sun, 02 Mar 2025 12:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740946433; x=1741551233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S82bcDg5JRVOiast/lHHQZXogPykxSJdKgD+56jm/RM=;
        b=CvgeLk2N+qTdYVWTkSQg21bpbbn00L06bKYY1cwJEI38PhAD9/MOlb7w6lMvKEsW2L
         Qy2fqtDwOLVxtmm7aEMzZ6K6+b+jMdYU8Www/x3MhKaD6YIQXzwg6EkorGm/kTRu8SXP
         cjYg3n01yx7MwaGj0Em7sogJsGX+TzwyXDNY3cw9OYIhG8HhLMh3aHCznTS66pkGl6zV
         ixKOlWO6ojGj7x4+MWis1t+TSVB9L8YXnfs+nS9RZXJ+KOGEfQ70R9xtpkPQvZbuPSt6
         r0mjRgo3+2BYFd02r+HZqWj4fdYc0MDNrPUxM+7XyrTyF9/4aK+ydwLzMvSau/2YrVJS
         EPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740946433; x=1741551233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S82bcDg5JRVOiast/lHHQZXogPykxSJdKgD+56jm/RM=;
        b=JoPmHfc5fqKyTqwMoT7ZSTDlhUhTvmdlZBxnQbm0x8wcfwHhkkVDw2KEg/3ZZEPu2P
         WicpKllohrBi+VHBgdjo27V1xhQOPIdFHXda3821IoHh0+5esTEtDE2Ou6pdHVGXebug
         4642H0NNvCBbqf5y32J4w/NbfmYKEVioZB4QT0A6NLCfh/aSE4AIyntDxXgROnAP0CHH
         TH/0FwxsaGRNkyU7+22k+AhSTqa1LhEW+VmtGkmodPpydHu5OVT/CkSUYLX9nYkf8eos
         IkmfEQHj1lYR27yeU/aQIx2FBSOQtxB1+txLYDqiGo8E2G4zjhKIn2KnbEODsyqENTbp
         Ph5g==
X-Gm-Message-State: AOJu0YwXURBhVEcio6P32qpU5a7xW4pT8qL0H5u//3yTt3X1YkBQzlXs
	269Xhquh1PmU57Ry/uMRqbNZ5JsAj3DpMsKRJ6S+Gkp1UFggnRoMfAXRzhP6gQs=
X-Gm-Gg: ASbGncsyQB7iSn0d6dW1xWdid94UmnJcTx+ADcwoXqmsV0V/CGlvRhLN74t4OCeNMXr
	/IfSlJRnTrQP8O+x/p287SWJmbJdClhWFjli9dZu3xaj+UbpTHgB0ePkl+Ug+kbl9Mfd7Edt+9p
	TJ/9AERnUlj6YmhcmMgZRhLGa+0gNdGs2LW72XT22SxSkoIk91eXacLyyPhEIVcliFeIseJHOH/
	v/f2Ty99gtj8P4Lfi+diizl1cwbnowJW7XF8Opi9e8ez+cpPjp05bTks6HK3/LroEWHlpscAksq
	4yoChEpUEEaKwhFCEpgaVvhwZ3fCIBHo9Q==
X-Google-Smtp-Source: AGHT+IGxCWimFDH/XXUUCEnD0rtxcoRuy874+cR5lFdE9ChxZWjuzPwQwNMkSeD78GWDR4INaiFDjQ==
X-Received: by 2002:a05:600c:5248:b0:439:a093:fffe with SMTP id 5b1f17b1804b1-43ba66e6de9mr89116995e9.7.1740946433021;
        Sun, 02 Mar 2025 12:13:53 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5871f4sm168439275e9.39.2025.03.02.12.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 12:13:52 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Barret Rhoden <brho@google.com>,
	Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 0/2] Timed may_goto
Date: Sun,  2 Mar 2025 12:13:46 -0800
Message-ID: <20250302201348.940234-1-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2692; h=from:subject; bh=B71gomAIG70VswU6WlK461LllWRM/YTbXteZsJPyQu8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnxLhMchMlRR3/JiKFKeMptjtQxbuCBUZ8j4QGuZgm OTjimkiJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ8S4TAAKCRBM4MiGSL8RysxND/ 9YVlQPVUGaqlCrqUDLgm8ZlyoIwBmp+owG4a+0hDcAl/zZ6ZGnW+db8TgeouACCCsT4KJ+iJKst5HA Tpq73/9Sy//+mqyglkrLDoJS5n4lBA1R2UrcxvqjcT4I/d4f0j+mcOq83Qyxbl29tSI5pWvH+BnsPu BgaY4V5bB1dgbmyZUzAcuLBP+QQpXrYO+24b9opTn9E0oFiXbw3pOUHLuXOlrajFdzatdDUKNXdush EmbXi6H8Y96nv4DzfjOwlItCdlh0SL2wIX0whJV+y/FHJyWlcJI32EB+CZRAJgUfyOqB8ITtmFVt0V 23bhS8LHZ7RaB0Vh9QBdIBPsbzqNyhZX8XqUwwdAUxe+kaD3hGAtYlpGUzT/vDWHKcJ+V63Khb8nWV Ro4LdyPLa+yA/ICC8Tyix49cD5osrveLxV9jpilIfKxPlhV44DK+LyUqA49V+QeB6KAmCEYYXesln1 7pveWrE2jWwgw3BgNyr/xnQAniJTRzWDWQtbFZ1swBmVTLp6Bw+WmNuHl8PNLcPUBDmIBZSyQO6gVe oygSZI95Tl8eYi9SmMmlDO3BN54Axi4SZxMfY+TAYzClbEOydcKH6U2/MxMDTRIuiGjpRXXwsIUaK6 v0VKdLw/AhRSBxpLHO8NkpzbabAShYozJ5XbIjLrsynqUL5uLfY8wDnLoZxg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

This series replaces the current implementation of cond_break, which
uses the may_goto instruction, and counts 8 million iterations per stack
frame, with an implementation based on sampling time locally on the CPU.

This is done to permit a longer time for a given loop per-program
invocation. The accounting is still done per-stack frame, but the count
is used to instead amortize the cost of the logic to sample and check
the time spent since the start.

This is needed for expressing more complicated algorithms (spin locks,
waiting loops, etc.) in BPF programs without false positive expiration
of the loop. For instance, the plan is to make use of this for
implementing spin locks for BPF arena [0].

For the loop as follows:

for (int i = 0;; i++) {}

Testing on a bare-metal Saphire Rapids Intel server yields the following
table (taking an average of 25 runs).

+-----------------------------+--------------+--------------+------------------+
| Loop type		      |	Iterations   |	Time (ms)   |	Time/iter (ns) |
+-----------------------------|--------------+--------------+------------------+
| may_goto		      |	8388608	     |	3	    |	0.36	       |
| timed_may_goto (count=65535)|	589674932    |	250	    |	0.42	       |
| bpf_for		      |	8388608	     |	10	    |	1.19	       |
+-----------------------------+--------------+--------------+------------------+

Here, count is used to amortize the time sampling and checking logic.

Obviously, this is the limit of an empty loop. Given the complexity of
the loop body, the time spent in the loop can be longer. Cancellations
will address the task of imposing an upper bound on program runtime.

For now, the implementation only supports x86.

  [0]: https://lore.kernel.org/bpf/20250118162238.2621311-1-memxor@gmail.com

Kumar Kartikeya Dwivedi (2):
  bpf: Add verifier support for timed may_goto
  bpf, x86: Add x86 JIT support for timed may_goto

 arch/x86/net/Makefile                         |  2 +-
 arch/x86/net/bpf_jit_comp.c                   |  5 ++
 arch/x86/net/bpf_timed_may_goto.S             | 43 ++++++++++++++
 include/linux/bpf.h                           |  1 +
 include/linux/filter.h                        |  8 +++
 kernel/bpf/core.c                             | 31 ++++++++++
 kernel/bpf/verifier.c                         | 52 ++++++++++++++---
 .../bpf/progs/verifier_bpf_fastcall.c         | 58 +++++++++++++++----
 .../selftests/bpf/progs/verifier_may_goto_1.c | 34 ++++++++++-
 9 files changed, 213 insertions(+), 21 deletions(-)
 create mode 100644 arch/x86/net/bpf_timed_may_goto.S


base-commit: 0b9363131daf4227d5ae11ee677acdcfff06e938
-- 
2.43.5


