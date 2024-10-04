Return-Path: <bpf+bounces-40996-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F97990D38
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 21:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D433AB24F9B
	for <lists+bpf@lfdr.de>; Fri,  4 Oct 2024 19:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7432038C4;
	Fri,  4 Oct 2024 18:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KwUQyFX7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B362038A7;
	Fri,  4 Oct 2024 18:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066335; cv=none; b=U4VNDdCSDca16x27/wWvZbNGj4/RGJMVWur0fTpF+pbHzvih4X+X1uLJaGc7nxPrO3y/4WYYqPe7TfS8xNoS4KDzEgyBwpfSQPRp3Wr9BPaDYT82yG1ehKYvVy3ivRVhzdWo5pFA33/Qz6SiDVu1sg0ozZOjN/JB0mAmyh2YmhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066335; c=relaxed/simple;
	bh=qKxMR/O+/KGzxD7YHNvfXz9zpZTqYq3dVEzc2yy3s4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mnrox37+mdzBWHXbYdclp8QMzVWUawmw1e7wtLFKG0bpI3uOuyoi5nIXDa4/CSUCqA12GBRgtLyh4/SGoqly2dE15qvDckX0WjP94Wk81IBDPLFh5TUllBYe41E1Anh2MGVebm0cULB8oFVyNUyKNic8/XLHDEeEL8PAvgArdfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KwUQyFX7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE15C4CEC6;
	Fri,  4 Oct 2024 18:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066334;
	bh=qKxMR/O+/KGzxD7YHNvfXz9zpZTqYq3dVEzc2yy3s4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KwUQyFX7mxyZIIXNGZ8C9ByFZDswfreP/sFH1v5022wVP02iAq9KeRKpxvxc/iTEv
	 pxOITOuJG3Brdboc9Lb3OpBKij7JhpHx0XN7AcDpc15W6nXsuDeqetGDDlpv/SUxRf
	 gaEVvXYXpnOVQ0n4d9Hb4+FFV9OOXgSxQUJnR5jomjWxeEPCLOuEGpvCbMsgBpjuLi
	 rr4VJpk/6kQsbzLtvzmYDgUB6sJQzvUGfFJlOhb/0Po13txn5aMH82DSuot/YVAvJo
	 RrLlT83k93+6I5x8kJBLfj+r720ckpc9F7MHJtxpjmrt329kc8tcdWbYlc3UVCnghi
	 uo+7ydPLwvrKg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xu Kuohai <xukuohai@huawei.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 17/58] bpf: Prevent tail call between progs attached to different hooks
Date: Fri,  4 Oct 2024 14:23:50 -0400
Message-ID: <20241004182503.3672477-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182503.3672477-1-sashal@kernel.org>
References: <20241004182503.3672477-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.54
Content-Transfer-Encoding: 8bit

From: Xu Kuohai <xukuohai@huawei.com>

[ Upstream commit 28ead3eaabc16ecc907cfb71876da028080f6356 ]

bpf progs can be attached to kernel functions, and the attached functions
can take different parameters or return different return values. If
prog attached to one kernel function tail calls prog attached to another
kernel function, the ctx access or return value verification could be
bypassed.

For example, if prog1 is attached to func1 which takes only 1 parameter
and prog2 is attached to func2 which takes two parameters. Since verifier
assumes the bpf ctx passed to prog2 is constructed based on func2's
prototype, verifier allows prog2 to access the second parameter from
the bpf ctx passed to it. The problem is that verifier does not prevent
prog1 from passing its bpf ctx to prog2 via tail call. In this case,
the bpf ctx passed to prog2 is constructed from func1 instead of func2,
that is, the assumption for ctx access verification is bypassed.

Another example, if BPF LSM prog1 is attached to hook file_alloc_security,
and BPF LSM prog2 is attached to hook bpf_lsm_audit_rule_known. Verifier
knows the return value rules for these two hooks, e.g. it is legal for
bpf_lsm_audit_rule_known to return positive number 1, and it is illegal
for file_alloc_security to return positive number. So verifier allows
prog2 to return positive number 1, but does not allow prog1 to return
positive number. The problem is that verifier does not prevent prog1
from calling prog2 via tail call. In this case, prog2's return value 1
will be used as the return value for prog1's hook file_alloc_security.
That is, the return value rule is bypassed.

This patch adds restriction for tail call to prevent such bypasses.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
Link: https://lore.kernel.org/r/20240719110059.797546-4-xukuohai@huaweicloud.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/bpf.h |  1 +
 kernel/bpf/core.c   | 21 ++++++++++++++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index e4cd28c38b825..0f0e0265cbdf5 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -288,6 +288,7 @@ struct bpf_map {
 	 * same prog type, JITed flag and xdp_has_frags flag.
 	 */
 	struct {
+		const struct btf_type *attach_func_proto;
 		spinlock_t lock;
 		enum bpf_prog_type type;
 		bool jited;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 4124805ad7ba5..58ee17f429a33 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2259,6 +2259,7 @@ bool bpf_prog_map_compatible(struct bpf_map *map,
 {
 	enum bpf_prog_type prog_type = resolve_prog_type(fp);
 	bool ret;
+	struct bpf_prog_aux *aux = fp->aux;
 
 	if (fp->kprobe_override)
 		return false;
@@ -2268,7 +2269,7 @@ bool bpf_prog_map_compatible(struct bpf_map *map,
 	 * in the case of devmap and cpumap). Until device checks
 	 * are implemented, prohibit adding dev-bound programs to program maps.
 	 */
-	if (bpf_prog_is_dev_bound(fp->aux))
+	if (bpf_prog_is_dev_bound(aux))
 		return false;
 
 	spin_lock(&map->owner.lock);
@@ -2278,12 +2279,26 @@ bool bpf_prog_map_compatible(struct bpf_map *map,
 		 */
 		map->owner.type  = prog_type;
 		map->owner.jited = fp->jited;
-		map->owner.xdp_has_frags = fp->aux->xdp_has_frags;
+		map->owner.xdp_has_frags = aux->xdp_has_frags;
+		map->owner.attach_func_proto = aux->attach_func_proto;
 		ret = true;
 	} else {
 		ret = map->owner.type  == prog_type &&
 		      map->owner.jited == fp->jited &&
-		      map->owner.xdp_has_frags == fp->aux->xdp_has_frags;
+		      map->owner.xdp_has_frags == aux->xdp_has_frags;
+		if (ret &&
+		    map->owner.attach_func_proto != aux->attach_func_proto) {
+			switch (prog_type) {
+			case BPF_PROG_TYPE_TRACING:
+			case BPF_PROG_TYPE_LSM:
+			case BPF_PROG_TYPE_EXT:
+			case BPF_PROG_TYPE_STRUCT_OPS:
+				ret = false;
+				break;
+			default:
+				break;
+			}
+		}
 	}
 	spin_unlock(&map->owner.lock);
 
-- 
2.43.0


