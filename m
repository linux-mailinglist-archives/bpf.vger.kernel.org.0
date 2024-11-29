Return-Path: <bpf+bounces-45845-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B329DBE2E
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 01:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E5C62824F0
	for <lists+bpf@lfdr.de>; Fri, 29 Nov 2024 00:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6464D749C;
	Fri, 29 Nov 2024 00:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3fzdirt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146141361
	for <bpf@vger.kernel.org>; Fri, 29 Nov 2024 00:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732839397; cv=none; b=tSuP1rq/JP3gR2GeSZ1X34Zpt7fm6C0sF5cyGtyEqog6PPMmMpxSUxuh77a88STLqfodXTBEHehMSsVPbAAE0aiQyDp3dvxdPwrW4aY2hqGzWnTb6LLXEU3GAnmmVF7g/SQwalH22DYyxrl47idC93p5PNHH7qVUnUBSRYhSlSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732839397; c=relaxed/simple;
	bh=m964BDMTDB2LJlxQe7VSUP6udh2Pw2m7XQr7sXEvkcY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gqm4BJbb/hiocGEv1vcGGTT3wDme8IB0Auii4jSdlbmZ+FRXtXScvbNqSmlhsXzk//XD08yId+RYNEzaa1mqwJN2qKlg2VnHTmUDudDeVxkQFJXm52yQDJifxrfzLTFl0blKjeqSVRzygAsHPhVR+lwClGEgwxa++9jTPM9vLdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3fzdirt; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-434ab114753so11710405e9.0
        for <bpf@vger.kernel.org>; Thu, 28 Nov 2024 16:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732839394; x=1733444194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5cIJGqda4dTNkF+YVi7SgrEjiZ+zLr8qbyH46r5hRKo=;
        b=E3fzdirtdr4o4fpvsxj919w0EjU8SUh4g6sl397ySUcLvI6EMvFIRYkq1nxvl5+jVA
         usesPQQAVm7xp0I60+OZjZJCcs8PiL3bhuTv5ziIoBy4lA3fw91/nlUVtT2dXtVTB1pc
         8efymzDCqlHYTs1/FLCTHM3UJhAW3iDOALqnrId16rgFq4OidYErA6j0AKbunM6IQOhX
         VqxUyv41VOQ5uDL2VNkzZzRRKUAbB/GoFwrL2Y50t9X52IWuiSTI1fy0cLnYiZsiDOXY
         FejtDgZDdy+TlkkvErLOdUP6oNp/z9xHptVykaa34KRh3AwZ/ZoY282/DoJKmK91YhOC
         wYrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732839394; x=1733444194;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5cIJGqda4dTNkF+YVi7SgrEjiZ+zLr8qbyH46r5hRKo=;
        b=bmIlv97S9ZkjANK68Fi+pAVqvP6iQIFqTlOvo6WyGKUVjkhidgJOYyd8u8oUkrVY18
         JMl3LulCC52y9qgZ55/xRQG028VsvB07GwJ3Exkcy7TpnM1GxNxdlctA6SdIYAAWMkI9
         nYqh57H0QWcMcXrBu8WPRaQmvfIQGr34v4Xm2XIcyHQn8GXTzfqLdU099ey+SVzaGYpN
         dYyk0V00ZrNhj5GDjZLU6XB063miUiaq3Tc1RqNyNMHTv7ozP1OLuZfJXKb/KgwhIqhW
         iBDB8LS7R+WBDBDYR0Bn8YOEDq+cyRE5lKrHr7Y+AssHNve24dvomNZ+Cs0thYBAX+VB
         zYqQ==
X-Gm-Message-State: AOJu0Yz+htcXNx4KB0y+2uGXggB6xxppscTGdoOWvNXmBhqgQXiRJx20
	clUjilAkthQ6kGxgPW5hhDgMsRguJiUrIvIPaRGpE9CO09bKIS/eEMzs4npLMQI=
