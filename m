Return-Path: <bpf+bounces-29391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 086EB8C1B4D
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 02:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352CB1C20C42
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 00:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2240313B585;
	Fri, 10 May 2024 00:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SFWpUj6W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5547513CAB4
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 00:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299892; cv=none; b=IvBOpl+uynw2NnzR8EpuKD9FwT1gyhLHPV1TQXzBdxYQpyaiY3iruK6eRY8aH/Ha1SZi8S+UREmiWvRhwMK/HR/n2hQbJRoRSXWg1/+8BqWqtBhXsyoX6+oC7mbps++77MRucG1TX4s2AZUw7lSAgoVE8RFknhW6PDSflbDpWdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299892; c=relaxed/simple;
	bh=O9xtfbgadu/p6ddd8avwApWGZ/0YxN3sdI3PLHa2U58=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p6KCXS7XsVr+k/wrA/yEmfvaxJehtibZhjwFHNrESz7InDBtTF7F9i39fh037fajQZa8dCbdjYgfTsVqbiKXnmSuwPXaMhvdzP3kr2JAilY/AKh6vDIv6OBIt/jucTNPN0fepiy13BndRJ+GxKT1VogKwlIPcQMHy4Gs+6B1sis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SFWpUj6W; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-61e2b365c9fso1275894a12.2
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 17:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299891; x=1715904691; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gqJpZ06+qwlYgGDMURIHtEZ0g2cp0HVan8txW5tNeCQ=;
        b=SFWpUj6WWfbw3A8k4RFiIDVrNWTpBR2S2RTocthdnIen6kdt8R6p1w0GMqioyiOb4e
         eb0UibyhDQK9N52ncUqXHD9jeV0hvOar+jEvk8IoWHlw2tWAbN3qnT4+4FQGHfRcAC6T
         g5IwiQ9wulAz4gLRnTpkIZZj42XoNU1Ec5z1BYXOCfHeEsQq5FtJaRzXFdx9q/5Ocn/y
         ZcMDupm0AXqb2P1oYGV7xNdBAtk8CDO/fM+1w96ZN+LRliq4eVL5MAG+uGOEYsrtfEay
         XNqwr7DFfwUV2taPycuctirdq83ywE4EgfVodHP30l3j8EuORB/R9GGhVLxrL/T6y7MU
         PcFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299891; x=1715904691;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gqJpZ06+qwlYgGDMURIHtEZ0g2cp0HVan8txW5tNeCQ=;
        b=ScmyhwT2Uaei44d1229RPRRHyH7AIAjpS1l4ZsQYHNQ+rz65kOX+hQDESzmgVAL1Zb
         9x2ZpV/jsYej+yQ1+CM4eOB6zlpqr/LzKhF4PWbjjR5pqvOnwN1gfqBSM3g344WoU0Ek
         CjcJXSzLMRBz7UhGZkiKMMVxWEizUNVdJszFig1N6BUj6Fzk3O5DWmWzxhIR6dI41dvq
         ISMVO9Jn7gUpoC/ETqx8uadY2Oy2Q5caCZPkJG/jTG324hTlYFLv5RqjZ5svqaim218A
         lXvtKMzud8nSMOedKbP1MS7KM/XGk/+9XIZmDWIM1cBOvuzUeZShzWXFx9KtqiCG2o+Z
         rQAg==
X-Forwarded-Encrypted: i=1; AJvYcCXJ400w3jrpwnjEa8ryaJ0/a+Bd591XW2M5iYZ6xcJabrcK9u+bCawj7lL8NX4hInNONIy8iMOc747y3SCL3NiXqsSW
X-Gm-Message-State: AOJu0YzG8D8kUdEhK1uq/PINv/SVFmodBB5PP9mcFdMjMTkw+Y81BHVB
	JwzNdBvQDPPrDYqxZ43UeMDuRrKMuaOO6utvD1YvsOprA+81Ev29b7r3hY/25mQeGYIZXQt3Y/P
	qAQ==
X-Google-Smtp-Source: AGHT+IFvnYt0ucR3iNwRUDByJjohutRzVbgCY1noF4/O8GrePk6IXOBinafk3bQLpiFMVdhzNUfEhUzwTzU=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:ac02:0:b0:61a:9ce7:90ea with SMTP id
 41be03b00d2f7-6373f599e9bmr2257a12.5.1715299890660; Thu, 09 May 2024 17:11:30
 -0700 (PDT)
Date: Fri, 10 May 2024 00:07:07 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-51-edliaw@google.com>
Subject: [PATCH v4 50/66] selftests/riscv: Drop duplicate -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/riscv/mm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/riscv/mm/Makefile b/tools/testing/selftests/riscv/mm/Makefile
index c333263f2b27..4664ed79e20b 100644
--- a/tools/testing/selftests/riscv/mm/Makefile
+++ b/tools/testing/selftests/riscv/mm/Makefile
@@ -3,7 +3,7 @@
 # Originally tools/testing/arm64/abi/Makefile
 
 # Additional include paths needed by kselftest.h and local headers
-CFLAGS += -D_GNU_SOURCE -std=gnu99 -I.
+CFLAGS += -std=gnu99 -I.
 
 TEST_GEN_FILES := mmap_default mmap_bottomup
 
-- 
2.45.0.118.g7fe29c98d7-goog


