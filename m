Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF46504A0A
	for <lists+bpf@lfdr.de>; Mon, 18 Apr 2022 01:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235335AbiDQXUy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 17 Apr 2022 19:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbiDQXUx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 17 Apr 2022 19:20:53 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953A8DE8B
        for <bpf@vger.kernel.org>; Sun, 17 Apr 2022 16:18:16 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id md4so11661571pjb.4
        for <bpf@vger.kernel.org>; Sun, 17 Apr 2022 16:18:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WBsrGZzWwWSc+8hrajitHXNgUcr7VP+/HKwWffoUSlw=;
        b=1LmSixN3U4wY0Hm42QaylftkKNzxQq/VpI5caKVr0oNP0I9F4IfDuK7hTQkx04Hh8f
         lZLN5WuK/mc7xTGCoX0Oh6WNa6TQIGpJ05xbRcQRQppxCNFWMYLwURR1XDa1N4M0cVni
         oLvUN1IzB5+jp6JDM+rVLbcemxR96LhxFcWyPvUUkkwQBL0f+rsBNzK0gdZ2lrmD3Sz0
         83qMtwJUlMgMSH16msIBGIB/0d1AcxcSO43JofyCXOlD3lg3ZCTRD85+1CM/HVwSLvZO
         ISBWaQNLStug87J8nB/gvzpkg3kmRirlNu3+GvquOP35u+kJg6bPhkKRPZ33zrJnvMEg
         rpoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WBsrGZzWwWSc+8hrajitHXNgUcr7VP+/HKwWffoUSlw=;
        b=ZvzGMWHcyF7jlFgx1cEqYFdgktiqaG7Ed068IkiW94I3xI/b6f/L8o/D7hLiIfBdKj
         GESJcJZMk0+v9MnN+GhkHWs99ybUtwXwrHE/5VvdCzIYSQbfIUuW+XmpqPCWQpoy71SR
         vDshBt0XLSgWhZoAneb5wdPHmqq/0cTsikjzAdgH9RGcgKlRCWheWhRATxH2ZQ+3Akv/
         Jij5KaQ1wHvE9Y+9OMtTYQatq9tEtqcu9hJkp/zg5PEKnusTg3Z6RC0pSlUkvzOQZ1ch
         A5hprtgWEpHVfCqkYyUNrqdNoYGxeXK1N+UFmvZHERbRqyaCN62cGz375RFiKfjMbOHB
         2nuA==
X-Gm-Message-State: AOAM533mZLtHmsnahUG19T9UO5jqwUc7nRYL+2LdDN1RmwE+s6sufgbt
        0Zk4YruPxU2Wv8ULPL2Wi0tm3g==
X-Google-Smtp-Source: ABdhPJwy0uUucit+G+C8doOG8m4YaQrzRRnbUgdOpAH+wDPzBOZsA/rXj29qROhszRl+Csk5QZQ+IQ==
X-Received: by 2002:a17:90b:4f91:b0:1cd:3a73:3a5d with SMTP id qe17-20020a17090b4f9100b001cd3a733a5dmr10074049pjb.98.1650237496112;
        Sun, 17 Apr 2022 16:18:16 -0700 (PDT)
Received: from localhost.localdomain ([223.64.73.168])
        by smtp.gmail.com with ESMTPSA id h10-20020a056a001a4a00b004f7c76f29c3sm9906005pfv.24.2022.04.17.16.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 16:18:15 -0700 (PDT)
From:   fankaixi.li@bytedance.com
To:     kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        Kaixi Fan <fankaixi.li@bytedance.com>
Subject: [External] [PATCH bpf-next v3 0/3] Add source ip in bpf tunnel key
Date:   Mon, 18 Apr 2022 07:17:45 +0800
Message-Id: <20220417231745.23354-1-fankaixi.li@bytedance.com>
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

Add tunnel and tunnel source testcases in test_progs.

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

