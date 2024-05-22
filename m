Return-Path: <bpf+bounces-30205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4F08CB768
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 03:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 776062826B6
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 01:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AF31487DB;
	Wed, 22 May 2024 01:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WDNntRXJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BE51482FE
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 01:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339634; cv=none; b=UyV7c+6PQ0Ue4suuZF3NBqc2QjbtWUugvAvNHxtvPXszDUdUmi0YqzPSZguQTgwVooV93SIXsCnpvVI6wjAen0suqYMGWNYpQQ3hOVEc8lEtQvCbW7o12wKritDAsCFB2zVCQWIrxueAQMT0FNqdibTVgMzKd3XgehxAlZp5J6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339634; c=relaxed/simple;
	bh=OhLPqsRCgD9vJ4hW8ulo30Ne4zlzolp19IgJWmt3n08=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FKyFDQLxUBVkKQPpD5/y2GAXU3DWsFTNCcMOFHFPtw8RTS0aYq1dsd0mx6otRYUgNzVWaDQqiBatx7oOhJPLcXYN4cq47iAzkiiCbFcPQw3VgYprJ0QNt6oeDhauUzE7fWU7ON/B7k/xTIlCPX4823BPKFk90HBFmbKys6kGXWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WDNntRXJ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-df4e4d71754so99455276.0
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 18:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339632; x=1716944432; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oewyckT7yCJdv6PsHxuPsX+KPG3aBwcB83OXgCrutjo=;
        b=WDNntRXJ1eTfAj4Bt7m0nw7JJEKstbvV3IFUWezma1oztg839XfpotIxd9Kg8a2dHF
         0WwHWvoM0F7PoY5TPvkYizp7MCG1FN6JZz0CmQzERsoYHObklhzvd4hqGmOptfUYC2rE
         Id1SiLa8714QM95OVgX8nJwshITfy/XrHzURGavEOFAXFvb4+xIx0S6bPYT1KsUXCGC3
         XOWuXWPw1G2kRuuEhYL8aaOTuec+oQiIxvUYTKgeQXhWrujcSdfOPZBpsR3Z+sb2/OGD
         aUS91RrtrolsY1sJA9BNSymA2TCwKQOhknYRCiOIpkbohpYIIYBVNmbnR4EiTOwEkcOi
         DZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339632; x=1716944432;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oewyckT7yCJdv6PsHxuPsX+KPG3aBwcB83OXgCrutjo=;
        b=O5cE/Hf+tBzJQslrvRV5VfKHnVoLIv9rryizeCZFG7GFTaNedOv/cpf+a5pxcIq2Bx
         n2qGI+BMHtX1VCO6GpaqlrBBRML1Vy7Lx7V9+26cOrsHhyVlZ/b9cRXU2cF67n+E5z9U
         VLs/5EJwfClHdAhPbAr78osBkKbXhcpTIqWn0YufnBK+LzXE3OeQ9b77R2rsViPCNu0M
         Ym+zxzdEG5pjimZymdVvXEhydatVw4+VL/GceL80bHz2bHVOK+LNrYOTtHKDJBfblIvm
         Q7B2LH7XVC0T/VWV/qnPxhD8W7Vq8poct3fqM6wQMfXf3859sPpFko6cc2Kq9IcgSRLk
         6D4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXXkipQ27yGnWzzMlgesGsEmNSNTt8Zuhbvur5OyEFw+myEZ/Q2HyRfXbXNCUPM9NFjONkzew4F1HKfh/tDpguKDTIY
X-Gm-Message-State: AOJu0YwiEL1ofrR/voDvKwG2wba8r3HNrWP4WB8UJOXOItTfaqwFAVAe
	5wIyj6THowtsDu1LjOhTQNIRL4fGswwlrNScNTsOQdBpszjOgniz+GUb30CYIIYzeP0wta08+E6
	0YQ==
X-Google-Smtp-Source: AGHT+IHUNo8cvfMfJNAVfAe+BtdbpT1JP+r7S8PiEYjzPEdLVkTG1XyhCc3cwbOFMzIaHwj4vfyOysmUIdw=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:2b91:b0:df4:a381:517a with SMTP id
 3f1490d57ef6-df4e0905878mr221333276.0.1716339632667; Tue, 21 May 2024
 18:00:32 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:08 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-23-edliaw@google.com>
Subject: [PATCH v5 22/68] selftests/intel_pstate: Drop duplicate -D_GNU_SOURCE
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

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/intel_pstate/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/intel_pstate/Makefile b/tools/testing/selftests/intel_pstate/Makefile
index 05d66ef50c97..f45372cb00fe 100644
--- a/tools/testing/selftests/intel_pstate/Makefile
+++ b/tools/testing/selftests/intel_pstate/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-CFLAGS := $(CFLAGS) -Wall -D_GNU_SOURCE
+CFLAGS := $(CFLAGS) -Wall
 LDLIBS += -lm
 
 ARCH ?= $(shell uname -m 2>/dev/null || echo not)
-- 
2.45.1.288.g0e0cd299f1-goog


