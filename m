Return-Path: <bpf+bounces-30231-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 074DF8CB7F2
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 03:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B657A2858B3
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 01:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535DB155335;
	Wed, 22 May 2024 01:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tFz58pCS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1C5155310
	for <bpf@vger.kernel.org>; Wed, 22 May 2024 01:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716339716; cv=none; b=sVf1QjgTn6y88MNGxzL1syndW1WJpHUf6gBXfAM7bNX9StTvApwmGNXIlM2K35ycXBApkdu53EPVroBf0bRXGmOUjzMXJ5ix3HxR1/kD4W8YdDmG/ZeAOanbPIxIHf9z6VYTnJaknD1wMPjwq+9D+XAltRzOQZ56rNgt6CMahTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716339716; c=relaxed/simple;
	bh=fBXBkXghEjNTtFe0F4ADNoBJuC5etV2XYfV9uhnigmE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ShPkhtwVeSJQigsi5lNO9Ko+LwpLNSCsi8zhU9oZ7chuf7X5yVSaIbhUr6xAnJJrhMEr5Pp5RXI+6RDw67XfPTPa/3r+AKFbHNdGCwYTivAQ9xBEQ6G5Vpwca3NBU+ff6HEyMdaZJ3s5Ie5LwYgeuZJRDZBCF5pW70x/9UpYXvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tFz58pCS; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-627e7734a29so1494337b3.1
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 18:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716339714; x=1716944514; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tX+C4G2dO430Dq5NwbbjDA2nRzbu4A2cHamlSsJi84o=;
        b=tFz58pCSR7AeVGRCYdVEa8hPfg8oap8Vq0N3lDbCt0qlNEDjUFH3l3nIdGq4K0JKgc
         CztzaFYtRWKIZA93x3KHmJL7p51oDBCQE3vb53yKzpgNdAzXfyneJXvJT0Rr74llpnft
         SWniS3Wt9YDat7aKBFlmqUCQgGEZdQb3WAlYqIMdoYqGFF1SQD8xHAbCXryk9bpCtkqS
         PS4iEKY9HKEulQ7YCK2ug+UiTOHC/RaYvaPNYHK24ohrHq2btX93gAY1gj1SiQNeVLGl
         OI/p4F90abY+u28xgBFNmJHkZUJ/8GZ7K54+tEcdFjDqc4+FtdbMpEiRte/NWatq5W9R
         6Nrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716339714; x=1716944514;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tX+C4G2dO430Dq5NwbbjDA2nRzbu4A2cHamlSsJi84o=;
        b=bavRhWpsbuTTMvZawJlH0XNZMztffoNX5VauOeac/TEOtDgPS6m/vl/+kG6Or4qB/o
         Lcf9cd3btqgTNHtwQvrVZgnj9fjswvGaG2zwgyYfBp5ZPJS79X8PR2/6YSb7ZJfKSj/z
         dn1ceUVpXkWz3tKtKNzP0EFwgJTMb6vkfRrfoVrSWu5lTolrMtCDyf8KJMruIwF6hTVV
         1iYL32C9ONHVcdefbzqBF5ypiP5vlE/CJwLXjClggXlCUzInAxPdvxzEy4M/GsMld9IY
         hfN25PAx06k1T901FNs7xjSXIITAKfjvR6CVVc0R5B8GrnDbz9O4h4TUO/LScsDgWWig
         CawA==
X-Forwarded-Encrypted: i=1; AJvYcCVuOWqFAs2BYpMeT/neJSKkRIblTIL0NaDEPwMetGBWxtW6/V8tU/B5U4/gKyRX66E004tWQ+A7b04NoBe/56hE9gTp
X-Gm-Message-State: AOJu0Yz2BVXQ4+Dn4mxTmQy8uMBkABye8B4GjWnbOkncFTDLCYHHGyMA
	CeVJ7d/vuocphOtlLkSPdaPsIaeN2r2Zz87LTTHa7tXufZZorDts3xdbWxPtFJ4HnqiiEFOasAn
	TTg==
X-Google-Smtp-Source: AGHT+IERd30jv/R2KSgTCg5YZ7ZV2lL0yhmpeb+wESJAYpGBxJBI9/AsRI4az9GMtDgAdquzLZrkmDgFCkE=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a0d:d80d:0:b0:622:c964:a590 with SMTP id
 00721157ae682-627e46d40c7mr1748647b3.1.1716339714682; Tue, 21 May 2024
 18:01:54 -0700 (PDT)
Date: Wed, 22 May 2024 00:57:34 +0000
In-Reply-To: <20240522005913.3540131-1-edliaw@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240522005913.3540131-1-edliaw@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
Message-ID: <20240522005913.3540131-49-edliaw@google.com>
Subject: [PATCH v5 48/68] selftests/resctrl: Drop duplicate -D_GNU_SOURCE
From: Edward Liaw <edliaw@google.com>
To: shuah@kernel.org, "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>, Christian Brauner <brauner@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre <reinette.chatre@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Edward Liaw <edliaw@google.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, 
	John Hubbard <jhubbard@nvidia.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Content-Type: text/plain; charset="UTF-8"

-D_GNU_SOURCE can be de-duplicated here, as it is added by lib.mk.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
Acked-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/resctrl/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/resctrl/Makefile b/tools/testing/selftests/resctrl/Makefile
index 021863f86053..f408bd6bfc3d 100644
--- a/tools/testing/selftests/resctrl/Makefile
+++ b/tools/testing/selftests/resctrl/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2 -D_GNU_SOURCE
+CFLAGS = -g -Wall -O2 -D_FORTIFY_SOURCE=2
 CFLAGS += $(KHDR_INCLUDES)
 
 TEST_GEN_PROGS := resctrl_tests
-- 
2.45.1.288.g0e0cd299f1-goog


