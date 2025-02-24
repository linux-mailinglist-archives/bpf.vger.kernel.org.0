Return-Path: <bpf+bounces-52389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF6CA428EE
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 18:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71DBA18975F1
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2025 17:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD9726658D;
	Mon, 24 Feb 2025 17:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VRQ7d5UD"
X-Original-To: bpf@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717C2266584
	for <bpf@vger.kernel.org>; Mon, 24 Feb 2025 17:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416403; cv=none; b=QZw+oastG5+8vyf3ngHiUBk4zfhmKMSb3z+Man1wdKK5fDxpo5nR5JykY1Qq64AznLYzIgCJqQACHiDvj2CSnqN0ein3U/xZvo0auuYTOaLItRDEVR8nx9k2iRe98/IFQLGuFTu0z8l2r4j3/+W6m+OGER5oKqvWN5Ql3NduZKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416403; c=relaxed/simple;
	bh=jm9V/uGdHxg5OBS/aN+olvdgGrxxL3p39+/oZgyyRrw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AN1CFp0x0icGTIZvaq07xjqx7ljCf1NxjPdT1p8ar0w8ipzrTH9xkeOP+noCbuTaBYMhaAt2pkYCbimoTcccRJDqkx/nEepWbruWWeDK0ofadxOO6WPfx4dQaPPcxirCXBqZF8B/p978MEaa5HQVVcWuoNLEMjKXIpxJ5GilkLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VRQ7d5UD; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740416399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sXImHF+AatB2zWehHEZzkP3DgCbk67G0CTnxuxdEVxE=;
	b=VRQ7d5UDZQ1lPbaD4QY3raHMG/CkJGI/nZfTYxApXF6OrKHQmK48OXXrKmvPgzvdYXI1p4
	Y8+Q7CoALwE6/jjdTZzmW+QWELQVwm0QjdIJlgFTjRqaXIxo9c5EmE2ubWNA1pl/HGOmpR
	KcwJSvVpL3KJkZJ+HVK9i5AvoqMmKDg=
From: Tao Chen <chen.dylane@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	haoluo@google.com,
	jolsa@kernel.org,
	qmo@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chen.dylane@gmail.com,
	Tao Chen <chen.dylane@linux.dev>,
	Tao Chen <dylane.chen@didiglobal.com>
Subject: [PATCH bpf-next v8 1/5] libbpf: Extract prog load type check from libbpf_probe_bpf_helper
Date: Tue, 25 Feb 2025 00:59:08 +0800
Message-Id: <20250224165912.599068-2-chen.dylane@linux.dev>
In-Reply-To: <20250224165912.599068-1-chen.dylane@linux.dev>
References: <20250224165912.599068-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Extract prog load type check part from libbpf_probe_bpf_helper
suggested by Andrii, which will be used in both
libbpf_probe_bpf_{helper, kfunc}.

Cc: Tao Chen <dylane.chen@didiglobal.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 tools/lib/bpf/libbpf_probes.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 9dfbe7750f56..a48a557314f6 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -413,6 +413,23 @@ int libbpf_probe_bpf_map_type(enum bpf_map_type map_type, const void *opts)
 	return libbpf_err(ret);
 }
 
+static bool can_probe_prog_type(enum bpf_prog_type prog_type)
+{
+	/* we can't successfully load all prog types to check for BPF helper
+	 * and kfunc support.
+	 */
+	switch (prog_type) {
+	case BPF_PROG_TYPE_TRACING:
+	case BPF_PROG_TYPE_EXT:
+	case BPF_PROG_TYPE_LSM:
+	case BPF_PROG_TYPE_STRUCT_OPS:
+		return false;
+	default:
+		break;
+	}
+	return true;
+}
+
 int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_id helper_id,
 			    const void *opts)
 {
@@ -427,18 +444,8 @@ int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_id helpe
 	if (opts)
 		return libbpf_err(-EINVAL);
 
-	/* we can't successfully load all prog types to check for BPF helper
-	 * support, so bail out with -EOPNOTSUPP error
-	 */
-	switch (prog_type) {
-	case BPF_PROG_TYPE_TRACING:
-	case BPF_PROG_TYPE_EXT:
-	case BPF_PROG_TYPE_LSM:
-	case BPF_PROG_TYPE_STRUCT_OPS:
-		return -EOPNOTSUPP;
-	default:
-		break;
-	}
+	if (!can_probe_prog_type(prog_type))
+		return libbpf_err(-EOPNOTSUPP);
 
 	buf[0] = '\0';
 	ret = probe_prog_load(prog_type, insns, insn_cnt, buf, sizeof(buf));
-- 
2.43.0


