Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5972C48F8
	for <lists+bpf@lfdr.de>; Wed, 25 Nov 2020 21:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgKYUYM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 25 Nov 2020 15:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgKYUYM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 25 Nov 2020 15:24:12 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7AA3C0613D4
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2020 12:24:11 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id k14so1200156wrn.1
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2020 12:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x9h88oHK+Sdh5+pR9JtijXCThpiA96Q13JfuMIH/ZMM=;
        b=FtWW6jTtZ+2HhTd6KizC5OxxJhU9IWEbhx32xim2QmtZcwXuCe1DaXJUnurGasZmwK
         wg5syV6hT0IVPgi6rFfRP8uhCXKXa14cPbcQtYoYWn0hLEnxbRFfR8UNkm8ZychOe5DS
         OKfc1+4aIPu2nRLQHtvityYY8RwujQRyPp9Ds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x9h88oHK+Sdh5+pR9JtijXCThpiA96Q13JfuMIH/ZMM=;
        b=hj/6kWb9sNeoxvdRlCSYLR2+Qxtoah3HHdL6lA7pg7bQLh8Rj6xrv0snGsvmcRN/fQ
         dqmeGjPZlCrExCgnOqZ/T9KpLW+lHfG9xUaA9b7WFV7I/5aYCgPZCwpdvSEaDQbEsB1q
         Jeb07UqrxyHEmxiGdWRbKXrb37xqDsgHyhUHUQaQMnttSwxLLyPqPoexhI/RHCi2k/Az
         aTUT0D6wBT0MO/Qid/t3tOFvHqWGhVSevEz2mnuOvgsDMX3JnWKHzUFelpD+23dkqXzN
         PrF8S8yEacOtzJ7QxoD99SD/Ey1DE2h8bY0ms80j00y6+WWWcfTatRAZDp2N+0ln8dNG
         d3JA==
X-Gm-Message-State: AOAM5333QOJp0L9BFaF4a6+Fel0HGlAEznyj5L6x/mCH1oPr++DwTpq7
        tSzBwqkXSiO+h3zczwYHKi2isxpcYq/pD03v
X-Google-Smtp-Source: ABdhPJwoA8f/YA9g8GPOyTlQhyUqTmqK8ECO8/cOkxAxaY857Au4p8RBwYcNPjxlRbrJzN890l8HxA==
X-Received: by 2002:adf:ed11:: with SMTP id a17mr6108696wro.197.1606335850324;
        Wed, 25 Nov 2020 12:24:10 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id 134sm6743955wmb.17.2020.11.25.12.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 12:24:09 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next] bpf: Add MAINTAINERS entry for BPF LSM
Date:   Wed, 25 Nov 2020 20:24:04 +0000
Message-Id: <20201125202404.1419509-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Similar to XDP and some JITs, also added Brendan and Florent who have
been reviewing all my patches internally as reviewers. The patches are
still expected to go via the BPF tree / list / merge workflows.

Signed-off-by: KP Singh <kpsingh@google.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index af9f6a3ab100..09c902bee5d2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3366,6 +3366,17 @@ S:	Supported
 F:	arch/x86/net/
 X:	arch/x86/net/bpf_jit_comp32.c
 
+BPF LSM (Security Audit and Enforcement using eBPF)
+M:	KP Singh <kpsingh@chromium.org>
+R:	Florent Revest <revest@chromium.org>
+R:	Brendan Jackman <jackmanb@chromium.org>
+L:	bpf@vger.kernel.org
+S:	Maintained
+F:	Documentation/bpf/bpf_lsm.rst
+F:	include/linux/bpf_lsm.h
+F:	kernel/bpf/bpf_lsm.c
+F:	security/bpf/
+
 BROADCOM B44 10/100 ETHERNET DRIVER
 M:	Michael Chan <michael.chan@broadcom.com>
 L:	netdev@vger.kernel.org
-- 
2.29.2.454.gaff20da3a2-goog

