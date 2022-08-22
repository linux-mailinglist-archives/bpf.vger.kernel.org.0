Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C488859B8B4
	for <lists+bpf@lfdr.de>; Mon, 22 Aug 2022 07:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiHVFWH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Aug 2022 01:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbiHVFWG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Aug 2022 01:22:06 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39338255A9
        for <bpf@vger.kernel.org>; Sun, 21 Aug 2022 22:22:04 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id n4so11747553wrp.10
        for <bpf@vger.kernel.org>; Sun, 21 Aug 2022 22:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metanetworks.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=SSXIFxv60cCLKCFAWptrYZQJpCsYDkFLE7A0xvIvW98=;
        b=TP2Orud/6Pc3/B++Ga67KRMBy8EKRiQiMWnP8EHHeMIjvTlHVjl7bVBHf2ntfc15kJ
         FoWmxq4X4dmdJZHXMKUgYUBUGYVRR6lZkZp6C27iPUaelx9+WErvlm+J/pfRcXlzY2bu
         Yo+1ICQ4aNdGdcJtWbTwve5+QJBOf/Rv0qM2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=SSXIFxv60cCLKCFAWptrYZQJpCsYDkFLE7A0xvIvW98=;
        b=c3AChA4Og6zeHpfR30mbB1JF+iEaSBPQARuK/pulYqRgKZRhGYvJjlX262/VwIgqyS
         s2yErpv7N/9CgLp46NVyX8WNEGC/5ym4vKGGPczQuDPI/GB6FxZELzFmI2t3rmDLclRe
         dR+23HxuVh5hFzTvnesq+vIzKiIKmYpvZS3llRE/USnUZ5XERaVhsiPZA+3cbfrrV5w/
         oXdiDxQxyR+p91d4q926sW59dufwe9OqUFXybyUDgO5o6kRUYcRl5AsVx7V8pJx7qOIc
         Z8eFfveXLmBpA9i2k2dsMBv/j9TnFqRde1QPEEElSGZL8sDBUDI/UyflaZQn/Y/PEcof
         3zGw==
X-Gm-Message-State: ACgBeo0HuC6EvmNgYQmway155st+TSEmQU1DuJrHZ6gf/SnvfTVRo7IL
        vb0upLJkGvtT2NKYbr3Fnhdj5SXa78jBTddnsyGplo2HbF6lOXzgBUwBqai6epv+JmMr4pwYWh1
        0HDkDoUId5NVVoNMX0ev/vycP81ZWeWnqkZinTGZMO+iBg51uRDtMMA0eshpUGyxeovSaOZgA
X-Google-Smtp-Source: AA6agR6wu3IaGVJo45q1LIj3lkOzVGkgc/YGk0XwcI6n3GvhQzBCSgFbytbOXCmDQ6NkBcPumwKzgQ==
X-Received: by 2002:a5d:59ad:0:b0:225:5b64:8c6a with SMTP id p13-20020a5d59ad000000b002255b648c6amr1043677wrr.558.1661145722324;
        Sun, 21 Aug 2022 22:22:02 -0700 (PDT)
Received: from blondie.home ([94.230.83.151])
        by smtp.gmail.com with ESMTPSA id z24-20020a1cf418000000b003a5dadcf1a8sm13163173wma.19.2022.08.21.22.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 22:22:01 -0700 (PDT)
From:   Shmulik Ladkani <shmulik@metanetworks.com>
X-Google-Original-From: Shmulik Ladkani <shmulik.ladkani@gmail.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Paul Chaignon <paul@isovalent.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: [PATCH v3 bpf-next 0/3] bpf: Support setting variable-length tunnel options
Date:   Mon, 22 Aug 2022 08:21:49 +0300
Message-Id: <20220822052152.378622-1-shmulik.ladkani@gmail.com>
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
v3:
- Avoid 'inline' for the __bpf_skb_set_tunopt helper function

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

