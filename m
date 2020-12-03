Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7652CCB55
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 01:59:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbgLCA66 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Dec 2020 19:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgLCA66 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Dec 2020 19:58:58 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71DDC061A47
        for <bpf@vger.kernel.org>; Wed,  2 Dec 2020 16:58:17 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id k14so167623wrn.1
        for <bpf@vger.kernel.org>; Wed, 02 Dec 2020 16:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ghTVsKbpZtfvZg6e/7iBLzacUWdh3E9D77gh2ZJibOg=;
        b=UCcew2G12nQ35xouD2ydDuKmEOgtKkMgTK/ZJX/WvlGCFxzhchd0kPyuc2JYFxFdSx
         3jf8Hy8wk3A75n3SUyp5tIxBmKgF5UZoAMKk32if1Uq6BfXdrIylu1rNHlS9eBi90i6/
         XpcmHdTf3KZidnZCWd3YSiyXBMg8WBE85dgb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ghTVsKbpZtfvZg6e/7iBLzacUWdh3E9D77gh2ZJibOg=;
        b=hURIMiManSE9CtaL6xSE52Jb0R3HQXUfjItGg6fXb9QBZ086y2z89Z0Mf/HuqRJK73
         DkzQlI6B4RCDAAIvPN2OF8zIXPmEwFFjlkc6OFY8F8KB72pAY12dHB9/dSIyjh6+BLMe
         y3RQXqQgpWnZ+bWZNc0gI5ZfibMV2yG9tamiTbM83yFLPKGKnot+ZkOGzzhtM91/e38+
         mMCyorWQDLp+hos1RBsA5FN+KmMsxcL+QC3yCj4TbOUtJRIhE6z79FG0m1LXOt1cNAQl
         ilbiQWL3CJ7Sp+5upIWqKrxZxycOj/YzllpvlryrCzN3T4DQdtYHatlgumamZcZqtXyr
         rjqw==
X-Gm-Message-State: AOAM5333B9KZ5hz9DQJjftpCTrzt+Mj0/g+hHVUI9qwdki0/RZ82jKE3
        6p+lPOCwmdJM1qWNlxO9FK3EL2314+DrkE5Y
X-Google-Smtp-Source: ABdhPJy7tnVcrXSmK1e55LDlngGOTYYTYOL5TpVdJJyxCB9JfHxMPeW5K/IxkbTwLE/iicOj7JLEZw==
X-Received: by 2002:adf:f347:: with SMTP id e7mr737105wrp.183.1606957096320;
        Wed, 02 Dec 2020 16:58:16 -0800 (PST)
Received: from kpsingh.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id m4sm217960wmi.41.2020.12.02.16.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 16:58:15 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf-next v3 3/4] selftests/bpf: Add config dependency on BLK_DEV_LOOP
Date:   Thu,  3 Dec 2020 00:58:06 +0000
Message-Id: <20201203005807.486320-4-kpsingh@chromium.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201203005807.486320-1-kpsingh@chromium.org>
References: <20201203005807.486320-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

The ima selftest restricts its scope to a test filesystem image
mounted on a loop device and prevents permanent ima policy changes for
the whole system.

Fixes: 34b82d3ac105 ("bpf: Add a selftest for bpf_ima_inode_hash")
Reported-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: KP Singh <kpsingh@google.com>
---
 tools/testing/selftests/bpf/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
index 365bf9771b07..37e1f303fc11 100644
--- a/tools/testing/selftests/bpf/config
+++ b/tools/testing/selftests/bpf/config
@@ -43,3 +43,4 @@ CONFIG_IMA=y
 CONFIG_SECURITYFS=y
 CONFIG_IMA_WRITE_POLICY=y
 CONFIG_IMA_READ_POLICY=y
+CONFIG_BLK_DEV_LOOP=y
-- 
2.29.2.576.ga3fc446d84-goog

