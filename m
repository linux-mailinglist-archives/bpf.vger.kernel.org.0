Return-Path: <bpf+bounces-60442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C25BBAD66CC
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 06:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CD6B189BD50
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 04:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7E81D63DD;
	Thu, 12 Jun 2025 04:31:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-144-179.mail-mxout.facebook.com (66-220-144-179.mail-mxout.facebook.com [66.220.144.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AC717B506
	for <bpf@vger.kernel.org>; Thu, 12 Jun 2025 04:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749702667; cv=none; b=P5jC3iLdBmCRMDgjByhEBJULMNyYmcfARXiPi255pVlPuI63fCKCqsM5HHdfaz7jrhSmK3CuiZN7UPIvg11CAtWIQwJCM4Cwa5CmvzNrXw1dpa0ahobbyp+x3JfGy/QVlWjdDNlcNRG8fTnd3rGEYje+Z3B5Tik+O+cMYkbtXfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749702667; c=relaxed/simple;
	bh=dS/g++UHsPDkzD5/VgZR4bH33XUxRhNjzC6JU8pj7pA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yft/782ECQEVIc5W5BcBNvZPVQPf3gXhARRNeM7h4CKbv62Fsd5MSubAUm2NNLMuIpskNwsE8h11OfrDjChhrODQiAzb8c4EmZaNnfgj7IEGiimbkZ1ra66wY2b2XBgLn1a6PygdfqHSqQnKXi3uTcLm6SwzQa1OX0ZaVva/2Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 63B56970F276; Wed, 11 Jun 2025 21:30:49 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next] docs/bpf: Default cpu version changed from v1 to v3 in llvm 20
Date: Wed, 11 Jun 2025 21:30:49 -0700
Message-ID: <20250612043049.2411989-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The default cpu version is changed from v1 to v3 in llvm version 20.
See [1] for more detailed reasoning. Update bpf_devel_QA.rst so
developers can find such information easily.

  [1] https://github.com/llvm/llvm-project/pull/107008

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 Documentation/bpf/bpf_devel_QA.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

NOTE:
  Timo Beckers from cilium made suggestion at
  https://github.com/cilium/ebpf/pull/1800#issuecomment-2959458764

diff --git a/Documentation/bpf/bpf_devel_QA.rst b/Documentation/bpf/bpf_d=
evel_QA.rst
index 0acb4c9b8d90..45bc5c5cd793 100644
--- a/Documentation/bpf/bpf_devel_QA.rst
+++ b/Documentation/bpf/bpf_devel_QA.rst
@@ -611,9 +611,10 @@ Q: I have added a new BPF instruction to the kernel,=
 how can I integrate
 it into LLVM?
=20
 A: LLVM has a ``-mcpu`` selector for the BPF back end in order to allow
-the selection of BPF instruction set extensions. By default the
-``generic`` processor target is used, which is the base instruction set
-(v1) of BPF.
+the selection of BPF instruction set extensions. Before llvm version 20,
+the ``generic`` processor target is used, which is the base instruction
+set (v1) of BPF. Since llvm 20, the default processor target has changed
+to instruction set v3.
=20
 LLVM has an option to select ``-mcpu=3Dprobe`` where it will probe the h=
ost
 kernel for supported BPF instruction set extensions and selects the
--=20
2.47.1


