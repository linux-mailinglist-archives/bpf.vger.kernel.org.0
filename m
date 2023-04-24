Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8867E6ED23A
	for <lists+bpf@lfdr.de>; Mon, 24 Apr 2023 18:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232108AbjDXQME (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Apr 2023 12:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbjDXQMD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Apr 2023 12:12:03 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1DE7ED5
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 09:11:58 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-63b4e5fdb1eso5750416b3a.1
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 09:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682352718; x=1684944718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9E7wa/h/xIUbrZzCFk28pdskdyPqXZohi6RP97GqXBk=;
        b=N743ZIniIQD8V34LIBp/1DTXkVL2/jcJJJx/uSfRgytBeLO52Gx5haBN30cxXXwFjQ
         aQPb6Nrvvcw2Ix7a7YocczAmC5Xq7OGT7pi1CJOs46w3sFCxEmnHbkTQw7RLdMGuIZUs
         BKZQiZW+NWmPzdssQpobDBMgnNzFXmHH/oT0qtHKrE5ZRyhi6QL+71cFEX3HWw8/mqVE
         OMEJTiCnCkIXaqDWHMMktaVzEW9yrRFDD0qbz1rzuINon7jRAEE1eKXEGpSdnagqIakb
         ZasmQzNNkiaHALvSO5XV8QmWghVhtlRg7+bEH9mTWEm5HnbWHn/5Y/3zERBO0WOSUIMh
         7Dfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682352718; x=1684944718;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9E7wa/h/xIUbrZzCFk28pdskdyPqXZohi6RP97GqXBk=;
        b=djZxDoqzIvt0CrsAoZsHGDwA1E4LMRPVaP9WsiqwnBbwvt8aZLtlH3OeyRPUyqTaFR
         5/fK1AVozNtOSDGgmO8Ysa8i2jxoKvhWURAoagjCjvfMI2xCk1rcA46N/C0UdF2cbg/o
         VD7VoB3QRO8h5mHvnQDm99GoHuV9SVFtnuK9itjNSH0Vbz+4zErqeFr0qYVRisIF4fmE
         cawJ/vefil9blhR9e8IG7vD0UjyzCQnQGC79SPs/Z9p1nZ/OPGPFt4sd27KHNC7UWNZO
         OG36T1btFDz3BhouYNtsw0KsMnjEdcd1lLqJvg1p3lBhO8XX1SslOS0RQezWdYsU35bY
         sk+Q==
X-Gm-Message-State: AAQBX9fKFK8+lh4qysF9mEGXXiEv+XCCfgTSAWxhfzJb128Z7S8oVnyA
        FCbrEGYO8HnkfTOndbSTDN8=
X-Google-Smtp-Source: AKy350YXQ4HesAZ/6tGuU/8gCobgFm2Rl2M4yz6QjyQyIPRVwIBC8fghsqZv2EIGtgflw1VsH4lv3g==
X-Received: by 2002:a05:6a21:6d8f:b0:f2:7da5:f27e with SMTP id wl15-20020a056a216d8f00b000f27da5f27emr14742018pzb.21.1682352718225;
        Mon, 24 Apr 2023 09:11:58 -0700 (PDT)
Received: from vultr.guest ([64.176.50.146])
        by smtp.gmail.com with ESMTPSA id 20-20020a630514000000b005142206430fsm6775729pgf.36.2023.04.24.09.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 09:11:57 -0700 (PDT)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 2/2] fork: Rename mm_init to task_mm_init
Date:   Mon, 24 Apr 2023 16:11:04 +0000
Message-Id: <20230424161104.3737-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230424161104.3737-1-laoar.shao@gmail.com>
References: <20230424161104.3737-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The kernel will panic as follows when attaching fexit to mm_init,

