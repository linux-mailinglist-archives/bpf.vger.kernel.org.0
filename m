Return-Path: <bpf+bounces-68304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8C5B562CC
	for <lists+bpf@lfdr.de>; Sat, 13 Sep 2025 21:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00F1D1B2325A
	for <lists+bpf@lfdr.de>; Sat, 13 Sep 2025 19:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF57259CBF;
	Sat, 13 Sep 2025 19:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G+mwjLYe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B57258EE1
	for <bpf@vger.kernel.org>; Sat, 13 Sep 2025 19:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757792033; cv=none; b=iaQxS1vrCEOeAngcBuufH6BLTzULqiWtVKkn2tUGouG1m1aWXz86Pqvo7rATUtMd0x7J4lfTK4JgPZTAAxobAZlg5QQpaBXMD0vMx/F6yXsnAmIwk54idqfh2dGZ2taGc+q/7Cg5BSeK6vCzFWshc30y0oXJeitaNjCUzrMTMgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757792033; c=relaxed/simple;
	bh=HihYLs2gIxnLftGd/1/oW3vzu2WhlYnPlcrAY6ztk+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OQj56AWVERnqYiveKG8ZVO1ePhwjo+zKkSbw0ap/+/X1ITm9ze/VVUzD6l70VdTT6cP4vMMjm8EtlPlzq+JydRXXy55vBjfp7ARaGE3bAA2C0o14U9OUMB8vsZE/tAhfUTB2eAbpec+WdrBWmmVeVinndGgHjFTr5f3S/auq/nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G+mwjLYe; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3e7643b0ab4so1974666f8f.2
        for <bpf@vger.kernel.org>; Sat, 13 Sep 2025 12:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757792030; x=1758396830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oY2NlcjLIHdh6oV54v02TaMgAkrON+dzvBXsgSYx/qI=;
        b=G+mwjLYelH/RnVl03cv8l6WMqIoJMYPkjlztNAD3mQBCYqZpJ0z/EFVVZKgYjogSHZ
         ba1QwcGXOQ7K91hU25q7BwQ2KgPIzcMq4Pw6r6dVbSlMOaA31Q72W65LYU9sz3NMOe72
         bDqhu1naANi9xzfOKFaLx1V9My0C+uNsnLDhj1g1U5ye5K+Qm28huTwGKbUJYVW4Lq38
         yHNP59h6zvkW5oQ6gKa/u5ofmjUmfZd3t9D4G5w9pIpYHWCuI9jEPVFH34gyT/3L0t+a
         06wEr4mB7npTDmRqnCTjMHyF/I2tLqEzfFd3MVmb/vCqHh39edM3TncTKqJHxv/jLw/h
         CI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757792030; x=1758396830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oY2NlcjLIHdh6oV54v02TaMgAkrON+dzvBXsgSYx/qI=;
        b=BKQd6juyHkKueNXZileIgg4UF7WqTi9vnDUow7j5X58CcyvvX+E82J2CGFbV2GKpvk
         2UYsS+OOzbdQCtXeishx8/fPCePQggfrw59No6U/5k4zhTAO9+wwOt43Njn8v0ADcYbM
         ZEOrE2PbAoAHotXrIXopREk7SI6cHIzZN5VkID4xLM64aLBGN/aoex3ocwS9rPn0Iw/J
         1L66ugmGzpu60/q0vxoZXWVFz0JtQKKKVlfkdIvq+/oyXPeIzTrX4Jd+lH5qGjAL0pK5
         bjMRzTpq+OxhCWMGQtSWhHtgKvyCjFj8iS5OqxR4glvmcqIsTXjxTCAoXwD5rBwUCHAj
         QoNg==
X-Gm-Message-State: AOJu0YyDCtgt9f5Fm8rRF4xmUyqfXWgDSAMVm2pXKfn+fruK2mpSi2Zl
	1QsjGXXodXATevOtoQvlwtK5no88fFhbjYWXhHJnUEjtj11BrfkeJ/ctftTzZA==
X-Gm-Gg: ASbGncu7BWjWeHuCrCrbSS4VLCcBHD/NkzhUa0rzpxtCQyi5JigNHaJJeHwA0RIoXec
	7qC33hUHjU1rUYgEAO0PpFkWo2oeBpipnhdnOl6PESPpu5LGIhzBGAKWFiBWtWfw/063kNxVETW
	3nbiMP1PRtNHqAdSmARfepVujLjLNKE6MherUB2wAKaSNhdhvpGa4pPke/FQyE+HaGwZGprZ4b4
	krnyBauPC6TbUJ5aMRmxN3flsURr4FTgxdrOMVfldyKJRVbkShYfP5rk5qDpadfDojWPn7zH+xm
	uI7Y/vCw1HXzgDwK9LyJJJJk8HVZphs5pq8msWcv3ekQuBp8jPjLcg+WDCaqqSBKniRMhjPKD/g
	yquhYsquGkoV95/98bNrXwSsvJ1OYXl6V8evPCrbvIA==
X-Google-Smtp-Source: AGHT+IEqeh9Or1pdmNi7drNLU/+IVAjQ4TaKkS8TJWypjcSYCvx1RIATie2eLnjsgrgfQiOt6uDzxQ==
X-Received: by 2002:a05:6000:2012:b0:3e7:4835:8eeb with SMTP id ffacd0b85a97d-3e765a225cdmr7060553f8f.53.1757792030006;
        Sat, 13 Sep 2025 12:33:50 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7ff9f77c4sm4948753f8f.27.2025.09.13.12.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 12:33:49 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v2 bpf-next 12/13] bpftool: Recognize insn_array map type
Date: Sat, 13 Sep 2025 19:39:21 +0000
Message-Id: <20250913193922.1910480-13-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250913193922.1910480-1-a.s.protopopov@gmail.com>
References: <20250913193922.1910480-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Teach bpftool to recognize instruction array map type.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 tools/bpf/bpftool/Documentation/bpftool-map.rst | 2 +-
 tools/bpf/bpftool/map.c                         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
index 252e4c538edb..3377d4a01c62 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
@@ -55,7 +55,7 @@ MAP COMMANDS
 |     | **devmap** | **devmap_hash** | **sockmap** | **cpumap** | **xskmap** | **sockhash**
 |     | **cgroup_storage** | **reuseport_sockarray** | **percpu_cgroup_storage**
 |     | **queue** | **stack** | **sk_storage** | **struct_ops** | **ringbuf** | **inode_storage**
-|     | **task_storage** | **bloom_filter** | **user_ringbuf** | **cgrp_storage** | **arena** }
+|     | **task_storage** | **bloom_filter** | **user_ringbuf** | **cgrp_storage** | **arena** | **insn_array** }
 
 DESCRIPTION
 ===========
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index c9de44a45778..79b90f274bef 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -1477,7 +1477,7 @@ static int do_help(int argc, char **argv)
 		"                 devmap | devmap_hash | sockmap | cpumap | xskmap | sockhash |\n"
 		"                 cgroup_storage | reuseport_sockarray | percpu_cgroup_storage |\n"
 		"                 queue | stack | sk_storage | struct_ops | ringbuf | inode_storage |\n"
-		"                 task_storage | bloom_filter | user_ringbuf | cgrp_storage | arena }\n"
+		"                 task_storage | bloom_filter | user_ringbuf | cgrp_storage | arena | insn_array }\n"
 		"       " HELP_SPEC_OPTIONS " |\n"
 		"                    {-f|--bpffs} | {-n|--nomount} }\n"
 		"",
-- 
2.34.1


