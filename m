Return-Path: <bpf+bounces-11431-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC2F7B9BD8
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 10:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 4819D1C2084A
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 08:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568FC6ABA;
	Thu,  5 Oct 2023 08:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGBrj8LM"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3AF538C
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 08:39:59 +0000 (UTC)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8528900A
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 01:39:57 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6c4d625da40so507311a34.1
        for <bpf@vger.kernel.org>; Thu, 05 Oct 2023 01:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696495197; x=1697099997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Md4/gNXefd/DLZFJxe4EWoi04i8hmvyR0NPZMEvk15U=;
        b=YGBrj8LMIFuE9Z7x8lwWSkk2TxYQGJYVecGq003nNbxHpafcCQoMIQxNe3ZpgruOQn
         MRkCO6ukHc0QYArvdfev/lH5afrSYHfLGQKb6mQPgN6amYYVEOS8/EOy0siWZg5gLSHQ
         aeBcFStvl+UTpu8wkHYZZHxtnSjI99u2JGN1j3JHz/HUzHoMF874WMoCZ7lZ9wTniJcO
         E0fQ+H7e7ksywv3uI143iWYzmnnoNPd9Per7M0jIpSdJEfeV3Zm+RLcwYE+bm1vz1+uK
         3qrf9ezwNJOY+Hmas3uBM/MBooZLUJ0dWNbKnAZZxgGOGqveGM/xzU6O0rmPSJ3HSOuc
         uTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696495197; x=1697099997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Md4/gNXefd/DLZFJxe4EWoi04i8hmvyR0NPZMEvk15U=;
        b=Ky9dzK2eK5sgAVSMFYnz55lZ5fexoZmtHBnD1RzQ2YpDOM8n4BBKZesy7TynAhQ//9
         eWfPpjegkDq896KNNyAU13YELs29qBVXUZ1QUNkIAjzhrnKCpcTj/gpbZEeUtNSXV7ok
         7Vq4tabMXLTjPn2glIVfB6zux3MItS0YJ8YBfpy8lJIOUqWbZ1GxZ4sqsQyFXzp4b3Rf
         QYycEJ7UIQ6kDTZcniaoMQZU0T4pnedgEuxuQ5faFoBjymnn9I3eyUq4vH02IGyln742
         EljnRsWWeyOsgyz/eFtwu57aLhoFgdA6aaUqSeI/Sb8cY7eChuQlfHGoQGoF7ledYW2X
         3y3g==
X-Gm-Message-State: AOJu0YzTBFyvxSRSXhBWpdMgoSjMHz4oSzot261CRtEKKBzYM1hbWHNs
	RrPSdo3XUemLJp+sVgyS1Dk=
X-Google-Smtp-Source: AGHT+IHGdaSqWTHMMM1pNDu7gNlQK1SHc2yw9EB0Y75tyI7GFsQC6mxUpEUzjFEmLOU71EEwwHME4Q==
X-Received: by 2002:a05:6870:911e:b0:1dd:7f3a:b8ee with SMTP id o30-20020a056870911e00b001dd7f3ab8eemr5170515oae.20.1696495197002;
        Thu, 05 Oct 2023 01:39:57 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac00:4fd4:5400:4ff:fe99:6afd])
        by smtp.gmail.com with ESMTPSA id n20-20020a638f14000000b00563e1ef0491sm924755pgd.8.2023.10.05.01.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 01:39:56 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Feng Zhou <zhoufeng.zf@bytedance.com>
Subject: [PATCH bpf-next 1/2] bpf: Fix missed rcu read lock in bpf_task_under_cgroup()
Date: Thu,  5 Oct 2023 08:39:52 +0000
Message-Id: <20231005083953.1281-1-laoar.shao@gmail.com>
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
Cc: Feng Zhou <zhoufeng.zf@bytedance.com>
---
 kernel/bpf/helpers.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index dd1c69e..bb521b1 100644
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
1.8.3.1


