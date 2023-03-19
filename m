Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9596C0494
	for <lists+bpf@lfdr.de>; Sun, 19 Mar 2023 20:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjCST6W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 19 Mar 2023 15:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjCST6W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 19 Mar 2023 15:58:22 -0400
Received: from mail-wm1-x361.google.com (mail-wm1-x361.google.com [IPv6:2a00:1450:4864:20::361])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D8F17162
        for <bpf@vger.kernel.org>; Sun, 19 Mar 2023 12:58:20 -0700 (PDT)
Received: by mail-wm1-x361.google.com with SMTP id u11-20020a05600c19cb00b003edcc414997so1427268wmq.3
        for <bpf@vger.kernel.org>; Sun, 19 Mar 2023 12:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dectris.com; s=google; t=1679255898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dKix+HSfHxFcGdowWw5h9i0BZMXf7CaTad7M4kHLSWU=;
        b=BYFUrrIUCpYI0uprYLo9iXPM96VoFIDXvM1lBKKC6GA/UsHwDImKb1ygsBYZJiSV+J
         pRxD7YOkGqhH5DUDbVL8wgJX/LCZOK8cCoEIYlkS0J1eDWIK1sBjkH8hVcPAt4OVFg2D
         56td5RaOtlZtn/vbs+k8DwvdJ0UxF2DOkqLFU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679255898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dKix+HSfHxFcGdowWw5h9i0BZMXf7CaTad7M4kHLSWU=;
        b=nIy2z+FQBwL/kQpB4WdtaQS+V0i2zFA7PanPvd++IF0o8x8tpQWHtUqIACN0x6Im7k
         Ek3YBnuDjM0rgvUufE70MBwYX7N18irDMnIv4JI8IYrj4/Y1jKChunUGrsL6in3SQtmF
         jqdP23ge1UwvrnyISZCuFwTVEx2q8MBoLK8xqNyff/jf+TkgaTr7sh2oV4m1Rnqp6ZXi
         9NAa8zi5iY74DDjnPOCfDQtIUnEPSJ0PCL3F20t3T9ed+MuL9azeR94Qjveh9hIDWSfX
         x/Sai8Ozb1ndpsUFH5USCWiWCBR9L0J2LQ5z9VE5jsVIXb9tE1sEVzam5oYY/djcxJ4O
         o4Rg==
X-Gm-Message-State: AO0yUKXdR+JaOMyVX6GWBBFRvlaCXoM1eEMjq3f0ABUBUE+OFtetzJEC
        LOk+rO88QNXcz6rBrCkiS8RMcYDkYa13946c4wSXOq3m+X3w
X-Google-Smtp-Source: AK7set96GWzcs13TpnXSUaXNh7RBxq4tt/MhSJkXeySOkPAu4qdYgIe7VLKDQA2MxjQBOYsNnOS/Sp+xgQCh
X-Received: by 2002:a1c:7707:0:b0:3ed:9b20:c7c1 with SMTP id t7-20020a1c7707000000b003ed9b20c7c1mr5806170wmi.20.1679255898346;
        Sun, 19 Mar 2023 12:58:18 -0700 (PDT)
Received: from fedora.dectris.local (dect-ch-bad-pfw.cyberlink.ch. [62.12.151.50])
        by smtp-relay.gmail.com with ESMTPS id m26-20020a7bca5a000000b003b499f88f52sm2728807wml.7.2023.03.19.12.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 12:58:18 -0700 (PDT)
X-Relaying-Domain: dectris.com
From:   Kal Conley <kal.conley@dectris.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Kal Conley <kal.conley@dectris.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH bpf-next 0/3] Support UMEM chunk_size > PAGE_SIZE
Date:   Sun, 19 Mar 2023 20:56:53 +0100
Message-Id: <20230319195656.326701-1-kal.conley@dectris.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patchset adds AF_XDP support for chunk sizes > PAGE_SIZE.

The changes depend on the following commit recently applied to the bpf tree:
cc7df4813b149 ("xsk: Add missing overflow check in xdp_umem_reg")

Thanks to Magnus Karlsson for his initial feedback!

Kal Conley (3):
  xsk: Support UMEM chunk_size > PAGE_SIZE
  selftests: xsk: Use hugepages when umem->frame_size > PAGE_SIZE
  selftests: xsk: Add tests for 8K and 9K frame sizes

 include/net/xdp_sock.h                   |  1 +
 include/net/xdp_sock_drv.h               |  6 ++++
 include/net/xsk_buff_pool.h              |  4 ++-
 net/xdp/xdp_umem.c                       | 46 ++++++++++++++++++------
 net/xdp/xsk.c                            |  3 ++
 net/xdp/xsk_buff_pool.c                  | 16 ++++++---
 tools/testing/selftests/bpf/xskxceiver.c | 26 +++++++++++++-
 tools/testing/selftests/bpf/xskxceiver.h |  2 ++
 8 files changed, 88 insertions(+), 16 deletions(-)

-- 
2.39.2

