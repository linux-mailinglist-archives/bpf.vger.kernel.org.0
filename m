Return-Path: <bpf+bounces-11622-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 821D67BC811
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 16:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F35E5282299
	for <lists+bpf@lfdr.de>; Sat,  7 Oct 2023 14:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77CA27733;
	Sat,  7 Oct 2023 14:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxiPt5qF"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55AD23749
	for <bpf@vger.kernel.org>; Sat,  7 Oct 2023 14:00:12 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925DCB6
	for <bpf@vger.kernel.org>; Sat,  7 Oct 2023 07:00:06 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6969b391791so2386726b3a.3
        for <bpf@vger.kernel.org>; Sat, 07 Oct 2023 07:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696687201; x=1697292001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dpzkmLeAt7BQEAYyhM465wQCi7VPMI6aZUboDp9HsGU=;
        b=mxiPt5qFxEN02yQRrWAKUCOzKl5vW1nFMLpW1iBcm8UWtMKP94ihRdDZFngeGpTUCv
         v+bRI1Wjc7pFflVniDHVGatGMOs/erRRF3VrWpCvGGZumKycTeO0gpH2Pgn2yhKDRqQG
         SiDlA9UmsgC4EG/dwbsLDol4qBB5JjIfK7hIffsJ9Rx8jDyuQGPAP8sVBZZDvaEf1iIJ
         Y1kGJ2DW02edpm4XCDlAULlavyFLq1uHrdCuVzUVsBvEEPMu/AdqeFfkC1AH80bLgJNh
         JpxJ6WE3uS0dPl0+sHzD3u55bqdEBjSKpzzkmFjxTnu52IygH1NMe4lM10Au7BSG5o5j
         b7eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696687201; x=1697292001;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dpzkmLeAt7BQEAYyhM465wQCi7VPMI6aZUboDp9HsGU=;
        b=ByN5MnyHC0iCTpL6sRqQ4WJZJPipOy4fzUZ+JtsIXmRIfaCtKWG9n9IF7n2qQrK6rN
         rW18O0zooPiMaGu+y6gTrAZOa77L2rXYCXh2niL25LdLulANQPEhCl23E8b2qdErx16Y
         LFOS7yJaOEtKVqJh8Q7OuCElGnQ151T9Te5vU1qqSqF37nqUk6aBkW0AMLHssx06r6jz
         CKoYMbSBVQ+ZgXQf7RU4CXBvIUexc2Q1AwjMouiVk42zEj9MgnKTEIKmOB/+tzdy6k8H
         rGOQIn2WrVKcVdZbnsGoOAo2Qjs8zQ3dliiEQL7tp/Mz8M2AQYlMYJtYyme0u2f5WgV5
         +smQ==
X-Gm-Message-State: AOJu0YzRi/g+IGK/Hk2dgtILbfyblNfsEQzK0bIHxNLAWzSdcK523mk+
	sDdZXew2IfM9X5KghWJxhm0=
X-Google-Smtp-Source: AGHT+IG00leOJgmzz5affaYPBsYGUIdBOyfB21lFLm6gCJQ7sZS7VKB13NaCIfVUxmbQjGDlGkCfhA==
X-Received: by 2002:a05:6a00:39a2:b0:691:2d4:23b2 with SMTP id fi34-20020a056a0039a200b0069102d423b2mr11671653pfb.15.1696687200723;
        Sat, 07 Oct 2023 07:00:00 -0700 (PDT)
Received: from vultr.guest ([45.77.191.53])
        by smtp.gmail.com with ESMTPSA id i23-20020aa787d7000000b00682a908949bsm3302978pfo.92.2023.10.07.06.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 07:00:00 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Feng Zhou <zhoufeng.zf@bytedance.com>
Subject: [PATCH bpf-next v2 1/2] bpf: Fix missed rcu read lock in bpf_task_under_cgroup()
Date: Sat,  7 Oct 2023 13:59:44 +0000
Message-Id: <20231007135945.4306-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When employed within a sleepable program not under RCU protection, the use
of 'bpf_task_under_cgroup()' may trigger a warning in the kernel log,
particularly when CONFIG_PROVE_RCU is enabled.

