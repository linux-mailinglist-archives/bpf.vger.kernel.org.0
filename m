Return-Path: <bpf+bounces-28739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C4F98BD86B
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 02:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4F161F23648
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 00:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA14637;
	Tue,  7 May 2024 00:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKHcAPJw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C967D37C
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 00:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715040819; cv=none; b=scCIS3cBLcQ78yj40X3mWBLTSVwT4+y4iyzMjQb96+Yy5d485fdzCRSOlPAYXZvs1mhxsG/ZOSQzfCXoO38uP/W3AMCMlAIuqf+/HpKbZlRK+V48qvj2YpNbypw31zzbW+rgEYPrkMz0EfyErZwbYwUXDVN1AuDBeurLscxwPck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715040819; c=relaxed/simple;
	bh=6m3vaFrRCG7IIjY4aVhrmVvez8cPw8SN/532aOgs5Go=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I1Ibh8ksGHXOa2hXS9yWtqVcSYGY+rvaVw++q0DpCkpEMBMvce4ftX21+5GMWhKvyGcMObC2EHjVApbln+EU3ItaDsgztwdRM3rUWzBY1RsDYnjZo4d4wIzODaw1ucsZ6h2CB33/ikNDDrtaTFXmj6uHzWxx+Gg3SuDOHKVcrGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKHcAPJw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F130C116B1;
	Tue,  7 May 2024 00:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715040819;
	bh=6m3vaFrRCG7IIjY4aVhrmVvez8cPw8SN/532aOgs5Go=;
	h=From:To:Cc:Subject:Date:From;
	b=oKHcAPJwTs+ZCdE8X94dVS13XF/KbfTqQqizRmWGP+pqVHrSYQoclXz0jOaDBRpfd
	 vk6n7jxahq51oAQ+tPcEOJMxr4cViDynpTl6/4rUY935/Yp4tUWfsE6ldL8tes/e0L
	 GSduzoF4hJbhI8n2aFO0SPqvBgMVy0Cc4PCCNU/8SEKTzUzlvYuv5p8BCVcG9vZNQM
	 NEnLQNhZaMA8MkuxK72MuD1ajIB300dsMfCL8PJe9sO4VaSF6ZVXgA7kySEP51CkOk
	 rwTp+Kzplaj5enog/PFCuZ5eIUVXVIQ377N0FneBjb0wzHttEwsGQIg3W19XmnSuYW
	 detft82X9fgmw==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 0/7] libbpf: further struct_ops fixes and improvements
Date: Mon,  6 May 2024 17:13:28 -0700
Message-ID: <20240507001335.1445325-1-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix yet another case of mishandling SEC("struct_ops") programs that were
nulled out programmatically through BPF skeleton by the user.

While at it, add some improvements around detecting and reporting errors,
specifically a common case of declaring SEC("struct_ops") program, but
forgetting to actually make use of it by setting it as a callback
implementation in SEC(".struct_ops") variable (i.e., map) declaration.

A bunch of new selftests are added as well.

Andrii Nakryiko (7):
  libbpf: remove unnecessary struct_ops prog validity check
  libbpf: handle yet another corner case of nulling out struct_ops
    program
  selftests/bpf: add another struct_ops callback use case test
  libbpf: fix libbpf_strerror_r() handling unknown errors
  libbpf: improve early detection of doomed-to-fail BPF program loading
  selftests/bpf: validate struct_ops early failure detection logic
  selftests/bpf: shorten subtest names for struct_ops_module test

 tools/lib/bpf/libbpf.c                        | 38 ++++++---
 tools/lib/bpf/str_error.c                     | 16 +++-
 .../bpf/prog_tests/test_struct_ops_module.c   | 78 ++++++++++++++++++-
 .../bpf/progs/struct_ops_forgotten_cb.c       | 19 +++++
 .../bpf/progs/struct_ops_nulled_out_cb.c      | 22 ++++++
 5 files changed, 156 insertions(+), 17 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_forgotten_cb.c
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_nulled_out_cb.c

-- 
2.43.0


