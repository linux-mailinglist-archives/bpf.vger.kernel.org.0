Return-Path: <bpf+bounces-29389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 012FF8C1B43
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 02:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEB4E289BF0
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 00:28:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510C813C9BF;
	Fri, 10 May 2024 00:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3FScSGlq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1519313C808
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 00:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299888; cv=none; b=iQxHsCTMejVBKmSXW5EGxvj2mDiGe6drynhLFhNtKfX5udpOKMua7qjadJ5g2oyCYB9Nrq57W7P0kn3gblK91l+ludVlB0BTXDlZVjI/rUacex/i/VnDDoX7Z1xymM19+gyvfYKTGSFhLYJ2xBqzGAFDGIsVA3CZR8lS1o/L+xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299888; c=relaxed/simple;
	bh=015fKGDJxCO3CrDnV5eDhM/cvgzAQ9buUgF1iz0PEt8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XpoEx/TCdiaHCvwjbMJQRbc9BDxdfPgfG76laflR6CAebKdqLEG8r1X47+k1O/CdEtA9CRov+VK/OXXMbegwqA/8NhWdvc7Z1W/nofognhkQiH5dpA5avSNJwaLS3FAF28UYF1XdIw9MU+1isCtaRqkoqHwBa8VJnlnTQyuM3Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3FScSGlq; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61b028ae5easo24037537b3.3
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 17:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299886; x=1715904686; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3uGp0w2sme3T3nV0EQqTopwZWuCKWdcvzDVr+VeYxCU=;
        b=3FScSGlqmDGcfC8JdovJbEM9EuhrxxRbsTWucnnH3JnVcmqLWqoTGpjJUWTrCQj5pN
         dztuS4/Oeo67IjVhlqfYEmTeNIWaxy7LGvqPmZZ8Guei9EprhaBq+Dcbi8iUZaKVcBjC
         WTbJULVDyrUTKyRGaJdty9x66E4DHllvNOuXKNWvcH1lk5ZekPnz8enrJc8zKdGox/SU
         3nconxKC7RqGHpBWoi7h3uneVkAAjbf0VKq977I0OxD3aRSnalEv8GQ6S7iLtC5x4oC/
         fbXU7o9Gi8i4fQVENs159Xma+qs4ITj/qRdllxCjEg+8lAidX9yjGdprfX+1enBNv+uZ
         izLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299886; x=1715904686;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3uGp0w2sme3T3nV0EQqTopwZWuCKWdcvzDVr+VeYxCU=;
        b=sOAW/FbypR8xG/UiW94+puA0/mrVTfTv6uKrp9OAS2NMy/TvTCZslj0xquyHbB1l+/
         LTasYp4djqzcq8uc6tFfyjf3lKJc7IyLtAkHEs5OZpj9ZfHbJqJKAfJsJ2kc0YYcSSlw
         nYu4OQe5qUm15cHTCMq+Y3DSByYu79bHCk8rW9LsKxD4FVVnLxdI9YHK+hTmcLW70Qe2
         Wxh2tUtRUSZklZm3g/Pxeo/PEb+Mha/STVxU2xIkONVEO6hJaqkJzbnj327NAhi7qJIA
         f36lcJ4jLwhtlfwpKXFLi0ziFjxTk4c5yMSn1pWIT2qt54oLap4lZzzKK80yHcphh4vU
         SaQA==
X-Forwarded-Encrypted: i=1; AJvYcCWmEt2W4YtpOdgA7ytcweF3B0BhS+3nFw9wYRLG6UtH1VoHCv3OIVUHu+PlYYJ5/vc7RR4/TKg+mVwEn6XExMPFn+7Z
X-Gm-Message-State: AOJu0YwW14H36Cbzd7C36EG86uY1tP6TW7tjjJeyL8cE1oZH4XVvepGV
	VAxpp197u/NX8U0XbJUJbBGf1OVJCXdzFKJ+LN+oysWnCalEk0fNTYtdNJ2aE1nin6uL/YtsV3m
	zUQ==
X-Google-Smtp-Source: AGHT+IHM1dFUhZApSrq8Qk43aou/1xK0czl+ZTNebJ0VcRvNcsT7MvbAdQNPHgT1F2os/qMJBLL/r7SojXM=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:690c:d0b:b0:61b:eb95:7924 with SMTP id
 00721157ae682-622aff8202fmr3114617b3.3.1715299886235; Thu, 09 May 2024
 17:11:26 -0700 (PDT)
Date: Fri, 10 May 2024 00:07:05 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-49-edliaw@google.com>
Subject: [PATCH v4 48/66] selftests/resctrl: Drop duplicate -D_GNU_SOURCE
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
Acked-by: Reinette Chatre <reinette.chatre@intel.com>
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


