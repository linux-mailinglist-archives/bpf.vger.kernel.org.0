Return-Path: <bpf+bounces-71330-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D7EBEEC26
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 22:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 303724E7F6B
	for <lists+bpf@lfdr.de>; Sun, 19 Oct 2025 20:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D192ECEAE;
	Sun, 19 Oct 2025 20:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMM1Yt47"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFFA2ECE91
	for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 20:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760904940; cv=none; b=atCeHJbSLVBR5+TAIl/phzFsQG0sfALLqVs7mEHY+ALnltmD0j7NYBnuYdvyVi5WaL2vS+QaVzW2VnnKhVIS2G+2/oqu+O8PQo48tiA/gHbJ5isIgt2FO1qljtuZHMATPEof+v+y2JqOWO+GSBEr7y4PFKycnGood02PEAIiQbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760904940; c=relaxed/simple;
	bh=h/H3jKCaUNS0v4/PB8F3Btz1k6QZB6pf+HwNnJ0mcIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o8TJA5yY+xfWMfetZBpbq+HQ+JQerR2ZzFYCv9VJcnV29WisOIiurJQKTdRlbhJ2RkiNZk2l3Uj7dVc5Lx7pHb4o8jcIdm41iy8FYhk4UVyAcLrdwjvZF1EDFl6M3TLgqLf3o83Hu4gYtzC5mVyM21Tna+zyO/Ua8Ibvs0o13fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMM1Yt47; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-471131d6121so29345595e9.1
        for <bpf@vger.kernel.org>; Sun, 19 Oct 2025 13:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760904937; x=1761509737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywknrftBjNyhxtILJZTbzsp0u8rThEFASWWoC6kgwfg=;
        b=dMM1Yt47jLc1sk6ymu2O/MyPrA0wSQM/oL7xM+yblGOA8JVCgB07sds3HTn4B0mC60
         2LA61c7H5QH+xOB7q0faF4HajsG7kw8CR6Ps1IkLrmrIJUCzbKwlZ7Z7PpeQ9WIrpBnk
         f6Ze+cZwZz6Ujfx4TKSV3ZqmbXWIjsqcv/+SRPWfrYeNp0Rxo80VntXa1aoNcS5oXmxz
         xoAPAmBVBgBMxLUD5kj2nHN985th2ei3YPkKdQ8B9i5SKPR6HaahJj2ntoDjtcsClRgT
         ar+MujnaWTnynBYIzMG5e8T8vZ9QjKpuz9ksQ6Px32N5JL2o8cfayJejM7e0mSRX8ztZ
         r0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760904937; x=1761509737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywknrftBjNyhxtILJZTbzsp0u8rThEFASWWoC6kgwfg=;
        b=q3U01GnPRiymp/AXAfdIw/cGKcXJziWVDs1nC8zhrjoHptAeMmvW7AN6e1H3d2sop3
         dGkJV308+TtuDYqQ6bML0D4Z7btPxoKm7bBkqnVlz75s+92jZOawdy7moDkqlx0Mal4A
         a8mKq1IMUc2jaE4jU1g5h6luw0rI0/3XAVtEWvyawYwkgYGS65/a8IWG/tdiUoDs1+mS
         2LCzm78IWubjP9mu+PiWljkIHGpNHv4IsMiinsvqWgI5qlaY9Yv7PiUrGsNqzbDXjOLC
         o6NGnD9vurGJe8FfSAjsFlBvYQeBjHniiKMQu69AV4NvGuoemtwf3HmYMkL1m1Yg/Xhf
         3TpA==
X-Gm-Message-State: AOJu0Yy13B/4dPZjf7OtMAT3RkJoHYeL9blg9zdT4zkT5bHtjOPkwesP
	Fpf4R1wfLYlJCzkJHmDdUhX3TrBppza+eF2RHAEcB+3h4CVKbt+Ij5eHpg+KIg==
