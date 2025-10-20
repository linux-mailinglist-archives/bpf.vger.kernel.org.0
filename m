Return-Path: <bpf+bounces-71427-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1766EBF2820
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 18:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ABAD4254FE
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 16:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95B232F75B;
	Mon, 20 Oct 2025 16:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nDiye4FY"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C412330320
	for <bpf@vger.kernel.org>; Mon, 20 Oct 2025 16:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760978810; cv=none; b=Q4wEUQ6LjCKQ8T/kG23zzvIEY4QFlxiqADZ04Y9T5rvAWtUvOEBK+ddUbzYHjT1BNXV9lclrqQQgAl/Xa0m4zLDph2GborRq6n+o6M7YscvgdYK2JteUJwuhw0bQTB+f99tdFnUhVWQyjnz8KdYRjpCJKzvwAxPos+L4reC47YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760978810; c=relaxed/simple;
	bh=aePpf2hEql1qfdG3M5ylZaVHF0AGBqfwF+1CHFlgt6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GjzNrgUtPsnc5JIyIhUFX9krFHPPPP2GOSVwBXPK9wiN5S0ocLi1jMiPV3SADfUlWNXdTuJ2mvDSBm54B7tz5stP8f8YBKwENvwqATgSyGMrUMYpOQo5wgbBPqaNkNaGWJw+QRhzsJJU6En8Mq4p++UlYZ/UNLdjx6jFIMQSr94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nDiye4FY; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760978806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JEyL06pmQ86osgNWjo4Zb1J+CW0SUTbpdgIL0oBMIEE=;
	b=nDiye4FYbJB03BthBlTXPaV/oZeta74ZUU+b5zq1vYXDOQJFICAAM61oR6by55aLu9lvcK
	V96Gk4T7K8E9CjqhWf8EGbGwplf9kzY2ONn+0QHk6EJGkIjoM1iBq/7BTD1PtcpnXiYWj8
	JeRQQOxPLUWRQCe+NTf4DmIzKSgaGCI=
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
	linux-kernel@vger.kernel.org,
	kernel-patches-bot@fb.com,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH bpf v2 3/4] bpf: Fix possible memleak when updating local storage maps with BPF_F_LOCK
Date: Tue, 21 Oct 2025 00:46:07 +0800
Message-ID: <20251020164608.20536-4-leon.hwang@linux.dev>
In-Reply-To: <20251020164608.20536-1-leon.hwang@linux.dev>
References: <20251020164608.20536-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When updating local storage maps with BPF_F_LOCK, the special fields
were not freed after being replaced. This could cause memory referenced
by BPF_KPTR_{REF,PERCPU} fields to leak.

Fix this by calling 'bpf_obj_free_fields()' after
'copy_map_value_locked()' to properly release the old fields.

Fixes: 9db44fdd8105 ("bpf: Support kptrs in local storage maps")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/bpf_local_storage.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index b931fbceb54da..2b7bd47e99b33 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -609,6 +609,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 		if (old_sdata && selem_linked_to_storage_lockless(SELEM(old_sdata))) {
 			copy_map_value_locked(&smap->map, old_sdata->data,
 					      value, false);
+			bpf_obj_free_fields(smap->map.record, old_sdata->data);
 			return old_sdata;
 		}
 	}
-- 
2.51.0


