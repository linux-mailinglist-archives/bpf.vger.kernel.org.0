Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9475550BF98
	for <lists+bpf@lfdr.de>; Fri, 22 Apr 2022 20:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiDVS04 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Apr 2022 14:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiDVS0x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Apr 2022 14:26:53 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591FADCAAA
        for <bpf@vger.kernel.org>; Fri, 22 Apr 2022 11:23:55 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id be20so3078010edb.12
        for <bpf@vger.kernel.org>; Fri, 22 Apr 2022 11:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JiJ2eTtUjZ0wseyJ7gTz6oNVQPfnalIfov1SgvTZStY=;
        b=MrxYpY3yzn30FZuAx8I9eJs5UXnFOpSAgCBh4DHReA4aE7P/OAy2hejG6Z0NrdkXMA
         VcZHASpjCZ2t3YGdGTIIFsho1wwYVK81VLxowDxOZNl2gTPAYTUL3BP3MVcuqeDS5C+F
         XAhyYn/1JKh2Iqt0x6F8gqGGX23/oD86parF/e/36IL2J3PvgKQkv8w0/bRy/gSay/Hq
         Ne1JS4AR0NcC5qr53Km+At6p+bpqv3jJ/x/xq+JiuVW2qPuxX0w0Kd5Sq3Yw0UYOceHq
         vHTR2S26EUYHe4vkO+GmNziYFo5kZFsfPYgflEICvB5sWLN5/dTEn94b+6iki2jGAE3f
         l+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JiJ2eTtUjZ0wseyJ7gTz6oNVQPfnalIfov1SgvTZStY=;
        b=HaC1nXQ24vzMfmw+Od/q3UHXAhidSqhPbBdrJLQl/JyjbUW/okS6HTIArPXiI/cK/g
         H6equ726ss5ehqpNRToYOOy7Q4M/lZaoge05/LxTt3lk7V9qouTGPfRgzP6BLrQ+KSz1
         buh97KZPkGF9wA5CB4V+sfyGRRKDF0Vj7nqhZi5jz9CViMvKMbA56MugdBI9xOFBI4P6
         SxPV2+wcA/fbqS4OGlNy1VmD8KNSyVSkms86eFa0RoiU/EoTIahPBWL3uBB2M+jjMjR2
         Uw2YHM5MN1sVexzUME0hi2ApxUYpO1ZXYZTp2cDV3GrOc9+kyPYNgj05b3yuNAugSbCk
         tBxQ==
X-Gm-Message-State: AOAM5319cPcfcNogKjyaaxwFajt1y4yJhcnLL1WVgDF+fDtByJ5mB0mu
        yMkBwHWFObds5lvkCRr7PKXEHGI0Yj/pQw==
X-Google-Smtp-Source: ABdhPJzJKz3V/wjyGmjxuQOdZgHFMw5st+pUoMC9zo5Mro0frewKIFn5F5Ae6ErtB/VAWi5DaKUq4Q==
X-Received: by 2002:a50:d087:0:b0:41d:7ea6:462a with SMTP id v7-20020a50d087000000b0041d7ea6462amr6297615edd.355.1650651821621;
        Fri, 22 Apr 2022 11:23:41 -0700 (PDT)
Received: from erthalion.local (dslb-178-005-225-126.178.005.pools.vodafone-ip.de. [178.5.225.126])
        by smtp.gmail.com with ESMTPSA id d11-20020a056402400b00b00423e5bdd6e3sm1152312eda.84.2022.04.22.11.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 11:23:41 -0700 (PDT)
From:   Dmitrii Dolgov <9erthalion6@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, yhs@fb.com, songliubraving@fb.com
Cc:     Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [RFC PATCH bpf-next 0/2] bpf: bpf link iterator
Date:   Fri, 22 Apr 2022 20:22:52 +0200
Message-Id: <20220422182254.13693-1-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bpf links seem to be one of the important structures for which no
iterator is provided. Such iterator could be useful in those cases when
generic 'task/file' is not suitable or better performance is needed.

The implementation is mostly copied from prog iterator, and I would like
to get any high-level feedback about what needs to be different or have
to be taken into account. As a side note, I would also appreciate if
someone could point me out to some guide about writing selftests for bpf
subsystem -- for some unclear reason I couldn't compile the test from
this changeset, and was testing it only manually with a custom test
program.

Dmitrii Dolgov (2):
  bpf: Add bpf_link iterator
  selftests/bpf: Add bpf_link test

 include/linux/bpf.h                           |   1 +
 kernel/bpf/Makefile                           |   2 +-
 kernel/bpf/link_iter.c                        | 107 ++++++++++++++++++
 kernel/bpf/syscall.c                          |  19 ++++
 .../selftests/bpf/prog_tests/bpf_iter.c       |  15 +++
 .../selftests/bpf/progs/bpf_iter_bpf_link.c   |  18 +++
 6 files changed, 161 insertions(+), 1 deletion(-)
 create mode 100644 kernel/bpf/link_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_bpf_link.c

-- 
2.32.0

