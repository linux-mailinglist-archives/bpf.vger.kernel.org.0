Return-Path: <bpf+bounces-29347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB438C1A6A
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 02:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4976B22F8A
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 00:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D9343AD9;
	Fri, 10 May 2024 00:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RtOIeBtv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EDA3CF4E
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 00:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299769; cv=none; b=lyJyyk6lcQ70GEB/ThaWNVJDjrY5cBuUMJsX7fvESJxyBVvfTBBJS3EV8B01rcnnMDKuWNmU52DCGqI88jmcjQbRhQL2rMO9YymJDTnrdSYrTHNuAgD4BAblAy+orU5x+R1uADBbNRb4Y//akmDPF3xw4CnKFWXWKFoqiPW0gdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299769; c=relaxed/simple;
	bh=Fdnw/LwGdQmMqFSFPRAfRPo2jqnRXRxdYj1IDRwmLsU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hxKgxfQJOAE3F/ylRWIpCSZ0FlQh9IMZ9rS9UYRUht24f8Jc03TH5rTzjZCgja6F9f78A4RNlDgYfLpRqNa+6qshh1U+bIrbiaw+JooyT16C/CAWXplho4jnRiySN51donrNMhiGEaLazW8yl/1XdtgVVcVIlBbFnFgqAK5DJeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RtOIeBtv; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2b3fbed1a03so1381808a91.3
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 17:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299768; x=1715904568; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rmsZ7SnLiO3MTUumcGwO6/3xrY/wF9JsS2sT8ar9LKE=;
        b=RtOIeBtv8mdcccxowCto+UU6PjW/3sFZ4bKzPPgp/8moiiFsgtEIxyCuvBm+9bXqkX
         GpfkrM10ldOpKd/mz7GGceV/glKmzTrM3X/4aVt8z9rRWee8rQztzoVbHAH1UkPfM570
         T+e13MoVnQYr8DCcY+XS8wbkVe5Kvr+qyHXd/nTjfCllifWaotWX39y2VV5OsSzNChGN
         Snf+pJyQDqICdPPzXtEu1y1qVGJJ7oSxaJJgyUBOiayHFNKm71aIl32m43xc8Tgnnxyz
         6/gtOBexJC4LQnVbKmRl0ix4dJ197SwMAzee2QizIbu3Pr/jiz6XI+b5QX6zc9ea5zPE
         nQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299768; x=1715904568;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rmsZ7SnLiO3MTUumcGwO6/3xrY/wF9JsS2sT8ar9LKE=;
        b=EGCwjs2N42TPokDS5VV6vNt7iOqnLge9X0oGjZDRWHW7v46bzyjhtxAcMHNTU+XN+1
         ToNhO7lGocjZPCO75C0F9MWmqPmVZtH3uroTqKQRhfUq7u/NujNu8A7ji5jGQ6KQhtNP
         NSoec6ZV0lWkmMlUQbpilOP53w6ZupBcIjodmd6g+54RWN3fkjXQYkHPvXxiTgZPGe/O
         zZeRrucbBaN+LK41ZDwOWHOlrVnUEfDQprs2iAxhlvauVOEqmtepqyr11cNWzabRagFz
         6lHy9IOTrCmZd4a+GDnHpx5iWmnz2zE05Jt+m7WXp+37967AFci+xg54LiusxMS2NdEd
         7a+g==
X-Forwarded-Encrypted: i=1; AJvYcCXcmL2oJjAP0DUhSXn+ImVPie4bdGIEvRlr29GN7X3WVRG/9xbj9D8BUECeoXDqzl+pRLZe5MR+rP33T2hAuemM9c6I
X-Gm-Message-State: AOJu0YwQOZiB9EZDxzeFwMPP1wk80w4pHJa/6OnoDyqgz2qeWpbl3LVF
	FUG/rPAAr88OpmciB7nsOrBcfHUu9MD0hh1gz5kxtonnwdTX09wzmNEHkbduj0ZHumVqCUm792f
	9bw==
X-Google-Smtp-Source: AGHT+IHvQVIM4JeR4ZgqjanMvc47tQdjM0e3oJXcocG1JkFtADLA104qts/GHMikYPcxHp/Zb6DHY6Ww0pM=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90a:f695:b0:2b5:af18:6465 with SMTP id
 98e67ed59e1d1-2b6cb7d0d50mr2811a91.0.1715299767774; Thu, 09 May 2024 17:09:27
 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:24 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-8-edliaw@google.com>
Subject: [PATCH v4 07/66] selftests/capabilities: Drop define _GNU_SOURCE
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
 tools/testing/selftests/capabilities/test_execve.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/capabilities/test_execve.c b/tools/testing/selftests/capabilities/test_execve.c
index 47bad7ddc5bc..7c37ae2407c6 100644
--- a/tools/testing/selftests/capabilities/test_execve.c
+++ b/tools/testing/selftests/capabilities/test_execve.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
-
 #include <cap-ng.h>
 #include <linux/capability.h>
 #include <stdbool.h>
-- 
2.45.0.118.g7fe29c98d7-goog


