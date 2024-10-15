Return-Path: <bpf+bounces-42042-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F07999F03B
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 16:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44AF31F22BFA
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 14:55:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33AA1DD0F0;
	Tue, 15 Oct 2024 14:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NwtQN7mr"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB361CBEB8;
	Tue, 15 Oct 2024 14:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729004059; cv=none; b=TL6YAw7auAp+goOMJJ3umu1f8F7GRSt1QTkNbOEu7BB6oLoFmWEL65KAaRwl0Bors2Fk+e2CAeA0/fee0/AhIlT8L+qACQu1ER7+osynVF2Eyinn8pzeifcpJCs4/VP+iAz7tf7T8xPKfbtAwloaZYMOapiykvhUfprVnjSSjlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729004059; c=relaxed/simple;
	bh=tQu14JwbxzrPa5a9MiLdxfRNOKo0ysvLK8e1crTNaM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YnJ1D4TS1Cyjb6oWLRtFwxsz6nQec2DGvypk+qMMwgebwnYob15NiXVzqgEL7m3rAZcYRlkSHl1KJ4xm09TLGAzhlKAyo+6B+iaBp9It6mkvLw9m40RbLgiIRKempDSvt5U898H9BceAVyn4u4nAXCKgHNTmlzSY+MzlW1+zfPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NwtQN7mr; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729004058; x=1760540058;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tQu14JwbxzrPa5a9MiLdxfRNOKo0ysvLK8e1crTNaM4=;
  b=NwtQN7mr8OcoqX7nPAGrQQ7cPh8M/xZyA3Vha6OOnf4SuUKbFAkCuE0o
   /jmF1DKL/vtj4ZLITt/THA0bp8/4BDhREZkTZkbtpzpXlvvAhatukOtJV
   ZtJNQYaeJqA+BdyFS2EgOshGLY84bORl+QNAoaV8oYEUDiWDcRqoBojD7
   FbL1kpacpnf5cAZvLgJ7/dWJC0m1NRoDdV/O2Bp9vriTpk7+DL30+oSSP
   g+MYgQhxtrKGw3iMg12DbhE1YZfswnTzjYZiz+iMMRXvJhBEh0zQGKz6n
   ByIrPbcrgaxUmLOS5ONiJrQBt03Xw3hqhCiFo4mRdq/HKHs658cGFNbM3
   g==;
X-CSE-ConnectionGUID: +5ElF/74R2Ku+ISnrQ2dsg==
X-CSE-MsgGUID: RcG1Yft/Q2aJW/w7t3POng==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="31277451"
X-IronPort-AV: E=Sophos;i="6.11,205,1725346800"; 
   d="scan'208";a="31277451"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 07:54:17 -0700
X-CSE-ConnectionGUID: Xv/sdtDIR22mAnGjwVE/0A==
X-CSE-MsgGUID: 8SkuyX2NTaiTLyZjgBmwVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="82723031"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa003.jf.intel.com with ESMTP; 15 Oct 2024 07:54:14 -0700
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
Subject: [PATCH net-next v2 01/18] jump_label: export static_key_slow_{inc,dec}_cpuslocked()
Date: Tue, 15 Oct 2024 16:53:33 +0200
Message-ID: <20241015145350.4077765-2-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241015145350.4077765-1-aleksander.lobakin@intel.com>
References: <20241015145350.4077765-1-aleksander.lobakin@intel.com>
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


