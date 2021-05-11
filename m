Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1535437A16D
	for <lists+bpf@lfdr.de>; Tue, 11 May 2021 10:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbhEKINT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 May 2021 04:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbhEKINS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 May 2021 04:13:18 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0475DC06175F
        for <bpf@vger.kernel.org>; Tue, 11 May 2021 01:12:11 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id m9so19171628wrx.3
        for <bpf@vger.kernel.org>; Tue, 11 May 2021 01:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RYYwR3CTxznzKHPoSIkCx5FVByAWj2aDJZ3uTlBEg4E=;
        b=YMhKx3S0b2h89pxYIg6yAkVl93SuxYBuLUX5vC952rof9yYPl0l0m0QYCmr9Sr12Lw
         F3cR1ye21HS0UGwz0sBBlv3p1/OiCNLK5bWs/yluwg3ACIVLAaUw8KUImqtMKm+C0mAd
         mxBlWhF4raJx8qN5BJFGPVxp2ErBwKgLeZsro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RYYwR3CTxznzKHPoSIkCx5FVByAWj2aDJZ3uTlBEg4E=;
        b=XBwKtxMU1w5UZO2sCmLUTwEtKvTYcLV9+Op5TJoft32TFFT41ycj2sO/8dnq2ZDqSf
         Sapv+Z2lddLn5+KXHwMxvZ+UwED+THUCENRxVWpAIh0Kt3014vQzRsV4xZqGle6gOoOR
         C7S/HWSdgmf1hI6Q6u8l5U/Hx3idtT84iI3yphfa2EOBUZF9oot02p3XFEg++EnoGIrv
         w+CAfYBebXnbVX6yaZrrjO39VPFW44tJuGSNvaCYykHTfwZ3pyyIRmMyI+/fkZ+ASwDT
         6eNB97RzNUGdo37+7cpvPJfzSRNrjr6F2+wVRX8rhpZ5sogkDeuY6YZ9OxGDRKVQS1tX
         v8JQ==
X-Gm-Message-State: AOAM530CWZGS4TCgZGaqzEz08ysjEaLzKUfcPVi6wLyjHQAe05BCM8Kq
        72KM0BHrttlcRuBlEjai88Mara3BAfGJKQ==
X-Google-Smtp-Source: ABdhPJwFxarF8C+ovrsOiDvv/NbaquuFaLWJf0P1c79YmZdCsZa93rQG0+j9HuOGeBbON1oZpZ4/Zg==
X-Received: by 2002:a5d:4e0b:: with SMTP id p11mr35697366wrt.220.1620720729542;
        Tue, 11 May 2021 01:12:09 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:61:302:5cab:f78e:32e4:87aa])
        by smtp.gmail.com with ESMTPSA id r2sm27829212wrv.39.2021.05.11.01.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 01:12:09 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@kernel.org, jackmanb@google.com, sdf@google.com,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>,
        syzbot+63122d0bc347f18c1884@syzkaller.appspotmail.com
Subject: [PATCH bpf v2] bpf: Fix nested bpf_bprintf_prepare with more per-cpu buffers
Date:   Tue, 11 May 2021 10:10:54 +0200
Message-Id: <20210511081054.2125874-1-revest@chromium.org>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The bpf_seq_printf, bpf_trace_printk and bpf_snprintf helpers share one
per-cpu buffer that they use to store temporary data (arguments to
bprintf). They "get" that buffer with try_get_fmt_tmp_buf and "put" it
by the end of their scope with bpf_bprintf_cleanup.

If one of these helpers gets called within the scope of one of these
helpers, for example: a first bpf program gets called, uses
bpf_trace_printk which calls raw_spin_lock_irqsave which is traced by
another bpf program that calls bpf_snprintf, then the second "get"
fails. Essentially, these helpers are not re-entrant. They would return
-EBUSY and print a warning message once.

This patch triples the number of bprintf buffers to allow three levels
of nesting. This is very similar to what was done for tracepoints in
"9594dc3c7e7 bpf: fix nested bpf tracepoints with per-cpu data"

Fixes: d9c9e4db186a ("bpf: Factorize bpf_trace_printk and bpf_seq_printf")
Reported-by: syzbot+63122d0bc347f18c1884@syzkaller.appspotmail.com
Signed-off-by: Florent Revest <revest@chromium.org>
---
 kernel/bpf/helpers.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 544773970dbc..ef658a9ea5c9 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -696,34 +696,35 @@ static int bpf_trace_copy_string(char *buf, void *unsafe_ptr, char fmt_ptype,
  */
 #define MAX_PRINTF_BUF_LEN	512
 
-struct bpf_printf_buf {
-	char tmp_buf[MAX_PRINTF_BUF_LEN];
+/* Support executing three nested bprintf helper calls on a given CPU */
+struct bpf_bprintf_buffers {
+	char tmp_bufs[3][MAX_PRINTF_BUF_LEN];
 };
-static DEFINE_PER_CPU(struct bpf_printf_buf, bpf_printf_buf);
-static DEFINE_PER_CPU(int, bpf_printf_buf_used);
+static DEFINE_PER_CPU(struct bpf_bprintf_buffers, bpf_bprintf_bufs);
+static DEFINE_PER_CPU(int, bpf_bprintf_nest_level);
 
 static int try_get_fmt_tmp_buf(char **tmp_buf)
 {
-	struct bpf_printf_buf *bufs;
-	int used;
+	struct bpf_bprintf_buffers *bufs;
+	int nest_level;
 
 	preempt_disable();
-	used = this_cpu_inc_return(bpf_printf_buf_used);
-	if (WARN_ON_ONCE(used > 1)) {
-		this_cpu_dec(bpf_printf_buf_used);
+	nest_level = this_cpu_inc_return(bpf_bprintf_nest_level);
+	if (WARN_ON_ONCE(nest_level > ARRAY_SIZE(bufs->tmp_bufs))) {
+		this_cpu_dec(bpf_bprintf_nest_level);
 		preempt_enable();
 		return -EBUSY;
 	}
-	bufs = this_cpu_ptr(&bpf_printf_buf);
-	*tmp_buf = bufs->tmp_buf;
+	bufs = this_cpu_ptr(&bpf_bprintf_bufs);
+	*tmp_buf = bufs->tmp_bufs[nest_level - 1];
 
 	return 0;
 }
 
 void bpf_bprintf_cleanup(void)
 {
-	if (this_cpu_read(bpf_printf_buf_used)) {
-		this_cpu_dec(bpf_printf_buf_used);
+	if (this_cpu_read(bpf_bprintf_nest_level)) {
+		this_cpu_dec(bpf_bprintf_nest_level);
 		preempt_enable();
 	}
 }
-- 
2.31.1.607.g51e8a6a459-goog

