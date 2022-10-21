Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FC8608084
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 23:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiJUVHe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 17:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiJUVHe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 17:07:34 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6739B2A1D9C
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 14:07:33 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id h185so3584575pgc.10
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 14:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jl9gRwzw7mJyH+iV+IR+fmUDtSW8bT8IBZ9io2IVodE=;
        b=aN1IjxXAslVBQyLMUDIBcF9SMj3vURxerxB+6eIvzasJ/wczb6uDFLgdWsX7RgZZUV
         QzAjqxcc/vgwTbRK1I89KFwEtNXdGx6/pZwmHI169YEUTBnbGEwFI8VoAqsif8F90qqX
         z8OoxppRdO5Tw2sJvZ9Y3klyN+Uj3MXhW/SoufBVSckCpYncBONVJy9zWBjQfr3bm7P9
         ZaijJ4wxDyf31oTPv3wW2rpxwZnXTJG77xMBqmSMbGlSNVR+c9mkO56bHiS2/BvV0jFd
         ovY60tj/UsVU9ij70WPms7nD6rfEe/dzSNOMqTJaPhLeJFMiF4JuXTGOfHesdi1f0vDL
         hO7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jl9gRwzw7mJyH+iV+IR+fmUDtSW8bT8IBZ9io2IVodE=;
        b=5CepeRamir4/QatF5yYqcXAHtwiN8unz4DnWj04Hh8Ux3Y121BU2dHspTAtDXhKbNm
         EItgXjw182ZsXjnqKjwnyliIyc+CnmdxdyxLvnLQIVlGUmbVOgr8KJ+JNEh/NiYOj+Ik
         /wiwEe1slRbIgsbajQdJKS7G6baiNECPFjuZI/sp4K+phjTA8YXgXcRjYYj5W7EkgCiT
         HdPLevYcR1VXzbn9Mmkn/uT6RkNHNmNZh9YHwoufmgZGEPzNUyu8Rb83oSFKFc/SeEkn
         dACcS1LLM8bO99/N0d3Bh9VD5am+zdRcUihZgOLOrnFqFXnlI7ZRLaS5w4hKdFbjKDWp
         TH/g==
X-Gm-Message-State: ACrzQf26t+b8ctdDlxT4Arz72skW5Bbks2Is4abi0goOXPOvEIaQtfsL
        5/wDtlmIn0sGDT8JShBXCYQ=
X-Google-Smtp-Source: AMsMyM40h51Two8IOff+VyhKOdIAlNY0frUvpOc9Fvbs6KbHk/2DVhcrxwMpfTnMltGJa0mxVKcsVw==
X-Received: by 2002:a63:5d50:0:b0:45f:f5c7:de9b with SMTP id o16-20020a635d50000000b0045ff5c7de9bmr17755567pgm.10.1666386452670;
        Fri, 21 Oct 2022 14:07:32 -0700 (PDT)
Received: from localhost (fwdproxy-prn-013.fbsv.net. [2a03:2880:ff:d::face:b00c])
        by smtp.gmail.com with ESMTPSA id b11-20020a1709027e0b00b00176b63535adsm15025283plm.260.2022.10.21.14.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 14:07:31 -0700 (PDT)
From:   Manu Bretelle <chantr4@gmail.com>
To:     chantr4@gmail.com, bpf@vger.kernel.org, andrii@kernel.org,
        mykolal@fb.com, daniel@iogearbox.net, martin.lau@linux.dev,
        yhs@fb.com
Subject: [PATCH bpf-next 0/4] Add support for aarch64 to selftests/bpf/vmtest.sh
Date:   Fri, 21 Oct 2022 14:06:57 -0700
Message-Id: <20221021210701.728135-1-chantr4@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patchset adds initial support for running BPF's vmtest on aarch64
architecture.
It includes a `config.aarch64` heavily based on `config.s390x`
Makes vmtest.sh handle aarch64 and set QEMU variables to values that
works on that arch.
Finally, it provides a DENYLIST.aarch64 that takes care of currently
broken tests on aarch64 so the vmtest run passes.

This was tested by running:

LLVM_STRIP=llvm-strip-16 CLANG=clang-16 \
    tools/testing/selftests/bpf/vmtest.sh  -- \
        ./test_progs -d \
            \"$(cat tools/testing/selftests/bpf/DENYLIST{,.aarch64} \
                | cut -d'#' -f1 \
                | sed -e 's/^[[:space:]]*//' \
                      -e 's/[[:space:]]*$//' \
                | tr -s '\n' ','\
            )\"

on an aarch64 host.

Manu Bretelle (4):
  selftests/bpf: Remove entries from config.s390x already present in
    config
  selftests/bpf: Add config.aarch64
  selftests/bpf: Update vmtests.sh to support aarch64
  selftests/bpf: Initial DENYLIST for aarch64

 tools/testing/selftests/bpf/DENYLIST.aarch64 |  81 +++++++++
 tools/testing/selftests/bpf/config.aarch64   | 181 +++++++++++++++++++
 tools/testing/selftests/bpf/config.s390x     |   3 -
 tools/testing/selftests/bpf/vmtest.sh        |   6 +
 4 files changed, 268 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/DENYLIST.aarch64
 create mode 100644 tools/testing/selftests/bpf/config.aarch64

-- 
2.30.2

