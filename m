Return-Path: <bpf+bounces-47207-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F6F9F6151
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 10:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8FC216E59C
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 09:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901D9198832;
	Wed, 18 Dec 2024 09:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lUFjBl3x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324521791F4
	for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 09:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734513734; cv=none; b=Xag0+SqvFUNThXr44/NDIN1pwHJTgGxwL+IpYfVx7FAi769MgzB3eMf0ntWHRp9hAYYR464QpBRRVjpTal6tUu9P+bzLvkVdkABRE7qLPqfahIXHfqFsyRHpHqz895iXef2L9LZi7jJBic871muz6XghteW7geLl4rVg+ofZh/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734513734; c=relaxed/simple;
	bh=+ElhvGiUetQc4q2/5i2efag4ASEObRIagrofGaWgaXI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XZe+yKLeHHYv7Nq8LWO4GH1QwHp9zSLOWdSnyqicP0b9T72M1FrJDqBDAw6403ny9ltcUaCwUAl2G4QGIf1mek8VT2hcrag8NycnkQIWYm6NeOK9nQ53ANiiDuBoDDCf1wW7kXPwtUv+DntxA/ToWUHvrH2VzDl5xByCWr6kUZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lUFjBl3x; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-216513f8104so6801425ad.2
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 01:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734513730; x=1735118530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+GHC0slKrgRif7a/VpJz05Ag7qSUEAL8d6DxebxYJI4=;
        b=lUFjBl3xc3nKsRA6tIoFH82nmMswUx0sOnoErHQxHZikv7k9MqXTrABy4wnQLJuUTC
         mCtTbwLJiFMWbnNbPfLCqJpdE4GSAGMhWGpvBJZVrXr9vcU7zRjSzs8V5PEUSSVpwD9B
         ILA4CkKz2Yew7sOQNmZhqCtwQMqvCetPaPxIJ7wdryN08zb7V4YYLJVDV82yeDubpHfl
         NAhaSo/ZjGFieVJsofjpWyqHOpSzk4lQk0tpdo6U8abrIhiZjVpsZVdBCepkLjE48ONK
         VI0QRRLhGNBAe0ACdzBASqXUwMQIKmxDX7xlDZNtFBGlh7UiH2Q4Atd8t8BDNIK3DQKm
         /e+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734513730; x=1735118530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+GHC0slKrgRif7a/VpJz05Ag7qSUEAL8d6DxebxYJI4=;
        b=G/dYRVvcMRESjJrz5woUdl7aCsA5OZEI3PZ/5JAmcADkgdPyR08/8W39jC8JgYclB8
         y0xoedhMCUcMy6wR9IVQJd0t7cS4djnf7hqsNhx3Kem8vXp2gUXJS7/6zoha/apQ15Bd
         Cx60qErBm46qGNprr0DrbZxHkJWDCycgjIm9QDY9rKaE8w5izYmEku+y9hq6hzz1tr9C
         y56YLgrd93YxsWDWT2V5BZHvnUspTDU95xVnoLSNgvZlzn9YzwWkyFnnes6WvkXeBsng
         sXqtXAii+B27Ck7B/Dwi7SmS2xUgGHo84thypuXfjEDlA/zQh+/G82uKt9528GIfcTYX
         v2yw==
X-Forwarded-Encrypted: i=1; AJvYcCWejIRiBIKXY+mtjs/050XrWT8KxzXp8Yzmy+i+lDLFx+uQqKlGbxgG+k6/cO5rAuB0NBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVT27jMkWtUDZWAytJuFE5Fp1vnSEoNsZgQWT+IM72PYQay8NA
	KA1bi15IOrj0xBPNE0LSzf9OL3CePGsNQ5l6hHTck9bYJNEXR4Vl+oP07t0BRKNHcWNsamY1txj
	H
