Return-Path: <bpf+bounces-29278-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4090E8C16D6
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 22:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEAEE28D777
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 20:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A6F1411D6;
	Thu,  9 May 2024 20:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ybewIHWZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E97113F454
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 20:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284993; cv=none; b=c5NjtDB6HofDBPGIENkJhnuBlfPl8jjVeqnAHRa7nfj5JquSr16BfO7kUKKM2Lx1Dh2DlgSsFV60hG7OH9i9Ev2GBlC4zWpDP2uIMduuI1cqQLrnBWwnofecVZyolDm+Q/meDaE3DX3vCG08h+fJUgj9FC75ep4GOIR2Ev0n968=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284993; c=relaxed/simple;
	bh=IyUlAGHuB4F0ACGEqw9XDD1VWDnG6Gr5lWYbpcHYvy0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pFLq+XOwQ78syEmM9p7eMZZuq31K91iJM3N9Dz8S5HGRtBFDjmckziGTsqpf3cqaGlg0y63B5J4Te19/1avcWv8h2S9/nFxr6LlqaIkr042/PN78VgwH15YA0J4z/+sQSyHkLULebfnDhpjyrBRELj9Mx2O3evPzozZLuwEJa/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ybewIHWZ; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2a49440f7b5so1109828a91.1
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 13:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284992; x=1715889792; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Be7dPPNzCq96H6P3h1xjg92hf8ZyE2EcN1YZKe/vuY=;
        b=ybewIHWZn1KMhnWj5rppt0eEpsAwvBka4dwRdYHdLkslf2u33Y3VreovmEUj4stwiW
         x3rYxwpAhZ/D7s+Ld+zK/ejjnDq21MqDIrRUue4gdPve75UmQ+w1nt5U30Fby+9oeHr2
         RJ9TLuGsGv4q7qeFEyvJG4ifoEMLdhuedipLs7CepjYbRCieq+L03bdt8rHeqaEp/sZL
         FmSKy439+oGntvU89C9/kxIXl+00X04sgjQdojVOYxeOWa7CK4dUpnGp9POuRCQ/h2Ip
         SXFL+jZT6p/icXGrCWNZzgnUxFXXDzdf+8gjgM4QVi9i65T5eUMNqmo4uPC8nW6RdrxT
         pi6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284992; x=1715889792;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Be7dPPNzCq96H6P3h1xjg92hf8ZyE2EcN1YZKe/vuY=;
        b=E5S0r4XwkcmBsSyh9rL+1BgdDA0stLikCIWj5Y2yBVeRy945E7dWw7FweY9dczCKXo
         jfUYdae4+1RNwIcQ+lP91oNUHmBxnqJygMt48GDx0P4qJ0cVOOpUN2O1skhjb7lAEDAG
         6/gMfRV7Oc1CJA3Bg7awWa9rIO9vZPFjFUYLz0hDPGjlKgfLDxqj7Xg3zfc7IwbdOd4k
         05e0KxBZV+zWPxkCJnlHqWRk2eEGslhS7Uq4CcCsQ+SRyhNMVoKZK7lr6ef1+Mmsalca
         DtUuDHFa4JHAYL89sQozpw4v0rIK27aL6QVsRYnykEX0N62wJdL+6o1ZLsqoO6sDhLHs
         6FtQ==
X-Forwarded-Encrypted: i=1; AJvYcCV13ndMlhn7tbvN1APIbt0TngnAcstZuhrBJNEVmzu9w6wrjODDv1oTNAWc6Wo9As3LKVsSxl6Xtc/ZIjJ4OlpxJk+0
X-Gm-Message-State: AOJu0YyonebxjWgZS3Vo4L2+QMWHR6Rhc0xfTOwAcP/x46snGqozzbt+
	qzdhIrOFIGo2A3rCl/K3Qn1qOzkPRJp4dTuhbSyp6hpi6YwptQqkDGYBPO/Z98sXKkWYdv4Fa7z
	ppw==
X-Google-Smtp-Source: AGHT+IFCjwU+w1U0yj0TkNwI/1blZtBGHka6u+vlka6eFMoi+Th2FASNm4gAn2xDAZ/v5xVDapqUQKSY1gU=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:90a:d30c:b0:2af:d65f:f89e with SMTP id
 98e67ed59e1d1-2b6cb6c0d84mr2722a91.0.1715284991495; Thu, 09 May 2024 13:03:11
 -0700 (PDT)
Date: Thu,  9 May 2024 19:58:40 +0000
In-Reply-To: <20240509200022.253089-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509200022.253089-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240509200022.253089-49-edliaw@google.com>
Subject: [PATCH v3 48/68] selftests/proc: Drop duplicate -D_GNU_SOURCE
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
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/proc/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/proc/Makefile b/tools/testing/selftests/proc/Makefile
index cd95369254c0..25c34cc9238e 100644
--- a/tools/testing/selftests/proc/Makefile
+++ b/tools/testing/selftests/proc/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS += -Wall -O2 -Wno-unused-function
-CFLAGS += -D_GNU_SOURCE
 LDFLAGS += -pthread
 
 TEST_GEN_PROGS :=
-- 
2.45.0.118.g7fe29c98d7-goog


