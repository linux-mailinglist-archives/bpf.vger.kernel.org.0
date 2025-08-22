Return-Path: <bpf+bounces-66276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90795B31AA9
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 16:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD2AB1D264F9
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 14:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AC221B8F5;
	Fri, 22 Aug 2025 13:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mind.be header.i=@mind.be header.b="C/8MVUkc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D922F9988
	for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 13:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755871179; cv=none; b=lCSF3EGJkfCC0zDHcaNG+HyTRjotB5Otr4CDnZ3uLb7M4N41N1pk46NQ0z01WSON87mMMMlyCUiWR4LaVGsHLkAeGU6uIPotLHWq/g1nO6y4SnaEyyT6VFr9OCLdETPkfr5CFdBmlvAE7auC1T3MWxhMQcDowIbuLvYgmdIzO7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755871179; c=relaxed/simple;
	bh=Hr/iu65GFENGLZy92IKRCfatxrU5Nb412i7sxtWQcD0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OgMaMdjcUgm0uyYdUe0tGmtcT2bge9jMhsC3LqujZITDvoOYK3mBJi1t9JFERgtmv0IYrwGKX9ta+vBhCNK23LMFgkmTw2kacmRoLN5lAbNtzZUO126GwbnjYKD++2Pbvjcdo+ErBIqRRv+LWt6U/DaSNITFiirUZGetJRwaEcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mind.be; spf=pass smtp.mailfrom=essensium.com; dkim=pass (2048-bit key) header.d=mind.be header.i=@mind.be header.b=C/8MVUkc; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mind.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=essensium.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3c68ac7e2bdso276219f8f.2
        for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 06:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google; t=1755871175; x=1756475975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XxgOKL4V7HaNjiomYQoDvLRsCs9DjqgsvWTf9O5MmYk=;
        b=C/8MVUkcydpg80yZAMXYfbWjH5RF19mzuMmOP8FIXxPLTtQ0lXBLQbZldX0I3HVAtn
         cQjYXriwuBt7T7SxFS4TLKod0TYHbiTXLiZ92izrG4E+nWjpeqGGjNMRX1dHgf7hMUZl
         Ec+y/u4HmzhQXXUEY3aWRyUCfLs6smbOGD41pwu1vA9D6z9LGSH2m6hKzrucEFwXb3Qu
         ayW8V0IGuZefGwNHaUo10pIIVNNjZuWVPKL/KuO/7nwacN8MyDK5+ds+znDxkOPlpBvR
         pB/IJuhguSoZ+VKU30TjQwydKPomQ0u2gRmJo+7dkreQtCXNFyAA3O+jzRjGlp0GVcR3
         U+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755871175; x=1756475975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XxgOKL4V7HaNjiomYQoDvLRsCs9DjqgsvWTf9O5MmYk=;
        b=qeocXtcfByz6Oovo0c37YzQ5skOGLhfMipc9rZcRIlMcCoynuYrjIH7AHom2KXC/tv
         d9quV6dZAjN1S33O+MBCiXAxu3z/clcNPE/xTzLlrPz5hGNK44LMx725iLfzhJt8T0Ay
         qcPcOtkKplnXrusyzNGUo166/zfGMF0pRGZ3RN9CSuAASbWDkFfP3mVx4knxEVdgIhaM
         idY6OdTO3TGUdVkZQqnmM63J6BljdaGWhTBoMdRuoj4+mhwrrTWD5Q5F9/zIrSZWbHZQ
         vXSOfJwKoeT0u/CtjdPNjzW6+BZYACAFsFRe7hSnCWc1mhdNCpXVFeCm3Lg4KD3A0Vq5
         T5kw==
X-Gm-Message-State: AOJu0Yx9pWv24HFaWWJ7Ph1R0280LIPOm2f8rC5OiVN5Ya8U0/Fkd0O1
	b2I1nLFlzubYEwJqfSNVS3O2MTubv7R8tQJ7gM4znTIGDjDPukMrv3ByVxjo8qyEXfBakP11mIF
	tPfA/QRXbFw==
X-Gm-Gg: ASbGncu9/fMGfeIB1rNphIatZaUbchIctHgpClB6VuT2V7VwmEMH6oGq74tnYPaseQX
	XNnYSPJd0oINaLvqBglXgHpLSWyHuBMQJR2WtZo930JeGunk7sUclkwkWQNoyPM3QhC6XG+yvLN
	+qJqSy4IOn9GvjJyWFw13Iuz5ukpu5ChcIV+8qtK3mUfOyA0ejLLkLJf6hBqJZ/KkHdDy6j9lOA
	24w5hxIVcgx/5J+gt9rjsoJsFtAE7xO5wn0V5JCcEQ+aJq8ZSHLrCVj53a74yYCDiEbqf57t/IR
	uyMyrnU0+pFZwdiuGCFlwXYAUxw3upNZw9ehcQBJmVyHuUiGfWmyzIKdOfWPvECdoLL+fYmLx9j
	zHQZv3Eml7fNWbycUwv6ATczqHNxvvSGmp9hiUcN0AZkfmjM=
