Return-Path: <bpf+bounces-65194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ED77AB1D805
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 14:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D851D4E3B10
	for <lists+bpf@lfdr.de>; Thu,  7 Aug 2025 12:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658F723F413;
	Thu,  7 Aug 2025 12:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="UdStOAJL"
X-Original-To: bpf@vger.kernel.org
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [178.154.239.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48BF7E9
	for <bpf@vger.kernel.org>; Thu,  7 Aug 2025 12:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754570130; cv=none; b=Cffr2TawSNAUpQnZc6q1FkP8OlvIyL+yZyjeqffLWq8blHXdOtotQgwlh45ujX4piS8w7DBq5cgzdsPSB7jXC2qU1Jb44/MhAyxa3VoNQuZGCNOqmHIXUHV67RHswK7L7vOx7DsuetF3LnE7WAVGO9lZYDtJ88PGhDNaimWqVoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754570130; c=relaxed/simple;
	bh=3k8WtDoGqb9Zl5LAGhF3CjwXqE42YR6sQhJ0kZNW7LU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QQP/Od3OuDA1o0PtVelSMzWY3R5Jw3HyktDrTQuGCF4kqxIbEVoiTd1f/eAwTA/HTH1+cAfljtUTo9RUWkJKkh1ZxoqZZ4iTuvNZW0ah5FMcg4ko18aZeZdSw8s12xsUTyjdNSV6QlBksgx18pjUFARTmYwHAZyTxz22zjcJHdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=UdStOAJL; arc=none smtp.client-ip=178.154.239.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:1f21:0:640:a2e6:0])
	by forward103a.mail.yandex.net (Yandex) with ESMTPS id 6FF0480624;
	Thu, 07 Aug 2025 15:35:18 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id GZhL5aWMomI0-suYPuIoO;
	Thu, 07 Aug 2025 15:35:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1754570118; bh=yid2eWd4yalTSequ4yTKynILCh8nfuN4JTiXyYhSVBA=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=UdStOAJLW5lwmDUt3cGwvZsmbB9E1d5ChOObvWheAQCxXAEjOL3hutSacvBvh2q6K
	 pBXzYr50pjefiXOMrGCZp1TI1aO70ky/1/gWs2ekL/cMLiF0FHbgErWs0AsjV32z4K
	 oJ6hwOMzYCfd8hSPs+XyV8sgekUn1gNnLaQLcqYI=
Authentication-Results: mail-nwsmtp-smtp-production-main-60.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] bpf: fix memory leak in SCC management
Date: Thu,  7 Aug 2025 15:34:33 +0300
Message-ID: <20250807123433.7868-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Running with CONFIG_DEBUG_KMEMLEAK enabled, I've noticed a few memory
leaks reported as follows:

unreferenced object 0xffff8881ce3bd080 (size 64):
  comm "systemd", pid 3524, jiffies 4294789711
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 8c5ed7af):
    __kmalloc_node_track_caller_noprof+0x25e/0x4e0
    krealloc_noprof+0xe8/0x2f0
    kvrealloc_noprof+0x65/0xe0
    do_check+0x3ef1/0xcd10
    do_check_common+0x1631/0x2110
    bpf_check+0x3686/0x1e430
    bpf_prog_load+0xda2/0x13f0
    __sys_bpf+0x374/0x5b0
    __x64_sys_bpf+0x7c/0x90
    do_syscall_64+0x8a/0x220
    entry_SYSCALL_64_after_hwframe+0x76/0x7e

Wnen an array of SCC slots is allocated in 'compute_scc()', 'scc_cnt' of
the corresponding environment should be adjusted to match the size of this
array. Otherwise an array members (re)assigned in 'scc_visit_alloc()' will
be unreachable from the freeing loop in 'free_states()'.

Fixes: c9e31900b54c ("bpf: propagate read/precision marks over state graph backedges")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 kernel/bpf/verifier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0806295945e4..c4f69a9e9af6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23114,6 +23114,8 @@ static void free_states(struct bpf_verifier_env *env)
 
 	for (i = 0; i < env->scc_cnt; ++i) {
 		info = env->scc_info[i];
+		if (!info)
+			continue;
 		for (j = 0; j < info->num_visits; j++)
 			free_backedges(&info->visits[j]);
 		kvfree(info);
@@ -24554,6 +24556,7 @@ static int compute_scc(struct bpf_verifier_env *env)
 		err = -ENOMEM;
 		goto exit;
 	}
+	env->scc_cnt = next_scc_id;
 exit:
 	kvfree(stack);
 	kvfree(pre);
-- 
2.50.1


