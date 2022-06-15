Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2F454CC80
	for <lists+bpf@lfdr.de>; Wed, 15 Jun 2022 17:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348482AbiFOPRb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jun 2022 11:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243553AbiFOPRa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Jun 2022 11:17:30 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6A16329
        for <bpf@vger.kernel.org>; Wed, 15 Jun 2022 08:17:25 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 25so16618357edw.8
        for <bpf@vger.kernel.org>; Wed, 15 Jun 2022 08:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pUocM+Gtkrj+nILW7X+HjcOQXJB5P16WN/F59j4mvxs=;
        b=byYn+oRHBNeSh8ESqe9yyOiQY0Yz8rir/5NFWj7dYkXdF2Wh8yNqQTMGlaHjfsTWOW
         Mno64BZpQqYhqzKtrgY7tVkkbJ/eautb5N0FhN1F37ojSq1JH4W+qsHTsBTLVBf05CvO
         NGKL7/COiSZQm6OpVDrbqd0Ty8B7VfNTtpkKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pUocM+Gtkrj+nILW7X+HjcOQXJB5P16WN/F59j4mvxs=;
        b=SIqmY+ZHg2ArToBCK5IIf7EXUGWFinj/pycsQvREV/KHsQJ7N9nB3dSkR/k3rnKgtC
         APFMXbYhk+PJeHLySj7bUHFeYH9Tl2HoAVVBoPHAE4xckYtDbJJsHKhBXPcyedXmvY8d
         LDLXMHY2AhMRUorN54PPRZbfQWBDCgKMEdg7ESN59DQXdN5YZqVXQf8E7MXE7txpWHKW
         B5+Aex7dys71ZGBkNOte/zYvhvhqIeovtQv729xN6VCvSXqkzWZI2iZCeVvTB96WbS6R
         LnIgE/Cl+XAY2wxMRJ2C3uIxYmA1Q/kvqoNF4nPnRy1IXX4CFZP/yckhVo1mSBEYTFjz
         eJ2w==
X-Gm-Message-State: AJIora9UvqtkP9RA4XFGXQZ4XF7yNexRumnYACjhuE+qT8gIErtJGHA/
        clMaTJ4nXJDCa56ZOaNWyfFn3Kw0gusPqw==
X-Google-Smtp-Source: AGRyM1vViCNaOBZiHAZKnWqCn7EC49XsxSFyAW5J5B28Uvl+3ZrpBNz3FTIQTUPqlxYSij7bxBz3Ow==
X-Received: by 2002:a05:6402:322a:b0:42e:1778:1f1f with SMTP id g42-20020a056402322a00b0042e17781f1fmr263772eda.115.1655306243552;
        Wed, 15 Jun 2022 08:17:23 -0700 (PDT)
Received: from cloudflare.com (79.184.138.130.ipv4.supernova.orange.pl. [79.184.138.130])
        by smtp.gmail.com with ESMTPSA id jx28-20020a170907761c00b0071160715917sm6360638ejc.223.2022.06.15.08.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 08:17:22 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        kernel-team@cloudflare.com
Subject: [PATCH bpf-next 0/2] Fix tail call counting with bpf2bpf
Date:   Wed, 15 Jun 2022 17:17:19 +0200
Message-Id: <20220615151721.404596-1-jakub@cloudflare.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When working on extending aarch64 JIT to support mixing bpf2bpf with tailcalls,
I ran into what looks like a bug in x64 JIT. Please see patch 1.  Patch 2 adds a
test so that we don't regress.

Jakub Sitnicki (2):
  bpf, x86: Fix tail call count offset calculation on bpf2bpf call
  selftests/bpf: Test tail call counting with bpf2bpf and data on stack

 arch/x86/net/bpf_jit_comp.c                   |  3 +-
 .../selftests/bpf/prog_tests/tailcalls.c      | 55 +++++++++++++++++++
 .../selftests/bpf/progs/tailcall_bpf2bpf6.c   | 42 ++++++++++++++
 3 files changed, 99 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tailcall_bpf2bpf6.c

-- 
2.35.3

