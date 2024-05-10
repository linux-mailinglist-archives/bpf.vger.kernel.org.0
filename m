Return-Path: <bpf+bounces-29373-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E838C1AEC
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 02:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B5EA282E14
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 00:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7836135401;
	Fri, 10 May 2024 00:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bSQv2WLS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99D9134424
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 00:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299838; cv=none; b=Ytib45a1nYtWAV/J2iChOnvuvBP5In/ONBAM3K+W/WSLLkcTGk+GV6T2S1yM4xSLihfICCVomvWdsMRX1pM1y7xzI9DfbGkYYTpAHPL9WYgWkKjBJrKAJMQ0SveEtHc2WVPQzi/PcFewdv1zF7rPRR9IiCitoUBPk9eODfd4eRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299838; c=relaxed/simple;
	bh=eDWuE+8ZHJTvhDSqm0UqgHUs2LzpKlCgtgR/lrBU6/k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ftPiX3/J7x/dhxIEEzfqknB57P8bTx4zL86ZcO8PytJ5jx5Bt2iEvZFQpf4pTsTQFa6Z/gGzRbePac4lvOdN0RKwyG7KfV+cuzGhfQoCaW3QiGHX13DrREGEqahrQoH/G4jvVZgmArIZnCJBOEhhc4Tjl/o9ubPg1QCefSnP20Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bSQv2WLS; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61be325413eso18611547b3.1
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 17:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299835; x=1715904635; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=F6IDZpyB3UrvfTL2t0wE57nV4aaGR/g2u1ts2clTgN8=;
        b=bSQv2WLSopB2v+1KZm8IwOgLuHIEUVK+qZzBvEZW8TVdwSts91OolEh9nhb8DK0rJF
         yDDicW3806mNqg0SL+NQzL6WtN/R0zairyXk6vUBi1q5bF2ZisVhXu78Xx+ImgAIL0nr
         Ua7VbCTtenVKTD7atgq0SmFMZIK3eBOwuWRBKGEZfx4lt6vMIpIduZm9oJgNcg4D3LOT
         k7HonRz8SOGYaRAcj9BxgyV5m7UkZNo2pwjhv3I4C9FXPa6ci2GNthcoRHYb1jEceykc
         7VqY8+7PDjtl7GufBSi1bcWd8onQ7OANUnb8qH2ctcOms/mb202ckQh901gzOOMMjmhn
         PDTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299835; x=1715904635;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F6IDZpyB3UrvfTL2t0wE57nV4aaGR/g2u1ts2clTgN8=;
        b=TrHuqurGf28KMIxgrYp1AK4edylnn9E5JrokhK9qXbzoJd83Mo5eIJ/Gb+39ylrOWg
         mJka9czDrWoU2+u7J+E4JWflWaVT0uymPzLdFg700On/kFkjHDe1vCazubgXkm6+1p+B
         WqAh3eamhFOXbl+rtUo7RkIEKxEKzxBGg2pbnfKBcGPEiOQAB6aOGHMvjPY6ITY9ydv5
         bTmr7Ato0IDeMIJNQrBy3A0FQwuYNh/wP4rXFz51YW3SssMJ1u2864s6r3XnupYvzrm7
         El545+VrIGcEB3PMVjgOPu14kKQ0quN7O0xaq+Y7g/cT1oZpbUmla2/9VGdyvw0XljS9
         jDig==
X-Forwarded-Encrypted: i=1; AJvYcCVP3xxcDg917UITpPFzXitzZuQTogwivjgXScN67CAOPX63DLdetizJx1jClasb90WGBagS0vapajCvnB2XQeEVdVAj
X-Gm-Message-State: AOJu0YyiCVLisHTYXQqRwgZq1o3C2clRotfhW906JSoucCX0joSsC55/
	RyUWlBq8kgSltujNn+gC0HITtW7a/LfUcudLtiwGXDzbC5hmq9jcT8ffsu1CBMpsGfpQ1pxX5Z4
	WbA==
X-Google-Smtp-Source: AGHT+IFp9arQQjLfM7uxnfZTL7Hk72AcVMd0VRlUcaVAMmNJqDm8Jb/qv8j63n8u+Ogp+M7sZzeDo1rc4Lg=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a81:5b09:0:b0:618:9348:6b92 with SMTP id
 00721157ae682-620992cbc48mr10042437b3.1.1715299834767; Thu, 09 May 2024
 17:10:34 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:49 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-33-edliaw@google.com>
Subject: [PATCH v4 32/66] selftests/mount_setattr: Drop define _GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Seth Forshee <sforshee@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

_GNU_SOURCE is provided by lib.mk, so it should be dropped to prevent
redefinition warnings.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/mount_setattr/mount_setattr_test.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/mount_setattr/mount_setattr_test.c b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
index c6a8c732b802..d894417134b6 100644
--- a/tools/testing/selftests/mount_setattr/mount_setattr_test.c
+++ b/tools/testing/selftests/mount_setattr/mount_setattr_test.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #include <sched.h>
 #include <stdio.h>
 #include <errno.h>
-- 
2.45.0.118.g7fe29c98d7-goog


