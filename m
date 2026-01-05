Return-Path: <bpf+bounces-77846-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E1422CF4887
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 16:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 984F23044866
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 15:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A64233A9C2;
	Mon,  5 Jan 2026 15:54:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.189.cn (189sx01-ptr.21cn.com [14.18.100.240])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DDE2F5A10;
	Mon,  5 Jan 2026 15:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.18.100.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767628454; cv=none; b=WpvxYgNgrlEtqf70iBDwU6MC1WjDi862eqnxfwv8my4Y7yMgAnofZSrCjiIxc9drIRNIm503bY2l6bYbJMEkovuEN0we1TT73cUkg01v1fVBN16ialQSKv3wtaaX0+kRCKaKfJNXYTD0Qt/+TXvBG44qyEdnLDZFZPIE3LJFTaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767628454; c=relaxed/simple;
	bh=DzZ2zHaDBq8WuYcyzQRNPh2LCzu7mqexrhJOeYhDTEA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ymgh1NzTtOrUDc327fEbYcioGVTPEDEMrLHbStCCs50DUUhxSQSh9PLhgkjsN5WWdn7ghbMNMXC8V6q6k9z9DFiPq5GBPnA2Xwu4TlXzE3zmNeuBUYG9MUtvEw/EIeS/2rv8drMe8qpgop99GNT99Me5BEcCOn+PbVjs6/VJW24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn; spf=pass smtp.mailfrom=189.cn; arc=none smtp.client-ip=14.18.100.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=189.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=189.cn
HMM_SOURCE_IP:10.158.242.145:0.2049999328
HMM_ATTACHE_NUM:0000
HMM_SOURCE_TYPE:SMTP
Received: from clientip-125.36.254.33 (unknown [10.158.242.145])
	by mail.189.cn (HERMES) with SMTP id 8E311400089;
	Mon,  5 Jan 2026 23:50:13 +0800 (CST)
Received: from  ([125.36.254.33])
	by gateway-153622-dep-587d8f56d7-sdp2j with ESMTP id 5e40b1ed08a84c8eb251a1b10b5e5c65 for ast@kernel.org;
	Mon, 05 Jan 2026 23:50:13 CST
X-Transaction-ID: 5e40b1ed08a84c8eb251a1b10b5e5c65
X-Real-From: chensong_2000@189.cn
X-Receive-IP: 125.36.254.33
X-MEDUSA-Status: 0
Sender: chensong_2000@189.cn
From: chensong_2000@189.cn
To: ast@kernel.org,
	andrii@kernel.org,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Song Chen <chensong_2000@189.cn>
Subject: [PATCH] kernel/bpf/verifier: removed an unused parameter in check_func_proto
Date: Mon,  5 Jan 2026 23:50:09 +0800
Message-Id: <20260105155009.4581-1-chensong_2000@189.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Song Chen <chensong_2000@189.cn>

I accidentally saw an unused parameter in check_func_proto,
it's harmless but better be removed.

Signed-off-by: Song Chen <chensong_2000@189.cn>
---
 kernel/bpf/verifier.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f0ca69f888fa..30232863bb47 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10349,7 +10349,7 @@ static bool check_btf_id_ok(const struct bpf_func_proto *fn)
 	return true;
 }
 
-static int check_func_proto(const struct bpf_func_proto *fn, int func_id)
+static int check_func_proto(const struct bpf_func_proto *fn)
 {
 	return check_raw_mode_ok(fn) &&
 	       check_arg_pair_ok(fn) &&
@@ -11524,7 +11524,7 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
 	memset(&meta, 0, sizeof(meta));
 	meta.pkt_access = fn->pkt_access;
 
-	err = check_func_proto(fn, func_id);
+	err = check_func_proto(fn);
 	if (err) {
 		verifier_bug(env, "incorrect func proto %s#%d", func_id_name(func_id), func_id);
 		return err;
-- 
2.43.0


