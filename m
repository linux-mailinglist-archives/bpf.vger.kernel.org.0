Return-Path: <bpf+bounces-59890-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AE7AD0714
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 18:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF8203B3101
	for <lists+bpf@lfdr.de>; Fri,  6 Jun 2025 16:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5012289E21;
	Fri,  6 Jun 2025 16:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KvxB4Uao"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3126728A1C5
	for <bpf@vger.kernel.org>; Fri,  6 Jun 2025 16:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749229125; cv=none; b=uirRoXK2McST00ADWv3yPUySUU4MJARLvsa40JroXyrEFhku8Vps+IvwQPfq/BlVYf9UdxrTXmxqOAX4hCNNKE29NKzI+3D9k+U4g+ZroO3QICVAv3PWGrLxRioOD6PA6Tf8LEUGWImq7EYiAcPAVROi0ZpD9jivib1d1kMGwWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749229125; c=relaxed/simple;
	bh=tufv0EOfIRCcGCuoeIAQzVp2+83siqI9hecekbLVrcY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rkyTEPerHM69ICHJjAInhyMan31fqhFUc3WKfP8ZqnJLsvrj/yXBlzeDrFTJoiMiZzVkOn3LuYTCJhuTguUK9E5iDdShp0zgs+5hSsYUiig6SNHAPI4iCHac+tto7aIF7hb5ezsOFY+UhJaWN6IV/jvapaEMqhD5J1wMCL3FZPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KvxB4Uao; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1749229121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5NdfrsbIRzOD8vK2LDNBZuEFwBMyM/EzGFaa7yMA5lU=;
	b=KvxB4UaoKQG/EngKwI9mNfIlykekVYow+Qp3zffmi1L8gB7BO50YIf8DX0uU94w7AIBKSs
	ElFlOi1KES1jkQly9HWPmF/cb0UA9d0OqeC2X8BJLCKykfuhqVGgp4JaC0A9uwpitr1ptK
	2tEff5IgCyrEwYBBHVDrlMy4BWv7A24=
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
Subject: [PATCH bpf-next  1/5] bpf: Add cookie to tracing bpf_link_info
Date: Sat,  7 Jun 2025 00:58:14 +0800
Message-Id: <20250606165818.3394397-1-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

bpf_tramp_link includes cookie info, we can add it in bpf_link_info.

Signed-off-by: Tao Chen <chen.dylane@linux.dev>
---
 include/uapi/linux/bpf.h       | 2 ++
 kernel/bpf/syscall.c           | 1 +
 tools/include/uapi/linux/bpf.h | 2 ++
 3 files changed, 5 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index f1160ebbf52..fd4869d8cd1 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6658,6 +6658,8 @@ struct bpf_link_info {
 			__u32 attach_type;
 			__u32 target_obj_id; /* prog_id for PROG_EXT, otherwise btf object id */
 			__u32 target_btf_id; /* BTF type id inside the object */
+			__u32 :32;
+			__u64 cookie;
 		} tracing;
 		struct {
 			__u64 cgroup_id;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 89d027cd7ca..4c0ac083518 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3416,6 +3416,7 @@ static int bpf_tracing_link_fill_link_info(const struct bpf_link *link,
 		container_of(link, struct bpf_tracing_link, link.link);
 
 	info->tracing.attach_type = tr_link->attach_type;
+	info->tracing.cookie = tr_link->link.cookie;
 	bpf_trampoline_unpack_key(tr_link->trampoline->key,
 				  &info->tracing.target_obj_id,
 				  &info->tracing.target_btf_id);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index f1160ebbf52..fd4869d8cd1 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6658,6 +6658,8 @@ struct bpf_link_info {
 			__u32 attach_type;
 			__u32 target_obj_id; /* prog_id for PROG_EXT, otherwise btf object id */
 			__u32 target_btf_id; /* BTF type id inside the object */
+			__u32 :32;
+			__u64 cookie;
 		} tracing;
 		struct {
 			__u64 cgroup_id;
-- 
2.43.0


