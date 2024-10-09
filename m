Return-Path: <bpf+bounces-41420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E054A996FE3
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 17:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A519128263B
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 15:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA0B1E25E2;
	Wed,  9 Oct 2024 15:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i++jiO4J"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A77B1E0DC8;
	Wed,  9 Oct 2024 15:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728487721; cv=none; b=JRLdYojqSFZSXWaHeG1cykQRefdLFM2q7I8GH0uAGiNXf6aAkicj0dUDLYkLxrMRy1ij/FraWqg9tARxkjjV7zKwh+hdL36CXMuHMYrugPf9McYuT5/NdC/jLnmah02DlTCnVNWuRL7dLSuWCAv3Y7c16jUsQg0nHLuJxY48O9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728487721; c=relaxed/simple;
	bh=tQu14JwbxzrPa5a9MiLdxfRNOKo0ysvLK8e1crTNaM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gEMIH1E7r66PTQV3EM4ZJZsXmvdIWTGPXcKL1L0K+OB1A6weqLu1hyUohR3DSCn1sD+0808im0qCt6V9tDZtsPctwVDjIcN/PqZJOBnK9IWK2XWkSLf6sHjXPK/XHs7c0bgYUaTV4BLK4rhOs/v84vJkIXoGfCQgMknb3tihcZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i++jiO4J; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728487720; x=1760023720;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tQu14JwbxzrPa5a9MiLdxfRNOKo0ysvLK8e1crTNaM4=;
  b=i++jiO4J9IyQ+bJTK2X29tZI0TjGoiIMp8Ezx+aEcpkeHFc7zFZCfwk0
   HRvgU15Z24ahr2S3IWuTAjH9laOyLrbqXteGpVz2PaYCPqW9mSq+Z8Mii
   QkcNCLV+NtpVc/zNt1owdPRqsT6o6+Yk2y0pW6oNhrx9OhDY8w6rzoRBw
   WPC8sN+BiBnn8YOF6qb6D8YouQsk5Z5PE//u2ZdK4Y3R8zS2Wja2vthS6
   FYljohBgVsEWMZjhr8unTMEEhN/WETpdgF96Zkj6soNUNIHsQZxgnm7kd
   9z7Af46r3q8ODK7XwSUQzfEGgQvZ/nyKz0nqzT/wfVCrMPgNVwp6r2Lzv
   w==;
X-CSE-ConnectionGUID: lRi171qmRYKWwmgP99zCeQ==
X-CSE-MsgGUID: 5PrW0w9ZRFKpPj8j86WKnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="27675678"
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="27675678"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 08:28:39 -0700
X-CSE-ConnectionGUID: D26v3ednTOyimH8wwB7F8Q==
X-CSE-MsgGUID: DqqnZYu/SYuTNbw7Xw0amQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,190,1725346800"; 
   d="scan'208";a="81305765"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa004.jf.intel.com with ESMTP; 09 Oct 2024 08:28:36 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 01/18] jump_label: export static_key_slow_{inc,dec}_cpuslocked()
Date: Wed,  9 Oct 2024 17:27:39 +0200
Message-ID: <20241009152756.3113697-2-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241009152756.3113697-1-aleksander.lobakin@intel.com>
References: <20241009152756.3113697-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sometimes, there's a need to modify a lot of static keys or modify the
same key multiple times in a loop. In that case, it seems more optimal
to lock cpu_read_lock once and then call _cpuslocked() variants.
The enable/disable functions are already exported, the refcounted
counterparts however are not. Fix that to allow modules to save some
cycles.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 kernel/jump_label.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 93a822d3c468..1034c0348995 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -182,6 +182,7 @@ bool static_key_slow_inc_cpuslocked(struct static_key *key)
 	}
 	return true;
 }
+EXPORT_SYMBOL_GPL(static_key_slow_inc_cpuslocked);
 
 bool static_key_slow_inc(struct static_key *key)
 {
@@ -342,6 +343,7 @@ void static_key_slow_dec_cpuslocked(struct static_key *key)
 	STATIC_KEY_CHECK_USE(key);
 	__static_key_slow_dec_cpuslocked(key);
 }
+EXPORT_SYMBOL_GPL(static_key_slow_dec_cpuslocked);
 
 void __static_key_slow_dec_deferred(struct static_key *key,
 				    struct delayed_work *work,
-- 
2.46.2


