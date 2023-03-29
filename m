Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F556CD364
	for <lists+bpf@lfdr.de>; Wed, 29 Mar 2023 09:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjC2Hhp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Mar 2023 03:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjC2HhY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Mar 2023 03:37:24 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32EC610F
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 00:36:06 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id b20so59612234edd.1
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 00:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680075364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VxjlU9jDHgZk7lNFBnkyiA/WWSS0U8UO2pumIjE27KU=;
        b=NVe1Dt6TvyAuyxCYXEmjWsEpBeKszT3oCHrTMmg0tG25bngSZU6cmddvEemW+YtM3m
         IkS7xuFfkPbVvNLBAlDxvkdFFvAjKWd/a8W3Mebdwj6UYLmjRJY2uglYwzp6liCxXfEF
         2NhllH31F0OgB9tqUnKTk3q2OXMuKrTylP2mdJ3EcZYgbPsW3VtAd+X6svEB8gzpgcsk
         I5/R4TqQJUOySmJqDDKvvAMQvxsGoAZSPim/b1Yc1zW9LoUt/8wqU33H80wR8WCuzgEh
         oBexBT/M2GNatqZmPqnWHUunNbG7NLu0EOOpYAxbpt1dnW/vHXuA3+D+OlVLSGiwCZEd
         GgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680075364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VxjlU9jDHgZk7lNFBnkyiA/WWSS0U8UO2pumIjE27KU=;
        b=xs9SaLvQMTro5SdlQEtiWzJH0vJmNDvrOIMessxHh2kghdTmnFA1W8yhgs350C+xpi
         W+vCT/8FmYoiCeGJIlVwUxG6vhoVyEG+Wv36WykAn/91wVdWoQjDm1w+eq/I8Cy6lOW6
         M7NR9R3/lDaJzlZsE0JZeHxLRT1Uei75hv2ozxZS64835S/ylrY8yXRnbmxgcDvzP9F4
         5DcD2hxNFBPDRjmpcfBRbd7MffsvT1DuY0TZUPmKRgcyXZKUAhbjYvW5hiWuLPDn2kDT
         3L4wPSPSoK3yabt4MohMPHEg79cIlGTzirJfH3PBNp3qRTNioJ4uMnx1zAJ/+62Qddby
         4PrQ==
X-Gm-Message-State: AAQBX9dUIlTsUKqUJOGYlGSeOpjFnDlIPZOYXYaj/pcg3kpJLHS8b7yD
        JIHZXpGQ+SddcIds4anO5EuH3xlpQk6d0mj+SWU=
X-Google-Smtp-Source: AKy350bgEKsfogc5rF9gdtKhFnEOqlfC7j4xWlRAiYGqcIIPfSpWAGcPoqUy4oB/269t+iihccp8RQ==
X-Received: by 2002:a17:906:6b8b:b0:93f:9b68:a0f4 with SMTP id l11-20020a1709066b8b00b0093f9b68a0f4mr1481818ejr.26.1680075364064;
        Wed, 29 Mar 2023 00:36:04 -0700 (PDT)
Received: from localhost.localdomain ([45.35.56.2])
        by smtp.gmail.com with ESMTPSA id g10-20020a17090670ca00b0093b8c0952e4sm9719041ejk.219.2023.03.29.00.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 00:36:03 -0700 (PDT)
From:   Yixin Shen <bobankhshen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, song@kernel.org, yhs@fb.com,
        bobankhshen@gmail.com
Subject: [PATCH bpf-next v2 0/2] Allow BPF TCP CCs to write app_limited
Date:   Wed, 29 Mar 2023 07:35:56 +0000
Message-Id: <20230329073558.8136-1-bobankhshen@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This series allow BPF TCP CCs to write app_limited of struct
tcp_sock. A built-in CC or one from a kernel module is already
able to write to app_limited of struct tcp_sock. Until now,
a BPF CC doesn't have write access to this member of struct
tcp_sock.

v2:
 - Merge the test of writing app_limited into the test of
   writing sk_pacing. (Martin KaFai Lau)
 
Yixin Shen (2):
  bpf: allow a TCP CC to write app_limited
  selftests/bpf: test a BPF CC writing app_limited

 net/ipv4/bpf_tcp_ca.c                               |  3 +++
 .../selftests/bpf/progs/tcp_ca_write_sk_pacing.c    | 13 ++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

-- 
2.25.1

