Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30C292FA576
	for <lists+bpf@lfdr.de>; Mon, 18 Jan 2021 17:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404676AbhARQAo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Jan 2021 11:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390669AbhARQAk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Jan 2021 11:00:40 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA0EFC061786
        for <bpf@vger.kernel.org>; Mon, 18 Jan 2021 07:59:11 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id r1so4702953wmn.8
        for <bpf@vger.kernel.org>; Mon, 18 Jan 2021 07:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=6OdTPYEA2p5+e67drhVq+n88z8c6ioQj4MZmywIDAFM=;
        b=eMBuLjmixjlbs4KF0qZwuBWsre4MhQNj8gm7XxkbXIPimS+tmeY3wm5Tke/4fDyObv
         J7FhRpPLOUyZ0NkB7PA9Whh3FFh/p4zRylDnczG+AOHircxNJd35i3cmWageo/SngS6F
         +pW8+PP117T9sFvwjbYfoOL06tsyW6srmnXTBEbbhcpDTG7Hvn0dpBpV39Jx35cmxWr2
         /qLfWcOFJHeCP6JN6sMRxyEmS4zkokORJhKHdr/XW8BoHiv8rm7yiZ0+2V6ABjqFxyNz
         r9Z6s0Lbx39CdrnhmIkAPnCj/h3bH+OuVy3XNiwSKHvJtIqR/06iUUW9y7ilPymgagbD
         8g2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6OdTPYEA2p5+e67drhVq+n88z8c6ioQj4MZmywIDAFM=;
        b=ZjPPqtwKC2A8zYpwtjtiKKqN9LX1DaGG3kADoSbRO8PYiNUW+7v2kyX88ND18bbfwU
         MFOt7tr8wY2lcITG2qLzZK7aD7X7USAN651OyBAQYp5Bf+Z+nM0O5qDd/MOLouipPM/V
         Cq9ua2BOzeusxdO9LZaSxXUSulQ+Qxyl/lHPnghocRlZSF/M/BUaezXNc4XX3iyrQDz6
         rN2OCFu/sZJMctl3l2jejvHAa9MhNeiaHmqIv2EdOOqQOxNLduPGi4cWb83vwz39bg5W
         qqQJnHJZ99jKglBqTiFlLK+jWxAc7IJfaSwiLhfBPig65tydaF+sZloFr3l/R+TZnlcv
         /VnA==
X-Gm-Message-State: AOAM5331cPjE0sDp06BZP5YbUO0PD0Tij9pX8i1qtwIvfj8GNPt58DDu
        emTzhTOneLJw8axtQgW7O/jZvt2olXFRWTZCwMR3TaUiwGgF6Gm2bO6ZAn28gShFJxzushrQTCZ
        DlpjdPZlqMS50MTPWDVU4IdVR/9onbgZgdEw77VVCtMDTBewVY2OKAERSwz850N8=
X-Google-Smtp-Source: ABdhPJx33zg0bqJm2Kmy1Jtk2wZJhRlq1DTndo3IekH3vxXdp0oYMj9T3RZMul5MMDMPA5R/Y/vw0BsdArAwKg==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a1c:6208:: with SMTP id
 w8mr82357wmb.24.1610985550410; Mon, 18 Jan 2021 07:59:10 -0800 (PST)
Date:   Mon, 18 Jan 2021 15:57:35 +0000
In-Reply-To: <20210118155735.532663-1-jackmanb@google.com>
Message-Id: <20210118155735.532663-3-jackmanb@google.com>
Mime-Version: 1.0
References: <20210118155735.532663-1-jackmanb@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH bpf-next v2 2/2] docs: bpf: Clarify -mcpu=v3 requirement for
 atomic ops
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei pointed out [1] that this wording is pretty confusing. Here's
an attempt to be more explicit and clear.

[1] https://lore.kernel.org/bpf/CAADnVQJVvwoZsE1K+6qRxzF7+6CvZNzygnoBW9tZNWJELk5c=Q@mail.gmail.com/T/#m07264fc18fdc43af02fc1320968afefcc73d96f4

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 Documentation/networking/filter.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/filter.rst b/Documentation/networking/filter.rst
index 4c2bb4c6364d..b3f457802836 100644
--- a/Documentation/networking/filter.rst
+++ b/Documentation/networking/filter.rst
@@ -1081,9 +1081,10 @@ before is loaded back to ``R0``.
 
 Note that 1 and 2 byte atomic operations are not supported.
 
-Except ``BPF_ADD`` *without* ``BPF_FETCH`` (for legacy reasons), all 4 byte
-atomic operations require alu32 mode. Clang enables this mode by default in
-architecture v3 (``-mcpu=v3``). For older versions it can be enabled with
+Clang can generate atomic instructions by default when ``-mcpu=v3`` is
+enabled. If a lower version for ``-mcpu`` is set, the only atomic instruction
+Clang can generate is ``BPF_ADD`` *without* ``BPF_FETCH``. If you need to enable
+the atomics features, while keeping a lower ``-mcpu`` version, you can use
 ``-Xclang -target-feature -Xclang +alu32``.
 
 You may encounter ``BPF_XADD`` - this is a legacy name for ``BPF_ATOMIC``,
-- 
2.30.0.284.gd98b1dd5eaa7-goog

