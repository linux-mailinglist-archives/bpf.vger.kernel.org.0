Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0EDF3D0DA6
	for <lists+bpf@lfdr.de>; Wed, 21 Jul 2021 13:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237074AbhGUKsK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Jul 2021 06:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238642AbhGUKAd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Jul 2021 06:00:33 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F44FC061762
        for <bpf@vger.kernel.org>; Wed, 21 Jul 2021 03:41:09 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id bu12so2604428ejb.0
        for <bpf@vger.kernel.org>; Wed, 21 Jul 2021 03:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=of1aHiumD0d746c1BNBCXDD6a5ghwP+21JON2EtY/nc=;
        b=O+AIL5WfDv+LnDd77LpVwq/3jOaXiZ4fnmed7KimdnkYKH5ZxjEY147HnmxRk/6ftk
         E3ax0dLhv6/V2+2d51q7QQKDAckTi3LTo1UfnVmjov3rqVaH6+VL9yKLt9PJaMhnq0Kx
         wDerR0hZps1mIqoHjDAwimB2WkowcDl8A0qMJSjCXAoIYOhStZd9jaeSH3gIUwpTD85n
         4gRHwZj2IOxA2hLqo9lWVeC2L0r5WGR/5ORO11JsbbEI6/YojiaS5fT+eNDl8ZyaSCvw
         4ENfhWBxadeITB/TuDlh7IBVmcvqHpdQGvq8gbWzJwECZe2KkWjDzieHecWR/bHoxSFc
         FL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=of1aHiumD0d746c1BNBCXDD6a5ghwP+21JON2EtY/nc=;
        b=MHUTFM7Psq+R5bEYfMZmmg7Vn2nuneOsuHWxQ/ars0L6v4LoxFqqLwm2fOJYdaM5z+
         LFn0ZXouoVy4JDi9o+OBeWYzPKsGOFzUEnHTmpJvaHYpOpFDF8Ha3ji+kzbUFYMX7Yhw
         xWCXgwlSxSwHcG1yjs5tgPcbImUkjTU7zbNLqYmFPU1ecr2gbzv8QS1TpYkZ1SKjDKDQ
         KdLLRNuf6N9fd5AOYgrBdINWruy4AKPlYzGq63rAWm/irUONFbhvdMTA90YjwpUON8og
         GZ6iKY54vcCYfRaZcHXOKwbZ1MNNQZYmTsFj4QiSAc6mcLFwC8w3oA/++WlmH3W9mS28
         6XWA==
X-Gm-Message-State: AOAM533lgFA4CjscUp+BrsVb3c4Moxi6g3+T5b0SfXkThqjI5xdism+f
        qEHq3L5Mn2cwtmQaWG1mJe4qlGKydzX6qYu3ABnZ8g==
X-Google-Smtp-Source: ABdhPJxYeCaVjdROd2OYfevnzDCpbLcnbMjaYnylZ4Sf0IQ8//ncTW8EcevuSwO2MTUcFAXZdHfJ2Q==
X-Received: by 2002:a17:906:4b46:: with SMTP id j6mr38006668ejv.247.1626864068041;
        Wed, 21 Jul 2021 03:41:08 -0700 (PDT)
Received: from anpc2.lan (static-213-115-136-2.sme.telenor.se. [213.115.136.2])
        by smtp.gmail.com with ESMTPSA id hb7sm8174054ejb.18.2021.07.21.03.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 03:41:07 -0700 (PDT)
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        Tony.Ambardar@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Johan Almbladh <johan.almbladh@anyfinetworks.com>
Subject: [PATCH] bpf/tests: fix copy-and-paste error in double word test
Date:   Wed, 21 Jul 2021 12:40:58 +0200
Message-Id: <20210721104058.3755254-1-johan.almbladh@anyfinetworks.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This test now operates on DW as stated instead of W, which was
already covered by another test.

Signed-off-by: Johan Almbladh <johan.almbladh@anyfinetworks.com>
---
 lib/test_bpf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/test_bpf.c b/lib/test_bpf.c
index baff847a02da..f6d5d30d01bf 100644
--- a/lib/test_bpf.c
+++ b/lib/test_bpf.c
@@ -4286,8 +4286,8 @@ static struct bpf_test tests[] = {
 		.u.insns_int = {
 			BPF_LD_IMM64(R0, 0),
 			BPF_LD_IMM64(R1, 0xffffffffffffffffLL),
-			BPF_STX_MEM(BPF_W, R10, R1, -40),
-			BPF_LDX_MEM(BPF_W, R0, R10, -40),
+			BPF_STX_MEM(BPF_DW, R10, R1, -40),
+			BPF_LDX_MEM(BPF_DW, R0, R10, -40),
 			BPF_EXIT_INSN(),
 		},
 		INTERNAL,
-- 
2.25.1

