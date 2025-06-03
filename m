Return-Path: <bpf+bounces-59513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C00ACCA6B
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 17:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E05A73A1B5B
	for <lists+bpf@lfdr.de>; Tue,  3 Jun 2025 15:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8596E23D2B3;
	Tue,  3 Jun 2025 15:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fnbp4Qld"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3F022A813
	for <bpf@vger.kernel.org>; Tue,  3 Jun 2025 15:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748965405; cv=none; b=SvWMK6pAXzn0eII1UvwpOKHOQ+pY6zUYq82h8S0FoDi+1aKCV11HCnk3T3ir9cRA0/JVuEb/XLzgRGS44J9bTZlXlCLtdmB+N/iRTH5dXesF1MsvVrRUHc9xGnL0gedGhajZPIDUiwIFJnu4hLo+cSRWnWkKwCmqsCohmh0kJCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748965405; c=relaxed/simple;
	bh=4ZPU5ft8aUPlm+cdEAdlvycAXQyP3MDOAbHuUhGBGSE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CWU97lZtK9i7arew9jY6B7Kb9RGDNDSlowMe59mKRanPN5+0723D94Tn/caCNRU72kppNPZf9oYtk0/4Q+G4+LaUzLdDnIh4w5aRv4s80jD/GI8CRO9sSmg97ZRIHx/nT1bva61AfeaSBZ7yesiMvJcB2YNXWduFH/Aps6tM/yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fnbp4Qld; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748965397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ovhgZmTf9V87V5kyUD1w6ta1v7vNnOUaKuTx985zZ7Q=;
	b=fnbp4QldOMvLnk7L+y91Dvq5D/V4fEt0m+t9JYRFMMj67/7ta6oueQ9662mwxGFjXQ2Vpt
	XN2OWokP9CTAO9LJyiZo7GrrIFWa93aLOQBRWsQR/8JnuBKW2RmIFmHyzjWioI2q90u93o
	TX0luPYR8SxtisnEgNfY/DlheosCorI=
From: Tao Chen <chen.dylane@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	qmo@kernel.org,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>
Subject: [PATCH bpf-next v3 1/3] bpf: Add cookie to raw_tp bpf_link_info
Date: Tue,  3 Jun 2025 23:43:07 +0800
Message-Id: <20250603154309.3063644-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

After commit 68ca5d4eebb8 ("bpf: support BPF cookie in raw tracepoint
(raw_tp, tp_btf) programs"), we can show the cookie in bpf_link_info
like kprobe etc.

Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 include/uapi/linux/bpf.h       | 2 ++
 kernel/bpf/syscall.c           | 1 +
 tools/include/uapi/linux/bpf.h | 2 ++
 3 files changed, 5 insertions(+)

Change list:
- v2 -> v3:
    - use '__u32 :32' to fill the hole.(Yonghong)
    - add double space for plain output.(Quentin)
    - patch1-2 Acked-by Jiri
- v2:
    https://lore.kernel.org/bpf/20250603022610.3005963-1-chen.dylane@linux.dev

- v1 -> v2:
    - fill the hole in bpf_link_info.(Jiri)
- v1:
    https://lore.kernel.org/bpf/20250529165759.2536245-1-chen.dylane@linux.dev

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 07ee73cdf9..9bd2a5b64b 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6644,6 +6644,8 @@ struct bpf_link_info {
 		struct {
 			__aligned_u64 tp_name; /* in/out: tp_name buffer ptr */
 			__u32 tp_name_len;     /* in/out: tp_name buffer len */
+			__u32 :32;
+			__u64 cookie;
 		} raw_tracepoint;
 		struct {
 			__u32 attach_type;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 9794446bc8..1c3dbe44ac 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3687,6 +3687,7 @@ static int bpf_raw_tp_link_fill_link_info(const struct bpf_link *link,
 		return -EINVAL;
 
 	info->raw_tracepoint.tp_name_len = tp_len + 1;
+	info->raw_tracepoint.cookie = raw_tp_link->cookie;
 
 	if (!ubuf)
 		return 0;
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 07ee73cdf9..9bd2a5b64b 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6644,6 +6644,8 @@ struct bpf_link_info {
 		struct {
 			__aligned_u64 tp_name; /* in/out: tp_name buffer ptr */
 			__u32 tp_name_len;     /* in/out: tp_name buffer len */
+			__u32 :32;
+			__u64 cookie;
 		} raw_tracepoint;
 		struct {
 			__u32 attach_type;
-- 
2.43.0


