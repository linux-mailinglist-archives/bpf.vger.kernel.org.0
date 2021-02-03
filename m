Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB3A30D3D7
	for <lists+bpf@lfdr.de>; Wed,  3 Feb 2021 08:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbhBCHHX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Feb 2021 02:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbhBCHHT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Feb 2021 02:07:19 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FECEC061573
        for <bpf@vger.kernel.org>; Tue,  2 Feb 2021 23:06:39 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d13so13935764plg.0
        for <bpf@vger.kernel.org>; Tue, 02 Feb 2021 23:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=J6aoxOrbMXyDLinhyZ7p1sxwjofGeUwTL7Xe+1l+0J8=;
        b=K1bcI0DQWbg9g62dUIiexGmnwyr1KLhsoK6AwScjolObKJ0YWW9qM3x9cb/lIIiXVl
         Ar1gajFWFdYfDeeh0Ey9QzE7YEkUFDwilxegHIR7fXo5PVP1u6VkANlYmeZkxUtn2S9x
         qcL+ca6Pp/5gCl8MEyjV+/rwySzjnZ21Fq/iLxbPkIaQpioyw+W8XgApydGACc+Tcfz3
         J38d/fpmooOXNQne1n2+urYYw0itxN7Ckvn8t5H2xguXZsDbq0I0v/rjtLyKEaT+iWDV
         9lfzo3PM908bh10SHPs3SDfbjfRstZ4ovzVBhvfI4dEvtKBGV69LR50y5946mJkbzzUb
         jdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=J6aoxOrbMXyDLinhyZ7p1sxwjofGeUwTL7Xe+1l+0J8=;
        b=Bdfx9tbvYIIOUHZinlpk8ddXPnlShl5RHSRP2W7sArQMFG+5SCQWDZti18qKNZOXWL
         zrd8yw4l8LJmCuRD/Xui2Gt9ag+1xfMFhBL9UyszSJeQ6lC7yacjFvtBD+Xe1JMaSWkp
         hgHYP+JYK/oR56zLIOz9DohxAahqgJ1oz7JGfFcEk/UKG8pVDYXj31VeTQjshPThEemO
         Z9uJZzrX0wtOKIAB0SatWX9zjywPFph7B2Jtbkd4Ozs0NoJUx0ucmBEsLdpYXocvUQGq
         ttqQCk94QUdhZzdkGzRHuvL6nYBhh2gW1JHn7TnBq0/Rli4QhQK7iM3lRTIliKzuyMPp
         kgjQ==
X-Gm-Message-State: AOAM533rQhXu1eo+DEY4IckzhmMh8Vk1E8/I05PU/2gITsZ5fH49W/lT
        bMbL736NG+1EHBM34GmJ9E0=
X-Google-Smtp-Source: ABdhPJxtRs+FNis9Jq/gJsVF1YbUqoJyNQKxMN3X31PMy5VQmi5H9Z3JLfHdCemWm0/iY3E34hcsiQ==
X-Received: by 2002:a17:90b:e86:: with SMTP id fv6mr1806400pjb.118.1612335998727;
        Tue, 02 Feb 2021 23:06:38 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([163.114.132.7])
        by smtp.gmail.com with ESMTPSA id p1sm993294pfn.21.2021.02.02.23.06.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Feb 2021 23:06:37 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, nborisov@suse.com, peterz@infradead.org,
        rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH bpf] bpf: Unbreak BPF_PROG_TYPE_KPROBE when kprobe is called via do_int3
Date:   Tue,  2 Feb 2021 23:06:36 -0800
Message-Id: <20210203070636.70926-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.13.5
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

The commit 0d00449c7a28 ("x86: Replace ist_enter() with nmi_enter()")
converted do_int3 handler to be "NMI-like".
That made old if (in_nmi()) check abort execution of bpf programs
attached to kprobe when kprobe is firing via int3
(For example when kprobe is placed in the middle of the function).
Remove the check to restore user visible behavior.

Fixes: 0d00449c7a28 ("x86: Replace ist_enter() with nmi_enter()")
Reported-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/trace/bpf_trace.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 6c0018abe68a..764400260eb6 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -96,9 +96,6 @@ unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx)
 {
 	unsigned int ret;
 
-	if (in_nmi()) /* not supported yet */
-		return 1;
-
 	cant_sleep();
 
 	if (unlikely(__this_cpu_inc_return(bpf_prog_active) != 1)) {
-- 
2.24.1

