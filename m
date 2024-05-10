Return-Path: <bpf+bounces-29370-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A48A38C1ADA
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 02:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CF52283AF9
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 00:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB3B132C15;
	Fri, 10 May 2024 00:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I14jRzgQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2001311B4
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 00:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299826; cv=none; b=DSnwna/KST35uQckdLB9BoPFwk6fUAqX8Eg9nl8JBk6SGPRzXnVQ5kYD9qoJbrQqTLs6UeVC8PYJkly7uiDi8laCYsdI2bO/eeep44TXzqtrZqSN7Z+d/4F2x7B/SmjvHsmFFh3N1IaZlAmB1BquKLw+enl/XkNXWmx8xAx1l2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299826; c=relaxed/simple;
	bh=E+1VpiDi85JXL9jydyuskBjbrlwZLObQo6bFBACsLOY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Zian/nn1zzxowpvJ1oUTUFhELHrFL3rtch8xFL9R8g2CjID7fEe8XIsH1AviTO0mhAi7W5H5OcxPtWaWMpirNNFd//QV4qqxkPKdRlxvEoR3dLriSXin3xC40ieKhEKQs3oMMiFQMCwjkJpb1iZb5Mc7nfvZ9BTF0obEuFeGSS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I14jRzgQ; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-61e2b365c9fso1275213a12.2
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 17:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299824; x=1715904624; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SutmlpPmP9Es0tW/Bsy7cVTmBXZ1L4QLiWxkdHQf5QM=;
        b=I14jRzgQVyA6vpo1xqWS6SqVIXqK8rE16OgSTDfGr8PnuJsQVGLB3XJAjrvhTvZHVc
         92eW2niQmUsUPw0HYdaceByizvygmwKTJdunxT5f3SgZucGvS1wAIgyIpluskoCLhjBb
         V26HO6CPwlnkutX46nZfvKslds2GcEpRuF746QeLXMv2bEEeCIS7S+hxb/oJrGsPZRcI
         +kHTSz2ASoj4StwlKfRsu9w95m3d8Ftwq+io8hGEHfyt0N99dYnyrEoH9y3bQYt17NxU
         NkRsnJJfbP3Choo5lDkO3gt11NG0b+Ms3MPF7/cvRx2mLDRKhjNun65m2lx8qIDgYxM7
         thiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299824; x=1715904624;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SutmlpPmP9Es0tW/Bsy7cVTmBXZ1L4QLiWxkdHQf5QM=;
        b=kogqJrBxrKjUWBnRazyQOh+UUsDNDocMApoee/J13YQTzEWXXoqAKf9mu6ZBWa/RSJ
         +NZoizIrI8Uf247cPDz4ftbjFne/C2y4PrDSjsb9J0QI37VagjVRuCdnN+xu5UM2zDg4
         oy0ZyfQAiahilMCVvx5yWPuWXFPK+wdYY44OkOwIaGkDgav6JEXXekTveywMlpMZBphU
         kDz9UJgbKR4s5Isg1jhRUaxWz4DkbXwZpjH8Q6YcNhPvVCvkQ0tkd0Vjrk7iE+cj2QSn
         dNAUaGrPecrI72XckNZyGxMWLB09sNprXCZMDJRevus6chvwAUEM5srMo1mB6cK5walm
         LoWw==
X-Forwarded-Encrypted: i=1; AJvYcCWJa3QGOc14Bk+D/NqRvv7s4oxL7mrTiIm/bp28Duk6pA1sqNtoonysjdFXrvnyOpLy7OVxTmAQ5Et83tKxnr33ORAX
X-Gm-Message-State: AOJu0Yx+VNYeXVJn55HKfuI4L1sU/Etb7wiW5Pec34/GpoQZH84aZo3/
	KB9GgKrl5a7YJWEcu4D/lBtXF7unF7SmW6gXSpBZ92r00y9SFB3umzFAUhOHhDGhz8kQWP/vCr8
	G3Q==
X-Google-Smtp-Source: AGHT+IEIehrU24eX0OqHRRhdZYUKWiYPftWJSgc7Y5tXd+qwfEKusHhkJB66OOWULkmBxo7GeAf8QgciojM=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a65:614f:0:b0:5ee:3ef7:a3c9 with SMTP id
 41be03b00d2f7-63744e04e8bmr1976a12.10.1715299823409; Thu, 09 May 2024
 17:10:23 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:46 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-30-edliaw@google.com>
Subject: [PATCH v4 29/66] selftests/mincore: Drop define _GNU_SOURCE
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
 tools/testing/selftests/mincore/mincore_selftest.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/mincore/mincore_selftest.c b/tools/testing/selftests/mincore/mincore_selftest.c
index e949a43a6145..e12398366523 100644
--- a/tools/testing/selftests/mincore/mincore_selftest.c
+++ b/tools/testing/selftests/mincore/mincore_selftest.c
@@ -4,9 +4,6 @@
  *
  * Copyright (C) 2020 Collabora, Ltd.
  */
-
-#define _GNU_SOURCE
-
 #include <stdio.h>
 #include <errno.h>
 #include <unistd.h>
-- 
2.45.0.118.g7fe29c98d7-goog


