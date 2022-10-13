Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5E05FD7AA
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 12:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiJMKQE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Oct 2022 06:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJMKQD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Oct 2022 06:16:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F18EA6AE
        for <bpf@vger.kernel.org>; Thu, 13 Oct 2022 03:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665656161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=h1cObQ2s1xR5ZeaqLWVHbxy0BrP3z3LZ2+yRklnqRvk=;
        b=ch6j2+Hsm4XPbFKdhPjJZ7fhPD/XfxGGgOO3wMFegStVlw2Y83QdF1E1YVEZfJ1KtkB8RT
        HOAef4yqaWpXRl7ojsJL5bcvMgQLV1B3zixxfVlTzIxWMOniqqiW/BUcz5/OiYHwQR+WbK
        WIlBCGu544tn63HsC3qtXI/eTrMYWQI=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-584-zVmJuU41Onyxi4Su50ZPkg-1; Thu, 13 Oct 2022 06:16:00 -0400
X-MC-Unique: zVmJuU41Onyxi4Su50ZPkg-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-13234741239so885237fac.7
        for <bpf@vger.kernel.org>; Thu, 13 Oct 2022 03:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h1cObQ2s1xR5ZeaqLWVHbxy0BrP3z3LZ2+yRklnqRvk=;
        b=C4BI9MolYxMo2CjdkxBl6W/zyZC5VQVdQ2SfrTkzQLBKjdGYY3q5RoensEyeGhIDMx
         NRbwK7DTwVkFSXIG2rWLzRyUDwvSVdcUZ2gwQYywb1dpA+UpWeNR4+Cz4EWC5H2k4Jox
         R7J+DcW0FxDhq3Rp2a9OFiedEvoe4LUNXEn8vJyuDqvUsP6cMWbCpjjkip+y+YBPDTnc
         z7m3gKxdTKiygBXtBsFooYLjUwxw0pIWPcMJ9O4q9d4lu7eSDRaUHKJO6QXrQX6y1rhC
         XCRWRhZcbz+xoXeMTOH/G0Wso9xXuqO0XKQgXwuv78/ODUarhOcrdtiO1WKwNc07SKVg
         GRlA==
X-Gm-Message-State: ACrzQf0BKlmIcF8hulPhr7qvq0JgiL3UmbPaX49+GxS6MJ7KmAxtURaJ
        4N7ZcHNqY54IWAuK78PhQ6dCkzPrA7xjAYRGf6OYX2BJrTsFBunPSidtu3G4rBzuKyWCS4qtdvO
        KsBu9MGi19fkeHla8jcSQE3p57jw02yTNv6wBJRVUZHyl0ImCT5E3WEm7NeEGylM=
X-Received: by 2002:a05:6808:1513:b0:354:f6d6:2015 with SMTP id u19-20020a056808151300b00354f6d62015mr2173384oiw.18.1665656159378;
        Thu, 13 Oct 2022 03:15:59 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5Wlx3426Um6Yto4xX93+FqYjwG4/Vl5PILgVndKDc7GhdaqOhvp5FTBE7avNS0UTRrE2wFGw==
X-Received: by 2002:a05:6808:1513:b0:354:f6d6:2015 with SMTP id u19-20020a056808151300b00354f6d62015mr2173373oiw.18.1665656158992;
        Thu, 13 Oct 2022 03:15:58 -0700 (PDT)
Received: from nfvsdn-06.testing.baremetal.edge-sites.net (nat-pool-232-132.redhat.com. [66.187.232.132])
        by smtp.gmail.com with ESMTPSA id f187-20020aca38c4000000b00354732338desm5034605oia.17.2022.10.13.03.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 03:15:58 -0700 (PDT)
From:   mtahhan@redhat.com
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Maryam Tahhan <mtahhan@redhat.com>
Subject: [PATCH bpf-next v2 0/1] doc: DEVMAPs and XDP_REDIRECT
Date:   Thu, 13 Oct 2022 07:11:28 -0400
Message-Id: <20221013111129.401325-1-mtahhan@redhat.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

v1->v2:
- Separate xdp_redirect documentation to its own file.
- Clean up and simplify examples and usage function descriptions.

Maryam Tahhan (1):
  doc: DEVMAPs and XDP_REDIRECT

 Documentation/bpf/index.rst      |   1 +
 Documentation/bpf/map_devmap.rst | 192 +++++++++++++++++++++++++++++++
 Documentation/bpf/redirect.rst   |  46 ++++++++
 3 files changed, 239 insertions(+)
 create mode 100644 Documentation/bpf/map_devmap.rst
 create mode 100644 Documentation/bpf/redirect.rst

-- 
2.35.3

