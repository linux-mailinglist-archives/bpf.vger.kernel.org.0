Return-Path: <bpf+bounces-56662-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1670A9BC7B
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 03:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEDE71B84700
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 01:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1376A282EE;
	Fri, 25 Apr 2025 01:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHc9cVrD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30ED1C2C9
	for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 01:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745545549; cv=none; b=Py1v0LissQ42UkamZTyT+O9InOIRzfmgh+J8MMfCMcYDuxSD+wxFQDxnfIztPsZPj5RmQukXWbMFHPqaXWiSOGQgT35Ymb7ovz4mbFGo+mln9MwemTpFJBUSL1XI2IibPjp0btaUBOj+CXo0+WVL3DxdwQj8S8tb13sDSG5Vfoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745545549; c=relaxed/simple;
	bh=7WvmheYH1tSi92OyqNkt5e4Rjcy59AkJ4AkkvHPVq3o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pIOvJOejMNGqTzGva+c9mG7qOj05nGkrpf4j6JD6l+lVss3z+oDOH/tZ6jNoU1WbtKmuKnvbDtuSKCxbhvDKJZTbmXUnt7j7OTEwH32WStOIZXqueXyzOyEFHOqbHPToHKDGbmMoHlbDVb6lHz3EUHU3sbQnyj8QVchHvMe5aS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHc9cVrD; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-afc857702d1so1513306a12.3
        for <bpf@vger.kernel.org>; Thu, 24 Apr 2025 18:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745545547; x=1746150347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/tEFpBkduH6d+JGsd0xNlyZxBAcoAqKsjucmHR+mfYI=;
        b=aHc9cVrDFjaV84qnKhs0hAryUtbTJHuDqK73JrNO+/AMa3movD6arQsFlxvbL0lzkg
         IU1zKkYUmPB9xr6i3Ev6sFKmFWwFojJXFDDd9+xgmR2QG6WozcdmOFV6y4rkmZ/ArUHs
         jaLjp5NmROnQCjsgnVbjh72XjdpeN9gb/X2Cvyzm5K/t+O+p/HfXZ6dQhNs/tevaofQa
         ocVo5N/6Z0krsg0sDAvzJYjfM4sl8NAy+YuqIwgj6gMwZ/49wKSQyeOoVbOgkmcwnxgt
         hxiLhMEgf8NvZ/JYnIN+HMAEAqrON6jKqSgyxQRSP5szjDxeBpiXKIYJkthxCzvUKo/R
         0wJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745545547; x=1746150347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/tEFpBkduH6d+JGsd0xNlyZxBAcoAqKsjucmHR+mfYI=;
        b=Hv/k94O4pcXyiMSzzy0bXbk7+3RnqJmHYEoV2QzUWWAUmb99s3bc9SjUIl9j6pQFom
         EHLkQI9aGbiA7Hh/zobYheSBCOR6xm1+bxX6p4/x49Ha/syMXNwfkRGLL9PR/8SHd179
         zmAvd2HDxEXzmVlc94RU2SQvKQnHWZOJ3j87naJvOw7ceRYcWo92RAnAOG0Eim7gPuNe
         ljUbLBNKHro71SHHxdT27LVoLmg1B+WxJwiaIfLInJIalcAxYDHVvZ3ipUaEvBxbwJYI
         WfQJT2HQSfx3dOEyvwrf9zwmE7NQtZ5LYEyKjZthyKDNHdKuyasYV5gneuGTXoDoq2Yk
         MaEQ==
X-Gm-Message-State: AOJu0Yzkp3AP4oWbasUTBLzc0X7ML4fxqJchOjkXB9zipIp2nStsWVeX
	blI6ReDnF2CYOt9zobuyS3akdlJ1BOP+g9gLkS/mXmoH9hPqMsXybE4sQg==
X-Gm-Gg: ASbGncsJfsQgxQ+ujSoIcHBpbdmzneuBpU9SNvtXXpRKjj7KeB3cQ2LOWefAomAe+gz
	jBQ/EYI1C2czQoDv5UITDvh7KrkrOaQkoHGK/Nkw1LvlMi3RvL2ZPUW4IBQ99d4jrUiL4p5MCG+
	hk3gybsGgc33i/QbIYS1kT6loXxZNZCGQHn+FDZn6lpY2KtK0f3AbMl51alPTJKt1x3fmd+Yttp
	Qe36CalC+zXXqk6BRBRSPGxQ7Qa8+zAE0nTi064aEV/q+xf/WyersZfMGCSwPBBXMCo75e1ZrqQ
	cGtnwSE6TZ0Oh/BWh4HD++xPC/I5mM/LMh/ghMqddK0YQ27PqeVfjkhw/goOHA6DOONq
