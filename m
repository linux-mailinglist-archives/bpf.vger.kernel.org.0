Return-Path: <bpf+bounces-35367-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1F959399BB
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 08:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E34CB219C2
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 06:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EC514A0BF;
	Tue, 23 Jul 2024 06:32:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11C514A0A0;
	Tue, 23 Jul 2024 06:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721716329; cv=none; b=Dcm1vPt1N1BxSm98vFcMN3wBvFCUdOjOG7D5CYAbk2qyumsscQpJrypfcFYWTF9OqM9MdV1aZ1soqDxsKZyqHLCq2FrkunQ+HyorMlXtLTHscLTL5R6D6mFZhG7i/hNWaz48+GBu9QPq5wXzO8kKgcY1R0xqKWsRy6vxkKFXHyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721716329; c=relaxed/simple;
	bh=zn8p2mp8QXQP5W9qSz5N2++LCfixPhpzw/topBgjCvw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=clqIY786lS5BmpimiLJVLm5A4iz8CQZkHFs/W9IJUkPG6HC20oA2JvkptjpJ60gNrB2pntcVRLQrp8csNJPx+1B07eG8KZMP+Oi+usLnEJQxpHg2bjVYACKbSbVlbIOKzU5LJU2YxOsazSZ3PvO6uJ7OAbtvtwjE7BSKpWvVWig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WSnNz5nhQz4f3lCp;
	Tue, 23 Jul 2024 14:31:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 50B5E1A140D;
	Tue, 23 Jul 2024 14:32:01 +0800 (CST)
Received: from localhost.localdomain (unknown [10.67.175.61])
	by APP2 (Coremail) with SMTP id Syh0CgA34wpOTp9mjImuAw--.48686S2;
	Tue, 23 Jul 2024 14:31:59 +0800 (CST)
From: Zheng Yejian <zhengyejian@huaweicloud.com>
To: masahiroy@kernel.org,
	peterz@infradead.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	naveen.n.rao@linux.ibm.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	mcgrof@kernel.org,
	mathieu.desnoyers@efficios.com,
	nathan@kernel.org,
	nicolas@fjasle.eu,
	ojeda@kernel.org,
	akpm@linux-foundation.org,
	surenb@google.com,
	pasha.tatashin@soleen.com,
	kent.overstreet@linux.dev,
	james.clark@arm.com,
	jpoimboe@kernel.org
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-modules@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	bpf@vger.kernel.org,
	zhengyejian@huaweicloud.com
Subject: [PATCH v2 0/5] kallsyms: Emit symbol for holes in text and fix weak function issue
Date: Tue, 23 Jul 2024 14:32:53 +0800
Message-Id: <20240723063258.2240610-1-zhengyejian@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgA34wpOTp9mjImuAw--.48686S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWrW7ur4kXFWktryDur45KFg_yoWrZF1fpa
	y3Xrs8Kr4DAa1qgFW2kr4Fyr1Yq3ykG3srKas5K3yfZr1q9r1UXws2yw1DZayDXrW5Cay3
	trn7ZF4xKF1kA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Wrv_ZF1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26rWY6r4UJwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7sREfHUDUUUUU==
X-CM-SenderInfo: x2kh0w51hmxt3q6k3tpzhluzxrxghudrp/

Background of this patch set can be found in v1:
https://lore.kernel.org/all/20240613133711.2867745-1-zhengyejian1@huawei.com/

