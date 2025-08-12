Return-Path: <bpf+bounces-65446-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 164B7B2306D
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 19:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21BAC189C7B6
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 17:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4047A2FABF8;
	Tue, 12 Aug 2025 17:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gculYJC8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621812868AF
	for <bpf@vger.kernel.org>; Tue, 12 Aug 2025 17:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021042; cv=none; b=R3Vyo57kFKN6vc9H99Fxb3yQrR6jHxpEFch3u2a92uJpvxA2r32TXRT5h8h9eqi44+joLIARa78H5kU14CYxvjN08DU1Ei1yqrVehCx3S3DH1/IVQ+0Hv0hPM8ZeZq6HSmL2BpCSWsNQUUzlH68A/EHqEsf7yGz3kTdk/lRuEzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021042; c=relaxed/simple;
	bh=UUXcwEwFGjP9SV37DaxT2aSUonEaQ90/EQtujjBZ2Fo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TkHmN5FE1BTZDGVqw0fyQ+gnEKvptNa5gSoJR7Z74HYeds/ClSF6uBVMW/YxxuGsT1Pm4EHgOnu8wggy7PH5xbe51Na4QwyrvEv1E32Mkyo2ouOvHv+keiVoGkON9KyAJKzBYtXHLMAlrLWRoM8F13U05CCx6pTm6+SMedZHnZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gculYJC8; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76bfabdbef5so4822140b3a.1
        for <bpf@vger.kernel.org>; Tue, 12 Aug 2025 10:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755021040; x=1755625840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AZk7jZH7WZ88OPtSKbONh3C8on+JPbkpWw1PXCdAwf8=;
        b=gculYJC8Lx7heUuBkEkwZlJQ4BQbMZwxXf/xHFBJ/u61+aI40QUc2aIVimh5hVfpZG
         1RmSZ3nXFItIt6AmKcwqipEzGCmSshBUL6GDHG/c8zjGllXumrz4SV0gy5CI7oVwIVwW
         OxeokEbV3bhByuVILpED7lzX1olFSY60v16n7GGmUzh2PgvxJy2n05fJD9SrY700NRh2
         62DCBZvC7nGKEPwcMZHgCb8W9QBB5XmyMEJBDGUwAG6yo7QBe4vJOStMigUVZtgkzLqR
         IwFFecYdtHrAN5j5wE1G9dHIJo++y5RdOcy/hOQWSvppkU6Ku/zQt7BGOKHAKjrwp5fq
         2Qhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755021040; x=1755625840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AZk7jZH7WZ88OPtSKbONh3C8on+JPbkpWw1PXCdAwf8=;
        b=rbcf++LBImmy7hx4v6qH4i5HT2Bnfr+jo8DAMPpsNrjuOXczS6ShiuOnDKJ+ZSdiou
         zeJal+aWFQDU70ckHzhLVaNKmR6xroAcEr2pZkOjyAo6vmVwTywT5y5wpNPNhnTFrGP4
         FaCKCQUsnPmEvOwXOF+PCEFUZbwyQYagY+QJVaaXoPk7OR5C16buwR02VEHnn2atm+KA
         3b62qEN/STqtBrj96mt5hG8Ltd5Ji1uhlyy34Jp7WKoyY4ycgHXXneUdCOumxpSyvJqw
         4nd7vu6MaBI1m2X6xaCy24HRmwfZRR6y0RrMXqN2rlNlsXEQ6/9YWCQsGUkeNkJcfowN
         cCLw==
X-Gm-Message-State: AOJu0YwAE84NrIEwQjRH1X79z1dHlaBx2nyuv1BEX1V7UIY2PQR8td2j
	nO0otvVJvRswXUSoI4iN3xPewIbOc9uTicZHK/4eyNB5PKPt1m0MUY0pehkUyw==
X-Gm-Gg: ASbGncsPGPNAJHx3v0fkuBPMpAOVhPQ1C3D6xtck4EjbidYOnNQr2wpoJE/UEHlQZgU
	CXhWXI5FOyXlYN5dxNw1L71lSvKuL0olcpyH4zZPYp0rrMXqzq/4VG/XHYVkdLoZDS8Lhl4wGrK
	XAo3jk4PFEC3RpmQRMJvOXFeYPyO6iuaIVAYGXsrzNxl3xOmHvPQc1oE1kgMn6Y3Th5TGumflgX
	mQDTBYFTqxaFIkRXa+ci5ag4+bUhft2X/tYNLy5r4nVVywEwwAHt9ttBqD9o8e6c+Bg6Rkm1x6C
	E7RjfNF0EZ/L7s4BkBvgiM0WtaQoyTX/l/WyVKHqUzhZOq9dPRwF07/s6vkC5+YNBkP/QVEPGt+
	Pm02iHG6hIlQVLt+S88GGdDQT
X-Google-Smtp-Source: AGHT+IG7r9BZyhCZFudihFViom470AlywLEuErw3NAEA88JPbH6qV+xKx96HrJYB+WCZVPD99QTbxQ==
X-Received: by 2002:a17:903:22cf:b0:226:38ff:1d6a with SMTP id d9443c01a7336-2430d0be4d4mr1692735ad.7.1755021040420;
        Tue, 12 Aug 2025 10:50:40 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:49::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef7c30sm304588675ad.37.2025.08.12.10.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 10:50:40 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	mykyta.yatsenko5@gmail.com,
	toke@redhat.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 1/1] selftests/bpf: Copy test_kmods when installing selftest
Date: Tue, 12 Aug 2025 10:50:39 -0700
Message-ID: <20250812175039.2323570-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit d6212d82bf26 ("selftests/bpf: Consolidate kernel modules into
common directory") consolidated the Makefile of test_kmods. However,
since it removed test_kmods from TEST_GEN_PROGS_EXTENDED, the kernel
modules required by bpf selftests are now missing from kselftest_install
when "make install". Fix it by adding test_kmod to TEST_GEN_FILES.

Fixes: d6212d82bf26 ("selftests/bpf: Consolidate kernel modules into common directory")
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 tools/testing/selftests/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 4863106034df..77794efc020e 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -137,7 +137,7 @@ TEST_GEN_PROGS_EXTENDED = \
 	xdping \
 	xskxceiver
 
-TEST_GEN_FILES += liburandom_read.so urandom_read sign-file uprobe_multi
+TEST_GEN_FILES += $(TEST_KMODS) liburandom_read.so urandom_read sign-file uprobe_multi
 
 ifneq ($(V),1)
 submake_extras := feature_display=0
-- 
2.47.3


