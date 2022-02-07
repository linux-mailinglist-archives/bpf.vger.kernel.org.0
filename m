Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDDCB4AC00C
	for <lists+bpf@lfdr.de>; Mon,  7 Feb 2022 14:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236115AbiBGNum (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Feb 2022 08:50:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449005AbiBGNPF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Feb 2022 08:15:05 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F4EC043188
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 05:15:03 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id j14so19551383lja.3
        for <bpf@vger.kernel.org>; Mon, 07 Feb 2022 05:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ogTHEJ6u2M62tUs2AjfjDpWnGrLDSdZkHRs0/05Ftio=;
        b=IcucMnOntR53bFU9rFuJNUllXAos1otMSmN+SCvxVFHf77e2OHIhJJYbY5CKnsChN7
         xgoCeHz7NBRTmyXx6Fo2+YDc3JQU3RgeyVwpN+0E2zrbaKurY+z0rTlrvAhZY/4yrNWQ
         4Tftbk7WksSPA42zgpq7rlE6MoPkPuk9jahog=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ogTHEJ6u2M62tUs2AjfjDpWnGrLDSdZkHRs0/05Ftio=;
        b=dk3FSsTGLOGEoV50Gp9dqQHvvB1voEl8F+zQM066DEXN2U6vyI7tdtIqSsqqOdsvhU
         e4hyQs+lBHRKPlAt+p1nquwfcTf846oBxLcWspXwacUScxSvCXIBlXyGihhRjt6aeZCl
         500AoCwkBXy9YupUMtit+/y/UXSqg8N8Cql5waDbral/1NODAHdPXZvOFGoUEcZQkQoo
         ZgjTzxTn4TXviEgYJTtn4mrqA8O4BxEOlwn4gzFIPdweF/0XuRb5eVBXij9cVgbFK46h
         nvIYeUR2j3ZKKpAuLqF7AGvjlwdMtOzCgFD6A9oIG29at8eBfpQvzWS9Ep/mLLWtrxLh
         ORwQ==
X-Gm-Message-State: AOAM530MKIlI6NAvWhGql1LzU4SXgOdbFM9paiAgd07KlJZvyCo6D/E4
        I6vCgvt0S0qmQArZXiURmOvQNPnglRx/kA==
X-Google-Smtp-Source: ABdhPJxmwcxQe/2G1oOhTH9jv/pfwdnFtMio0JqRY44WvhOAjdpwfOKMwD3WKiw0bTLOVcb/u4fDxg==
X-Received: by 2002:a2e:8948:: with SMTP id b8mr3398982ljk.36.1644239700826;
        Mon, 07 Feb 2022 05:15:00 -0800 (PST)
Received: from cloudflare.com (user-5-173-137-68.play-internet.pl. [5.173.137.68])
        by smtp.gmail.com with ESMTPSA id z5sm657415lft.210.2022.02.07.05.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 05:15:00 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, kernel-team@cloudflare.com
Subject: [PATCH bpf-next 0/2] Split bpf_sk_lookup remote_port field
Date:   Mon,  7 Feb 2022 14:14:57 +0100
Message-Id: <20220207131459.504292-1-jakub@cloudflare.com>
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

Jakub Sitnicki (2):
  bpf: Make remote_port field in struct bpf_sk_lookup 16-bit wide
  selftests/bpf: Cover 4-byte load from remote_port in bpf_sk_lookup

 include/uapi/linux/bpf.h                           | 3 ++-
 net/core/filter.c                                  | 3 ++-
 tools/include/uapi/linux/bpf.h                     | 3 ++-
 tools/testing/selftests/bpf/progs/test_sk_lookup.c | 6 ++++++
 4 files changed, 12 insertions(+), 3 deletions(-)

-- 
2.31.1

