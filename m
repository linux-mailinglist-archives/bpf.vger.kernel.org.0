Return-Path: <bpf+bounces-58921-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD45AC39A5
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 08:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C63D91892645
	for <lists+bpf@lfdr.de>; Mon, 26 May 2025 06:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8599D1C84BB;
	Mon, 26 May 2025 06:08:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754E31D5143
	for <bpf@vger.kernel.org>; Mon, 26 May 2025 06:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748239713; cv=none; b=Dp7zbCv8RLmjyfXUt5FpNCrW3Ztoq0pkhYJGToFUq6OAPVSMaS/91sEq6zT15pb8wKvxtGBayL072NaJlURNZzfa1ildH5sQxsH/AHIRGxEFwqGVOYHIUH/UqbQKzJ3ntOGXiTyur1MUaj46GdohBjQDr7L9U0pORmY9xinoM2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748239713; c=relaxed/simple;
	bh=k+yspxABU76yvnyF4E6lGcIFjBbksYm8Crtz1tg4gds=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=grGcBsfn37d2x3qU4vQ6oWWB6m4a3bTpgmbGRv4TUcSxvaGQn3Wc+qvwnAIJDXbxBiRu0sbhXwEMWEkZtoDlqs6O4ALi1nrA+xwT0ex7qPEm5oYNCajBhZu01ovN8GLnZ+XTRlS6fQZPffDUxmnN/zQAJmExfXEY1thuawJEKC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4b5QKs2L3mz4f3lDF
	for <bpf@vger.kernel.org>; Mon, 26 May 2025 14:08:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 1259F1A018D
	for <bpf@vger.kernel.org>; Mon, 26 May 2025 14:08:28 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgDXOl9aBTRoMQovNg--.11895S4;
	Mon, 26 May 2025 14:08:27 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	houtao1@huawei.com
Subject: [RFC PATCH bpf-next 0/3] bpf: Free the leaked special fields in hash map
Date: Mon, 26 May 2025 14:25:52 +0800
Message-Id: <20250526062555.1106061-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXOl9aBTRoMQovNg--.11895S4
X-Coremail-Antispam: 1UD129KBjvJXoW7CFW5Aw1DAr4rKF4rZryrJFb_yoW8XFyxpF
	Z5Kr13Gr4DtF1xAwn7JwsruayrJw4fGFW2kanIgw1Yyw1Sqr97Jr4Iga45XFyfJrW8tryf
	ZwnFvr98ua18ZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
	tVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IUbmii3UUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Hi,

The special fields in the non-preallocated hash map value may be leaked
if the bpf prog tries to initialize or reassign the special fields
(e.g., bpf_timer or kptr) after the map element has been removed from
hash map. These leakage can be demonstrated by the newly-added test
case.

To free these lingering special fields in hash map, the patch set
proposes adding a new dtor callback in bpf memory allocator and
implement the dtor for hash map. However, considering the bpf memory
alocator will be removed in the (near ?) future, I am not sure whether
or not it is the best way to handle the problem, hence add RFC tag for
the patch set to get more feedback.

Hou Tao (3):
  bpf: Add a new dtor callback argument for bpf_mem_alloc_init
  bpf: Implement bpf mem allocator dtor for hash map
  selftests/bpf: Add test cases for the leaked special fields in map
    value

 include/linux/bpf_mem_alloc.h                 |   5 +-
 kernel/bpf/bpf_local_storage.c                |   5 +-
 kernel/bpf/core.c                             |   2 +-
 kernel/bpf/cpumask.c                          |   2 +-
 kernel/bpf/hashtab.c                          |  35 +++-
 kernel/bpf/lpm_trie.c                         |   2 +-
 kernel/bpf/memalloc.c                         |  38 +++--
 .../prog_tests/special_fields_in_map_value.c  |  34 ++++
 .../bpf/progs/special_fields_in_map_value.c   | 159 ++++++++++++++++++
 9 files changed, 259 insertions(+), 23 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/special_fields_in_map_value.c
 create mode 100644 tools/testing/selftests/bpf/progs/special_fields_in_map_value.c

-- 
2.29.2


