Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1B10F59F4
	for <lists+bpf@lfdr.de>; Fri,  8 Nov 2019 22:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732536AbfKHVdP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Nov 2019 16:33:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33556 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732137AbfKHVdN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 8 Nov 2019 16:33:13 -0500
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 795B65D612
        for <bpf@vger.kernel.org>; Fri,  8 Nov 2019 21:33:12 +0000 (UTC)
Received: by mail-lj1-f200.google.com with SMTP id l12so1547879lji.10
        for <bpf@vger.kernel.org>; Fri, 08 Nov 2019 13:33:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=BiQhD3lhOOPyI/TJ9HVvq9h3gpiDFD7ZG1O5n1PsnQo=;
        b=uTOTpNbhkb59tqHwGHZnynUMBXuKUWPRFNcHnPsT9n7YA6IsuUCCakqaoAFDAyukjy
         49mIzJTWy852znaGDL7CjKseE8zyg/moePV6P6Z7/zZeeb+lLqWqmG7Ir2/tDFQ8uGNS
         HyKWIWqwuaYEnSvjnzF0WzhJ/JgeQlRT3RrWFhBQ1evKl5bow5sd7HBftSWVVNM0gd49
         aRLSxttXqw7f9kh0LaWR6qZ8aMF6BlkCim4bih7WdWLpFOtZBA3OlFPyfKq5q1VNHlHQ
         qGbTCeokQqf7k5UGbp8N1ZEvtsohJYPa74jR7Ihm20U/6Tw3Z9dwaNyl+BBCMeZ21IZ8
         A/uQ==
X-Gm-Message-State: APjAAAV+s3gJw8T11nPWbXtEZa15dKb829rDyc7A8XmjduhPiosN/2LH
        GZaFSBWe1Nytf+Ss7sCvKkG2bT6fXGUdy9ptP9wsVbGud3eKt+DaFt/cwqeAQiIuDlZeh5VA9hC
        qhBhBpjw5zlGN
X-Received: by 2002:a2e:84c9:: with SMTP id q9mr7912302ljh.163.1573248791051;
        Fri, 08 Nov 2019 13:33:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqz4d3xozYcEnBmlweGpt5e9wPkHYsoy39YA6+ZSu0UsBXNOlNnaKjFsIQUvvMi15x6bsun4yQ==
X-Received: by 2002:a2e:84c9:: with SMTP id q9mr7912286ljh.163.1573248790781;
        Fri, 08 Nov 2019 13:33:10 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id c22sm3629480lfj.28.2019.11.08.13.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 13:33:10 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id AA5791800BD; Fri,  8 Nov 2019 22:33:09 +0100 (CET)
Subject: [PATCH bpf-next v2 4/6] libbpf: Use pr_warn() when printing netlink
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
Date:   Fri, 08 Nov 2019 22:33:09 +0100
Message-ID: <157324878956.910124.856248605977418231.stgit@toke.dk>
In-Reply-To: <157324878503.910124.12936814523952521484.stgit@toke.dk>
References: <157324878503.910124.12936814523952521484.stgit@toke.dk>
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

