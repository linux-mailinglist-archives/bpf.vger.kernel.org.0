Return-Path: <bpf+bounces-2579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D2272F697
	for <lists+bpf@lfdr.de>; Wed, 14 Jun 2023 09:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA12E1C20C3A
	for <lists+bpf@lfdr.de>; Wed, 14 Jun 2023 07:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FCC4430;
	Wed, 14 Jun 2023 07:42:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAC47F
	for <bpf@vger.kernel.org>; Wed, 14 Jun 2023 07:42:39 +0000 (UTC)
Received: from mail.208.org (unknown [183.242.55.162])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E958519B7
	for <bpf@vger.kernel.org>; Wed, 14 Jun 2023 00:42:36 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
	by mail.208.org (Postfix) with ESMTP id 4Qgy7Z6511zBQJYv
	for <bpf@vger.kernel.org>; Wed, 14 Jun 2023 15:42:34 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
	content-transfer-encoding:content-type:message-id:user-agent
	:references:in-reply-to:subject:to:from:date:mime-version; s=
	dkim; t=1686728554; x=1689320555; bh=snMogAIL9y2byMbsZXqj+hiozP/
	+XS6VEZBwL8D7BD8=; b=QCwMuqdVsxZLhCViwgbZUgy8hRFEaVoU5f6prngM7lj
	xh2B+HTGC5E3icZpe9pcHYrn82WrJ1tZCRJGtZSoCn11TzJ/ipPmkRhM7SiTpdVM
	Qv+Zu7eV8KP/vOOwyulFckqmtzXtLw7j5exUW/EKRv3CxWfBpVLWEMmd9v0Lr72E
	t5KiUlLOcM9QjZ86AO1w/3jf1pN79SKgVmkMEJU/VFf5nNA1Iwhot9YOZLLNJNVj
	01KjzIjRF3jYDx8i99yzBXy/rEYG/bB05ZA5PS0KQ+LWeDRl+jIQwU+Sy7mu9uV4
	1rZP7f1F/+zWHkWUqdD5cCGhscrvrtoOM4M3njOn4Lg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
	by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4meMK41imArz for <bpf@vger.kernel.org>;
	Wed, 14 Jun 2023 15:42:34 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
	by mail.208.org (Postfix) with ESMTPSA id 4Qgy7Z3WNczBQJYk;
	Wed, 14 Jun 2023 15:42:34 +0800 (CST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 14 Jun 2023 15:42:34 +0800
From: wuyonggang001@208suo.com
To: andrii@kernel.org, shuah@kernel.org
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/bpf: Fix the address is NULL
In-Reply-To: <20230614073443.4894-1-zhanglibing@cdjrlc.com>
References: <20230614073443.4894-1-zhanglibing@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <7f34bd3ce377d9d89626c2df8fa584e0@208suo.com>
X-Sender: wuyonggang001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fix the following coccicheck error:

tools/testing/selftests/bpf/progs/test_ksyms_weak.c:53:6-20: ERROR: test 
of a variable/field address

Signed-off-by: Yonggang Wu <wuyonggang001@208suo.com>
---
  tools/testing/selftests/bpf/progs/test_ksyms_weak.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/test_ksyms_weak.c 
b/tools/testing/selftests/bpf/progs/test_ksyms_weak.c
index d00268c91e19..768a4d6ee6f5 100644
--- a/tools/testing/selftests/bpf/progs/test_ksyms_weak.c
+++ b/tools/testing/selftests/bpf/progs/test_ksyms_weak.c
@@ -50,7 +50,7 @@ int pass_handler(const void *ctx)
      /* tests non-existent symbols. */
      out__non_existent_typed = (__u64)&bpf_link_fops2;

-    if (&bpf_link_fops2) /* can't happen */
+    if (&bpf_link_fops2 != NULL) /* can't happen */
          out__non_existent_typed = 
(__u64)bpf_per_cpu_ptr(&bpf_link_fops2, 0);

      if (!bpf_ksym_exists(bpf_task_acquire))

