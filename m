Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3939E2D1A1E
	for <lists+bpf@lfdr.de>; Mon,  7 Dec 2020 20:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbgLGT5M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Dec 2020 14:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgLGT5M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Dec 2020 14:57:12 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6B41C061794
        for <bpf@vger.kernel.org>; Mon,  7 Dec 2020 11:56:31 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id x22so322393wmc.5
        for <bpf@vger.kernel.org>; Mon, 07 Dec 2020 11:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eA/fhHttmx4BYSoIV7Y3PyW0Xgp8HedWJZ3kSwGd7qM=;
        b=Rx2kkCmZ+FgKln8FUJd506TxOlujIx2a854tc5Lv/wbSoF4I3D5Y3UTDvOiPf4BEU0
         9b9A8fmyTZZ/BvEcc6/iQ4yZ7S4SkzfURcxY6jir+78TKz30w2hxqARUgdOrkXfeOUB9
         OUjSXC+UW2mecPfAlRcn4bc31TC7dogLu/4Xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eA/fhHttmx4BYSoIV7Y3PyW0Xgp8HedWJZ3kSwGd7qM=;
        b=kwnYKigfK9GwZTsNfsXwCdVpUvUKYefLWZKISJYDc03Q5BJjuMUkmr0xiOfHj+0G6R
         gGAzImpnon9UEziqXFSAobWV31uWK8cyWNo5TImQKbZXtEQtESobdAEMxX7CUBvpQ8xA
         d/LU2nDUKbzkTJmIKBtgj/BpH8Z2Yv/yk6lSNJlQZdzfnqFEeznZ8S+xX4NSvCjUaqPE
         l2tOLTCx6BMidY6yeKm1Hv+lPBWe41Cdc11TdUTkuMP+5vD7j0uinCRPeYJcuQP8MbqN
         KxsKd7vIAm25WduVXic6H1zzHQbKntn9k8XkoN70W6rDl7KjhE0ctwXe+Bnku7f/8PDP
         FNng==
X-Gm-Message-State: AOAM532SpfgCHgIactgfRfPEJnpz5+VGjUAXNkV7vMeDlpI5LPa2QSLm
        pFwf2S2qp5+7pgI4QcAb1p1TaQ7B5wxTWg==
X-Google-Smtp-Source: ABdhPJwRr3c35YwXYieC6vSlSfluvpB8QKErxv59vR3tfD4WwjdeDPBfFZj0sPyFG8L9BtVzgSKjvA==
X-Received: by 2002:a1c:2ec6:: with SMTP id u189mr469286wmu.31.1607370990290;
        Mon, 07 Dec 2020 11:56:30 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:f693:9fff:fef4:a569])
        by smtp.gmail.com with ESMTPSA id v20sm325722wml.34.2020.12.07.11.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 11:56:29 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@chromium.org, rdunlap@infradead.org,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next] bpf: Only call sock_from_file with CONFIG_NET
Date:   Mon,  7 Dec 2020 20:55:39 +0100
Message-Id: <20201207195539.609787-1-revest@chromium.org>
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
index 0cf0a6331482..877123bae71f 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1272,7 +1272,11 @@ const struct bpf_func_proto bpf_snprintf_btf_proto = {
 
 BPF_CALL_1(bpf_sock_from_file, struct file *, file)
 {
+#ifdef CONFIG_NET
 	return (unsigned long) sock_from_file(file);
+#else
+	return NULL;
+#endif
 }
 
 BTF_ID_LIST(bpf_sock_from_file_btf_ids)
-- 
2.29.2.576.ga3fc446d84-goog

