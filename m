Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C2E4DC4EA
	for <lists+bpf@lfdr.de>; Thu, 17 Mar 2022 12:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233000AbiCQLkk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Mar 2022 07:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232975AbiCQLkj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Mar 2022 07:40:39 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135D11E3E39
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 04:39:23 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id bx44so316811ljb.13
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 04:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DbtrcL9GJzYDGCFlpv1xtgXFVasGhksAlMX+lSG7WXU=;
        b=q5Ku+BbuqekmrbgH8cftrjOwzn3WSMzmo20OayCXYV9oH95anvqWmJpQGAuYMUf1ae
         W0RWKYXUYckr3vL0VDrmerIO5ZwqYk0maw1Fz3708cCulDmPtyQUwZUMqiyivthIoVHJ
         txDZB5SqFP8+9t7HKtFlKApi+O6HxUiqMo+qk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DbtrcL9GJzYDGCFlpv1xtgXFVasGhksAlMX+lSG7WXU=;
        b=H+LXkWDE4ccGs95jHb45IavXYr+lJZv8VcTef2Ii9GxFWYu4IfzA5BW0AYcykEwVjY
         Sgw8PVfXlIYSpdW5WquiR/xM5UD++ZIDdTSR4378a4GoHzaJXq+r1HT4TQzgsRG7h7WI
         ykGmL2qpVcPaFmCdyk94U834GupG9MZyXaCRg/7beIeH8amPu5jDpusDUClTLWeOrahN
         s8k+VUAgkuKYKt2v8eiNCyMo312oOZtE958OTkN8j9pGsj9KkuHzwwCxWFFhESf061pg
         lbOeFPojVM/EsZF3F/S4GskTd9cZdEWgUN1xFryLjjM0jV3TeyTTFC0wzVergccJl1dA
         7MBg==
X-Gm-Message-State: AOAM533rV/M5zn/cA5klh3Cqhj0LIkH3L0kx0yPFgyDjbz0aU708fAnY
        g+WDWJie1kdSFgrApnBZGAy0tb0UyaNNcg==
X-Google-Smtp-Source: ABdhPJzcQVuGOdpiud7qZRpPV53jrK03AXivteMFrfV+jVhs6sLeRc9DHvLvWhbTAff2Z5uOfe5a9A==
X-Received: by 2002:a2e:a451:0:b0:247:fdea:247 with SMTP id v17-20020a2ea451000000b00247fdea0247mr2579714ljn.305.1647517161219;
        Thu, 17 Mar 2022 04:39:21 -0700 (PDT)
Received: from cloudflare.com ([2a01:110f:4809:d800::f9c])
        by smtp.gmail.com with ESMTPSA id h3-20020a2e9003000000b00249278d3bd7sm416490ljg.77.2022.03.17.04.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 04:39:20 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        kernel-team@cloudflare.com, Ilya Leoshkevich <iii@linux.ibm.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next v3 0/4] Fixes for sock_fields selftests
Date:   Thu, 17 Mar 2022 12:39:16 +0100
Message-Id: <20220317113920.1068535-1-jakub@cloudflare.com>
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

I think we have reached a consensus [1] on how the test for the 4-byte load from
bpf_sock->dst_port and bpf_sk_lookup->remote_port should look, so here goes v3.

I will submit a separate set of patches for bpf_sk_lookup->remote_port tests.


This series has been tested on x86_64 and s390 on top of recent bpf-next -
ad13baf45691 ("selftests/bpf: Test subprog jit when toggle bpf_jit_harden
repeatedly").

[1] https://lore.kernel.org/bpf/87k0cwxkzs.fsf@cloudflare.com/

v2 -> v3:
- Split what was previously patch 2 which was doing two things
- Use BPF_TCP_* constants (Martin)
- Treat the result of 4-byte load from dst_port as a 16-bit value (Martin)
- Typo fixup and some rewording in patch 4 description

v1 -> v2:
- Limit read_sk_dst_port only to client traffic (patch 2)
- Make read_sk_dst_port pass on litte- and big-endian (patch 3)

v1: https://lore.kernel.org/bpf/20220225184130.483208-1-jakub@cloudflare.com/
v2: https://lore.kernel.org/bpf/20220227202757.519015-1-jakub@cloudflare.com/

Jakub Sitnicki (4):
  selftests/bpf: Fix error reporting from sock_fields programs
  selftests/bpf: Check dst_port only on the client socket
  selftests/bpf: Use constants for socket states in sock_fields test
  selftests/bpf: Fix test for 4-byte load from dst_port on big-endian

 .../selftests/bpf/progs/test_sock_fields.c    | 24 +++++++++++++------
 1 file changed, 17 insertions(+), 7 deletions(-)

-- 
2.35.1

