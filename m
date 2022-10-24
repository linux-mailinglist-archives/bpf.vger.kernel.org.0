Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC6F460B176
	for <lists+bpf@lfdr.de>; Mon, 24 Oct 2022 18:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbiJXQZQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Oct 2022 12:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234773AbiJXQY2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Oct 2022 12:24:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42DFD18D6
        for <bpf@vger.kernel.org>; Mon, 24 Oct 2022 08:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666624119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7yug/hLUQCw7qYq1gKwXHE2PBRB1KoHvO1djMcyNbXQ=;
        b=A1/rocuKox1O0+wBfyOKuDhAZaq/DrLh+I+kQ7W53eg62EzPp6Grh4qinWwJwRk4wFVvvY
        rohlZ5D+QPru7vm/whM945OPF5Gs08ydhWwZVTK+C17ryTglpdVASktBNPq0q9c19Ys/fo
        ycEhqS/tqhcibI4GGsh+zvDLZtiw4JE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-410-pXTgQd_rPrCZeBMHgQYgFw-1; Mon, 24 Oct 2022 07:48:40 -0400
X-MC-Unique: pXTgQd_rPrCZeBMHgQYgFw-1
Received: by mail-qv1-f72.google.com with SMTP id q17-20020a056214019100b004b1d3c9f3acso5090815qvr.0
        for <bpf@vger.kernel.org>; Mon, 24 Oct 2022 04:48:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7yug/hLUQCw7qYq1gKwXHE2PBRB1KoHvO1djMcyNbXQ=;
        b=oAEtO/BHUastiDQnDo1oA9pE5iXOo1G1vkezXvbs4DmH08vq3lcZiGK6zSZHA1iIlJ
         /EjRiEYOCx0gu9h4Qi1vZPYpZmuXwUwttFrsAz6Eizt97uTwunWEfeVpE28wgYFOWH1B
         l/gwSvZjJcYMie7el7uSKH+YnBM8kWoMiIuP6k6XmGLHjefEg6REzl6sXzX+KlnjP1gT
         yvr6Xxw3oSMMWimTE5OwGbDXaYhcJwpD2/iQ+C6BNqIjuJvNDbudPhCti/uwaS/nY48v
         62nyUAHCTDYnvekWntg48Zx7weDEIy9Q+KNwDr3/uagKCtAvSONVe1w3hH3LOobvtfAs
         pQcA==
X-Gm-Message-State: ACrzQf3/KS9pGmOkvvw6QHlsGLa5KIu8g422XrLI+hTkECaV/dwp8eaK
        6s007+NTXeJbAkZO2FC5WGt283zPNRfOVos+xNsKrHu73+vkABXdMsdXZQzKxMdstf4f+nMvfNW
        IPUgN+WTJodADEI7DEl89dtggu0RinAIVfJcQEFjO9sjgCctWs2c/ZyHKQdMsuqg=
X-Received: by 2002:a05:622a:1015:b0:39c:be69:bf2d with SMTP id d21-20020a05622a101500b0039cbe69bf2dmr27865545qte.85.1666612119409;
        Mon, 24 Oct 2022 04:48:39 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4+ASXME3U+PSmVa7jxRPX3J3GOgBErk2ndsbpTfCWuYTw+fxoM9+sZu/lt7RYI7zXlyo9vNA==
X-Received: by 2002:a05:622a:1015:b0:39c:be69:bf2d with SMTP id d21-20020a05622a101500b0039cbe69bf2dmr27865531qte.85.1666612119158;
        Mon, 24 Oct 2022 04:48:39 -0700 (PDT)
Received: from nfvsdn-06.testing.baremetal.edge-sites.net (nat-pool-232-132.redhat.com. [66.187.232.132])
        by smtp.gmail.com with ESMTPSA id m15-20020a05620a13af00b006ee949b8051sm14653564qki.51.2022.10.24.04.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 04:48:38 -0700 (PDT)
From:   mtahhan@redhat.com
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Maryam Tahhan <mtahhan@redhat.com>
Subject: [PATCH bpf-next v5 0/1] doc: DEVMAPs and XDP_REDIRECT
Date:   Mon, 24 Oct 2022 08:43:40 -0400
Message-Id: <20221024124341.2157865-1-mtahhan@redhat.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Maryam Tahhan <mtahhan@redhat.com>

Add documentation for BPF_MAP_TYPE_DEVMAP and
BPF_MAP_TYPE_DEVMAP_HASH including kernel version
introduced, usage and examples.

Add documentation that describes XDP_REDIRECT.

v4->v5:
- Remove unused 'index' variable in example.

v3->v4:
- Prepend supported map section for XDP_REDIRECT documentation.

v2->v3:
- Fixed indentations in usage section to exclude non note text.
- Replace links to selftest with actual paths.

v1->v2:
- Separate xdp_redirect documentation to its own file.
- Clean up and simplify examples and usage function descriptions.

Maryam Tahhan (1):
  doc: DEVMAPs and XDP_REDIRECT

 Documentation/bpf/index.rst      |   1 +
 Documentation/bpf/map_devmap.rst | 203 +++++++++++++++++++++++++++++++
 Documentation/bpf/redirect.rst   |  45 +++++++
 3 files changed, 249 insertions(+)
 create mode 100644 Documentation/bpf/map_devmap.rst
 create mode 100644 Documentation/bpf/redirect.rst

-- 
2.35.3

