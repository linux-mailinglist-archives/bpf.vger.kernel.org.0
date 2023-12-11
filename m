Return-Path: <bpf+bounces-17375-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0B880C209
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 08:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 177F81C20959
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 07:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D95C208A3;
	Mon, 11 Dec 2023 07:37:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C85D9
	for <bpf@vger.kernel.org>; Sun, 10 Dec 2023 23:37:44 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SpYVr15lfz4f3jZS
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 15:37:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 54E471A09BC
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 15:37:41 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP1 (Coremail) with SMTP id cCh0CgDn6xFBvHZlF2ZYDQ--.7860S4;
	Mon, 11 Dec 2023 15:37:39 +0800 (CST)
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
	houtao1@huawei.com
Subject: [PATCH bpf-next v2 0/2] bpf: Use GFP_KERNEL in bpf_event_entry_gen()
Date: Mon, 11 Dec 2023 15:38:41 +0800
Message-Id: <20231211073843.1888058-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDn6xFBvHZlF2ZYDQ--.7860S4
X-Coremail-Antispam: 1UD129KBjvJXoW7GF18CrW5Kw4kJFWfXw48Crg_yoW8Jr1rpr
	ZYka15XF4UtrnrX3s7Kay7GrW8Cw45Gr9rJFn3Jw1FvFyUXFyI9F18KF43ZFWYqryakFWS
	qw1akrn2ya48XFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
	cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
	IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI
	42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42
	IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
	87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Hi,

The simple patch set aims to replace GFP_ATOMIC by GFP_KERNEL in
bpf_event_entry_gen(). These two patches in the patch set were
preparatory patches in "Fix the release of inner map" patchset [1] and
are not needed for v2, so re-post it to bpf-next tree.

Patch #1 reduces the scope of rcu_read_lock when updating fd map and
patch #2 replaces GFP_ATOMIC by GFP_KERNEL. Please see individual
patches for more details.

Comments are always welcome.

Change Log:
v2:
 * patch #1: add rcu_read_lock/unlock() for bpf_fd_array_map_update_elem
             as well to make it consistent with
	     bpf_fd_htab_map_update_elem and update commit message
             accordingly (Alexei)
 * patch #1/#2: collects ack tags from Yonghong

v1: https://lore.kernel.org/bpf/20231208103357.2637299-1-houtao@huaweicloud.com

[1]: https://lore.kernel.org/bpf/20231107140702.1891778-1-houtao@huaweicloud.com

Hou Tao (2):
  bpf: Reduce the scope of rcu_read_lock when updating fd map
  bpf: Use GFP_KERNEL in bpf_event_entry_gen()

 kernel/bpf/arraymap.c | 4 +++-
 kernel/bpf/hashtab.c  | 2 ++
 kernel/bpf/syscall.c  | 4 ----
 3 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.29.2


