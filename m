Return-Path: <bpf+bounces-68763-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FEEB83D09
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 11:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AF6E1B2007B
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 09:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41C52E9743;
	Thu, 18 Sep 2025 09:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhBzMwo5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08E72E264C
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 09:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187973; cv=none; b=X11p8YH9x6Z4d3sg+MxvI5bXHQJj8fDDVYkWC5R69gDT4kBlcfnPVcVTJSiOfbrwo6OJhd0+nUyxCdbtUzpOdGAsS3UGIAuDq2z5CJ6Y35+7ILYAE1U0DqkA5R4P6B2K2NJdIbsRNMrH2VTG65A2ZikYY00wucMv1ZI5MxHtZY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187973; c=relaxed/simple;
	bh=h/H3jKCaUNS0v4/PB8F3Btz1k6QZB6pf+HwNnJ0mcIE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IXwstRuzfKKWz+aKxwUcXlzYL1QXr5Wv0hTHsRyYxgFJFCagKsH7W0aNN4L/IqAwuYsEgiDtU35gN38dRzG3VnEWXJ5G+N5sLqO/5drhmDDJyJck/qTA++yuc/oZHtok6aFMAoIQsLjJVyIpAyVOzD0A1MeEkDWW37DAAqF7bHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhBzMwo5; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3ea7af25f8aso314121f8f.0
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 02:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758187970; x=1758792770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ywknrftBjNyhxtILJZTbzsp0u8rThEFASWWoC6kgwfg=;
        b=fhBzMwo5WmcicrFODYiOv4Kjx+a8sFJAmr53F/tYFKgmUdJVR2ycGdv7iUvlQXXkPX
         oRlvBCj63+UHHerc3llhbIJJ/nkI8OOJe07N808wSnUjR0QSWRTX+Vdfb1Y3abWm5X/M
         kSF3dhZ5vts0GW7kKA8R0lGEGVWrcXG34QjFU5Qi7FQ/e7PnEQcYJodT4i/1b0YViktz
         S4Ry5+XxLr1NSOK5HsuYCViGpSMJqWah6AmczqVT3s65DjcqPzssJdc/qs+A1q0uJvN/
         6msslhq2Jg2QQDqUe7NuINpays7S3JBk/+yXYZoJLNUcXiT0vq8ybwPHOWmwfv0GBHxO
         Fa2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758187970; x=1758792770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ywknrftBjNyhxtILJZTbzsp0u8rThEFASWWoC6kgwfg=;
        b=aC262oiDKMZ3Xae0cNmQMRT7kjJxeMyKGleX0ECN63tl5nebcDaTm3xEcUAASN9L1P
         5oryz5wCw/iXrg3gTAhahEUiQW8UCydk4Mq6At6r24Z9w6tqLf8ZY4tbSsTxXiCXAznH
         Ryhmdn2adG9IeAh6oTJSTf8TGetQ0X1IouhWtR0tFM9FDH6tNLvly7qiJHYi5it4Rvo7
         NZSjtN0br96rbVsJftHCediFp9PrtameKHeurgCAMnl/kuy/XnfCRda+D2/VWaZ6X5+r
         SyJ8mAE/b3z8YOmAqXOKzjOcr/DUxny3TLtbFpjUhnjvTeeaPX1n1Jf898e67j/rXQdY
         a1eA==
X-Gm-Message-State: AOJu0YzJjpx7pYIHUvQmlnHBMgbS11fpfkc9h5VfrxGTKGCEAzDldply
	0AdXlQVpE0EZs4HRwZKUSDID2eGmjZjknZi5ta3ygkisBvNY4jHZeoEx652vKQ==
X-Gm-Gg: ASbGncu3vceIERtZlgZCvp+tzBVjpmSR+f4e8Gdts/TanzCikDd1jYRLmdkerIhZ5yi
	Cr86o3qf4gIPQLUK7Rhxl6tq8a4DiSrX1DguXY5mV67ELtr0Nn+NmMuBml74u57o1IGnwalY7Bg
	0NTNtXN2AohQVecmSLzvM4WbcpswRXo84kw5DAG7WBuvG3dX0i6iRXubhUJWSNOAmLvNEVthJ0f
	N4djRw82IEE0UYjonVxyY9hyXIJ9IG33SPqUqzg0/3lG9AFaKNcIcwFvOG7dMu/wp/+34+RczIX
	ec5BZFcL30z96K/kAGO+A1no2wv7dBmoQ8kuAn6GS/E5eTEIdBxWOX6ZMBjynNP3G76Y4krWiN8
	mvHDV5wJYw/KclZc5Nnfv4jk9nFat7kyLNqgg4h8+VSf3LfCSMQ/g1mVF24/VEMv0zyOxRrk=
X-Google-Smtp-Source: AGHT+IGOw2SxMJpaQbM6C/2XGNN9nKLarx+PlhVpseR0LIdKFfrWMKl5ynVtCtZXpFZlkelG22KaKQ==
X-Received: by 2002:a05:6000:100e:b0:3ee:1125:5253 with SMTP id ffacd0b85a97d-3ee112554a3mr1122453f8f.20.1758187969586;
        Thu, 18 Sep 2025 02:32:49 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbf0a4fsm2775026f8f.52.2025.09.18.02.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 02:32:48 -0700 (PDT)
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
Subject: [PATCH v3 bpf-next 12/13] bpftool: Recognize insn_array map type
Date: Thu, 18 Sep 2025 09:38:49 +0000
Message-Id: <20250918093850.455051-13-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250918093850.455051-1-a.s.protopopov@gmail.com>
References: <20250918093850.455051-1-a.s.protopopov@gmail.com>
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


