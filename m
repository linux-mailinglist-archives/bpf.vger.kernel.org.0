Return-Path: <bpf+bounces-50929-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D456A2E546
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 08:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 045C71620BD
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 07:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC2B1B87F8;
	Mon, 10 Feb 2025 07:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="UsbmSFtZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8E61B425A
	for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 07:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739172167; cv=none; b=i5cAkQvCh01DJAY1s0F9Lu1q6zyYaCjmG+Xfof8uyMA5a5eBguRlzcogh3VDL+R6S8RZydvRg2WX5U55RiF//82E+a1Ih4dX2gSP8/TOQQCT67rtY4sp36lhl4e80IQKsk5J9KXgI4CGoWNgMjyt6at/lJ+ScdZFF6zurxIgI+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739172167; c=relaxed/simple;
	bh=FkkhpQQNgHTRR+bAMkblL7lnICrRS0qX2m5AHBb6fjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iyljxTd/sXRWVRloTAWJKsXiFqEk39mX1yaCNTtal2J0LLh1cS851+Hc6mGscQEDjHBgAfQDD8ok1+YXuWsRiytb+2Pz57GfvbZN5Z4bvxeRqFRvqahsnGi7ZJ3i9I3RoATRaZsrJBqFBWv08lIwN56tFju+PjBRUBFaM4f/kbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=UsbmSFtZ; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c05cda3e3fso84133385a.1
        for <bpf@vger.kernel.org>; Sun, 09 Feb 2025 23:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1739172163; x=1739776963; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QRiPaDvLh0TgDzkJqtvQgteH0/7MhRxsaWow4OwTnOY=;
        b=UsbmSFtZiyHDRmcJQbLFFRx0l382lg8CNVeGD8r0CYoBkNaMvsXrBEJudDCf49AuAb
         7RM98CdkkVCBEWo7dTmbXb3luxZNYNlGrzPUlUL6VeVLp41afDzfDOXFZMSnbfPoLEfZ
         4z5xze0z42740tszzL/CAQU+UNGjpzp7t2ZGU9hPd9RwwfGoJN0qdBPbTSfohBgZQCoW
         6YsRqHidFbzC1rugTV75nnkvLDjJrPPjyICAzNcG8P92fTPEMO9G4cpDPDKS6Tjg7UWp
         FB1oRog8kJjnPsCbqSeqNtui5D5aeIVw2eyV3FVX6uEx3qE4T+UvsbearpsfizxLpXfB
         4ukw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739172163; x=1739776963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QRiPaDvLh0TgDzkJqtvQgteH0/7MhRxsaWow4OwTnOY=;
        b=fBLUjAwFCei+VIZZoDSU053uMID6QAnaaHHx2BeYvOjBnG0pba/yaVsMaxt3EZDYN4
         ZJwwRt14P3xqygNiuvwaywkxQGm7WhALejGjmyIa0olo58L2jdpMZRpy+D+u2Y+e5O9z
         WehKY8KYpl3iE/mAyrrT1h8eAHknVkq3ySRY7NpkN9YcQR2GUj9H/2G58kD+hkHV8PCK
         kSqrRlff/rEcy7DIA7o6LcbzaA5eMa6VV44D9U0N1pyQI+FLMl1QVCEgcEu7tGnkxPg/
         AOvaygSp1pV20tkwPas+9lmo4gDrCmYmkLaoYRes+SdJEEEZ+bWpFUAMoNB9Kd9Em/PF
         efwA==
X-Gm-Message-State: AOJu0Yz38etfQrI8xAxWZzMwC9G3xJizzG4dpbkYzXPB8dBSDDWjq5fB
	gTXHy9BRd7Ca00C5OAOB0oJsuyyM1ov2ohO72POxkF2K8tzorALesUla2yvKO1sXicTCPjASeCO
	c
X-Gm-Gg: ASbGncs6Y/QBa0D5j8B/7Lkafy1BM4bwLz6mhHOl1hsLFJE0gKzc2Hn6Wxb7fcZZcu0
	UkQ1p7ef09wobS1m00XcixkEFCWTFhBiSGxtMfskUBBqlxyTAI2rlC981I7BqTSrnwTLl1FrQfD
	SzMmRbxdQf0XFkOFiXX7yZdNkaqFeC0fppllKGC4N+zuZBTF9xm+qkHcRzKuCDlFqgo1QsxVdNg
	5z8NQlVz06/JUZlF/kd9Hm2lFklCLcmDapuIQLgblMGyXHCnGtPXjSJClfdiiefIqHfl1oq1noo
	bXNS
