Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9ABD23F4EA
	for <lists+bpf@lfdr.de>; Sat,  8 Aug 2020 00:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbgHGWit (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Aug 2020 18:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgHGWis (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Aug 2020 18:38:48 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5FAAC061756
        for <bpf@vger.kernel.org>; Fri,  7 Aug 2020 15:38:48 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d26so4550050yba.20
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2020 15:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Qj9/TfNVp3NnjEs+9soDUF8jF3QB3TPNXKn9Up++SLE=;
        b=nyYdVL66yoiwemUxRvTq0TQ5ULgyJJZTEAHH6A/RQhVc/lb7h3CMG7X+xuebEH2QeR
         F85qgArjLtIuSJwPHlHRmJDfe25JtNfDs+oQ1nHvbqdnn+Nho2kKI/1I9xhfRp01PUF7
         V5/CK7Uf0zr5lEjEO943VxDEsyX9mrzGNuqotlPS0bulwGqTnJoIWWLkS6+PUX1EnW1/
         Ng+GdRiGDZszrIXinrh/kmE8IFoJ0tO8GOp6TAnCoh0J6aEb10RJzABIwjGtvfLbRQzm
         bAo40sLwg1qfheUPZ+9YOtkM53HYp2cHuprUsKD9Bl65d19gjsHqcePWo6g9jt17w1Ud
         QfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Qj9/TfNVp3NnjEs+9soDUF8jF3QB3TPNXKn9Up++SLE=;
        b=morlFNYhXeDLVgu7ZMc8cCj/ZsT+nkM2m913R+YBDhfOHNHXfV3QgXTa8qWuAm6YD8
         s8AHlFCHGwxXG8I4xbHl7F4c1A2YnTbH6r1RkA33r0LC+Y6AJ71itKlIkkkYiR4q3TEz
         Ep3JTjjcxwF8R82D1HUFHT1El8yIpsXdy96wYR5AJ0ESKsdikEbalsoR9TKKsY7Ww83A
         4DkJ+j0ohAUCXLj1ht2h0ZMyGk5Nvu4aOxCcrvVi/yZXleHcn0fPcj0MW+u2smyb7MKt
         6sk4V5VbDxN7zjwBlryL79CfqzDZjO2pzJhkxd4agB+6OE5yJ11V5bWj+r1Mr1Z6Bo7t
         2xBg==
X-Gm-Message-State: AOAM530oHXOL88NUT3p2aLPdFXdtHeaihmAhq5itRrolalA8KwlOaMms
        hZP7xBCUcThp3UHBEF9pSYd3Vc0=
X-Google-Smtp-Source: ABdhPJxokK2Y7pEiBU2Yy1s63CaOnAOkZ7Yo6nyeWm9GAyH4RV+nvlML6Nz6s5eQGEd4Tp5BaipE4X8=
X-Received: by 2002:a25:3785:: with SMTP id e127mr26142705yba.191.1596839927685;
 Fri, 07 Aug 2020 15:38:47 -0700 (PDT)
Date:   Fri,  7 Aug 2020 15:38:46 -0700
Message-Id: <20200807223846.4190917-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [PATCH bpf] selftests/bpf: fix v4_to_v6 in sk_lookup
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I'm getting some garbage in bytes 8 and 9 when doing conversion
from sockaddr_in to sockaddr_in6 (leftover from AF_INET?).
Let's explicitly clear the higher bytes.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/prog_tests/sk_lookup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
index c571584c00f5..9ff0412e1fd3 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
@@ -309,6 +309,7 @@ static void v4_to_v6(struct sockaddr_storage *ss)
 	v6->sin6_addr.s6_addr[10] = 0xff;
 	v6->sin6_addr.s6_addr[11] = 0xff;
 	memcpy(&v6->sin6_addr.s6_addr[12], &v4.sin_addr.s_addr, 4);
+	memset(&v6->sin6_addr.s6_addr[0], 0, 10);
 }
 
 static int udp_recv_send(int server_fd)
-- 
2.28.0.236.gb10cc79966-goog

