Return-Path: <bpf+bounces-30194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB838CB72F
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 03:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BBC61F21D31
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 01:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB216BFD5;
	Wed, 22 May 2024 01:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rKmZZGPJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECCD79B87
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 01:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339608; cv=none; b=Vd8QmXmGOnIHRSHb40K6h0MJLfniapqzhinxKTwsGHkF2U5/dPZ1YWriZe1yIoac1TaG2RrigXFofvNKb5Jahf6OJs0CB1MwR60ofs5Vcy5kGr5xyJcCFVF5GsmCp4dvnw/COy+kDVmEHoFWjpUZ7LQu5qQY1g2VHbhr/MZylEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339608; c=relaxed/simple;
	bh=Dzdcnsg6q93Dx/VQ4J5vnEEbAA9pDEU+SlfSfSnZ0a8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=V81D8E7eKIfdGRVTWm7v54to7kN5P/eC5LNODtd89hLZcolQ0RB3FBQ38V2pq6bW+9r8awXyQpYDL++IXSsUDftwpidyVbpRpoD96eMP0l9/qyL4fAEfJYpwr90k91cCxJi/dFSKucz9bjSl10RestjDLjywV5oXiiQPIde+aYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rKmZZGPJ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be4b79115so260553957b3.1
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 18:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339605; x=1716944405; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0lmQNJORVSfCUFFoUd1ViMTpUw9e5KrZZN0Cex2QGeo=;
        b=rKmZZGPJmgiDLzhdg8t5T/uJw7g0/Y1rQqAWxzN76pdtBHfHCfkgA5flqk86htTc9C
         oi1/o6AUzs47YiQjAGwVRWcdxMsmaW7OQ4U9NLcKgPHTXNDB4kCkNX4jTSOIMgxVekkE
         miG0Ju90JFXXxYMdyFth6j7m/pjgzE8bw4i3ssxyF/8dlvz5yXD296Rp8UxuXvoEJYGO
         MeGz1tsaeKdryzFl0HE5r7oUH/HFKEG/Ok1l5zH1fsRjiDtF4noZySZLjQAQat2+BNJc
         veX0u0foh0+j0hiWEdXvPeD47o6ipchfTjlV14YSd+7+PAtfJiSBCv+Qf3ONGwFrn4Ty
         c6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339605; x=1716944405;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0lmQNJORVSfCUFFoUd1ViMTpUw9e5KrZZN0Cex2QGeo=;
        b=tQwGJDUaWFHcxSnNjRYye1glAeiztmWt7XpSZeJ6SilHFJ9C/RbVEYzgLIXMI+s8jh
         3DZpY5szqwHa2rFEkShSIvGiVHsH4i3K0umJYDZ5Z+BwTwBjwLYq5lXbO//H5GkvkNmV
         IFgNUldOxF6OOaud2N9xukqerh115oh2unKNgCMR5V5rb9EgA6rsHn+bWsc7bb0NXcL6
         LM3Y5gMeiW6oYj8GFLqwS2VyveVtRnkjaIu4FcfeMTpnx8XhNdQ2Z0xR+tStWoxFDTnK
         stccC9H7f8K9Y4n8xQStBX2A6HqJ6w/L1eCqVmEF/A6Ry2h43PyQd9iq4IPg1piifPnh
         f1vw==
X-Forwarded-Encrypted: i=1; AJvYcCWmu67PZ3sAP0OnkUJ2h96NGZVQP1NuSM+svqiTcUtJ6TS4ZuPzeW1UMESLqSvMeTFrvWYL/qSzjhC5SR7b/YtTEJAP
X-Gm-Message-State: AOJu0YyqtlRf+UmMQX7bkRFCH5cFWUvQoRhZVqmzXRVPO5g/1vvmHiHG
	OIfpGTEuIPzsOV3r0mQBbM8ZyflSWybhFO/ne2NVs1wu0CQnbwb4Ch1Cu4zY0IIJF18nIoySV8B
	odg==
X-Google-Smtp-Source: AGHT+IFHbotlZv7fBN3ho5Rqkkq34fEhQTmj5VOO1FIjb4w3cqdjQsyZMPao6gSz2IdVEby5LAMyjSIG9hg=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a0d:e609:0:b0:627:d549:c40b with SMTP id
 00721157ae682-627e4848affmr1773967b3.5.1716339605428; Tue, 21 May 2024
 18:00:05 -0700 (PDT)
Date: Wed, 22 May 2024 00:56:57 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-12-edliaw@google.com>
Subject: [PATCH v5 11/68] selftests/core: Drop define _GNU_SOURCE
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
 tools/testing/selftests/core/close_range_test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/core/close_range_test.c b/tools/testing/selftests/core/close_range_test.c
index 991c473e3859..05781c7fc578 100644
--- a/tools/testing/selftests/core/close_range_test.c
+++ b/tools/testing/selftests/core/close_range_test.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-
-#define _GNU_SOURCE
 #include <errno.h>
 #include <fcntl.h>
 #include <linux/kernel.h>
-- 
2.45.1.288.g0e0cd299f1-goog


