Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4C5368A48
	for <lists+bpf@lfdr.de>; Fri, 23 Apr 2021 03:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235569AbhDWBP6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Apr 2021 21:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbhDWBP5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Apr 2021 21:15:57 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4207CC06174A
        for <bpf@vger.kernel.org>; Thu, 22 Apr 2021 18:15:22 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h4so37610387wrt.12
        for <bpf@vger.kernel.org>; Thu, 22 Apr 2021 18:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6tnmCzU5o1RaGCQyagi+jERPl52+lDaOeiTTMhHRcJo=;
        b=mulAFomOqY5tyfdHYoYN7oJbb3m5RLiFBL2SUjgQ3wvwi0uvACFvR5Iyesc5OTtfCT
         l2YwGARKcfSHDmaG/gbJLJeRcpgkMMmGnfRghUXaDcPeK99itLC/TdR7rq/51D5kxk2X
         SdoKa5mtk4hqAmamI5XdpmQoeKBvGGlABrLhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6tnmCzU5o1RaGCQyagi+jERPl52+lDaOeiTTMhHRcJo=;
        b=YdausfgIBHQFYWT7g2aK1MTU6QlLhk3FbHyPyx4gyMH8Iy8ge0fkHuWKuv2Cr73PVE
         nbSG8O67Ab5BVocGQmXGbg/4Mbk7lY+MX+84sG0RROhgFlZFUgIH1iI8Cidjq5K318OO
         CUJwp5Rk6xWBAKai/TUIHr2ukC3Abb2h587XaPcfmTcbDRQa5THA3LmnKgkZi4BMiu28
         i06EKb+1hwjrHDgDnVuUFRTGMjg5qzliMNAmAO6nnlrUAgIVRi8IOe340EAH82lS82Su
         1Aj0UjYEUGMvzQzHfHDpqEYa791EY8QbdqjF9cahF4s9vvcNSy7XU5hqZW2fLtp+JnK3
         XKUg==
X-Gm-Message-State: AOAM5333zFfSHz/hxu9UgQZX5gMnV7+UX5ZIedyVPsxcco03F3h57P6t
        f1Ey+euep37YPaOC6knwiWpX3XtSErQ43w==
X-Google-Smtp-Source: ABdhPJy33ed/7fcB3eBdze/DWHCU+UMqWFGSs9QaNUuie4uTYVwmdcBwWj9Xc8WZSXE5o4aUjbLzHg==
X-Received: by 2002:a5d:49ca:: with SMTP id t10mr1247357wrs.395.1619140520749;
        Thu, 22 Apr 2021 18:15:20 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:61:302:e4b7:67ca:7609:a533])
        by smtp.gmail.com with ESMTPSA id a13sm6709340wrs.78.2021.04.22.18.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Apr 2021 18:15:20 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@kernel.org, jackmanb@google.com, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next 0/2] Implement BPF formatted output helpers with bstr_printf
Date:   Fri, 23 Apr 2021 03:15:15 +0200
Message-Id: <20210423011517.4069221-1-revest@chromium.org>
X-Mailer: git-send-email 2.31.1.498.g6c1eba8ee3d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Our formatted output helpers are currently implemented with
snprintf-like functions which take arguments as va_list but the types
stored in a va_list need to be known at compilation time which causes
problems when dealing with arguments from the BPF world that are always
u64 but considered differently depending on the format specifiers they
are associated with at runtime.

This series replaces snprintf usages with bstr_printf calls. This lets
us construct a binary representation of arguments in bpf_printf_prepare
at runtime that matches an ABI that is neither arch nor compiler
specific.

This solves a bug reported by Rasmus Villemoes that would mangle
arguments on 32 bit machines.

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

