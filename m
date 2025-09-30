Return-Path: <bpf+bounces-70023-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CEDBBAC904
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 12:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 120D13ADBA0
	for <lists+bpf@lfdr.de>; Tue, 30 Sep 2025 10:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81CE72FB98B;
	Tue, 30 Sep 2025 10:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLaZwgm/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678C62FB968
	for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 10:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759229401; cv=none; b=Pn2xf+5RcPjpaGK/e9URWrJA017x9VA8zhKodsZT7UakRVa24h0R52FL0o+p2ekee0ddf2SKCJ2VseU+c12N+7WmksleEYuUNFVGWvk9lv6QLynJ3kVSnuLfW8Ap5XTQLbKb6KjuuYQ6LmD/7s3D8x135crq96mmWFsSWe7RUrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759229401; c=relaxed/simple;
	bh=h/H3jKCaUNS0v4/PB8F3Btz1k6QZB6pf+HwNnJ0mcIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pe3Zlb0CNs6AylO6bxRnd4Qt8e/DeC3VDtjlUACGu2ApRnq+1j8IW8cO96bYL0vSHdSmW3y477RHPKbYPKYGbxYXmEgC4mcmGstw2kaYHJSBLT/pt2eSkUPmP3sLjeTXnaV4DjFLlih87K55RfLD1uxwmOgAXjN/eKQmKObWA+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QLaZwgm/; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3fa528f127fso4531884f8f.1
        for <bpf@vger.kernel.org>; Tue, 30 Sep 2025 03:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759229397; x=1759834197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywknrftBjNyhxtILJZTbzsp0u8rThEFASWWoC6kgwfg=;
        b=QLaZwgm/Ol7OKnq1ie8B/XO281VF/4R+0ahqNG5KuTqZB6R+egAtD9DQ6GzFHnx1Pu
         FOLk/0Qr9nzvqK0y1o6Jv+tyZttVlBOjdIXibJi6fI7pytEDmfZxcDzPuPajx0iXt+fg
         IBm4Y+A+agQWTECyoaOWcVxsFbHK1UAXsiapUBD3UDxDNId2hiqEUs5DKblFA6TUcL8x
         UUVRmerYqy94khPh/ETM98m4X/BVSlfm/dljGkALpQ7zfsttM6fHmkV2X7MbPFZrkpo5
         u/LsT8STtEfQ/4RSIeAK0E2TogZmW0M47fzh4Xn0IClLwvAmYU5I2Ln9UjX4ICyCorCx
         vfUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759229397; x=1759834197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywknrftBjNyhxtILJZTbzsp0u8rThEFASWWoC6kgwfg=;
        b=pLvamxEnpZ3ve8Yro4PuQCLBihcGmIy/kY4LZOF83fszFn2XWwF6X5zGM7RGyviSKV
         TZOoUQoXhuon++IODMAQkI3ZRlUqf2h18SDFKlCLBWeWtN6Uh4jwFLqc5vDQrZQOYnd1
         /CelBuPslzigE6PnbP0Mnr2d+iPf9ZMcwJnALeNpwqh69wQHmFDRHEjK7bB4I6+OUJhW
         gLyGO2I4bdCNJQJ/sqPQxRBIMT9DWT7pSK/L6YpmqvgAueVGJuU45u8Yge3B4avrhj+F
         gbaya2/+91nhzEjzO7bGVYYXIAuhQ6XPf0AC5EVHrPCBAfGLcmRSB3oAJk3P5rmdVpLq
         4DqQ==
X-Gm-Message-State: AOJu0Yz2JF+c06NHx5CUGasGJ/eAisUoN8rWCQLBxy4eodA1KwFLUcxW
	8ElcETqlSNCGL95wCKfJ3a1tyOVImvaSV2PWMTvs2NQBa9gyFkIqRHJiC6LmnQ==
X-Gm-Gg: ASbGncsMpV2XkGFWCNnr9OqKwPP5O8rQqDuupaT7gJybL/DaxHOAotNxBbaQShhgqdD
	OU7YkJhkI461s9SKGpS965WY2ZW8IV08PlnsCB5Eqjc4aM19i3WhV9vEsbnAyko44Nl21V2pq05
	LfjhIU+XNMKeJVOIqZZK8Ggi45Jqd4t8IPinI69tqiWL4hdzdfx+Zd/PUdz+YFF16r97tRax32/
	N9Q2ucLPA7J0tCMnap3xwRFLxjwNgc6QUwfukS+ugxHN3mJCQO4keGrOnhywSh/4PSkj1JNfH7Y
	c3J5CIU0TKrC5R01Cw0ClZJ9bfpvShaV8WxHx8pxgYjMDsry5QaI4ZdTgZfNPwOqO8Cni7obp5+
	+DkJnwBH3Iss3mmRGM5XMuG6b5xeE8kqHKRXNWR6Nt9fgkQqxYehzdQ5oYeUp2qEtRQ==
X-Google-Smtp-Source: AGHT+IFAiFRLQszWdEyEtEGQv9rZ16XR3HCOKztgMYNqeoyp+gwX79u7M9DqWn/P4G2LY1Edze/2ag==
X-Received: by 2002:a5d:64c6:0:b0:3f0:8d2f:5ed9 with SMTP id ffacd0b85a97d-424107810d7mr3365866f8f.1.1759229397234;
        Tue, 30 Sep 2025 03:49:57 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc5602dfdsm21982161f8f.33.2025.09.30.03.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 03:49:56 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 14/15] bpftool: Recognize insn_array map type
Date: Tue, 30 Sep 2025 10:55:22 +0000
Message-Id: <20250930105523.1014140-15-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250930105523.1014140-1-a.s.protopopov@gmail.com>
References: <20250930105523.1014140-1-a.s.protopopov@gmail.com>
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


