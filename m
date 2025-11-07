Return-Path: <bpf+bounces-73948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D03D5C3F59B
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 11:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AAE23B4303
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 10:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08D93002DB;
	Fri,  7 Nov 2025 10:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b="PwZDXpXG"
X-Original-To: bpf@vger.kernel.org
Received: from forward203b.mail.yandex.net (forward203b.mail.yandex.net [178.154.239.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455EC30274F;
	Fri,  7 Nov 2025 10:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762510239; cv=none; b=dgdchcpEtDPHSclCzmRLnpuuEngDj1g2gYEHJPrvj1Yo0ChagXR9hYElJs07K9arF63svZX8VWp1euBpck566xmsfB6un/nhsfeq1PB4QOSh6ShdgQmv8YsZtDhcaE+ueBSLxRWN0u8PDxWwXIy1lqiHExTLncCVuS1ueqPhKpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762510239; c=relaxed/simple;
	bh=jFKc+wX+ajbmLFnPFexfoBdwC+jpUnLEIVN4MhArpzw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f15Tjlt3GTvqlprB0ZkMahoilZOwNgyJjy8VCa1OhDmOxI0U6FDDDqu8GLXivlIYg5rki7L63cgPJsci+pseUBzF696F5WZ1Eef65P4ZC0EyoYU+lIlcKnCAwM4EpRTeJSMcEZqF+yYLmeJmu6hsLIdIiOHzGeKiVtZTlCLDhT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosa.ru; spf=pass smtp.mailfrom=rosa.ru; dkim=pass (1024-bit key) header.d=rosa.ru header.i=@rosa.ru header.b=PwZDXpXG; arc=none smtp.client-ip=178.154.239.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosa.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosa.ru
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d103])
	by forward203b.mail.yandex.net (Yandex) with ESMTPS id 3DF428290F;
	Fri, 07 Nov 2025 13:03:26 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-67.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-67.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:143b:0:640:90e9:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTPS id C262CC007D;
	Fri, 07 Nov 2025 13:03:17 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-67.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id F3kLtoNLMGk0-vm03Z50E;
	Fri, 07 Nov 2025 13:03:17 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosa.ru; s=mail;
	t=1762509797; bh=nHlNLT0QT67+z+JXyBHWIaWjzREiUAJawLJmZUp+LLU=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=PwZDXpXG6ULisdhVt9HRXFLjm+XGD3piTSYHHZUEMjnSnl+DKGnAnNXZM4uQOwHCF
	 XlJRAEiTImJALNeoZsC7T83z1bKcnSZi+GYI4s3QkU+RaG3MVT6hvTiGoyonwqEhQA
	 cGwr3i/RXnFQ7mTV5w+v11lJrKsx9YnoyzqRljfA=
Authentication-Results: mail-nwsmtp-smtp-production-main-67.sas.yp-c.yandex.net; dkim=pass header.i=@rosa.ru
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
Subject: [PATCH v2] bpf: hashtab: fix 32-bit overflow in memory usage calculation
Date: Fri,  7 Nov 2025 13:03:05 +0300
Message-ID: <20251107100310.61478-1-a.safin@rosa.ru>
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

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 304849a27b34 ("bpf: hashtab memory usage")
Cc: stable@vger.kernel.org
Suggested-by: Yafang Shao <laoar.shao@gmail.com>
Signed-off-by: Alexei Safin <a.safin@rosa.ru>
---
v2: Promote value_size to u64 at declaration to avoid 32-bit overflow
in all arithmetic using this variable (suggested by Yafang Shao)
 kernel/bpf/hashtab.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 570e2f723144..1f0add26ba3f 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -2252,7 +2252,7 @@ static long bpf_for_each_hash_elem(struct bpf_map *map, bpf_callback_t callback_
 static u64 htab_map_mem_usage(const struct bpf_map *map)
 {
 	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
-	u32 value_size = round_up(htab->map.value_size, 8);
+	u64 value_size = round_up(htab->map.value_size, 8);
 	bool prealloc = htab_is_prealloc(htab);
 	bool percpu = htab_is_percpu(htab);
 	bool lru = htab_is_lru(htab);
-- 
2.50.1 (Apple Git-155)


