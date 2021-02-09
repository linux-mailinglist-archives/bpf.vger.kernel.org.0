Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD593159A9
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 23:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234395AbhBIWrk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 17:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234065AbhBIWUN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Feb 2021 17:20:13 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39610C0617A7
        for <bpf@vger.kernel.org>; Tue,  9 Feb 2021 14:18:29 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id fv24so2663507pjb.9
        for <bpf@vger.kernel.org>; Tue, 09 Feb 2021 14:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=IJr6rjdV0ge7ooDfMKWJj/dk9pIwsXcgC7YvK8nTUak=;
        b=InEoJpk9LyZYeLF0/9RsVHGrznhp1YhCNKUyHtVinTKmiyQuo6DeyVS3piPLA5O4cb
         ldYBhl9VdgBZqfgdwzXbvfgfxOAFGURyimUn3j7nOb+SVsnq1Nlm7ClMwDS2TY9uDVfB
         muAR2aNpy4HxkpmQ+zsSzb2lu+7ssVK6SGIQbapeB6B5nXjWa7tOxXxvo4mg39SqsFoB
         xDDrqRUkMtevHstpmlxov1a7qi7T4YSqnyGt6S4IIGzbxyXp3wtpCK5i+6oI2kaL8vFI
         Y422T3144vu/G5ycG+B6DRPvwkbnGpEbHUaRrBWVktQFNiS95sZ3QeG/l2YXZpujoDTd
         ylTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=IJr6rjdV0ge7ooDfMKWJj/dk9pIwsXcgC7YvK8nTUak=;
        b=cLYyecXUYjt5NghXBtEDoV9v+rzqpow5/m4TCMTfUHHDHHx4RvpNNBunu+GEeDie5U
         yxeUqCEi6sKibh+t4R76VerQbKpnGXGLYJbZQs3Z2e51Oh0Crli4Pw3r7MyLU5UuuGqa
         28Y0v+Ivh0kr2uVo0F4JtJ04Geg1s/r+RfYviI7DCB5rRFs5ZnQDZEKMNMSZDEK4ZQSJ
         w2oLtfDXxFTlfSzuUQk3Oj7V9HFCIBurXvtMebxZv4ye42S6td52saodBKvuEUFW1Zcf
         sVSsb4wXW370pfmTbikbjgiqZZH9uxGdrSzSd3Yk59z1zCsGlMSZNBy3XDiK7Dln7kw0
         +l0w==
X-Gm-Message-State: AOAM5311gh2FPzJRQAhmwt1IuFOAL1u2XUNtqLfYb3dacEAJJH8nJeEt
        jmyxZu3LmDChKzfVBRhL61Zd+Vk=
X-Google-Smtp-Source: ABdhPJy5tl47uJDJ2/4A3uDNCUkisIgBFwLvqPvYV6iSDsZCyNTo6WaNHXJU8WOl6QtJi5whnzgiP44=
Sender: "sdf via sendgmr" <sdf@sdf2.svl.corp.google.com>
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:1:b8:bd34:879f:b865])
 (user=sdf job=sendgmr) by 2002:a17:90a:4209:: with SMTP id
 o9mr22850pjg.75.1612909108659; Tue, 09 Feb 2021 14:18:28 -0800 (PST)
Date:   Tue,  9 Feb 2021 14:18:26 -0800
Message-Id: <20210209221826.922940-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01-goog
Subject: [PATCH bpf-next] libbpf: use AF_LOCAL instead of AF_INET in xsk.c
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We have the environments where usage of AF_INET is prohibited
(cgroup/sock_create returns EPERM for AF_INET). Let's use
AF_LOCAL instead of AF_INET, it should perfectly work with SIOCETHTOOL.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/lib/bpf/xsk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/xsk.c b/tools/lib/bpf/xsk.c
index 20500fb1f17e..ffbb588724d8 100644
--- a/tools/lib/bpf/xsk.c
+++ b/tools/lib/bpf/xsk.c
@@ -517,7 +517,7 @@ static int xsk_get_max_queues(struct xsk_socket *xsk)
 	struct ifreq ifr = {};
 	int fd, err, ret;
 
-	fd = socket(AF_INET, SOCK_DGRAM, 0);
+	fd = socket(AF_LOCAL, SOCK_DGRAM, 0);
 	if (fd < 0)
 		return -errno;
 
-- 
2.30.0.478.g8a0d178c01-goog

