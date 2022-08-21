Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9760359B5DD
	for <lists+bpf@lfdr.de>; Sun, 21 Aug 2022 20:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbiHUSOB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 21 Aug 2022 14:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbiHUSOA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 21 Aug 2022 14:14:00 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596D2201A2
        for <bpf@vger.kernel.org>; Sun, 21 Aug 2022 11:13:59 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id k17so4557914wmr.2
        for <bpf@vger.kernel.org>; Sun, 21 Aug 2022 11:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metanetworks.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=AOVYXu4Lnky15b8qqUYFWd5TizYGXcxg045pUoZMw/w=;
        b=XvkgLs80ZEBPOdQ3sJPcHRLlhD7DseVCzolBS4QorRgWkogEPbde0F6ViSPKxzMqNq
         miOexF3w+s5loTZTY6cQNCzkkHy/ZF4Qr4wqGPs9PnNz9S46AZT2Md5VMp9mbPUJOWQ8
         AG6nTl/0IVHUTdbQwKepXh1DyQsygJmL9dAoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=AOVYXu4Lnky15b8qqUYFWd5TizYGXcxg045pUoZMw/w=;
        b=lF+Wr5dgwBJtSGf7bK8sy9YSDrX+zmSH5YLcr+y64cAYlbWicYHCofe2RFqhTjqcUf
         cRfnagmcKQKlAx9WXAuf7a8UkmUBAeBDaKaGSmyaVnzcIoybpLaGcvpCGmF62S8sfPuo
         WGX3eAV0p/y78gARAlV3AbDB6xmbHSATa2R3Y1gsBqUU3KQ8ImocV8x32GEyd/9uO5rV
         mR6Lz+xrEQrRLzpxi7+qDRQ2sj483J5hA1V97AD9H7Zy84lc3he1i//FgtJ9xIp+YVFV
         36xYbKpzoKCCCtyroOpl+j88fa96tLWHHGKhFNm5qakWNVWxOTYeeBdKKgV2QyPfenhh
         s5Sw==
X-Gm-Message-State: ACgBeo03wpmaFvVPW1rdpVd8S7SybEN3NnEpRaz/GKRwCf4EFvr7RVAo
        MQU1nXaMLj9rDOfSKrpBn9dF/oD/S+Daw2I94m6qZ5KCob2qcAlPy8zlHeBEjM+KST1RDzWmxOi
        EVb9yguWEC2g1K/ROtiE644J8Ajr8eoQkwURBvFxDziG5ROvAydqvtH3dg5Zm2bPXTl7uLZos
X-Google-Smtp-Source: AA6agR4qa7Q8MSW2tc5hC8OmKMsGk3cavMUYBalDidWVPhIiJ/OeCT+LD9cE36JRDbst1GuFqPTsuA==
X-Received: by 2002:a7b:cc85:0:b0:3a5:50b2:f9be with SMTP id p5-20020a7bcc85000000b003a550b2f9bemr9955022wma.18.1661105637539;
        Sun, 21 Aug 2022 11:13:57 -0700 (PDT)
Received: from blondie.home ([94.230.83.151])
        by smtp.gmail.com with ESMTPSA id n17-20020a5d4851000000b0021eff2ecb31sm9509303wrs.95.2022.08.21.11.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 11:13:57 -0700 (PDT)
From:   Shmulik Ladkani <shmulik@metanetworks.com>
X-Google-Original-From: Shmulik Ladkani <shmulik.ladkani@gmail.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Paul Chaignon <paul@isovalent.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: [PATCH v2 bpf-next 0/3] bpf: Support setting variable-length tunnel options
Date:   Sun, 21 Aug 2022 21:13:42 +0300
Message-Id: <20220821181345.337014-1-shmulik.ladkani@gmail.com>
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

v2:
- Place test_tunnel's local route in a custom table, to ensure the IP
  isn't considered assigned to a device.

Shmulik Ladkani (3):
  bpf: Support setting variable-length tunnel options
  selftests/bpf: Simplify test_tunnel setup for allowing non-local
    tunnel traffic
  selftests/bpf: Add geneve with bpf_skb_set_var_tunnel_opt test-case to
    test_progs

 include/uapi/linux/bpf.h                      |  12 ++
 net/core/filter.c                             |  34 +++-
 tools/include/uapi/linux/bpf.h                |  12 ++
 .../selftests/bpf/prog_tests/test_tunnel.c    | 131 +++++++++++--
 .../selftests/bpf/progs/test_tunnel_kern.c    | 182 ++++++++++++------
 5 files changed, 290 insertions(+), 81 deletions(-)

-- 
2.37.2

