Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3767262454D
	for <lists+bpf@lfdr.de>; Thu, 10 Nov 2022 16:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiKJPPN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Nov 2022 10:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiKJPPM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Nov 2022 10:15:12 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7998831216
        for <bpf@vger.kernel.org>; Thu, 10 Nov 2022 07:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668093253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=zEvplYuwssLJ3t9LRCQjT4FvP3g4vYYyMhE2+Vd/Jhg=;
        b=Ga0gkv8AayPlb5Abmj8q3yjqb2HE21IS2xzrfqeOO1tfH/hdcmsW/U1GpZ5U8TvoqkhDFK
        MjJPtxs8qTmHrSUy89upojFupSGa1naYZFk5c2hin3n3QY+WyFXt4ycvSmTIYHIRWJuRwU
        4qTWjRY4XBlX4olCE3VMW5UtliSQizY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-322-tgG83INzP3eKUsnfIKVYAg-1; Thu, 10 Nov 2022 10:14:11 -0500
X-MC-Unique: tgG83INzP3eKUsnfIKVYAg-1
Received: by mail-qk1-f197.google.com with SMTP id bm2-20020a05620a198200b006fa6eeee4a9so2166137qkb.14
        for <bpf@vger.kernel.org>; Thu, 10 Nov 2022 07:14:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zEvplYuwssLJ3t9LRCQjT4FvP3g4vYYyMhE2+Vd/Jhg=;
        b=Xcx2vWGGIPNReRXB5hCyzl9wfLKD9dn98cKECWcBjUQfSSfvBOuzIJSBcAGRIe4aU2
         hduDaYgfY4V5rzS0jhcjCX2i+6BjDoJioyTiCd4VwyYgxqvROLncFUzL6lwB1Rr8LpYW
         R/T5mOgSwCwGs05o9Xl9jlsk/glNCjGmH4+ItWdHXQeSZ7hMumh1uL1yooDPdzRAHo3c
         r145zdvx3eYF9fLNfpynxBLco79SaHUovQCWWDmX4ObG5GbYP/ycjHVmt+jG3vmi6O7t
         hqT9o84GJ8AoEjXLOubDA1j+OQ2kK64hK+14U5Vzcmdob3W72Szfoei/Jo/zM5rVs9TF
         Ofww==
X-Gm-Message-State: ACrzQf1rBMad7IugMnHdZSkvy1Mxs7041Q2h5LER0RLwLVXzJ1MNu4XR
        wJkiwpDdkNPStRch7rnvSHgetEM/ehRVryfj/L7Ochp3XM5bzsXLix1rv5mwNckrdssN2i7+I0C
        Sla6kSQ30IG5wJGX9D2uN4mOr5lbAdv8xyK/7Y5bEG90kFQPKx0nRZMn53Qv//ds=
X-Received: by 2002:a05:620a:13db:b0:6fa:28c5:e06 with SMTP id g27-20020a05620a13db00b006fa28c50e06mr43421389qkl.629.1668093247128;
        Thu, 10 Nov 2022 07:14:07 -0800 (PST)
X-Google-Smtp-Source: AMsMyM6SrgJUuJzXrqbA4GxWXofdLpOydoJ4P2uTKkpP4SreDc2IjZepp/HIqPuhN2wzy4WK+ZYaRw==
X-Received: by 2002:a05:620a:13db:b0:6fa:28c5:e06 with SMTP id g27-20020a05620a13db00b006fa28c50e06mr43421357qkl.629.1668093246786;
        Thu, 10 Nov 2022 07:14:06 -0800 (PST)
Received: from nfvsdn-06.redhat.com (nat-pool-232-132.redhat.com. [66.187.232.132])
        by smtp.gmail.com with ESMTPSA id fg26-20020a05622a581a00b00399b73d06f0sm11320703qtb.38.2022.11.10.07.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 07:14:06 -0800 (PST)
From:   mtahhan@redhat.com
To:     bpf@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     jbrouer@redhat.com, thoiland@redhat.com, donhunte@redhat.com,
        yhs@meta.com, Maryam Tahhan <mtahhan@redhat.com>
Subject: [PATCH bpf-next v8 0/1] doc: DEVMAPs and XDP_REDIRECT
Date:   Thu, 10 Nov 2022 11:08:17 -0500
Message-Id: <20221110160818.1053910-1-mtahhan@redhat.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Type: text/plain; charset=y
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

v7->v8:
- Updated multicast to use description suggested by Toke Høiland-Jørgensen.

v6-v7:
- Got rid of unnecessary initializations in examples.

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
 Documentation/bpf/map_devmap.rst | 222 +++++++++++++++++++++++++++++++
 Documentation/bpf/redirect.rst   |  81 +++++++++++
 net/core/filter.c                |   8 +-
 4 files changed, 310 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/bpf/map_devmap.rst
 create mode 100644 Documentation/bpf/redirect.rst

--
2.35.3

