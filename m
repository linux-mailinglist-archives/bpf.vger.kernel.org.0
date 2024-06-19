Return-Path: <bpf+bounces-32508-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0F690E6D5
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 11:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC1EA283FDA
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 09:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C187980035;
	Wed, 19 Jun 2024 09:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmtg4m5Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com [209.85.208.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19D27F7C6
	for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 09:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718788942; cv=none; b=O2LSA160ASZyE/fkROlTyCfSzQim1fS7korRCCaOUNQaPS/ZaC10Kue07oO55IYmRY8UeyC2fMmdsxQwGpblRauAu4s6QmZdnrVatnBpnoeaTvy2Aqq8ywXwXCPIXq0jRieEWOYrA5CBOjh7+RLzkvmX5I7oQUt0UfqZYYHAyOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718788942; c=relaxed/simple;
	bh=5b5FH8U2l7wu1botKWLsLYwKKmC7GX2n46sF2qZIM0c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rU+t+h1pIg+x5zz3X9RE4n6aGKX6G9A0l0rXfZ8dbD0jayFvu3K+UGFgHdI6sCfPlyt7qjxMtuXHSvInLMgcgoHhFs5F12f5qiASIDTThckXQYFsyZ8p3wMnLf7oGdbVNH9CGrV6MXmROkRSakRNM8nRTeGcA1HTCbe8h5R5v2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gmtg4m5Q; arc=none smtp.client-ip=209.85.208.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f196.google.com with SMTP id 38308e7fff4ca-2eaae2a6dc1so112111701fa.0
        for <bpf@vger.kernel.org>; Wed, 19 Jun 2024 02:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718788938; x=1719393738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r40ajEoPJukQtTBgqMR5rUBheayF4Ie9R18wHmjrBM8=;
        b=gmtg4m5Q0gRb8WfZR0MYit3erHNt9IpYYp2JtZ1I4Yu9H76KN4OR7DEBgwVpZxOWsq
         e/RVBk1Skf0HCeu8eEEXKEBwz/zeaT3dahYdAAMM4BiAWA4Phk7sli9oPj1q7EP0+OO+
         UK/Xs75G+zkRttkdJkAKaUdEQQgtxZHbdYDDFeM0yxsvKCPFBlvNQKNhW2EdmLm4a5kt
         OIEonhk2HRDRkwFxVCbP12H0TtUcSKI8q1d+TLVN8eejplXsfi/gEBA7PD111YU2/sMK
         PTT9aN0qBICViHYFl+jU2J34MiXimpZFIFmKpX/xYi2LNmThfOZ8oE0XUUaFsMe6ByfG
         4vAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718788938; x=1719393738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r40ajEoPJukQtTBgqMR5rUBheayF4Ie9R18wHmjrBM8=;
        b=Kw8Z02juTj2ldv+h7eeuq6bDDYaijFltj0AWjOo14FbQK5kCmhprFESeYpBRoMN1Tw
         5yfVXksid2N33VCgNfXfVZBN8qbL0lIt1kMaYF0zn6M0Fyj5HXFGSVIr6LEiwikE+cuL
         SbrDpSs6+cUOXYijnoB4QRO/TWMAlqppZjXAKm0Y2m4t9aqD+BXNYH4EQZUPDNQk1Tko
         vlUJ6104sB+5Xfit1Qnnd4ioc45JrlTlFFeDyN4CWHIYv0KCqjI5UvF9LD0SIvsHPG/M
         HOIbVmDNeafjsUbZEOYrLokiI4uGborSSUOm4bnL5l30/ySb6T3iPie2MarK6KvQGeoD
         Y2qg==
X-Gm-Message-State: AOJu0YweK/h7jmOiouga8uHulQuDNotSha/6AKIzqWsn+qKrQTReIi9F
	BYqW9QIb4/tiJTfD0wKE0Ua1VQeIo5ITXqVP4ja08I7XuG44jsTAhr+/YLtA
X-Google-Smtp-Source: AGHT+IGv70T1WyNxYy0uuk2Gd3ryvBMX10kucxFDjSdqMYiFxHFgu+8FIVngG9auS6Jr3kYQ2OHEHg==
X-Received: by 2002:a2e:7c10:0:b0:2ea:e1fe:2059 with SMTP id 38308e7fff4ca-2ec3ced180emr15887981fa.27.1718788937675;
        Wed, 19 Jun 2024 02:22:17 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f602efdesm222047105e9.17.2024.06.19.02.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 02:22:17 -0700 (PDT)
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
	"H. Peter Anvin" <hpa@zytor.com>,
	Rishabh Iyer <rishabh.iyer@berkeley.edu>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Subject: [PATCH bpf-next v2 0/2] Zero overhead PROBE_MEM
Date: Wed, 19 Jun 2024 09:22:14 +0000
Message-ID: <20240619092216.1780946-1-memxor@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2572; i=memxor@gmail.com; h=from:subject; bh=5b5FH8U2l7wu1botKWLsLYwKKmC7GX2n46sF2qZIM0c=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBmcqMX4152mQMxYEwZ6OkfaX3p448m18s6S4pwe Tcl9mK3LpuJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZnKjFwAKCRBM4MiGSL8R yr/pEAC39kF1CTdc/i6ysDqX7jJ0xvsUhrUq10vDftqRKMdDxs9XS8cJDV9X7Kfnh/ClTP0O2zU Itcwxy7ZYGqDH8r579vX5grJ/01tCjmr6u/8YyYtUYBew/WGc8g8zy4b9kvXmkJN1jwBCPuuJNZ WICXLdeBgiJrwBuduUupNEq3q0vzqs79r3H+ybpzYPXFO8a30WM4I5N3lMTOuiIkEmdaTX6hvBp lrRxJo0gLqQaKAxpB+lB42DN1MweuhyhRcgqrAAO6xzd7FN87K4TxufLZPP3C+wDiarfsMsx1Rf QYp6dh/5kqWiqTFe20PJTYu48Bbv1ivSf14/+8IdMM4RjWO7HD98VZPtlM2ysYkmf0xI0kv0qvZ +SCBT4jPA9LMUj6kPVko0xzaRXS8T19ypDtyFZYMZhtyqMDRzSUlL/ZRNzhoaGi2SMbp0IUJGkW g6Pkd9yFOTbHkOvjRGWGmTcHXD7N3L2IRXvNPN9Hpft6Zqa4ZB52VLEUqDA/XvUXI32YzEfqSpP Lr4ZM2jIDh80kRjfw18Jh21g4LIqTEL/xfc6zzzbbLwzSnk6efGnSzdjsFiPPXXlEx0+hZI+HVZ xF2z/0y1kp1+PZXXhySFh97AZoBoOOuDlimuhW6YPxRBK1gsoAShkX1BDGlzxZo90Uv5LotUJSH Qd2Q8SZQyB7g75A==
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
v1 -> v2
v1: https://lore.kernel.org/bpf/20240515233932.3733815-1-memxor@gmail.com

 * Rebase on bpf-next

Kumar Kartikeya Dwivedi (2):
  x86: Perform BPF exception fixup in do_user_addr_fault
  bpf, x86: Skip bounds checking for PROBE_MEM with SMAP

 arch/x86/mm/fault.c         | 11 +++++++++++
 arch/x86/net/bpf_jit_comp.c | 11 +++++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)


base-commit: f6afdaf72af7583d251bd569ded8d7d1eeb849c2
-- 
2.43.0


