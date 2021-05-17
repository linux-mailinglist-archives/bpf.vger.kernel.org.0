Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A92B738284A
	for <lists+bpf@lfdr.de>; Mon, 17 May 2021 11:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235544AbhEQJaK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 May 2021 05:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236001AbhEQJaJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 May 2021 05:30:09 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29851C06174A
        for <bpf@vger.kernel.org>; Mon, 17 May 2021 02:28:53 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r12so5628485wrp.1
        for <bpf@vger.kernel.org>; Mon, 17 May 2021 02:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QvrLOSKHI2fJCJkZwbWCONQINEKi3W3/3dDgjZ+UXwI=;
        b=WYAd48+QKjaDH4Za9nTjih8+OmyktTPOPPWIQT4yMZmQCxNHFuR4BubBE16LGLQEao
         kWYJ2ZOTBbQJotgYER3zKidiH+E+bHX94NammSoQUi3H2g81QUBBvkbimcBB4MduAba+
         j6/5QNkZ7avwu/ggX5PFmUuuTk6hlgGv0CrZU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QvrLOSKHI2fJCJkZwbWCONQINEKi3W3/3dDgjZ+UXwI=;
        b=HuH7fUBrE7c0sX/fkiDgDvJyMGkaeMhNTJbyk8EmKtVVtSkmdSRsysWCaFGK1BkEwa
         FyvZ/jMczZxkpvhQPOkCSux46hOP7KxUW0GAgNqy6RVCp5Qi12DL7fyA5dWPf1FsqBEF
         gI0aExOKnQkes78VeD5iBl1bqrUoe6fOB5PdU3eNYlasrn0BgKF5tVKLCqdpPQejIokN
         v8YD7eIQR7dqHRi5AYqto4MQAj+IdBMf8A+bPUjkybRXVtlAxjuPTu0UdhQRvLEuAFA1
         k6TxrcoRVwNZOLRIc2emlkOfCYEa9cN1ghKpUk/2GIujYLcygh+6EwYujdpcsRtwZKD+
         engw==
X-Gm-Message-State: AOAM533dRLabLfCB3N+R0NDveQsZolngQyEUQmFcoyBwypfnev1FlqUF
        QCMsQDqVE1Ld8qrNzuWGlxh/lyKcPvzmSA==
X-Google-Smtp-Source: ABdhPJzPLDy87vJgeW0xxhn0RMCksPboSqnFJDWIeZrZI3CbzDCy9W5urLtEZkYI/bGaCetCj494aA==
X-Received: by 2002:adf:dfca:: with SMTP id q10mr28440440wrn.343.1621243731714;
        Mon, 17 May 2021 02:28:51 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:61:302:6c6d:556b:3e10:9fd0])
        by smtp.gmail.com with ESMTPSA id e8sm16316616wrt.30.2021.05.17.02.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 02:28:51 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kpsingh@kernel.org, jackmanb@google.com,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH bpf 2/2] bpf: Avoid using ARRAY_SIZE on an uninitialized pointer
Date:   Mon, 17 May 2021 11:28:30 +0200
Message-Id: <20210517092830.1026418-2-revest@chromium.org>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
In-Reply-To: <20210517092830.1026418-1-revest@chromium.org>
References: <20210517092830.1026418-1-revest@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The cppcheck static code analysis reported the following error:
>> helpers.c:713:43: warning: Uninitialized variable: bufs [uninitvar]
    if (WARN_ON_ONCE(nest_level > ARRAY_SIZE(bufs->tmp_bufs))) {
                                             ^

ARRAY_SIZE is a macro that expands to sizeofs, so bufs is not actually
dereferenced at runtime, and the code is actually safe. But to keep
things tidy, this patch removes the need for a call to ARRAY_SIZE by
extracting the size of the array into a macro. Cppcheck should no longer
be confused and the code ends up being a bit cleaner.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Florent Revest <revest@chromium.org>
---
 kernel/bpf/helpers.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 3a5ab614cbb0..73443498d88f 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -698,8 +698,9 @@ static int bpf_trace_copy_string(char *buf, void *unsafe_ptr, char fmt_ptype,
 #define MAX_BPRINTF_BUF_LEN	512
 
 /* Support executing three nested bprintf helper calls on a given CPU */
+#define MAX_BPRINTF_NEST_LEVEL	3
 struct bpf_bprintf_buffers {
-	char tmp_bufs[3][MAX_BPRINTF_BUF_LEN];
+	char tmp_bufs[MAX_BPRINTF_NEST_LEVEL][MAX_BPRINTF_BUF_LEN];
 };
 static DEFINE_PER_CPU(struct bpf_bprintf_buffers, bpf_bprintf_bufs);
 static DEFINE_PER_CPU(int, bpf_bprintf_nest_level);
@@ -711,7 +712,7 @@ static int try_get_fmt_tmp_buf(char **tmp_buf)
 
 	preempt_disable();
 	nest_level = this_cpu_inc_return(bpf_bprintf_nest_level);
-	if (WARN_ON_ONCE(nest_level > ARRAY_SIZE(bufs->tmp_bufs))) {
+	if (WARN_ON_ONCE(nest_level > MAX_BPRINTF_NEST_LEVEL)) {
 		this_cpu_dec(bpf_bprintf_nest_level);
 		preempt_enable();
 		return -EBUSY;
-- 
2.31.1.751.gd2f1c929bd-goog

