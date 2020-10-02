Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84400280B7D
	for <lists+bpf@lfdr.de>; Fri,  2 Oct 2020 02:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732836AbgJBAEy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Oct 2020 20:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbgJBAEx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Oct 2020 20:04:53 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90071C0613D0
        for <bpf@vger.kernel.org>; Thu,  1 Oct 2020 17:04:53 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f199so667603yba.12
        for <bpf@vger.kernel.org>; Thu, 01 Oct 2020 17:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=D/6wuu7G5ipBgz3n+vEqaRzmvPM65gW36ZXpDlR+Izo=;
        b=BlYac3o6Nrij7ij4sxT/qxVzzvCIgoOgTIoyEyHwPpFviC2fY8UVqmI2bDNaD696CI
         wL0L8N9BwDm5Z5uM2q1iA5c/fVZECoJ8Dh6fBoJmFgrEUpZraJsEB2yx2dyfO2elhwYN
         pnRYlozVBpDEU3ruiiND/PBdhwy2BjHh6WBItt4esjY56jxMorivKHNMflM5zpxByFC9
         SnnBagGNorww3Zvq9rAJ6frrQWCKkLe7PxjUxf8nOS5W3IcliTDJYUHk4Z/ipyRrDATg
         rJPofrUMx2fBNFC7YFlWwLl3Mxk+wr4a/pR7YHDzbJbi/xd0xcDA+mU5cIE+PJN4Dsc6
         ohDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=D/6wuu7G5ipBgz3n+vEqaRzmvPM65gW36ZXpDlR+Izo=;
        b=R/Nb0kC5+dt00sQq8G8vgc3e7J64BKJnQRkXCstlrxzDkHvDvrlXXnWu2DDfe87piR
         UIT5iD22y2+/n8myNrwtv/3fs2BfuvLuxeXytUyY3x9TZqM6ks7c8fXvoT43JvroxPWZ
         eajPW3SwEZy/qtlr+odtXt+7KOOGwSMWJGzEWqOBmiguWKqAP/Ezw7Pqa0VGrNlXJyzh
         0yz9tbZktjahaUcACHg8uiBnOAolncBICMf4EKpY9M1hJ+fJUIgvlELMq2D3LexHN3Od
         CT6ZwgSJ7nkGenszfY4APSS7+odP3PRnWfVJHSmsC2I/heGnW6Gwjmo8aYvyTCCjA0Y2
         C5TQ==
X-Gm-Message-State: AOAM5327A3tVdd1X5QMNhVeDibPI9NUUehfRhFY5WvHzb2qQTtu+udFS
        NOrmVS8cpXHXecTIhRiBR+Jh+/E=
X-Google-Smtp-Source: ABdhPJzQlhHu9gt3HmQUwpsu9kt7xfdMf4F6/oIPnXRHh14wXdedhS/pxawGtdxPaeFk7MmIVfAVSN8=
Sender: "sdf via sendgmr" <sdf@sdf2.svl.corp.google.com>
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:1:7220:84ff:fe09:7732])
 (user=sdf job=sendgmr) by 2002:a25:c688:: with SMTP id k130mr13341967ybf.51.1601597092792;
 Thu, 01 Oct 2020 17:04:52 -0700 (PDT)
Date:   Thu,  1 Oct 2020 17:04:51 -0700
Message-Id: <20201002000451.1794044-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH bpf-next] selftests/bpf: properly initialize linfo in sockmap_basic
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When using -Werror=missing-braces, compiler complains about missing braces.
Let's use use ={} initialization which should do the job:

tools/testing/selftests/bpf/prog_tests/sockmap_basic.c: In function 'test_sockmap_iter':
tools/testing/selftests/bpf/prog_tests/sockmap_basic.c:181:8: error: missing braces around initializer [-Werror=missing-braces]
  union bpf_iter_link_info linfo = {0};
        ^
tools/testing/selftests/bpf/prog_tests/sockmap_basic.c:181:8: error: (near initialization for 'linfo.map') [-Werror=missing-braces]
tools/testing/selftests/bpf/prog_tests/sockmap_basic.c: At top level:

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/prog_tests/sockmap_basic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index 4c4224e3e10a..85f73261fab0 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -198,7 +198,7 @@ static void test_sockmap_copy(enum bpf_map_type map_type)
 {
 	DECLARE_LIBBPF_OPTS(bpf_iter_attach_opts, opts);
 	int err, len, src_fd, iter_fd, duration = 0;
-	union bpf_iter_link_info linfo = {0};
+	union bpf_iter_link_info linfo = {};
 	__u32 i, num_sockets, num_elems;
 	struct bpf_iter_sockmap *skel;
 	__s64 *sock_fd = NULL;
-- 
2.28.0.709.gb0816b6eb0-goog

