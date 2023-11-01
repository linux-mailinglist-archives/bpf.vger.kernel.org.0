Return-Path: <bpf+bounces-13777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 207307DDB75
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 04:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 046EE1C20D93
	for <lists+bpf@lfdr.de>; Wed,  1 Nov 2023 03:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FB0EDD;
	Wed,  1 Nov 2023 03:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE33137F
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 03:23:49 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D72A4
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 20:23:48 -0700 (PDT)
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SKsmF41C7z4f3nV1
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 11:23:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0ACB51A0173
	for <bpf@vger.kernel.org>; Wed,  1 Nov 2023 11:23:45 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgCHHt6+xEFlSpMJEg--.58519S4;
	Wed, 01 Nov 2023 11:23:44 +0800 (CST)
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
	Anton Protopopov <aspsk@isovalent.com>,
	houtao1@huawei.com
Subject: [PATCH bpf-next 0/3] selftests/bpf: Fixes for map_percpu_stats test
Date: Wed,  1 Nov 2023 11:24:52 +0800
Message-Id: <20231101032455.3808547-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHHt6+xEFlSpMJEg--.58519S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Jr1UJrW3JFyUXw4rJrWxCrg_yoW8JrW5pF
	WrK3WrKrZ7tryaqw13tanrW3yrtrs5W3WjkF13tr4YvF1UJ34xKr48KF1jgrZxCrZYqr1a
	yay8tF1xWa1xZrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

BPF CI failed due to map_percpu_stats_percpu_hash from time to time [1].
It seems that the failure reason is per-cpu bpf memory allocator may not
be able to allocate per-cpu pointer successfully and it can not refill
free llist timely, and bpf_map_update_elem() will return -ENOMEM.

Patch #1 fixes the size of value passed to per-cpu map update API. The
problem was found when fixing the ENOMEM problem, so also post it in
this patchset. Patch #2 & #3 mitigates the ENOMEM problem by retrying
the update operation for non-preallocated per-cpu map.

Please see individual patches for more details. And comments are always
welcome.

Regards,
Tao

[1]: https://github.com/kernel-patches/bpf/actions/runs/6713177520/job/18244865326?pr=5909

Hou Tao (3):
  selftests/bpf: Use value with enough-size when updating per-cpu map
  selftests/bpf: Export map_update_retriable()
  selftsets/bpf: Retry map update for non-preallocated per-cpu map

 .../bpf/map_tests/map_percpu_stats.c          | 39 +++++++++++++++++--
 tools/testing/selftests/bpf/test_maps.c       | 17 +++++---
 tools/testing/selftests/bpf/test_maps.h       |  5 +++
 3 files changed, 53 insertions(+), 8 deletions(-)

-- 
2.29.2


