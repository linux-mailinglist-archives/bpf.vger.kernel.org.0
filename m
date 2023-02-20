Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCD769C6F9
	for <lists+bpf@lfdr.de>; Mon, 20 Feb 2023 09:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjBTIs5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Feb 2023 03:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjBTIs0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Feb 2023 03:48:26 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C573893C2;
        Mon, 20 Feb 2023 00:48:24 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id cp9so1723115pjb.0;
        Mon, 20 Feb 2023 00:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uYnkhQbWM4LZJsmgLPfHe7W3LYiU/dDbk2eSvNPNzZM=;
        b=h/BKAeytoo1Q2M46VZnM7+Cmzg6aaDbjJQNiFBlK7TE5qnMYP4Mt6oVh/rahd8Ypng
         H/gjxNc1XMPKh3P1BzquJJAjctmuC2eeykOvwmkAo5nK5XN8WJc1CepKxs5AePa6Ugpt
         7eW05dt8MhPxTZhvjOQVYXA6oqVXjfCrbVdF8PHsIXCFfGCGRAOcHXLcdW86zzOHahUL
         gFiDqdVUfMO3ybOzyKRgBBsTqNkaJf9D2++jn7gvOYzo06G7Brbrf3PkoWlkfDN+K1Qu
         p6g7GRRc18Pp6SpsomasmRYIwAK5F1EymBGExRNRUOD13nGT1QOTb4+2KPqcINlGIlF+
         76hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uYnkhQbWM4LZJsmgLPfHe7W3LYiU/dDbk2eSvNPNzZM=;
        b=S13nOKllKplDVBhzRURZHvFMaCaxWoQ7TqMIzCyG3QwmPP0QBXfw9LIzRNx5EtUfaG
         0o6h6QXOlVePzf7V9/EBpO7W3cLRbO/qAIwVUEV4hUEejiOU5PegSrjq2urvLb2KvPq/
         DZzicaTccSOurQ2y+bEnZZTslqofADyoRTLCi1AgaT6BMxYQ8WcCi1ZzLiMNWA6Um41k
         oMBZAnHdXisItpkO5D7UE/Q9EMUjGsykxeg29fSF09NIjuvOhg3MCAGK9htwl/73mzYV
         N3aoh2R6doaFkf1qjhJ4Qrdxrn1E1hZrZPa1oZhVWKWZkHjmCW2Or4qQ9hIlNn2/mWul
         Ufyg==
X-Gm-Message-State: AO0yUKVOIh2CsJFHYRLrWnnLOIgsU6fkqsl5a1JdYQ7Oz6dvAtxjdJlQ
        XL0Z1IkUQCVobX/p5UOj748=
X-Google-Smtp-Source: AK7set/yIHLQLlTuhm+v9tjWCZUfsPKRF5KOILAfTr08ukAB+nu18E0gDx8JVkAxPECMiSCYXrABhA==
X-Received: by 2002:a05:6a21:999a:b0:bc:bdb1:165a with SMTP id ve26-20020a056a21999a00b000bcbdb1165amr8356926pzb.39.1676882904163;
        Mon, 20 Feb 2023 00:48:24 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.21])
        by smtp.gmail.com with ESMTPSA id n11-20020a62e50b000000b00586fbbdf6e4sm7136378pff.34.2023.02.20.00.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 00:48:23 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To:     andrii.nakryiko@gmail.com, alan.maguire@oracle.com
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Subject: [PATCH bpf-next v2 0/3] libbpf: allow users to set kprobe/uprobe attach mode
Date:   Mon, 20 Feb 2023 16:47:08 +0800
Message-Id: <20230220084711.261642-1-imagedong@tencent.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Menglong Dong <imagedong@tencent.com>

By default, libbpf will attach the kprobe/uprobe eBPF program in the
latest mode that supported by kernel. In this series, we add the support
to let users manually attach kprobe/uprobe in legacy/perf/link mode in
the 1th patch.

And in the 2th patch, we split the testing 'attach_probe' into multi
subtests, as Andrii suggested.

In the 3th patch, we add the testings for loading kprobe/uprobe in
different mode.

Changes since v1:
- some small changes in the 1th patch, as Andrii suggested
- split 'attach_probe' into multi subtests

Menglong Dong (3):
  libbpf: add support to set kprobe/uprobe attach mode
  selftests/bpf: split test_attach_probe into multi subtests
  selftests/bpf: add test for legacy/perf kprobe/uprobe attach mode

 tools/lib/bpf/libbpf.c                        |  42 ++-
 tools/lib/bpf/libbpf.h                        |  31 +-
 .../selftests/bpf/prog_tests/attach_probe.c   | 283 ++++++++++++------
 .../bpf/progs/test_attach_kprobe_sleepable.c  |  23 ++
 .../selftests/bpf/progs/test_attach_probe.c   |  45 +--
 .../bpf/progs/test_attach_probe_manual.c      |  53 ++++
 6 files changed, 337 insertions(+), 140 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_attach_kprobe_sleepable.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_attach_probe_manual.c

-- 
2.39.0

