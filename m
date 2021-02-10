Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC95315DD8
	for <lists+bpf@lfdr.de>; Wed, 10 Feb 2021 04:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhBJDiA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 22:38:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbhBJDh7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Feb 2021 22:37:59 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69338C06178B
        for <bpf@vger.kernel.org>; Tue,  9 Feb 2021 19:36:47 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id m6so401753pfk.1
        for <bpf@vger.kernel.org>; Tue, 09 Feb 2021 19:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=01Exh/2ObMelGUhb994VG5lHlejeefEcqeiEWbL0Xvk=;
        b=KP8poCIX/DRk2rr8R33udeZ6Fw+VTS20ntjyxl49gkxHj2/wIRQXzLpgGuJJBYs/Rz
         2foMTibGuJNmaU97XExr9/Xbz9FblARt23DB9kUPsuomD5hYcWHPLnLo1G34hSIslwVb
         98wUE7ABPRKiXoQpv0QMBBtpADK8agZDx5b4qoytYAe/sU72RV3eXAqu8w2mEptGMoPo
         wrik0oNfaVkgFIS/JSeJyg6JgmTLcVdQdfl8wfXjBmRMrEKMcXGgqHUxBBmTzbyEWRe1
         2GMyGg2KG7U/ZicaviiPB6/HsuFzwKNZ4jcbPQ4zgqEUcWK72EILpwWCmx1Y+NzjraK1
         HBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=01Exh/2ObMelGUhb994VG5lHlejeefEcqeiEWbL0Xvk=;
        b=gMLtwEVdNmpt+ZTEDs+mw753UA9ERiGwQKHf+FitHI4sABYu+OTe7UxWZ2ULCcK64m
         xyZlm7WizqB8MzwkJM39qBgmtu68pv1DcJznkVNqiSBnYFpV5GDgvF2DLL4TiiNXcbGn
         lSlgC0jwS2A1h8AP10HGbRtoEqQuTjItpwPGiaj/6tP326w+OFVbp3yAm67nvj0YSsdv
         rt+iDRKXTA+cgc1hHskVh/fj5vugeqFfHxzdKkxgfDQwCnf/d+aiPtjHNZzP/tZOpRWH
         St3BFI/FcTOMm7qyE/oPzrw9yGfhsGB5AGKWd0YL5RuB8D8nELAWzLsQM7VsE+rjmijP
         iplQ==
X-Gm-Message-State: AOAM5313jqDyIK5gbIuyeyLw5eDp/5m/sQCnUyCAIy9+h2NCBYUd8emw
        0VIWZF+yNJ6iHTies5JLRp5Fn2PHlak=
X-Google-Smtp-Source: ABdhPJy1s6TgtIoOJZ6K3fSvKzndgpseLjjitpsaxshqxEkfLqJ/fihabtTr2bPcsq2BnxJ2B3Jz5Q==
X-Received: by 2002:a05:6a00:80e:b029:1b6:39dd:8b2a with SMTP id m14-20020a056a00080eb02901b639dd8b2amr1022299pfk.23.1612928207015;
        Tue, 09 Feb 2021 19:36:47 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([163.114.132.7])
        by smtp.gmail.com with ESMTPSA id f7sm391099pjh.45.2021.02.09.19.36.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2021 19:36:46 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH v4 bpf-next 7/9] selftests/bpf: Improve recursion selftest
Date:   Tue,  9 Feb 2021 19:36:32 -0800
Message-Id: <20210210033634.62081-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20210210033634.62081-1-alexei.starovoitov@gmail.com>
References: <20210210033634.62081-1-alexei.starovoitov@gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

Since recursion_misses counter is available in bpf_prog_info
improve the selftest to make sure it's counting correctly.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/recursion.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/recursion.c b/tools/testing/selftests/bpf/prog_tests/recursion.c
index 863757461e3f..0e378d63fe18 100644
--- a/tools/testing/selftests/bpf/prog_tests/recursion.c
+++ b/tools/testing/selftests/bpf/prog_tests/recursion.c
@@ -5,6 +5,8 @@
 
 void test_recursion(void)
 {
+	struct bpf_prog_info prog_info = {};
+	__u32 prog_info_len = sizeof(prog_info);
 	struct recursion *skel;
 	int key = 0;
 	int err;
@@ -28,6 +30,12 @@ void test_recursion(void)
 	ASSERT_EQ(skel->bss->pass2, 1, "pass2 == 1");
 	bpf_map_lookup_elem(bpf_map__fd(skel->maps.hash2), &key, 0);
 	ASSERT_EQ(skel->bss->pass2, 2, "pass2 == 2");
+
+	err = bpf_obj_get_info_by_fd(bpf_program__fd(skel->progs.on_lookup),
+				     &prog_info, &prog_info_len);
+	if (!ASSERT_OK(err, "get_prog_info"))
+		goto out;
+	ASSERT_EQ(prog_info.recursion_misses, 2, "recursion_misses");
 out:
 	recursion__destroy(skel);
 }
-- 
2.24.1

