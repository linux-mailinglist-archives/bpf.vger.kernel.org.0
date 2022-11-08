Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97ADC6219DA
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 17:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbiKHQzQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 11:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbiKHQzO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 11:55:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427A82314A
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 08:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667926454;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fWBiQlvS1LnuRc8wZ5xGuWJrY9OP9xHPVPpIfrUrek0=;
        b=cYkkluy96u/aVEkba+6Mcu7LXgHscqUYGf9oImPTt4tHHfard5bh80vaFnt2yPiyGXlUvp
        2JXpKMcsE7khUT+Xu97A7rEh3yRh63avLJ7B2LOR8Bzo3sUmCzESSBV80agNs930ktIZ1O
        vmrgrvIy4+8QmKerHaoO5q5zJ4KswnI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-175-eGYPuMjbNSybhCa6v9eTPQ-1; Tue, 08 Nov 2022 11:54:13 -0500
X-MC-Unique: eGYPuMjbNSybhCa6v9eTPQ-1
Received: by mail-qt1-f199.google.com with SMTP id i4-20020ac813c4000000b003a5044a818cso10591765qtj.11
        for <bpf@vger.kernel.org>; Tue, 08 Nov 2022 08:54:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fWBiQlvS1LnuRc8wZ5xGuWJrY9OP9xHPVPpIfrUrek0=;
        b=Hcw3R5SUXT7DUSm21e43BcXLIouym2Uv8rRKgYnrJbDr3nqZvYCBgTn69Y/MkU+x7j
         ELB0IF0ejK87zGxQxMcL5u1OGIWvvNaatfJsf795oYsSm6IzsR7PnbdoZNTB7u11vZrj
         8SR0/pye+zU31DnLP8+7ozNIDlVt+cBFp7NkLsDVFEuyPGt7K+1DLIDUgGF+nkKmDPMM
         RLeLj2MeveUlRkLAae9K1JaytX5b2btGFS4jGCJOFTiuqnTgNqHmuHD2iNn4rdc51lLB
         Eg9ykF4QXNa2xx8MPj0s6dlwEY1zmTNQXvYl+Je36SIhJ5z6AIoVvufNog7C2vzyicjz
         2FQQ==
X-Gm-Message-State: ACrzQf3THqLZJZ11rByxg4tQOpubIhgB+C9QMi3a2w8nDEkXy0SmpcfO
        86Onk0V1k3ivkDgINQvn0zwlsYp6azEd85TBF9vOFNodYfIQ0BUMcvpE92gNxORQm0qJS7wr/g4
        a35S65nt/zlTOLiANzeYu6v793sGBW135vy4muZCnmdTbSPo0CWsDa3Vp7aQWqcw=
X-Received: by 2002:a05:6214:ca1:b0:4bb:9b8c:55a0 with SMTP id s1-20020a0562140ca100b004bb9b8c55a0mr50167728qvs.131.1667926452634;
        Tue, 08 Nov 2022 08:54:12 -0800 (PST)
X-Google-Smtp-Source: AMsMyM6imRg7+S75Tr0aMDtmz+GBQeGE9Vnw5XLwXictPazQh3fSVVVEpkMlIDXncyIlvJ6HQn1Akg==
X-Received: by 2002:a05:6214:ca1:b0:4bb:9b8c:55a0 with SMTP id s1-20020a0562140ca100b004bb9b8c55a0mr50167700qvs.131.1667926452332;
        Tue, 08 Nov 2022 08:54:12 -0800 (PST)
Received: from nfvsdn-06.testing.baremetal.edge-sites.net (nat-pool-232-132.redhat.com. [66.187.232.132])
        by smtp.gmail.com with ESMTPSA id h18-20020ac85852000000b003a57eb7f212sm7444579qth.10.2022.11.08.08.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 08:54:11 -0800 (PST)
From:   mtahhan@redhat.com
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     jbrouer@redhat.com, thoiland@redhat.com, donhunte@redhat.com,
        Maryam Tahhan <mtahhan@redhat.com>
Subject: [PATCH bpf-next v6 0/1] doc: DEVMAPs and XDP_REDIRECT 
Date:   Tue,  8 Nov 2022 12:48:32 -0500
Message-Id: <20221108174833.1106947-1-mtahhan@redhat.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
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

v5->v6:
- Separate Kernel BPF and userspace functions for devmaps.
- Include some packet/tracepoint debug info in the redirect
  documentation.

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
 Documentation/bpf/map_devmap.rst | 221 +++++++++++++++++++++++++++++++
 Documentation/bpf/redirect.rst   |  82 ++++++++++++
 net/core/filter.c                |   8 +-
 4 files changed, 310 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/bpf/map_devmap.rst
 create mode 100644 Documentation/bpf/redirect.rst

-- 
2.35.3

