Return-Path: <bpf+bounces-29403-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D60A58C1B8A
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 02:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31279B2421A
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 00:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2049C13FD6C;
	Fri, 10 May 2024 00:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dZh+XYWO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D6513FD68
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 00:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299923; cv=none; b=YIpQr8YrIjOIwvmQtdRdj2KNxDOHlMc2TVIpqSr1Hu2WZupflTMBNU2nN6QHt9gH7ucVHxOuBE9bcNgsMMx+LSfQIx5g+7D4juxWLsKTbYX38eEaewlak+FJEQa/kIWmo9B4pPD3ij9VjCiZd3LlPX4reGDONoRzisuGUs+FZrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299923; c=relaxed/simple;
	bh=nvF8uJuNaWpgJDptnrpeGSuj5a+FC4vLqICGTcLZizo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B6ZHUJ7XctcQTpCZ+rS0CH+GU/R4ksUeDDKIjN4fD10lhUrrCUrSFRtOYegpvqrGTpCGWBCJipKslq2E80uetdQWnEaH+MDnTbEPzz1HhHNgmF3z0tLTUupp08IduMkue57b+RGnpnh1UNNhXo6+aaiiwKshQ4Wjxt4l3da0g3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dZh+XYWO; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61be8f9ca09so24890037b3.2
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 17:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299921; x=1715904721; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dlrpveSTicTC1QjgYgHoRdW1gbJlSbbGgHtnkq6hedQ=;
        b=dZh+XYWOgf+/AplIGIMhz/1uF6SaPCohqCusfifTMnJTFe3M/dupFqcPmtwg3EwMrw
         URRnwjBO2RYwqQc7As4GKtiM10xjBc5MEGlCQUf+fXpC59ph0iDNdVenzhy5X/zls/XJ
         b/ogJ4vajCNn+L3WkJ+MSc53q5youHG508jBxTr3zfLKBwXUKgu5y1HVLg0oYtZMC/NB
         4fTf0EyQuzBR13quKNKG0hJAOiY4BDgfEN9OL2xekvho1nLxULMch1dCc6WO6sOo6fll
         3GpDz4yyi5d5+DdMXg1A/dVfWS/u/i7Em5w4qjoeaRFz44oZMHzIpIBhVFJhEvo56agW
         CIag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299921; x=1715904721;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dlrpveSTicTC1QjgYgHoRdW1gbJlSbbGgHtnkq6hedQ=;
        b=bSNhktKIxJUol+fbYQCneIEXJKQMt2F9T5HDSMPtdr0aZdhpDnUJm6NT8Wwv3cVtfP
         yTagoDEBDca3eNVGwXiMMFblF+ZgDABAr6gKuxrKv36A2SKwlhsTOKAE3zr1AtneR7pA
         9IGuIOnpF59Pr4Y7XKUJgmpxND/LMNgmta+zfa4vG4eb4rwE/WL9bzjtbd9msMWV7Ywe
         V8pOEDyh2rwVljhNt3eSgXD7J3SHiTsRS/yOmiibxdy13SKYpb1tiI5ahyXB+WhY90gc
         okBM7ItCBKiRzV0bpydyWHTQrLDaakCn0GdcK8nuhJhDG4ahkOo2F44cwm8nEHKX+w8q
         fudw==
X-Forwarded-Encrypted: i=1; AJvYcCVfx7jKX4nFNfbiIbN3YM8qT+vY+9AhVjmgnxHbcsby4g7aV6yiuOw6w2b+bRxPUMaAZ/IclxPLK0ky1hJU3Xq5rLH+
X-Gm-Message-State: AOJu0Yznj+FMVGs2Rl2Qmxr8an6zK3JFoB0RLvkB5SVRHqx6+2vng2/L
	KIoGixQHNv1T9vNdESKF3QNRm2C8Jj2E1J/Y2n5TnyIqGFKC91vXLwkJd668LcixmhMwRWx0shO
	HJA==
X-Google-Smtp-Source: AGHT+IEljiny7OmbNGCw2EWYbsHOOVLKCcmnwEgJ62aNlyn1CZ9mTlCHDOKzsq6Mv/IMiisjYaWJaVEs9Uc=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:1004:b0:dc7:68b5:4f21 with SMTP id
 3f1490d57ef6-dee4f508f29mr292058276.9.1715299921234; Thu, 09 May 2024
 17:12:01 -0700 (PDT)
Date: Fri, 10 May 2024 00:07:19 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-63-edliaw@google.com>
Subject: [PATCH v4 62/66] selftests/uevent: Drop define _GNU_SOURCE
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
 tools/testing/selftests/uevent/uevent_filtering.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/uevent/uevent_filtering.c b/tools/testing/selftests/uevent/uevent_filtering.c
index dbe55f3a66f4..e308eaf3fc37 100644
--- a/tools/testing/selftests/uevent/uevent_filtering.c
+++ b/tools/testing/selftests/uevent/uevent_filtering.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <linux/netlink.h>
-- 
2.45.0.118.g7fe29c98d7-goog


