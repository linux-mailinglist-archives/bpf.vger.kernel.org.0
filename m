Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18784752ED
	for <lists+bpf@lfdr.de>; Wed, 15 Dec 2021 07:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbhLOGTd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Dec 2021 01:19:33 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35300 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhLOGTc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Dec 2021 01:19:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40A7BB81EA3;
        Wed, 15 Dec 2021 06:19:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6D7C34609;
        Wed, 15 Dec 2021 06:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639549170;
        bh=2wZ+UURKbZvHgojJB88tl5FRcu4BOxSu67wzI+vjpGg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cJY6mbiGtZpelM733ZVHy5iyKgF8d2QjUT8uDpFPrhBbFkLklRldxvQIHNz5RKXIK
         PCKIeK5NZlQ37/+XC4PSSVMdrkSpMs05W8TJzzo/pkXw/y+RYD1QM511YJ6YcmFevn
         gZm8YSTXzUiLsDvK1TF3BeGpoaHJ4riANPU5t24tY7cPApKO/b40hGkMvFH0Fj3NVN
         +BYX4mVAfFaXIIU6+v8BNhppthN85cmQLdWHy/GZLAS4HEbhYdaq3+a/92x+Yhoo8h
         nu4cFGhp66boINMcpgfEBF9iiuUfz9D586hn3Yj+UAOVnI9ocRAaWmi8Gp2+V+7ixj
         DhVtvOowGGIow==
From:   Jakub Kicinski <kuba@kernel.org>
To:     daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org
Cc:     bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@linux.ibm.com,
        agordeev@linux.ibm.com, akpm@linux-foundation.org,
        peterx@redhat.com, linux-s390@vger.kernel.org
Subject: [PATCH bpf-next v3 1/3] add includes masked by cgroup -> bpf dependency
Date:   Tue, 14 Dec 2021 22:19:14 -0800
Message-Id: <20211215061916.715513-2-kuba@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211215061916.715513-1-kuba@kernel.org>
References: <20211215061916.715513-1-kuba@kernel.org>
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