X-Google-Smtp-Source: AGHT+IEasASFwq3Wv4sBSLHH7+He2Ur/0+qZ7ZUnwpFMbIIeN9iP163hn4TxK2m0j89EcjgKAdIMrw==
X-Received: by 2002:a17:90b:4e90:b0:309:e351:2e3d with SMTP id 98e67ed59e1d1-309f7ddfe75mr1266662a91.12.1745545546568;
        Thu, 24 Apr 2025 18:45:46 -0700 (PDT)
Received: from localhost.localdomain ([2620:10d:c090:400::5:3a24])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309f77652ebsm334110a91.27.2025.04.24.18.45.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 24 Apr 2025 18:45:46 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	kernel-team@fb.com
Subject: [PATCH v2 bpf] bpf: Add namespace to BPF internal symbols
Date: Thu, 24 Apr 2025 18:45:42 -0700
Message-Id: <20250425014542.62385-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Add namespace to BPF internal symbols used by light skeleton
to prevent abuse and document with the code their allowed usage.

Fixes: b1d18a7574d0 ("bpf: Extend sys_bpf commands for bpf_syscall programs.")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 Documentation/bpf/bpf_devel_QA.rst    | 8 ++++++++
 kernel/bpf/preload/bpf_preload_kern.c | 1 +
 kernel/bpf/syscall.c                  | 6 +++---
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/bpf/bpf_devel_QA.rst b/Documentation/bpf/bpf_devel_QA.rst
index de27e1620821..0acb4c9b8d90 100644
--- a/Documentation/bpf/bpf_devel_QA.rst
+++ b/Documentation/bpf/bpf_devel_QA.rst
@@ -382,6 +382,14 @@ In case of new BPF instructions, once the changes have been accepted
 into the Linux kernel, please implement support into LLVM's BPF back
 end. See LLVM_ section below for further information.
 
+Q: What "BPF_INTERNAL" symbol namespace is for?
+-----------------------------------------------
+A: Symbols exported as BPF_INTERNAL can only be used by BPF infrastructure
+like preload kernel modules with light skeleton. Most symbols outside
+of BPF_INTERNAL are not expected to be used by code outside of BPF either.
+Symbols may lack the designation because they predate the namespaces,
+or due to an oversight.
+
 Stable submission
 =================
 
diff --git a/kernel/bpf/preload/bpf_preload_kern.c b/kernel/bpf/preload/bpf_preload_kern.c
index 2fdf3c978db1..774e5a538811 100644
--- a/kernel/bpf/preload/bpf_preload_kern.c
+++ b/kernel/bpf/preload/bpf_preload_kern.c
@@ -89,5 +89,6 @@ static void __exit fini(void)
 }
 late_initcall(load);
 module_exit(fini);
+MODULE_IMPORT_NS("BPF_INTERNAL");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Embedded BPF programs for introspection in bpffs");
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 9794446bc8c6..64c3393e8270 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1583,7 +1583,7 @@ struct bpf_map *bpf_map_get(u32 ufd)
 
 	return map;
 }
-EXPORT_SYMBOL(bpf_map_get);
+EXPORT_SYMBOL_NS(bpf_map_get, "BPF_INTERNAL");
 
 struct bpf_map *bpf_map_get_with_uref(u32 ufd)
 {
@@ -3364,7 +3364,7 @@ struct bpf_link *bpf_link_get_from_fd(u32 ufd)
 	bpf_link_inc(link);
 	return link;
 }
-EXPORT_SYMBOL(bpf_link_get_from_fd);
+EXPORT_SYMBOL_NS(bpf_link_get_from_fd, "BPF_INTERNAL");
 
 static void bpf_tracing_link_release(struct bpf_link *link)
 {
@@ -6020,7 +6020,7 @@ int kern_sys_bpf(int cmd, union bpf_attr *attr, unsigned int size)
 		return ____bpf_sys_bpf(cmd, attr, size);
 	}
 }
-EXPORT_SYMBOL(kern_sys_bpf);
+EXPORT_SYMBOL_NS(kern_sys_bpf, "BPF_INTERNAL");
 
 static const struct bpf_func_proto bpf_sys_bpf_proto = {
 	.func		= bpf_sys_bpf,
-- 
2.47.1


