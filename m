Return-Path: <bpf+bounces-72546-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE37C15228
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 15:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCC20642DD1
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 14:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1CB3346AD;
	Tue, 28 Oct 2025 14:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUsmaIWQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D71337102
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 14:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761660922; cv=none; b=r5GIXpj5A1/lOe/GvTjNPqeIUbnT8S4B8ie1n9WmtkNajIHjuUF8i446IdGBZ9up4g9WJLWB6qMxsPW/isubepzN0Yta2emLUR0z+2v/qvnVOMKzEQ2XxMWY6e9BpO2WRzwJyMrBv4sML3cT8FAnCt4pnbES0SIFijwM7pm4pj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761660922; c=relaxed/simple;
	bh=h/H3jKCaUNS0v4/PB8F3Btz1k6QZB6pf+HwNnJ0mcIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t2PmtccUFGRHnPTu07bwHnvZb92KhDWqiy7F3WI66JowF2bQ0yd5gk6YBKZI+KTow9luTlworbkraeAOMUBIo/8kdoDZPVSJQCuwyGSnrGfOidDLDmPZIjFYKkfTLd7dwZKWHFJvborEr3700gaYPxnU8i/Qu9+tuLZ6WVz5Rso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUsmaIWQ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3f0ae439bc3so3837353f8f.1
        for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 07:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761660918; x=1762265718; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywknrftBjNyhxtILJZTbzsp0u8rThEFASWWoC6kgwfg=;
        b=fUsmaIWQPmwRFLhhXPA0IgBYD6IONnw7ZbP9/K7gHdlhx4DwiE/OlTTznmIPXIO3BN
         VfeoNiIcZn3BGM2cSVOv06Q++tUo+URRE/NQSjDbfOlfja5AjWem88n95g+y+13kHKGU
         bIL/sWVCEnuVJLnnbtlzl/tS3V7m4ijy5F201gVG2XWwSxcTEt63rcLNQ2s83x1XykwB
         x8SS0G+L1FMns98tsrI+piO/p2dR5opmgtfkNBLwuvmUEfiQWSmNNZq2KSd7+zbfyvaF
         s/5wf5wmrcm56B1rTclYJQgx6KPoIrCQfUxPOQDsjGTfeevtYAE8YPW4Bn7P+NFDUjMu
         78Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761660918; x=1762265718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywknrftBjNyhxtILJZTbzsp0u8rThEFASWWoC6kgwfg=;
        b=E794RzZIcNjA/tCzyRV7EGzocPsVoelNuT0VXCGxZM7lam/TNDbUajJ1bSsOzqvVWB
         l6GyurDA1wq++LSORGNCPAYygiTzeyWwsDMHtOo8Catgxhyjmm6VGLw9oYxLLehuN7kF
         w7dHfZ/Kx4rbPD3ANzIpHqzDB3XdIkoTZQRFDRRVK2x5UGlNk0vhbSNBNRLz3WUFJ8h9
         o7494wkO9SVGTjRUmkfDxVaY51+sN2pwtPDgIlHHIjF/x+ez2auV8pJ6vZvMywYx74+u
         pjM0lWs4pNnOnqIwRiXqIdD1bOBp2xlQcvdh/KHz6y9JeLGA0EqigmMNyfjOjwH8/b6X
         FtwA==
X-Gm-Message-State: AOJu0YwdYxKSdNvaO861nLfuC72FsG/Bo/fxsRhFx0mbPh2R/FRD3TYF
	kiXM/IEl8buMGIzN9BI4ssm2rV939kyBA6c7oZtmwPB1ugitl6uHtrHu2OC8SQ==
X-Gm-Gg: ASbGnctc8CnGKSc1PpXvcpjQyNgwT95jqUEsfb4R/FpJBX1wKD1RdLP6rirksmOGAlS
	pJTVeoA1rnmAdqp0Amwl/DpsBYxRx89JT2G/5U0LlzKD/7WRG7NhK5fNxfT94sGyVytLdRz/8bk
	VdJPv4sniddHlRJS3dT6WRTJzs+exDqoWfXHOy0GbKDTQ8nbTttoHahy3NpRLMsg1zRG15Z9PBE
	G4WMLk1YTFJF3fSDqtyRk/zaiMSWrDmDTRTTbEJO5N3HaHz8NtznRLFAENuqI8UVWJLMbdNpbTR
	UpT3npiRcq1/mST/2eabkMaj5itwKlj6GsKXoQHz9c/ON7kDsJx7qHm9xnmxlWryvBbSFsQKJt1
	+wZmMPj09+rPnkbWwrpS61fJ9UThM3pxCqu7z/kbZq6ZFVvf381YTsssDM2gKHt3X8QHnt7lrgN
	/W5S4Y5egk91HBsuvPZzU=
X-Google-Smtp-Source: AGHT+IFO++ZZnnuwSA8TnLj1DhWh96hFPzYDI65XvmJkmCT7iOwzAkhNhjSTo9fnSdJIHgQwsd/cmA==
X-Received: by 2002:a05:6000:1ace:b0:3ea:6680:8fb5 with SMTP id ffacd0b85a97d-429a7e36fa2mr2907137f8f.2.1761660917934;
        Tue, 28 Oct 2025 07:15:17 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d4494sm20867060f8f.21.2025.10.28.07.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 07:15:17 -0700 (PDT)
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
Subject: [PATCH v8 bpf-next 09/11] bpftool: Recognize insn_array map type
Date: Tue, 28 Oct 2025 14:20:47 +0000
Message-Id: <20251028142049.1324520-10-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251028142049.1324520-1-a.s.protopopov@gmail.com>
References: <20251028142049.1324520-1-a.s.protopopov@gmail.com>
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


