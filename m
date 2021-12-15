Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13CE1476061
	for <lists+bpf@lfdr.de>; Wed, 15 Dec 2021 19:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244739AbhLOSMh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Dec 2021 13:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbhLOSMg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Dec 2021 13:12:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955BEC06173E;
        Wed, 15 Dec 2021 10:12:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55095B82004;
        Wed, 15 Dec 2021 18:12:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1EE1C36AE3;
        Wed, 15 Dec 2021 18:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639591954;
        bh=2wZ+UURKbZvHgojJB88tl5FRcu4BOxSu67wzI+vjpGg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HM0rnVLZfljLK9JJWxd9NPQHToafZgrI3Ceo0hU3/fNXFMYUPxdddNPdundo3qDnB
         o2BWvHOBSgqf7mok2IUODXYHYvY1mWjZrv+GDqfYZyLeeA804VNza9C/X+Ci4IkJnF
         POjDDw7nh7uUXRKA2ytDjX30qbLVynnxVJuRY1RnV9uw0vNL/VMw2DvHbOFuWE4n1b
         D+S+FldxVtWlvoztxC8Oe/aHqEoQLvS6yalyje1nHXmQDQrbvtV7mc9TdA1fcLadRZ
         jOUnPWUyvJFOeNCmvwFpF/iOo6LQtWKvaiw85IHAExHRhRIq4hVu0NKvvISJU6j1gN
         8iDEosJ4pMHOA==
From:   Jakub Kicinski <kuba@kernel.org>
To:     daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org
Cc:     bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@linux.ibm.com,
        agordeev@linux.ibm.com, akpm@linux-foundation.org,
        peterx@redhat.com, linux-s390@vger.kernel.org
Subject: [PATCH bpf-next v4 1/3] add includes masked by cgroup -> bpf dependency
Date:   Wed, 15 Dec 2021 10:12:29 -0800
Message-Id: <20211215181231.1053479-2-kuba@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211215181231.1053479-1-kuba@kernel.org>
References: <20211215181231.1053479-1-kuba@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

cgroup pulls in BPF which pulls in a lot of includes.
We're about to break that chain so fix those who were
depending on it.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: hca@linux.ibm.com
CC: gor@linux.ibm.com
CC: borntraeger@linux.ibm.com
CC: agordeev@linux.ibm.com
CC: akpm@linux-foundation.org
CC: peterx@redhat.com
CC: linux-s390@vger.kernel.org
---
 arch/s390/mm/hugetlbpage.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
index da36d13ffc16..082793d497ec 100644
--- a/arch/s390/mm/hugetlbpage.c
+++ b/arch/s390/mm/hugetlbpage.c
@@ -9,6 +9,7 @@
 #define KMSG_COMPONENT "hugetlb"
 #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
 
+#include <asm/pgalloc.h>
 #include <linux/mm.h>
 #include <linux/hugetlb.h>
 #include <linux/mman.h>
-- 
2.31.1

