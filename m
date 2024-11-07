Return-Path: <bpf+bounces-44303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E12929C1140
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 22:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 993881F24F16
	for <lists+bpf@lfdr.de>; Thu,  7 Nov 2024 21:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3A7218939;
	Thu,  7 Nov 2024 21:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=epfl.ch header.i=@epfl.ch header.b="4GcFrYQw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp0.epfl.ch (smtp0.epfl.ch [128.178.224.218])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E5F2185B0
	for <bpf@vger.kernel.org>; Thu,  7 Nov 2024 21:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.178.224.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731016080; cv=none; b=lXIt8Co5HPBxVnXbWOAKlQ+RZ+l4OAxvQzDzRSgsbLZpbxa9QJHClaspYeZcEjeXPmD1iPPDn9WkDMNBcpkJTltubwulkLMllFihwXQI/ANidEKpD/GM/cNBELGyp/ajxEyxZ/0GvL7s842QnTyDVne1wPo9Ow+DCsruSXf1S/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731016080; c=relaxed/simple;
	bh=r9plYawaNrI6VpRkU6YGwkayLudP/q1oDIkXYwWoGzE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aETqKqF5MNFm8rg9qw0dCAeoHenNyT7sFcXaP7VnjPWx7y6JoU1YVzed7YLnR3nap1VagXEvo545kJx5yDao8MTgX5i2fGBcA5aUFBRjcdqNYLIRiBa1CIHsfdlNgc73L+ObFJeQ7F9gYlPelzmlfc6MQdowGXHU9c3J64UGwkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epfl.ch; spf=pass smtp.mailfrom=epfl.ch; dkim=pass (1024-bit key) header.d=epfl.ch header.i=@epfl.ch header.b=4GcFrYQw; arc=none smtp.client-ip=128.178.224.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=epfl.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=epfl.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epfl.ch;
      s=epfl; t=1731016070;
      h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Content-Type;
      bh=r9plYawaNrI6VpRkU6YGwkayLudP/q1oDIkXYwWoGzE=;
      b=4GcFrYQw0j1B6lCVrbrFVHbdwa8fTvG1MtwxhNRBEvEuf4rASJk7zs+2LZC+atT8h
        W5bGErbVYx+pKlvGF39pgysEWTSr22L5r5H+hTZppmyWKtK5gNCoM9OYblvekPPgu
        tEUyyhy51NFCo5MSJ4ntuCf942epsBRlrG6dlrk1c=
Received: (qmail 24626 invoked by uid 107); 7 Nov 2024 21:47:50 -0000
Received: from ax-snat-224-178.epfl.ch (HELO ewa07.intranet.epfl.ch) (192.168.224.178) (TLS, ECDHE-RSA-AES256-GCM-SHA384 (P-256 curve) cipher)
  by mail.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPS; Thu, 07 Nov 2024 22:47:50 +0100
X-EPFL-Auth: VNs8glDkrlIX4XHkTClhpYSCUj7wn/g1YlyCi8cUx1xLGuj3UKo=
Received: from rs3labsrv2.iccluster.epfl.ch (10.90.46.62) by
 ewa07.intranet.epfl.ch (128.178.224.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Nov 2024 22:47:50 +0100
From: Tao Lyu <tao.lyu@epfl.ch>
To: <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<song@kernel.org>, <yonghong.song@linux.dev>, <haoluo@google.com>,
	<martin.lau@linux.dev>
CC: <bpf@vger.kernel.org>, Tao Lyu <tao.lyu@epfl.ch>
Subject: [PATCH 2/2] selftests/bpf: Add a test for the type checking of iter args
Date: Thu, 7 Nov 2024 22:47:36 +0100
Message-ID: <20241107214736.347630-3-tao.lyu@epfl.ch>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241107214736.347630-1-tao.lyu@epfl.ch>
References: <20241107214736.347630-1-tao.lyu@epfl.ch>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ewa04.intranet.epfl.ch (128.178.224.170) To
 ewa07.intranet.epfl.ch (128.178.224.178)

This is a selftest for the type checking of iter arguments.
When passing a PTR_TO_MAP_VALUE to bpf_iter_num_* kfuncs,
the program should be rejected.

Signed-off-by: Tao Lyu <tao.lyu@epfl.ch>
---
 tools/testing/selftests/bpf/progs/iters.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
index ef70b88bccb2..613037ececb9 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -1486,4 +1486,24 @@ int iter_subprog_check_stacksafe(const void *ctx)
 	return 0;
 }
 
+SEC("raw_tp")
+__failure __msg("arg#0 expected pointer to the iterator")
+int iter_check_arg_type(const void *ctx)
+{
+	struct bpf_iter_num it;
+
+	int *map_val = NULL;
+	int key = 0;
+
+	map_val = bpf_map_lookup_elem(&arr_map, &key);
+	if (!map_val)
+		return 0;
+
+	bpf_iter_num_new(&it, 0, 3);
+	while (bpf_iter_num_next((struct bpf_iter_num *)map_val))
+	bpf_iter_num_destroy(&it);
+
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.34.1


