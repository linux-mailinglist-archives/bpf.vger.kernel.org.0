Return-Path: <bpf+bounces-29280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D11E8C16E3
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 22:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BE961F25302
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 20:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FD9143756;
	Thu,  9 May 2024 20:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RmwdionV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8111419BA
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 20:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284999; cv=none; b=BwHEdWrZSn1HTI0STP2FqBYbcChMc3TGShrzXzz0G+0iSPewqPLexdGyota03qRs/cY6utp94ZCxZO7LpsZRR1cP+kevVWUIvXzdbvmHYUdRC8P/fQkNOGrH7bEojoehEvP1punNALlmxlmQ6iNLAIg2uuowtrT/Zq3yvJ8dakY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284999; c=relaxed/simple;
	bh=5eCs2dGnvyXJyHpHcW99rKbYfAt3cSCAPK72Lv3waNU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L6YeLm35A5A5f3q8/Ulkm7JNW8EAre6NEc92LNcTbuW/iyeMoAGp+N8dmUGzVN2pQ9DET/sI4z9O2SUYoJEaSptO/M9tnWELPkttMgJzZfBGhDXo1kQyOFDS+QOJnRn7qZi1AcfKpaiYzMWwu8SakDIBJjxwsCHD6U8EfPR9/H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RmwdionV; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6f441afba80so1381875b3a.3
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 13:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284996; x=1715889796; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oiy7DTv1aGKmws/cPGkTZCbrHaB1ocI0/bjdksGN1y4=;
        b=RmwdionVv+lFDdu+RyCiQO9pHTCDcpsKoCMy/Hm4k/KSBu265s17AubvIt1b4FHP+E
         hBrHCt4GUddE1rzxZMhYrBI63XQW7/NFsoSnuCxOncp44vi8Q56oIGH6IYkNYJjyr65P
         JIKXXiGR2ARHR3NmCoW3KWOzWwlMNMbNeezpnRUruSAm1s7GMCuLb7vclVgZYDwZO3hr
         EAQZDdTbwVSdgd6t1WBFU8yz5yJlvA8925kaGbnDyZ5X0CiEja230arE8/dFqBKZw4Nq
         vnPEzjPCnL4qsW2BfsGnAJXqp1gFYEGQJnA6cDgX1Qu8T4YvvSAdD3Cngedwll6ekYnK
         rWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284996; x=1715889796;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oiy7DTv1aGKmws/cPGkTZCbrHaB1ocI0/bjdksGN1y4=;
        b=wlX5mm8w7kAQkiO+ADm+Z+5RghONT0+ps8emOCeE3yP8QN1mu15iXWCkcs9puoQV06
         3Ycpa8sKdIKubbV9g91PYM1NbZPkZ/52QC3dB3q+68N7h2jr9RRzIzxM3S8dXIfmtILp
         AM4pcoFoTbMXKJwcQfoI1cjPVT3+QzADmJBiQdd3I/p8JorEvbDfm+OyUMUp40J98pBP
         RcMs/vUmDIYBYBsatzpDD0rceY+gM2ISgYDmu0lUtKKG5BD3Lkj6sUoTZT5o6CEYQGAv
         5yvQPQHIOwRTED7jMZuGuLxbi+zoUx91Vu7O0Yn+F0VOSy4xJngq6USHxbA5NFpTeNx3
         Ghbw==
X-Forwarded-Encrypted: i=1; AJvYcCXTaus1jES2Q4opG/zLwbeaaGukuXFzYvakCgrSRHaGV0uP/SYpyWk+4JfXOhKmE1R1NOzAInfAUkeSwXixuti26pXj
X-Gm-Message-State: AOJu0YwMq0+K8Ghgkpd4ZqKY1lKnw+Mjdiukc/W9DYmw7DpryDMmpKSX
	BMQ+PBKYDdYinfrS2VmzaAiXFRw6GCn8kG+/VSYGJEgg02mp9wu2SonWs7zXuddudmsZRnd+jr6
	Imw==
X-Google-Smtp-Source: AGHT+IEJ/rJS6p21P2/qhLYsQGGVjwiajthmzURaTvAjOCnE9jf3eBCmxwF6D/Wet0iEWq9F++qDVmCDiHs=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:3d54:b0:6ec:f406:ab4b with SMTP id
 d2e1a72fcca58-6f4e03a195cmr28293b3a.4.1715284996043; Thu, 09 May 2024
 13:03:16 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:42 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-51-edliaw@google.com>
Subject: [PATCH v3 50/68] selftests/resctrl: Drop duplicate -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre <reinette.chatre@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/resctrl/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
index 021863f86053..f408bd6bfc3d 100644
--- a/tools/testing/selftests/resctrl/Makefile
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2 -D_GNU_SOURCE
+CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2
 CFLAGS += $(KHDR_INCLUDES)
 
 TEST_GEN_PROGS := resctrl_tests
-- 
2.45.0.118.g7fe29c98d7-goog


