Return-Path: <bpf+bounces-67215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BACAAB40D00
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 20:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97FCB562330
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 18:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B560135084A;
	Tue,  2 Sep 2025 18:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WPNB/jSq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB3A34DCF8
	for <bpf@vger.kernel.org>; Tue,  2 Sep 2025 18:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756837081; cv=none; b=ERtfdPHIzPBlGR9wZeoWYZrMvm+ezAaTZXl8CgQl+vr/wVFCPiCyAGG+DkiJMMmp8hCBeV8uZIImmEbyCYe93ZX6W7uZJ4JXfHqJi9cRSXal0xiVF5ubm5VxgIIUdA2hwmaRlw92bt1bjaVpM82SCorA++tsrf1kim0g8BINBfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756837081; c=relaxed/simple;
	bh=9pOKl1lXDuajNkxewqIeccw4ne2bXf7ekNvgOMTPpqU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=orAvcYX/SRoD7bxt98i4kxdBQoBD4X8/DsHrlX3A6QlViqNM3I/2QspG6unJxz/rnU9jTHt1FDFNjfXibxEZBBhvxx5OMDloTYoW8/Ao7OQWieCHrLJgUkXx07buB6PnhGhY2NMWBJd8Zf01ZeYrWwjBc98F3ehurXSBheyXvh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WPNB/jSq; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2445803f0cfso75003845ad.1
        for <bpf@vger.kernel.org>; Tue, 02 Sep 2025 11:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756837079; x=1757441879; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kdo5o2SetATQTIpdBQY6E+sJihlY0VNKLQbD3MSNFx4=;
        b=WPNB/jSqd5SISxsBbuTzcOaAsdO19qEicC0X93zVUGIQCkAOVRXrY0cOsFEmG3tR89
         hz8VwnksaLS9d0MRBeMDQHPSAfAvxiu8J9XVPpU8uPwxKZ1/7kTlzWCEMPtdRSFPEKRc
         Iyc9GduGC7dUyUmhB70Di7DUo8UsoNflspeLH0TaQDt+pLEUvqmmiIujuNUVxEYJt3y7
         /YzJ+IS8KlPUyWL2cUm/YeWbi1+nqEPgi9AvT4rAqfQv98YYHosIMSBvl2oj4EYkVHvp
         BAyM7S9qSfXNLeOgdFwSHoT6Kkf1aJTdbD+NVo6GFPK1y35Wt50VTviIQne7CzAV+ab6
         n4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756837079; x=1757441879;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kdo5o2SetATQTIpdBQY6E+sJihlY0VNKLQbD3MSNFx4=;
        b=cRP5fLHkQOUK1Hq4Ey5h25hHTQyIRvxrkX2kdMnmA44BcyeRHvJ1eBkmHnNuO7CuP8
         j5Dk0TRr9FSPb2Fi+t/c3X1GACXNvCEE9//qxynfTeWbIDv+e5B2/iq1Q2CM/xJrqCdP
         gpg8LXce+DFqs8HTOMjoVljhEf08Zz2JoKRB86NLIutXHoOl8Lt/atktAZfJrIH+ulqj
         fTHjEQMOfUsA1SUEku4Xm5OQEPceBpQD7BH/2R3aGYpzDoySd3ESgub9oADTSsvXMUBp
         sSt/YlqRY30mSJP23hN7mf+3eVChu0teHnZ4SPloDtslUiIt3mGVeKltyWEriDtfS3CE
         NgpA==
X-Forwarded-Encrypted: i=1; AJvYcCUXraAWzYCQ5wgD0+g8Jq+VMe3aBF8SJCoSFsHMm7eeR45Nz17j4QIxvEsEu9jYFgtJbh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI2KFu80pkjrJGqoDR09lV3DtDLGZk/NjT9rQy/fnw8+DB2W+O
	ViGbNk/EzuqTtYDfyvEdNnnweIsX0zBNs2threwrDFaQzvsCJOiLP5FmtLjoK+NWarxfWUZClxq
	R6r0v8I5pTw==
