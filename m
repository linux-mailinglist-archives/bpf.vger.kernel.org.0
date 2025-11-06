Return-Path: <bpf+bounces-73905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EB0C3D70F
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 21:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C47FC4E6B69
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 20:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6DC301705;
	Thu,  6 Nov 2025 20:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b="a8gVwRda"
X-Original-To: bpf@vger.kernel.org
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [178.154.239.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1B3301492;
	Thu,  6 Nov 2025 20:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762462787; cv=none; b=MyM4OgL7ixWQb7sNY28iykdWDtG+MNJPx8jHjq64Alu8Heu9o4TkBTyMC2zLMXu5f/CLz4uNgzZXoIFigQQrbUXnHZXdVuzMtcK1SU2+GLQ3QaTZxvaDw9fafcipwVS4U/GmI5M5dLlQK8Acc50d061lkQN7/oj6meY19r86hYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762462787; c=relaxed/simple;
	bh=IC0x0oZUh4X2mLDEyPdhQd0SMBfCZdh7lBBnf0a64+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XC9kWsY4HgeWgeDIli0D4QnYylKxFE9bUvraDVrbxIqFhZl4utVhaKpE4oRz8WNdNojL6d7z5SgShWNpDNPIDkLRtERphVpA6+XFIfKbvzSjTZcho31DhwJ40172ipRSAz/PeUiNcDwBqe1FmEw+FyBXITiYJDXzt2r4Qwrs+y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosa.ru; spf=pass smtp.mailfrom=rosa.ru; dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b=a8gVwRda; arc=none smtp.client-ip=178.154.239.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosa.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosa.ru
Received: from mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:ec27:0:640:5ac1:0])
	by forward100b.mail.yandex.net (Yandex) with ESMTPS id 7738D806DA;
	Thu, 06 Nov 2025 23:59:32 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id SxtU1pGLB8c0-00FU0989;
	Thu, 06 Nov 2025 23:59:31 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosa.ru; s=mail;
	t=1762462771; bh=I+5fGidXHttPZIAH5EDKfTztWLspei5KA1OZ0w7FGW0=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=a8gVwRdaYw2G7dQAosh0BHR1bg3IcXH6JpVIzYthGWR12rL7v86A2EPtRFm0VkSt0
	 OQLoKub+R9qK7FmQxVzPwpPdAjIxKTCWlssGbVpVoDflFtnH54kyZCOUD59AlVqvYs
	 ELs0u5fSgC7nFXcroRBVQX5x4Y5sSey3x9SuCnH8=
Authentication-Results: mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net; dkim=pass header.i=@rosa.ru
From: Alexei Safin <a.safin@rosa.ru>
To: Alexei Starovoitov <ast@kernel.org>
Cc: Alexei Safin <a.safin@rosa.ru>,
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
	Jiri Olsa <jolsa@kernel.org>,
	Yafang Shao <laoar.shao@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-patches@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] bpf: hashtab: fix 32-bit overflow in memory usage calculation
Date: Thu,  6 Nov 2025 23:58:44 +0300
Message-ID: <20251106205852.45511-1-a.safin@rosa.ru>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The intermediate product value_size * num_possible_cpus() is evaluated
in 32-bit arithmetic and only then promoted to 64 bits. On systems with
large value_size and many possible CPUs this can overflow and lead to
an underestimated memory usage.

Cast value_size to u64 before multiplying.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 304849a27b34 ("bpf: hashtab memory usage")
Cc: stable@vger.kernel.org
Signed-off-by: Alexei Safin <a.safin@rosa.ru>
---
 kernel/bpf/hashtab.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 570e2f723144..7ad6b5137ba1 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -2269,7 +2269,7 @@ static u64 htab_map_mem_usage(const struct bpf_map *map)
 		usage += htab->elem_size * num_entries;
 
 		if (percpu)
-			usage += value_size * num_possible_cpus() * num_entries;
+			usage += (u64)value_size * num_possible_cpus() * num_entries;
 		else if (!lru)
 			usage += sizeof(struct htab_elem *) * num_possible_cpus();
 	} else {
@@ -2281,7 +2281,7 @@ static u64 htab_map_mem_usage(const struct bpf_map *map)
 		usage += (htab->elem_size + LLIST_NODE_SZ) * num_entries;
 		if (percpu) {
 			usage += (LLIST_NODE_SZ + sizeof(void *)) * num_entries;
-			usage += value_size * num_possible_cpus() * num_entries;
+			usage += (u64)value_size * num_possible_cpus() * num_entries;
 		}
 	}
 	return usage;
-- 
2.50.1 (Apple Git-155)


