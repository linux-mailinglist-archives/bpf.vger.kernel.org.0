Return-Path: <bpf+bounces-69624-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06265B9C420
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 23:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0E761BC36E8
	for <lists+bpf@lfdr.de>; Wed, 24 Sep 2025 21:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002BD287260;
	Wed, 24 Sep 2025 21:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sS5TDL+1"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0320286887
	for <bpf@vger.kernel.org>; Wed, 24 Sep 2025 21:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758748669; cv=none; b=ab8Nv/9Y9U8GB/l67/+4xRDfIuiqHPL6BKL2tw/78JqfMPWe7St29FeMLge0Z+hJ203X/9stpDyju1gEMX/DER8h+vcltsJleNweXvZVHosl9pOW608tzPw7trtaGUxJuduVJRUmUtnENlT7Cuh5QB5pMOl6OSGzweqN5Is5JrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758748669; c=relaxed/simple;
	bh=iZ8qlbnKDdAoz6FK3w34KlTbTE36qQ/esXNHq11T3k8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OH1AOnWE7sUQC/wu2p6ddi1zYAZ7buSa1v/pHaCRb3K2RjwNpDTHFPUEVy93nlOFX4PmScgLk6O6I+TqM9jCnB5Kn5K8JM/SCBMEq+PXCJLClh9rSxT8V7DgkU0YgEvFfBnfZ/AmUC7kjcZDKVhA3Ek9OKnHSyuRxoEyRE7XRbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sS5TDL+1; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758748656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WoXcsSQYcCjyZkdzUaCVBK2YFChR0gldTpoKEAHzsxU=;
	b=sS5TDL+1pxGo0uAWg4PLpetX2fqR2O+v2vRqeD8nzHohwnyDsXuur5H0JuQwVqqxBCgm6I
	JeLqaQrWxiIyRpZC+ohtOn/Shj9klG8XtdMHxVMI6NOqirbCGbk7jexGWURvNFO6p7ivHp
	/YJIF2nGEbo17ci7HhxVwzai9IIdCNk=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: bpf@vger.kernel.org,
	andrii@kernel.org,
	ast@kernel.org
Cc: dwarves@vger.kernel.org,
	alan.maguire@oracle.com,
	acme@kernel.org,
	eddyz87@gmail.com,
	tj@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 0/6] bpf: implicit bpf_prog_aux argument for kfuncs
Date: Wed, 24 Sep 2025 14:17:10 -0700
Message-ID: <20250924211716.1287715-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This series implements KF_IMPLICIT_PROG_AUX_ARG kfunc flag. The flag
indicates that the last argument of a BPF kfunc is a pointer to struct
bpf_prog_aux implicitly set by the verifier.

There is already a mechanism for passing bpf_prog_aux to kfuncs:
__prog kfunc parameter annotation [1]. While it works technically, it
requires explicit declaration of the argument in kfunc prototype in
BPF (for example, in vmlinux.h) and a dummy actual parameter on call
sites. Which then prompts adding macros like the following:

    #define bpf_wq_set_callback(timer, cb, flags) \
	bpf_wq_set_callback_impl(timer, cb, flags, NULL)

This is cumbersome in light of potentially many more kfuncs requiring
access to bpf_prog_aux data [2].

An alternative approach is implemented in this series in combination
with a change in pahole's BTF encoding [3].

When a kfunc needs access to bpf_prog_aux, it's declaration on the
kernel side must have struct bpf_prog_aux pointer as it's *last*
argument, and the kfunc must have KF_IMPLICIT_PROG_AUX_ARG flag set in
its BTF_ID_FLAGS entry.

When generating BTF pahole recognizes KF_IMPLICIT_PROG_AUX_ARG flag
and does not emit the last argument of the kfunc to BTF.

During BPF patching in the verifier KF_IMPLICIT_PROG_AUX_ARG is
checked for to set the actual pointer, exactly as it happens for
__prog annotation currently.

For backwards compatibility __prog annotation handling is preserved in
the verifier. Existing kfuncs that use __prog annotation are updated
to KF_IMPLICIT_PROG_AUX_ARG in this series.

Successful BPF CI run with modified pahole:
https://github.com/kernel-patches/bpf/actions/runs/17987713438

[1] https://docs.kernel.org/bpf/kfuncs.html#prog-annotation
[2] https://lore.kernel.org/bpf/20250920005931.2753828-42-tj@kernel.org/
[3] https://github.com/theihor/dwarves/tree/prog-aux.v1

Ihor Solodrai (6):
  bpf: implement KF_IMPLICIT_PROG_AUX_ARG flag
  bpf,docs: Add documentation for KF_IMPLICIT_PROG_AUX_ARG
  selftests/bpf: update bpf_wq_set_callback macro
  bpf: implement bpf_wq_set_callback kfunc with implicit prog_aux
  bpf: mark bpf_stream_vprink kfunc with KF_IMPLICIT_PROG_AUX_ARG
  bpf: mark bpf_task_work_* kfuncs with KF_IMPLICIT_PROG_AUX_ARG

 Documentation/bpf/kfuncs.rst                  | 39 ++++++++++++-
 include/linux/btf.h                           |  3 +
 kernel/bpf/helpers.c                          | 36 +++++++-----
 kernel/bpf/stream.c                           |  3 +-
 kernel/bpf/verifier.c                         | 58 ++++++++++++++-----
 tools/lib/bpf/bpf_helpers.h                   |  4 +-
 .../testing/selftests/bpf/bpf_experimental.h  |  7 ++-
 .../testing/selftests/bpf/progs/stream_fail.c |  6 +-
 tools/testing/selftests/bpf/progs/task_work.c |  6 +-
 .../selftests/bpf/progs/task_work_fail.c      |  8 +--
 .../selftests/bpf/progs/task_work_stress.c    |  2 +-
 .../testing/selftests/bpf/progs/wq_failures.c |  4 +-
 12 files changed, 130 insertions(+), 46 deletions(-)

-- 
2.51.0


