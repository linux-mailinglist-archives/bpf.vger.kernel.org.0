Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F74D47685E
	for <lists+bpf@lfdr.de>; Thu, 16 Dec 2021 03:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbhLPCzn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Dec 2021 21:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbhLPCzn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Dec 2021 21:55:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34E33C06173E;
        Wed, 15 Dec 2021 18:55:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C49DD61BF5;
        Thu, 16 Dec 2021 02:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5A8C36AE3;
        Thu, 16 Dec 2021 02:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639623342;
        bh=7X9ZmUGE+B1m0xkLxOJiwH84nbiN+L9KsIInhdbCtVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c1BbK6Y2VWmKhBFVSdVOYyHL4NenIXxV+gpv+wQ5hqP8azUpj0xbc8C7GB5uI0MRI
         6FC24EWUxADPfp0QfoZ3Gqx758dEjysX65y7IBfa1yHvuJ9aBSg60XuHIwJEXLfaiR
         jezwj1ja0Zl27wtNh7NJK61lLleW8Qa1UxX5A4sKefyUqVDYcvsWjTLCgCBPvLkAMW
         g9Pf3oVIg0rrkS70dJKetdUJaL14n1YmMzfP8yastRcZ6QzdB2H6Gzt9LiWLKI5Wu6
         hWTqEbJMR5gF5C1F95Kci2fAkIHb+QeQ3iYZmjeEXYBQ3ybqCpy4UKkzjMntkN02ID
         Ay4nj3Mpxb6Lw==
From:   Jakub Kicinski <kuba@kernel.org>
To:     daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org
Cc:     bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@linux.ibm.com,
        agordeev@linux.ibm.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, kafai@fb.com, songliubraving@fb.com,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        peterx@redhat.com, akpm@linux-foundation.org,
        linux-s390@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: [PATCH bpf-next v5 1/3] add includes masked by cgroup -> bpf dependency
Date:   Wed, 15 Dec 2021 18:55:36 -0800
Message-Id: <20211216025538.1649516-2-kuba@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211216025538.1649516-1-kuba@kernel.org>
References: <20211216025538.1649516-1-kuba@kernel.org>
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
CC: peterz@infradead.org
CC: mingo@redhat.com
CC: acme@kernel.org
CC: mark.rutland@arm.com
CC: alexander.shishkin@linux.intel.com
CC: jolsa@redhat.com
CC: namhyung@kernel.org
CC: ast@kernel.org
CC: daniel@iogearbox.net
CC: andrii@kernel.org
CC: kafai@fb.com
CC: songliubraving@fb.com
CC: yhs@fb.com
CC: john.fastabend@gmail.com
CC: kpsingh@kernel.org
CC: peterx@redhat.com
CC: akpm@linux-foundation.org
CC: linux-s390@vger.kernel.org
CC: linux-perf-users@vger.kernel.org
CC: bpf@vger.kernel.org
---
 arch/s390/mm/hugetlbpage.c | 1 +
 include/linux/perf_event.h | 1 +
 2 files changed, 2 insertions(+)

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
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 0dcfd265beed..4a021149eaf0 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -611,6 +611,7 @@ struct swevent_hlist {
 #define PERF_ATTACH_SCHED_CB	0x20
 #define PERF_ATTACH_CHILD	0x40
 
+struct bpf_prog;
 struct perf_cgroup;
 struct perf_buffer;
 
-- 
2.31.1

