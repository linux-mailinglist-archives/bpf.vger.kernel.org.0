Return-Path: <bpf+bounces-42911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 985959ACF11
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 17:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C818B1C2146E
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 15:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05EE1CEE82;
	Wed, 23 Oct 2024 15:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OOlIQD7j"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192DF1C830D;
	Wed, 23 Oct 2024 15:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729697999; cv=none; b=u61BmkoyMmFVLIQx/3zRBSiXNdYY6cDd4S/v45C4mbLu9RUl8fUiHNyiGEPDWnvzd45RgQJu0VRSVRkH1Sb5CHWiK8apl/O217BtJLikZ24gcqUoy43i5anVKCAOHUmXIiWAEIx4OKy4Ya6a7tyRhEdNXTd6LY+S+Kr+kFOJ0T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729697999; c=relaxed/simple;
	bh=iKa9bcxI6W9fsHF/fh/13PtU+WQ5xvNEzWBxiNVZ7eU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S1pZ489+sgdMiE5hCqxsDOTDNDSJd4CM3CZtaakhhle6EUDU0bmpKgBQZmSbMr/6+7rtvQIzMgrMenGKmULCO3hRjDR7av8amyUNJ1kebqqzDhjHmY3FI5tFbsIhRRgEEr1PuPQ2nzVL2x8CK3QrW/ivvwIvoOpK7aeNuIORWME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OOlIQD7j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E74C4CEC6;
	Wed, 23 Oct 2024 15:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729697998;
	bh=iKa9bcxI6W9fsHF/fh/13PtU+WQ5xvNEzWBxiNVZ7eU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=OOlIQD7juHvuvkhsOoG+/kUGScwiJurQiWGsl4I4bILYyLzGx6igrE/Ko+XkW62sZ
	 JkU0TTtOjREB4eintBt4Nv0IL82qybWWFnPX4nYHaTqVH76y58z3hTTiaLFXK2VY5g
	 T+SWopByQfU9fbMR5m+6ZvIFLhOmz2xghWxrVrWt+EtGXSXvDIem7eYstRyxhsgTID
	 hu4JpFrAQBpSerM1QMdMxV+AG+9MwwzBkJA60mPBGfbkjUysBB/LeEiezzTP0U7YUp
	 bMOzvcDSdKhj3HxMxVjtV+odXbBPb+5pKkIooFR2Jzd4efOUP498DNakBTV/TV7+Zc
	 xEjo1cJQ4kcvA==
From: Puranjay Mohan <puranjay@kernel.org>
To: Albert Ou <aou@eecs.berkeley.edu>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Hao Luo <haoluo@google.com>,
	Helge Deller <deller@gmx.de>,
	Jakub Kicinski <kuba@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Mykola Lysenko <mykolal@fb.com>,
	netdev@vger.kernel.org,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Puranjay Mohan <puranjay12@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Song Liu <song@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next v2 3/4] selftests/bpf: don't mask result of bpf_csum_diff() in test_verifier
Date: Wed, 23 Oct 2024 15:39:21 +0000
Message-Id: <20241023153922.86909-4-puranjay@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241023153922.86909-1-puranjay@kernel.org>
References: <20241023153922.86909-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The bpf_csum_diff() helper has been fixed to return a 16-bit value for
all archs, so now we don't need to mask the result.

This commit is basically reverting the below:

commit 6185266c5a85 ("selftests/bpf: Mask bpf_csum_diff() return value
to 16 bits in test_verifier")

Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/testing/selftests/bpf/progs/verifier_array_access.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_array_access.c b/tools/testing/selftests/bpf/progs/verifier_array_access.c
index 95d7ecc12963b..4195aa824ba55 100644
--- a/tools/testing/selftests/bpf/progs/verifier_array_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_array_access.c
@@ -368,8 +368,7 @@ __naked void a_read_only_array_2_1(void)
 	r4 = 0;						\
 	r5 = 0;						\
 	call %[bpf_csum_diff];				\
-l0_%=:	r0 &= 0xffff;					\
-	exit;						\
+l0_%=:	exit;						\
 "	:
 	: __imm(bpf_csum_diff),
 	  __imm(bpf_map_lookup_elem),
-- 
2.40.1


