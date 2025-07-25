Return-Path: <bpf+bounces-64323-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6D7B11774
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 06:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0745DAC8726
	for <lists+bpf@lfdr.de>; Fri, 25 Jul 2025 04:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E41D23BD1F;
	Fri, 25 Jul 2025 04:34:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DC33594E
	for <bpf@vger.kernel.org>; Fri, 25 Jul 2025 04:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753418082; cv=none; b=VZKJ5YVVB6eLSrABdYOMuurUt/WbD4708O6KNzCPSAzDH/z7YMq2PHsWXTFXGMaMRZnlOzQHKW7l4CMtIlW2KJ+2FViIvpUFSkw/QslRcUbScarwI2xuw7noVkTzj0AFTrLlD36eU3c+yK9sEY7iAeFjSQsHE+Gc8ZxIJWuUHpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753418082; c=relaxed/simple;
	bh=Fc7IlW1rFQ40A5rMGVZww28zxatOe/ZpSFHGEtTRd/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sPYh0CpbiZy4hF2GfEIu/hwGA00mAYD0wWVJMcyDQRhDA7JWxvsX6uc3s+wrKfLALdY63h30D5x9RiHH6nCdiLz+7Xb/Xl2vqS8aSSq8CBHyqC38ZXQ7mysLwtwcQ7wIa2ba9UFHq6coSN9+rdu92fIRByVe+zlwrvyDYR38O48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 5A99CC48A4DE; Thu, 24 Jul 2025 21:34:25 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next 0/3] selftests/bpf: Fix a few dynptr test failures with 64K page size
Date: Thu, 24 Jul 2025 21:34:25 -0700
Message-ID: <20250725043425.208128-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There are a few dynptr test failures with arm64 64K page size.
They are fixed in this patch set and please see individual patches
for details.

Yonghong Song (3):
  selftests/bpf: Increase xdp data size for arm64 64K page size
  selftests/bpf: Fix test dynptr/test_dynptr_copy_xdp failure
  selftests/bpf: Fix test dynptr/test_dynptr_memset_xdp_chunks failure

 .../testing/selftests/bpf/prog_tests/dynptr.c  | 10 ++++++++--
 .../selftests/bpf/progs/dynptr_success.c       | 18 +++++++++++++++---
 2 files changed, 23 insertions(+), 5 deletions(-)

--=20
2.47.3


