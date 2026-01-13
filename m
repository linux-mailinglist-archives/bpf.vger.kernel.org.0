Return-Path: <bpf+bounces-78666-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBC0D16C58
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 07:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 146903038321
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 06:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD26D368264;
	Tue, 13 Jan 2026 06:10:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-178.mail-mxout.facebook.com (66-220-155-178.mail-mxout.facebook.com [66.220.155.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8F234B19F
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 06:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768284643; cv=none; b=lvwzvKXhQuVtTT29VmjtU6fWBUAuAZlEx2/c2YeLX1hdCghLTNv2H0Fu7x6IcG+cUvChV0CXVKcZ1grzAPKbMGSeQh3njDaf7/CGlkIpyQ9XOPRSz6h/tDXZEl9BiV7SgJYaODiozfjUECybw9WVF2h8ej28Wt+sq1tlOPwxgnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768284643; c=relaxed/simple;
	bh=+f1M4Ir75wsDilpMg8wDp5PAto8AW/d+E3NSozzK3GY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ht1fOYcaHlVNq+y2JGsDNrHJvKO3Lc0TnhW0C+eP4DaVXz+LO3G0/VdBSpNJ5vS/dHw1XBghzAJtWPuELc+Yjb89+A/CmFk2MLH9jo23TPnQ4BjGQC4VvpsVxLGbaIqE08sJmBR+d76ywTt0W37aZuAnCUbQztSx0dcmqAJ3sms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id BC6D018C4C628; Mon, 12 Jan 2026 22:10:33 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next 3/3] selftests/bpf: Fix verifier_arena_globals1 failure with 64K page
Date: Mon, 12 Jan 2026 22:10:33 -0800
Message-ID: <20260113061033.3798549-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260113061018.3797051-1-yonghong.song@linux.dev>
References: <20260113061018.3797051-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

With 64K page on arm64, verifier_arena_globals1 failed like below:
  ...
  libbpf: map 'arena': failed to create: -E2BIG
  ...
  #509/1   verifier_arena_globals1/check_reserve1:FAIL
  ...

For 64K page, if the number of arena pages is (1UL << 20), the total
memory will exceed 4G and this will cause map creation failure.
Adjusting ARENA_PAGES based on the actual page size fixed the problem.

Cc: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/progs/verifier_arena_globals1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_arena_globals1.c =
b/tools/testing/selftests/bpf/progs/verifier_arena_globals1.c
index 14afef3d6442..83182ddbfb95 100644
--- a/tools/testing/selftests/bpf/progs/verifier_arena_globals1.c
+++ b/tools/testing/selftests/bpf/progs/verifier_arena_globals1.c
@@ -9,7 +9,7 @@
 #include "bpf_arena_common.h"
 #include "bpf_misc.h"
=20
-#define ARENA_PAGES (1UL<< (32 - 12))
+#define ARENA_PAGES (1UL<< (32 - __builtin_ffs(__PAGE_SIZE) + 1))
 #define GLOBAL_PAGES (16)
=20
 struct {
--=20
2.47.3


