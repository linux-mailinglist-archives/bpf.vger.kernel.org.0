Return-Path: <bpf+bounces-12777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 551C97D0633
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 03:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1106A2822AD
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 01:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B2F803;
	Fri, 20 Oct 2023 01:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D40648
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 01:41:23 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF5A18E
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 18:41:08 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SBS3K28yDz4f3kkW
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 09:41:01 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgAnt9ar2jFlqF+2DQ--.48939S4;
	Fri, 20 Oct 2023 09:41:01 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Hsin-Wei Hung <hsinweih@uci.edu>,
	houtao1@huawei.com
Subject: [PATCH bpf v2 0/2] bpf: Fix bpf timer kmemleak
Date: Fri, 20 Oct 2023 09:42:12 +0800
Message-Id: <20231020014214.2471419-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAnt9ar2jFlqF+2DQ--.48939S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Cry8uF4UZw4xXw43CF1ftFb_yoW8GryDpa
	yrtw43Kr48AFsrJr4xtryDWryrta1kGr1UCr1fJ34UC3y7GryIvF1xKrya9a9xJFWIqF13
	ZF1IkFs5CF18AFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
	cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
	IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI
	42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
	IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
	z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected

From: Hou Tao <houtao1@huawei.com>

Hi,

The patchset aims to fix the kmemleak problem reported by Hsin-Wei Hung
[0]. Patch #1 fixes the kmemleak problem by re-checking map->usercnt
after timer->timer is assigned. Patch #2 adds a selftest for the
kmemleak problem. But it is a bit hard to reproduce the kmemleak by
only running the test and I managed to reproduce the problem by both
running the test and injecting delay before timer->timer is assigned in
bpf_timer_init().

Please see individual patches for more details. And comments are always
welcome.

Change Log:
v2:
  * patch #1: use smp_mb() instead of smp_mb__before_atomic()
  * patch #2: use WRITE_ONCE(timer->timer, x) to match the lockless read
              of timer->timer

v1: https://lore.kernel.org/bpf/20231017125717.241101-1-houtao@huaweicloud.com

Hou Tao (2):
  bpf: Check map->usercnt again after timer->timer is assigned
  selftests/bpf: Test race between map uref release and bpf timer init

 kernel/bpf/helpers.c                          |  18 ++-
 .../bpf/prog_tests/timer_init_race.c          | 138 ++++++++++++++++++
 .../selftests/bpf/progs/timer_init_race.c     |  56 +++++++
 3 files changed, 209 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/timer_init_race.c
 create mode 100644 tools/testing/selftests/bpf/progs/timer_init_race.c

-- 
2.29.2


