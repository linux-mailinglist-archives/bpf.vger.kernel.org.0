Return-Path: <bpf+bounces-73037-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 191D1C20EAA
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 16:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42537462AE8
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 15:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 385B1363B89;
	Thu, 30 Oct 2025 15:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rkPTnvfB"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280DC363377
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 15:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761837946; cv=none; b=QMZln65ECAC72vOH0soCN7Lgt5h5O9lvcVMUzqG3cDBe2LWNM7rOzq0XwRnX3MLbRhM/k20F2XMNSoL8wn+oe1tKM04RNVFuBfx1UeSCsTA6E9esaJZ4NESzYqsdLr8SvWh9jvTltfmpRAuMtSsLp0c2m8C8dRxRhtzvHDwNS6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761837946; c=relaxed/simple;
	bh=C1VYz5QuVV63H7XNPupCntSTAeRkeenISLIRXxOgMNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iYVjIzYjuPvkv+K7CF2kUaxmKZC8qtuFENDYhD5Syp2LPUxjYn13jJUJ1UcCUYNEr1mwEEIT44GIDA8olxhnwZIq8PuvSeE35MBA6alUki/c8HjV8j9dhkmQ3LOk8IOAcRGdhlbof6FbAMvNFYk9gtkS8tF2ItocfnEwL904WFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rkPTnvfB; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761837943;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZREJDifRPsmjHO+i1eo1SrExYnnJEjUJF7OJxIRlEuQ=;
	b=rkPTnvfBfMhAces2LgaFJDOLgHIQ7RUYmPAue1jMXv8YcPwDxWxUb3iQu04o4Lt385OuDr
	9HaVJhWBhxXGBYrTtI9UfONq34UvhIGFK1HDHFkhGdK8zp932dkrlb0QMrd12cHqeI3vjf
	hWyWglnkr54TAGsAu0BXmkc67JWquLU=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	memxor@gmail.com,
	ameryhung@gmail.com,
	linux-kernel@vger.kernel.org,
	kernel-patches-bot@fb.com,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH bpf-next v4 2/4] bpf: Free special fields when update hash maps with BPF_F_LOCK
Date: Thu, 30 Oct 2025 23:24:49 +0800
Message-ID: <20251030152451.62778-3-leon.hwang@linux.dev>
In-Reply-To: <20251030152451.62778-1-leon.hwang@linux.dev>
References: <20251030152451.62778-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When updating hash maps with BPF_F_LOCK, the special fields were not
freed after being replaced. This could cause memory referenced by
BPF_KPTR_{REF,PERCPU} fields to be held until the map gets freed.

Fix this by calling 'check_and_free_fields()' after
'copy_map_value_locked()' to properly release the old fields.

Fixes: 14a324f6a67e ("bpf: Wire up freeing of referenced kptr")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/hashtab.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 3861f28a6be81..fc3c7ede3cd0c 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1110,6 +1110,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 			copy_map_value_locked(map,
 					      htab_elem_value(l_old, key_size),
 					      value, false);
+			check_and_free_fields(htab, l_old);
 			return 0;
 		}
 		/* fall through, grab the bucket lock and lookup again.
@@ -1138,6 +1139,7 @@ static long htab_map_update_elem(struct bpf_map *map, void *key, void *value,
 		copy_map_value_locked(map,
 				      htab_elem_value(l_old, key_size),
 				      value, false);
+		check_and_free_fields(htab, l_old);
 		ret = 0;
 		goto err;
 	}
-- 
2.51.1


