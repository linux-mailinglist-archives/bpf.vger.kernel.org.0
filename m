Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48BE6CC089
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 15:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbjC1NWG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 09:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjC1NWF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 09:22:05 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D837285
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 06:22:03 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id ew6so49596975edb.7
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 06:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680009721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M3Gr5Je7guIiujdLrMxTqrEOz8T6Uy5IsES9KC1M1QM=;
        b=q1sHfFRKjcGVZMWMduc1bexx7ZdQ2irxm6DO9OHqhsoPe0mmrMWiPkham5lG1/IgCF
         MeogglgreGdR5B+ctQbSDGuVmqjd8sHUU3H3hbrcwwkzjoZlxd36R/8v4UrbUKNaKhri
         BadNyGhWYVYcrTb5zeV/NuntHJQTbnv2p/D55GTMqndS5ms/K2/h0f+FCcJbff4B2yba
         VT3LWoK11ChlkIb81GA10xomh/l1gMlrQFSSeKQnPeX3MjDFVvqKqfRR/22t5BJn4BFK
         7Uer85NugORgAxowXMq5oElSUbGK0KAjMxf4rG/o91FQLXZtlWMjc61nOJ/8R6TRC3uG
         kj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680009721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M3Gr5Je7guIiujdLrMxTqrEOz8T6Uy5IsES9KC1M1QM=;
        b=ADD6DelrlO0SHmSPZAgY6TeiMnhqb5A12dKcOq0xJ05kj0+FiGtoFVEnVLOzlW2zy0
         at2VLU7BmwUP5L2Cjbd9xvcokW7HqzUluiSBJS11KtZXnawCL+pMOaVBcHNgNbgAypdv
         DDCtG/NlLvyUjUXlqph3FG/YTfKZ6Xey52qnprtbmaBzwbw+WKDv0BGlqmlXQGuVClDs
         IE7JVyEYK1I2MQ7XxIM3Y6wDAIgy2GwfPxdYRezOuLVLNI1uDSSV0vwWwa4Y/P/sgNBj
         Y2/R6U9NXVrv8MsnE0wVgxpjA2mtJCBfNTNc8ICPTo7mqFy+UiOU98GNTqDjYx9hxiy3
         ixoQ==
X-Gm-Message-State: AAQBX9fCnpIIUzIGg/ZCr5Y3RXEhesKCINWwYIw47ElKbW1TqauOUZVa
        KOrvzJvgePVGqCY7aLCt/70WZU4TBvs2fWw3xe5+Vg==
X-Google-Smtp-Source: AKy350alTuksoi33ATq8sJXMQyf+ozli/6xoOPKDV2GeINZxvQHBxOroi5lQ8tNu8t5K/7IH9jQuhA==
X-Received: by 2002:a17:906:3e0f:b0:92b:69cd:34c7 with SMTP id k15-20020a1709063e0f00b0092b69cd34c7mr15846583eji.40.1680009721745;
        Tue, 28 Mar 2023 06:22:01 -0700 (PDT)
Received: from localhost.localdomain ([45.35.56.2])
        by smtp.gmail.com with ESMTPSA id h19-20020a1709070b1300b008ec4333fd65sm15240170ejl.188.2023.03.28.06.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 06:22:01 -0700 (PDT)
From:   Yixin Shen <bobankhshen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, song@kernel.org, yhs@fb.com,
        bobankhshen@gmail.com
Subject: [PATCH 0/2] Allow BPF TCP CCs to write app_limited
Date:   Tue, 28 Mar 2023 13:20:33 +0000
Message-Id: <20230328132035.50839-1-bobankhshen@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series allow BPF TCP CCs to write app_limited of struct
tcp_sock. A built-in CC or one from a kernel module is already 
able to write to app_limited of struct tcp_sock. Until now,
a BPF CC doesn't have write access to this member of struct
tcp_sock.

Yixin Shen (2):
  bpf: allow a TCP CC to write app_limited
  selftests/bpf: test a BPF CC writing app_limited

 net/ipv4/bpf_tcp_ca.c                         |  3 +
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 19 +++++
 .../bpf/progs/tcp_ca_write_app_limited.c      | 71 +++++++++++++++++++
 3 files changed, 93 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/tcp_ca_write_app_limited.c

-- 
2.25.1

