Return-Path: <bpf+bounces-76730-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 713DBCC4A46
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 18:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E82413044867
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 17:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B9C32C94B;
	Tue, 16 Dec 2025 17:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J16ObFfY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4A5309DCB
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 17:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765905723; cv=none; b=OFzWGh4QNtRUIpLXmF6NLhHLLffTZrn2noYBA+jrcbX9bp4yOwyuGDXLCQsvf7mrkSBSu6bxdz3aKEXY5qyAPDmX9ApGe4PV3hzrKJrrLpxrqIZIlL1wUD++VwdaZ14HzNTEfz3y9nSk2k3jnG57b0raDN9peY5A9oXmh4vFvCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765905723; c=relaxed/simple;
	bh=eIgY/c8RdDw5i5dZKZXKrVM4WWOFEUU3zrqwERCuVb8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=meBwv9gqxuiF5B62y6Q6CWFCBwMLxSYez6eG+6Xd4UoCPyisl9FfeSXI6JG+IyrQCcdC+Gq/1obdMITxUB7Lnjpt2dtkoKKkRhM68/ZqkshRmxrvCBnI9HDZJRNDo0A2Godzwb5EqNhn7bAzH+sCviVMtjeI6FQ/IDr3nzbiwx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J16ObFfY; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4ee1e18fb37so49559321cf.0
        for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 09:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765905721; x=1766510521; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3xg8naONACF8hcDCihq1qUcqf/P+mMXkkg/WKCFR1K4=;
        b=J16ObFfYKX7UTQYGIcDexkCOh9dkWebTTYFY8/RwcYfk5qf/3n009lA2epF5fewtJC
         vij+dzEqUExOLx+VwXS8xuG1r/Z6cDMeQLSxgQiIqRbTp0hHRk4SS4+U0NjygllrZ1Np
         67ZrmU0V559gc1bgbq+kWVn1cjKpiKNj3UK3Bt0xaCqgglv9OarvAYZT+u0BIHUTtLuM
         rck0OtNIcRhjw5Jqlo/nRAbo/Bz8IfJZcLAmQ4aTiJSeAC/fTIaXNwlVSNwy05/8ZMQ1
         iFbZRYQ7ZZdWBifjSgUArtHFMWwFFLt7cg3/6AETNtgxZs3AQt4xkk2dX4LSl9gCL14L
         HtJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765905721; x=1766510521;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3xg8naONACF8hcDCihq1qUcqf/P+mMXkkg/WKCFR1K4=;
        b=C8J4yF1dTwOARbFeACFarVec/zVXwkVus6GjypIbawSLjROgZNOmpLSFUwurSahbwf
         GEWD1aDl3Y9JFkeLxwQK13Ecl29/tuBPckAUHt8oIcwa+LGSAPw33TZ20yyeSTg6MVXN
         Ir5AET5x4kfmt6lHCPGtOYhj8n6ub8ccgwC9yIUEfLChbhXgbj9qUHxhUvaYM92/yDeI
         1/8Rsb0ikUA/u3gr2pY/zJwso7iEEzAs5b/RfQqPOuQCdPL2xl4h2qx3RAKqFAlcARrA
         O1c605OBMvAoXhfe/mEwnixkxfEEv/KR/Cz/CpxqziAK6fFM1j6askv1dDBEZf3qnqAo
         5zQQ==
X-Gm-Message-State: AOJu0YzvIqYwKxi4qxcppj4/cc7XLZ2tWbt8TKp7ik6WUxfhuCyu3Fju
	lHhSUaH2cmZfOUsOzeRSY3a8BysvbBBXrXiDWdbS9Z6354BGoLFimO0JfJKxBOiLxezMYs6/LxB
	Kwc2ZnpJboSrPHDfXwAXsG9eMW/AK76Q=
X-Gm-Gg: AY/fxX55YC0FqPc8nKRIe/lM7anL5RAtab8h0s7zRIL2vYy+qz5yy4jGwHtSA/nhTrN
	JjEDvH7bwRbWUk0EOQ9w8E5nJnlIgJBPLxycR5yqwwX1MNtMigQZcC0fH6TsUo4dugQgAsZtE+Y
	rlRTXAUYomR8eOAaLERJhE+uycFl94pivO6fuU7jq2bH/Ft4cg//3cYLuA3xBv16mINDnbxEgJq
	ixGtLx0q5pNHPXoZl8GHaPw2WGfSa7VDUx/Z8agrbcOtV10cGbdAQPLEzxfUh+UZg6J7nSVB1Qq
	SiUXuqY=
X-Google-Smtp-Source: AGHT+IE063AL0MNCe7NNfilzsr2xWXIYFSezV65iS8s6du/2o5M63c5bbtHo0kGEyebR3CXUJZQTbVB9BkK6Z22RHFc=
X-Received: by 2002:a05:622a:53ca:b0:4ee:1920:2b1c with SMTP id
 d75a77b69052e-4f1d0471499mr193538831cf.2.1765905720611; Tue, 16 Dec 2025
 09:22:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: cb m <mcb2720838051@gmail.com>
