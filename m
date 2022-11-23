Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A396D6355E2
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 10:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237583AbiKWJ0U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 04:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237666AbiKWJZr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 04:25:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DC6DC758B
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 01:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669195406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fc7BgEWK5CMEA7cvzcbtUcvqyz0msU0YsHhfcZmgv5E=;
        b=Yi09aouzx+ELkb4ev7qHCa2PScakfH8ffXwCQ9ojMEd5tlkhkFig4feq9pqnCE3EicHNgU
        uIxN7x4XxmWH3qLvDl9DlZ2Mn5MB8XKfhHlyIQm9Fxtgw0icyMA6uBKuSYkXV/xvJmUJnc
        7SyZQdgEgUCaL7jdpbtuPehCfpTNr+o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-79-POfIUpomOrmsZwpzb3OFgA-1; Wed, 23 Nov 2022 04:23:25 -0500
X-MC-Unique: POfIUpomOrmsZwpzb3OFgA-1
Received: by mail-wr1-f71.google.com with SMTP id c4-20020adfa304000000b00241e5b2c816so1028289wrb.21
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 01:23:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fc7BgEWK5CMEA7cvzcbtUcvqyz0msU0YsHhfcZmgv5E=;
        b=mEumZq0iMWe4Xz2imdTnP1kOvdbZo9s9br5JeXlz4zHCp5oGDFwob6oLgEMfK0Zik8
         J3hd47/E7RKRoRxGkiO+7Cs2NrR9QzZfQTDiDaQhteaZmiMji9ixtSaQvh+tyWbCKKqP
         OXK5UBUMDD5KysAshoG9/oCfxxUfYX830i0bAlDPK1wkz8B6KW+N9UMXCe9Yy9JZO76u
         5tGblL0g8DQaZnShNrEZ4auA66QhAGaqwkdLdJJrEhsQyiCuG8TRAQGzbKyhNIw9mady
         sw3IBafKRu9RUYEQZcQfJeHkc2pfdremcpt1RDG6zkXYX1brLXmPZsr0GGAK84KDEr7x
         byoQ==
X-Gm-Message-State: ANoB5pm2cLj4E5XJ3801rPfh0QhiIQ+xfo/pQr8d0a61GtNIZWxxAEyp
        Rf6xwlYRdOt5WRFUAtY0A30Q4/ouoFDonjPg9IqNIvWBbBvghdYt9XsGf+F6Azwubix95D8M/4+
        Ygx8RMCymnrOrCWSaVckLoAOIXJs09tAFSsYfY7oJ/fQrgGJajdnPK7zmTAMf22M=
X-Received: by 2002:a5d:6f16:0:b0:241:ce9e:77f4 with SMTP id ay22-20020a5d6f16000000b00241ce9e77f4mr10169724wrb.702.1669195403923;
        Wed, 23 Nov 2022 01:23:23 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7z2VrXjsysBH0iXTYYXz/WSU67Q88R3i470A/DqMdNYUBmV0ys7VxGm0nYMtjnJBSCXbC3Cg==
X-Received: by 2002:a5d:6f16:0:b0:241:ce9e:77f4 with SMTP id ay22-20020a5d6f16000000b00241ce9e77f4mr10169701wrb.702.1669195403636;
        Wed, 23 Nov 2022 01:23:23 -0800 (PST)
Received: from localhost.localdomain ([78.19.107.254])
        by smtp.gmail.com with ESMTPSA id w19-20020adfbad3000000b00241c6729c2bsm13048855wrg.26.2022.11.23.01.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 01:23:23 -0800 (PST)
From:   mtahhan@redhat.com
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     jbrouer@redhat.com, thoiland@redhat.com, donhunte@redhat.com,
        akiyks@gmail.com, Maryam Tahhan <mtahhan@redhat.com>
Subject: [PATCH bpf-next v3 0/2] docs: fix sphinx warnings for cpu+dev maps
Date:   Wed, 23 Nov 2022 09:23:19 +0000
Message-Id: <20221123092321.88558-1-mtahhan@redhat.com>
X-Mailer: git-send-email 2.34.1
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

Sphinx version >=3.1 warns about duplicate function declarations in the
CPUMAP and DEVMAP documentation. This is because the function name is the
same for Kernel and User space BPF progs but the parameters and return types
they take is what differs. This patch moves from using the ``c:function::``
directive to using the ``code-block:: c`` directive. The patches also fix
the indentation for the text associated with the "new" code block delcarations.
The missing support of c:namespace-push:: and c:namespace-pop:: directives by
helper scripts for kernel documentation prevents using the ``c:function::``
directive with proper namespacing.
---
v3:
- Update Sphinx version to 3.1.
- Add note about namespacing.

v2:
- Fix references to user space.
---
Maryam Tahhan (2):
  docs: fix sphinx warnings for cpumap
  docs: fix sphinx warnings for devmap

 Documentation/bpf/map_cpumap.rst | 56 +++++++++++++++-----------
 Documentation/bpf/map_devmap.rst | 68 ++++++++++++++++++++------------
 2 files changed, 76 insertions(+), 48 deletions(-)

--
2.34.1

