Return-Path: <bpf+bounces-77021-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D2ECCD148
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 19:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9B1C1303BE8F
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 17:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA8830FC31;
	Thu, 18 Dec 2025 17:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvzlD5m3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C586330F934
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 17:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766080609; cv=none; b=cxW/RCTAcFI8c9eIei0tCVumHhusdoJFqkJZ+csUVeQhkPIfa1o9sJZERmtUhINboLmicuYQcocLI0//ju9+9Nq1m8ZRj+Ug2w2dhWgkntMwQbhSucCg6AFOWZDjnJm/E+jTsvUtb4Er1TDf/EVzCTogH2copOpJFaeuzJacteU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766080609; c=relaxed/simple;
	bh=An8BnmX9Br7RS5E/JK5+AuLgGH68OZSuI8tJGKtCb0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dTGxL8CVKR29YCvCCjg7UkMzhqEb7HxShYxVSwZj736aoEyI+dgW9PCFcaJI7GHuKG6Lr4JlWSMtuTzF1ZW843yWGovSaar5/yi5i1yKITZ4BbTHiWMEtXtPf9ZhERqBxt/aIwsZJyULydiL/PP23GZnM+ypSv2O3kJ3bAbbZn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvzlD5m3; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a1022dda33so8190465ad.2
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 09:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766080607; x=1766685407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nuNvMHG7EsV3WDXcTIQ0sCJGxiwxkoeLevbL1JCpO94=;
        b=CvzlD5m3nHccPfxyBLLit8EDHYIewJo7Z2MFSKa4fNxUrS2wwtR2wPsGqS9zjilw6Y
         mGKcWdnLRaxnwMuwjvz0IQIto8ei6k+eZ2hLY+BKLuy1pPP/rRPhWku94gCBpPAVK3zl
         q1rg06fb+ggWn13qSmirEb8150uGYARrYeyrfB6MAHn4LNfA/xdylDG7DHDM6PB4D1lv
         OkksNAZ7wAVnWb/hZWA1MZpEZk8TtQWR9O4KgJa9MXaUjZQMfdNymNnO9AAE4kY2qOmy
         N/pPDVfC0TAPChq0mivSxBvlQ9C+1obMltYxuSeBJ4KzwI2kCNen+qmIFbpU/59KMLtz
         8G5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766080607; x=1766685407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nuNvMHG7EsV3WDXcTIQ0sCJGxiwxkoeLevbL1JCpO94=;
        b=uW6DNr+3ElttQM+TuXfowmEANYLnkh+Fy7dTCjNR+B37NHlgBWs2PL4MDAfa4hd0dX
         Hy7Pg3qe4huD1crn59KdoiEls4S57cbg9xOsmccd+d7A+q6OjIhsu2QKFUFf9JvZ10Pu
         eM4NdUxZR6KD9tNIq07LDsRQe4DVVfoT6UfRDWPIMUs4qjsePhif9jZ9s+iCsp0xfz0a
         hD+lPrGoD+Yyer0uirHEp+eBmpTFm2WXZe+9KeipJIsWAKZh66hO0hr9X/UdCkVZ6N8S
         HWr8V0rQPbSbaa/8lCg1MoIu737Ap5nUM7r/51FcIHKZsSJ15djvPiZnBBkjPiD1NDD0
         unsw==
X-Gm-Message-State: AOJu0YxJGvhTIS9sK0g7rct+VrvOWdH5zmjO6NqP/kLsiRA33lQ1evQQ
	wTabj92mD00w8a39yDWSrNprf8jmZ+rKum80MKtKSxm6USiCDX6RfXnqu+fewQ==
X-Gm-Gg: AY/fxX6bLhp598bU3UxVmcd1/lLheqFsWDalviz2EH0oR6dVSxSyrpB9OPuN4jcH7L7
	MiSUHMyG7Z7aZThuFUNqEkUZBaMgwccLoIfC+L13Hc5k7rEv8kmN5Y2aXfxfZn4V+IflquLwCJQ
	QBhB0CANpLo7+F0UGJ6mIXLNuGVol8hPOmFVmx48wE7UblR3jA9/JKdCcE2Ogeww+pS4HysEjwJ
	vB3LaSzROtIV0VvruRFnb4PUEm02PHPlN1GTqeBTqS/DlM770Wb51FOrEow8Qz+3a09sItl3VtQ
	vH6MfYCNgWkN+eyVHzeU6b3xkOKyXebq+O5zGIn3pQLhOpNBI/S+i/XyxlAj9dIWq4ZNT4910fv
	fxrRbOkqZg1ov/KSqU9fGDOCj3RKq8di3Ra6ZagJWFfa4gIv8lDChUlk1JjKq0LvlE1KTb7t0cx
	dnuTeQBFFZQz5ZKg==
X-Google-Smtp-Source: AGHT+IGh2Lk1XMg+o0oiNmR3d12OTi1u4MOPjiFlEQvGb37xjw/US/MSn/Va6np7AIN+1z1t/e53wA==
X-Received: by 2002:a17:902:ef47:b0:297:f0a8:e84c with SMTP id d9443c01a7336-2a2f2a4f69fmr948745ad.52.1766080606831;
        Thu, 18 Dec 2025 09:56:46 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4c::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2d087c8absm32397025ad.10.2025.12.18.09.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 09:56:46 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	kpsingh@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	haoluo@google.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 14/16] selftests/bpf: Update task_local_storage/task_storage_nodeadlock test
Date: Thu, 18 Dec 2025 09:56:24 -0800
Message-ID: <20251218175628.1460321-15-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251218175628.1460321-1-ameryhung@gmail.com>
References: <20251218175628.1460321-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adjsut the error code we are checking against as bpf_task_storage_get()
now returns -EDEADLK or -ETIMEDOUT when deadlock happens.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../testing/selftests/bpf/progs/task_storage_nodeadlock.c  | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/task_storage_nodeadlock.c b/tools/testing/selftests/bpf/progs/task_storage_nodeadlock.c
index 986829aaf73a..6ce98fe9f387 100644
--- a/tools/testing/selftests/bpf/progs/task_storage_nodeadlock.c
+++ b/tools/testing/selftests/bpf/progs/task_storage_nodeadlock.c
@@ -1,15 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include "vmlinux.h"
+#include <errno.h>
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
 
 char _license[] SEC("license") = "GPL";
 
-#ifndef EBUSY
-#define EBUSY 16
-#endif
-
 extern bool CONFIG_PREEMPTION __kconfig __weak;
 int nr_get_errs = 0;
 int nr_del_errs = 0;
@@ -40,7 +37,7 @@ int BPF_PROG(socket_post_create, struct socket *sock, int family, int type,
 
 	ret = bpf_task_storage_delete(&task_storage,
 				      bpf_get_current_task_btf());
-	if (ret == -EBUSY)
+	if (ret == -EDEADLK || ret == -ETIMEDOUT)
 		__sync_fetch_and_add(&nr_del_errs, 1);
 
 	return 0;
-- 
2.47.3


