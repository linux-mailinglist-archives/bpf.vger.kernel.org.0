Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2859259B564
	for <lists+bpf@lfdr.de>; Sun, 21 Aug 2022 18:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiHUQR5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 21 Aug 2022 12:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiHUQR4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 21 Aug 2022 12:17:56 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089B214088
        for <bpf@vger.kernel.org>; Sun, 21 Aug 2022 09:17:56 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u14so10520827wrq.9
        for <bpf@vger.kernel.org>; Sun, 21 Aug 2022 09:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metanetworks.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=L0IglDnMgKJvmUou5SZGIYmEu1kQuYy9stAD0Dz+rYY=;
        b=UUxra0tkUeD4FjGOfMN+fJlI3pC1ny9yZnYuTdOGeXA8REc/P4VNEv1iRvdYshq4wn
         NI4iL189UOFKP8pIbh3YUrRFwlwWfnqRTl0704jn6NgRcYjHa29A6fhNMYxu2mJcC2Z3
         th8SQoZjqylhkKCk6srSQXHdHO84ZFgH3wSAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=L0IglDnMgKJvmUou5SZGIYmEu1kQuYy9stAD0Dz+rYY=;
        b=MuVCWMXOWYwi/cltrhp4vUw7pqaYEGkIOA0Ks0aYZVA9x6L/+U7JNOq0eaSnDcwsUU
         kPKjYsjdPh+J+mXBK6oazON/XADMqVqijuFdSDRfDBABpo8TWMhvjKZ6MvoXXsQ690Xm
         qE2aioOfVbVCPfKZPBootqDu+kK3+3mFHIVW1YfH5IHCt32d6zCR/GcSOFObkJJe3JMf
         xp8qTZ7bb+nCxhY7jW2DGJHnegTTM/et49o4lbKDLAc44ikH2PAucmh/NbnhMy2n8Yvd
         T/sc0Oq6S4+8Ew8JMB/SbjPxIME3m740I+W33sVrgKY0rLDoNVh/udSGGT1O5wBVl3Wf
         WYLA==
X-Gm-Message-State: ACgBeo3yZeavcU+bqONbdW0u2elwlKj9WEkPq5dOKDxt/EW9Zfedy2i+
        uvUinJzeSojBXFWzn91dRML8OVI0ANP7XJRixxoC1MZLmzfiIUJ9JWqiyH2RkyvKXoq8svLfCE3
        hivtITXR3yY5zPZ6Pe0BSCUn63dj1tUINnVd3mpdcDK1Dp8vnJ8A7oH3TjC3AfSdhXWIlw1sL
X-Google-Smtp-Source: AA6agR5iBZBhKrKCPQoUznU8GN2WNA42Uhdybb57tBPnxMWk/cRn8J+qwBNai+iopnqqSTGCJq5qXA==
X-Received: by 2002:adf:f643:0:b0:225:2cb3:4b05 with SMTP id x3-20020adff643000000b002252cb34b05mr9247223wrp.12.1661098674220;
        Sun, 21 Aug 2022 09:17:54 -0700 (PDT)
Received: from blondie.home ([94.230.83.151])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c154e00b003a32251c3f9sm17659002wmg.5.2022.08.21.09.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 09:17:53 -0700 (PDT)
From:   Shmulik Ladkani <shmulik@metanetworks.com>
X-Google-Original-From: Shmulik Ladkani <shmulik.ladkani@gmail.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Paul Chaignon <paul@isovalent.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: [PATCH bpf-next 0/3] bpf: Support setting variable-length tunnel options
Date:   Sun, 21 Aug 2022 19:17:37 +0300
Message-Id: <20220821161740.166682-1-shmulik.ladkani@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce 'skb_set_var_tunnel_opt' to allow setting tunnel options of
dynamic length.

Shmulik Ladkani (3):
  bpf: Support setting variable-length tunnel options
  selftests/bpf: Simplify test_tunnel setup for allowing non-local
    tunnel traffic
  selftests/bpf: Add geneve with bpf_skb_set_var_tunnel_opt test-case to
    test_progs

 include/uapi/linux/bpf.h                      |  12 ++
 net/core/filter.c                             |  34 +++-
 tools/include/uapi/linux/bpf.h                |  12 ++
 .../selftests/bpf/prog_tests/test_tunnel.c    | 125 ++++++++++--
 .../selftests/bpf/progs/test_tunnel_kern.c    | 182 ++++++++++++------
 5 files changed, 284 insertions(+), 81 deletions(-)

-- 
2.37.2

