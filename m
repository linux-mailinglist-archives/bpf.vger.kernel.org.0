Return-Path: <bpf+bounces-46659-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F849ED3A8
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 18:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15DDA1612F7
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2024 17:32:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB1462288C4;
	Wed, 11 Dec 2024 17:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Th4KcVtw"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EAE225A5E;
	Wed, 11 Dec 2024 17:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733938172; cv=none; b=etW3v+sXKbHYIqgSeYefPhWOpoV1lHg3p+HcU+bo96ue4JmPMjt/8TgdOVxk8SRBWu+fPrh//KWVq5Kc6CyfAPtEjPenHckc5pujeSKatNnVfsWvSMzpepDfS1+AxmybycfWgHOD4KMQ6Z1ThoWUTm60qu55wD4E5Pl9PfvnfG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733938172; c=relaxed/simple;
	bh=Hj3Ed674/goNpKUME1dgCcKm75c46TNcR4upTjpWwA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rQ3O8hb/HURoCXnM1ryCaOkNzMNJgVHGMaKLrrYdo/CqVo0mba4TLrkNlLil13mBlbj8qkO3MVGdxgu0YpeWK1nAQHphjGrF8dSRy0jz6Ktx36ITnToOqDS/oeZARdjVENx+NIM46SXuMDKsKrl2Kb/+ynQGAIt5xhSfGfV86V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Th4KcVtw; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733938171; x=1765474171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hj3Ed674/goNpKUME1dgCcKm75c46TNcR4upTjpWwA0=;
  b=Th4KcVtwo/8e9IMWcuQKNp2Tdl3xx13lXbDZ1WlMDqoxSJGSTM1IBJno
   aE6pU+C5y1Q491Qh1tyGszTwUXm2xyiqmRj2M5amXEEXuns5MlKAwEbmu
   x/tobPWDu1zzLh5knhZF7hNrqctJCI198D84fYd06DuvoVbCqqzCR3rMV
   uGOoBMGTXPUHhbU5Od+gVkFIgy/g+3DpmdjY7oxUjtY9J1VOBnI3+ASo0
   KeZ/AeW9zKr8PDWpaSwS+RTFyzw4YbKessih6VhLLAO9TFisdiPRdSSS5
   x8bkQ8dxjq9RSXECUuG7SZ5yhz5goPgAT0ZLM9rgeCLSoXQ5ObydugQZv
   A==;
X-CSE-ConnectionGUID: ga23n61zRfWxkmqBEgdt7w==
X-CSE-MsgGUID: 81gyF54vRUir+zO2oLLDrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="51859702"
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="51859702"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 09:29:31 -0800
X-CSE-ConnectionGUID: sUUIA7wTTtWK1/4hzW7Z1Q==
X-CSE-MsgGUID: IKjM3BetSHOby7BRvbWF3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119122405"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa002.fm.intel.com with ESMTP; 11 Dec 2024 09:29:26 -0800
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	"Jose E. Marchesi" <jose.marchesi@oracle.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jason Baron <jbaron@akamai.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Nathan Chancellor <nathan@kernel.org>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 11/12] jump_label: export static_key_slow_{inc,dec}_cpuslocked()
Date: Wed, 11 Dec 2024 18:26:48 +0100
Message-ID: <20241211172649.761483-12-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211172649.761483-1-aleksander.lobakin@intel.com>
References: <20241211172649.761483-1-aleksander.lobakin@intel.com>
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
2.47.1


