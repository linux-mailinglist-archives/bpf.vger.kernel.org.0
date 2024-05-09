Return-Path: <bpf+bounces-29281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 879378C16E7
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 22:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4203C284310
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 20:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A65143749;
	Thu,  9 May 2024 20:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L/1OkajL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B93E14374B
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 20:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715285000; cv=none; b=cIzohbUHcPUd5DuRKE4hhoD4cse7N2N9fhaCSJvgiuA/YK+2kBuCtd7QbHhlYtFQCm10dAUt+4ENJr7ByxVsnbeQu/qoer67X3LTmn1WW5Q5eE3ifImrvICtIgKzMRiD8myrGHZiSnjMLKznxoaJTH8pZUyonav/plJOn0aIfbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715285000; c=relaxed/simple;
	bh=1k9pJ4Bc1nKNaedfe0Z+6a7iznCVlqHkWeOluNZawro=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VYUeJab22Gsunkbkhw145VUBupVVplGF7nMDPMsP+sKs3Lz5pf7Pb9EKyIvcEzXjwUHwOkYjIeN1Jcd6U3BlARI/A8PBgRqVBlKMj9Z6a2clpvsXnF1E82HX1OqDcIcUyQ+XXa64hj7BOe2u7dE7K7Gc8GYWvcle8L1oJuvfDZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L/1OkajL; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6f46eb81892so1255879b3a.0
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 13:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284999; x=1715889799; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1HIud3j7hw+SCl0gZCLxmuOdO359mwG6ZPGgmENMsjY=;
        b=L/1OkajLZpRcATHRdh/Ju7zCrJSdP32/LXyjZTZchsekpWkEOn8eCAR1ncrpuRj+Lx
         MmlfP/x2NUAjBokOhLqkkVSBhm7xFAit4irlhZBH84L80tZAT+yojCImDe2VCrtquVsJ
         vkj1CN8KmmHbqkSUCeLtzOCP3VPM9uayn//Bo09YVZ8q5JIbjpPoS6e2NeC1Is4GBEN2
         87XnIjQkbzZMGABVDtBJmIRO0leRsxJpIcGVFWeMxFYGfjnXHx1YJ3qAeX9gHw5xd9lF
         zLAyk29DsBfuiLbY1pvGdBygGSVsSPHODwBoORCb8qcRWva+JfErzslJnETTwtz5/YFy
         A6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284999; x=1715889799;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1HIud3j7hw+SCl0gZCLxmuOdO359mwG6ZPGgmENMsjY=;
        b=OTPaWrrgP+CP5upUgc5CNebafEJMlRuHm7BgZtWVsDwodJgquEH2D9mIbxyJoihBWR
         uIepFYx8Y105p/uUsfaBMrFQ8CaN/iD+9DGzkyWmBvIxqdQXc8FwjuTw8vsrDiwqUH6U
         Vcv55VLdUK6wnVCo8w1+2wuL3ZMUtgTMoYOuiMp+flYDreo8RsLrJtUJMUQfu/H5FZXq
         TLon7x+K6MByUNYWExxvBzSuyxsnsOJeFLdtjwONP4jJy+fWTDW176fyYkeZyQgptV0X
         /ivuXGFhI1oJwGlXAX6SMDTOTwAcupCRz0znQKASRwuzmS9al0W5ENP/h9HLVYuX7NkN
         l5OA==
X-Forwarded-Encrypted: i=1; AJvYcCUnpWeU2rpZ1gS+IOs8LPymv6TztrzwSuQtKVel+JVWan2oQjl4rg28ZCZ1/H2KVdPFgu36SYhMLkvRLAzpHK+mgoiu
X-Gm-Message-State: AOJu0YySwHCx8aAXqbbp/BzEyDg6TVXEjifMPbzAGEPIFh0PP2XCNr9w
	XizAesG1BOClbF26ui9V5dEJhK17gV2i+yYv2BjpBs9XeoBzLBLJLwpdKSa3VZy6M18pOfghw7N
	MHQ==
X-Google-Smtp-Source: AGHT+IENgmr10+nzjNcMdhdNDTzER9b53y/mst1FjhAtj1Qm1Boi+WgJ7sFW+pHzHKduriFjFIhfQXMw+Ho=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:a91:b0:6ed:ce48:f194 with SMTP id
 d2e1a72fcca58-6f4e0296348mr32533b3a.2.1715284998656; Thu, 09 May 2024
 13:03:18 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:43 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-52-edliaw@google.com>
Subject: [PATCH v3 51/68] selftests/riscv: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Edward Liaw <edliaw@google.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Fixes: 809216233555 ("selftests/harness: remove use of LINE_MAX")
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/riscv/hwprobe/cbo.c        | 1 -
 tools/testing/selftests/riscv/hwprobe/which-cpus.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/testing/selftests/riscv/hwprobe/cbo.c b/tools/testing/selftests/riscv/hwprobe/cbo.c
index a40541bb7c7d..4de6f63fc537 100644
--- a/tools/testing/selftests/riscv/hwprobe/cbo.c
+++ b/tools/testing/selftests/riscv/hwprobe/cbo.c
@@ -5,7 +5,6 @@
  * Run with 'taskset -c <cpu-list> cbo' to only execute hwprobe on a
  * subset of cpus, as well as only executing the tests on those cpus.
  */
-#define _GNU_SOURCE
 #include <stdbool.h>
 #include <stdint.h>
 #include <string.h>
diff --git a/tools/testing/selftests/riscv/hwprobe/which-cpus.c b/tools/testing/selftests/riscv/hwprobe/which-cpus.c
index 82c121412dfc..c3f080861c06 100644
--- a/tools/testing/selftests/riscv/hwprobe/which-cpus.c
+++ b/tools/testing/selftests/riscv/hwprobe/which-cpus.c
@@ -5,7 +5,6 @@
  * Test the RISCV_HWPROBE_WHICH_CPUS flag of hwprobe. Also provides a command
  * line interface to get the cpu list for arbitrary hwprobe pairs.
  */
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-- 
2.45.0.118.g7fe29c98d7-goog