Here add a reproduction to show the impact to livepatch:
1. Add following hack to make livepatch-sample.ko do patch on do_one_initcall()
   which has an overriden weak function behind in vmlinux, then print the
   actually used __fentry__ location:

  diff --git a/kernel/livepatch/patch.c b/kernel/livepatch/patch.c
  index 90408500e5a3..20b75e7b1771 100644
  --- a/kernel/livepatch/patch.c
  +++ b/kernel/livepatch/patch.c
  @@ -173,6 +173,8 @@ static int klp_patch_func(struct klp_func *func)
                  unsigned long ftrace_loc;

                  ftrace_loc = ftrace_location((unsigned long)func->old_func);
  +               pr_info("%s: old_func=%pS ftrace_loc=%pS (%lx)\n", __func__,
  +                       func->old_func, (void *)ftrace_loc, ftrace_loc);
                  if (!ftrace_loc) {
                          pr_err("failed to find location for function '%s'\n",
                                  func->old_name);
  diff --git a/samples/livepatch/livepatch-sample.c b/samples/livepatch/livepatch-sample.c
  index cd76d7ebe598..c6e8e78e23b8 100644
  --- a/samples/livepatch/livepatch-sample.c
  +++ b/samples/livepatch/livepatch-sample.c
  @@ -38,7 +38,7 @@ static int livepatch_cmdline_proc_show(struct seq_file *m, void *v)

   static struct klp_func funcs[] = {
          {
  -               .old_name = "cmdline_proc_show",
  +               .old_name = "do_one_initcall",
                  .new_func = livepatch_cmdline_proc_show,
          }, { }
   };

2. We can see the size of do_one_initcall() is 0x27e:
  $ nm -nS vmlinux | grep do_one_initcall
  ffffffff810021e0 000000000000027e T do_one_initcall

3. Insert the livepatch ko, the expected ftrace_loc is do_one_initcall+0x4/0x27e but
   actually do_one_initcall+0x294/0x2c0 which is invalid, also its size is inaccurate.
   Then this livepatch can not properly work!!!

  # insmod livepatch-sample.ko
  [   17.942451] livepatch: klp_patch_func: old_func=do_one_initcall+0x0/0x2c0 ftrace_loc=do_one_initcall+0x294/0x2c0 (ffffffff81002474)
  #
  # cat /sys/kernel/tracing/available_filter_functions_addrs | grep ffffffff81002474
  ffffffff81002474 __ftrace_invalid_address___660

After this patch, this issue is gone:

  # insmod livepatch-sample.ko
  [   42.408632] livepatch: klp_patch_func: old_func=do_one_initcall+0x0/0x27e ftrace_loc=do_one_initcall+0x4/0x27e (ffffffff810021e4)
  # cat /sys/kernel/tracing/available_filter_functions_addrs | grep ffffffff810021e4
  ffffffff810021e4 do_one_initcall
  # cat /sys/kernel/tracing/enabled_functions
  do_one_initcall (1)   I     M   tramp: 0xffffffffa0020000 (klp_ftrace_handler+0x0/0x258)->klp_ftrace_handler+0x0/0x258

Changes:

v1->v2:
  - Drop patch which titled "kallsyms: Optimize multiple times of realloc() to one time of malloc()"
    as suggested by Masahiro;
    Link: https://lore.kernel.org/all/CAK7LNAQkSnZ1nVXiZH9kg52H-A_=urcsv-W7wGXvunMGhGX8Vw@mail.gmail.com/
  - Changes in PATCH 1/5:
    - Change may_exist_hole_after_symbol() to has_hole() and return bool type;
    - User realloc instead of malloc another table in emit_hole_symbols();
      Link: https://lore.kernel.org/all/CAK7LNAQaLc6aDK85qQtPHoCkQSGyL-TxXjpgJTfehe2Q1=jMSA@mail.gmail.com/
    - Use empty symbol type/name as a special case to represent the hole instead of
      using symbol "t__hole_symbol_XXXXX";
      Link: https://lore.kernel.org/all/CAK7LNARiR5z9hPRG932T7YjRWqkX_qZ7WKmbxx7iTo2w5YJojQ@mail.gmail.com/
  - Changes in PATCH 3/5:
    - Now name of hole symbol is NULL, so if __fentry__ is located in a hole,
      kallsyms_lookup() find an NULL name then will return 0, so drop the
      needless kallsyms_is_hole_symbol().

Zheng Yejian (5):
  kallsyms: Emit symbol at the holes in the text
  module: kallsyms: Determine exact function size
  ftrace: Skip invalid __fentry__ in ftrace_process_locs()
  ftrace: Fix possible out-of-bound issue in ftrace_process_locs()
  ftrace: Revert the FTRACE_MCOUNT_MAX_OFFSET workaround

 arch/powerpc/include/asm/ftrace.h |   7 --
 arch/x86/include/asm/ftrace.h     |   7 --
 include/linux/module.h            |  14 +++
 kernel/module/kallsyms.c          |  42 ++++++--
 kernel/trace/ftrace.c             | 171 ++++++------------------------
 scripts/kallsyms.c                |  95 ++++++++++++++++-
 scripts/link-vmlinux.sh           |   4 +-
 scripts/mksysmap                  |   2 +-
 8 files changed, 173 insertions(+), 169 deletions(-)

-- 
2.25.1