X-Google-Smtp-Source: AGHT+IHwAdt/JxFvVqPwAfn0Fh+7XPRFGGQZEZyiHGiYKYvV2yPyjI/bP1LBuEdcCYtdzJs+QXzfUBVhZBlT
X-Received: from plbkf12.prod.google.com ([2002:a17:903:5cc:b0:240:1821:d2d2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cf09:b0:248:df64:ec6a
 with SMTP id d9443c01a7336-24944a27103mr144275025ad.15.1756837078726; Tue, 02
 Sep 2025 11:17:58 -0700 (PDT)
Date: Tue,  2 Sep 2025 11:17:13 -0700
In-Reply-To: <20250902181713.309797-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250902181713.309797-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250902181713.309797-4-irogers@google.com>
Subject: [PATCH v1 3/3] perf bpf-utils: Harden get_bpf_prog_info_linear
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Blake Jones <blakejones@google.com>, 
	Zhongqiu Han <quic_zhonhan@quicinc.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Song Liu <songliubraving@fb.com>, Dave Marchevsky <davemarchevsky@fb.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Howard Chu <howardchu95@gmail.com>, song@kernel.org, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"

In get_bpf_prog_info_linear two calls to bpf_obj_get_info_by_fd are
made, the first to compute memory requirements for a struct perf_bpil
and the second to fill it in. Previously the code would warn when the
second call didn't match the first. Such races can be common place in
things like perf test, whose perf trace tests will frequently load BPF
programs. Rather than a debug message, return actual errors for this
case. Out of paranoia also validate the read bpf_prog_info array
value. Change the type of ptr to avoid mismatched pointer type
compiler warnings. Add some additional debug print outs and sanity
asserts.

Closes: https://lore.kernel.org/lkml/CAP-5=fWJQcmUOP7MuCA2ihKnDAHUCOBLkQFEkQES-1ZZTrgf8Q@mail.gmail.com/
Fixes: 6ac22d036f86 ("perf bpf: Pull in bpf_program__get_prog_info_linear()")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf-utils.c | 43 ++++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/bpf-utils.c b/tools/perf/util/bpf-utils.c
index 64a558344696..5a66dc8594aa 100644
--- a/tools/perf/util/bpf-utils.c
+++ b/tools/perf/util/bpf-utils.c
@@ -115,7 +115,7 @@ get_bpf_prog_info_linear(int fd, __u64 arrays)
 	__u32 info_len = sizeof(info);
 	__u32 data_len = 0;
 	int i, err;
-	void *ptr;
+	__u8 *ptr;
 
 	if (arrays >> PERF_BPIL_LAST_ARRAY)
 		return ERR_PTR(-EINVAL);
@@ -126,6 +126,8 @@ get_bpf_prog_info_linear(int fd, __u64 arrays)
 		pr_debug("can't get prog info: %s", strerror(errno));
 		return ERR_PTR(-EFAULT);
 	}
+	if (info.type >= __MAX_BPF_PROG_TYPE)
+		pr_debug("%s:%d: unexpected program type %u\n", __func__, __LINE__, info.type);
 
 	/* step 2: calculate total size of all arrays */
 	for (i = PERF_BPIL_FIRST_ARRAY; i < PERF_BPIL_LAST_ARRAY; ++i) {
@@ -173,6 +175,8 @@ get_bpf_prog_info_linear(int fd, __u64 arrays)
 					     desc->count_offset, count);
 		bpf_prog_info_set_offset_u32(&info_linear->info,
 					     desc->size_offset, size);
+		assert(ptr >= info_linear->data);
+		assert(ptr < &info_linear->data[data_len]);
 		bpf_prog_info_set_offset_u64(&info_linear->info,
 					     desc->array_offset,
 					     ptr_to_u64(ptr));
@@ -186,26 +190,45 @@ get_bpf_prog_info_linear(int fd, __u64 arrays)
 		free(info_linear);
 		return ERR_PTR(-EFAULT);
 	}
+	if (info_linear->info.type >= __MAX_BPF_PROG_TYPE) {
+		pr_debug("%s:%d: unexpected program type %u\n",
+			 __func__, __LINE__, info_linear->info.type);
+	}
 
 	/* step 6: verify the data */
+	ptr = info_linear->data;
 	for (i = PERF_BPIL_FIRST_ARRAY; i < PERF_BPIL_LAST_ARRAY; ++i) {
 		const struct bpil_array_desc *desc = &bpil_array_desc[i];
-		__u32 v1, v2;
+		__u32 count1, count2, size1, size2;
+		__u64 ptr2;
 
 		if ((arrays & (1UL << i)) == 0)
 			continue;
 
-		v1 = bpf_prog_info_read_offset_u32(&info, desc->count_offset);
-		v2 = bpf_prog_info_read_offset_u32(&info_linear->info,
+		count1 = bpf_prog_info_read_offset_u32(&info, desc->count_offset);
+		count2 = bpf_prog_info_read_offset_u32(&info_linear->info,
 						   desc->count_offset);
-		if (v1 != v2)
-			pr_warning("%s: mismatch in element count\n", __func__);
+		if (count1 != count2) {
+			pr_warning("%s: mismatch in element count %u vs %u\n", __func__, count1, count2);
+			free(info_linear);
+			return ERR_PTR(-ERANGE);
+		}
 
-		v1 = bpf_prog_info_read_offset_u32(&info, desc->size_offset);
-		v2 = bpf_prog_info_read_offset_u32(&info_linear->info,
+		size1 = bpf_prog_info_read_offset_u32(&info, desc->size_offset);
+		size2 = bpf_prog_info_read_offset_u32(&info_linear->info,
 						   desc->size_offset);
-		if (v1 != v2)
-			pr_warning("%s: mismatch in rec size\n", __func__);
+		if (size1 != size2) {
+			pr_warning("%s: mismatch in rec size %u vs %u\n", __func__, size1, size2);
+			free(info_linear);
+			return ERR_PTR(-ERANGE);
+		}
+		ptr2 = bpf_prog_info_read_offset_u64(&info_linear->info, desc->array_offset);
+		if (ptr_to_u64(ptr) != ptr2) {
+			pr_warning("%s: mismatch in array %p vs %llx\n", __func__, ptr, ptr2);
+			free(info_linear);
+			return ERR_PTR(-ERANGE);
+		}
+		ptr += roundup(count1 * size1, sizeof(__u64));
 	}
 
 	/* step 7: update info_len and data_len */
-- 
2.51.0.355.g5224444f11-goog


