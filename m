Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB344AFB87
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 19:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240699AbiBISr1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 13:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241019AbiBISq2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 13:46:28 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721A3C002B79
        for <bpf@vger.kernel.org>; Wed,  9 Feb 2022 10:43:38 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id f23so5957510lfe.5
        for <bpf@vger.kernel.org>; Wed, 09 Feb 2022 10:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c85reDCGkBPaTN3RSyeYt17oyCuDpc1kgEfl/4qYIBo=;
        b=ti/xACF/P3rWEFRgmY8xRpF4JIOnkE1XX/tpD1pz7X0Jla6qa9o/2hKNHFIIdDWSv8
         X/ONhBVLSufHKlG2OGVsgjFHlrQRWQpgdCZe55fMXriplS+tkWWmnPzdDyRZ2++YPcru
         brnkRLdIg0fhDtRPuCiG5dgUmemTbh3Jy1K9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c85reDCGkBPaTN3RSyeYt17oyCuDpc1kgEfl/4qYIBo=;
        b=NnsXnS5JrFbAoXQGredi3m5+Fc1Z52qOYrjefV0CE5nrQMjqQSGF8ix3LmHCg+ltsK
         WNgg9coueLSl1t+K71AT5Ybjre8oP6V0GCIvJZ4BGhPyY6LaknLTfhcY+udNz8MAbL53
         JPg4wzXtcv7hmLuuOtRxfg/jTqfxhlicnQCtKzwo2ytVdDPQ5cO8eTZFGCdJXbLvRDJv
         zNKgF0IgeiGzwCO3dKMgUkE214rT8mBheAeuMvfFWUaxx3xttqK+5ljguPAryxDwblNc
         qGQ7fI4y9hVV1+8iE+CT/8BsovwO0AFdUyHQRbH2JIwzfR9GCje38CrrjHKng7hjkqWw
         gwFg==
X-Gm-Message-State: AOAM531lgq+GFMpkwNmLUwOtmBbWZB6ob3IZIB9U+mzqbC5roopPBrC5
        +cSWFFXfnRTC0nMJfBwi1P7HuJzqVw91sA==
X-Google-Smtp-Source: ABdhPJykHK+JSD5pZoJbPdkPZXSjCXcYsujAoQrPx/0tWATv3lOZr/AnZju3fFO8/cwNmbKMSKJ9nA==
X-Received: by 2002:ac2:47ef:: with SMTP id b15mr2411514lfp.95.1644432214328;
        Wed, 09 Feb 2022 10:43:34 -0800 (PST)
Received: from cloudflare.com (2a01-110f-4809-d800-0000-0000-0000-0e00.aa.ipv6.supernova.orange.pl. [2a01:110f:4809:d800::e00])
        by smtp.gmail.com with ESMTPSA id k2sm2465086lfe.213.2022.02.09.10.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 10:43:33 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        kernel-team@cloudflare.com, Yonghong Song <yhs@fb.com>
Subject: [PATCH bpf-next v2 0/2] Split bpf_sk_lookup remote_port field
Date:   Wed,  9 Feb 2022 19:43:31 +0100
Message-Id: <20220209184333.654927-1-jakub@cloudflare.com>
X-Mailer: git-send-email 2.31.1
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

Following the recent split-up of the bpf_sock dst_port field, apply the same to
technique to the bpf_sk_lookup remote_port field to make uAPI more user
friendly.

v1 -> v2:
- Remove remote_port range check and cast to be16 in TEST_RUN for sk_lookup
  (kernel test robot)

Jakub Sitnicki (2):
  bpf: Make remote_port field in struct bpf_sk_lookup 16-bit wide
  selftests/bpf: Cover 4-byte load from remote_port in bpf_sk_lookup

 include/uapi/linux/bpf.h                           | 3 ++-
 net/bpf/test_run.c                                 | 4 ++--
 net/core/filter.c                                  | 3 ++-
 tools/include/uapi/linux/bpf.h                     | 3 ++-
 tools/testing/selftests/bpf/progs/test_sk_lookup.c | 6 ++++++
 5 files changed, 14 insertions(+), 5 deletions(-)

-- 
2.31.1