X-Google-Smtp-Source: AGHT+IH14xUXTB2xUpzagKeTUSIAJrf68FsVnzXIgt0Kf2N65wJGH1EcVg2HS0/a0CHpekjnPUnHAQ==
X-Received: by 2002:a5d:5d0b:0:b0:3b7:9dc1:74bf with SMTP id ffacd0b85a97d-3c5dcdfd46emr2336721f8f.35.1755871175098;
        Fri, 22 Aug 2025 06:59:35 -0700 (PDT)
Received: from cephalopod.i.decadent.org.uk ([2a02:578:851f:1502:3474:c4d4:aa9e:144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c4ccbf04fasm6086825f8f.7.2025.08.22.06.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:59:34 -0700 (PDT)
From: Ben Hutchings <ben.hutchings@mind.be>
To: bpf@vger.kernel.org
Cc: Ben Hutchings <ben.hutchings@mind.be>,
	Dinh Nguyen <dinguyen@kernel.org>,
	linux-openrisc@vger.kernel.org,
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] nios2, openrisc, xtensa: Fix definitions of bpf_user_pt_regs_t
Date: Fri, 22 Aug 2025 15:58:48 +0200
Message-Id: <20250822135848.1922288-1-ben.hutchings@mind.be>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The UAPI <asm/bpf_perf_event.h> header is required to define the type
alias bpf_user_pt_regs_t.  The generic version includes
<linux/ptrace.h> and defines it as an alias for struct pt_regs.

For these 3 architectures, struct pt_regs is not defined in the UAPI.
They need to override the generic version with an architecture-
specific definition of bpf_user_pt_regs_t.

References: https://autobuild.buildroot.org/results/bf2/bf21079facd21d684e8656e7ac44b4218a8fcb9d/build-end.log
Fixes: c895f6f703ad ("bpf: correct broken uapi for BPF_PROG_TYPE_PERF_EVENT program type")
Signed-off-by: Ben Hutchings <ben.hutchings@mind.be>
---
I understand that perf_events is not yet supported on nios2 and
openrisc, so this isn't obviously useful.  However, libbpf has generic
handling for BPF_PROG_TYPE_PERF_EVENT that includes
<linux/bpf_perf_event.h> and it now fails to build on openrisc.

I verified that:
- This fixes building libbpf with Buildroot for openrisc
- This makes "#include <linux/bpf_perf_event.h>" work on xtensa

I wasn't able to test nios2 at all.

Ben.

 arch/nios2/include/uapi/asm/bpf_perf_event.h    | 9 +++++++++
 arch/openrisc/include/uapi/asm/bpf_perf_event.h | 9 +++++++++
 arch/xtensa/include/uapi/asm/bpf_perf_event.h   | 9 +++++++++
 3 files changed, 27 insertions(+)
 create mode 100644 arch/nios2/include/uapi/asm/bpf_perf_event.h
 create mode 100644 arch/openrisc/include/uapi/asm/bpf_perf_event.h
 create mode 100644 arch/xtensa/include/uapi/asm/bpf_perf_event.h

diff --git a/arch/nios2/include/uapi/asm/bpf_perf_event.h b/arch/nios2/include/uapi/asm/bpf_perf_event.h
new file mode 100644
index 000000000000..5e1e648aeec4
--- /dev/null
+++ b/arch/nios2/include/uapi/asm/bpf_perf_event.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI__ASM_BPF_PERF_EVENT_H__
+#define _UAPI__ASM_BPF_PERF_EVENT_H__
+
+#include <asm/ptrace.h>
+
+typedef struct user_pt_regs bpf_user_pt_regs_t;
+
+#endif /* _UAPI__ASM_BPF_PERF_EVENT_H__ */
diff --git a/arch/openrisc/include/uapi/asm/bpf_perf_event.h b/arch/openrisc/include/uapi/asm/bpf_perf_event.h
new file mode 100644
index 000000000000..6cb1c2823288
--- /dev/null
+++ b/arch/openrisc/include/uapi/asm/bpf_perf_event.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI__ASM_BPF_PERF_EVENT_H__
+#define _UAPI__ASM_BPF_PERF_EVENT_H__
+
+#include <asm/ptrace.h>
+
+typedef struct user_regs_struct bpf_user_pt_regs_t;
+
+#endif /* _UAPI__ASM_BPF_PERF_EVENT_H__ */
diff --git a/arch/xtensa/include/uapi/asm/bpf_perf_event.h b/arch/xtensa/include/uapi/asm/bpf_perf_event.h
new file mode 100644
index 000000000000..5e1e648aeec4
--- /dev/null
+++ b/arch/xtensa/include/uapi/asm/bpf_perf_event.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI__ASM_BPF_PERF_EVENT_H__
+#define _UAPI__ASM_BPF_PERF_EVENT_H__
+
+#include <asm/ptrace.h>
+
+typedef struct user_pt_regs bpf_user_pt_regs_t;
+
+#endif /* _UAPI__ASM_BPF_PERF_EVENT_H__ */
-- 
2.39.5


