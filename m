Return-Path: <bpf+bounces-43844-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E539BA7AA
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 20:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10B531C20C04
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 19:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570A41885BB;
	Sun,  3 Nov 2024 19:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJ+1WyUf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34171136E09
	for <bpf@vger.kernel.org>; Sun,  3 Nov 2024 19:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730662521; cv=none; b=WSQ7DIsyujB9aHkhYYNJKuBggRX4iVr7W1LMI9leD1+1Nr7BOsdzLe4t3yDrnSzJaOGbUeF3nS+0baXqxyWsvIOTK84oc0RN05/p+48b5MKUCO+XDiBGGqgrpEsXu5K8kXMIpHlfv9CDPAcZ06mPu0PN5/U8GNRh+sdVQX7Q/iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730662521; c=relaxed/simple;
	bh=KUU/NlZuXad3Xtf97p7hHtSU8v36zakVrcJICT1hrhM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d3wHLz4MD/ZHj1NGNt2MGHHjeJ//0kwb3Jwoa2gBzgWEWmcr6IrOt6UpemkR4UqHnNprJE0epKwcr2jmZhmhWfqJClMOSy1aU4WD8JIma9dk+BWG4VkglW+nvKTfkSY47lJx+jE671m20ktIsBEEJyugOwjwZIVLkQ9rxNZkR48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJ+1WyUf; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-37f52925fc8so2181168f8f.1
        for <bpf@vger.kernel.org>; Sun, 03 Nov 2024 11:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730662517; x=1731267317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SNLcqMk9AdfkvkUEhOpbtW+LRzJ3pGZ4pO2suuVgwF4=;
        b=DJ+1WyUf6/G3lKjfUhnwRXNHUAJjGczx26Wh5bx1tEiOHrtIAFrukNkLEU+MDcBS8z
         fcsZUKcpEa3mQUQFeTF6vZDQKvKTUQs5tqlT400jwtuGCWo3IPE+DfqtPVtdw0gm+gwy
         Aw4QPakXL5MyMwRmEZvnatDzDE6MQUW2Ag4Wx8V7AfZn0p0AXuX2qLO+By+fx/FIOs24
         MrYHS/plCh46PufDSkQJ+qyVz1IBc7rK7OhFsU6j8zniboM0OK0u4/p4D8dy44G3D1Oq
         mayUHYxle5IFx+cAhCiPy6uUuR6mxPQgqtcfVENVMmH0D7rdHQBwqol5rsp83awC4hKd
         8mjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730662517; x=1731267317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SNLcqMk9AdfkvkUEhOpbtW+LRzJ3pGZ4pO2suuVgwF4=;
        b=RzU2MFydBLS2x5ygZRRo/hnhpIlFKZOqSP+jDnnLO27CNKCS111JUdwvosaHXTGDu+
         UNuM1e68AT1ucyIukbRY0p+K+VpWHSCrvC8+xAh4O4rQphn9vFIhn4UTYnRR5NuNZfi/
         zXVxMjV6VArEg8wESEO4ZqWksg+FQc7BYtSyl9CpNqtKsMG456cSkMiXat+D6GpHGmnz
         4bdjbTQNUySjl/hBl6UNwnqL7haaS4zmNNKDucB3CSaANwnybf+TUnMCIYTuGRYnEC5H
         hsW6CxtSVGIs3wjF6/t8pYR4R+z7uXSeQozKx1KlDyfxIBy0Ap9V1Afsat+uFqf5Ng5i
         TQ0w==
X-Gm-Message-State: AOJu0Yyn5WmbsCqUHKAebiYVeQijydTAmV1l4DNZr8zYcUEMnOYGHzRH
	AXOv9f+O26zXbWfJuQhiRRMMl8kjnkZvrRChliLdmsw4LIZniQI4W9c5y+uOnZoRZw==
X-Google-Smtp-Source: AGHT+IGG1fRsgWAhgabWkx8lCjMQtWWTXPxRkZs8TQFIhAe/QLWBne/cOU8EEVrhFua06tU128ijmA==
X-Received: by 2002:a05:6000:4029:b0:37e:d2b7:acd5 with SMTP id ffacd0b85a97d-381c7a476a8mr8197673f8f.8.1730662517045;
        Sun, 03 Nov 2024 11:35:17 -0800 (PST)
