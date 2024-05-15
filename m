Return-Path: <bpf+bounces-29740-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0536B8C60C0
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 08:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96FCAB21B7E
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 06:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64DA3C463;
	Wed, 15 May 2024 06:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTnS3oLh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C82B3BB4D;
	Wed, 15 May 2024 06:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715754286; cv=none; b=Po/sQpVfY3yADC0Wp8PdeJkPk0z1mtPG+3BoRJe5GQN53WAmn9MkGpSxEQLF0Y/69DzxI+3akdFvgS88ZaiqwdQYd1ptNj/uLtqOzcJH45lAH8atTESrXR7AYPQx768e09sRjj51whkSPDd8tpvL42jeRFktYdKiAiUsD/2OZAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715754286; c=relaxed/simple;
	bh=kSAMvoZysrAjktwQArGqxt3b28KO02TdAsjB7TS/7+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ARHZryYj4pBelN7ObRJplWgmTkkOAo9VY5WLgi0DN1GVAHLyFlnQgWFRxWl6i0Zwwcttdt2nGDThoKa7cWxcWdVD6KTOYR5jND9JXsRUmWNRDav6U52WiEYCARZnB6f6WBj5vWB5UMzRClx3L02QYk3VCp4JGKT3HDIXLWdpBX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTnS3oLh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9654EC116B1;
	Wed, 15 May 2024 06:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715754285;
	bh=kSAMvoZysrAjktwQArGqxt3b28KO02TdAsjB7TS/7+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BTnS3oLh3479jOjEFj9mPh1ezY3tDDxMHPoNCylWX5YeqN7bEYQhAMMuvf5wd5IxD
	 QG6io/8rHL53XiJHXwsLgddvM1WStuBW+QdmDhFDYbnAMlMi09BdxqmdPjT8xZ34D/
	 4ORilCjbnghTD+oznhct/bf8gSVhNs03aqvNX+vHQBDI8rUm8xDZGrc9SKWcUancXK
	 NywMG5lyf75l1WTmxoym1OtFil5rZtC3XUJbSnDcF9tLDo/Kegh3p3y7v38F+6tkg1
	 JgmyQ/1Wb634Q4YtpiszTR9FMzIhAKykiXgeYRmFSUoG+QT0rbbRtif8Hqcj9mLO/I
	 OCuQfPercvZVQ==
From: Andrii Nakryiko <andrii@kernel.org>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: torvalds@linux-foundation.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/2] selftests/bpf: add more variations of map-in-map situations
Date: Tue, 14 May 2024 23:24:40 -0700
Message-ID: <20240515062440.846086-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240515062440.846086-1-andrii@kernel.org>
References: <20240515062440.846086-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test cases validating usage of PERCPU_ARRAY and PERCPU_HASH maps as
inner maps.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/progs/map_kptr.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/map_kptr.c b/tools/testing/selftests/bpf/progs/map_kptr.c
index da30f0d59364..ab0ce1d01a4a 100644
--- a/tools/testing/selftests/bpf/progs/map_kptr.c
+++ b/tools/testing/selftests/bpf/progs/map_kptr.c
@@ -110,10 +110,14 @@ DEFINE_MAP_OF_MAP(BPF_MAP_TYPE_ARRAY_OF_MAPS, array_map, array_of_array_maps);
 DEFINE_MAP_OF_MAP(BPF_MAP_TYPE_ARRAY_OF_MAPS, hash_map, array_of_hash_maps);
 DEFINE_MAP_OF_MAP(BPF_MAP_TYPE_ARRAY_OF_MAPS, hash_malloc_map, array_of_hash_malloc_maps);
 DEFINE_MAP_OF_MAP(BPF_MAP_TYPE_ARRAY_OF_MAPS, lru_hash_map, array_of_lru_hash_maps);
+DEFINE_MAP_OF_MAP(BPF_MAP_TYPE_ARRAY_OF_MAPS, pcpu_array_map, array_of_pcpu_array_maps);
+DEFINE_MAP_OF_MAP(BPF_MAP_TYPE_ARRAY_OF_MAPS, pcpu_hash_map, array_of_pcpu_hash_maps);
 DEFINE_MAP_OF_MAP(BPF_MAP_TYPE_HASH_OF_MAPS, array_map, hash_of_array_maps);
 DEFINE_MAP_OF_MAP(BPF_MAP_TYPE_HASH_OF_MAPS, hash_map, hash_of_hash_maps);
 DEFINE_MAP_OF_MAP(BPF_MAP_TYPE_HASH_OF_MAPS, hash_malloc_map, hash_of_hash_malloc_maps);
 DEFINE_MAP_OF_MAP(BPF_MAP_TYPE_HASH_OF_MAPS, lru_hash_map, hash_of_lru_hash_maps);
+DEFINE_MAP_OF_MAP(BPF_MAP_TYPE_HASH_OF_MAPS, pcpu_array_map, hash_of_pcpu_array_maps);
+DEFINE_MAP_OF_MAP(BPF_MAP_TYPE_HASH_OF_MAPS, pcpu_hash_map, hash_of_pcpu_hash_maps);
 
 #define WRITE_ONCE(x, val) ((*(volatile typeof(x) *) &(x)) = (val))
 
@@ -204,6 +208,8 @@ int test_map_kptr(struct __sk_buff *ctx)
 	TEST(hash_map);
 	TEST(hash_malloc_map);
 	TEST(lru_hash_map);
+	TEST(pcpu_array_map);
+	TEST(pcpu_hash_map);
 
 #undef TEST
 	return 0;
@@ -281,10 +287,14 @@ int test_map_in_map_kptr(struct __sk_buff *ctx)
 	TEST(array_of_hash_maps);
 	TEST(array_of_hash_malloc_maps);
 	TEST(array_of_lru_hash_maps);
+	TEST(array_of_pcpu_array_maps);
+	TEST(array_of_pcpu_hash_maps);
 	TEST(hash_of_array_maps);
 	TEST(hash_of_hash_maps);
 	TEST(hash_of_hash_malloc_maps);
 	TEST(hash_of_lru_hash_maps);
+	TEST(hash_of_pcpu_array_maps);
+	TEST(hash_of_pcpu_hash_maps);
 
 #undef TEST
 	return 0;
-- 
2.43.0


