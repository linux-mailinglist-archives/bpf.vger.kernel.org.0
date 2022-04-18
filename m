Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2BC3504A78
	for <lists+bpf@lfdr.de>; Mon, 18 Apr 2022 03:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbiDRBe2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 17 Apr 2022 21:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiDRBe1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 17 Apr 2022 21:34:27 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D35F13E99
        for <bpf@vger.kernel.org>; Sun, 17 Apr 2022 18:31:50 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id t4so16187748pgc.1
        for <bpf@vger.kernel.org>; Sun, 17 Apr 2022 18:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ECcBp+VvL8RjwfUwe6yF95t5cOmCYcR+uU+OlZQUG7A=;
        b=aV1+GBD9olLoVdvSMyh2qRSqFVn28TaASI4fIIEWLCpq4gNFYGmfXHKgY85FDNi/k8
         B0HToDfLx2e2xt62YT9zb+MXF41Qg7+qnNW4kEPZUVALEQNzVJhJf+tZKJm+3s+95nBW
         p/72801NGRISMgiUXtjYhM2biVz+J8M97SSUGC983S/jiFwSPtEx3kDXqgVZ+uHmnnHj
         3GXI6gPclXiU6qZuHk/HkKITTpZhlUDhNQ2jQCfAJzhIN6/gY6y08bGYLpdnMpVNP1TZ
         3wa7ev8EVfj8TllTg+TMG+sR4c/PhQc81vhPOfu2TnUhKmAd8GvVZ4mwL8NB9JDeTgjQ
         fgzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ECcBp+VvL8RjwfUwe6yF95t5cOmCYcR+uU+OlZQUG7A=;
        b=jUBpoDjqKupwniy4ggbhbPYVcM3TtulBaOR4Bu0ILUL2XxnNTQlcBiLc4UO69f6JCa
         8hIj5ksUhQtb7fO2fmNEeR9EqvqpHg6j1MXlC0yOH1nsdWX4E3/JYIFJ8z7arCdkfa4f
         FY+IihtQ2YHbQrsAcQo5CmelNg9k0Qutkr1yOobuzhiiOZ19/8E9+e/V3Z5RRpXvKPL6
         U+tLgH6SnayA1TGrSjJf4hKapUcJ7G2SfuZzeYX4I5pIQsfCxcFkX4HuQDqrBmMWf3tD
         hurlGDglGN/NVgiLOFC4k31oIAtw/3BYDGKCkY6Z5zG5C5KsEb+4XZleB6MecSLC+BCU
         jM+Q==
X-Gm-Message-State: AOAM533HYv4ip8PXHlNYY+lVhUxif45nsJoWbl7WJk9XkZSzncsf5TvQ
        QNZZSG/SGYs4U5zYLzjezX6VlYUEDJgjtA==
X-Google-Smtp-Source: ABdhPJxHBvvFwk76A9fYEI4jlVQXT7HKVlLD9mbm2MU04hxRo2F4Ts493hkko8O3j/cf27umwSKFhQ==
X-Received: by 2002:a63:450d:0:b0:3a8:f2ed:1aa5 with SMTP id s13-20020a63450d000000b003a8f2ed1aa5mr4955938pga.367.1650245510011;
        Sun, 17 Apr 2022 18:31:50 -0700 (PDT)
Received: from localhost.localdomain ([2409:8a20:4832:de00:590a:cbcb:f71b:54e5])
        by smtp.gmail.com with ESMTPSA id c2-20020a63a442000000b0039cc5a6af1csm10807333pgp.30.2022.04.17.18.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 18:31:49 -0700 (PDT)
From:   fankaixi.li@bytedance.com
To:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        Kaixi Fan <fankaixi.li@bytedance.com>
Subject: [External] [PATCH bpf-next v4 0/3] Add source ip in bpf tunnel key
Date:   Mon, 18 Apr 2022 09:31:33 +0800
Message-Id: <20220418013136.26098-1-fankaixi.li@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Kaixi Fan <fankaixi.li@bytedance.com>

Now bpf code could not set tunnel source ip address of ip tunnel. So it
could not support flow based tunnel mode completely. Because flow based
tunnel mode could set tunnel source, destination ip address and tunnel
key simultaneously.

Flow based tunnel is useful for overlay networks. And by configuring tunnel
source ip address, user could make their networks more elastic.
For example, tunnel source ip could be used to select different egress
nic interface for different flows with same tunnel destination ip. Another
example, user could choose one of multiple ip address of the egress nic
interface as the packet's tunnel source ip.

Add tunnel and tunnel source testcases in test_progs. Other types of 
tunnel testcases would be moved to test_progs step by step in the
future.

v4:
- fix subject error of first patch 

v3:
- move vxlan tunnel testcases to test_progs
- replace bpf_trace_printk with bpf_printk
- rename bpf kernel prog section name to tic

v2:
- merge vxlan tunnel and tunnel source ip testcases in test_tunnel.sh

Kaixi Fan (3):
  bpf: Add source ip in "struct bpf_tunnel_key"
  selftests/bpf: move vxlan tunnel testcases to test_progs
  selftests/bpf: replace bpf_trace_printk in tunnel kernel code

 include/uapi/linux/bpf.h                      |   4 +
 net/core/filter.c                             |   9 +
 tools/include/uapi/linux/bpf.h                |   4 +
 .../selftests/bpf/prog_tests/test_tunnel.c    | 461 ++++++++++++++++++
 .../selftests/bpf/progs/test_tunnel_kern.c    | 282 ++++++-----
 tools/testing/selftests/bpf/test_tunnel.sh    | 124 +----
 6 files changed, 646 insertions(+), 238 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_tunnel.c

-- 
2.20.1

