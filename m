Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985D96E4221
	for <lists+bpf@lfdr.de>; Mon, 17 Apr 2023 10:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjDQII3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 04:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjDQII1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 04:08:27 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56BD46B4
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 01:08:01 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id kh6so23185760plb.0
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 01:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681718881; x=1684310881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Swqe8hdnyr90lKGZ34p9/SCrV2uM7jygoSbLirhNYaU=;
        b=RzueqtYWKHquKbh1r91xnBOR9MFUOwTtEL7JuxAvbQGOmalRQOVk1il2sClha6cktk
         s5S7cML/Wwg1GRJxaXsrEaCZN/OiX9UnhHG1VTPCe56uCsDOVj88DLWTvKtoFEdGowdK
         PAXU293prILUVEDi6LZXzQpTFWYDfQT4XC0FOjfOgQ+EERaWxfzeTwj8DKGN6mo6uctv
         LgzqgPSfu/eoCaiCcEWkSMMeKHCj8EBpaUGmnfZ9BYuIjvu8awDUj6BzfeunPMQ66ufO
         OdR/gnDrVLXe+KP+ObUuYs5tcysmfvWdJTDWsGF8FoZh/cRnk3gtvxAd+d+pUEHvi6td
         2haQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681718881; x=1684310881;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Swqe8hdnyr90lKGZ34p9/SCrV2uM7jygoSbLirhNYaU=;
        b=L2cVLzatMQ+mgaw5eMS+WpvD3ZmdLdoJlUx+i/2lfyIV6dcObX6GUiIIS7nPqcZW2R
         nLMakSX+KuXSdgnd2oL90bZamkcH+KcaW/AwVXYtWBFVQ1k2itljGd372WIH+mFVHBpy
         dZ6/yVCiqr2PcByx+d7Y5YzIlneG7+aNlz5izEvn8Nli0TXJtM8Jfo/y99BIJxdhINqd
         R+N+oKnap211mWRK8RO5TgKpDMPnpOQGCpxTlO5nTg9H8TSy0OtSfoXTPpR41uR5oIVG
         NBgGQGNmCQ0WvhDMoqeCBlXUvrWP6s3uhtNZhCWwDBWPYhTzdb44EQlBEV5hgcwC0GOY
         l9yg==
X-Gm-Message-State: AAQBX9cceeyXFfw684x5FCtWTYY4P7Xl3JoriPbYLN2jF9nXTOmIpP48
        4H/voLWRZ/JsOZmS+0fM9ITTUg==
X-Google-Smtp-Source: AKy350YRelaL8B0w4O3NnCLX/PVG+4BiJ3Ah+M51OrPw3Y8gE6kkvDrzEvhk+MJ95rnyIbRwnbV+xA==
X-Received: by 2002:a17:902:db06:b0:1a1:bff4:49e9 with SMTP id m6-20020a170902db0600b001a1bff449e9mr14009898plx.23.1681718881342;
        Mon, 17 Apr 2023 01:08:01 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id jc3-20020a17090325c300b0019a97a4324dsm7114135plb.5.2023.04.17.01.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 01:08:00 -0700 (PDT)
From:   Feng zhou <zhoufeng.zf@bytedance.com>
To:     martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mykolal@fb.com, shuah@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        yangzhenze@bytedance.com, wangdongdong.6@bytedance.com,
        zhouchengming@bytedance.com, zhoufeng.zf@bytedance.com
Subject: [PATCH 0/2] Access variable length array relaxed for integer type
Date:   Mon, 17 Apr 2023 16:07:47 +0800
Message-Id: <20230417080749.39074-1-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Feng Zhou <zhoufeng.zf@bytedance.com>

Add support for integer type of accessing variable length array.
Add a selftest to check it.

Feng Zhou (2):
  bpf: support access variable length array of integer type
  selftests/bpf: Add test to access integer type of variable array

 kernel/bpf/btf.c                              |  8 +++++---
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   | 20 +++++++++++++++++++
 .../selftests/bpf/prog_tests/tracing_struct.c |  2 ++
 .../selftests/bpf/progs/tracing_struct.c      | 13 ++++++++++++
 4 files changed, 40 insertions(+), 3 deletions(-)

-- 
2.20.1

