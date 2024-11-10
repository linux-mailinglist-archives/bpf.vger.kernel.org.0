Return-Path: <bpf+bounces-44488-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAA19C343E
	for <lists+bpf@lfdr.de>; Sun, 10 Nov 2024 19:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A49EDB20D85
	for <lists+bpf@lfdr.de>; Sun, 10 Nov 2024 18:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B52A13C690;
	Sun, 10 Nov 2024 18:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtC1JXit"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A0713BC12
	for <bpf@vger.kernel.org>; Sun, 10 Nov 2024 18:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731264293; cv=none; b=bcDxKwzGirnI0jWOreOEEQ+QD8YF4EqpExEthaAg+W1fG4FlVQubQI8Ml9JeCXEZ3WeVqS7GkUyf5fnmDinMHCVr4/1ghKdDLuxknqum1O33lRJbtocp9rIgeKZFi6Dr8JYxUL4wu1mmfiMsxNUcHqbdyaZxuEjAMgab6E3zTwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731264293; c=relaxed/simple;
	bh=nuoEPP3hsTRytoVgglBE5dmjS+82640VQlxIGlKoAns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fQCimywim1t6DDGvye834Pbsa6eaeza0sRTxZciYdFiaMyfcQIqoaqQ4SWyo4DIqurILnePiBJd1hCnxP8jcyhPvysR3dFvtivY2vFzByymyu3oaS9sD2g4V2U1/2ew5OiJO0vq7/uNhqby7OZTHe/oeNXjgtbVP5bm/0/iDjlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtC1JXit; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9e71401844so487471866b.3
        for <bpf@vger.kernel.org>; Sun, 10 Nov 2024 10:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731264290; x=1731869090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=whJFXZkNBSsBlx/3skV5Sl3ph1oX31uQ5AVZ1wTBllY=;
        b=mtC1JXitTcpXKdYyWOxe+4U5PGNL0gWVuujlw1bLQkbNRcrhdYV3TyAtnCFaeOzshs
         rAjQCVMu4SVfDCd6nlU0gg/c3f4X1otlCVS63yDLIWHQbltzsFlvhx9IAzTFaP3ssim1
         YFPm+kBjFkuqEBImoUVde59CcNzfOYn4yrr8lcqXXgC0i3zFwPaWBjEpasODAPbdbOMN
         AAFCfL5m2QI9M1zQdd3enVW7AefAAlVwqiwmWTng3oWM2tQlhD7z+MtQN+GHuLND7wU2
         Pipj7QzIeymH+uUFXQE+LnQu+ta2woBf+NAjC05WyosPHCMtEkkRC2UnwzWY6hr52pI6
         aqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731264290; x=1731869090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=whJFXZkNBSsBlx/3skV5Sl3ph1oX31uQ5AVZ1wTBllY=;
        b=xFIB5vg/AFWpsXO7N+M80V4KI3I4PxnzGD1vIisjAOVeHYbczjsSr4nhV62g/8lmP1
         AYYuWdZbLAXBLPC1KjrYGXqjLKe043uIomYf0tifOP4gsCmztIFmdlSoMSnRor5DjIWX
         xXRAqBbgPZU+veEXDetxI2fS8+Tj9GOGOnspWzFvkNBFIxETRnsEfDnMnQsv+LUNUfbF
         VRBtmdCCmKMXSieqTcNGCkEQjtwqdYjd+yrjieckuBwdeNNK8ocYmvLXV08G34r2HqoR
         57wpD8KHegBKsk0EKavVBW3ik03LZRVC9Nh30MRmIs2hYDHXc2+XEaxZD+7k250S8LO1
         0JTg==
X-Gm-Message-State: AOJu0Yw5rItGnIE89leU+B1Ql3xqdKkyDWdTzzb2lplGQP9I2+GS5z0s
	BFqbn90ovJFQ8PGADBMSd62m1i4Yrp2KI68wWSVD88ooj+5SUjGOS3fkIg==
X-Google-Smtp-Source: AGHT+IH2igW+hwDzqHXe0QQLZaamlISD8La83puixWQf3HSKRLgmiUx4HKJJc0lVoY0FdI+kFK+TUQ==
X-Received: by 2002:a17:907:3e9e:b0:a9e:b1f9:bc52 with SMTP id a640c23a62f3a-a9ef0010e1bmr918735366b.55.1731264289896;
        Sun, 10 Nov 2024 10:44:49 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:864b:8201:1677:ed83:8020:fb22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0e2f4a6sm501542166b.199.2024.11.10.10.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 10:44:49 -0800 (PST)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>
Subject: [PATCH] bpftool: Set srctree correctly when not building out of source tree
Date: Sun, 10 Nov 2024 19:44:25 +0100
Message-ID: <20241110184429.823986-1-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows building bpftool directly via "make -C tools/bpf/bpftool".
---
 tools/bpf/bpftool/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index ba927379eb20..7c7d731077c9 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -2,6 +2,12 @@
 include ../../scripts/Makefile.include
 
 ifeq ($(srctree),)
+update_srctree := 1
+endif
+ifndef building_out_of_srctree
+update_srctree := 1
+endif
+ifeq ($(update_srctree),1)
 srctree := $(patsubst %/,%,$(dir $(CURDIR)))
 srctree := $(patsubst %/,%,$(dir $(srctree)))
 srctree := $(patsubst %/,%,$(dir $(srctree)))
-- 
2.47.0