Date: Wed, 17 Dec 2025 01:21:49 +0800
X-Gm-Features: AQt7F2rOZk6dfo8G9OXKhwpUNBND1s7rFG4Iv5EnKe4pnrfpcjFizn9vMKQi40I
Message-ID: <CAO3QcbgU-wbyxgeYL87j6adrQP+-FhHXiXdsgKwvKGMzmzeVPA@mail.gmail.com>
Subject: [RFC] Rust implementation of BPF verifier
To: rust-for-linux@vger.kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	ojeda@kernel.org, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"

Subject: [RFC] Rust implementation of BPF verifier

Dear Rust for Linux and BPF maintainers,

I hope this email finds you well. I am writing to respectfully submit
an RFC for a Rust implementation of the BPF verifier, and I would be
very grateful for your feedback and guidance.

With Rust now officially adopted as a core language in the Linux kernel
following the 2025 Kernel Maintainer Summit, I have been working on a
Rust implementation of the BPF verifier and would like to humbly seek
the community's opinion on whether this direction is worthwhile.


MOTIVATION
==========

The BPF verifier (kernel/bpf/verifier.c) is approximately 30,000 lines
of complex C code. I believe a Rust implementation could potentially
offer the following benefits:

  * Compile-time safety through Rust's ownership model
  * Type-safe state tracking for registers and bounds
  * Reduced attack surface via strict aliasing rules
  * Improved maintainability through pattern matching

I fully understand that these are my assumptions, and I would greatly
appreciate any corrections or different perspectives from the experts
in this community.


CURRENT IMPLEMENTATION STATUS
=============================

I have been working on this project for some time, and the current
status is as follows (~78,000 lines including tests):

Core Features:
  - Full register state tracking (R0-R10)
  - Tnum arithmetic for precise bounds
  - 211 BPF helper function signatures
  - 85+ kfunc definitions (synced with kernel 6.12)
  - State pruning with hash-indexed equivalence
  - Reference tracking (locks, RCU, acquired refs)
  - IRQ flag state tracking

Memory Verification:
  - Stack, packet, context, map, arena
  - Spectre v1/v4 mitigation checks

Technical Characteristics:
  - #![no_std] compatible
  - GPL-2.0-only license
  - Pure Rust implementation (no C glue code, Linux 6.12+ style)
  - 300+ unit tests

Preliminary Benchmark Results:
  - simple_verification:   ~14.6 us
  - medium_verification:   ~28.7 us
  - complex_verification:  ~736 us
  - state_creation:        ~406 ns
  - bounds_operations:     ~5.8 ns

I acknowledge that these benchmarks are preliminary and would welcome
suggestions on more comprehensive testing approaches.


PROPOSED INTEGRATION APPROACH
=============================

Following the patterns established in the kernel, I propose using the
native kernel::Module trait:

    use kernel::prelude::*;

    module! {
        type: RustBpfVerifier,
        name: "rust_bpf_verifier",
        license: "GPL",
    }

    impl kernel::Module for RustBpfVerifier {
        fn init(_module: &'static ThisModule) -> Result<Self> {
            pr_info!("Rust BPF verifier loaded\n");
            Ok(Self { })
        }
    }

Configuration would be:

    CONFIG_BPF_VERIFIER_RUST=y
    echo 1 > /proc/sys/kernel/bpf_rust_verifier


PROPOSED PHASES (Subject to Community Feedback)
===============================================

  Phase 1: RFC and community discussion (current)
  Phase 2: Add necessary kernel crate APIs for BPF
  Phase 3: Validation through selftests, benchmarks, and security audit
  Phase 4: Gradual adoption (initially disabled by default)

I am completely open to adjusting this plan based on the community's
suggestions and requirements.


QUESTIONS FOR THE COMMUNITY
===========================

I would be very grateful if the maintainers and community members could
share their thoughts on the following questions:

1. Is there interest in pursuing a Rust BPF verifier now that Rust has
   been officially adopted in the kernel?

2. If so, what would be the preferred approach:
   a) Eventually replace the C implementation?
   b) Coexist as a selectable alternative?
   c) Focus on specific verification passes only?

3. What kernel crate APIs would need to be added for proper BPF
   integration?

4. What validation criteria and benchmarks would be required for this
   to be considered for inclusion?

I understand that the maintainers are very busy, and I am grateful for
any time you can spare to review this proposal.


REPOSITORY
==========

The code is available at:
  https://github.com/MCB-SMART-BOY/verifier-rs

I welcome any feedback, criticism, or suggestions for improvement.


REFERENCES
==========

  - Rust for Linux Documentation: https://docs.kernel.org/rust/
  - Kernel Crate API: https://rust-for-linux.github.io/docs/kernel/
  - BPF Verifier Source:
https://github.com/torvalds/linux/blob/master/kernel/bpf/verifier.c


Thank you very much for taking the time to read this proposal. I look
forward to hearing from you and learning from your expertise.

With sincere respect,
MCB-SMART-BOY

