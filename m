Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF61D2D1A3E
	for <lists+bpf@lfdr.de>; Mon,  7 Dec 2020 21:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgLGUHD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 15:07:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbgLGUHD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Dec 2020 15:07:03 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B25C061794
        for <bpf@vger.kernel.org>; Mon,  7 Dec 2020 12:06:17 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id u12so14044560wrt.0
        for <bpf@vger.kernel.org>; Mon, 07 Dec 2020 12:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZY6PnXSHmnL1clMEjidFbJWKwSKFrnJjIARjAjV0kbg=;
        b=b+meLkYgvmiATHtHLcWUsdmN0/mHnVCOxiHjWZHNuyFjU3/PY+INCbBCbNkm5IJbCH
         mNSCVoYGRJqnLv+bysls9E7m60/hzpqZH1SarTqhaOIX1DjJdbRpz4nfIQ3vxFejr9IC
         4iIhBMXCvWGi5+sITzyzL44c5z9cfd6D26JzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZY6PnXSHmnL1clMEjidFbJWKwSKFrnJjIARjAjV0kbg=;
        b=hBU78LVxD0JKXVypfB2kq4kXfseLPCOs8+OebYx7sM+lGqg50WIt/a/ZMSbcspGfJY
         qr5HgnbpUtohEtuROXJZkk9b/Kjrfonv/8QGiW4yMd9JIDt4hogtnQipZmxqQuWxtKCO
         Y+Vr6Meu0CDnkVTgxq/oOdO85DmlNql7CDw7aX1qwtBdXFAzGHX9AhuzRhkT2aOWJoWL
         sqK+BPfSluf1PREQkMyK2y0Pfovza6qJszjEseDu1swK6FP9cPVBE9ftgPkDw6hw0Cr5
         /pfseS+1GBCCkkNJHxJ9bkl9knXV+COZLZWPZvFtKDYZYPKjE/IPEAw+Rs3jGthJyzoL
         ALQg==
X-Gm-Message-State: AOAM532KTj4xX9BPeqR4VrBcwkB462gnZvSl466/dzXtL68EEaIwtH3s
        idepCMHKkIsYHrkAIuTwa+ZDWMeSBQqc9Q==
X-Google-Smtp-Source: ABdhPJxOTR7AmaDvUsAyDUxKnDlaqCuaYmt3uGcpEHsJb7fK9T+mjbkJ7bKRTyaGXCDlkqpnzKZyFg==
X-Received: by 2002:adf:eb08:: with SMTP id s8mr21529516wrn.12.1607371576062;
        Mon, 07 Dec 2020 12:06:16 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:f693:9fff:fef4:a569])
        by smtp.gmail.com with ESMTPSA id m4sm9863145wrw.16.2020.12.07.12.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 12:06:15 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@chromium.org, rdunlap@infradead.org,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next v2] bpf: Only call sock_from_file with CONFIG_NET
Date:   Mon,  7 Dec 2020 21:06:05 +0100
Message-Id: <20201207200605.650192-1-revest@chromium.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This avoids
  ld: kernel/trace/bpf_trace.o: in function `bpf_sock_from_file':
  bpf_trace.c:(.text+0xe23): undefined reference to `sock_from_file'
When compiling a kernel with BPF and without NET.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Florent Revest <revest@chromium.org>
---
 kernel/trace/bpf_trace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 0cf0a6331482..29ec2b3b1cc4 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1272,7 +1272,11 @@ const struct bpf_func_proto bpf_snprintf_btf_proto = {
 
 BPF_CALL_1(bpf_sock_from_file, struct file *, file)
 {
+#ifdef CONFIG_NET
 	return (unsigned long) sock_from_file(file);
+#else
+	return 0;
+#endif
 }
 
 BTF_ID_LIST(bpf_sock_from_file_btf_ids)
-- 
2.29.2.576.ga3fc446d84-goog

