Return-Path: <bpf+bounces-32228-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D5B909954
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2024 19:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 184D6283336
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2024 17:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA73F26ACD;
	Sat, 15 Jun 2024 17:46:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 69-171-232-180.mail-mxout.facebook.com (69-171-232-180.mail-mxout.facebook.com [69.171.232.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9626CDF49
	for <bpf@vger.kernel.org>; Sat, 15 Jun 2024 17:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718473597; cv=none; b=mEqzxF5DStu8gLeBtN0fpLngXUan3s6aaiz+phypqFrSY+3phnegr2Ru9R6E27YLmOVnmsrTeDiJHmwurQq+XXbzueebnug+1AA9VWgw40l1x6kyhjVCHAuLmDNqWJ1KEhSjAyVvG+wsglmCzyYRL2StzVwWY1aMirNP5IG1S+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718473597; c=relaxed/simple;
	bh=7gD0ecO0bclIAAFiEhpDJBZmgE7izJThXO+92By1Cus=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iGuApwLeU3D/vEicKtDh8uPLDsxU1xsbzAQxJPqTB/tYLa7RikQgoLcvR8jWz2QmomT4sSO/O3Bh6K0YbJKwe910g5APITa5gE9d/nTOgpkt9e3eObDZUU4WFtGBC8e70TgKlrMaLAKRPylDLhBBx9F432URYRwLBfUbkR5bYbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id D708D5802497; Sat, 15 Jun 2024 10:46:21 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf 0/3] bpf: Fix missed var_off related to movsx in verifier
Date: Sat, 15 Jun 2024 10:46:21 -0700
Message-ID: <20240615174621.3994321-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Zac reported a verification issue ([1]) where verification unexpectedly s=
ucceeded.
This is due to missing proper var_off setting in verifier related to
movsx insn. I found another similar issue as well. This patch set fixed
both problems and added three inline asm tests to test these fixes.

  [1] https://lore.kernel.org/bpf/CAADnVQLPU0Shz7dWV4bn2BgtGdxN3uFHPeobGB=
A72tpg5Xoykw@mail.gmail.com/

Yonghong Song (3):
  bpf: Add missed var_off setting in set_sext32_default_val()
  bpf: Add missed var_off setting in coerce_subreg_to_size_sx()
  selftests/bpf: Add a few tests to cover

 kernel/bpf/verifier.c                         |  2 +
 .../selftests/bpf/progs/verifier_movsx.c      | 63 +++++++++++++++++++
 2 files changed, 65 insertions(+)

--=20
2.43.0