[   86.549700] ------------[ cut here ]------------
[   86.549712] BUG: kernel NULL pointer dereference, address: 0000000000000078
[   86.549713] #PF: supervisor read access in kernel mode
[   86.549715] #PF: error_code(0x0000) - not-present page
[   86.549716] PGD 10308f067 P4D 10308f067 PUD 11754e067 PMD 0
[   86.549719] Oops: 0000 [#1] PREEMPT SMP NOPTI
[   86.549722] CPU: 9 PID: 9829 Comm: main_amd64 Kdump: loaded Not tainted 6.3.0-rc6+ #12
[   86.549725] RIP: 0010:check_preempt_wakeup+0xd1/0x310
[   86.549754] Call Trace:
[   86.549755]  <TASK>
[   86.549757]  check_preempt_curr+0x5e/0x70
[   86.549761]  ttwu_do_activate+0xab/0x350
[   86.549763]  try_to_wake_up+0x314/0x680
[   86.549765]  wake_up_process+0x15/0x20
[   86.549767]  insert_work+0xb2/0xd0
[   86.549772]  __queue_work+0x20a/0x400
[   86.549774]  queue_work_on+0x7b/0x90
[   86.549778]  drm_fb_helper_sys_imageblit+0xd7/0xf0 [drm_kms_helper]
[   86.549801]  drm_fbdev_fb_imageblit+0x5b/0xb0 [drm_kms_helper]
[   86.549813]  soft_cursor+0x1cb/0x250
[   86.549816]  bit_cursor+0x3ce/0x630
[   86.549818]  fbcon_cursor+0x139/0x1c0
[   86.549821]  ? __pfx_bit_cursor+0x10/0x10
[   86.549822]  hide_cursor+0x31/0xd0
[   86.549825]  vt_console_print+0x477/0x4e0
[   86.549828]  console_flush_all+0x182/0x440
[   86.549832]  console_unlock+0x58/0xf0
[   86.549834]  vprintk_emit+0x1ae/0x200
[   86.549837]  vprintk_default+0x1d/0x30
[   86.549839]  vprintk+0x5c/0x90
[   86.549841]  _printk+0x58/0x80
[   86.549843]  __warn_printk+0x7e/0x1a0
[   86.549845]  ? trace_preempt_off+0x1b/0x70
[   86.549848]  ? trace_preempt_on+0x1b/0x70
[   86.549849]  ? __percpu_counter_init+0x8e/0xb0
[   86.549853]  refcount_warn_saturate+0x9f/0x150
[   86.549855]  mm_init+0x379/0x390
[   86.549859]  bpf_trampoline_6442453440_0+0x23/0x1000
[   86.549862]  mm_init+0x5/0x390
[   86.549865]  ? mm_alloc+0x4e/0x60
[   86.549866]  alloc_bprm+0x8a/0x2e0
[   86.549869]  do_execveat_common.isra.0+0x67/0x240
[   86.549872]  __x64_sys_execve+0x37/0x50
[   86.549874]  do_syscall_64+0x38/0x90
[   86.549877]  entry_SYSCALL_64_after_hwframe+0x72/0xdc

The reason is that when we attach the btf id of the function mm_init we
actually attach the mm_init defined in init/main.c rather than the
function defined in kernel/fork.c. That can be proved by parsing
/sys/kernel/btf/vmlinux:

[2493] FUNC 'initcall_blacklist' type_id=2477 linkage=static
[2494] FUNC_PROTO '(anon)' ret_type_id=21 vlen=1
        'buf' type_id=57
[2495] FUNC 'early_randomize_kstack_offset' type_id=2494 linkage=static
[2496] FUNC 'mm_init' type_id=118 linkage=static
[2497] FUNC 'trap_init' type_id=118 linkage=static
[2498] FUNC 'thread_stack_cache_init' type_id=118 linkage=static

From the above information we can find that the FUNCs above and below
mm_init are all defined in init/main.c. So there's no doubt that the
mm_init is also the function defined in init/main.c.

So when a task calls mm_init and thus the bpf trampoline is triggered it
will use the information of the mm_init defined in init/main.c. Then the
panic will occur.

It seems that there're issues in btf, for example it is unnecessary to
generate btf for the functions annonated with __init. We need to improve
btf. However we also need to change the function defined in
kernel/fork.c to task_mm_init to better distinguish them. After it is
renamed to task_mm_init, the /sys/kernel/btf/vmlinux will be:

[13970] FUNC 'mm_alloc' type_id=13969 linkage=static
[13971] FUNC_PROTO '(anon)' ret_type_id=204 vlen=3
        'mm' type_id=204
        'p' type_id=197
        'user_ns' type_id=452
[13972] FUNC 'task_mm_init' type_id=13971 linkage=static
[13973] FUNC 'coredump_filter_setup' type_id=3804 linkage=static
[13974] FUNC_PROTO '(anon)' ret_type_id=197 vlen=2
        'orig' type_id=197
        'node' type_id=21
[13975] FUNC 'dup_task_struct' type_id=13974 linkage=static

And then attaching task_mm_init won't panic. Improving the btf will be
handled later.

This issue can be reproduced with a simple bpf program as such:
  SEC("fexit/mm_init")
  int fentry_run()
  {
      return 0;
  }

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/fork.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 0c92f22..af8110d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1116,7 +1116,7 @@ static void mm_init_uprobes_state(struct mm_struct *mm)
 #endif
 }
 
-static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
+static struct mm_struct *task_mm_init(struct mm_struct *mm, struct task_struct *p,
 	struct user_namespace *user_ns)
 {
 	int i;
@@ -1193,7 +1193,7 @@ struct mm_struct *mm_alloc(void)
 		return NULL;
 
 	memset(mm, 0, sizeof(*mm));
-	return mm_init(mm, current, current_user_ns());
+	return task_mm_init(mm, current, current_user_ns());
 }
 
 static inline void __mmput(struct mm_struct *mm)
@@ -1542,7 +1542,7 @@ static struct mm_struct *dup_mm(struct task_struct *tsk,
 
 	memcpy(mm, oldmm, sizeof(*mm));
 
-	if (!mm_init(mm, tsk, mm->user_ns))
+	if (!task_mm_init(mm, tsk, mm->user_ns))
 		goto fail_nomem;
 
 	err = dup_mmap(mm, oldmm);
-- 
1.8.3.1

