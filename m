Return-Path: <bpf+bounces-56735-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFF5A9D43A
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 23:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 401644C1E9D
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 21:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6EE224AF9;
	Fri, 25 Apr 2025 21:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vv91bpBN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F25820C000
	for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 21:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745617188; cv=none; b=MCAQoFpwMekCNZTbx1F9QrpTzUT4w31v/L3/ciEvavUI8p8FFozr6/bhiseJUDEQ05drWni2mFB4Nqv9sr2Nj0tT1L983FZfzo21yXzqqeEjYiBIoVI6muVpBwv9ZeWIdnyb9Q3TFCSddTrNaj24fQNJHRNi0wro4k3uXSyZitc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745617188; c=relaxed/simple;
	bh=nqLMcYEnp7TRldI8UDk1/89xaAGHDoDkIiBAexvXTrA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JdZ0Z/kiRYwnDyKfv8RR+bXElFuVPGtxtyJa6O6gMHu/GaEhKVO+wTAp/YUX56TBJj08i84IZX0+rcZsSbjpT4wQ2XqS189L3CVGMK65ZaNxHrou7Er3Kn6NTWAsXt0B1i6b/hhPBPSEPIpXHC9Vt38PlcfJXP00clfnEFg6T7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vv91bpBN; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-739515de999so2303244b3a.1
        for <bpf@vger.kernel.org>; Fri, 25 Apr 2025 14:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745617186; x=1746221986; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H+W30opamxEm/bE6Q5G3bwCNZD+tWOhwlXHl3AqSUOg=;
        b=vv91bpBNfIVax8AefJ5U6ld7gVzRo/zNzGU8YPLF/46k3lFHzsdfDl8urDaOdxFPPp
         5Ux3YDq2SfL51h0yOIiTOfLKThQBnH/Hi6L+I7GcrUUeIs05ikTp87xXat7piNtb1Tjp
         NDH97aWxi2Qpg9VCYIjTjC78hbwxN0v4+NoMTvy/l8SEmcj94F0x4iwlCqOpyo7hf11w
         BBaSCe0+pGwnRItgfyNDMCgLUZopZ/xckEjzIAWCU7SZJtYlUjxNvKEeCMOSpmopGPgy
         EfVwZ29FsLOXpIIXSTquL6/Hl3ms2YsMHeqdxSdmemjiZIOq4UYSPR0F1tjtRt+4nrRr
         bXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745617186; x=1746221986;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H+W30opamxEm/bE6Q5G3bwCNZD+tWOhwlXHl3AqSUOg=;
        b=MyDE+A35aMfz4J81MjG7KWadqHJ+nh8JjfmQ62QG+n9cpS4NcLCfPL1IB+LJv/lqes
         xMl/vCETS+QZOyjqsPWlW/dm9Q69O/b4zwmeloIZFsGWUywzv1pRu8+ODYdre94Aol19
         F/+WEg4GsXeWCsK7sdrdSufciyKRPgT3+9bhNpst0ryv+dCqxTfme/kXP0AA842jKUH+
         FTHH1Wj8j0e8aPuvcul32LxGAMXOdOHBbLm0mNSJw+sbZXTnXMY2z0VpqMGMOwXU+/Kk
         QpN6zJ81mNTKxp+UMpQCoXuMuDIAaYGjFsFIDVaL+RudUj4ZFBwiPKYidOsbZt/RG+6F
         Ci1A==
X-Gm-Message-State: AOJu0Yx4QK6z7rjiFtAY+x+JENF0yhp+rvI2fCeB97RI/vmOLKy6P8ie
	mXtYYP/i+9LEA+tLqA+7rp0xF2IFoX6t0sCJlr6STytGlmLKZuLOo47y/yM2npqKlKTuxLZiJrf
	0SLXW4CkfuMLriG0zORDu6gnPHv4AcHeCOC/XgFfnjQCrCBaMCitKzfWM/OvFQ8IMZ91v9Iwxah
	TO6RW7Ga7laOnrzeqfnHLZ5A2CASKZ93/z6+ITi+k=
X-Google-Smtp-Source: AGHT+IGoxC2JT5VKEhMabdn4fuQawHBCo3n40dBgZGYTOET0p2n84BvHEsbo14mhLkqgDlr0gIlp4NksQhtj3w==
X-Received: from pgns27.prod.google.com ([2002:a63:925b:0:b0:af0:e359:c50a])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:9d94:b0:204:4573:d855 with SMTP id adf61e73a8af0-2045b6b0383mr5538423637.9.1745617186465;
 Fri, 25 Apr 2025 14:39:46 -0700 (PDT)
Date: Fri, 25 Apr 2025 21:37:10 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.850.g28803427d3-goog
Message-ID: <20250425213712.1542077-1-yepeilin@google.com>
Subject: [PATCH bpf] selftests/bpf: Correct typo in __clang_major__ macro
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org
Cc: Peilin Ye <yepeilin@google.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Josh Don <joshdon@google.com>
Content-Type: text/plain; charset="UTF-8"

Make sure that CAN_USE_BPF_ST test (compute_live_registers/store) is
enabled when __clang_major__ >= 18.

Fixes: 2ea8f6a1cda7 ("selftests/bpf: test cases for compute_live_registers()")
Signed-off-by: Peilin Ye <yepeilin@google.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 13a2e22f5465..863df7c0fdd0 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -221,7 +221,7 @@
 #define CAN_USE_GOTOL
 #endif
 
-#if _clang_major__ >= 18
+#if __clang_major__ >= 18
 #define CAN_USE_BPF_ST
 #endif
 
-- 
2.49.0.850.g28803427d3-goog


