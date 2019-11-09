Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2BAF6184
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2019 21:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfKIUhi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 9 Nov 2019 15:37:38 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45943 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726569AbfKIUhf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 9 Nov 2019 15:37:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573331854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rH6r2De9GadkXLbCyN93me6DEPMZRHLuAF94Rklw8C8=;
        b=XiLhjxuSeTuykISQYU90oegugGcNYjbyTSqJ+9oBx9YQAHEcjf16bQjLfyIG4Fg2XouHe5
        qnmzOP5jYKXqoThqC4AFW+uy8x0mrjqaszD4oQyFQPO+x/hXb2Z4nCgBq9YZrtJd8QkdUj
        MhS5vgt1E62CsQyO2tQnlmaMfZU43g4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-KIDUutebMcKpE2S8f2o3tA-1; Sat, 09 Nov 2019 15:37:33 -0500
Received: by mail-ed1-f72.google.com with SMTP id l6so7329140edc.18
        for <bpf@vger.kernel.org>; Sat, 09 Nov 2019 12:37:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=+uTEROvAXIn7cfXeWKiRQvoN+m0g9SUDb6vRM4Q9nmw=;
        b=Sn/f3Ul585dZD4huXiOjUbCKBdXXQ6JUv4qBxsOiDvBtt8MJYxZ/a6Lf2vZbLHIeMY
         qpU34Kc1q3s6A9P9F1qxlC+sjIBxgwEGxmzCd1OBHYu3GgPI7Mg5H3/2rAqpdc/ABg6h
         8k649SCwa4jnn308i+BchebhIrLMYFYP1aZc+9ABw0+uOCm/kTdXBUSaOm6Jbq8Cc/F6
         oQKzDqHXuP4j8N7w9CGrZnSEn8w33fXIjmid7BPcMJdButh+EwxEMmA058BTkh6zUvQe
         r0LiTz9qclRaW5XFLRCzML4qA3OIJ3YfT+WKf3r+i5S6eqi7UUHZt1E5nGVfxwmQs0sg
         x2GA==
X-Gm-Message-State: APjAAAUPlk3Wm7NB0m2GAD4psi5Qtsn8svDBEaDa5K3TutqXZsOyXeKY
        /IoK1Xasek1LXk9VaKQ2bxlIx1FObNcNtOJyxqSlPBCF8trRIoXYdjYgxb+lF/2uX0C4ZqewQIe
        ot2rPCLYFnomS
X-Received: by 2002:a17:906:4098:: with SMTP id u24mr5046243ejj.220.1573331851982;
        Sat, 09 Nov 2019 12:37:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqyXH7lIVgPrtwMTO2Tegsgkfa0ZVq0M3RKgvOAhMZ09RVig9dQri4h++YRTQcoLW4X/chJLrA==
X-Received: by 2002:a17:906:4098:: with SMTP id u24mr5046231ejj.220.1573331851801;
        Sat, 09 Nov 2019 12:37:31 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id q2sm335016edj.38.2019.11.09.12.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2019 12:37:31 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9C5321800CC; Sat,  9 Nov 2019 21:37:30 +0100 (CET)
Subject: [PATCH bpf-next v4 4/6] libbpf: Use pr_warn() when printing netlink
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
Date:   Sat, 09 Nov 2019 21:37:30 +0100
Message-ID: <157333185055.88376.15999360127117901443.stgit@toke.dk>
In-Reply-To: <157333184619.88376.13377736576285554047.stgit@toke.dk>
References: <157333184619.88376.13377736576285554047.stgit@toke.dk>
User-Agent: StGit/0.21
MIME-Version: 1.0
X-MC-Unique: KIDUutebMcKpE2S8f2o3tA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

The netlink functions were using fprintf(stderr, ) directly to print out
error messages, instead of going through the usual logging macros. This
makes it impossible for the calling application to silence or redirect
those error messages. Fix this by switching to pr_warn() in nlattr.c and
netlink.c.

Acked-by: Andrii Nakryiko <andriin@fb.com>
Acked-by: David S. Miller <davem@davemloft.net>
Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
---
 tools/lib/bpf/netlink.c |    3 ++-
 tools/lib/bpf/nlattr.c  |   10 +++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/netlink.c b/tools/lib/bpf/netlink.c
index ce3ec81b71c0..a261df9cb488 100644
--- a/tools/lib/bpf/netlink.c
+++ b/tools/lib/bpf/netlink.c
@@ -12,6 +12,7 @@
=20
 #include "bpf.h"
 #include "libbpf.h"
+#include "libbpf_internal.h"
 #include "nlattr.h"
=20
 #ifndef SOL_NETLINK
@@ -43,7 +44,7 @@ int libbpf_netlink_open(__u32 *nl_pid)
=20
 =09if (setsockopt(sock, SOL_NETLINK, NETLINK_EXT_ACK,
 =09=09       &one, sizeof(one)) < 0) {
-=09=09fprintf(stderr, "Netlink error reporting not supported\n");
+=09=09pr_warn("Netlink error reporting not supported\n");
 =09}
=20
 =09if (bind(sock, (struct sockaddr *)&sa, sizeof(sa)) < 0) {
diff --git a/tools/lib/bpf/nlattr.c b/tools/lib/bpf/nlattr.c
index 1e69c0c8d413..8db44bbfc66d 100644
--- a/tools/lib/bpf/nlattr.c
+++ b/tools/lib/bpf/nlattr.c
@@ -8,6 +8,7 @@
=20
 #include <errno.h>
 #include "nlattr.h"
+#include "libbpf_internal.h"
 #include <linux/rtnetlink.h>
 #include <string.h>
 #include <stdio.h>
@@ -121,8 +122,8 @@ int libbpf_nla_parse(struct nlattr *tb[], int maxtype, =
struct nlattr *head,
 =09=09}
=20
 =09=09if (tb[type])
-=09=09=09fprintf(stderr, "Attribute of type %#x found multiple times in me=
ssage, "
-=09=09=09=09  "previous attribute is being ignored.\n", type);
+=09=09=09pr_warn("Attribute of type %#x found multiple times in message, "
+=09=09=09=09"previous attribute is being ignored.\n", type);
=20
 =09=09tb[type] =3D nla;
 =09}
@@ -181,15 +182,14 @@ int libbpf_nla_dump_errormsg(struct nlmsghdr *nlh)
=20
 =09if (libbpf_nla_parse(tb, NLMSGERR_ATTR_MAX, attr, alen,
 =09=09=09     extack_policy) !=3D 0) {
-=09=09fprintf(stderr,
-=09=09=09"Failed to parse extended error attributes\n");
+=09=09pr_warn("Failed to parse extended error attributes\n");
 =09=09return 0;
 =09}
=20
 =09if (tb[NLMSGERR_ATTR_MSG])
 =09=09errmsg =3D (char *) libbpf_nla_data(tb[NLMSGERR_ATTR_MSG]);
=20
-=09fprintf(stderr, "Kernel error message: %s\n", errmsg);
+=09pr_warn("Kernel error message: %s\n", errmsg);
=20
 =09return 0;
 }

