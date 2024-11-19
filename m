Return-Path: <bpf+bounces-45171-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF699D250A
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 12:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 498F01F2553B
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 11:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDADA1C9ED5;
	Tue, 19 Nov 2024 11:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YOci1XSi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f67.google.com (mail-lf1-f67.google.com [209.85.167.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A2E1C07C2
	for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 11:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732016445; cv=none; b=u8UoTuq1dqUPbuThidpK9kXGzP94nV+c6PtvKXqswNszTP7vrTGz1wZvBijh/kz/a72FfNSsTyjVOLl/GtOnXJS5k75YmwHdNmat0Aoo9qO1Nn0s1VQAxvg7S6idwJ3H6K81ILBncxgzQHN969KEnOaZIx5wUOW63eIKVH1PWsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732016445; c=relaxed/simple;
	bh=GXcnKEKAUmIyOZ/ytmJRCDsejFamC5E4khXhtTJ+JYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c48qT2EjBPjrvSiVNIBjZpEkNk8GPQEGmd4046ADwEkKAzkCfw1dxak8sqH1LFVWWwF7OLJPhymX8E8Kda165koNfN/EL062WllFUPcHAR/39ilmmtHE2gcbeVHJv/X7HCCjirkD4+7KACSlh4Crkp549DDPrdrEGWq3qcy1DhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YOci1XSi; arc=none smtp.client-ip=209.85.167.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f67.google.com with SMTP id 2adb3069b0e04-53a097aa3daso2834749e87.1
        for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 03:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732016441; x=1732621241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dd0AhOrZVNFZtxtDwAKxmoFJYzISg/TRE2vP5TJBFfY=;
        b=YOci1XSixG4ZoLl81hcAEbEf24a9WUzUhaPrwpTIYls+uWh90XOxrF/eH94US5nH36
         w71Cxxw0fEvV9yp8+49Vw3I2QvmtPOf8nNKOGv18QMZgpxsNNQvQvAsIgswF3DboupOu
         ENn/nTwfqBbHlpbVd7CBdBcZ990P0QhDVZ59jnQqXeR7DFlCQ/kjqApLAUXExyxh04aZ
         yaFetW/HNuo+Zcc1J32P7mCXjrlIVXkfTWrkoeywZKg4VLXJuPdnydqHxJc530zwzkwl
         APNLg1fL5GssCKDfOTd2isllZM9vvkvKjfN7AbDmGfOod1LPJPX1OClMsDvXFhWQZmJM
         4wGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732016441; x=1732621241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dd0AhOrZVNFZtxtDwAKxmoFJYzISg/TRE2vP5TJBFfY=;
        b=E9FBKKIcQAzUyIgLyd8jlObRTM1JwDjFTdUHkT0vQlOvcqZcWCoZe3cyn+DWPpGhbF
         LLhovWSdJFEPRLZqOBATepL80KN3M58PAOEqLk2ucMu3vbvnPSrr5q5x70JQupbnwhJv
         iIe1+fGTlQCCTTUUiW3ZJZAF8q7DS4jt3zMU+21xVOlCMAhPSv2+Trgs2p8jBPF0v8Rx
         SXOJ/ccvle1ifpnOt61+S4Jp9aqPvxGyyrvkslo+4YBBlnc/HJbLyRK876M0G0TvaQVQ
         ZlnaO5BUCvZ68S0nrT2pJayBASgpYyz7nfYMqiDmVUN+B2/EcjA8RviwuSQHaSfrkzlK
         wY0w==
X-Gm-Message-State: AOJu0Yzr+nCjNBtnM4umJlS2QnOyZLIOhXerYM+etew7nZitKFHL+rn5
	RGWn8w0gz99bk6kNdc80VIiosNAZKOYEzE3d/lFqqcm2i19MgUAyPlWzep1IXOFF0oGbs6uVBeT
	kKw1xLg==
X-Google-Smtp-Source: AGHT+IHcVx8T6qCjhz0CEQTqxVweUp/3RhfMjPItR17qUPqsl7yyxvNlPqkWpBzu/qCYwDapEiwM+g==
X-Received: by 2002:ac2:4c4a:0:b0:53d:a2cc:f081 with SMTP id 2adb3069b0e04-53dab3b0f1amr6938564e87.52.1732016440249;
        Tue, 19 Nov 2024 03:40:40 -0800 (PST)
Received: from localhost (2001-b011-fa04-f863-b2dc-efff-fee8-7e7a.dynamic-ip6.hinet.net. [2001:b011:fa04:f863:b2dc:efff:fee8:7e7a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211e9d0c389sm59270725ad.161.2024.11.19.03.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 03:40:39 -0800 (PST)
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Xu Kuohai <xukuohai@huawei.com>
Subject: [RFC bpf-next v2 2/3] selftests/bpf: bring back verifier tests for bpf lsm
Date: Tue, 19 Nov 2024 19:40:20 +0800
Message-ID: <20241119114023.397450-3-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241119114023.397450-1-shung-hsi.yu@suse.com>
References: <20241119114023.397450-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add back 'test 3' from Xu Kuohai, which was previously removed because BPF
verifier signed range deduction was not precise enough. With last patch in this
series applied this test no longer fails.

Link: https://lore.kernel.org/bpf/CAADnVQJ2bE0cAp8DNh1m6VqphNvWLkq8p=gwyPbbcdopaKcCCA@mail.gmail.com/
Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 tools/testing/selftests/bpf/progs/verifier_lsm.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_lsm.c b/tools/testing/selftests/bpf/progs/verifier_lsm.c
index 32e5e779cb96..08251c517154 100644
--- a/tools/testing/selftests/bpf/progs/verifier_lsm.c
+++ b/tools/testing/selftests/bpf/progs/verifier_lsm.c
@@ -26,6 +26,22 @@ __naked int errno_zero_retval_test2(void *ctx)
 	::: __clobber_all);
 }
 
+SEC("lsm/file_alloc_security")
+__description("lsm bpf prog with -4095~0 retval. test 3")
+__success
+__naked int errno_zero_retval_test3(void *ctx)
+{
+	asm volatile (
+	"call %[bpf_get_prandom_u32];"
+	"r0 <<= 63;"
+	"r0 s>>= 63;"
+	"r0 &= -13;"
+	"exit;"
+	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 SEC("lsm/file_mprotect")
 __description("lsm bpf prog with -4095~0 retval. test 4")
 __failure __msg("R0 has smin=-4096 smax=-4096 should have been in [-4095, 0]")
-- 
2.47.0


