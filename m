Return-Path: <bpf+bounces-29368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EC98C1AD1
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 02:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02B731F2430D
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 00:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21825130499;
	Fri, 10 May 2024 00:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VX+YBzTm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB2312FB3E
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 00:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299820; cv=none; b=UwWdUkAAgIh3+aPzNNfJHScEnMJ5gzAcsfa8EpXrQBfhaRZEJPd/h8+dYt4NXZNR9FtF8kEx5M/Q6rngrbwxERoYcopiPlYmE5s4AIAG8aDgBNZscCpGbp58EKibjn6QWTwbiqIpfav8NVU3fcBntr1SK3cOJjSpTp5PsPbiSD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299820; c=relaxed/simple;
	bh=HCpBdVfJG+s2iqOCbWg1zZn6r84Mcw7MdFykcaLHTfs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iBBR7A1S9zDfAT6wWp6xkTon3XDPMYgVFiKjUSYvxlByQbV/B+27bYftruCc2OLh9bL3TrIpO5al/rHfCbw+9P/5LRGlb1ow54lolwp978hP02Hstx3QuBUz3vgbK28xU5yknvL4qlPH9Bsae8NqzDQ0zId/CHCoXFjR2mZPjTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VX+YBzTm; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2a473ba0632so1361694a91.0
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 17:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299818; x=1715904618; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0S2ku+XXmuipqzeUWKEDXJqHDc5fSB/5BLcnzpP9HjI=;
        b=VX+YBzTm6FoCh987AXwEG0NGLU7ebn+8AqhAuxwgQAbqrWiTYYkJNuVzaI6ZzwB3+2
         U+UgQlZQgbLHcecYJoG9SlA64WQJuuWbBU/Zt6xNvzs+jPZ7xPAh59E6h2HyPqxBTUGX
         e9QjQ4OqQntQzPDLRD18YWLiu2yWR6uhSWEcFo6NWehVUHfbfpArrSrmTukzQfclUMrT
         fIpwukHGMyWdCNtr6pcKVHtwC8hQPFIXfJhEqDg4GIAdM9i2nXEDm9hH0XIpnc5dRBdJ
         TVKsEceJQrbXIDReYGDdQYl0O0hUiOT4WxEmxPLsr4Z/HGYv8iGmLukpAK08/TBCXfbC
         amhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299818; x=1715904618;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0S2ku+XXmuipqzeUWKEDXJqHDc5fSB/5BLcnzpP9HjI=;
        b=MxpE6pg2LJf/968p6B3ORie1PEaGiyfUzhseuGK6GTv22TYYYtA5TvUps1s6wyPXnk
         wiMzEVN9oPmp5BjXHyUvZZD1a4n8TQ9Ll0YTt7Rrhv47pTC4dPjkc6gcVOpF8U1bbSh9
         nqxQ3ij0dD5XL+kQusJRB6njLmxvMychj2OT3LmLEJgS3qIO7nfHLM675oKQ+ctBLc+O
         zlv5qP82JOMxGOFPfBjvI3WkG5rA18yoLdYZvH/sQYIhGiY3duvdTx414NDHNYeIMy8J
         D8Qiu70y9xaGltZMMgmfaWLLRPx74z5QV+yQ5EetvEFTTNv+1eMi6mAFYMq/vTAZzLjN
         Tk0g==
X-Forwarded-Encrypted: i=1; AJvYcCW/h3uVzci41Trs9h4aD//cNkT4BZtUOzOpb9FleCMhyTnm1UXu+erAxCiPvHXUOZ8LlPNdTGrPu5Wpl8FNCcyGhsYK
X-Gm-Message-State: AOJu0YwdagvL3Wx+MDmxezqouLtbBZtYnxdGwrRTTZcH7OwcBeIR4jQ1
	v+omrUlO6qGL0g+9o60gqHqLx/ylVjgVsUpKGJPfxPS/YSIDGy/j+bhMRaUjIqzRvBShA9FZZhq
	IRA==
X-Google-Smtp-Source: AGHT+IEvPxzG+VgbGLQZPyjTunSD2K2OGyOx1fSoHPtCs3xqRWSd1ujURjrAMGTT/wZYgXc+/eF9Tg8NW6c=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90a:5403:b0:2a5:dd7:1c35 with SMTP id
 98e67ed59e1d1-2b6ccd85d25mr2766a91.8.1715299818491; Thu, 09 May 2024 17:10:18
 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:44 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-28-edliaw@google.com>
Subject: [PATCH v4 27/66] selftests/membarrier: Drop define _GNU_SOURCE
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
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/membarrier/membarrier_test_impl.h        | 1 -
 .../testing/selftests/membarrier/membarrier_test_multi_thread.c  | 1 -
 .../testing/selftests/membarrier/membarrier_test_single_thread.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/tools/testing/selftests/membarrier/membarrier_test_impl.h b/tools/testing/selftests/membarrier/membarrier_test_impl.h
index af89855adb7b..a8a60b6271a5 100644
--- a/tools/testing/selftests/membarrier/membarrier_test_impl.h
+++ b/tools/testing/selftests/membarrier/membarrier_test_impl.h
@@ -1,5 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#define _GNU_SOURCE
 #include <linux/membarrier.h>
 #include <syscall.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c b/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c
index 4e14dba81234..c00f380b2757 100644
--- a/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c
+++ b/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <linux/membarrier.h>
 #include <syscall.h>
 #include <stdio.h>
diff --git a/tools/testing/selftests/membarrier/membarrier_test_single_thread.c b/tools/testing/selftests/membarrier/membarrier_test_single_thread.c
index fa3f1d6c37a0..c399fbad8efd 100644
--- a/tools/testing/selftests/membarrier/membarrier_test_single_thread.c
+++ b/tools/testing/selftests/membarrier/membarrier_test_single_thread.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <linux/membarrier.h>
 #include <syscall.h>
 #include <stdio.h>
-- 
2.45.0.118.g7fe29c98d7-goog


