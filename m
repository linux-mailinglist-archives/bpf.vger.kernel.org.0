Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8010F5B4CAF
	for <lists+bpf@lfdr.de>; Sun, 11 Sep 2022 10:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiIKIqY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Sep 2022 04:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiIKIqU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Sep 2022 04:46:20 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EAD931DDC
        for <bpf@vger.kernel.org>; Sun, 11 Sep 2022 01:46:19 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id r18so13618089eja.11
        for <bpf@vger.kernel.org>; Sun, 11 Sep 2022 01:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metanetworks.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=dtwQmSt2od+Vhv2Bev3Uvh+v7U3zX32L648E+2IBaMs=;
        b=MMIkr2jXv9SWq72wuRtd4kAvudyCayj6bp/vCtd3Jdv+e7ruqpcHCoVe18fIjJcBbX
         06znQWK3/l1kZWA843NlgcurnvShS9R9PZ54n7/+jDoXvAbUAxVf3Jyy9TPyG66eyyPu
         lN7UZed2ZxLDimks02TQK05u+zMxCoiNHhN34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=dtwQmSt2od+Vhv2Bev3Uvh+v7U3zX32L648E+2IBaMs=;
        b=zwSQNDo72MkAv6IqW7T5n3Lyp7wXjIy8mNf/di0Fuzzd6vFz/Ks5RDv9Y3Mprm3o/B
         WmWvxlBcCj12AJ6SqkCaQwFOy4N551611bgMVjjLV8/WWYWCJ4gFYh3P6OT/OHHbzvuf
         OLTsmBTugK/SGoqcpoG04YSHKeS9FV+ZWHl1PVfIGrEJj7/Mcf4d6xtndzwowzsIkhVe
         v5vD/Fdr2Jcg0PQwtJ/+0NqlzE1Ofah1gnGZdLK6RDd1OPQHXMc8MwpA9eExevjjgAWc
         s904vBgDGHIHxX3VfjBCWSITZBImfS8NMHOjMBUFoYjcWPEOSTih4HGLG9W4Zo9mNiaO
         /DcQ==
X-Gm-Message-State: ACgBeo1px8SR4LqUPIe9oKsrqxNA5ryxUEZ7txPvsbIhkdIfEltUK0Q3
        DF5Hl8UT84Zxf/uyqfx14FqvCf0aehbP2A3XcsMj1U2tPsGWJlNWjcHkqUI09AI5cWdHNLrNLzc
        jm0EVrjA1Hpey4kYu0QV2tesuTdFVAx7Ymz2Bj746gBC8PG4IH7f+uYIpYlM9PcTy2V6YwBuCPg
        M=
X-Google-Smtp-Source: AA6agR5kLriTVQlO63ZRioCfq99antsHyQTGJtJ7xIMqyYcvMMld91cSvLpryXT6QBCqTYrz+QKrGA==
X-Received: by 2002:a17:906:ef90:b0:77c:280b:93a1 with SMTP id ze16-20020a170906ef9000b0077c280b93a1mr2334752ejb.709.1662885977375;
        Sun, 11 Sep 2022 01:46:17 -0700 (PDT)
Received: from localhost.localdomain ([141.226.162.95])
        by smtp.gmail.com with ESMTPSA id q10-20020a170906360a00b007309a570bacsm2713591ejb.176.2022.09.11.01.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 01:46:17 -0700 (PDT)
From:   Shmulik Ladkani <shmulik@metanetworks.com>
X-Google-Original-From: Shmulik Ladkani <shmulik.ladkani@gmail.com>
To:     bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Paul Chaignon <paul@isovalent.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: [PATCH v6 bpf-next 0/4] bpf: Support setting variable-length tunnel options
Date:   Sun, 11 Sep 2022 11:46:05 +0300
Message-Id: <20220911084609.102519-1-shmulik.ladkani@gmail.com>
X-Mailer: git-send-email 2.37.3
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

Introduce 'skb_set_tunnel_opt_dynptr' to allow setting tunnel options of
dynamic length.

v2:
- Place test_tunnel's local route in a custom table, to ensure the IP
  isn't considered assigned to a device.
v3:
- Avoid 'inline' for the __bpf_skb_set_tunopt helper function
v4:
- change API to be based on bpf_dynptr,
  suggested by John Fastabend <john.fastabend@gmail.com>
v5:
- fix bpf_dynptr_get_data's incorrect usage of bpf_dynptr_kern's size
  spotted by Joanne Koong <joannelkoong@gmail.com>
v6:
- Simplify bpf_dynptr_get_data's interface and make it inline
  suggested by John Fastabend <john.fastabend@gmail.com>
- Simplify bpf_skb_set_tunnel_opt_dynptr's interface, removing the
  superfluous 'len' parameter
  suggested by Andrii Nakryiko <andrii.nakryiko@gmail.com>
- Fix missing retcodes in progs/test_tunnel_kern.c
  spotted by John Fastabend <john.fastabend@gmail.com>

Shmulik Ladkani (4):
  bpf: Export 'bpf_dynptr_get_data, bpf_dynptr_get_size' helpers
  bpf: Support setting variable-length tunnel options
  selftests/bpf: Simplify test_tunnel setup for allowing non-local
    tunnel traffic
  selftests/bpf: Add geneve with bpf_skb_set_tunnel_opt_dynptr test-case
    to test_progs

 include/linux/bpf.h                           |   6 +
 include/uapi/linux/bpf.h                      |  11 +
 kernel/bpf/helpers.c                          |   2 +-
 net/core/filter.c                             |  31 ++-
 tools/include/uapi/linux/bpf.h                |  11 +
 .../selftests/bpf/prog_tests/test_tunnel.c    | 131 +++++++++--
 .../selftests/bpf/progs/test_tunnel_kern.c    | 212 ++++++++++++------
 7 files changed, 318 insertions(+), 86 deletions(-)

-- 
2.37.3

