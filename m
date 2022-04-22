Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7572C50B6CE
	for <lists+bpf@lfdr.de>; Fri, 22 Apr 2022 14:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447273AbiDVMIa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Apr 2022 08:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447270AbiDVMHZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Apr 2022 08:07:25 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1D656743
        for <bpf@vger.kernel.org>; Fri, 22 Apr 2022 05:03:13 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id u15so6992916ple.4
        for <bpf@vger.kernel.org>; Fri, 22 Apr 2022 05:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RGyYpTTr+6KIJE1eoOxIScVTt/Yg1gFBt+3DlTxvD6k=;
        b=WezksrIO9cBOZm+7M9hWc9TYrxPJ6T18bNocf5S0bzYc83UQOuhNL76ufPjqEplQ7+
         zcTJ1o2NddD9tRnR60CSBSMD3TMUzQ2+06l1VlOba1dBq7Fru4t0O809CKrb6cnYKRYE
         8hcZKFmF/qIbwpqhoJvS3zxdkjY5mQU1iXsHe5zVu069g2/BxVcs5lAMHLtzmq8BNLXk
         DS7U4/oN94/nBIkF5vnlhCFPiuak7tOTRq1wcXFp4Afo1hO5h7tWYU1B8kw6m6PPy2aN
         5bXhuZ5LODq2wMRTeu+5swP+Ui3Dv3zks27HmYqboAWlCVnD0aWBr3yGRj98islJhuG0
         ffdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RGyYpTTr+6KIJE1eoOxIScVTt/Yg1gFBt+3DlTxvD6k=;
        b=n8ysqhyCSI4oOMNzkFRK1OjK90H5uC2qy8U4KPuE/mX7jeKIEYTKsxfEmbD8x1TyrV
         z10/6j5/zKd1upnerCQJxn4qF3SG0L3uATrGMLo4mm9128Hok1Tj+7uGlJo7U1CKDv8S
         F8cJXkccvvrcIIicCkTE6b1MQD1aLhy5FPwjdhniIcRmpSvXgxtI5eb8WKt3s1FiEXkK
         T6yrodr2AxYExMYr54wnR3tPMfcmxyrCpSD+lmg9mIyF7ze6DaDodujv4LR4j+Qoeh0C
         WhDMcNZLRhWerfj6euTpoMIDm4SmO56Aw3NxMIoNsVv+26AStbsrGxz6VlxC+EOh7Dt9
         mwUQ==
X-Gm-Message-State: AOAM531JOb8Eb4nl2q2HlO6b26l6TdUKJ9B/4H56nxoJNDqxk5kvKEI3
        CLryzt6y9yq12XojweVs3ZErAA==
X-Google-Smtp-Source: ABdhPJxeCZJjv2rjgLe84yf4gMYdw+HoLPtMJQ9KCWvTQDy9ShI4Cf2JFulymU2FXyiNbD3K08Wa2w==
X-Received: by 2002:a17:90b:4d8c:b0:1d2:a600:301f with SMTP id oj12-20020a17090b4d8c00b001d2a600301fmr15554844pjb.29.1650628992267;
        Fri, 22 Apr 2022 05:03:12 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a20:4832:de00:7c31:9ae8:33d2:1fe7])
        by smtp.gmail.com with ESMTPSA id o12-20020a17090aac0c00b001cd4989ff41sm5588555pjq.8.2022.04.22.05.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 05:03:11 -0700 (PDT)
From:   fankaixi.li@bytedance.com
To:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        Kaixi Fan <fankaixi.li@bytedance.com>
Subject: [External] [PATCH bpf-next v5 0/3] Add source ip in bpf tunnel key
Date:   Fri, 22 Apr 2022 20:02:56 +0800
Message-Id: <20220422120259.10185-1-fankaixi.li@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Kaixi Fan <fankaixi.li@bytedance.com>

Now bpf code could not set tunnel source ip address of ip tunnel. So it
could not support flow based tunnel mode completely. Because flow based
tunnel mode could set tunnel source, destination ip address and tunnel
key simultaneously.

Flow based tunnel is useful for overlay networks. And by configuring tunnel
source ip address, user could make their networks more elastic.
For example, tunnel source ip could be used to select different egress
nic interface for different flows with same tunnel destination ip. Another
example, user could choose one of multiple ip address of the egress nic
interface as the packet's tunnel source ip.

Add tunnel and tunnel source testcases in test_progs. Other types of
tunnel testcases would be moved to test_progs step by step in the
future.

v5:
- fix some code format errors
- use bpf kernel code at namespace at_ns0 to set tunnel metadata

v4:
- fix subject error of first patch

v3:
- move vxlan tunnel testcases to test_progs
- replace bpf_trace_printk with bpf_printk
- rename bpf kernel prog section name to tic

v2:
- merge vxlan tunnel and tunnel source ip testcases in test_tunnel.sh

Kaixi Fan (3):
  bpf: Add source ip in "struct bpf_tunnel_key"
  selftests/bpf: Move vxlan tunnel testcases to test_progs
  selftests/bpf: Replace bpf_trace_printk in tunnel kernel code

 include/uapi/linux/bpf.h                      |   4 +
 net/core/filter.c                             |   9 +
 tools/include/uapi/linux/bpf.h                |   4 +
 .../selftests/bpf/prog_tests/test_tunnel.c    | 395 ++++++++++++++++++
 .../selftests/bpf/progs/test_tunnel_kern.c    | 371 ++++++++++------
 tools/testing/selftests/bpf/test_tunnel.sh    | 124 +-----
 6 files changed, 659 insertions(+), 248 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_tunnel.c

-- 
2.20.1

