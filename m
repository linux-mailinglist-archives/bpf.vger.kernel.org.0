Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE181425C86
	for <lists+bpf@lfdr.de>; Thu,  7 Oct 2021 21:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241854AbhJGTrD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Oct 2021 15:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241154AbhJGTqx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Oct 2021 15:46:53 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294B2C061771
        for <bpf@vger.kernel.org>; Thu,  7 Oct 2021 12:44:56 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v25so22395120wra.2
        for <bpf@vger.kernel.org>; Thu, 07 Oct 2021 12:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T7ah9JcOeuH9p74IgUUJnTD1owMghTgwQtnWNkA3pgY=;
        b=fXD4O3WWIhWTAjI40sylx7YPqN6qn0IjvYzlJpr7QEUeYi8iooyOEMU1ZYr2M7HT4+
         Ig0IfaBLUkhda4FtNZO+SVQj9BrUPlcN0ruL8A/k8KyJYBoHSscngS/6KtGf6TXnvxEH
         k3SBeWcvQzBaeXBq+S4g9D89WNLY5Wu6cq0/qAGIY67qQZLlzbfbRr1wtgq6tYLfhE9K
         tud7XHOz1pDcinoTVAdLmT5bNc4OZbhCXGskYwLiEuCU/pCovryQpViVVklyJTv04waZ
         6d5A3xtPh20mN16Jqti0vnQKLdlZdk0sxduUmMhV4xMwG4PLRwdwHsYqLDrfIEncIJ4E
         a+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T7ah9JcOeuH9p74IgUUJnTD1owMghTgwQtnWNkA3pgY=;
        b=7P362zoy64AuDfHJtGp9riGMGPelhjqNOMhP72X5WJ+mH3e/tSxQjBPyfpJOT+eDVt
         VkCHYGwQm15a35xIDVgkEz7YQkS5jc/dfQ5OdwkZJ8xPqtGrgpTGaUXAmOawDt1CO9E2
         unD1hz2gwWbnIWw2im1/k/+nXnJHcVBI9RcxQoyULuDbjibjdFHh8BRVJ8Y4cQ6VL9Ac
         erCbcXrTDDmZJANYg27z8XTgOyVXUghJN6uD2opO8ounPA66i1uxENP5EWwuPzlr2pZw
         KyCiRCYsYiRD7kALjsGOjgnkeT/TWa6NwJsPTzep4tpYXfMPy3JlztrCcFy+GxFcCEsH
         8ZyA==
X-Gm-Message-State: AOAM533akEu1tvvNrmzsYLXoeO22GCpVDCLcdasQgIXWXoZ9u+dmS9g/
        1txjYRTHEtWB7K4CtbLdB4zO1A==
X-Google-Smtp-Source: ABdhPJzTd+ixlbUNCSuPSkjOH7e6saHvidqG3gt8TQ53s+3hVcL41g0I/sGOJMfWdkzbufs7dRlplg==
X-Received: by 2002:a1c:2543:: with SMTP id l64mr18452803wml.9.1633635894795;
        Thu, 07 Oct 2021 12:44:54 -0700 (PDT)
Received: from localhost.localdomain ([149.86.87.165])
        by smtp.gmail.com with ESMTPSA id u2sm259747wrr.35.2021.10.07.12.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 12:44:54 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v4 10/12] samples/bpf: do not FORCE-recompile libbpf
Date:   Thu,  7 Oct 2021 20:44:36 +0100
Message-Id: <20211007194438.34443-11-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211007194438.34443-1-quentin@isovalent.com>
References: <20211007194438.34443-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In samples/bpf/Makefile, libbpf has a FORCE dependency that force it to
be rebuilt. I read this as a way to keep the library up-to-date, given
that we do not have, in samples/bpf, a list of the source files for
libbpf itself. However, a better approach would be to use the
"$(wildcard ...)" function from make, and to have libbpf depend on all
the .c and .h files in its directory. This is what samples/bpf/Makefile
does for bpftool, and also what the BPF selftests' Makefile does for
libbpf.

Let's update the Makefile to avoid rebuilding libbpf all the time (and
bpftool on top of it).

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 samples/bpf/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index cb72198f6b48..c9cee54ce79d 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -276,7 +276,8 @@ clean:
 	@find $(CURDIR) -type f -name '*~' -delete
 	@$(RM) -r $(CURDIR)/libbpf $(CURDIR)/bpftool
 
-$(LIBBPF): FORCE | $(LIBBPF_OUTPUT)
+$(LIBBPF): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) \
+	   | $(LIBBPF_OUTPUT)
 # Fix up variables inherited from Kbuild that tools/ build system won't like
 	$(MAKE) -C $(LIBBPF_SRC) RM='rm -rf' EXTRA_CFLAGS="$(TPROGS_CFLAGS)" \
 		LDFLAGS=$(TPROGS_LDFLAGS) srctree=$(BPF_SAMPLES_PATH)/../../ \
-- 
2.30.2

