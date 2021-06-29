Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7043B7815
	for <lists+bpf@lfdr.de>; Tue, 29 Jun 2021 20:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235318AbhF2S6q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Jun 2021 14:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234139AbhF2S6p (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Jun 2021 14:58:45 -0400
Received: from mail-oi1-x264.google.com (mail-oi1-x264.google.com [IPv6:2607:f8b0:4864:20::264])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633F7C061760
        for <bpf@vger.kernel.org>; Tue, 29 Jun 2021 11:56:17 -0700 (PDT)
Received: by mail-oi1-x264.google.com with SMTP id a133so25194054oib.13
        for <bpf@vger.kernel.org>; Tue, 29 Jun 2021 11:56:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:dkim-signature:from:to:cc:subject:date
         :message-id:mime-version:content-transfer-encoding;
        bh=EuO7VyvmBnndAIGfOtS2q0Ly0UUF+dp3H72/CZ+9zNg=;
        b=t59WO8rXv3ngLHeiTqc4u7aEHKRGB89m7fklzNDObvTlQk8Swtzk3H9smljLljjl9v
         v1TyCUT2SuOlcmo9zIjVMnKxSms9mculTit+FnnoK2n8rYNkEKJf0vtVzUAZ40mzHUtr
         qfqlUPg3KpxFTmtnfuN12u2sZAmr0luo9GQ4yiKrMnnXMZ9kNfN7CStovR8MZsPxgRfZ
         69UlhahqO+Trl/sYkysAbcrrMG1ZIpkLmeNfpkRcpoWdfvW9WWR2nGJvH8Lt1cf1N7a2
         ee5cW4h4/AItqssjje9LQ3sR6bDY7XTM6PyEyK/P10vV3sdR7D3PPvoUKHZo8GG9mB8L
         Tj6A==
X-Gm-Message-State: AOAM532TR6piAov2UIwZ7L5Q2sIkuiw/NJ0I4wEFEvxjtXmJJxCz9ag+
        aQDw8SJgbWTlIURF3YJ8YNwV6oGvnAnUgwTBg1rQ/M3qHAvtbA==
X-Google-Smtp-Source: ABdhPJzUhpMIcooVghfk8CJME3OsfIwxFqnoLW/Za79GuHJhO77hdXC++1Yn46/CKCMWC/D44znP0y/HdFHD
X-Received: by 2002:a05:6808:1309:: with SMTP id y9mr238283oiv.112.1624992976469;
        Tue, 29 Jun 2021 11:56:16 -0700 (PDT)
Received: from restore.menlosecurity.com ([13.56.32.60])
        by smtp-relay.gmail.com with ESMTPS id n13sm6178740ooo.16.2021.06.29.11.56.15
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jun 2021 11:56:16 -0700 (PDT)
X-Relaying-Domain: menlosecurity.com
Received: from safemail-prod-02790022cr-re.menlosecurity.com (13.56.32.61)
    by restore.menlosecurity.com (13.56.32.60)
    with SMTP id ae40ebd0-d90b-11eb-9530-c7a89e3d05f0;
    Tue, 29 Jun 2021 18:56:16 GMT
Received: from mail-pj1-f72.google.com (209.85.216.72)
    by safemail-prod-02790022cr-re.menlosecurity.com (13.56.32.61)
    with SMTP id ae40ebd0-d90b-11eb-9530-c7a89e3d05f0;
    Tue, 29 Jun 2021 18:56:16 GMT
Received: by mail-pj1-f72.google.com with SMTP id j8-20020a17090a8408b02901651fe80217so1934351pjn.1
        for <bpf@vger.kernel.org>; Tue, 29 Jun 2021 11:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=menlosecurity.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EuO7VyvmBnndAIGfOtS2q0Ly0UUF+dp3H72/CZ+9zNg=;
        b=HsGZTM1SZNm63JqdN0ZIR8gyV/PlgyNqBCWViItW45dYS36CsZzhi7+v/QPFuW5NGq
         yLt5TZsKoTw2E6cD4mfggutH4AlXqmM8txvhb5Or73B+ZFjkateihx/Xg4chAjDWqlT0
         7SFIY/5854uqWFnun/pi+N0/UUrS8I5x4yaqQ=
X-Received: by 2002:a17:903:1d0:b029:118:307e:a9e1 with SMTP id e16-20020a17090301d0b0290118307ea9e1mr28595478plh.76.1624992974874;
        Tue, 29 Jun 2021 11:56:14 -0700 (PDT)
X-Received: by 2002:a17:903:1d0:b029:118:307e:a9e1 with SMTP id e16-20020a17090301d0b0290118307ea9e1mr28595468plh.76.1624992974665;
        Tue, 29 Jun 2021 11:56:14 -0700 (PDT)
Received: from localhost.localdomain ([12.219.129.130])
        by smtp.googlemail.com with ESMTPSA id t14sm19641260pfe.45.2021.06.29.11.56.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jun 2021 11:56:14 -0700 (PDT)
From:   Rumen Telbizov <rumen.telbizov@menlosecurity.com>
To:     bpf@vger.kernel.org
Cc:     dsahern@gmail.com,
        Rumen Telbizov <rumen.telbizov@menlosecurity.com>
Subject: [PATCH 0/3] Add support for fwmark to bpf_fib_lookup
Date:   Tue, 29 Jun 2021 11:55:34 -0700
Message-Id: <20210629185537.78008-1-rumen.telbizov@menlosecurity.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add support for fwmark to bpf_fib_lookup.

Patch 1: adds the support to the uapi and updates the lookup helper.
Patch 2: copies the uapi change to the tools directory.
Patch 3: adds test cases.

Rumen Telbizov (3):
  bpf: Add support for mark with bpf_fib_lookup
  tools: Update bpf header
  selftests: Add selftests for fwmark support in bpf_fib_lookup

 include/uapi/linux/bpf.h                      |  16 +-
 net/core/filter.c                             |   4 +-
 tools/include/uapi/linux/bpf.h                |  16 +-
 tools/testing/selftests/bpf/Makefile          |   1 +
 .../selftests/bpf/progs/test_bpf_fib_lookup.c | 135 ++++++++++++++
 .../selftests/bpf/test_bpf_fib_lookup.sh      | 166 ++++++++++++++++++
 6 files changed, 332 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_bpf_fib_lookup.c
 create mode 100755 tools/testing/selftests/bpf/test_bpf_fib_lookup.sh

-- 
2.30.1 (Apple Git-130)