X-Gm-Gg: ASbGncvylU2DQR68gBRJ/xOlKAtgif/rS42IeN1MQsIKpd/p51zmocLzCr5qeSludtC
	qIwwTDAVGV52hBmWszpHABEZ3ysu78FVNVDAU8Cz3nfFJ6YahSj8XJkWN6pkur3oRgN7wHVNFi3
	hpfn2lPF7NOvUbkqcsHFPpqBhMzG05iiNDHcetfKqWDf0CGrJeQRKpALzvss/AbJENAmAf7vz0s
	Lp5m/4C0XOTNMvA3BsRK/9K1RWz7g8q+ITWNRu15ffwkpqFQWafwPlyB/+qdMeKmaKDJd9hd2uI
	h+sK1Joh68ri4NP1ok8=
X-Google-Smtp-Source: AGHT+IFnfp6EZGGCUDI9TUuZfeHO0MijI/IFSSu0PBKWbyreWRmHmLB+0KLP66J/XDvmE9LS5YNTAg==
X-Received: by 2002:a17:903:41ca:b0:212:b2b:6f0d with SMTP id d9443c01a7336-218d6c4aaf8mr11768495ad.0.1734513730531;
        Wed, 18 Dec 2024 01:22:10 -0800 (PST)
Received: from C02DV8HUMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2eda27344sm909682a91.34.2024.12.18.01.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 01:22:09 -0800 (PST)
From: Abel Wu <wuyun.abel@bytedance.com>
To: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	David Vernet <void@manifault.com>
Cc: Abel Wu <wuyun.abel@bytedance.com>,
	bpf@vger.kernel.org (open list:BPF [STORAGE & CGROUPS]),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH bpf] bpf: Fix deadlock when freeing cgroup storage
Date: Wed, 18 Dec 2024 17:21:48 +0800
Message-Id: <20241218092149.42339-1-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following commit
bc235cdb423a ("bpf: Prevent deadlock from recursive bpf_task_storage_[get|delete]")
first introduced deadlock prevention for fentry/fexit programs attaching
on bpf_task_storage helpers. That commit also employed the logic in map
free path in its v6 version.

Later bpf_cgrp_storage was first introduced in
c4bcfb38a95e ("bpf: Implement cgroup storage available to non-cgroup-attached bpf progs")
which faces the same issue as bpf_task_storage, instead of its busy
counter, NULL was passed to bpf_local_storage_map_free() which opened
a window to cause deadlock:

	<TASK>
	_raw_spin_lock_irqsave+0x3d/0x50
	bpf_local_storage_update+0xd1/0x460
	bpf_cgrp_storage_get+0x109/0x130
	bpf_prog_72026450ec387477_cgrp_ptr+0x38/0x5e
	bpf_trace_run1+0x84/0x100
	cgroup_storage_ptr+0x4c/0x60
	bpf_selem_unlink_storage_nolock.constprop.0+0x135/0x160
	bpf_selem_unlink_storage+0x6f/0x110
	bpf_local_storage_map_free+0xa2/0x110
	bpf_map_free_deferred+0x5b/0x90
	process_one_work+0x17c/0x390
	worker_thread+0x251/0x360
	kthread+0xd2/0x100
	ret_from_fork+0x34/0x50
	ret_from_fork_asm+0x1a/0x30
	</TASK>

	[ Since the verifier treats 'void *' as scalar which
	  prevents me from getting a pointer to 'struct cgroup *',
	  I added a raw tracepoint in cgroup_storage_ptr() to
	  help reproducing this issue. ]

Although it is tricky to reproduce, the risk of deadlock exists and
worthy of a fix, by passing its busy counter to the free procedure so
it can be properly incremented before storage/smap locking.

Fixes: c4bcfb38a95e ("bpf: Implement cgroup storage available to non-cgroup-attached bpf progs")
Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 kernel/bpf/bpf_cgrp_storage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index 20f05de92e9c..7996fcea3755 100644
--- a/kernel/bpf/bpf_cgrp_storage.c
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -154,7 +154,7 @@ static struct bpf_map *cgroup_storage_map_alloc(union bpf_attr *attr)
 
 static void cgroup_storage_map_free(struct bpf_map *map)
 {
-	bpf_local_storage_map_free(map, &cgroup_cache, NULL);
+	bpf_local_storage_map_free(map, &cgroup_cache, &bpf_cgrp_storage_busy);
 }
 
 /* *gfp_flags* is a hidden argument provided by the verifier */
-- 
2.37.3


