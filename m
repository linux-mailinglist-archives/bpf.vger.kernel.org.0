Return-Path: <bpf+bounces-65127-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C314DB1C7A4
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 16:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 827DD188C9AC
	for <lists+bpf@lfdr.de>; Wed,  6 Aug 2025 14:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4712028DB73;
	Wed,  6 Aug 2025 14:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AaLqpZCm"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340FE28DB7F
	for <bpf@vger.kernel.org>; Wed,  6 Aug 2025 14:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754490674; cv=none; b=CsGWHua4naGm753LTa0ttQZYt9Fe8cIsLQpQn6bk+FduQtZfZssqyLpeaViEbv1suws2QpQwqacbFcBHJ66d3Lr4Qy1OK4K0FBJK6wrxlNrkNCy4FYDuztPLNj+RZ7Y4qGUTFwnsZaXr9S5z+Vhiob8kaXGly+O1d+B4kpfyUKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754490674; c=relaxed/simple;
	bh=InkPhHeic8qB1Cg9YLB67GOAs9m8OvwtVDVuqy0Xq2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qif/PGSNS5Vl5pAXnBLfy7DNYcG6424GXbJFBJzdEtCq4RcWuVdJ5bPPAq2gXJx2sRECuXCPhQJ3qUw+eObq54sotyFb8C7stEpWCVoMUioqIwmUhKyC3l3xcVdXQ5jAjZTluaRhI8OKpr1+9i5sbj5DBvUwzifrc7W937Fvcu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AaLqpZCm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754490672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QRCxO5LEsmHWpUSNSPauqINHADCftQQ6v6EfUX21S/M=;
	b=AaLqpZCmSNKGgHmxMO7sch3LbFtIEpVk6JCdmtBCRH3nZaQbxy6jzMMeAn5Zat5NtZKNfH
	+46GHZWJgNNn9EEdZzuPdb075vSuF6jA8m0SnA53Z8qNUnpgpbgur+ETtiak0Mf/D1Uc2j
	8ws6LrdmXFQrikgyRbZQudIACGms7O0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-iYXvR8rpPV2vr9RI1G0YKQ-1; Wed, 06 Aug 2025 10:31:08 -0400
X-MC-Unique: iYXvR8rpPV2vr9RI1G0YKQ-1
X-Mimecast-MFC-AGG-ID: iYXvR8rpPV2vr9RI1G0YKQ_1754490668
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b7806a620cso3089512f8f.3
        for <bpf@vger.kernel.org>; Wed, 06 Aug 2025 07:31:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754490667; x=1755095467;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QRCxO5LEsmHWpUSNSPauqINHADCftQQ6v6EfUX21S/M=;
        b=efk0GTiSKSTWBzn0p7kMyLRjwz9XaPWMcUuopFufXhRYlNBB+b7L412OTIaUKDc7dN
         wcxhD13qNtaQnb9+hugfdIeGRw0SgdXHKbSDUVteL4Hl/RhW8KUZib2uAqzVbkW1wN+n
         26vegmJWag4zGA7g9+hM5YU6ZVQsxkk1NgMF/yNTe0A6DO4Js38UoutkoMqidAJVcVom
         4Dw4yusKeANHGMKmjYPQoBCAnSDHWAABqpOX2d6r7in7M0xlGvemCEj51U4U2hcjVm1F
         ARbhO4YAKP2Hb162C9ryodGn3NZumIk/09D6AdIUK7pw0+J0a6ocBqLdriY9QtxvG+b1
         9C+Q==
X-Gm-Message-State: AOJu0YyjCDihIsp70ilcmwF/ktft7uVd7WbmGP7UIwPkpkaGR75vXmJ1
	qe2o7hrQHQ2SbVgzlOZ0WrQG9eHtrTBU+Pf2DwotQuf+AwoEbw/Yh9xUC/VB4fw5JOYEYiPWtJk
	2XNkantVKRkyruwJn/aGgyFAayymEOB+JuOt2sarKifH0VJ20xFinQQ==
X-Gm-Gg: ASbGnctFeIDRSdod+OcdHxUPgsd37E9+PF4xCV5LPHcceYZYCCNCpVtWTOzGztdAur7
	ACmOpGE2POjqvBHBxdwtsXfcRcyR4I/qgMxTSNu7nQFqnwris8cyqGCIegreIeonTmAZ0Nyyru/
	CxnVD/U8EmaE4uxS50E5B3KtQOpUvVG24LVRuDgfh4yX9hRS2PJdEDIuUOQrEZql+rGuyXY3umH
	+NNYApmefOHCCzzyx7Ck/w57brXHyMmkZy4nntxQTORIvv2naxICuJnrttsde/Qv8dsyVss9Q2D
	wcTvsVNVTW0wiNjh1QWx7HTZWucK0v6wLpQ=
X-Received: by 2002:a05:6000:4029:b0:3b7:8fcc:a1e3 with SMTP id ffacd0b85a97d-3b8f421057fmr2658542f8f.48.1754490667545;
        Wed, 06 Aug 2025 07:31:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiJBQ1yelVUM9E1lMgUijAACK9NPTXg6PpQUczFaIPct+wwXKaPFImCbN1OzlcZ3oUMOB6dg==
X-Received: by 2002:a05:6000:4029:b0:3b7:8fcc:a1e3 with SMTP id ffacd0b85a97d-3b8f421057fmr2658518f8f.48.1754490667074;
        Wed, 06 Aug 2025 07:31:07 -0700 (PDT)
Received: from fedora ([2a02:8308:b104:2c00:7718:da55:8b6:8dcc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8e009e465sm14204156f8f.43.2025.08.06.07.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 07:31:06 -0700 (PDT)
From: Ondrej Mosnacek <omosnace@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: bpf@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH] x86/bpf: use bpf_capable() instead of capable(CAP_SYS_ADMIN)
Date: Wed,  6 Aug 2025 16:31:05 +0200
Message-ID: <20250806143105.915748-1-omosnace@redhat.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't check against the overloaded CAP_SYS_ADMINin do_jit(), but instead
use bpf_capable(), which checks against the more granular CAP_BPF first.
Going straight to CAP_SYS_ADMIN may cause unnecessary audit log spam
under SELinux, as privileged domains using BPF would usually only be
allowed CAP_BPF and not CAP_SYS_ADMIN.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=2369326
Fixes: d4e89d212d40 ("x86/bpf: Call branch history clearing sequence on exit")
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
---
 arch/x86/net/bpf_jit_comp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 15672cb926fc1..2a825e5745ca1 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2591,8 +2591,7 @@ emit_jmp:
 			seen_exit = true;
 			/* Update cleanup_addr */
 			ctx->cleanup_addr = proglen;
-			if (bpf_prog_was_classic(bpf_prog) &&
-			    !capable(CAP_SYS_ADMIN)) {
+			if (bpf_prog_was_classic(bpf_prog) && !bpf_capable()) {
 				u8 *ip = image + addrs[i - 1];
 
 				if (emit_spectre_bhb_barrier(&prog, ip, bpf_prog))
-- 
2.50.1


