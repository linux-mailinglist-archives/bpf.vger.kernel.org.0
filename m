Return-Path: <bpf+bounces-1034-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C9170CB21
	for <lists+bpf@lfdr.de>; Mon, 22 May 2023 22:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCF3A1C20C22
	for <lists+bpf@lfdr.de>; Mon, 22 May 2023 20:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D91154B0;
	Mon, 22 May 2023 20:34:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20384A21
	for <bpf@vger.kernel.org>; Mon, 22 May 2023 20:34:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A8EC433D2;
	Mon, 22 May 2023 20:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1684787644;
	bh=k0aB+o1daihaSdDKLS6VLR59jpZRIAxsFLSrVS0dxVg=;
	h=From:To:Cc:Subject:Date:From;
	b=nNUGh6B848Qg2olakHNvKLbIpygbHL/4n4FAtRuXBc9b+WyxeSw5LFiNyaZU1X4p/
	 rJAWZFLLZZ0CvvZrAmsFyWbNaAuwNNJjf0SOONItglQgyNRqR0a7YIN7y2V++0vLLp
	 mEstsbuyQAnaxkjQXjTdyHzRFLCCCmIEgDp9oj+kn42+nYdSXA5VEKUSBVpNruyV7H
	 UdVi0sLfLULBWapo0eu79sUlmdfOwKgtxfzgNrKH98X53JT8gLZFO7Mie/EVJVgU5v
	 SZv7KaPiq1/PhJojS200YUAk1ozmggGCQ8nICFt+H/SgLXiXg74ETpgbC8ZsocvDNE
	 nq4aYJX/EOvJw==
From: Jiri Olsa <jolsa@kernel.org>
To: stable@vger.kernel.org
Cc: linux-mm@kvack.org,
	bpf@vger.kernel.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Tsahee Zidenberg <tsahee@annapurnalabs.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Mah=C3=A9=20Tardy?= <mahe.tardy@isovalent.com>,
	linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH stable 5.4 0/8] bpf: Fix bpf_probe_read/bpf_probe_read_str helpers
Date: Mon, 22 May 2023 22:33:44 +0200
Message-Id: <20230522203352.738576-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
we see broken access to user space with bpf_probe_read/bpf_probe_read_str
helpers on arm64 with 5.4 kernel. The problem is that both helpers try to
read user memory by calling probe_kernel_read, which seems to work on x86
but fails on arm64.

There are several fixes after v5.4 to address this issue.

There was an attempt to fix that in past [1], but it deviated far from
upstream changes.

This patchset tries to follow the upstream changes with 2 notable exceptions:

   1) bpf: Add probe_read_{user, kernel} and probe_read_{user, kernel}_str helpers

      - this upsgream patch adds new helpers, which we don't need to do,
        we just need following functions (and related helper's glue):

          bpf_probe_read_kernel_common
          bpf_probe_read_kernel_str_common

        that implement bpf_probe_read* helpers and receive fix in next
        patch below, ommiting any other hunks

   2) bpf: rework the compat kernel probe handling

      - taking only fixes for functions and realted helper's glue that we took
        from patch above, ommiting any other hunks


It's possible to add new helpers and keep the patches closer to upstream,
but I thought trying this way first as RFC without adding any new helpers
into stable kernel, which might possibly end up later with additional fixes.

Also I'm sending this as RFC, because I might be missing some mm related
dependency change, that I'm not aware of.

We tested new kernel with our use case on arm64 and x86.

thanks,
jirka


[1] https://yhbt.net/lore/all/YHGMFzQlHomDtZYG@kroah.com/t/
---
Andrii Nakryiko (1):
      bpf: bpf_probe_read_kernel_str() has to return amount of data read on success

Christoph Hellwig (4):
      maccess: clarify kerneldoc comments
      maccess: rename strncpy_from_unsafe_user to strncpy_from_user_nofault
      maccess: rename strncpy_from_unsafe_strict to strncpy_from_kernel_nofault
      bpf: rework the compat kernel probe handling

Daniel Borkmann (3):
      uaccess: Add strict non-pagefault kernel-space read function
      bpf: Add probe_read_{user, kernel} and probe_read_{user, kernel}_str helpers
      bpf: Restrict bpf_probe_read{, str}() only to archs where they work

 arch/arm/Kconfig            |   1 +
 arch/arm64/Kconfig          |   1 +
 arch/x86/Kconfig            |   1 +
 arch/x86/mm/Makefile        |   2 +-
 arch/x86/mm/maccess.c       |  43 ++++++++++++++++++++++++++++++++++++++
 include/linux/uaccess.h     |   8 +++++--
 init/Kconfig                |   3 +++
 kernel/trace/bpf_trace.c    | 140 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------------------------
 kernel/trace/trace_kprobe.c |   2 +-
 mm/maccess.c                |  63 ++++++++++++++++++++++++++++++++++++++++++++++++-------
 10 files changed, 207 insertions(+), 57 deletions(-)
 create mode 100644 arch/x86/mm/maccess.c

