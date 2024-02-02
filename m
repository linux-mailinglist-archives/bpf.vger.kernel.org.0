Return-Path: <bpf+bounces-21078-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFFA847938
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 20:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC6EC287283
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 19:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA7046B4;
	Fri,  2 Feb 2024 19:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+u3QMPz"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7A415E5BF
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 19:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706900731; cv=none; b=MN/qaFdJzswNw9SmcRCSuodpm8/imrnJJauqTHVLXlMLrrPgoFWQ6FeFoOajrAKHdBUzliYwfT8vnJeLQOV4QknHg80MOuetLK5mggHVGVIvuwg9ioEWRqOMR2MaSbKKveQDS9tSMt4IvdcPCEVLzaRxrQUAiZgSD88DsQCSYeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706900731; c=relaxed/simple;
	bh=74stbyCoxTF4Fd3dmFGz3G/KEoiwk2sHvyz7zYYuRQI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bRWWvfuRqlakDnl9dp3Mg7BzppJuzRaw/MgCNjewaqA3NMJ9utN62YfLou3f2q2IM0u6TnucpbsMRPf3rPbpBmtNvP+Afx5ADihY32taSLplLftv7Ck+rO+QDBHOn6PUlhiGhovg0hj7n2W2BJ0LGAJqm9XNUOr0Kl/kR27FTI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+u3QMPz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA48C433C7;
	Fri,  2 Feb 2024 19:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706900731;
	bh=74stbyCoxTF4Fd3dmFGz3G/KEoiwk2sHvyz7zYYuRQI=;
	h=From:To:Cc:Subject:Date:From;
	b=I+u3QMPzf87L3aR18ko6uNolU7B3gE7EJ9G9g4o9N0jg/aUgSWTP2KXfsZycSbhf+
	 Jq7UyhnIFRkFAq7R7DeoER1A3PpBTcT7dL49yE7g1FZhj0K7CwiOyyLOTuYyi6F0qc
	 40hLis5D6RnQD8Wm/s7Lb0X9D8m867qVv+yEPnzAwqmpeXKy+i7cHd/ohtZ+WQ98mr
	 qRPeYq4m+BuOvL08rFnK4UabPr8sR98l+LvqfA2LUXnJsa/upzmNHcJ2CiHPajctw6
	 IITMTKT83fecolR1sE5aCDBa3j83fLdT8sO6mjIoB0IWkG4kGmiasR/owGM7sWatR6
	 NkugXGpk9Z3wg==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 0/3] Two small fixes for global subprog tagging
Date: Fri,  2 Feb 2024 11:05:26 -0800
Message-Id: <20240202190529.2374377-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a bug with passing trusted PTR_TO_BTF_ID_OR_NULL register into global
subprog that expects `__arg_trusted __arg_nullable` arguments, which was
discovered when adopting production BPF application.

Also fix annoying warnings that are irrelevant for static subprogs, which are
just an artifact of using btf_prepare_func_args() for both static and global
subprogs.

Andrii Nakryiko (3):
  bpf: handle trusted PTR_TO_BTF_ID_OR_NULL in argument check logic
  selftests/bpf: add more cases for __arg_trusted __arg_nullable args
  bpf: don't emit warnings intended for global subprogs for static
    subprogs

 kernel/bpf/btf.c                              |  6 ++++
 kernel/bpf/verifier.c                         |  1 +
 .../bpf/progs/verifier_global_ptr_args.c      | 32 +++++++++++++++++--
 3 files changed, 36 insertions(+), 3 deletions(-)

-- 
2.34.1


