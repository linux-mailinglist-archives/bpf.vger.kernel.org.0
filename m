Return-Path: <bpf+bounces-29809-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAD28C6F44
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 01:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E12461F2216A
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 23:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F6D4F60D;
	Wed, 15 May 2024 23:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3jDVlKn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f66.google.com (mail-ej1-f66.google.com [209.85.218.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F230101C8
	for <bpf@vger.kernel.org>; Wed, 15 May 2024 23:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715816382; cv=none; b=XtwSHwDKBCAfpOh1+29C+XbUwWqcnb1UQJgkElP9el8OxAsDLF0y7EMWVl6m88cPx10WZu7puPtkzhAK0ssDD2/rQ0aJIAeJxneTCEEWJsC/L/0yPhnkCSBDqX2BZNM8m7/XQOpOtbZ7irmKYQ6GAKmMh0KRXXmb2pP3TLR+J0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715816382; c=relaxed/simple;
	bh=tNoeNuuJm/BJ58Lu/ofLPeE4Xtplhe9OOt8KDJzqv3U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LkU9WfBbz36US+kHhOWSAfoud2M9/hEqJSCG3HWK1x2scK73fkCgz8c8pGA709HYQVHv/9wWqnlqB5/hNv0ozn2eQg/0B5za3Mq19Rn2lHV56/ugRzQLIcDIBl9mbMuoiMo8apv0bouh5xdtz0uo9WiGo+u1VowroU2lsV7uAWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3jDVlKn; arc=none smtp.client-ip=209.85.218.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f66.google.com with SMTP id a640c23a62f3a-a5a89787ea4so228578366b.2
        for <bpf@vger.kernel.org>; Wed, 15 May 2024 16:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715816378; x=1716421178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SsMHUhKjv/mlonH9nIZ/o+CiTgCaIM+URW0J35wV4+U=;
        b=E3jDVlKnpEPTWSP0u57WnFkI+oVXzGQi4YqI3DDwcuzQVAqb8fVFVtSWpAVl1DspiF
         NcOu3EbLHEK4h/oIvehn3b8Hk21d3oNluJFwcmFxaJuMkGu0U9U/qNG2OxqOgZEUw2LD
         C81BEsVCDyLKEALLk3O1izJcou9uVTEQCx+F7/NGOEafVZPg7cXNIH9c0fKe9CQW7hlA
         WtxUY1/uhi8kNetEBacYQJSW1QUmEXBIXaBxTNh1Hy2phiMgeUlm7JzfwXjDHh+r9aHw
         b8vzDb2Qzv662W7/eXpJuUHGHpSeenqPPmUBzN5+h+eHqui53ubCtwem3h2q5Amvn17s
         ug7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715816378; x=1716421178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SsMHUhKjv/mlonH9nIZ/o+CiTgCaIM+URW0J35wV4+U=;
        b=Ih+9/2K62RBdKbjhSsOSambKfZ+qLjH0mbd/zfOWVO8rO3fA8avqdc/Xf7RljC2ela
         3a8G7U158l7Oz3mQgIMRpxFS1m9Dkt3O3YkNS+tLHrlIoiUZ3JFb0axyhEvljhcEPfhM
         01V7WqQ22c1aIhfqn6d/ZUgfb0BMKf01159W669dD74txnEUd8q85/ZnNK+cXMByIhL1
         pQxbYILLK81Z5CVFg5UAZlb1EyGouhEKtC1WHYLdSLX5LW74D+JRVJLt3RF0JqGW5SLH
         5cLKssERnEVQa9zw1N6vM0OWMh8aKQ/L/RHFScQvNcUuqFhYtqoCoeUJ2mwe80u+GydZ
         7lPQ==
X-Gm-Message-State: AOJu0YwSn5qGwIu+PWp+NT6P017nnGJPMhEKg3X+9xQnKalFk4CLb7TN
	jLXo/IX8P1Mq7wM90T9k3ii4CvYvjQRhXqYr78MAeRwFpaba1sNFQMG7/Z/y
X-Google-Smtp-Source: AGHT+IFDW0xxZgJK78G41i3WKpxIH1OBYbGougDhNRVlVYSWRZhohU90sF7Re4+vfwWBEQjkOzBZVg==
X-Received: by 2002:a17:906:a890:b0:a59:a05c:b559 with SMTP id a640c23a62f3a-a5a2d67f88emr1017255366b.70.1715816377937;
        Wed, 15 May 2024 16:39:37 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781d207sm907235766b.22.2024.05.15.16.39.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 16:39:37 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH bpf-next v1 0/2] Zero overhead PROBE_MEM
Date: Wed, 15 May 2024 23:39:30 +0000
Message-ID: <20240515233932.3733815-1-memxor@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2436; i=memxor@gmail.com; h=from:subject; bh=tNoeNuuJm/BJ58Lu/ofLPeE4Xtplhe9OOt8KDJzqv3U=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBmRUUkNTpsuCNMPNfbPwCvXq2HiOL6FhiVqgDNM 27Y2PlwtGOJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZkVFJAAKCRBM4MiGSL8R yvGGD/4peaGAOiry3V5NId/VcqcUHrv4ECKCtyVX+isLAdXm8d+G5j/lkNNHE/bKK4w0n8Y05cb tlXZ9HXZpChNxRN/7zipzeMQLRCFLmeSbEJUnGQqXeZ3E3AGrEua4pifJLrKFBl2mtDLxn/xQ/0 rtjBBvG0isGwVikYme9ASDksOSrfTVMILmpM5+WPwoX1nvArGiLSptZz83qX/q7TBXoTs1s5tke +hxRAL8Kfs8CGB3LLRadQpKb6iaaTHll1pPAkKN1j0tvsry6siXbCs3ySazf0kVsErWuagjhh/o 1dd+zTga+bxqV/NIIcL9sgvV898ORhFk0wiR7Vqsoy6pjrQ6FbhuavqZDow2LWm384rLWrqqSLR nBfKHu1TzmKiPYRBqKVbGb7OJ9Cgw0BUr+WyJ8XEhvzk5OP/e5oNbRrgK3s3j44VAjvATfD9d/6 Z2vSXr8HCvFSPhePi3kJItvDqLuUuNMCmPZXqQJTcI4gCRW9LhvjkXpFxgPAp8RK2N3fSByxxTd Ux/e+m9JQT0QIhhHJUsp98reApjKrg5sqc7RqyMYuBoEoYGV/Mc+G00QzuTCytgWOika8wiPJLz 0DNK9IncWvisFYT8m+LMe0vdgDQaGxXoGeo2oAD2CrDHE5g9rH7iZK+3JFXWlini2Mp++VRAGla lDcB2QefZ7e+oMQ==
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

Kumar Kartikeya Dwivedi (2):
  x86: Perform BPF exception fixup in do_user_addr_fault
  bpf, x86: Skip bounds checking for PROBE_MEM with SMAP

 arch/x86/mm/fault.c         | 11 +++++++++++
 arch/x86/net/bpf_jit_comp.c | 11 +++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)


base-commit: 5c1672705a1a2389f5ad78e0fea6f08ed32d6f18
-- 
2.43.0


