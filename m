Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38EDC6CB2DE
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 02:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjC1Arz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 20:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjC1Arx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 20:47:53 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370812137
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 17:47:51 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id ek18so43206964edb.6
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 17:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679964470;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZlMEQqkZ8WIbjo0f8wWnbRjk0VBkFmWqK5G+qlhpgUA=;
        b=qI/ZlfHQG2UomIP+gPzUyNKvlGkxOMgS8FF5B+2KHqYzSCeFint0BAVOlRkxLc63Vy
         s5Kg7vufxs1ALaZTA1B8PwGf3wd00UzuarsGjViyJhj37nOxo1EAi4DUgXnDB3x7Skrd
         GzbrLxMMVyoXpEcBRGsUrgptygcRHjuvBFVrNrKt/JB5tO6UKy0pp96Njv2ctssDwtdu
         DRFA5orkItQOB3iprnuri6eBa6m6UBBfhWVWf2d70UAJVj5cYoUBHaNDYya9FENsn0K3
         5bD9MNxOiz5DHQMgzoSobJqclNGguCkygNumW4ybNgf+ug9/bjGiTkqqIMA05WxDsFjI
         uQ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679964470;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZlMEQqkZ8WIbjo0f8wWnbRjk0VBkFmWqK5G+qlhpgUA=;
        b=yd65Rx4Zr15Cq0inGtorIM1bdcb+jg01WI1rRjtF6ftFrTt6GU8wny//YX2LKKJrxl
         01afRx9AR9/mPKcdAf4y3ZF+jZ4eS/vZU4PFdfnDth7JTtryQPf1w+MgpK1E1n0+reyC
         p/3LCVwpDXenTUT3DZEYMxcAGWwtqVpjdJL6NhJln2jeTIbyBOrCkmO5p8OYeQ34u0/2
         XkYYCuKvUKgKXTmaEesvn6mKpKI8xirtwqGhPWvptB+axXZsSuUa8+a5EFJG4NVob7EI
         /Hd1O53mqGRdIvfh/hJpvVcEGRCqjiXbwpa+THDtZ5fbglhJZ7dUKUDPgFjO28Ba81WN
         jQDA==
X-Gm-Message-State: AAQBX9f6J6Ky/kXyv8AGChMD80Rmg1Mbd4mr2oN/mud0mXF6fATAQ96E
        8poOvmYDHm1dzdu8hnLPq3bwHRE2Yz2QlA==
X-Google-Smtp-Source: AKy350Y1eO0zj8UMUVD6wMGgk3iuocZzQ9Wjad15EgsSUnkyuPTp7aVGsasTlPy/B44+lFrjXFk71w==
X-Received: by 2002:a17:907:7788:b0:932:c1e2:9984 with SMTP id ky8-20020a170907778800b00932c1e29984mr14014926ejc.58.1679964470074;
        Mon, 27 Mar 2023 17:47:50 -0700 (PDT)
Received: from bigfoot.. (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id xc1-20020a170907074100b0093de5b42856sm5560175ejb.119.2023.03.27.17.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 17:47:49 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        kernel-team@fb.com, yhs@fb.com, james.hilliard1@gmail.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 0/2] Fix double-free when linker processes empty sections
Date:   Tue, 28 Mar 2023 03:47:36 +0300
Message-Id: <20230328004738.381898-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fixes double-free error in linker.c:bpf_linker__free() caused by
realloc(..., 0) call in linker.c:extend_sec() (such a call "frees"
memory every second time :). The error is triggered when object files
with empty sections of the same name are processed by linker.

- The first patch extends progs/linked_funcs[12].c to trigger the
  error upon tests compilation;
- The second patch contains detailed description of the error, fix and
  appropriate attributions.

Eduard Zingerman (2):
  selftests/bpf: Test if bpftool linker handles empty sections
  libbpf: Fix double-free when linker processes empty sections

 tools/lib/bpf/linker.c                            | 14 +++++++++++++-
 tools/testing/selftests/bpf/progs/linked_funcs1.c |  3 +++
 tools/testing/selftests/bpf/progs/linked_funcs2.c |  3 +++
 3 files changed, 19 insertions(+), 1 deletion(-)

-- 
2.40.0

