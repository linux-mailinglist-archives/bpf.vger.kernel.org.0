Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442474E4342
	for <lists+bpf@lfdr.de>; Tue, 22 Mar 2022 16:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236880AbiCVPog (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Mar 2022 11:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233987AbiCVPof (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Mar 2022 11:44:35 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9568C7CB
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 08:43:07 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id q1-20020a17090a4f8100b001c6575ae105so2220905pjh.0
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 08:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ct6Vji+d4zAMDLEdoDbgrPPldMdn2cj5qr/104RDCQ8=;
        b=8Q7EMAmzIRLw+wDVPYzv1p9dC0AOrwKLkl4Ts4iLrODttcSHJKJIHZuXwB7PKQpDm8
         pByZHRPaeX3nFU13CXXGqSr88r7O6gVoaa8KTEsZCxYIi03iDBvEcpBVtqBNGW6vWKZ7
         9tZctFveRBOXkIgKXAjfyMG/tIKFA3y7y/+C5Ahok7O7T+9dGQ0/LPLevnvVt3IKpcTu
         e6QZjhtWhmjUH550DAZoKlf5ons11QHCbIQPnMpSWAyvkm5ucEz92XBkNfzSBytKNlU2
         3EPPiuwfwPUQPuMVe7FLEjKpyckmf7c/t6DZLxsXn744ncxXb1F20DotidwIKu2o+d/P
         wO7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ct6Vji+d4zAMDLEdoDbgrPPldMdn2cj5qr/104RDCQ8=;
        b=HaGomoGw364PJvrzsM4Pd2Jes3lkjZVryAlvn1fxV9m9tvwPnPQ7n8SOYQylj+zLMS
         3bCtKgKnXaz4Kjl5uXiswSdOrJ1WzVSJRfXuCu5IWPsBDGrFYsLpvPvVb99Y2UFhdMcH
         QkMx+MkMvuZ3gXwQMasxGZdkk3uTmfTcuOaBQvg7smN2L449G5/X0NuTla2ZxLUWc5os
         kc/vXzVGD0dzGT15VCHwpHkHmf8bZMeinFqmzDHlPEPasTCChaWiZONaLOkfLwTVYtfo
         vJQuqkxMKj+Ie5zwZZh2/3P2Rn6tbVjfr/I/U/y0jQVswBSVGx9Z4HXX6a2DoRW1wDw6
         PdaQ==
X-Gm-Message-State: AOAM5316Ck2KTHA/+VwRqpooYow3KrS9DdQeq5+szyYuzK/YTXURDBNe
        xbFYPIVvge0Lhg4MYavcKy2+dg==
X-Google-Smtp-Source: ABdhPJzHQBWMSVW8cPMgmn5TARsqylffVIUW45ICxlw3bdMk0obVkwZ+1JN+OXkadbHn+BhKUUi/gg==
X-Received: by 2002:a17:90b:17c6:b0:1c7:46bf:ba16 with SMTP id me6-20020a17090b17c600b001c746bfba16mr5723275pjb.1.1647963786393;
        Tue, 22 Mar 2022 08:43:06 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a20:483a:72c0:3435:f390:36c7:be7a])
        by smtp.gmail.com with ESMTPSA id d14-20020a056a0024ce00b004f7281cda21sm24719158pfv.167.2022.03.22.08.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 08:43:06 -0700 (PDT)
From:   fankaixi.li@bytedance.com
To:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, bpf@vger.kernel.org
Cc:     shuah@kernel.org, ast@kernel.org, andrii@kernel.org,
        "kaixi.fan" <fankaixi.li@bytedance.com>
Subject: [External] [PATCH bpf-next v2 0/3] bpf: Add support to set and get
Date:   Tue, 22 Mar 2022 23:42:28 +0800
Message-Id: <20220322154231.55044-1-fankaixi.li@bytedance.com>
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

From: "kaixi.fan" <fankaixi.li@bytedance.com>

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

v1 -> v2:
v1: https://lore.kernel.org/bpf/20220319130538.55741-1-fankaixi.li@bytedance.com

- Add secondary ip and set tunnel remote ip in "add_vxlan_tunnel" and
"add_ip6vxlan_tunnel"

kaixi.fan (3):
  bpf: Add source ip in "struct bpf_tunnel_key"
  selftests/bpf: add ipv4 vxlan tunnel source testcase
  selftests/bpf: add ipv6 vxlan tunnel source testcase

 include/uapi/linux/bpf.h                      |   4 +
 net/core/filter.c                             |   9 ++
 tools/include/uapi/linux/bpf.h                |   4 +
 .../selftests/bpf/progs/test_tunnel_kern.c    | 115 ++++++++++++++++++
 tools/testing/selftests/bpf/test_tunnel.sh    |  80 +++++++++++-
 5 files changed, 206 insertions(+), 6 deletions(-)

-- 
2.24.3 (Apple Git-128)

