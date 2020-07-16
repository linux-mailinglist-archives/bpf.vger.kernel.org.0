Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1EE02225E7
	for <lists+bpf@lfdr.de>; Thu, 16 Jul 2020 16:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgGPOjj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Jul 2020 10:39:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58248 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728955AbgGPOjj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Jul 2020 10:39:39 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1jw52u-0006ul-CJ
        for bpf@vger.kernel.org; Thu, 16 Jul 2020 14:39:36 +0000
Received: by mail-io1-f72.google.com with SMTP id d64so3692088iof.12
        for <bpf@vger.kernel.org>; Thu, 16 Jul 2020 07:39:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R6Vp2q7Z0AYp/kVnpoBWr500ikgjJpj3Qnu3Hl9IZkg=;
        b=XvtgLe0CQZOezf61hPRdpPDXqWlGLpZRslmEuBKhmI6uyHf1LljCgTQwf5y3KNUtEX
         aDumkJYqbx94/qJLjiQgrPCOs1iGGMdFxAbq5Dmy6cqEekBL4653uUDkXLhTWa0tL152
         ACgfISOgudL/q9VSKOURJNM0vAF/NP3/+9Yuqinx94pC0zm4UtVjrVkYJdMlGNqEH5Ss
         fl/7p5hekVV0TpTiklDdzg1L43Ht0iAJBWN8+KrCt0p1aVF1FXkp+ZYPNly4EvFdcwBU
         NRrj2bWimHnG+uZgyNo7WsTzpgodbliSGP2YDNeSgm2Ib+W8w/YVkZ71LYESrripaRNR
         rjEg==
X-Gm-Message-State: AOAM532mNpmKknxPaj1tiOou0V5rbYrH3KlXpmujocaP4yYTtxsUSpJ6
        RCG9AUnvlPrmoeoPwqUp4hSzrFVrhSJEVN5AtHeE3ymZCC/yl17+MdQQ3b2kcVmgHfSzXztx0d1
        cZEc5R5S6pLmeC/h26AIIGA8PRLmQCA==
X-Received: by 2002:a92:aac8:: with SMTP id p69mr5123521ill.26.1594910373312;
        Thu, 16 Jul 2020 07:39:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBPP1hBjN4dv0mJH0CucnCvELVhUU8DEtOkN3QnRH7+kA6uRArkIsCl5a4LLp7dyeEYbWQWw==
X-Received: by 2002:a92:aac8:: with SMTP id p69mr5123478ill.26.1594910372525;
        Thu, 16 Jul 2020 07:39:32 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:90fa:132a:bf3e:99a1])
        by smtp.gmail.com with ESMTPSA id j19sm2779760ile.36.2020.07.16.07.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 07:39:31 -0700 (PDT)
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "test_bpf: flag tests that cannot be jited on s390"
Date:   Thu, 16 Jul 2020 09:39:31 -0500
Message-Id: <20200716143931.330122-1-seth.forshee@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This reverts commit 3203c9010060806ff88c9989aeab4dc8d9a474dc.

The s390 bpf JIT previously had a restriction on the maximum
program size, which required some tests in test_bpf to be flagged
as expected failures. The program size limitation has been removed,
and the tests now pass, so these tests should no longer be flagged.

Fixes: d1242b10ff03 ("s390/bpf: Remove JITed image size limitations")
Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
---
 lib/test_bpf.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index a5fddf9ebcb7..ca7d635bccd9 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -5275,31 +5275,21 @@ static struct bpf_test tests[] = {
 	{	/* Mainly checking JIT here. */
 		"BPF_MAXINSNS: Ctx heavy transformations",
 		{ },
-#if defined(CONFIG_BPF_JIT_ALWAYS_ON) && defined(CONFIG_S390)
-		CLASSIC | FLAG_EXPECTED_FAIL,
-#else
 		CLASSIC,
-#endif
 		{ },
 		{
 			{  1, SKB_VLAN_PRESENT },
 			{ 10, SKB_VLAN_PRESENT }
 		},
 		.fill_helper = bpf_fill_maxinsns6,
-		.expected_errcode = -ENOTSUPP,
 	},
 	{	/* Mainly checking JIT here. */
 		"BPF_MAXINSNS: Call heavy transformations",
 		{ },
-#if defined(CONFIG_BPF_JIT_ALWAYS_ON) && defined(CONFIG_S390)
-		CLASSIC | FLAG_NO_DATA | FLAG_EXPECTED_FAIL,
-#else
 		CLASSIC | FLAG_NO_DATA,
-#endif
 		{ },
 		{ { 1, 0 }, { 10, 0 } },
 		.fill_helper = bpf_fill_maxinsns7,
-		.expected_errcode = -ENOTSUPP,
 	},
 	{	/* Mainly checking JIT here. */
 		"BPF_MAXINSNS: Jump heavy test",
@@ -5350,28 +5340,18 @@ static struct bpf_test tests[] = {
 	{
 		"BPF_MAXINSNS: exec all MSH",
 		{ },
-#if defined(CONFIG_BPF_JIT_ALWAYS_ON) && defined(CONFIG_S390)
-		CLASSIC | FLAG_EXPECTED_FAIL,
-#else
 		CLASSIC,
-#endif
 		{ 0xfa, 0xfb, 0xfc, 0xfd, },
 		{ { 4, 0xababab83 } },
 		.fill_helper = bpf_fill_maxinsns13,
-		.expected_errcode = -ENOTSUPP,
 	},
 	{
 		"BPF_MAXINSNS: ld_abs+get_processor_id",
 		{ },
-#if defined(CONFIG_BPF_JIT_ALWAYS_ON) && defined(CONFIG_S390)
-		CLASSIC | FLAG_EXPECTED_FAIL,
-#else
 		CLASSIC,
-#endif
 		{ },
 		{ { 1, 0xbee } },
 		.fill_helper = bpf_fill_ld_abs_get_processor_id,
-		.expected_errcode = -ENOTSUPP,
 	},
 	/*
 	 * LD_IND / LD_ABS on fragmented SKBs
-- 
2.27.0

