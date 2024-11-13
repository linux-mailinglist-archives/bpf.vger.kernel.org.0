Return-Path: <bpf+bounces-44756-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7864F9C7701
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 16:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E2DE2885E0
	for <lists+bpf@lfdr.de>; Wed, 13 Nov 2024 15:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04698200CA7;
	Wed, 13 Nov 2024 15:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uyc45The"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9762159583;
	Wed, 13 Nov 2024 15:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731511506; cv=none; b=SG8DHC9BhioxTxFNoEOwYZyvnpt/6PzCom7N5stgxZ4xnCu4F76EDKKt1BCpHnYmTVXzVaS9r8/EZcz5j3P81jBEvTp0u7Di//HItIqBwD40tUylD8Btwi/afDi2jZt+bh+xC3mLUGRJtkZpFUwIWzR6qOW8avC2E1CEjPzMvhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731511506; c=relaxed/simple;
	bh=4IC24vmZl6WDvgMu457OvjBdl317Y6deaK2gkmSPzBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lxWUfRWdpqtDPILmrfGgglSN638gGZQTYWgmx3T17Yx3dRl2P3RVCUAMFwc6rMguoLdxtnk12e0YUtL5C20gLEHt704X24J2f9z61CXMdey1J2C//twTMNVoPnEbhwIf01zwENkPuxyOg8J5CA6kvSxZKJIfPFcaQQFzKhvosIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uyc45The; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731511505; x=1763047505;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4IC24vmZl6WDvgMu457OvjBdl317Y6deaK2gkmSPzBk=;
  b=Uyc45Theof+x41Y5Y1MoVxUnSndbivaQ1/jovdN+Gu3WeDTfKgXle3dn
   cM4C50gwVcmybYZyB+VumPS2ecJWuhOYj0JZLtowk0SrOzZIdrS4z/FN2
   WYS3AovgOYga0jWL5BRR+7msFlCICz0r0MpSWP+hbFRh5TLk7tfKIhJKf
   ecLKbayLha2g2vsaY1vIjzXcIqIQlMHOkTJ9jf+2gxh6JLwZmrCqOcRxY
   J0AuvRuECQUTWl9kJgBex7vZrP5/HWNDlKWTMmGuRpqLYgBYUJMaF0Bdo
   7P0i0ikBKR+QVHHsBNsABC8+Bp4+8WBf3qsoBAKeOGn1pujdMwAhyZrur
   A==;
X-CSE-ConnectionGUID: 3z4KuQhZRrCNOThV9wX8Kg==
X-CSE-MsgGUID: 7RF4IRcSTKC5JYJnP/uY+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="42799232"
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="42799232"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 07:25:04 -0800
X-CSE-ConnectionGUID: zwNAkJ6QQ46M3oyxm5WcLA==
X-CSE-MsgGUID: DRwNa1nHTsuGjxmqrXvlMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="118726824"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa002.jf.intel.com with ESMTP; 13 Nov 2024 07:25:01 -0800
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
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 01/19] jump_label: export static_key_slow_{inc,dec}_cpuslocked()
Date: Wed, 13 Nov 2024 16:24:24 +0100
Message-ID: <20241113152442.4000468-2-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241113152442.4000468-1-aleksander.lobakin@intel.com>
References: <20241113152442.4000468-1-aleksander.lobakin@intel.com>
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
2.47.0


