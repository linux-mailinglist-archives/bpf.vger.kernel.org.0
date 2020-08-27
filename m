Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C83254995
	for <lists+bpf@lfdr.de>; Thu, 27 Aug 2020 17:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgH0PiI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Aug 2020 11:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgH0PiG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Aug 2020 11:38:06 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59280C061264
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2020 08:38:06 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id c10so5320414edk.6
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2020 08:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EaIq8QbD2ygQvGuwiTmg8aFibFOGpbY5xHv3+1Dpy6o=;
        b=HlMSCE3Z4l+38hwc5qnPvhMSzJj13xiTeQl1ElixTmvd+yJ+VvciNuxDhH9GWOrSEJ
         9iinURJMiiQZQ7NzjeMyTEKqDyCPXyAyneJRvF1+bxwoA93G7U9Hf89gz96mUOivAMFz
         Myo/jW5gb2tuJwIi0NEFd3ZkbHPltKPwmxIiVJKe8NcnPyA/GS3bzt9g6CaNx5FvHHan
         wIy9QCpXW2dU7BLnP6n/9WesaAl7MYjbpnDKbhNHVNvKCE96IZTcTbQDbyP6Vfid6KYV
         apE9ZZDGw0BWVkKzXTphTZKuEdQqXKovf/qzrroeINbuAtxhmFbxYC+3wHelkmDR17Tf
         Sf+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EaIq8QbD2ygQvGuwiTmg8aFibFOGpbY5xHv3+1Dpy6o=;
        b=X1GQ76hzT5Ppp3cQY9kP4Yao8K7Uj4aEDE6ue5/4iOAL8GEguLeCqXJHVJNgKs7srF
         9BYrPHYUNoa3oQF9B2Vie5Y8lc5oc/29S2w4PXI4CeNxjiTgOUWisveUWvKFg7qK5JkI
         mwweW4VMsmLEjBklJrs8uYolcQ+tptu4hL9SJzWA5WHPIPcZmypq6AOZuPKMsRNEoq0U
         xthZLVi7F0O/KEQw+WdfmQxEOlwYsO0nSB/bHHkbXzqmfPGCJr7MlmfOdSMZR9dI8THW
         9K9zt1DuuZYzXzkuGKd9jawbBk+dm+J8Jxu7jEsWsJ2HyeqGF+lFnehdHL+XwIs3TlKy
         vxTg==
X-Gm-Message-State: AOAM533/wVa++EFLkEKFzBSOhAgCThBnjl3suG5fUbsu0dRE7pJO8/6i
        3KyElHftIukKAf0hCnVOl9Qy1Q==
X-Google-Smtp-Source: ABdhPJweOLHgm2IcaKNvyhEJjf+L1osKvvQTcQ1KXX4Zd+bb0sb3kgJogL3WHbM+JJzJC8kbv0BJUQ==
X-Received: by 2002:aa7:d6d6:: with SMTP id x22mr21485303edr.282.1598542684961;
        Thu, 27 Aug 2020 08:38:04 -0700 (PDT)
Received: from localhost.localdomain ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
        by smtp.gmail.com with ESMTPSA id i25sm1765616edt.1.2020.08.27.08.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 08:38:04 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, andriin@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [PATCH bpf-next 0/6] tools/bpftool: Fix cross and out-of-tree builds
Date:   Thu, 27 Aug 2020 17:36:24 +0200
Message-Id: <20200827153629.3820891-1-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A few fixes for cross-building bpftool and runqslower, to build for
example an arm64 bpftool on a x86 host machine and run it on an embedded
platform. Also fix out-of-tree build, allowing for example to use the
same source tree for different target architectures.

Patch 1 factors the HOST variables definitions. Patches 2 and 3 fix the
bpftool build and patches 4-6 fix the runqslower build. I also have some
fixes for the BPF selftests build which I'll send later.

Jean-Philippe Brucker (6):
  tools: Factor HOSTCC, HOSTLD, HOSTAR definitions
  tools/bpftool: Force clean of out-of-tree build
  tools/bpftool: Fix cross-build
  tools/runqslower: Use Makefile.include
  tools/runqslower: Enable out-of-tree build
  tools/runqslower: Build bpftool using HOSTCC

 tools/bpf/bpftool/Makefile        | 38 +++++++++++++----
 tools/bpf/resolve_btfids/Makefile |  9 ----
 tools/bpf/runqslower/Makefile     | 68 ++++++++++++++++++-------------
 tools/build/Makefile              |  4 --
 tools/objtool/Makefile            |  9 ----
 tools/perf/Makefile.perf          |  4 --
 tools/power/acpi/Makefile.config  |  1 -
 tools/scripts/Makefile.include    | 10 +++++
 8 files changed, 78 insertions(+), 65 deletions(-)

-- 
2.28.0