X-Google-Smtp-Source: AGHT+IGqQVePZxVF5Vyx4zKG5yY/Q0jOMz9QBzyVpccdscUkIj9rn1n9yNKmtqAXJAJRezMjKRzINQ==
X-Received: by 2002:a05:620a:2485:b0:7c0:5f6c:a33f with SMTP id af79cd13be357-7c05f6ca392mr420431485a.31.1739172163524;
        Sun, 09 Feb 2025 23:22:43 -0800 (PST)
Received: from debian.debian ([2a09:bac5:79dd:f9b::18e:183])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041e9f94csm496264385a.78.2025.02.09.23.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 23:22:42 -0800 (PST)
Date: Sun, 9 Feb 2025 23:22:39 -0800
From: Yan Zhai <yan@cloudflare.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
	Yan Zhai <yan@cloudflare.com>, Brian Vazquez <brianvv@google.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	kernel-team@cloudflare.com, Hou Tao <houtao@huaweicloud.com>
Subject: [PATCH v3 bpf 2/2] selftests: bpf: test batch lookup on array of
 maps with holes
Message-ID: <9007237b9606dc2ee44465a4447fe46e13f3bea6.1739171594.git.yan@cloudflare.com>
References: <cover.1739171594.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1739171594.git.yan@cloudflare.com>

Iterating through array of maps may encounter non existing keys. The
batch operation should not fail on when this happens.

Signed-off-by: Yan Zhai <yan@cloudflare.com>
Acked-by: Hou Tao <houtao1@huawei.com>
---
 .../bpf/map_tests/map_in_map_batch_ops.c      | 62 +++++++++++++------
 1 file changed, 44 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/bpf/map_tests/map_in_map_batch_ops.c b/tools/testing/selftests/bpf/map_tests/map_in_map_batch_ops.c
