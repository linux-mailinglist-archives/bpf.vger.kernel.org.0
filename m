Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A532C33B30A
	for <lists+bpf@lfdr.de>; Mon, 15 Mar 2021 13:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbhCOMp0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Mar 2021 08:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhCOMpK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Mar 2021 08:45:10 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F739C061574;
        Mon, 15 Mar 2021 05:45:10 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id a22-20020a17090aa516b02900c1215e9b33so14305005pjq.5;
        Mon, 15 Mar 2021 05:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OYxUeg1IdQxQnxwvNs7fJX3FexyIcbE7FDVXyh5OdEM=;
        b=nI9YuUb80LbZ4aMJ4gAdGs/DVPvxa/+Iht0lFG4mE1wiv3LVrfpnzodFVINjFGBw//
         0OShEOCpoUWrk/mcpQcwZaqSahKjfrTl0yZFpQ8DoZj07FSqKSbcb1eNbmeELqOgLmrD
         0Y7L23jQdaDVEZHzfCTc9j0q+XMFt8kl8R5YH1tSCPcfFxQyHs+90E4ZeC6NsT076kB+
         2IC4qdTCwjvu+0iTpDqHxSM3STNh43b6lJHjgGr8fi+fDLu98+KjS6C/Zsgss8ZgZ5Pg
         r4mNixLJFXoaseF4EwVzaKdGWxJWRzapLMxhK5BEOTO+FU5NH40BogP71aieCysM+tTX
         NDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OYxUeg1IdQxQnxwvNs7fJX3FexyIcbE7FDVXyh5OdEM=;
        b=X8bg0kD8IominaBsTAgiyQNAXMSIH5/ON24hbFEV8XlL89g9Sv5fI67jpZUPcDHFjO
         /RhhaZPLZTsj96ggixpcG23t7/Y7FNlGOFmIQ3/MgLJ3HI4qNvblGa1PLDCD2bwrI0rX
         ZXPNYk1dW4Nd2GWJ64ibgvj0m23gK/zLC6pXLyCXxaomIVWbP9MyLg9YVZNrP9BlxnxC
         S+Dgy1ZJwA12BaGJhsEiVqoek/mgxsaHC+JVXPj4d2Lmn1gSQFunnROCyiCIqfllq1wx
         P5OqKdXffRlNLL/+sRTsIBYbW+r6NtxAvxPMV8uhLUVIjjKaoBQsv7j2bU6aWolnI03l
         tEBQ==
X-Gm-Message-State: AOAM530IoVOtZxzMLb0CS6klYtdfDNrPWqTPMROiqRXSFRZbw5ubsIop
        EXrRxdHOt3FsSd/KUCZDx6F7XalOtePVMw==
X-Google-Smtp-Source: ABdhPJwLwV4QPZ0DpOvzSJcznbEsVxi6UL35OHvQuLLdazbvan1dz6j18iCP0y6lpNCzSb87XI5oIg==
X-Received: by 2002:a17:902:a707:b029:e6:52fd:a14d with SMTP id w7-20020a170902a707b02900e652fda14dmr12075311plq.34.1615812309795;
        Mon, 15 Mar 2021 05:45:09 -0700 (PDT)
Received: from masabert ([202.12.244.3])
        by smtp.gmail.com with ESMTPSA id a19sm13523055pfc.65.2021.03.15.05.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 05:45:09 -0700 (PDT)
Received: by masabert (Postfix, from userid 1000)
        id 763E723603DE; Mon, 15 Mar 2021 21:45:07 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     linux-kernel@vger.kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, ast@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, bpf@vger.kernel.org
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] samples: bpf: Fix a spelling typo in do_hbm_test.sh
Date:   Mon, 15 Mar 2021 21:44:54 +0900
Message-Id: <20210315124454.1744594-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch fixes a spelling typo in do_hbm_test.sh

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 samples/bpf/do_hbm_test.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/do_hbm_test.sh b/samples/bpf/do_hbm_test.sh
index 21790ea5c460..38e4599350db 100755
--- a/samples/bpf/do_hbm_test.sh
+++ b/samples/bpf/do_hbm_test.sh
@@ -10,7 +10,7 @@
 Usage() {
   echo "Script for testing HBM (Host Bandwidth Manager) framework."
   echo "It creates a cgroup to use for testing and load a BPF program to limit"
-  echo "egress or ingress bandwidht. It then uses iperf3 or netperf to create"
+  echo "egress or ingress bandwidth. It then uses iperf3 or netperf to create"
   echo "loads. The output is the goodput in Mbps (unless -D was used)."
   echo ""
   echo "USAGE: $name [out] [-b=<prog>|--bpf=<prog>] [-c=<cc>|--cc=<cc>]"
-- 
2.25.0

