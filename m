Return-Path: <bpf+bounces-30190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3ACA8CB71A
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 03:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B7F9B2432D
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 01:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16473FB96;
	Wed, 22 May 2024 00:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0GzILuDk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3CE38DF2
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 00:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339597; cv=none; b=JMFOoxBsgNMGXhmy/ssQbtPgMN5skaeYTB/F7x6u+kawnJle2poeSzVUN6N3m0yUtGqkGzr5uIU9HCeMHzofBk+1Hi8sc4B3kZTEKs88+ZKGVPJULxf2+zilgp4dp75JEqpRYsxyqEA9P6cKT9fLg+deAJ4dZ4Uv0FdYhPc/Avk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339597; c=relaxed/simple;
	bh=QlxunmI1UMNHVXdfUhGhzSfMamEMKYnucGTyrjL/sgE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PdwQO65D+rI7qT8OvM2kUD84bGhA7KPrZrTAYYrKXJ3FCaZajQV/DK+yLAffKKl+iuIa1bViatY5GqoQ4V+njbjtc3EO7gumGuPUTpJSkt2EKjqQ0euJxMULuSWsFrKJ2Hn1WdilcIVIzblecUFxPbXLUH65V9kDoSzid5vxVcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0GzILuDk; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-66957d4e293so3009550a12.2
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 17:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339594; x=1716944394; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AWjM7OsrUPOawORB4U9wbeNgOji92nYBHhW5FcjXqmE=;
        b=0GzILuDk6a0rcZe8QWnfWkAgVqclroLk8MUjIf1ofgo/ZtfRMQruqDKViQctf6p8VH
         3DRu/aqqL/GpXn44pTejvARWwpR+gpXF6mesPrmwW98FZ3XqY4/rx4XjS8a4f9BGRwkm
         RaJn1ChHf+KhLRZ0rjySjehkKyuVMuc2SUollb07ep7hgNw+mDp/j3iHv0+3dxPQwyAs
         u1VsrICVplebkqJTHOT9F5m6hyg6/k/8PDFeTE6bn2Z7DXo2yptRraXhcM4RLyIumcmn
         LglfIc+c+Enizsoq2yy7ltSf3Uv+K2Fg3rVgbZvfbZPc5dmw+qIaiyaY+rR4WwqWD9Rz
         FclQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339594; x=1716944394;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AWjM7OsrUPOawORB4U9wbeNgOji92nYBHhW5FcjXqmE=;
        b=P3/4jO/yxMqRubzBdJFqi4KAYQSapBTEwWZ+v1XnZEKYfarBf/Ux+qIowZ1wVOmRCr
         NOhlrB/tnrgOlrMp8wTgcpePPMmU2s57Q3gFb9ifuUwiU/z7l2se9IEgIvJaqkAI8sUN
         DDyRWPwzhp4721h0m1Uj1eK9hFiBYz3gxoeeryAkWEbW0NbgZ9UM9/uqq5CkSHiMh/T7
         ZP+7KCySQ9wrSs14LkEuU4I043v0yBM9X4jolYDtt7oIhN9R77Dv5hNv4YT/X7T2Bkkd
         nEWy/ZZTRp+s4Y4bl9P9zNF8/QqNRVq7YJlTOXjtOC4+EQSf6+zK2E/dezgVGfUQ8BRy
         rU6g==
X-Forwarded-Encrypted: i=1; AJvYcCUqLGPrXLk3VpPGweT2N6kmV7kLJU+89qK7NI3cwTNtAsbE+vDGdN+5UvA3Kvy1wVWqLxYBrX08SQfnOpJKCN2d/Gsg
X-Gm-Message-State: AOJu0YxIncYoubuKbtjHdx0pxCDUhbxQ8MsQHOD22rhsPNKJGrpqj0AF
	d4fpamrGPp0yWdVuQ24aLn/NCXCYWgdpMV1NuNYq2pg9na3YSx73718YCqTKBk8WVRVv23vgALa
	SXg==
X-Google-Smtp-Source: AGHT+IF+dXCrqU49ux2SHmZgWpvGHIfsSKPUFGkKjMCQnUfR9LpuorqbJFmyzygHKtz1jlIYWFlRGrTJeR8=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:da86:b0:1e5:10e5:344 with SMTP id
 d9443c01a7336-1f31c964eb8mr40835ad.3.1716339594265; Tue, 21 May 2024 17:59:54
 -0700 (PDT)
Date: Wed, 22 May 2024 00:56:53 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-8-edliaw@google.com>
Subject: [PATCH v5 07/68] selftests/cachestat: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/cachestat/test_cachestat.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools/testing/selftests/cachestat/test_cachestat.c
index b171fd53b004..c1a6ce7b0912 100644
--- a/tools/testing/selftests/cachestat/test_cachestat.c
+++ b/tools/testing/selftests/cachestat/test_cachestat.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
-
 #include <stdio.h>
 #include <stdbool.h>
 #include <linux/kernel.h>
-- 
2.45.1.288.g0e0cd299f1-goog


