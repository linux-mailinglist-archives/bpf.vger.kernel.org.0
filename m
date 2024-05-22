Return-Path: <bpf+bounces-30196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 302C28CB738
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 03:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B492CB2359E
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 01:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD52884A33;
	Wed, 22 May 2024 01:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="roZaxLIK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B0382893
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 01:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339612; cv=none; b=Ec1brC+o3F+mbK09OWA0RvQO0v/6BaEc9V+mv0btKQCu/MIwVxHdYvSbutLdWdSB6fjLHzr8swOUrjbWSjQg16jtoMxxn4vn7xKxsjKd5Qb9nyTEOxiaoHO6zmXjZkv84AVMZhbkYPqVN9IBeRSbiY6RHt6S8KniQR5tlNwygig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339612; c=relaxed/simple;
	bh=S1fHZ16QGTzRdof7kT4XVR0on/jJvuLWPLTX5ALLxIk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Sn/29GFC63V4vKCWzMlXpqSyLtQ2ZB8teUItX827l/+yPFpjcLrIBDOqrhR1gcdMoIjWHPVznumzYg/lle1ZpZC68R2a1FnLmauvtzs3OHc/uWfRy4V80UnLy/yBqi9UEjefJzudz91UeSRt62qaoenNqbeJpEN1TYlOPy7L2c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=roZaxLIK; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1ee2f06e652so141375085ad.1
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 18:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339610; x=1716944410; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=k0SrfosPfaORMORiDV3L6HqdThQeC5VRMNDfvSuUG8c=;
        b=roZaxLIKbfqCeY7X71vD8nhyFc4CE7XJh8ZvX2oUUVFSYNtO01h7bDZlAeI4CMuGSF
         PUAsXXw1bzEdpv3HqWpDpNbB9d3O/6Y2qyjLTK9l9+pMuL+OTJfYkW2UtFh6lQGusWFP
         jpUesHxsxTTquD6Tk04TO4iYc2mYKbqF+xlTnUIfeAuWKH0YWLx9OSe3C5mvZwLij7oe
         CNDl90LiLwCBStzZ2ZVpNVwBSziOEjA+4ou75tXFQ/I8QF3nCXgPbgC/uKJ6dpQZ/Mi0
         1dQKCD69KY+54w7XD66/1242Y2Tec8X+5H5NR4fXRbpJ12RsODj9wos+Ep5PKU+ggH0x
         HzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339610; x=1716944410;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k0SrfosPfaORMORiDV3L6HqdThQeC5VRMNDfvSuUG8c=;
        b=TUKmj1Y0N3ytcc3XO0ngowdwRM/dHEOT6njlnwqPQin+zMtgYOmINHyv8gNX4OwUpu
         0ADchGq6gb6Zj7f7sYTjIbclqYdp91z3VUDmdqNQaRMMKWPN3gGyltEUdwdrdV95Lyat
         dkO2aPVNAM/FDYj4pB3bsbjpNOZ7tVmszGvXWtyDJGU5RTg7gCQ946Ub8GWP6aTdN39p
         MOrQRe7/5Rl/mzgFRoJD3l28ulbIyUA2yodAf5HYI/qPh3dh2BYhRwwi33uJVSQYysA/
         ppAgn7zbRtney93XdfJtOJreVZFILx8Lg8KFDhx1EyM9/oSSGm0dDmjIpzZizgn+B/pG
         jVOQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4V/3TSbzkH5kzvvNF1kAEJEY5XTD7CZsamM2baoBvQ6wZgHMkyWpJygouL00whZluxdBPZPIXSppipCslqepymp+i
X-Gm-Message-State: AOJu0YxLV5bPBae1LpmTbCzPNhq1XsiJGugZ7A7nFeN69BRgUOPbCshT
	Vs9Jt4Yq0+auG+cJzm+WMwQVr7TjaaTWXOrBVPMm6yJoKXaUrUTBs6gGocTU/efzYjX0cJXzlNF
	fDg==
X-Google-Smtp-Source: AGHT+IGUpVwRCqPawwzanMXPOZwgNaMDkfSqd1hp2W1p1CdLiIMpUGI6bBPVJi6DEWQCXHcXLDTPCIyai9A=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a17:902:f688:b0:1f3:7ba:db47 with SMTP id
 d9443c01a7336-1f31c7f28aemr145555ad.0.1716339610323; Tue, 21 May 2024
 18:00:10 -0700 (PDT)
Date: Wed, 22 May 2024 00:56:59 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-14-edliaw@google.com>
Subject: [PATCH v5 13/68] selftests/drivers: Drop define _GNU_SOURCE
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
 tools/testing/selftests/drivers/dma-buf/udmabuf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/dma-buf/udmabuf.c b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
index c812080e304e..7c8dbab8ac44 100644
--- a/tools/testing/selftests/drivers/dma-buf/udmabuf.c
+++ b/tools/testing/selftests/drivers/dma-buf/udmabuf.c
@@ -1,5 +1,4 @@
 // SPDX-License-Identifier: GPL-2.0
-#define _GNU_SOURCE
 #define __EXPORTED_HEADERS__
 
 #include <stdio.h>
-- 
2.45.1.288.g0e0cd299f1-goog


