Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D519515B15
	for <lists+bpf@lfdr.de>; Sat, 30 Apr 2022 09:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382334AbiD3Hwp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 30 Apr 2022 03:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382315AbiD3Hwo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 30 Apr 2022 03:52:44 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C494EBF57
        for <bpf@vger.kernel.org>; Sat, 30 Apr 2022 00:49:23 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id t13so8670156pfg.2
        for <bpf@vger.kernel.org>; Sat, 30 Apr 2022 00:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rCsVDSw0StqNk1f/Of5EJbaYwSeXntgn+bw+aZTtiUo=;
        b=UEJR5tes9RCpORJ+LGJlffqwLwpMs5Sso3TyahbJQa3LXdn9tpcxldqHsdqYWr6nbL
         IEnQA94x/I8/Qi77Je0ocf3VZifFcPMx4QT433U4V3SWKExdpj8K5VC3Gm+MygvgFfaf
         5iNu3Kiwu2b26Vt3Jj01TIb6Mv0sGTBDYRqgaDxuv6wctpjz9HIIg0B6MB2VKnTV2+bQ
         tT6+fQP4+42E0hZhHKTv+1Ih5py3r6zquFiV7Xak6RbkyQyaM9yioLYKSSi+TdmoSdtY
         7w+YDL+OBHSW0j2Y5Qw1mLHa/P+XrE6GfwYVoCIDeyCjoriiZMKy9s6scmju/pEiA/mA
         LAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rCsVDSw0StqNk1f/Of5EJbaYwSeXntgn+bw+aZTtiUo=;
        b=xTJIoC73yZcdmXVCLcpFjzomWePTsCTTm3TFsLQ+hIWLrAF7p1H6N6z/rXgYaTQ+vS
         TiYP1Myq2x+Qg4SSi7ApomKWSTI721yT49z4Pe2VDyTBAGrlpOZGIXQHI59swl5IBVpi
         klpxeT6SDZn94Gh6i2HvY6x+xQrGF7psVG1DQ+ZaxdyY0hGn4idZFiKvAIFpqF1a9WOT
         d62kTVTeSzesPMyTgTzvoCahawvbEBuSOLsFyriWv2TG5drOyELI7tzz2LoUCz3IQL4O
         QvJ0/dT3YbPn2xR7HbXa2o/jLomWlTtzMAOoxI3RjA6fzd8cWVcVvL6aZmlHpRp+K48W
         xDpw==
X-Gm-Message-State: AOAM5332Bz11vDwjmm2+SovJxWMQlMfrrfdN5MQ2l3I+WX+KbbzLGWxy
        i+ok2/5Eup9fqLHtMcVsIZjl8555A5+riQ==
X-Google-Smtp-Source: ABdhPJyyznDCwZZKXAyfYcbhOruMGpzxnRfrWMzdM2+0CKZuPxT58wBovRpURGcfCz7WcQk8k8/MRg==
X-Received: by 2002:a63:d04a:0:b0:3c1:65f2:5d09 with SMTP id s10-20020a63d04a000000b003c165f25d09mr2325571pgi.201.1651304963255;
        Sat, 30 Apr 2022 00:49:23 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a20:483c:22c0:2c47:6a7d:5be8:bdfa])
        by smtp.gmail.com with ESMTPSA id y15-20020a1709027c8f00b0015e8d4eb225sm818103pll.111.2022.04.30.00.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 00:49:22 -0700 (PDT)
From:   fankaixi.li@bytedance.com
To:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        Kaixi Fan <fankaixi.li@bytedance.com>
Subject: [External] [PATCH bpf-next v6 0/3] Add source ip in bpf tunnel key
Date:   Sat, 30 Apr 2022 15:48:41 +0800
Message-Id: <20220430074844.69214-1-fankaixi.li@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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

v6:
- use libbpf api to attach tc progs and remove some shell commands to reduce
  test runtime based on Alexei Starovoitov's suggestion

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
 .../selftests/bpf/prog_tests/test_tunnel.c    | 423 ++++++++++++++++++
 .../selftests/bpf/progs/test_tunnel_kern.c    | 371 +++++++++------
 tools/testing/selftests/bpf/test_tunnel.sh    | 124 +----
 6 files changed, 687 insertions(+), 248 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_tunnel.c

-- 
2.20.1

