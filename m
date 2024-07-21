Return-Path: <bpf+bounces-35194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 411C093850C
	for <lists+bpf@lfdr.de>; Sun, 21 Jul 2024 16:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 726341C20A66
	for <lists+bpf@lfdr.de>; Sun, 21 Jul 2024 14:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBF3166317;
	Sun, 21 Jul 2024 14:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kx/mX6zI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFF7150980;
	Sun, 21 Jul 2024 14:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721572981; cv=none; b=Fcbd8x4bIQL0ioHG8OwaoJ8SZ3R6zYNA7lesdSRmJO9PbC+PzkZKQU3HnKvayScl6QTdF/bF/dIlzS7qGIvMLYpsmQkUDAgkskm/r2YuXpb4cfNUzzev9sy4ACp7Yo29iyhG4jzFPhvsw4cFihLNKec2sZPgnmnlOcYZUDBROok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721572981; c=relaxed/simple;
	bh=KsRZIIVF2mFFBV6NuuLYyif7cLH41blk3r28EuCSS68=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=myCD7BZaoD6gvH4Zpoxm7UHIXLjae3peJNhVHBGf9+Y2jCRmCbfK+vRoYsJ+H4jVQVJS12IZbIXBxIVEgAa4im6fgBbVbRwoZgVzYXYAahxNPenPecZMePRyW4U8QREVUTn0tWpPnWLValFgo3qLA6qRCvQ2qBMaaE35MQqvTfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kx/mX6zI; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fd66cddd4dso18393275ad.2;
        Sun, 21 Jul 2024 07:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721572980; x=1722177780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ZiPga6tr64DZh3sYOPyVgg9p0KRzGrR3EpmGO9QyTA=;
        b=kx/mX6zIlpO+bPwGrrJaBX3UWGp7H0lkH/31/L+DJQnXzTOOHG716mxJw8LmnMAzhA
         GrLFwoUAvkEFxF5dWobSIgJQTLkXFl+mylOZXTjPxySgem1KrcniQCWaWF8dZo0W9hLx
         m6Ihng20ETlPk3JKydBeu1gjzZ+Edt/Qrt7yJzYTQK0hHTQckbwywOjezvkRWoM8tEHQ
         gzz30hugWMNJvvXQ5LCdq7amlhX6i/9l3g2v9p1XmDK+YPo7bVEcQu7FKqBJhQSK6qco
         FD09CBmk+tPG96aBT+Xf3hUpvIc7ShUXL9PfyPrWl7SyHmCUDbJMBu3Ye56r8OjPO3Ih
         RyLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721572980; x=1722177780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ZiPga6tr64DZh3sYOPyVgg9p0KRzGrR3EpmGO9QyTA=;
        b=oSV5gulUsTDixMEUUQQdpfWmDgEbgTIJu+rq9nyCoN4083redLmgf2VSTCnLkeYzP/
         Up23ndi11rEs0VT6L91DNejuLS6O035+ol9hC3kPd6ccov2fGn5aCbT1Gfr66TzbAK/r
         qtcrETMC+ySSrGiKQRaXqegtnsoY6Mt1ISX3eOY10sEBveEL/IZcVkJd3tRkurVB16gY
         7GDzyGVdtZ+1BbRk2FpSBeGhO6istfvt0Jup768tuaCtdl8YZAr3gGln9Ha3KLlhC6vq
         sxdVG491hgFipKohNtWCt7HcxtuhPEdt3yzsnOvJ2BBB3+pC0OTZ7czdsdi0PLiKIMxx
         qwwA==
X-Forwarded-Encrypted: i=1; AJvYcCXpdz9brF7PYZgV1/RwTXRnJggcV5Ey+5t+oU1IWt2afDW9L3AC5KUGAQaKgyf4cdWfC2uC6LcPRaV6WO8wZJkxw8n054ihsXJJ+NCNpCmBKzFBwapTdsrv6vACoCAYeaW3
X-Gm-Message-State: AOJu0YyoqeMXXiW4JCJK5/wvHJmjwfQk5b1RVe/Rt7yArSeNuJ6Hy3Cb
	C7DYiv8rO9+ZUBIuPJaCSrRlx47hEc5gKhZZNX0cZtymhtJm0qarki5kjldi
X-Google-Smtp-Source: AGHT+IEY7ZgHgWh0N17tPo6horrpfd4ym2tY+CBJDm1vcSbUVeURBXpoUxBI7ISoaFkTkyckpLhucw==
X-Received: by 2002:a17:902:ecc5:b0:1fa:221b:a7ef with SMTP id d9443c01a7336-1fd7461f2e1mr57264835ad.41.1721572978145;
        Sun, 21 Jul 2024 07:42:58 -0700 (PDT)
Received: from localhost ([117.147.31.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f457c6asm37162725ad.242.2024.07.21.07.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 07:42:57 -0700 (PDT)
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
Subject: [v3 PATCH bpf-next 4/4] bpftool: add document for net attach/detach on tcx subcommand
Date: Sun, 21 Jul 2024 22:42:52 +0800
Message-Id: <20240721144252.96264-1-chen.dylane@gmail.com>
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

Acked-by: Quentin Monnet <qmo@kernel.org>
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


