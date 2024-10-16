Return-Path: <bpf+bounces-42194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FFE9A0BDD
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 15:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E5431C23789
	for <lists+bpf@lfdr.de>; Wed, 16 Oct 2024 13:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4221620B1EE;
	Wed, 16 Oct 2024 13:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="aYrM7rUo"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216B6208D7D
	for <bpf@vger.kernel.org>; Wed, 16 Oct 2024 13:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729086559; cv=none; b=cSEuv6ffdOhyBKz6f7yTjX9N2JfvoSMkMRxPxkjUmNY025Brl8s8WGJd3dqm6+i4zR9sf3b0S58FHJIV6s6gUbP5h0+032leD8OQ+uoT8cFSqZMdD3Wywi5lM/4odigVA6JWEcjw1M7l7gSsV/FAYyI11+5DJlAO0dhp5kkeCzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729086559; c=relaxed/simple;
	bh=3uBpiXVD4QUsGsFAgcNPOLcwCTIE85yIjO1xdtKGZGM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hO53WicvyFDLMzIEOIlQb3VpsVRON/eL3MVmVd4gkbRuWZogQxeBEgjHUJx04SqmyKpntXvpLoZXp4RCBViPDb2Euf5Fy26fRaSUkIQ+lLs7JKoIU8N5uPcxATSp5xMrBlSRg/ysQ/3QDPe5AP8K/W+LBPbNxAvWusI1G5egFCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=aYrM7rUo; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=FiY7GNkd52GaXBTWs9JzPL1/MlU/9SjThSdJw47eb2g=; b=aYrM7rUoaGbj8Q6B9KJyYLJHkS
	7FGIYZBx8E8o3gt6P1i3xVuC+2HTcPRpMy3ENI5SgS1m9GW0rd3XXaGYJ34hDf/1zGzMuj70xs9xq
	6BAnUP4oWm6H/cjTfrazPr2phleKOSejtGsgjPVMXdffzbNnn7LJZXm8NZLszmBokRKgxe7t55w/f
	5oBnmhQgG4+xkuSqODNaYxfS84hI+s6bScv+ZhroJAHrMK+TThnjgc8fZBm56IPtqwfjnMbVF27R4
	rC4gaZLmtCcmup2dqfVzyDJXdwQ4TzCFJ2Tc5LcIZEBWh+hpEF6+Dm/u+23Kq+srq0Xph+/KnIqU8
	cxx/Jjyg==;
Received: from 44.248.197.178.dynamic.cust.swisscom.net ([178.197.248.44] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1t14Oo-000NfG-Mt; Wed, 16 Oct 2024 15:49:14 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: nathaniel.theis@nccgroup.com,
	ast@kernel.org,
	eddyz87@gmail.com,
	andrii@kernel.org,
	john.fastabend@gmail.com
Subject: [PATCH bpf 2/3] bpf: Fix print_reg_state's constant scalar dump
Date: Wed, 16 Oct 2024 15:49:12 +0200
Message-Id: <20241016134913.32249-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241016134913.32249-1-daniel@iogearbox.net>
References: <20241016134913.32249-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27429/Wed Oct 16 10:34:11 2024)

print_reg_state() should not consider adding reg->off to reg->var_off.value
when dumping scalars. Scalars can be produced with reg->off != 0 through
BPF_ADD_CONST, and thus as-is this can skew the register log dump.

Fixes: 98d7ca374ba4 ("bpf: Track delta between "linked" registers.")
Reported-by: Nathaniel Theis <nathaniel.theis@nccgroup.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 kernel/bpf/log.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
index 5aebfc3051e3..4a858fdb6476 100644
--- a/kernel/bpf/log.c
+++ b/kernel/bpf/log.c
@@ -688,8 +688,7 @@ static void print_reg_state(struct bpf_verifier_env *env,
 	if (t == SCALAR_VALUE && reg->precise)
 		verbose(env, "P");
 	if (t == SCALAR_VALUE && tnum_is_const(reg->var_off)) {
-		/* reg->off should be 0 for SCALAR_VALUE */
-		verbose_snum(env, reg->var_off.value + reg->off);
+		verbose_snum(env, reg->var_off.value);
 		return;
 	}
 
-- 
2.43.0


