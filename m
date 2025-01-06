Return-Path: <bpf+bounces-47917-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4411EA0203D
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 09:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9076B3A30F1
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 08:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 872B91D88D7;
	Mon,  6 Jan 2025 08:07:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD551D6DBF;
	Mon,  6 Jan 2025 08:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736150820; cv=none; b=C6b13fDeTCSEt7yd/bWerUY5uvsWEwbXlUYOFc3azamHP90UYXTWUin/G8POKsyPlZ879xnGKi9aOFi+QyjT2jbBSNX+oZ0QWw5xzbPsWyzLyGA0HqeIZDHkmB0krodsMhCh7nn8ChZv67X6lTVJx03VIYDnaTIR0IWqrXWXXPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736150820; c=relaxed/simple;
	bh=epmiwvVSzgTJPZR2+YC9mv0nvURQFsG8ENopp9v8Ipg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wnid1D478SqE1ErGakTX4zPwDU9msJi/wCa2kVmNYfvZxESuPBN7WyXuOuCZ0M172wONT2LieURxFdSNvcyqUsjZ2TP2fFiVvTHQHLEuBHVq7UG7lIKt6ITgmEVgTgGj0lIARaf0w+ensXMDo4bfDhjKpmKopV3EsDBcq30EBh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YRRbH6Nrbz4f3jM1;
	Mon,  6 Jan 2025 16:06:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 012301A14A8;
	Mon,  6 Jan 2025 16:06:55 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgD3W2AZj3tnVG29AA--.29272S7;
	Mon, 06 Jan 2025 16:06:55 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
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
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf-next 03/19] bpf: Remove migrate_{disable|enable} in htab_elem_free
Date: Mon,  6 Jan 2025 16:18:44 +0800
Message-Id: <20250106081900.1665573-4-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20250106081900.1665573-1-houtao@huaweicloud.com>
References: <20250106081900.1665573-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3W2AZj3tnVG29AA--.29272S7
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar1kCrW3AF1UCw4DAF43Wrg_yoW8Ww4kpF
	WkGr4xKw40vFyqva13XF40grWUZrn7Kw17AFWDG34rt3s8ur97tw4fCFy2qFyFvry7Ar4f
	ZanFq3Wxta18CrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU14x
	RDUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

htab_elem_free() has two call-sites: delete_all_elements() has already
disabled migration, free_htab_elem() is invoked by other 4 functions:
__htab_map_lookup_and_delete_elem, __htab_map_lookup_and_delete_batch,
htab_map_update_elem and htab_map_delete_elem.

BPF syscall has already disabled migration before invoking
->map_update_elem, ->map_delete_elem, and ->map_lookup_and_delete_elem
callbacks for hash map. __htab_map_lookup_and_delete_batch() also
disables migration before invoking free_htab_elem(). ->map_update_elem()
and ->map_delete_elem() of hash map may be invoked by BPF program and
the running context of BPF program has already disabled migration.
Therefore, it is safe to remove the migration_{disable|enable} pair in
htab_elem_free()

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/hashtab.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 42af7fac61b9..1db71d25836e 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -895,13 +895,13 @@ static int htab_map_get_next_key(struct bpf_map *map, void *key, void *next_key)
 
 static void htab_elem_free(struct bpf_htab *htab, struct htab_elem *l)
 {
+	cant_migrate();
+
 	check_and_free_fields(htab, l);
 
-	migrate_disable();
 	if (htab->map.map_type == BPF_MAP_TYPE_PERCPU_HASH)
 		bpf_mem_cache_free(&htab->pcpu_ma, l->ptr_to_pptr);
 	bpf_mem_cache_free(&htab->ma, l);
-	migrate_enable();
 }
 
 static void htab_put_fd_value(struct bpf_htab *htab, struct htab_elem *l)
-- 
2.29.2