[ 1259.662354] =============================
[ 1259.662357] WARNING: suspicious RCU usage
[ 1259.662358] 6.5.0+ #33 Not tainted
[ 1259.662360] -----------------------------
[ 1259.662361] include/linux/cgroup.h:423 suspicious rcu_dereference_check() usage!
[ 1259.662364]
other info that might help us debug this:

[ 1259.662366]
rcu_scheduler_active = 2, debug_locks = 1
[ 1259.662368] 1 lock held by trace/72954:
[ 1259.662369]  #0: ffffffffb5e3eda0 (rcu_read_lock_trace){....}-{0:0}, at: __bpf_prog_enter_sleepable+0x0/0xb0
[ 1259.662383]
stack backtrace:
[ 1259.662385] CPU: 50 PID: 72954 Comm: trace Kdump: loaded Not tainted 6.5.0+ #33
[ 1259.662391] Call Trace:
[ 1259.662393]  <TASK>
[ 1259.662395]  dump_stack_lvl+0x6e/0x90
[ 1259.662401]  dump_stack+0x10/0x20
[ 1259.662404]  lockdep_rcu_suspicious+0x163/0x1b0
[ 1259.662412]  task_css_set.part.0+0x23/0x30
[ 1259.662417]  bpf_task_under_cgroup+0xe7/0xf0
[ 1259.662422]  bpf_prog_7fffba481a3bcf88_lsm_run+0x5c/0x93
[ 1259.662431]  bpf_trampoline_6442505574+0x60/0x1000
[ 1259.662439]  bpf_lsm_bpf+0x5/0x20
[ 1259.662443]  ? security_bpf+0x32/0x50
[ 1259.662452]  __sys_bpf+0xe6/0xdd0
[ 1259.662463]  __x64_sys_bpf+0x1a/0x30
[ 1259.662467]  do_syscall_64+0x38/0x90
[ 1259.662472]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[ 1259.662479] RIP: 0033:0x7f487baf8e29
...
[ 1259.662504]  </TASK>

This issue can be reproduced by executing a straightforward program, as
demonstrated below:

SEC("lsm.s/bpf")
int BPF_PROG(lsm_run, int cmd, union bpf_attr *attr, unsigned int size)
{
        struct cgroup *cgrp = NULL;
        struct task_struct *task;
        int ret = 0;

        if (cmd != BPF_LINK_CREATE)
                return 0;

        // The cgroup2 should be mounted first
        cgrp = bpf_cgroup_from_id(1);
        if (!cgrp)
                goto out;
        task = bpf_get_current_task_btf();
        if (bpf_task_under_cgroup(task, cgrp))
                ret = -1;
        bpf_cgroup_release(cgrp);

out:
        return ret;
}

After running the program, if you subsequently execute another BPF program,
you will encounter the warning. It's worth noting that
task_under_cgroup_hierarchy() is also utilized by
bpf_current_task_under_cgroup(). However, bpf_current_task_under_cgroup()
doesn't exhibit this issue because it cannot be used in sleepable BPF
programs.

Fixes: b5ad4cdc46c7 ("bpf: Add bpf_task_under_cgroup() kfunc")
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Stanislav Fomichev <sdf@google.com>
Cc: Feng Zhou <zhoufeng.zf@bytedance.com>
---
 kernel/bpf/helpers.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index dd1c69ee3375..bb521b181cc3 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2212,7 +2212,12 @@ __bpf_kfunc struct cgroup *bpf_cgroup_from_id(u64 cgid)
 __bpf_kfunc long bpf_task_under_cgroup(struct task_struct *task,
 				       struct cgroup *ancestor)
 {
-	return task_under_cgroup_hierarchy(task, ancestor);
+	long ret;
+
+	rcu_read_lock();
+	ret = task_under_cgroup_hierarchy(task, ancestor);
+	rcu_read_unlock();
+	return ret;
 }
 #endif /* CONFIG_CGROUPS */
 
-- 
2.30.1 (Apple Git-130)


