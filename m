Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07CF446B50
	for <lists+bpf@lfdr.de>; Sat,  6 Nov 2021 00:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbhKEXp2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Nov 2021 19:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbhKEXp1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Nov 2021 19:45:27 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A709CC061570
        for <bpf@vger.kernel.org>; Fri,  5 Nov 2021 16:42:47 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id b13so12039806plg.2
        for <bpf@vger.kernel.org>; Fri, 05 Nov 2021 16:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cUKXkaITkLUMJ/sMokqY/X0RYPL5P2/dB9bmwM8eQaE=;
        b=LPcOaV1lE5klSG2IbmqLwSyNV7thIUIXubjgpmi0GprfdoXurk+lMII6sny3ZNj9we
         cMHsNolfseUtGVhoDZfnaSSVCIgQmlG62Gih5+urD9missywnNqUWYB1WJgdmVYB1c35
         46ZGJefJ/HtBQ7rzL6uH0VZk0v5ZQz4Lqx8H6mV0zQ8+1oJFHpkTpjssRu15sitKIve4
         2/xFrdE11zggLSUBUhT8lEEKFpCTRaSOheQNN2Rrl7qmfEHUIYWj1FrzpYbyqgZSbq5q
         UGkRpzgoGdVzs1oKyu0UNXtcMRHkaLqOzTxCf86dx7iPNrrUuF2wE7MybLRsnYzwoYoD
         QZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cUKXkaITkLUMJ/sMokqY/X0RYPL5P2/dB9bmwM8eQaE=;
        b=pUuQZ/f+L924nJKdQDmWzTLMOy58y2RGC2AAget6dolTTpH201RCcpw+qcTiD0vc7x
         VeKLorh1/y/1ASpU+m+TVixciGFZCBhhOmS/1hgY4qgjpcDns6tbz5/S7jCFwYDdHNT9
         zLS7uGmMEihOJKE+Ml4RvAjtcfF5lMQXNpUxlr6BtERiYdsGN1RRYNjbjsyRyoi6CRUC
         0dikhE+RZF0DeDeOnAmovUnUJkgJi933cwIsE7e2Vhr2/9sR8T0ikB+tMJyTPDitwxA0
         Kye/Cromp0KEJBtWvFksjZfGs7WgQ6zf7i6/0LNXdxsdt5MRmiWx+nBFulFFBjZ1czmc
         SKBg==
X-Gm-Message-State: AOAM533Cf5lW4rtcx7OzIII+/13j3wDPmcl09rwdztW40ceuxUsEViU2
        zAUjWspaJ5dXEEhwYrIrQBmZ9rViUxS/dw==
X-Google-Smtp-Source: ABdhPJx5DYTC+fzrxZ/l+MxB0OUI3P45GhaB08SOJ01Npn9CnPcys3vl0sBUkGYYKVPwLDBvlKcfSw==
X-Received: by 2002:a17:90b:1c0b:: with SMTP id oc11mr33956765pjb.237.1636155766634;
        Fri, 05 Nov 2021 16:42:46 -0700 (PDT)
Received: from localhost ([2405:201:6014:d916:31fc:9e49:a605:b093])
        by smtp.gmail.com with ESMTPSA id k4sm7110667pjl.20.2021.11.05.16.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 16:42:46 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next v1 0/6] Change bpftool, libbpf, selftests to force GNU89 mode
Date:   Sat,  6 Nov 2021 05:12:37 +0530
Message-Id: <20211105234243.390179-1-memxor@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1344; h=from:subject; bh=2qofjtrDLpKv/hJiTi7fkyG2HqwgkbjNKYe+MKtngfY=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBhhb9AX6qb2h8vCW6v9MEA8E0dhP48WR/ZzXlgXzO3 yaPntsaJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYYW/QAAKCRBM4MiGSL8RynPxD/ 9OkjMqMPoAsnBP9trcRe+gpHGYAOGW40t4hhKT5+/qya3l7uZlGkhXt+TDJGVKq8zbbYV1eixRJNpa qB9xlfcamiIFI9s1TpOdcH5iuHMJlgefliZZxkcBHMvoeHkVKuU8k6cnmTLZxBCjTT2LpJMXNiO8xD p/HlvTVECxcEGRHVkeHP47rvKpmFcvfwQl5UGZP3/bMIfOCqvbyXfvJEK1Zq2jCFu2OmNg7ifunwUh PQrOshE5VGINmc1YQ9xtOaboQ19Q34esMQ17dgPgo3w4u8d/CZcqsycN4cF5XpIF8h/18IlagHeSrf 2cZPepWiIgNpVTXC6ErgwsndgHHn/n7gYmOv0wcYtqHSuV3NUwskKT7VY1p1tgwPSAE/hg7RhouS1n ESskV3yxRBSBQJZt7IYB+I+D5GfsfX7Z6IqL45+HG4CuGGAh071lo6HAWU1pJ6w+qDTnfu+mvm7737 AYKkyOP6vy/V1w7H8aUYqERzUFAELBuTtShCo8pACqu8loa3ifHgMR7b9dgiktgQF8KA5n0ZxWFUEJ AobmuNro2Y+phK9jd3veD+OvyClt/vZXchrf68y1mJT8mkLPiX2w9JkhNX/GjgySD2tFI3ugGEJrX8 ekv/8quBoDNs8V5a4vzXcTFd2x0kQwzHbShUZefFUQ2lLWQ++pPPClp5Xrww==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix any remaining instances that fail the build in this mode.  For selftests, we
also need to separate CXXFLAGS from CFLAGS, since adding it to CFLAGS simply
would generate a warning when used with g++.

This also cherry-picks Andrii's patch to fix the instance in libbpf. Also tested
introducing new invalid usage of C99 features.

Andrii Nakryiko (1):
  libbpf: fix non-C89 loop variable declaration in gen_loader.c

Kumar Kartikeya Dwivedi (5):
  bpftool: Compile using -std=gnu89
  libbpf: Compile using -std=gnu89
  selftests/bpf: Fix non-C89 loop variable declaration instances
  selftests/bpf: Switch to non-unicode character in output
  selftests/bpf: Compile using -std=gnu89

 tools/bpf/bpftool/Makefile                           | 2 +-
 tools/lib/bpf/Makefile                               | 1 +
 tools/lib/bpf/gen_loader.c                           | 3 ++-
 tools/testing/selftests/bpf/Makefile                 | 5 ++++-
 tools/testing/selftests/bpf/bench.c                  | 6 +++---
 tools/testing/selftests/bpf/prog_tests/d_path.c      | 4 ++--
 tools/testing/selftests/bpf/prog_tests/timer_mim.c   | 6 +++---
 tools/testing/selftests/bpf/prog_tests/xdp_bonding.c | 4 ++--
 tools/testing/selftests/bpf/test_progs.c             | 2 +-
 9 files changed, 19 insertions(+), 14 deletions(-)

-- 
2.33.1

