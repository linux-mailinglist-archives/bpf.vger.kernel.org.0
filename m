Return-Path: <bpf+bounces-34960-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C382F9341BF
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 19:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D2171F23785
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 17:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EA918307D;
	Wed, 17 Jul 2024 17:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9sYsLqu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8CE183068;
	Wed, 17 Jul 2024 17:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721238955; cv=none; b=DewEUpyeyDtYDvC5pp+vb4eRk6ZIa8/UTkGPvPX75mff7z+p22uD6pFPc5BzzD4MgnzH24kzX5g8lycpx6qZUD0kOgYNPGTUHCNp4ZNDnP1Bo5sSbm7FLc7L0p9R0/XiyI4mzABA92D96pTAUUFkil7Zi7y4otGw6SIkmIx9Ut4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721238955; c=relaxed/simple;
	bh=nWpNdRmuS4vCP5i+Yp+KKH6GI8MxgME7esnrEhssBzU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=odN1C3TdeDd/qDeJGhp5oW50O4kB6KGKjezwZ8lJxdtwvpUaOykHRjGvhlDAdQDvZ87kvIW+K21acNsQrxAWCgwS99hUfwsrPaG5HEt9IA+C5p00DigQVkxcIFJxd+js5rMS7dcd+jNPJ4sMu8PETwHgOAhOZ4kJfTB6AAwpYzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9sYsLqu; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fb05b0be01so49136385ad.2;
        Wed, 17 Jul 2024 10:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721238953; x=1721843753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KEbbdd9YNwTR1oy8pR+LUVTk58PGi94R+NS2hMzG6PE=;
        b=j9sYsLqu4f94gyXcoa3wneDFr5wxN2KABUQUeK3pWaJb1OMadh0LQB443NHnjn5Hdp
         jdt+75qO9cNH0zkpv6YCUlRtClvSxykjy/5gqryAY1ERgOIr6NqdsLhZzirkkY1X5NMG
         Zx/te1DNH+o8lDykOYahbC0U62+zVP3To9meWEWbVVyYE6ixgEon786SW7eiqLono3gW
         RZc4ad62JoqujmXt7wAhuyyYcJyhi+jYpek0p0VrlcLpCnGfYBLNJkdg5zvKAolM8PaK
         ujGVDbh/RiEdcCqv/nyKhBHP9svLbge7jEZb0eAVbzK9qGhve8PVlhRjlIQ9tSaJKV7Y
         x/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721238953; x=1721843753;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KEbbdd9YNwTR1oy8pR+LUVTk58PGi94R+NS2hMzG6PE=;
        b=amT7rJi9cRGWif/bNrWIfExxyxKo1X+om2uBhMQ5JqKdu24YEP5nG0tgUJEby2/set
         jQzVR98OCRV/ux1r6VG1gkuF7yfSeM8SpUrJScGHdohOKw1BQgUN0azyTQTrQc/oRvlZ
         FbdB2zQWfrbN3yzgDdleFiEKOxh1FvlbpRNVnRJvVMyAhzPatUi8n9+/HiHJrr3Pcx3O
         TSZ4vbhwMjoWG03Qe92nOzKkYzrynl10mVKlKQnnVidIhLl7pjfyfvJw/MzC00bhWyD2
         g96LlO5xcF+CiZhqtp1achYKilPpdZu8/3Q59myfw8Cnk9TC7VeCU0l+FAM0fqy6krnm
         vYpA==
X-Forwarded-Encrypted: i=1; AJvYcCXYe2pvgY04z/cgVKrM7n5ZZOW5pRbRGRuAK9/p4v99uPidadsZVq0D17p2gLvoceeYQ1D8oLTMyUfXqq01cTI6bjyPJaEsMjbE/Kys8goZHSTu5LHnSHxY59+O+aqhTm7T
X-Gm-Message-State: AOJu0YyUiGe92vE1nWNvYdyzATdqRGaQ2diEbfqu0KOgytZPUSAtyoYA
	oogb3sZtO4vlmQUcACVYYN87PTAYwzgyNUm5kM48RZ4Oi1shgEvt
X-Google-Smtp-Source: AGHT+IEM1QTt/AmeIZwgPmUP7/OY4FU6pDZ3agAqoBTQuzmAYwJI4Tkl21VbmbbuJ/MVa9uKS8xm0w==
X-Received: by 2002:a17:902:db07:b0:1f7:2293:1886 with SMTP id d9443c01a7336-1fc4e165dffmr22434765ad.12.1721238953366;
        Wed, 17 Jul 2024 10:55:53 -0700 (PDT)
Received: from localhost ([116.198.225.81])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc53fc6sm77926575ad.294.2024.07.17.10.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 10:55:53 -0700 (PDT)
From: Tao Chen <chen.dylane@gmail.com>
To: Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	chen.dylane@gmail.com
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [v2 PATCH bpf-next 4/4] bpftool: add document for net attach/detach on tcx subcommand
Date: Thu, 18 Jul 2024 01:55:48 +0800
Message-Id: <20240717175548.1512076-1-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds sample output for net attach/detach on
tcx subcommand.

Signed-off-by: Tao Chen <chen.dylane@gmail.com>
---
 .../bpf/bpftool/Documentation/bpftool-net.rst | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-net.rst b/tools/bpf/bpftool/Documentation/bpftool-net.rst
index 348812881297..4a8cb5e0d94b 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-net.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-net.rst
@@ -29,7 +29,7 @@ NET COMMANDS
 | **bpftool** **net help**
 |
 | *PROG* := { **id** *PROG_ID* | **pinned** *FILE* | **tag** *PROG_TAG* | **name** *PROG_NAME* }
-| *ATTACH_TYPE* := { **xdp** | **xdpgeneric** | **xdpdrv** | **xdpoffload** }
+| *ATTACH_TYPE* := { **xdp** | **xdpgeneric** | **xdpdrv** | **xdpoffload** | **tcx_ingress** | **tcx_egress** }
 
 DESCRIPTION
 ===========
@@ -69,6 +69,8 @@ bpftool net attach *ATTACH_TYPE* *PROG* dev *NAME* [ overwrite ]
     **xdpgeneric** - Generic XDP. runs at generic XDP hook when packet already enters receive path as skb;
     **xdpdrv** - Native XDP. runs earliest point in driver's receive path;
     **xdpoffload** - Offload XDP. runs directly on NIC on each packet reception;
+    **tcx_ingress** - Ingress TCX. runs on ingress net traffic;
+    **tcx_egress** - Egress TCX. runs on egress net traffic;
 
 bpftool net detach *ATTACH_TYPE* dev *NAME*
     Detach bpf program attached to network interface *NAME* with type specified
@@ -178,3 +180,21 @@ EXAMPLES
 ::
 
       xdp:
+
+|
+| **# bpftool net attach tcx_ingress name tc_prog dev lo**
+| **# bpftool net**
+|
+
+::
+      tc:
+      lo(1) tcx/ingress tc_prog prog_id 29
+
+|
+| **# bpftool net attach tcx_ingress name tc_prog dev lo**
+| **# bpftool net detach tcx_ingress dev lo**
+| **# bpftool net**
+|
+
+::
+      tc:
-- 
2.34.1


