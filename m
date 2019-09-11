Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 495D0B0374
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2019 20:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbfIKSSz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Sep 2019 14:18:55 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32941 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbfIKSSz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Sep 2019 14:18:55 -0400
Received: by mail-pf1-f196.google.com with SMTP id q10so14223233pfl.0
        for <bpf@vger.kernel.org>; Wed, 11 Sep 2019 11:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cbarcenas.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OxH44ra1+gEp9PWWFB00ytYJnw6f4HSrr96GTfwUaLM=;
        b=uM4ST25kZeMGH3xIGggXJ7qcZByoytX4C0P66Ir1DUdk4x/0nlibaJRPkMlXIGJ0bo
         cYOls3HSJajX2wheZbMT78Ad5yQ+s4bIloqmb1BYUajusfkorCuj9ds6u4zRMMarZqCs
         8NFCOsP8yrwIalWoHauNwof+wsznRDcYASlFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OxH44ra1+gEp9PWWFB00ytYJnw6f4HSrr96GTfwUaLM=;
        b=AjUY84en18ooPQUI4xZ48HpZ/9YdipV5Z5zbziNefbQN6zAniIdykPeYeVYN9hA6sx
         CGcKvrDakDI4ZQXF78wP7ix7iCoylseP5AcYrubLmEz1FnuUAU0eETLN/7FGVxRSdWmJ
         57eWwM7c23BWj87e8vBgRGGjr/1sb84HNlHNoreIIzv1HdKagW3meQLdvTG1Wp/gC+aC
         X4pxyzy8VZkKU0iLMQ+RLOjLWJZ2yj6ABTuMX9iUcsHj6FtBMrWfIcxX0V3w12WZYoBY
         L+cSwDrY4QTVl3tyBsBHsegf2tbqJjXoQ3zaOZpJI3krQcS2EHtYDDNLMFvTysQ6OYA+
         DWBg==
X-Gm-Message-State: APjAAAXCi+1oJqTUCBJMDpaDVLsfy2mw7ixDjNf+ZEAPELNbyo7iS7uJ
        F4YH98Uk40/tz2QWFIKMF0xrfA==
X-Google-Smtp-Source: APXvYqwDzRSTJ2VvR0WVQbknFfffWNjfYRWGVhAFRabRPFTDbb2EOlQ7wqyR93+J3C96qXZttqYvJg==
X-Received: by 2002:a63:c013:: with SMTP id h19mr34319325pgg.108.1568225933157;
        Wed, 11 Sep 2019 11:18:53 -0700 (PDT)
Received: from localhost.localdomain (70-35-54-238.static.wiline.com. [70.35.54.238])
        by smtp.gmail.com with ESMTPSA id k14sm19122310pgi.20.2019.09.11.11.18.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Sep 2019 11:18:52 -0700 (PDT)
From:   Christian Barcenas <christian@cbarcenas.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        Christian Barcenas <christian@cbarcenas.com>,
        bpf@vger.kernel.org
Subject: [PATCH bpf] bpf: respect CAP_IPC_LOCK in RLIMIT_MEMLOCK check
Date:   Wed, 11 Sep 2019 11:18:16 -0700
Message-Id: <20190911181816.89874-1-christian@cbarcenas.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A process can lock memory addresses into physical RAM explicitly
(via mlock, mlockall, shmctl, etc.) or implicitly (via VFIO,
perf ring-buffers, bpf maps, etc.), subject to RLIMIT_MEMLOCK limits.

CAP_IPC_LOCK allows a process to exceed these limits, and throughout
the kernel this capability is checked before allowing/denying an attempt
to lock memory regions into RAM.

Because bpf locks its programs and maps into RAM, it should respect
CAP_IPC_LOCK. Previously, bpf would return EPERM when RLIMIT_MEMLOCK was
exceeded by a privileged process, which is contrary to documented
RLIMIT_MEMLOCK+CAP_IPC_LOCK behavior.

Fixes: aaac3ba95e4c ("bpf: charge user for creation of BPF maps and programs")
Signed-off-by: Christian Barcenas <christian@cbarcenas.com>
---
 kernel/bpf/syscall.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 272071e9112f..e551961f364b 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -183,8 +183,9 @@ void bpf_map_init_from_attr(struct bpf_map *map, union bpf_attr *attr)
 static int bpf_charge_memlock(struct user_struct *user, u32 pages)
 {
 	unsigned long memlock_limit = rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
+	unsigned long locked = atomic_long_add_return(pages, &user->locked_vm);
 
-	if (atomic_long_add_return(pages, &user->locked_vm) > memlock_limit) {
+	if (locked > memlock_limit && !capable(CAP_IPC_LOCK)) {
 		atomic_long_sub(pages, &user->locked_vm);
 		return -EPERM;
 	}
@@ -1231,7 +1232,7 @@ int __bpf_prog_charge(struct user_struct *user, u32 pages)
 
 	if (user) {
 		user_bufs = atomic_long_add_return(pages, &user->locked_vm);
-		if (user_bufs > memlock_limit) {
+		if (user_bufs > memlock_limit && !capable(CAP_IPC_LOCK)) {
 			atomic_long_sub(pages, &user->locked_vm);
 			return -EPERM;
 		}
-- 
2.23.0
