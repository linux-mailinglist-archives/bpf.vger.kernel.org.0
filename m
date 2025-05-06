Return-Path: <bpf+bounces-57489-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AE3AABB72
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 09:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B83364E310B
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 07:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C0822F753;
	Tue,  6 May 2025 06:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Fk8aQTXZ"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20FD228CA3;
	Tue,  6 May 2025 06:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746512142; cv=none; b=hJaR7DlLoAa6PWP1BizEjQBSksrh2+eXvZe7Je7AVxNIvddVZAFjRrS1DW4E9zIfjI4+g3qL/kHsUuV4Mr339PGCKvNDIXq028QLkeonVF33EiIuFgwkQrtqnUbWDwjoozBiqV82cm8KR6p4nCPsz3VPeR2PymPoiMHKn+eucbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746512142; c=relaxed/simple;
	bh=ynWK2J8C2BCh41D4/1FAgDRD2ogIy1eMHChuUtUrGdk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SOCZmNaRRqdLHVY+GyYlwPyudhCZHryFASQHjXFFIJkFrWKXTGhp91YuQf68ONVpmUfQ/C6uO9xlz0KXa+DiXqIxF0BC0EDmYMIpQsZ43MF2i8TQ6npToT9y/uW9ri+qPB8EsWFl6YOMpYXbbq3ISmMqQwsWmR6Q2F1o3b30ok8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Fk8aQTXZ; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=ZE+bT
	GstDpcwUv49z0r7w9laeGwplHKajtRxKbtzLOo=; b=Fk8aQTXZ2fLsOrZ1pjma8
	jznaTrUbhYv214kEj+HiYmi3TO/R0hnYfE+PrR//UXgcqyxnPt1Qp8PE1dwn5rYu
	YHUFdlqjiEondOYJakEVPL8cInucD1C46Qx/KKMk3/3aNRHFhoaAJRBFXNNybMit
	CUkA53G3Ojg71nKvmiI5S0=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgBnylfLqBlovwXpBw--.23593S4;
	Tue, 06 May 2025 14:14:38 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	davem@davemloft.net,
	tj@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v3 sched_ext 2/2] sched_ext: Remove bpf_scx_get_func_proto
Date: Tue,  6 May 2025 14:14:34 +0800
Message-Id: <20250506061434.94277-3-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250506061434.94277-1-yangfeng59949@163.com>
References: <20250506061434.94277-1-yangfeng59949@163.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgBnylfLqBlovwXpBw--.23593S4
X-Coremail-Antispam: 1Uf129KBjvJXoWrtw48Wr4kJr48ZF4kXr4fKrg_yoW8JF1rpF
	ZxXFsxCr48Gw4agF9xJr4fZF15GwnIq3yxGa90yw1xtr4qvryqqw1UGr4I9a4fJr9rCw12
	yr1jvFWakr1Iga7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jOqXdUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/1tbiTRlFeGgZp3ApAwAAsl

From: Feng Yang <yangfeng@kylinos.cn>

task_storage_{get,delete} has been moved to bpf_base_func_proto.

Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 kernel/sched/ext.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index fdbf249d1c68..cc628b009e11 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5586,21 +5586,8 @@ static int bpf_scx_btf_struct_access(struct bpf_verifier_log *log,
 	return -EACCES;
 }
 
-static const struct bpf_func_proto *
-bpf_scx_get_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
-{
-	switch (func_id) {
-	case BPF_FUNC_task_storage_get:
-		return &bpf_task_storage_get_proto;
-	case BPF_FUNC_task_storage_delete:
-		return &bpf_task_storage_delete_proto;
-	default:
-		return bpf_base_func_proto(func_id, prog);
-	}
-}
-
 static const struct bpf_verifier_ops bpf_scx_verifier_ops = {
-	.get_func_proto = bpf_scx_get_func_proto,
+	.get_func_proto = bpf_base_func_proto,
 	.is_valid_access = bpf_scx_is_valid_access,
 	.btf_struct_access = bpf_scx_btf_struct_access,
 };
-- 
2.43.0


