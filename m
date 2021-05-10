Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26D50379941
	for <lists+bpf@lfdr.de>; Mon, 10 May 2021 23:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbhEJVig (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 May 2021 17:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232632AbhEJVid (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 May 2021 17:38:33 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6EEC061761
        for <bpf@vger.kernel.org>; Mon, 10 May 2021 14:37:27 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id v12so18056261wrq.6
        for <bpf@vger.kernel.org>; Mon, 10 May 2021 14:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9XUgLuGGfG6fvCOnoM0als/tlAr9SP064P/RkEd2QVU=;
        b=g2VR9mc7Hr1AaxZrqangX0oRdrVDaAmH1eVSa5vu5/S8167IX0pEK8PeEHNgcokNb/
         uYmlGwNo1x8lWVoY30trqupYSWEY6N50H7H6cCp/1PTwS8A3SpF+j/9oy+3baOrIh6U4
         ROA5tbFICipzi0OmOZfMD+IE2VOfw99qOzg+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9XUgLuGGfG6fvCOnoM0als/tlAr9SP064P/RkEd2QVU=;
        b=P8FAJl2ej20zDMXJl63exv6orUBc62bsX9Ysf39g13lzDEVKz6MUEppZHjMIUFeCdI
         vWKd8W+EC4mxm/lqyk0LITDal2MGwxOr9KlPZ4d9UDriKncNRb74RMRnMbMOVYvde1dN
         TQBsy3C0sWGSMe47QmtBwlyzD9gI75uB5kav7LtAPsQxd8atw/mvM/UW3ncr1GOyLpzd
         5BMYuC4g8RL/e0RDgwgHNyShgGmJfGLh3Dy9fxNid7lG+WqE+ezQjuxEbtmxRUeXdJBq
         peBS80vn9vlZpJZMJ1Z/8zgdiHOFJEc7HPOOYNsg2hS2nMBzep1T2grr+uCpPOeXW5qR
         2wfw==
X-Gm-Message-State: AOAM531VmaPN2bx1wZPEIdenVL/Pp2Ciy3wCT/ZSyWEKfM/JvVWfYCAf
        oQOtcKT3v9VWbjyS739BR0StCmsM/mb9ZA==
X-Google-Smtp-Source: ABdhPJyGbp6cuYMaS0B0oIRAgdeVdc18BO8J+/8W/s84Bn4K4Zz7KIcCPrqhQzPlv89666Bem2FpZw==
X-Received: by 2002:adf:f683:: with SMTP id v3mr32914523wrp.133.1620682645559;
        Mon, 10 May 2021 14:37:25 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:61:302:5cab:f78e:32e4:87aa])
        by smtp.gmail.com with ESMTPSA id l12sm28136463wrq.36.2021.05.10.14.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 14:37:25 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@kernel.org, jackmanb@google.com,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>,
        syzbot+63122d0bc347f18c1884@syzkaller.appspotmail.com
Subject: [PATCH bpf] bpf: Fix nested bpf_bprintf_prepare with more per-cpu buffers
Date:   Mon, 10 May 2021 23:37:09 +0200
Message-Id: <20210510213709.2004366-1-revest@chromium.org>
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
index 544773970dbc..302410ebbea9 100644
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
+static DEFINE_PER_CPU(struct bpf_bprintf_bufs, bpf_bprintf_bufs);
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
+	bufs = this_cpu_ptr(&bpf_bprintf_buf);
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

