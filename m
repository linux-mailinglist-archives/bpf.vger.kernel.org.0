Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F217D83E38
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2019 02:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbfHGATi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Aug 2019 20:19:38 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41143 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbfHGATi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Aug 2019 20:19:38 -0400
Received: by mail-qt1-f194.google.com with SMTP id d17so7646610qtj.8
        for <bpf@vger.kernel.org>; Tue, 06 Aug 2019 17:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XRsl0hq2sktvUUN9RQLQt4ElBo/nkveeqhoqozaDdMo=;
        b=VHrmh+0FfYFYc6ASAFpV7lz0e8zO3xo2Tq93z3rFxeI4Au+N2uZtex27qAugn+0/cu
         mJCL/LnxBTnXsWILME5J0RoLjLEo4UBTOUDsnenYLXq55xPjcv6vBXhjI9Zq66atPW9h
         2zKmkOIrCV7bJ3lqorVGlSnkAHA5UCUfzbSTEdpL1+bHeMMkrSDN4+pN6/Ta0WjsC1ry
         OhDVg2sSz7HS+7BOTOKqm9I/wPta3XtzYrnfkSCTog0HmC4jdhEzV7u/+o5EFQRNqyno
         6lCzl/bRsL40AcQ35EZAfPbMsHHVZyRhsmbik9RzaTLMNyfjMuhUg90dwKApeFL32ii5
         vNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XRsl0hq2sktvUUN9RQLQt4ElBo/nkveeqhoqozaDdMo=;
        b=m27OICqGfmjQiIJaYo1pc/j4LoqsFD6o5gHMF742cU/cODYWzS5a/0N69o3O/Z0Oqw
         ZWx1P5sGBtdH7+qAsMbUs7Ykxs5Ujt7Rf8iMIpZc4VvzPp0yu/2CsJRijvaRdKKoFaXO
         kUc4pHHUggAXVacJYgW9Xme2SBLIqso8i3euRE7nPvBxEWlF5FP2P3k+ytZR2bzT1VQd
         1wbfDFpE4zT8Ssy6tFs0Pjbq5nU2+pQ7f1guFCE9HRLq3OL4+KmAVh3Pcu/rVk4VqV+E
         l4jnRxmvR7mJkmlxbROG/sITpZmbVSJZ/sgG4Oi9zJZb6+Ma5tPjzjYcP5NLvcRgZwxI
         kDLw==
X-Gm-Message-State: APjAAAXySP0+pEwAa8XF6rbSDzsHkwgNsvUOkRHBi1rJEayHkT8WuePC
        ZhN0fwQvt6cPKcFHQNgp0cLYiA==
X-Google-Smtp-Source: APXvYqy+VIxlXwV7g6+hU7VMi8uG8VheY3mhYYyLOi623igKtv3BlH0t3hHGqSYpq1nfGFQKKe71jQ==
X-Received: by 2002:a0c:99e6:: with SMTP id y38mr5717677qve.42.1565137177343;
        Tue, 06 Aug 2019 17:19:37 -0700 (PDT)
Received: from jkicinski-Precision-T1700.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id i5sm35547554qtp.20.2019.08.06.17.19.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 17:19:36 -0700 (PDT)
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        oss-drivers@netronome.com,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andy Lutomirski <luto@kernel.org>,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH bpf 2/2] tools: bpftool: add error message on pin failure
Date:   Tue,  6 Aug 2019 17:19:23 -0700
Message-Id: <20190807001923.19483-3-jakub.kicinski@netronome.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190807001923.19483-1-jakub.kicinski@netronome.com>
References: <20190807001923.19483-1-jakub.kicinski@netronome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

No error message is currently printed if the pin syscall
itself fails. It got lost in the loadall refactoring.

Fixes: 77380998d91d ("bpftool: add loadall command")
Reported-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>
---
CC: luto@kernel.org, sdf@google.com

 tools/bpf/bpftool/common.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index c52a6ffb8949..6a71324be628 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -204,7 +204,11 @@ int do_pin_fd(int fd, const char *name)
 	if (err)
 		return err;
 
-	return bpf_obj_pin(fd, name);
+	err = bpf_obj_pin(fd, name);
+	if (err)
+		p_err("can't pin the object (%s): %s", name, strerror(errno));
+
+	return err;
 }
 
 int do_pin_any(int argc, char **argv, int (*get_fd_by_id)(__u32))
-- 
2.21.0

