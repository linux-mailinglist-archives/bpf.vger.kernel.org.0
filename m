Return-Path: <bpf+bounces-30198-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF348CB741
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 03:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79CE2281CA0
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 01:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE078526A;
	Wed, 22 May 2024 01:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JAmk3JAn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A5279950
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 01:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339617; cv=none; b=ixmhRgj+eww+OCe7w+U4KThUEaME7CFXngJZAalsAI9xKfaL1zd/tlRQFG6CbjlkDkL6XANmw4jgt2SiTPY4Dz5BAAcqy3XNjcPmywvSTwO758m7g99BmJBTgaYT7Sd854IyFtiD4rrFn2DFeQM7MroPSbqb1CEIVNVhrqvUBS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339617; c=relaxed/simple;
	bh=bwGxj56rDXZcmxX6KG1pualMpakVJVhSxYm/fRQ200M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TDRqCYX76pqxfn1A5MNCldbt189RIdBYUag5p+rJk9df1YCakSHszHR1am56X1wA61lNPh5KioYzgtecPFntBwZEVYikSlU4IrLCTjp+0E4Wq0UU6ES7Vq/hhYdjPQQsSLguVom2PCsRswc9sBJN5lsDRsycm2wT7tEZFYTj80Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JAmk3JAn; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dee5f035dd6so20429478276.0
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 18:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339615; x=1716944415; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SekOhk5uN00IhSEFy2Kx0Wz+un/KHciPZvQ+RL+rSjU=;
        b=JAmk3JAnfNrgh3tRLQx5oNewyBfaUFGJko6bCu068aDSwyY/WqpBD1KPiBOFmgkZf0
         OvHd28CyFtuEvSLmUgbiwDzanC6HzvxULQDEPsl4D1AN2AD2QtV700LQ29Fzk95hyoSW
         3uzTUFqNt+wCDTQY9uKhGsiHum6NspzXYvR/9fwEPdOSaOyk2WK6j2dGiP89Ya7mTMOV
         3WBECTHP0/YhJPV434T/v4/e0Tf5/+UAYOGrnAvbkxJC9sBj1ZXAS8m417pqHXMsXhRm
         1DHQxjUfjdqFrD+6ULatygRIo8FnSuM/d+5dcYX9icHuRe2ROC/TYooC9wrwIN2JTHuJ
         ctqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339615; x=1716944415;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SekOhk5uN00IhSEFy2Kx0Wz+un/KHciPZvQ+RL+rSjU=;
        b=CCwebYgmhoB5i8lSbsltyb82kWTP8Y8HHqHe7zCJe34pAGoUPeXjnVpJ8iVlPlEykd
         amIPAd6VH3BBA/TiFI2Yw8o5UrRDFDJOP0KXyFBUE6p01rTq8k5Os+0GKynr2rbBBoyw
         zD9IhJayb+KxnU09AtLCr/gINwU6oaicbPFwNNTv+fDPmB7KUN1dulm0m54fMgXcDDYK
         b7pH9ZhhyVYJsifAuRUMdF5k/Ds5qyjW8iYdFYaWkyT30v1d0mOyt6hYdsFf08DwIsy7
         IRTUfXr8lSd1G+SZNa7LD58AQsWGkjsKuKa5lLjnRdCesPV2yoTwr76c5Ur3DREiZlfN
         njLg==
X-Forwarded-Encrypted: i=1; AJvYcCU+kY96sYfuK2DdWy94Dcxm3AZn9KneUjG1EGgxXN3Zm9VRgNNbODix0632yaSDS4El4UltdphggX1YExCUBwDw5iJU
X-Gm-Message-State: AOJu0YzxI5yGW7eOZuUu77Q4TDV1Q7b8Y//Ovz9obvzMGHnId62jJpY4
	n2HZsIJ2i/d4uesVeOlaU1c1Mf35advKcWsDKKgOM5dh+YL57d62FNxL8PXdRGLmg6/jy6ArPt3
	M5w==
X-Google-Smtp-Source: AGHT+IE9bSYLh/E/LGMxrrx+sHbG1nGNJ4Z5EJs4Lw6O6tg4A/yJwqWA/HgEqsXHwdInVe2s+KZjs0ddQxY=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a25:2e09:0:b0:dc9:c54e:c5eb with SMTP id
 3f1490d57ef6-df4e0d5b5d4mr203793276.7.1716339614945; Tue, 21 May 2024
 18:00:14 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:01 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-16-edliaw@google.com>
Subject: [PATCH v5 15/68] selftests/fchmodat2: Drop define _GNU_SOURCE
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
 tools/testing/selftests/fchmodat2/fchmodat2_test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/fchmodat2/fchmodat2_test.c b/tools/testing/selftests/fchmodat2/fchmodat2_test.c
index e0319417124d..6b411859c2cd 100644
--- a/tools/testing/selftests/fchmodat2/fchmodat2_test.c
+++ b/tools/testing/selftests/fchmodat2/fchmodat2_test.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-
-#define _GNU_SOURCE
 #include <fcntl.h>
 #include <sys/stat.h>
 #include <sys/types.h>
-- 
2.45.1.288.g0e0cd299f1-goog