Received: from localhost (fwdproxy-cln-035.fbsv.net. [2a03:2880:31ff:23::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d6983f6sm135154575e9.45.2024.11.03.11.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 11:35:16 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Rishabh Iyer <rishabh.iyer@berkeley.edu>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>,
	x86@kernel.org,
	kernel-team@fb.com
Subject: [PATCH bpf-next v3 0/2] Zero overhead PROBE_MEM
Date: Sun,  3 Nov 2024 11:35:10 -0800
Message-ID: <20241103193512.4076710-1-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2708; h=from:subject; bh=KUU/NlZuXad3Xtf97p7hHtSU8v36zakVrcJICT1hrhM=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnJ8wMRJMtxATdCAuPz5SayW0Vfkzs0RRUXdLxWHTz Th4puIeJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZyfMDAAKCRBM4MiGSL8Rynq7EA CSJk7SNkblce8YEvllej4O6JvjwVDY+UNKgRlSrtEUEZucJkLYDq1MNlyLg0zXpLEEm2axhFsnTfH6 ZBL4wuqJ1E7HTi42HkRH+XaVDJylENPKUgPjB2G7/HEgh2YPW6AE0CM/jsa5Ht3TMM/JKxo6kDkK86 xbJjBs4JZH+WJd/RAsQKzudZ4hI+9qWovkQPwjQ7x2K6d4xTZZn4WGqn7bAJxEWFyvdS+CQlZsELKn VSF5heX2FfE8n46GFjGlY2ikkUlcVjmEIkckz9M/tNKc6Q6YAUh1Yoni/6zfYfSNypgJSMRXnqR8Wr onZgWBsyaWvkbDl9PwPjKSymNfpDGYP71C+ZRAsaSd+ZeSwU0LkuRM8gMUBJlOND6X1DEItLZpeEkN HTlWEN3jPK7sjOPN97lBiFRxAuiF/g0dLT/R8QJKo4Vwpiplyi3qMVVcXClOJpGmmEkv0L23RflJV5 niDmkIzgxGDcck/aLkDXmPCgzU+3OfRQCQMwjVw1b4P4MzzEegIcweWvKQC/mu7YXbDVsIMZpx0gUp SexbYpOKc0fzxlb6zIf3E5fAge8PZvRGtk9N9AnO5NcYq4AGGWAuLd7QnIbTQPDJAj5gbe41Gk7AV5 mJuws6UfHu10RJnlNUFyHmJrvfq2USrTIzDzRKIHxwDlT8aUDJ4C7W9DJkEQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

BPF programs that are loaded by privileged users (with CAP_BPF and
CAP_PERFMON) are allowed to be non-confidential. This means that they
can read arbitrary kernel memory, and also communicate kernel pointers
through maps and other channels of communication from BPF programs to
applications running in userspace.

This is a critical use case for applications that implement kernel
tracing, and observability functionality using BPF programs, and
provides users with much needed visibility and context into a running
kernel.

There are two supported methods of such kernel memory "probing", using
bpf_probe_read_kernel (and related) helpers, or using direct load
instructions of untrusted kernel memory (e.g. arguments to tracepoint
programs, through bpf_core_cast casting, etc.).

For direct load instructions on untrusted kernel pointers, the verifier
converts these to PROBE_MEM loads, and the JIT handles these loads by
adding a bounds check and handling exceptions on page faults (when
reading invalid kernel memory).

So far, the implementation of PROBE_MEM (particularly on x86) has relied
on bounds check because it needs to protect the BPF program from reading
user addresses.  Loads for such addresses will lead to a kernel panic
due to panic in do_user_addr_fault, because the page fault on accessing
userspace address in kernel mode will be unhandled.

This patch instead proposes to do exception handling in
do_user_addr_fault when user addresses are accessed by a BPF program,
and when SMAP is enabled on x86. This would obviate the need for the BPF
JIT to emit bounds checking for PROBE_MEM load instructions, and any
invalid memory accesses (either for user addresses or unmapped kernel
addresses) will be handled by the page fault handler.

This set does not grant programs any additional privileges than those
they already had. Instead, it optimizes the common case of doing loads
on valid kernel memory, while shifting the cost to cases where invalid
kernel memory is accessed without sanitization by a program.

Changelog:
----------
v2 -> v3
v2: https://lore.kernel.org/bpf/20240619092216.1780946-1-memxor@gmail.com

 * Rebase on bpf-next
 * Add Puranjay's Acks

v1 -> v2
v1: https://lore.kernel.org/bpf/20240515233932.3733815-1-memxor@gmail.com

 * Rebase on bpf-next

Kumar Kartikeya Dwivedi (2):
  x86: Perform BPF exception fixup in do_user_addr_fault
  bpf, x86: Skip bounds checking for PROBE_MEM with SMAP

 arch/x86/mm/fault.c         | 11 +++++++++++
 arch/x86/net/bpf_jit_comp.c | 11 +++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)


base-commit: 77017b9c46820d72596e50a3986bd0734c1340a9
-- 
2.43.5


