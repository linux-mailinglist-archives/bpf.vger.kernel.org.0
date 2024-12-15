Return-Path: <bpf+bounces-47003-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D6D9F25DF
	for <lists+bpf@lfdr.de>; Sun, 15 Dec 2024 20:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CCD11885FE9
	for <lists+bpf@lfdr.de>; Sun, 15 Dec 2024 19:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9458E1C54A5;
	Sun, 15 Dec 2024 19:35:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C5F1C4A2E;
	Sun, 15 Dec 2024 19:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734291323; cv=none; b=VWFOgex4zSJTtE50SWZxwiBQzSbUirMbz2jGkiquuDz9CTbAz6olJp0Cv+rZUflC5IdchUuDgsJ7V7py5f8+AgZ9WuyBxdrOL33ui7H23mzsKTD6KSp7lRMEcD3yw5FNGf7BviB2OhppIr17NZdhRSV3vM+eAGx1AzgLVCB+0s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734291323; c=relaxed/simple;
	bh=FW+SVeCqxjmBqsfNQNVYgmUSe/phkOsX9Wq1i5i+KrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LHgO3xOx8zOecc5PifMcj9dSbttkkh/RwRpSPbgJAFzYzqIgQJmlcujxls55LZnjVAfpA5jIjpw36bGuTR9o0vaPJFe3XwYCMcEXJ5j4Ju+3JiamfgUtr3dZ/YaylccPxzFltwFKTGtL5FdfzcItp8qytwpO3k7s3/OGYHM3xgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 024891424;
	Sun, 15 Dec 2024 11:35:49 -0800 (PST)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 098D83F528;
	Sun, 15 Dec 2024 11:35:16 -0800 (PST)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v1 3/7] bpf: Sync bpf_perf_event_aux_pause in tools UAPI bpf.h
Date: Sun, 15 Dec 2024 19:34:32 +0000
Message-Id: <20241215193436.275278-4-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241215193436.275278-1-leo.yan@arm.com>
References: <20241215193436.275278-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the new API bpf_perf_event_aux_pause has been added in the kernel
UAPI bpf.h.  Sync with tools UAPI bpf.h.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/include/uapi/linux/bpf.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 4162afc6b5d0..678278c91ce2 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5795,6 +5795,26 @@ union bpf_attr {
  *		0 on success.
  *
  *		**-ENOENT** if the bpf_local_storage cannot be found.
+ *
+ * long bpf_perf_event_aux_pause(struct bpf_map *map, u64 flags, u32 pause)
+ *	Description
+ *		Pause or resume an AUX area trace associated to the perf event.
+ *
+ *		The *flags* argument is specified as the key value for
+ *		retrieving event pointer from the passed *map*.
+ *
+ *		The *pause* argument controls AUX trace pause or resume.
+ *		Non-zero values (true) are to pause the AUX trace and the zero
+ *		value (false) is for re-enabling the AUX trace.
+ *	Return
+ *		0 on success.
+ *
+ *		**-ENOENT** if not found event in the events map.
+ *
+ *		**-E2BIG** if the event index passed in the *flags* parameter
+ *		is out-of-range of the map.
+ *
+ *		**-EINVAL** if the flags passed is an invalid value.
  */
 #define ___BPF_FUNC_MAPPER(FN, ctx...)			\
 	FN(unspec, 0, ##ctx)				\
@@ -6009,6 +6029,7 @@ union bpf_attr {
 	FN(user_ringbuf_drain, 209, ##ctx)		\
 	FN(cgrp_storage_get, 210, ##ctx)		\
 	FN(cgrp_storage_delete, 211, ##ctx)		\
+	FN(perf_event_aux_pause, 212, ##ctx)		\
 	/* */
 
 /* backwards-compatibility macros for users of __BPF_FUNC_MAPPER that don't
-- 
2.34.1


