Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB524AC213
	for <lists+bpf@lfdr.de>; Mon,  7 Feb 2022 15:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343713AbiBGO46 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Feb 2022 09:56:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356063AbiBGObs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Feb 2022 09:31:48 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD3EC0401C1
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 06:31:47 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id p22-20020a17090adf9600b001b8783b2647so7515485pjv.5
        for <bpf@vger.kernel.org>; Mon, 07 Feb 2022 06:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dkZUSlduxLUNkOHP8pgyqH3yKqTS8fpj0WI791VKcBI=;
        b=pkTNjYdL37YggAhyKzUMllDeOoRypmZod/Q8vsDh1p4ZeqOsVjZ+2Ga+NKRwgqp3SQ
         aYqwcJzFfPQSztcClSASxVw7xWjA0UeVdVqOoSio664dkXK3j1z2pnFxVZuA3xDTqBSd
         OQv6UYy8kqnsgwRTnslJl/6tFVPZAqvYsFxf0D3zvih9gsSV7X6z4RTTe6VUrJP7c5ro
         h+v/XEgf4zCz1dPldN11BGk42RbYXJBwwjwj6QQQDmAySI/YrgNxNqKr82oqX2zMNGb1
         fGGlfNvfrY7P6OfGTvHTNKEUVC+aFIdXx0CdW8azkbXRMMCHn6v19hzUw5IJr4SDLzs2
         nwTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dkZUSlduxLUNkOHP8pgyqH3yKqTS8fpj0WI791VKcBI=;
        b=irgj/Ehrh0qaQnMCs+fvTgGjDiNsiwr9i4R+U0EX/ENtWvlVlebGsD37h46+ePFy1+
         YNy6VTLamDAES0lom+TTfDj9p9IZEGW2Y0WBd/SXSA5TcGH3+K68Yb+phj4xBTmzsTPM
         1JPXOzJ4jMHe1+wjOQrED+D9CloDmkGx/uzPT0PMULY5nCIbTQIgk8LJy6kyFNR620CE
         sO/1QxlqHmVOc265lSg/sy2ZESF3xjuOt+fEOxy2YOe1mZvkeakAAK20Ra8Or1YA/0CZ
         4CdHlMyUSNijDcXUCI6TF3TMfMQ1JWj1K7TMOHaJZ0O6SDk0KuUrSaQFEGeajNbLIne7
         ElpQ==
X-Gm-Message-State: AOAM532AvIwV5anfUSkKuUfHjNxZ1NpbE+gzOBiOvT/cfJISgrYNWiyc
        6fJAmTSzZZtHu41CdRZLHo19VsG3W8A=
X-Google-Smtp-Source: ABdhPJwh9y/NWuEttz6TFC+VulMUwNsJ2fGeXfhG3MS/SEz4tLiLddBq6wT8RjR1PaNaxIeRnuBUeg==
X-Received: by 2002:a17:902:ecc5:: with SMTP id a5mr51823plh.30.1644244306727;
        Mon, 07 Feb 2022 06:31:46 -0800 (PST)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id s84sm8928747pgs.77.2022.02.07.06.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 06:31:46 -0800 (PST)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, hengqi.chen@gmail.com
Subject: [PATCH bpf-next v3 0/2] libbpf: Add syscall-specific variant of BPF_KPROBE
Date:   Mon,  7 Feb 2022 22:31:32 +0800
Message-Id: <20220207143134.2977852-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add new macro BPF_KPROBE_SYSCALL, which provides easy access to syscall
input arguments. See [0] and [1] for background.

  [0]: https://github.com/libbpf/libbpf-bootstrap/issues/57
  [1]: https://github.com/libbpf/libbpf/issues/425

v2->v3:
  - Use PT_REGS_SYSCALL_REGS
  - Move selftest to progs/bpf_syscall_macro.c

v1->v2:
  - Use PT_REGS_PARM2_CORE_SYSCALL instead

Hengqi Chen (2):
  libbpf: Add BPF_KPROBE_SYSCALL macro
  selftests/bpf: Test BPF_KPROBE_SYSCALL macro

 tools/lib/bpf/bpf_tracing.h                   | 33 +++++++++++++++++++
 .../bpf/prog_tests/test_bpf_syscall_macro.c   |  6 ++++
 .../selftests/bpf/progs/bpf_syscall_macro.c   | 23 +++++++++++++
 3 files changed, 62 insertions(+)

--
2.30.2
