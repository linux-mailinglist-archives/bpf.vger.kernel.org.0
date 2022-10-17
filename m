Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0375600953
	for <lists+bpf@lfdr.de>; Mon, 17 Oct 2022 10:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiJQIxR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Oct 2022 04:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiJQIxC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Oct 2022 04:53:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6272717E05
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 01:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665996756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Lz76llnI70u7uCZcTOSr/aib1axFYq6vl4LNEDDUrLw=;
        b=CaSdIzYWnPtbw1V1tf//WfjedmnNPM580NtWAFJukyZ0ST3c4DQgWxIdxnQYl6YDFKnnbn
        +2B5hjRUWnB+YAJmTapXbXS2C3AvI6E3mMfJ2GJZWr1PoGw/zuj1DQ3YMmgqpJvVIDpaIz
        Mb0/+xHN0PdwKQRdF+S6OmC4oLTYe4c=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-374-sc2wmUpBOAOe5umHekuITw-1; Mon, 17 Oct 2022 04:52:34 -0400
X-MC-Unique: sc2wmUpBOAOe5umHekuITw-1
Received: by mail-qk1-f200.google.com with SMTP id bq17-20020a05620a469100b006eeb0bbe02bso8989258qkb.5
        for <bpf@vger.kernel.org>; Mon, 17 Oct 2022 01:52:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lz76llnI70u7uCZcTOSr/aib1axFYq6vl4LNEDDUrLw=;
        b=zQkqFkMjUlKYJvNwNwY9aESHhjarwTzefWImgW02ST072HXAbcv7qPt4+A23Zvu0pt
         MyivOkimb0oZTJo8JAxQhytc6voKiFEv/bOgU2HpG+tPZWBAQ6SmUM2HRQoLIRHNzyMN
         1C2QY0e0FdDaMkywZtosl6BbMxRzswQ83g76NvCbkaDJD+3/1tBaf1/sJNvwnC89ZDWt
         UX6LFrd6U9W9Ou9Y+hgUcmudtHkEVtDZ+lsFGUM9vGcrvyEuwP5gnjWhtU7jYOnjjOEB
         zvLyTudsohPpdV8rMrLzJlSaSXAuxkpzATDNrgdPfoCs7L7ePv5DxeVH4rdAU6D4xOGx
         w0iw==
X-Gm-Message-State: ACrzQf0Zke0n712pKOk67bs+XmYRfOqr92gLJp8Z9o9V5bEp63Zy3hRg
        G40V0dAUdEi/9y5Blj30Urjjow11vc+7l+L8uXq5STpA1eErX6eC1TPkjaCYu9bDdMyKAY6Xz74
        BU2Pj3GqmMMpxIYx5z/KZfTCK0dvSzNUPIIxNwiwTmHcuF3GnXsiXzk1lzJj7GY0=
X-Received: by 2002:a37:ef02:0:b0:6e4:9fd5:ba76 with SMTP id j2-20020a37ef02000000b006e49fd5ba76mr6583933qkk.405.1665996754295;
        Mon, 17 Oct 2022 01:52:34 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7HH6prC3VABzVT3B7/GBsFSwRWO98Nge7dCJway0voYUGMXVEPtHR8dKjX8gR77ZPLBhj8Ig==
X-Received: by 2002:a37:ef02:0:b0:6e4:9fd5:ba76 with SMTP id j2-20020a37ef02000000b006e49fd5ba76mr6583924qkk.405.1665996754046;
        Mon, 17 Oct 2022 01:52:34 -0700 (PDT)
Received: from nfvsdn-06.testing.baremetal.edge-sites.net (nat-pool-232-132.redhat.com. [66.187.232.132])
        by smtp.gmail.com with ESMTPSA id a20-20020a05622a065400b0039853b7b771sm7571591qtb.80.2022.10.17.01.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 01:52:33 -0700 (PDT)
From:   mtahhan@redhat.com
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     Maryam Tahhan <mtahhan@redhat.com>
Subject: [PATCH bpf-next v3 0/1] doc: DEVMAPs and XDP_REDIRECT 
Date:   Mon, 17 Oct 2022 05:47:52 -0400
Message-Id: <20221017094753.1564273-1-mtahhan@redhat.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

v2->v3:
- Fixed indentations in usage section to exclude non note text.
- Replace links to selftest with actual paths.

v1->v2:
- Separate xdp_redirect documentation to its own file.
- Clean up and simplify examples and usage function descriptions.

Maryam Tahhan (1):
  doc: DEVMAPs and XDP_REDIRECT

 Documentation/bpf/index.rst      |   1 +
 Documentation/bpf/map_devmap.rst | 189 +++++++++++++++++++++++++++++++
 Documentation/bpf/redirect.rst   |  46 ++++++++
 3 files changed, 236 insertions(+)
 create mode 100644 Documentation/bpf/map_devmap.rst
 create mode 100644 Documentation/bpf/redirect.rst

-- 
2.35.3

