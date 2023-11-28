Return-Path: <bpf+bounces-16055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB567FBEB4
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 16:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCDCAB20C85
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 15:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23593528B;
	Tue, 28 Nov 2023 15:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GibD/jeZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E2795;
	Tue, 28 Nov 2023 07:55:18 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6cc02e77a9cso3164783b3a.0;
        Tue, 28 Nov 2023 07:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701186917; x=1701791717; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xZsgogkFvQta+bD1L9N7CDsGe7p3FH8Sftpj+xzgtys=;
        b=GibD/jeZsGav8M6mKhLQy/3rYSN2llBtoYc6WH3FZFlrLp0DGDfn28u6pc++brVQmO
         ERnK265GrFAE7TeC4sYBo8n1A9cBcPrYsG/tPq9fPo19/5P37/nsGV+og/N09XqSIPch
         kYYc/BHNckArVVX0RFIidiMw8Le5XKdLEJ0GtCr8csmXuT/lqYWF6BF2bYss/WRkJQOF
         IofmUFizkXjobX6OadGP+LMfRPtOaV9a6vJJC+HWWmXshvQLuTIomVA0U5q9itB/+ZCu
         CMGeMpKeQIdHtwdw0vebxmes18fdfTfvwAmdmuc1cKYCPVyT7N0pWpzzdDPMixrAp24G
         jl5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701186917; x=1701791717;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xZsgogkFvQta+bD1L9N7CDsGe7p3FH8Sftpj+xzgtys=;
        b=XXgCer2KUD+0h+fCHCCGeD4Y/oU3dqXA+51P4Wkf2UMQovUA6F71/vo1o+l+owDKpC
         TCqjU1nl22WybqEkDmXdl94TMRLXANIg5pooCmAZOS/GgflXeVMxhG/mCtopmBg0JlTN
         EJ9ivl+tF03yQx743eYq/IB189PlejRDLFo6fBwQSRLL3WvPxBbd+dXcNYgsOwSv5y0n
         DRuDFD3x8jM3EZe6QuurbpvPCMhOYi6Mb9hpTp0fHA+jxHEq7yRMpOqfDGeL05GIz5IU
         7jZ/ZVoTy/vgMjkvLDXjvGehNMzlsWZ2O4HZqQbVQzAubrKWaaF5ZLvdVFbx0KkqEr9S
         h/5A==
X-Gm-Message-State: AOJu0Yzu7P8o1+4oUPWG4k69m4jOsESMiU3JZg+LLNR9Yrnu9FI+EyFF
	ycUtSheIeKDxKg5LWGAhAOs=
X-Google-Smtp-Source: AGHT+IGmRwrCZgkZ2DHuQvbtB6nkOCBHOYq2T5y5w4VsyCL3mzjT9Ocy2+j53sxtXblWgBJmnTRoRA==
X-Received: by 2002:aa7:9f05:0:b0:6b8:69fa:a11 with SMTP id g5-20020aa79f05000000b006b869fa0a11mr17909686pfr.12.1701186917478;
        Tue, 28 Nov 2023 07:55:17 -0800 (PST)
Received: from john.lan ([2605:59c8:148:ba10:1a40:ebd8:363b:757e])
        by smtp.gmail.com with ESMTPSA id w12-20020aa7858c000000b006cd8c9ae7adsm3695378pfn.25.2023.11.28.07.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 07:55:16 -0800 (PST)
From: John Fastabend <john.fastabend@gmail.com>
To: martin.lau@kernel.org,
	jakub@cloudflare.com
Cc: john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf v3 0/2] sockmap fix for KASAN_VMALLOC and af_unix
Date: Tue, 28 Nov 2023 07:55:13 -0800
Message-Id: <20231128155515.9302-1-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The af_unix tests in sockmap_listen causes a splat from KASAN_VMALLOC.
Fix it here and include an extra test to catch case where both pairs
of the af_unix socket are included in a BPF sockmap.

Also it seems the test infra is not passing type through correctly when
testing unix_inet_redir_to_connected. Unfortunately, the simple fix
also caused some CI tests to fail so investigating that now.

v3: drop unnecessary assignment (Martin) and rebase on latest selftests.

v2: drop changes to dgram side its fine per Jakub's point it graps a
    reference on the peer socket from each sendmsg.

John Fastabend (2):
  bpf: sockmap, af_unix stream sockets need to hold ref for pair sock
  bpf: sockmap, add af_unix test with both sockets in map

 include/linux/skmsg.h                         |  1 +
 include/net/af_unix.h                         |  1 +
 net/core/skmsg.c                              |  2 +
 net/unix/af_unix.c                            |  2 -
 net/unix/unix_bpf.c                           |  5 ++
 .../selftests/bpf/prog_tests/sockmap_listen.c | 51 +++++++++++++++----
 .../selftests/bpf/progs/test_sockmap_listen.c |  7 +++
 7 files changed, 56 insertions(+), 13 deletions(-)

-- 
2.33.0


