Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88B844DCBE4
	for <lists+bpf@lfdr.de>; Thu, 17 Mar 2022 17:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236723AbiCQQ75 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Mar 2022 12:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236716AbiCQQ7r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Mar 2022 12:59:47 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0644975610
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 09:58:29 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id y17so8002808ljd.12
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 09:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WcrG6+VkE47r6ZOz+XMo3HPYTrzJFWjCVoQmfct9yaU=;
        b=IMicaJVRm3S3zjhvmLDgF78ntl4fG7zHIxnZkbJmV2lFPU5nB4Aml94Tm/TPAq6DoO
         eCatqFz6g3QZlI1sT4dyRAIgpQijPKWJ3c8IiDFqWiZX3WKtyXaCl9iPaazVhq7ljX3x
         BJfyWRy6ervIbjP0STDFYidq++yGDMzhUkZEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WcrG6+VkE47r6ZOz+XMo3HPYTrzJFWjCVoQmfct9yaU=;
        b=6Pjg17QewQKkVur68jLF0vDDCsUyr8VoGYraogNF2Rtls/7Qs1isK9Q7LKTmjW7Gks
         3Tfeggln0vl8zjFr49EPZ0N8+KZwRZ0RabTnM+vq3JD4CgibEwPojbv3vsVCPSgv0BMj
         6ZIN2gRP12I7tYdksjrrp7mBzGRZljO7uAy6IuGWDc/Uxyqh9N/bzWVN4AHj369LdVQS
         D6Wb+gqbXcv5KJkTa+AMaYhevKNsx2lcLL0Bu8J55OlvvT75a+TZva++P8RZhFdBWqlX
         wa9DXj765XNfa5odMkY39pJhTPvzYI0VwRnL6Hcz8F1+JuZDS46POPMrHbvBTdHMJ2os
         FuCQ==
X-Gm-Message-State: AOAM5330l9NB0+PR9AgUA6e11Fi++utkGaRzSyHSDuY9IYGhGxVodhYe
        JW4shFAbolANosMAX13/tltqXHNzBaJyBw==
X-Google-Smtp-Source: ABdhPJx4o4zcl/fDVtho5sQUzbFOwRS4G7JCaYOdwizlVqL6nIpXNg9+qOzK2QlPoijHRkQXdH/Fgw==
X-Received: by 2002:a2e:a0c9:0:b0:249:171b:1b06 with SMTP id f9-20020a2ea0c9000000b00249171b1b06mr3450600ljm.420.1647536307144;
        Thu, 17 Mar 2022 09:58:27 -0700 (PDT)
Received: from cloudflare.com ([2a01:110f:4809:d800::f9c])
        by smtp.gmail.com with ESMTPSA id cf12-20020a056512280c00b004485b8f37b7sm485833lfb.277.2022.03.17.09.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 09:58:26 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        kernel-team@cloudflare.com, Ilya Leoshkevich <iii@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH bpf-next 0/3] Make 2-byte access to bpf_sk_lookup->remote_port endian-agnostic
Date:   Thu, 17 Mar 2022 17:58:23 +0100
Message-Id: <20220317165826.1099418-1-jakub@cloudflare.com>
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

Jakub Sitnicki (3):
  bpf: Treat bpf_sk_lookup remote_port as a 2-byte field
  selftests/bpf: Fix u8 narrow load checks for bpf_sk_lookup remote_port
  selftests/bpf: Fix test for 4-byte load from remote_port on big-endian

 net/core/filter.c                             | 20 +++++++++++++++++--
 .../selftests/bpf/progs/test_sk_lookup.c      | 13 ++++++++----
 2 files changed, 27 insertions(+), 6 deletions(-)

-- 
2.35.1

