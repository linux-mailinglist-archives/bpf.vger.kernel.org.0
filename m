Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7BDBF5C1F
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2019 01:01:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbfKIABD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Nov 2019 19:01:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50384 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727862AbfKIABD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Nov 2019 19:01:03 -0500
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 77D118125B
        for <bpf@vger.kernel.org>; Sat,  9 Nov 2019 00:01:02 +0000 (UTC)
Received: by mail-lf1-f69.google.com with SMTP id k30so1614795lfj.5
        for <bpf@vger.kernel.org>; Fri, 08 Nov 2019 16:01:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=+uTEROvAXIn7cfXeWKiRQvoN+m0g9SUDb6vRM4Q9nmw=;
        b=FINITl2BkSopp48xDvVnBz5gdfdqEBKaYQEkCBstzuyMGaFih0invcpzcG15DRy9er
         +Tp7dRnRyXoYIGW7xS3HJcfiaICIUX97lwGm9uUCZEwB/IMobayw0q03v7/o050sMCqS
         whTgQBGH4p245aIDOPRcJXi1jxWXhFNRit6qPOdA7DG2PfwJLflWrw5z+seaED5IEhEG
         avTGEMgQDdBhmPElp0iSboublFeE/hinIYRt+9QPtZYPFrVkZ182zHU3Z95VAadN5cJT
         It2P2BKMCObVid+oiStSqZoLIXtn4zUMN9INuaUZuqf2gN6fmTx2QXEUwoY1iYp5b83j
         eNVQ==
X-Gm-Message-State: APjAAAWADwi6CvPDvvGTaZC7cF/9n3GSYfHDnF3+v/ku14Wg5TST1ruU
        a935q/lQkZLGC+o4lXFwmTbflXrTNTB2mYe5eyQuw1kPPcPNdNjLj9DSIvKJ8XvHBlPrOOu6UoC
        7qdZiIfml0y2I
X-Received: by 2002:ac2:4243:: with SMTP id m3mr8294106lfl.24.1573257661019;
        Fri, 08 Nov 2019 16:01:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqxDwHhM4tgnFRifupGTocCo05Wf5BWkcj5RkRjmPSq8AGbXGdhvRmr5WpcPOUG+Y66lZCYzgw==
X-Received: by 2002:ac2:4243:: with SMTP id m3mr8294095lfl.24.1573257660863;
        Fri, 08 Nov 2019 16:01:00 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id v21sm3126954lfe.68.2019.11.08.16.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 16:01:00 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 1BAE71800CC; Sat,  9 Nov 2019 01:00:59 +0100 (CET)
Subject: [PATCH bpf-next v3 4/6] libbpf: Use pr_warn() when printing netlink
 errors
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Sat, 09 Nov 2019 01:00:59 +0100
Message-ID: <157325765904.27401.7758657875953932781.stgit@toke.dk>
In-Reply-To: <157325765467.27401.1930972466188738545.stgit@toke.dk>
References: <157325765467.27401.1930972466188738545.stgit@toke.dk>
User-Agent: StGit/0.21
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

The netlink functions were using fprintf(stderr, ) directly to print out
error messages, instead of going through the usual logging macros. This
makes it impossible for the calling application to silence or redirect
those error messages. Fix this by switching to pr_warn() in nlattr.c and
netlink.c.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Acked-by: David S. Miller <davem@davemloft.net>
Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/lib/bpf/netlink.c |    3 ++-
 tools/lib/bpf/nlattr.c  |   10 +++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/netlink.c b/tools/lib/bpf/netlink.c
index ce3ec81b71c0..a261df9cb488 100644
--- a/tools/lib/bpf/netlink.c
+++ b/tools/lib/bpf/netlink.c
@@ -12,6 +12,7 @@
 
 #include "bpf.h"
 #include "libbpf.h"
+#include "libbpf_internal.h"
 #include "nlattr.h"
 
 #ifndef SOL_NETLINK
@@ -43,7 +44,7 @@ int libbpf_netlink_open(__u32 *nl_pid)
 
 	if (setsockopt(sock, SOL_NETLINK, NETLINK_EXT_ACK,
 		       &one, sizeof(one)) < 0) {
-		fprintf(stderr, "Netlink error reporting not supported\n");
+		pr_warn("Netlink error reporting not supported\n");
 	}
 
 	if (bind(sock, (struct sockaddr *)&sa, sizeof(sa)) < 0) {
diff --git a/tools/lib/bpf/nlattr.c b/tools/lib/bpf/nlattr.c
index 1e69c0c8d413..8db44bbfc66d 100644
--- a/tools/lib/bpf/nlattr.c
+++ b/tools/lib/bpf/nlattr.c
@@ -8,6 +8,7 @@
 
 #include <errno.h>
 #include "nlattr.h"
+#include "libbpf_internal.h"
 #include <linux/rtnetlink.h>
 #include <string.h>
 #include <stdio.h>
@@ -121,8 +122,8 @@ int libbpf_nla_parse(struct nlattr *tb[], int maxtype, struct nlattr *head,
 		}
 
 		if (tb[type])
-			fprintf(stderr, "Attribute of type %#x found multiple times in message, "
-				  "previous attribute is being ignored.\n", type);
+			pr_warn("Attribute of type %#x found multiple times in message, "
+				"previous attribute is being ignored.\n", type);
 
 		tb[type] = nla;
 	}
@@ -181,15 +182,14 @@ int libbpf_nla_dump_errormsg(struct nlmsghdr *nlh)
 
 	if (libbpf_nla_parse(tb, NLMSGERR_ATTR_MAX, attr, alen,
 			     extack_policy) != 0) {
-		fprintf(stderr,
-			"Failed to parse extended error attributes\n");
+		pr_warn("Failed to parse extended error attributes\n");
 		return 0;
 	}
 
 	if (tb[NLMSGERR_ATTR_MSG])
 		errmsg = (char *) libbpf_nla_data(tb[NLMSGERR_ATTR_MSG]);
 
-	fprintf(stderr, "Kernel error message: %s\n", errmsg);
+	pr_warn("Kernel error message: %s\n", errmsg);
 
 	return 0;
 }

