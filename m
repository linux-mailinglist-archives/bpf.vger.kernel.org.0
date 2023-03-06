Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5CAD6ABE0A
	for <lists+bpf@lfdr.de>; Mon,  6 Mar 2023 12:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjCFLVr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Mar 2023 06:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjCFLVq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Mar 2023 06:21:46 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A45B23DB7
        for <bpf@vger.kernel.org>; Mon,  6 Mar 2023 03:21:44 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id e13so8380228wro.10
        for <bpf@vger.kernel.org>; Mon, 06 Mar 2023 03:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1678101703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QkrfogGMhz6EbK34e3SWusY5TQtZdeDKYYTyzk+6w7E=;
        b=gDPVbkkWcsK2PskU149pAXAypiy+Q+sGCJEDh1b/ZKqeB/71r88pxBNwHMe0/Sdb8Q
         AVvhtqGXGgd2YA3Os7OycSdgG6y/FIfI23uxokCpf68vkjFmwR2aocUPQz8zpJ9Jc+Gw
         iT21uuOW/HXMpsxFbIKFDeTRBWiXWAT1UmEKjaIJ1HlBEOy4k54QsM9LAoHirI73W+6L
         3uNue28Ym9phxDUfLNZlo2Sy/8wY6eg+d37C+YBUI4Zs784Oi+DK1ykvIIFn/dbbqUKS
         sWkRK9cL9T5k4KCpzuOcpG7Rykoxdb/mZAT551h5sqtyR2dYfaiENLgAQlhjA593TkRV
         VAtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678101703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QkrfogGMhz6EbK34e3SWusY5TQtZdeDKYYTyzk+6w7E=;
        b=n+uo643aPrCsRs/7S9fUYHKHD4zV0EnGMxpFVhmzlEoSaoUjNkkEJZgdcimc5n+wrg
         lzH37m67odbw78Nh8fKd3PO8dKvmL6Z4sIqY09NP8GDeWxTYq1cz3rrLUov+oDq2RbFH
         5vpyFgFM6er2jl1rNC9mOFr03m0L+o3FAFXuR1/6y4eqfWeYDGnf9NYnXi99UQnCftDb
         IGSE43vQIg+7mO8vzhu1+a0BE5qmh8xmqmcqPTUzBrcR9g7jeOzHmNumVyQNdjBSsHDW
         4baLj3g189t3TRIcTwYY8fZlsQXBq9gLv2l+PijGzaRBD6b5uRoqqdkGlMHiFdBNS23j
         JeGA==
X-Gm-Message-State: AO0yUKVlf+mj56UY6f/c/r7GZxhNdHBj6tSEPXIHanLYg3znoZ0XYPZr
        qAS1Nc7p/qoe/fghxxcYPQ6d97pTRyCMWsbIWUELlA==
X-Google-Smtp-Source: AK7set+xJFHie9ovWZVB1jzrNpSaVQj8740nPJcaQUtCGlG4OQ6xX7em4escAFcx0icxgmdo+WJ3Qg==
X-Received: by 2002:a05:6000:1809:b0:2c7:f82:827a with SMTP id m9-20020a056000180900b002c70f82827amr6028142wrh.19.1678101703070;
        Mon, 06 Mar 2023 03:21:43 -0800 (PST)
Received: from tpx1.lan (f.c.7.0.0.0.0.0.0.0.0.0.0.0.0.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff::7cf])
        by smtp.gmail.com with ESMTPSA id j4-20020adfff84000000b002cda9aa1dc1sm9604854wrr.111.2023.03.06.03.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 03:21:42 -0800 (PST)
From:   Lorenz Bauer <lorenz.bauer@isovalent.com>
X-Google-Original-From: Lorenz Bauer <lmb@isovalent.com>
Cc:     Lorenz Bauer <lmb@isovalent.com>, bpf@vger.kernel.org
Subject: [PATCH bpf v2 0/2] fix resolving VAR after DATASEC
Date:   Mon,  6 Mar 2023 11:21:36 +0000
Message-Id: <20230306112138.155352-1-lmb@isovalent.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

See the first patch for a detailed explanation.

v2:
- Move RESOLVE_TBD assignment out of the loop (Martin)

Lorenz Bauer (2):
  btf: fix resolving BTF_KIND_VAR after ARRAY, STRUCT, UNION, PTR
  selftests/bpf: check that modifier resolves after pointer

 kernel/bpf/btf.c                             |  1 +
 tools/testing/selftests/bpf/prog_tests/btf.c | 28 ++++++++++++++++++++
 2 files changed, 29 insertions(+)

-- 
2.39.2

