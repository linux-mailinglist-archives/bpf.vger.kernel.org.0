Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E25159F2BD
	for <lists+bpf@lfdr.de>; Wed, 24 Aug 2022 06:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbiHXElc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Aug 2022 00:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234428AbiHXElb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Aug 2022 00:41:31 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2C38B9B3
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 21:41:29 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id o3so759157wrv.6
        for <bpf@vger.kernel.org>; Tue, 23 Aug 2022 21:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metanetworks.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=yGxF0jiErGy/8U35p3tLl4/XjetDAM/3F6QmhnEsNwk=;
        b=YjD6dbOqyLuG6Z1XQDkMEbmczslJnFUHI0g+o1Ww85DJNDAJPLbdFTGL5MJa8/9kcT
         Iuei5zvkzTehRaWy9LgQKLQHL2bmqp/8aZ5oObUF99r+HXfNu/7W926l1mOl78U90RvS
         /IxupapDRhcVLeIe1wJIHO8eTHRM55fqoE5Qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=yGxF0jiErGy/8U35p3tLl4/XjetDAM/3F6QmhnEsNwk=;
        b=AV7itkaleT2yOqv9pYrD/7VN6f36PTx7ZnHJC8mTeg6aBCwBlN92eSHe2H1zLDDcLj
         B46okP8fHe2hSubYrbsPf/p5XXIQceVZGFFuAbifYq/drj68I9YooOD+vIo/OHaQD/21
         tv1ta+2eLHxfB7NL9mrvwGrJHlsBcuYCMzuYxYkJPyOs/huKiIHwCt3cxJi28aydP0bA
         mw6KzOYUaI5oqn4k4R8IxcCyzXbMyGYAY7wlPMw8QogYzsd7xBC0HkAv8UOIvQXic7O6
         3eQumZ/7W06zl1ct7i+AIDMe/CoRHiIvt4M5c1Kq80U5QbkPnaRZw2eLk6bGg9Tq190Y
         G2hg==
X-Gm-Message-State: ACgBeo0/YnysTpR+7jL8ku4Lvj+8Lzxckk0oGBSghT7dBY5mUI9+m0zq
        yk5nu/uXKaoId6Py6vNiAurEX+W4p2000YONjMJ1/8DMMwCiiEjNBSQcUEIvZTNHywd8eFkcWY0
        rHMy5inZGoyqATstIgxbgUeQ7BuVm8iZxwqdKx6hylRJP65839mcc5IzsHEzqzO8acbF2zdjS
X-Google-Smtp-Source: AA6agR6dlukDUGIcy3gq5gXvsLBeLdaofiBEb9wZsi6Z4nX+3wTOPGDglZaVYKrNqb5lCoFAlD/i4g==
X-Received: by 2002:a05:6000:1acd:b0:220:62c2:bc29 with SMTP id i13-20020a0560001acd00b0022062c2bc29mr14685739wry.620.1661316087538;
        Tue, 23 Aug 2022 21:41:27 -0700 (PDT)
Received: from blondie.home ([94.230.83.151])
        by smtp.gmail.com with ESMTPSA id m9-20020adfe0c9000000b00225206dd595sm15572735wri.86.2022.08.23.21.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 21:41:26 -0700 (PDT)
From:   Shmulik Ladkani <shmulik@metanetworks.com>
X-Google-Original-From: Shmulik Ladkani <shmulik.ladkani@gmail.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Paul Chaignon <paul@isovalent.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: [PATCH v5 bpf-next 0/4] bpf: Support setting variable-length tunnel options
Date:   Wed, 24 Aug 2022 07:41:13 +0300
Message-Id: <20220824044117.137658-1-shmulik.ladkani@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

Shmulik Ladkani (4):
  bpf: Add 'bpf_dynptr_get_data' helper
  bpf: Support setting variable-length tunnel options
  selftests/bpf: Simplify test_tunnel setup for allowing non-local
    tunnel traffic
  selftests/bpf: Add geneve with bpf_skb_set_tunnel_opt_dynptr test-case
    to test_progs

 include/linux/bpf.h                           |   1 +
 include/uapi/linux/bpf.h                      |  12 ++
 kernel/bpf/helpers.c                          |   8 +
 net/core/filter.c                             |  36 +++-
 tools/include/uapi/linux/bpf.h                |  12 ++
 .../selftests/bpf/prog_tests/test_tunnel.c    | 131 ++++++++++--
 .../selftests/bpf/progs/test_tunnel_kern.c    | 200 ++++++++++++------
 7 files changed, 320 insertions(+), 80 deletions(-)

-- 
2.37.2

