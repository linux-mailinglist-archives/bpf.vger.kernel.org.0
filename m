Return-Path: <bpf+bounces-30187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF468CB709
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 03:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0DF11C22D14
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 01:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1660F1CD35;
	Wed, 22 May 2024 00:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WdJ+w+pl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FC21CD3D
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 00:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339579; cv=none; b=DkNstRPYZUq6wTAi9aS+QXpi/LdIYrWRRHzv0Sv5LZ8mvYptBGxO8KexeMKLqoP9o04LXDdn+LEQ3PZgHc2JgJSibxFanZ5RRUv48T5WpkgNDJAg8AdHFtik+u2g3HDu1XfZ0DxfoTiVfdif00MUdokcvMnsDDI3PSE7rQBoRRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339579; c=relaxed/simple;
	bh=wyS7Ki/mejf0xhJNUDsmkKI4TXOY7lCcp6nK2TM+yu0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NRec/hR4eP11APBE5TcRgc9KsfBDjLV3hoBIb6yFK1hj0qmzRuVQ1EC9Kx2NCz4jpANl8oMjrvV4Ui1T1FQ+dds/ZQ05qEUBWr2xbXVUkx5pK5tJBr+aW47ziHol6QRX08brzuNWYuAz6jqQLaiF7Fv/cGobZp7qC3eRcphYJrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WdJ+w+pl; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbf216080f5so22939245276.1
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 17:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339577; x=1716944377; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=h2+Rsi36vwtZnongYaIBJsOunisSLXoKXt6dmQkzkok=;
        b=WdJ+w+plvIuy7Tx8/uGH43uxlebvq3HgzvfeKhzEZOHeGMyom8Xb02KjGX9UO5FMay
         MXlBD5cxMvBH5NL5CTOWUuo+D+6rYLELOraGg+GKs80reJpdSVHDXO2pkbFBduDiDOWt
         H/OUfKXbqnL5fkKef7waOxfGoVR9Cx4/qg7lFIGaw/WJH8bMMXyA5J3FLGtLAHnYAD6u
         mCu7JMbYK43Ui8enl4ViXH7MCu36gAPq0pII9nsbyPpaPNW8pkG2Z4WOfh7ed9RuS8nq
         0Y26ZZJpOMIaEf2Zk05puCS4Xzr6p5zw9egRJSUsb77XJQXrXD8tjcO+mUxY/rpb5GMT
         G4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339577; x=1716944377;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h2+Rsi36vwtZnongYaIBJsOunisSLXoKXt6dmQkzkok=;
        b=T6cXvtLew6uxmxuoxGJf9XDdcAYU4vAyTFoNdJwRL7YCSYG12nxrZG2wIiig6wbXlm
         HdOhCke/zXe9pIa+ww6eoC5nrSAMuDZU6m19R5/739zih/ghkpiGc6qQFwYhNVq4cSK5
         1LESDDzuv/AU8Z0TkZI1bxq62PMQBHBo+xSChoVnIudrAtkiorhlQ0FTD1dQpg2UI/cC
         EFS+XZqYo+usnCi8VO+mc0/VjqusASL/+A6PkpK1TGm1fyDMAhE9p8DWsMYq8Z6RT+Zq
         ZipHPDoClozo208JtJIskoHe9xfs1RpA/vmAEPpK7RC5SyNTSRM7sTMFB6KHIp1263QU
         +cbA==
X-Forwarded-Encrypted: i=1; AJvYcCWa7EsVJGDyHmRUQ3sSYVE4sEs8AHJ5O9EoAB57xmAeaZ81aXqpLGb1w60omIuZ0SjMRUGCyLzOzVi55HgX/niBubHK
X-Gm-Message-State: AOJu0YzyuNQeC/xQuFEnMC7bJVDg8Ya+HIN8mAlCKR6HFNxBpw17uiOi
	MB77gUsXXMO64FiWsOkAoLQySiOJXs6xMgyL/q1l68QPiVQ7yNEMwyqCq+ZZXxZAahOv5vQSzG6
	arg==
X-Google-Smtp-Source: AGHT+IG/3Zpx7l7joTN4k4AeREX+mCmSb7fgmrUn7wwa4Tb4B4bmk+1v4oGre9mjMvzUs+OvPiRE3jsBfVg=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:2b8b:b0:de5:2b18:3b74 with SMTP id
 3f1490d57ef6-df4e0a4dee9mr216829276.2.1716339577258; Tue, 21 May 2024
 17:59:37 -0700 (PDT)
Date: Wed, 22 May 2024 00:56:50 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-5-edliaw@google.com>
Subject: [PATCH v5 04/68] selftests/arm64: Drop duplicate -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/arm64/signal/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/signal/Makefile b/tools/testing/selftests/arm64/signal/Makefile
index 8f5febaf1a9a..37c8207b99cf 100644
--- a/tools/testing/selftests/arm64/signal/Makefile
+++ b/tools/testing/selftests/arm64/signal/Makefile
@@ -2,7 +2,7 @@
 # Copyright (C) 2019 ARM Limited
 
 # Additional include paths needed by kselftest.h and local headers
-CFLAGS += -D_GNU_SOURCE -std=gnu99 -I.
+CFLAGS += -std=gnu99 -I.
 
 SRCS := $(filter-out testcases/testcases.c,$(wildcard testcases/*.c))
 PROGS := $(patsubst %.c,%,$(SRCS))
-- 
2.45.1.288.g0e0cd299f1-goog


