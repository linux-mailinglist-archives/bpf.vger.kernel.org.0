Return-Path: <bpf+bounces-29394-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FF58C1B5D
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 02:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B18532825F7
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 00:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7ADC13D63A;
	Fri, 10 May 2024 00:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QP679QKJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518A613D535
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 00:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299902; cv=none; b=p5Jt1IHsl0htQJ/HrqNl9dHNaOs4dFYBqkGsFHeeGRh5s3ercNq7h29B5cc3mpqJ7sD4BLYTRpPewYgluImfjmqX5AkuAOuIbPf1j1/7b1X+Narhbla1H28i2TEBoxitWuXQfEoA0xjGC2yli39/hkrxXJvmTwps5Z0hUN/VDIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299902; c=relaxed/simple;
	bh=JvbDWxGt73x+3I5wycvjFh+GG2YkBR1D3FMaXjgEOUM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dAF+LYDlvejyNaYt/b/m+M75ZovXMJiR7ZGUj0Xvb2jpBLlPuGPZoHUzGJx/00VMBCxjkUk0d+320ug7XIbctmNDICNu4wo6TV3XGfDWzVbiurHq+rAzev4vD7AjrhQxiwaxO06uChfJEL8pL9PTccx4ABbDSaIB7j+fzsqaSgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QP679QKJ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de604ccb373so2283878276.2
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 17:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299898; x=1715904698; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0WWgoFurwAg8h9SR6wezGd5h5K+Y3bRntTGdapCnYLQ=;
        b=QP679QKJ+YJmUJRm34oeIG2z2fV+eM5+XdTrCwfV3+3XDob7WXz7VcW2vVJIl+ymif
         DtsIA/CliHTTsjmF5m0TikO7867fp+6gSTDWNVuL3FFExEU3lt/9RU9o82DqKRskInMw
         OUFYnwG/v9PfiyXeX5L9a3L/9VCdD2SY/k6Vd6j6Uk2h3tmyZSBVROJ0UxTUuA46x5zY
         sD3BGmKGBS535ty0/EQJhQEGQZ2DYWvrLvXb4IVftMe7RDGttpOuusFpaCgbrQ/EDJyl
         UGhvFjlABNB2orh/7PnnVebuPNvOjyXbkW4MeLCVvvFpXQM2O4n6Aevfb5DeH5PnK799
         WzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299898; x=1715904698;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0WWgoFurwAg8h9SR6wezGd5h5K+Y3bRntTGdapCnYLQ=;
        b=ivixBMbt1Tr3JstOX7KAgjvR23yrMtJP0XZLr04HS4FXicfnqu3kuuald38OhC2BjR
         O5ChMiKX5H9LIrUi/0Lz3Fq1NXcULBzJVn11I1UNVcoa3NDBKDUg06DZnzoj0Fg9rt13
         cFqXSeW9rilHChXWSuG3DGim6+zEIEmp4//Zu9iQWuuAt9JpM+JZHkyRaeLjM2h9v2WO
         CMgCoGbVAcyNXoj6dUtk2/nVmzdm6P8vligqlJQWN58zrA0FdTsmXuEm28eXuMKq8bmk
         Q9CMbdlIpYYv4fTv5RFYbNHnF4HBhlFJCtoW4SUrWScyGFEomvMtRwO/Fxky/WRtmUVx
         Kz8A==
X-Forwarded-Encrypted: i=1; AJvYcCVP3e78J8tepEbmR3wYATnhJwRIIViAvLlk8NCKXYRvkLzup51PXyA+C2a10fqD40nuwKAItx5qkHjvglRkHdsnwwl9
X-Gm-Message-State: AOJu0Yz5jHdzHmlNn6EQx/8HiITx1Li8ChrFPY2b4FBx5NuAsgvQvUdA
	9UsFkhu7CJBqGNoMMsCG5xv6Tn2CSKMx2S6o7xFPOh74v27vHo4dT/yOJpbeub12U7pgT5V4cWa
	rdA==
X-Google-Smtp-Source: AGHT+IHvqoyfuJd+zpWyzRtMJpM3tPkSIvIsjPanUafDlQuCX9siiHmpPTAd92EjaLgk71HiYZjK7/db9Q4=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a25:b31a:0:b0:de4:64c4:d90c with SMTP id
 3f1490d57ef6-dee4f4fb5bdmr99366276.12.1715299898422; Thu, 09 May 2024
 17:11:38 -0700 (PDT)
Date: Fri, 10 May 2024 00:07:10 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-54-edliaw@google.com>
Subject: [PATCH v4 53/66] selftests/safesetid: Drop define _GNU_SOURCE
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
 tools/testing/selftests/safesetid/safesetid-test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/safesetid/safesetid-test.c b/tools/testing/selftests/safesetid/safesetid-test.c
index eb9bf0aee951..89b9d83b76f6 100644
--- a/tools/testing/selftests/safesetid/safesetid-test.c
+++ b/tools/testing/selftests/safesetid/safesetid-test.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <stdio.h>
 #include <errno.h>
 #include <pwd.h>
-- 
2.45.0.118.g7fe29c98d7-goog


