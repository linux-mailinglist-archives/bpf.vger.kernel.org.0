Return-Path: <bpf+bounces-29390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 840E38C1B48
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 02:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39A70289E47
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 00:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BAD913CAB0;
	Fri, 10 May 2024 00:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n3O2IGWl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5081513C9A0
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 00:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299890; cv=none; b=lrnLrELCHfzSj9rpbohbJQu87+VNekxfY1oqWfyNElxva/M+2I9+9a2Msu6cB+UAtvbjWlprsZnO/KyFz63WPRHS09qbtQ+CseL5xNtDXis6Xr+uTLerovcVKMAOwEacq5PF09BzX9+eXvnzcTUHH/WMGFtkA0xCPsNW6OoVkto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299890; c=relaxed/simple;
	bh=IBU/NuSGvQtjM8xGos15Pkr68BKEzjA0BEJAs909nTE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NWGG8E5BY3eRAV/em7NMTZa9OpMXs1i9MbUQjA1CLsUd575vuv1T8ZsacJbKE1E548Mxe3prnf1jxODjz+npITdUtac3SF3FnYD0URZPLDqC/lc+zz9Q2kKrOpT0+eZaXmWME7cxbaY5n3No7DmN8HXY4luT/nLfP2/3u3FnF/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n3O2IGWl; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-6f4739ba7dcso952725b3a.0
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 17:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299888; x=1715904688; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LuB3m194wkKvY0eVyf5M25YoLPjrODu7ClV5j+qOpls=;
        b=n3O2IGWl9Zq/A9XSyxaDukijDRxz4BJN8dyJcfqn/PgAuljQ6MlIQg6efMlRXmQLmH
         Ah/YGdfxBXT0GSBU80V9nlhmftG/eMTKYhWhoAbriXxWU16AsIWTzlHu2+0ewttgStuq
         QDCuRM4jd6VY5+UZ0RhfyBNYp5YmDlCg5SW0Ckkx5G4y0fUal5J2JlVcoP3gDCuWwkec
         BIMyzRhmVDktvY7dMorKjN2AuXyrctG5AI19OaH4ElKSuZHmQ7wWg9H4hL29JGibQI1k
         gUFLvJBRLUULeR8burOiKNGTX91qulll2X/xGwt0HO1d2t1q/Uxu/qvVatbq1SFt+gwx
         wbjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299888; x=1715904688;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LuB3m194wkKvY0eVyf5M25YoLPjrODu7ClV5j+qOpls=;
        b=aqHzsw8bBcWbeV9BjB7DwD1EF6tAIU6tsw96n55HM2SQKYKOCYUkP434dbxvfM9aCX
         yj2v5ei6MUKNxyJ/TkfPBG7MjAyCD2MStA6OAdM279TzMzbhVjv5kBurQW8I5ywgLcJK
         v3LfN7UFGPqWVXAnxUX9UTSIcegjTZg1ZbvrokGgCiIAvgLHpqq3UKBS4M30zFO/MWoM
         3LE19pxVhnvlR1siUZdgTdcfculXl0a8yEOFif/oFZnY2r5YLzxHxe8jIp4WIQ6QF5W3
         ZfY7NrM8BTi0+QU+bbE4oFwEe2RMvkAhPiHv/H7H8mSPisStBPvlVWRc96L+aQt7XtV+
         Hcag==
X-Forwarded-Encrypted: i=1; AJvYcCUhl0YP0gSG6BaW+Xfs2Xyy0B49hL3/fOrC7z+EEBYZc/j6SOrDyEypA8XREPQal9mfBUUGGBMGMQObmvD7+TUXY7ca
X-Gm-Message-State: AOJu0YxhNv4YtQ+oOtCd2vrhHetOJzGFamEE6tOW4uOBq6BeRLluAcZ4
	BK7K28c2c7P1l5c/+nD6UeQnULKr7Lj7dQhosfLPz7jzRUvzBnRswr1z+QSkvSmG30LmbaQ3CLj
	69w==
X-Google-Smtp-Source: AGHT+IEAPDmiCGGPRhY6JBRoUT6dlR+CkZjrxhOj+xsSstNk+8V5LsggLR8ug+7H1pKBdhGr0v4AK8MG9gc=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6a00:17a0:b0:6ec:ee42:b143 with SMTP id
 d2e1a72fcca58-6f4e02ad1f1mr31327b3a.2.1715299888557; Thu, 09 May 2024
 17:11:28 -0700 (PDT)
Date: Fri, 10 May 2024 00:07:06 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-50-edliaw@google.com>
Subject: [PATCH v4 49/66] selftests/riscv: Drop define _GNU_SOURCE
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

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

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


