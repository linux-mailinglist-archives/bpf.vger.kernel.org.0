Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C84F836CA82
	for <lists+bpf@lfdr.de>; Tue, 27 Apr 2021 19:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236552AbhD0RoG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Apr 2021 13:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238314AbhD0RoE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Apr 2021 13:44:04 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F35C061756
        for <bpf@vger.kernel.org>; Tue, 27 Apr 2021 10:43:20 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id h4so51289106wrt.12
        for <bpf@vger.kernel.org>; Tue, 27 Apr 2021 10:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sTVXYIke2mYhPaPQQebsNo0GgJ6tL2u6qjrM5GFCGyE=;
        b=SgDEyqUOq79z0oEavubQe+urM8+uc+iQ68gURUc8gqUQmmXMno35OpYPSWfy5OygSm
         jdmKup8DCZues81DvSAkxE0AXNZDKhStMoMLeIyBf9kGOgscP0yQjYk1BCRQgWO01mRt
         C0qE6aU/juhBV+s/iSgi0oxjaIV7aiTh8z/ZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sTVXYIke2mYhPaPQQebsNo0GgJ6tL2u6qjrM5GFCGyE=;
        b=iGEBL8WUWegVFm4EQNiLfiPvDQfnpKmPIfGhejX+76LC2iMtul9CdRU/1EXxW4PbXx
         IO6WozWo3Jph9fMI4aBaYvgOupQlHR8LaSm6yujpJi8kQt9Sk7oRUn71uJPy82xNgNlU
         D9MO/G7l3OrrsRMSGjXouL7l8x4usvypJcFzb3cDjzAAYzQN4dBpzdd41X5j68JtEt2i
         iKb4JFWAqoiUrgfbRhsJKm/tnnbpFXPbex1B5pkJ5gr73rYcTXoCZn12TTJ+r24aMewx
         0f9gRmBZG1OPybNkX8yMsZuSlCjfU3o6HkpTKhYGkMKZWt5j9p71TbgwOfhui1igYIcz
         FxOw==
X-Gm-Message-State: AOAM532fmziQLEXsuxHlCWXU6cWwQ3CgWOBE7GcnXagvdlE0ttBRWIxN
        jE2OQKvBc4k23JxwkESSE2hYa+pQ7xYnyw==
X-Google-Smtp-Source: ABdhPJyPyLIg5qhWknNn7WU7xxi+4li4Ym7+YJ12lijz0KXXfEPj9mSQNzgJNAjLQKtF79YXd8bhnA==
X-Received: by 2002:a5d:6352:: with SMTP id b18mr9017312wrw.76.1619545399112;
        Tue, 27 Apr 2021 10:43:19 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:61:302:14c3:1569:da7a:4763])
        by smtp.gmail.com with ESMTPSA id h8sm647302wmq.19.2021.04.27.10.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 10:43:18 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@kernel.org, jackmanb@google.com, linux@rasmusvillemoes.dk,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v2 0/2] Implement formatted output helpers with bstr_printf
Date:   Tue, 27 Apr 2021 19:43:11 +0200
Message-Id: <20210427174313.860948-1-revest@chromium.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF's formatted output helpers are currently implemented with
snprintf-like functions which use variadic arguments. The types of all
arguments need to be known at compilation time. BPF_CAST_FMT_ARG casts
all arguments to the size they should be (known at runtime), but the C
type promotion rules cast them back to u64s. On 32 bit architectures,
this can cause misaligned va_lists and generate mangled output.

This series refactors these helpers to avoid variadic arguments. It uses
a "binary printf" instead, where arguments are passed in a buffer
constructed at runtime.

---
Changes in v2:
- Reworded the second patch's description to better describe how
  arguments get mangled on 32 bit architectures

Florent Revest (2):
  seq_file: Add a seq_bprintf function
  bpf: Implement formatted output helpers with bstr_printf

 fs/seq_file.c            |  18 ++++
 include/linux/bpf.h      |  22 +----
 include/linux/seq_file.h |   4 +
 init/Kconfig             |   1 +
 kernel/bpf/helpers.c     | 188 +++++++++++++++++++++------------------
 kernel/bpf/verifier.c    |   2 +-
 kernel/trace/bpf_trace.c |  34 +++----
 7 files changed, 137 insertions(+), 132 deletions(-)

-- 
2.31.1.498.g6c1eba8ee3d-goog