X-Gm-Gg: ASbGncsFkH+ogFcVP/MXY1KpmzaO1L+48BtmLM4VyYX4wrR7IXFv4gyJXZsuUxa3qyL
	9xMrw6xBtLDRTxyht0KK8BPD1laehMgRNuSqBZs/Y7GNJXRE0ORp0d5KJGWawzNNpwaAcvhPqR2
	8C4TgaO4CktfU0W77zYfQZ16vz3E5SE2mr1ESjYfyjIDT+A1UZzcGB+s8Q3aolNv8ucr3shvUsj
	1UO9wjrZAoEO53Ir3KROF4CEOZ8IZHvxmcw0JoZg+0/M4ZPt0AG0Dw0PddouMSl99/7ODQc4qJo
	iNa+grWUYszim2qqskeTQn32a157aroTJgxRsJodWr2wgxdvuWYCkVLphvdi6KvuFB7IA/e7DbV
	O5IYnnkExOZb9NKO1H9D+W566kRApC4zQZ855zI3C4b0+rmORQILWZ1GbdYkNU9vreAYKxqRAvk
	mhFmIj5Ja56xzfVdiPxmF7U7XblKR9jg==
X-Google-Smtp-Source: AGHT+IFO/P+0RTob7/28J5Stu6obEVp7ZSwDtCbQFEI5/aKmePLzJgKNgK96u8KCH0FcbJ7WZOCZHQ==
X-Received: by 2002:a05:600c:64cf:b0:46e:3dcb:35b0 with SMTP id 5b1f17b1804b1-4711786d332mr87195685e9.2.1760904936860;
        Sun, 19 Oct 2025 13:15:36 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144c831asm190460105e9.13.2025.10.19.13.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 13:15:36 -0700 (PDT)
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
Subject: [PATCH v6 bpf-next 15/17] bpftool: Recognize insn_array map type
Date: Sun, 19 Oct 2025 20:21:43 +0000
Message-Id: <20251019202145.3944697-16-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
References: <20251019202145.3944697-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Teach bpftool to recognize instruction array map type.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
Acked-by: Quentin Monnet <qmo@kernel.org>
---
 tools/bpf/bpftool/Documentation/bpftool-map.rst | 3 ++-
 tools/bpf/bpftool/map.c                         | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
index 252e4c538edb..1af3305ea2b2 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst
@@ -55,7 +55,8 @@ MAP COMMANDS
 |     | **devmap** | **devmap_hash** | **sockmap** | **cpumap** | **xskmap** | **sockhash**
 |     | **cgroup_storage** | **reuseport_sockarray** | **percpu_cgroup_storage**
 |     | **queue** | **stack** | **sk_storage** | **struct_ops** | **ringbuf** | **inode_storage**
-|     | **task_storage** | **bloom_filter** | **user_ringbuf** | **cgrp_storage** | **arena** }
+|     | **task_storage** | **bloom_filter** | **user_ringbuf** | **cgrp_storage** | **arena**
+|     | **insn_array** }
 
 DESCRIPTION
 ===========
diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
index c9de44a45778..7ebf7dbcfba4 100644
--- a/tools/bpf/bpftool/map.c
+++ b/tools/bpf/bpftool/map.c
@@ -1477,7 +1477,8 @@ static int do_help(int argc, char **argv)
 		"                 devmap | devmap_hash | sockmap | cpumap | xskmap | sockhash |\n"
 		"                 cgroup_storage | reuseport_sockarray | percpu_cgroup_storage |\n"
 		"                 queue | stack | sk_storage | struct_ops | ringbuf | inode_storage |\n"
-		"                 task_storage | bloom_filter | user_ringbuf | cgrp_storage | arena }\n"
+		"                 task_storage | bloom_filter | user_ringbuf | cgrp_storage | arena |\n"
+		"                 insn_array }\n"
 		"       " HELP_SPEC_OPTIONS " |\n"
 		"                    {-f|--bpffs} | {-n|--nomount} }\n"
 		"",
-- 
2.34.1