index 66191ae9863c..79c3ccadb962 100644
--- a/tools/testing/selftests/bpf/map_tests/map_in_map_batch_ops.c
+++ b/tools/testing/selftests/bpf/map_tests/map_in_map_batch_ops.c
@@ -120,11 +120,12 @@ static void validate_fetch_results(int outer_map_fd,
 
 static void fetch_and_validate(int outer_map_fd,
 			       struct bpf_map_batch_opts *opts,
-			       __u32 batch_size, bool delete_entries)
+			       __u32 batch_size, bool delete_entries,
+			       bool has_holes)
 {
-	__u32 *fetched_keys, *fetched_values, total_fetched = 0;
-	__u32 batch_key = 0, fetch_count, step_size;
-	int err, max_entries = OUTER_MAP_ENTRIES;
+	int err, max_entries = OUTER_MAP_ENTRIES - !!has_holes;
+	__u32 *fetched_keys, *fetched_values, total_fetched = 0, i;
+	__u32 batch_key = 0, fetch_count, step_size = batch_size;
 	__u32 value_size = sizeof(__u32);
 
 	/* Total entries needs to be fetched */
@@ -134,9 +135,8 @@ static void fetch_and_validate(int outer_map_fd,
 	      "Memory allocation failed for fetched_keys or fetched_values",
 	      "error=%s\n", strerror(errno));
 
-	for (step_size = batch_size;
-	     step_size <= max_entries;
-	     step_size += batch_size) {
+	/* hash map may not always return full batch */
+	for (i = 0; i < OUTER_MAP_ENTRIES; i++) {
 		fetch_count = step_size;
 		err = delete_entries
 		      ? bpf_map_lookup_and_delete_batch(outer_map_fd,
@@ -155,6 +155,7 @@ static void fetch_and_validate(int outer_map_fd,
 		if (err && errno == ENOSPC) {
 			/* Fetch again with higher batch size */
 			total_fetched = 0;
+			step_size += batch_size;
 			continue;
 		}
 
@@ -184,18 +185,19 @@ static void fetch_and_validate(int outer_map_fd,
 }
 
 static void _map_in_map_batch_ops(enum bpf_map_type outer_map_type,
-				  enum bpf_map_type inner_map_type)
+				  enum bpf_map_type inner_map_type,
+				  bool has_holes)
 {
+	__u32 max_entries = OUTER_MAP_ENTRIES - !!has_holes;
 	__u32 *outer_map_keys, *inner_map_fds;
-	__u32 max_entries = OUTER_MAP_ENTRIES;
 	LIBBPF_OPTS(bpf_map_batch_opts, opts);
 	__u32 value_size = sizeof(__u32);
 	int batch_size[2] = {5, 10};
 	__u32 map_index, op_index;
 	int outer_map_fd, ret;
 
-	outer_map_keys = calloc(max_entries, value_size);
-	inner_map_fds = calloc(max_entries, value_size);
+	outer_map_keys = calloc(OUTER_MAP_ENTRIES, value_size);
+	inner_map_fds = calloc(OUTER_MAP_ENTRIES, value_size);
 	CHECK((!outer_map_keys || !inner_map_fds),
 	      "Memory allocation failed for outer_map_keys or inner_map_fds",
 	      "error=%s\n", strerror(errno));
@@ -209,6 +211,24 @@ static void _map_in_map_batch_ops(enum bpf_map_type outer_map_type,
 			((outer_map_type == BPF_MAP_TYPE_ARRAY_OF_MAPS)
 			 ? 9 : 1000) - map_index;
 
+	/* This condition is only meaningful for array of maps.
+	 *
+	 * max_entries == OUTER_MAP_ENTRIES - 1 if it is true. Say
+	 * max_entries is short for n, then outer_map_keys looks like:
+	 *
+	 *   [n, n-1, ... 2, 1]
+	 *
+	 * We change it to
+	 *
+	 *   [n, n-1, ... 2, 0]
+	 *
+	 * So it will leave key 1 as a hole. It will serve to test the
+	 * correctness when batch on an array: a "non-exist" key might be
+	 * actually allocated and returned from key iteration.
+	 */
+	if (has_holes)
+		outer_map_keys[max_entries - 1]--;
+
 	/* batch operation - map_update */
 	ret = bpf_map_update_batch(outer_map_fd, outer_map_keys,
 				   inner_map_fds, &max_entries, &opts);
@@ -219,15 +239,17 @@ static void _map_in_map_batch_ops(enum bpf_map_type outer_map_type,
 	/* batch operation - map_lookup */
 	for (op_index = 0; op_index < 2; ++op_index)
 		fetch_and_validate(outer_map_fd, &opts,
-				   batch_size[op_index], false);
+				   batch_size[op_index], false,
+				   has_holes);
 
 	/* batch operation - map_lookup_delete */
 	if (outer_map_type == BPF_MAP_TYPE_HASH_OF_MAPS)
 		fetch_and_validate(outer_map_fd, &opts,
-				   max_entries, true /*delete*/);
+				   max_entries, true /*delete*/,
+				   has_holes);
 
 	/* close all map fds */
-	for (map_index = 0; map_index < max_entries; map_index++)
+	for (map_index = 0; map_index < OUTER_MAP_ENTRIES; map_index++)
 		close(inner_map_fds[map_index]);
 	close(outer_map_fd);
 
@@ -237,16 +259,20 @@ static void _map_in_map_batch_ops(enum bpf_map_type outer_map_type,
 
 void test_map_in_map_batch_ops_array(void)
 {
-	_map_in_map_batch_ops(BPF_MAP_TYPE_ARRAY_OF_MAPS, BPF_MAP_TYPE_ARRAY);
+	_map_in_map_batch_ops(BPF_MAP_TYPE_ARRAY_OF_MAPS, BPF_MAP_TYPE_ARRAY, false);
 	printf("%s:PASS with inner ARRAY map\n", __func__);
-	_map_in_map_batch_ops(BPF_MAP_TYPE_ARRAY_OF_MAPS, BPF_MAP_TYPE_HASH);
+	_map_in_map_batch_ops(BPF_MAP_TYPE_ARRAY_OF_MAPS, BPF_MAP_TYPE_HASH, false);
 	printf("%s:PASS with inner HASH map\n", __func__);
+	_map_in_map_batch_ops(BPF_MAP_TYPE_ARRAY_OF_MAPS, BPF_MAP_TYPE_ARRAY, true);
+	printf("%s:PASS with inner ARRAY map with holes\n", __func__);
+	_map_in_map_batch_ops(BPF_MAP_TYPE_ARRAY_OF_MAPS, BPF_MAP_TYPE_HASH, true);
+	printf("%s:PASS with inner HASH map with holes\n", __func__);
 }
 
 void test_map_in_map_batch_ops_hash(void)
 {
-	_map_in_map_batch_ops(BPF_MAP_TYPE_HASH_OF_MAPS, BPF_MAP_TYPE_ARRAY);
+	_map_in_map_batch_ops(BPF_MAP_TYPE_HASH_OF_MAPS, BPF_MAP_TYPE_ARRAY, false);
 	printf("%s:PASS with inner ARRAY map\n", __func__);
-	_map_in_map_batch_ops(BPF_MAP_TYPE_HASH_OF_MAPS, BPF_MAP_TYPE_HASH);
+	_map_in_map_batch_ops(BPF_MAP_TYPE_HASH_OF_MAPS, BPF_MAP_TYPE_HASH, false);
 	printf("%s:PASS with inner HASH map\n", __func__);
 }
-- 
2.39.5



