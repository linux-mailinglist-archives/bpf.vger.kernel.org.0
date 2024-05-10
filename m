Return-Path: <bpf+bounces-29365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7046B8C1AC2
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 02:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A9432819BD
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 00:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719371391;
	Fri, 10 May 2024 00:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2wYQAoKk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A51212EBE8
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 00:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715299813; cv=none; b=uzztBn6EE2TXFfCvuQWNkf/1GcgiQHw+0ti3cQxbrLgkfbmpHUrveRZPYuAs3DNtp/4ZVuNHhuGcCYPfkVMlPqd27XXZ6lfcz6cQb4VQDMukMzui4nyDghYIi+7UeAhUQCMWuXeZeSNW+ZsrKZ2gDDoUuV/UxDZXPdfsCnUBkKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715299813; c=relaxed/simple;
	bh=06GXIfnrY5FenXrSGQ9POcsOnMyF8JM6D0YxLBQedpw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SbNIkubG7ggoVcRpOcVQ2e331KM6E3gASh0ZhoKLg60cxzm088DSG1c4imRRQLM5zyRV4kXK2KR4+ZwTNb5r6G/6lajE7TNEY3AdawVawYCaNzw/8+X4QKTevNj6QlXIkAZ1AsOg7ipOxUZ/DToKln2ceEXJmIMX7ZXYSOBgJcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2wYQAoKk; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61b2ef746c9so24152827b3.1
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 17:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715299810; x=1715904610; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D1JirhXYvbIsfalfItEFO7rXY7kH5rekU7f7+XKnP28=;
        b=2wYQAoKkO7yIefW8lFqWEkzzGOHKeZGDZygTqDO24b9RHkrxVdmY6IVqKgHyDk+I+m
         F7c3htf/27Nuul8+OajYAFjginQ+MCuyUzVnwFlPjjRV4BH7RXCUwrAWJAKDVSY++xFu
         SPKUvXz/Jni8tMC5FkNKt05D+NfDbtz0sVLqpoIPfX3u4FIY7qX+6jVwx/IGEHX+6MiP
         BOErU6Lf+NUP/ZTL8iechAbps85lxzxTsjql6zLKHiBaTDNaGe5rscBiLElrDa+wh7tl
         Dd7KhMiQSPdnuVSt29zFP/jumazoJsZExeqWoe+l0LDZ0lsXhcKCYbU4CM6SqxqpqrNc
         69Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715299810; x=1715904610;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D1JirhXYvbIsfalfItEFO7rXY7kH5rekU7f7+XKnP28=;
        b=vclG3pCQHvr+lLDIjOXPebMsykow8sBc2Kmk3eP1RiFY0aHL9H90UXtaMiAZ2GZazV
         jvvEHACBNF5EFs6e5cb6/VM4pQk7h6pcvU354pkhHarjNy6afowq6o0ezVZHC41ItsFr
         4C1w7YEvrB8zTAVC1cFtfJmhBVcwu4443LBmte1KsK9hkkeaiHsdC0z7EoSXzxLQ9RKq
         gSh6CbDn5w5U7fb0CaCS+pImt/blqikzntdCqr4rL39JJE/GVmp8XN8DvYqmkS2ZKFx2
         XlFNZWUgky71yifE042EPdXQeffp2sKMBInWMesn4OGJApUbSL0VP39+NATxo0karne+
         D1hA==
X-Forwarded-Encrypted: i=1; AJvYcCU8xR/VeEZuGXqWbOsGjdw+P+2GWstF+v5EzqmGcGm/W9kSE/B88TR+jSqBgGf6grYsrzo/49SV3UcvBK6py8+55gaU
X-Gm-Message-State: AOJu0YzCt0MDPdm9wdDI7xGPUCKXJT9o0Bdxg27RIGic/Jtj3EzcESSv
	D5Atugq6hax/CrgGdLtaGrZEX5O0Ft2MGLOGAm3+jzPfOQLx1GM0a4+62C25BM1/a5VQvg0u4pw
	MxA==
X-Google-Smtp-Source: AGHT+IG/RWyFjoRdfpBoeWuBwpsoREtw3fEGHoJsuZVogrcMqGX9XXGJ9mAouAKS6OupGTFj8vQ5m6c7k3E=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a05:6902:c01:b0:de5:2694:45ba with SMTP id
 3f1490d57ef6-dee4f104643mr309828276.0.1715299810434; Thu, 09 May 2024
 17:10:10 -0700 (PDT)
Date: Fri, 10 May 2024 00:06:41 +0000
In-Reply-To: <20240510000842.410729-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510000842.410729-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510000842.410729-25-edliaw@google.com>
Subject: [PATCH v4 24/66] selftests/kcmp: Drop define _GNU_SOURCE
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
 tools/testing/selftests/kcmp/kcmp_test.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/kcmp/kcmp_test.c b/tools/testing/selftests/kcmp/kcmp_test.c
index d7a8e321bb16..f0e356139e1f 100644
--- a/tools/testing/selftests/kcmp/kcmp_test.c
+++ b/tools/testing/selftests/kcmp/kcmp_test.c
@@ -1,6 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
-
 #include <stdio.h>
 #include <stdlib.h>
 #include <signal.h>
-- 
2.45.0.118.g7fe29c98d7-goog


