Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD2D5047E0
	for <lists+bpf@lfdr.de>; Sun, 17 Apr 2022 15:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234151AbiDQNXY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 17 Apr 2022 09:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiDQNXX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 17 Apr 2022 09:23:23 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA922140C1
        for <bpf@vger.kernel.org>; Sun, 17 Apr 2022 06:20:47 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id t12so10480552pll.7
        for <bpf@vger.kernel.org>; Sun, 17 Apr 2022 06:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WBsrGZzWwWSc+8hrajitHXNgUcr7VP+/HKwWffoUSlw=;
        b=0/kLCuVID1BxP/kScDBRD0qhbyoDVte0OzF+3JZp2wVBeaZONG4Ati0zJhWRfM9hb7
         czhAguHwNQV1ARZVmMjJSQcyHMSDUt+BeKW9VktO0IxXJTOc3TN4GzSRWzmGt1HJ7kfe
         rCjXWgDNAtneuzqGv8+k9fOoCuwuhVoGa/58yoemqX3gruQ+8o09FHnYD1UHUBfmvs2k
         Wnoy1vTSWQ1aad2Z5J+3Q0hMQjNxjruLXw8NgwPwp5wz9mHmqweBiEPgER7eDjCgwVNC
         V2TqWamCXxG8zCp3Aa5v7dNV87aLQOJucI1MyO3BvsfVzNd9uNLy58Dep3bV4PzEluo3
         pAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WBsrGZzWwWSc+8hrajitHXNgUcr7VP+/HKwWffoUSlw=;
        b=t3rMFYcZJ9rf/vlgDZd3MtXBG9//d/xFa21b7iBAeSkRd5BeKr1DfhSx0e0/4ExAaM
         4dTMKX0VSQoRp7bCn80OPDhRyt5IqoHxnRNiB5bX19O+9uHzpWbghBTHSZUtZFnjirD9
         EYx9UBrwvXw+kEjb6t724HH0PQ5Yu9VgBkL6oHL8qcuL5w1SKJ2D0sfnVgC3IQ5bETIo
         4nOahlUmot0+2UkqkOuE2X+7tN4taS1uppLk8Dfbqqn5wMksm9OCjS23ZHM2EKrE4Pzi
         1q7nJWlOfBLCg9f9T6HLOYrDK2/7G1AF1V+miLbllckP3gv7IGIxuZK71DmRCyYe6xSV
         Aq0Q==
X-Gm-Message-State: AOAM530nFY/XU1Ny+opqLZNMKyTdI78ASzZAPMEqu7wSHVMbRUo/A6jv
        J31GE/f5BzcAarZUgIfIxgtrAA==
X-Google-Smtp-Source: ABdhPJx4Zct6eqX/tYzsbyWpfWQPzKj2nI8XQNwsn6Vlnv/fldxuWcA2lCo3a+iCRT1USbMKXGfyhw==
X-Received: by 2002:a17:902:8f94:b0:14f:d9b3:52c2 with SMTP id z20-20020a1709028f9400b0014fd9b352c2mr6784941plo.103.1650201647241;
        Sun, 17 Apr 2022 06:20:47 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a20:4832:de00:bc27:698e:1fca:c5bb])
        by smtp.gmail.com with ESMTPSA id l10-20020a17090aec0a00b001d27f7fb42csm1936907pjy.13.2022.04.17.06.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 06:20:46 -0700 (PDT)
From:   fankaixi.li@bytedance.com
To:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        Kaixi Fan <fankaixi.li@bytedance.com>
Subject: [External] [PATCH bpf-next v3 0/4] Add source ip in bpf tunnel key
Date:   Sun, 17 Apr 2022 21:20:27 +0800
Message-Id: <20220417132030.17067-1-fankaixi.li@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Add tunnel and tunnel source testcases in test_progs.

v3:
- move vxlan tunnel testcases to test_progs
- replace bpf_trace_printk with bpf_printk
- rename bpf kernel prog section name to tic

v2:
- merge vxlan tunnel and tunnel source ip testcases in test_tunnel.sh

Kaixi Fan (3):
  bpf: Add source ip in "struct bpf_tunnel_key"
  selftests/bpf: move vxlan tunnel testcases to test_progs
  selftests/bpf: replace bpf_trace_printk in tunnel kernel code

 include/uapi/linux/bpf.h                      |   4 +
 net/core/filter.c                             |   9 +
 tools/include/uapi/linux/bpf.h                |   4 +
 .../selftests/bpf/prog_tests/test_tunnel.c    | 461 ++++++++++++++++++
 .../selftests/bpf/progs/test_tunnel_kern.c    | 282 ++++++-----
 tools/testing/selftests/bpf/test_tunnel.sh    | 124 +----
 6 files changed, 646 insertions(+), 238 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_tunnel.c

-- 
2.20.1