X-Gm-Gg: ASbGncsjvkko20octsEZwjb8ijemM72Rck0CMzlpIriYmxeXHY/NE8FLuratbxe7yjR
	kZRvxPbQ+ooIeEGdvbrUVLbiy7l4VOBEZJXbaPsnRocfDjWEYsJEMFA6+nxT8aLGJIWfY63Dg79
	sYr/erShabPOcfmGTaf9YOu/K+PFdpHRr95wl3nM+Cv9iFEMR38+IaU3WdYJahxStU8OAxF4ah9
	CxeI4mat+C7fHY43LAd7bXgLOIwMmoMk4mW5mSnhfPqoxtQ5MT8EuBa/AjrJsDFbL676IJ00+KM
	mQ==
X-Google-Smtp-Source: AGHT+IHYVJVXWQWBfpyPBOY9csbkwDf02e5ETdo9dChKlmXCm+INEv0tx0pvWA3TymmHOOMHF5ktvA==
X-Received: by 2002:a05:600c:458d:b0:434:a9a8:ad1d with SMTP id 5b1f17b1804b1-434a9dbc426mr78861915e9.7.1732839393794;
        Thu, 28 Nov 2024 16:16:33 -0800 (PST)
Received: from localhost (fwdproxy-cln-022.fbsv.net. [2a03:2880:31ff:16::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0f7148fsm35615805e9.41.2024.11.28.16.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 16:16:33 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v5 0/7] IRQ save/restore
Date: Thu, 28 Nov 2024 16:16:25 -0800
Message-ID: <20241129001632.3828611-1-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4131; h=from:subject; bh=m964BDMTDB2LJlxQe7VSUP6udh2Pw2m7XQr7sXEvkcY=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnSQfb1JVY9K6eIiKslVWH1lo1KzXIbTOp43tIqoaM X3cdh1GJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0kH2wAKCRBM4MiGSL8RygJaEA C9uNRUHYQ5pig2TSY1fWLy9s2QfVnEhMWd7LrIFnt0EJVs9oxn5DZooRYGUv/2yP74mZS9yiSG96Yh SzFQIbzfQi+lr5yD49ThlXyB/ZeUvhjQC0+MQiAtM4I+AWLfAcu88dpP0XrzAvcwv/CXgIRbUez7PZ OooMFmAGgXGiM28RoDLdTasO1UO0E5ljn5XXzQKh45hTzO7VCkComhIWoGX7RmRGgEl8dMVkxOxgUE xnICqfgVwn0pf9oJTiCJNi8atTb7hLIDIO87T7SPO8WbOa32hsIvvi6enaso+QeY4SJNsVLKVWrqWe dCrNz2oMLxM8t0ok2yU7gRdibP7vWhyeliVkpRPcVfXcBlu0ABwGnSBlNuu+oLmj/onHBc1xuULQMy oN2lwMkeOuPnAch3iSDNhl42lwPJXTTQfG3r3SaqTlZ312ZzC+vNiwnJTOo0CaGrDsYYYfKsatJQQC wLQ7/RMcIdyJNTo9ktjHmV42Ww3LFnvQf8th7l8lmrYFRn+P5bYXBwVqsrtI8swLEP+8z5argURCZy 6C1ezHTIzfgp7cZbYKjmAkttQs0BR0DBdGw7IaQhuukhvm7XAeHv61vwTOwojKE2XknZZg4u3R0dw9 x4vIUHmh7oJNMD5+SjF5Z8sXpCUnuajuxMaCXMhHE4VN0CJYDJlnh9AdWAfA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

This set introduces support for managing IRQ state from BPF programs.
Two new kfuncs, bpf_local_irq_save, and bpf_local_irq_restore are
introduced to enable this functionality.

Intended use cases are writing IRQ safe data structures (e.g. memory
allocator) in BPF programs natively, and use in new spin locking
primitives intended to be introduced in the next few weeks.

The set begins with some refactoring patches before the actual
functionality is introduced. Patch 1 consolidates all resource related
state in bpf_verifier_state, and moves it out from bpf_func_state.

Patch 2 refactor acquire and release functions for reference state to
make them reusable without duplication for other resource types.

After this, patch 3 refactors stack slot liveness marking logic to be
shared between dynptr, and iterators, in preparation for introducing
same logic for irq flag object on stack.

Finally, patch 4 and 7 introduce the new kfuncs and their selftests. For
more details, please inspect the patch commit logs. Patch 5 makes the
error message in case of resource leaks under BPF_EXIT a bit clearer.
Patch 6 expands coverage of existing preempt-disable selftest to cover
sleepable kfuncs.

See individual patches for more details.

Changelog:
----------
v4 -> v5
v4: https://lore.kernel.org/bpf/20241127165846.2001009-1-memxor@gmail.com

 * Do regno - 1 when printing argument
 * Pass verifier state explicitly into print_{insn,verifier}_state (Eduard)
 * Pass frameno instead of bpf_func_state (Eduard)
 * Move bpf_reference_state *refs after parent to fill two holes in
   bpf_verifier_state (Eduard). The hunk fixing that bug is in the
   commit adding IRQ save/restore kfuncs, as it is only needed then.
 * Fix bug in release_reference_state breaking stack property (Eduard)
 * Add selftest for triggering and reproducing bug found by Eduard
   irq_ooo_refs_array in final patch
 * Print insn_idx and active_irq_id on error (Eduard)
 * Add more acks

v3 -> v4
v3: https://lore.kernel.org/bpf/20241127165846.2001009-1-memxor@gmail.com

 * Add yet another missing kfunc declaration to silence s390 CI

v2 -> v3
v2: https://lore.kernel.org/bpf/20241127153306.1484562-1-memxor@gmail.com

 * Drop REF_TYPE_LOCK_MASK
 * Add kfunc declarations to selftest to silence s390 CI errors

v1 -> v2
v1: https://lore.kernel.org/bpf/20241121005329.408873-1-memxor@gmail.com

 * Drop reference -> resource renaming in the verifier (Eduard, Alexei)
 * Change verifier log for check_resource_leak for BPF_EXIT (Eduard)
 * Remove id parameter from acquire_resource_state, read s->id (Eduard)
 * Rename erase to release for reference state (Eduard)
 * Move resource state to bpf_verifier_state (Eduard, Alexei)
 * Drop unnecessary casting to/from u64 in helpers (Eduard)
 * Add test for arg != PTR_TO_STACK (Eduard)
 * Drop now redundant tests (Eduard)
 * Address some other misc nits
 * Add Reviewed-by and Acked-by from Eduard

Kumar Kartikeya Dwivedi (7):
  bpf: Consolidate locks and reference state in verifier state
  bpf: Refactor {acquire,release}_reference_state
  bpf: Refactor mark_{dynptr,iter}_read
  bpf: Introduce support for bpf_local_irq_{save,restore}
  bpf: Improve verifier log for resource leak on exit
  selftests/bpf: Expand coverage of preempt tests to sleepable kfunc
  selftests/bpf: Add IRQ save/restore tests

 include/linux/bpf_verifier.h                  |  27 +-
 kernel/bpf/helpers.c                          |  17 +
 kernel/bpf/log.c                              |  21 +-
 kernel/bpf/verifier.c                         | 573 +++++++++++++-----
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/exceptions_fail.c     |   4 +-
 tools/testing/selftests/bpf/progs/irq.c       | 444 ++++++++++++++
 .../selftests/bpf/progs/preempt_lock.c        |  28 +-
 .../selftests/bpf/progs/verifier_spin_lock.c  |   2 +-
 9 files changed, 950 insertions(+), 168 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/irq.c


base-commit: c8d02b547363880d996f80c38cc8b997c7b90725
-- 
2.43.5


