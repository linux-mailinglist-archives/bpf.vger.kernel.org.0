Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180FD607BB3
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 18:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiJUQER (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 12:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiJUQEQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 12:04:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30202263B4F
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 09:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666368252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=17geT16pG35VTrdYqV5tA3g6Cj90L+YxvyM0AjY26TQ=;
        b=R4exmJ8vSWV+I13alWHeub+uozLegSrAg3cx10Uq/tbjYDjLWVjtXeRmhcbyGrdc1V/a4o
        1DTYpXDUFZ7OwPq7+KGhWnaxOxAF7vTj0D3l/OZFhSj5Ln8T8WGJb4WYgvQw3AsMk3p/nm
        TRUanLxsgSk+oJNqhUzjflFiN1cnJc0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-640-rUIjDTB7OUeUuBEgcvJyKw-1; Fri, 21 Oct 2022 12:04:10 -0400
X-MC-Unique: rUIjDTB7OUeUuBEgcvJyKw-1
Received: by mail-qk1-f200.google.com with SMTP id h9-20020a05620a244900b006ee944ec451so3844072qkn.13
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 09:04:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=17geT16pG35VTrdYqV5tA3g6Cj90L+YxvyM0AjY26TQ=;
        b=3E9OpuwWlf7VRJP+HKmSr935yA0UX6CeICTb5oCWpu0ZVgBE1DSOzMGOHWnpX04SUb
         8xy4ha4FMzuSXFM10sPeSf36M4Y/W/Rho2Gh9e7TU4L0bfXDpEUD+xLmSqybGjSzHULD
         H9X3je0jD1W4PxG+L4HdIZ8skVptgYMVoHftaJqeBQJZPRwaPvNuUaWgRB6cueYq+PQJ
         ntd7+3pDL4Y+HaJqk6gdf9yp5TMfZ8J11H+FCeOTMsMT5RNSr6kzhvSk5yoNG8QfrCBb
         3lWG1g6jc+OMyftPfioOh2pEW+TmBJ90bFm9hocAS30vIbPkaQQfBAi+9Y+ngJf3FBr8
         Yy+Q==
X-Gm-Message-State: ACrzQf2Ftpk9THBDzgz/HmGSBuStyTYNE3PRqbYqJbZGbGWFFgsH0Ik2
        aS+mZiteydAS8NLzrcQJ1WH+F3jUYucXx/coVcx26iFw9l2iROK2AEM6nTeiIkMcUJGokmGJliB
        QG6YGEzxAh67/7xFG/4jMFjXDbEM75zh7unGp2TKVIZghXzHOSYlJaWVlA7ZrawA=
X-Received: by 2002:a05:620a:2414:b0:6ee:d0c5:b3ad with SMTP id d20-20020a05620a241400b006eed0c5b3admr14003976qkn.613.1666368250093;
        Fri, 21 Oct 2022 09:04:10 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6pELEP9EfuC3UNQ/G1TIANQewXbb7hKJRjTjdUXiNxvYiQXnDmDhOls8IIpnlQmwzpvCa9nQ==
X-Received: by 2002:a05:620a:2414:b0:6ee:d0c5:b3ad with SMTP id d20-20020a05620a241400b006eed0c5b3admr14003940qkn.613.1666368249809;
        Fri, 21 Oct 2022 09:04:09 -0700 (PDT)
Received: from nfvsdn-06.testing.baremetal.edge-sites.net (nat-pool-232-132.redhat.com. [66.187.232.132])
        by smtp.gmail.com with ESMTPSA id br22-20020a05622a1e1600b0039cb5c9dbacsm8088849qtb.22.2022.10.21.09.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 09:04:09 -0700 (PDT)
From:   mtahhan@redhat.com
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Maryam Tahhan <mtahhan@redhat.com>
Subject: [PATCH bpf-next v4 0/1] doc: DEVMAPs and XDP_REDIRECT
Date:   Fri, 21 Oct 2022 12:59:18 -0400
Message-Id: <20221021165919.509652-1-mtahhan@redhat.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 Documentation/bpf/map_devmap.rst | 205 +++++++++++++++++++++++++++++++
 Documentation/bpf/redirect.rst   |  46 +++++++
 3 files changed, 252 insertions(+)
 create mode 100644 Documentation/bpf/map_devmap.rst
 create mode 100644 Documentation/bpf/redirect.rst

-- 
2.35.3

