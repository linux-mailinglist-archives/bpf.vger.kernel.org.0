Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5334DEA20
	for <lists+bpf@lfdr.de>; Sat, 19 Mar 2022 19:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243916AbiCSSfV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Mar 2022 14:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243007AbiCSSfU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Mar 2022 14:35:20 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB8A2986E2
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 11:33:59 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id q14so1831312ljc.12
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 11:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VW8BDB2VfwkzSZCTsDyRQ3YwjQtV1V8LL0bIchN+Big=;
        b=VIw1S1GO9SuM4hHP/8bLBfM4LuZKgyt19a6B8zs+zTAiCD/YOHj3/2BJ0vgOUDCRe7
         jU5JauuEDT2CJNj4BMjL9bX5/UuagijFQ8w03C8SXW8zCqxRQJDpj4rOaD78/tUrcSUA
         Izj6WCLTW3E/DVI/9Zw7Us8vGNw1Nu6t+0lgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VW8BDB2VfwkzSZCTsDyRQ3YwjQtV1V8LL0bIchN+Big=;
        b=EU1FQVnV2K9vXlwDDRM7Z0H8kNBj0i187cQfxWRnmblopRiJBM1au6fxBPf91GFtfV
         /3dsvKhVda+cYYwZ9Q1110JFJ0c0DjnZUX4hjiNt50LFmUzxL4A+vKZxZ/9HWCodEtCS
         uVNxy/UnWg/xljAcY8fq75GwPuyDsH/LDzL4bo8ako8OBLS5gYkzcpnSY9oKTwADJQ8c
         mAQxUETo32u64M2hdmgwkk3BFviXhk05q90lTc9dhPPO+aq9EYGR9fN3An5y+g59wxyi
         Ers3vAX+769rAnTM/BpsEhjHu80VM3MQmHfY+h97RvdKk/vJ8TYyq6zSMWTmLhIawWJF
         bdaQ==
X-Gm-Message-State: AOAM532MCs6IFFu1E9Sm/bRtWBjE6RfSCP7QkeUeK6peGVNqJPIMrF5n
        QEVhZ2kMXih4qO4TRUro3RdCO1ktodJArA==
X-Google-Smtp-Source: ABdhPJyOGKukco55KC3gc4VIB2Z1gihOxNgMmd5O0vCGT34eNB9IZZQ1l+Wp9NSIqVFkN7SnVxk7+w==
X-Received: by 2002:a2e:a58c:0:b0:249:7ecf:6075 with SMTP id m12-20020a2ea58c000000b002497ecf6075mr657781ljp.460.1647714837091;
        Sat, 19 Mar 2022 11:33:57 -0700 (PDT)
Received: from cloudflare.com ([2a01:110f:4809:d800::f9c])
        by smtp.gmail.com with ESMTPSA id i4-20020a0565123e0400b0044a22849fe3sm125808lfv.244.2022.03.19.11.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 11:33:56 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        kernel-team@cloudflare.com, Martin KaFai Lau <kafai@fb.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH bpf-next v2 0/3] Make 2-byte access to bpf_sk_lookup->remote_port endian-agnostic
Date:   Sat, 19 Mar 2022 19:33:53 +0100
Message-Id: <20220319183356.233666-1-jakub@cloudflare.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch set is a result of a discussion we had around the RFC patchset from
Ilya [1]. The fix for the narrow loads from the RFC series is still relevant,
but this series does not depend on it. Nor is it required to unbreak sk_lookup
tests on BE, if this series gets applied.

To summarize the takeaways from [1]:

 1) we want to make 2-byte load from ctx->remote_port portable across LE and BE,
 2) we keep the 4-byte load from ctx->remote_port as it is today - result varies
    on endianess of the platform.

[1] https://lore.kernel.org/bpf/20220222182559.2865596-2-iii@linux.ibm.com/

v1 -> v2:
- Remove needless check that 4-byte load is from &ctx->remote_port offset
  (Martin)

[v1]: https://lore.kernel.org/bpf/20220317165826.1099418-1-jakub@cloudflare.com/

Jakub Sitnicki (3):
  bpf: Treat bpf_sk_lookup remote_port as a 2-byte field
  selftests/bpf: Fix u8 narrow load checks for bpf_sk_lookup remote_port
  selftests/bpf: Fix test for 4-byte load from remote_port on big-endian

 net/core/filter.c                             | 20 +++++++++++++++++--
 .../selftests/bpf/progs/test_sk_lookup.c      | 13 ++++++++----
 2 files changed, 27 insertions(+), 6 deletions(-)

-- 
2.35.1

