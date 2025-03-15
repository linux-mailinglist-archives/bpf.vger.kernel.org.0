Return-Path: <bpf+bounces-54108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DE1A62E8C
	for <lists+bpf@lfdr.de>; Sat, 15 Mar 2025 15:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF1D67A33AD
	for <lists+bpf@lfdr.de>; Sat, 15 Mar 2025 14:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908D8202963;
	Sat, 15 Mar 2025 14:57:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1695011185
	for <bpf@vger.kernel.org>; Sat, 15 Mar 2025 14:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742050653; cv=none; b=S4kORYHyzw4pZ3/HhzDEZvwRWzys7iZGup4SfLIorlF5pXTgA0KJwDHzvbLaXIA5kSHdSJjhLvK1G76r9fexHpjqrT4N8qAzg4su4Fdmbf06v+C0y51hXZTi0io81GSh8xqsDO1Pkh2/RU12VpCXNocv22G2RfhCTF2nkXxiMtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742050653; c=relaxed/simple;
	bh=K0dCULXC2G6HXenHawqzd9J5kAY0WF4X/E6SiUQe0As=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ngwUJkGaUt9g3M3RQmJJAd6Gk0/NZDapVqVtJMhNmjkIIDE8q+ImxH7D/7V0yyYs9geRmgOScWEVBVJty4eg97PN7EYNRdBiZUBuZ019fzs4sbJuoSqOV7axPbU8KuTy1+0ct5Ot3QLO1Rs4AxtsLrM7U5/6Ip2hetGLDbYbrBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZFPTQ6wPdz4f3lgR
	for <bpf@vger.kernel.org>; Sat, 15 Mar 2025 22:56:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id EBB581A07BB
	for <bpf@vger.kernel.org>; Sat, 15 Mar 2025 22:57:22 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgAni19RldVnWsxPGg--.27761S4;
	Sat, 15 Mar 2025 22:57:22 +0800 (CST)
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
Subject: [RESEND][PATCH bpf-next] bpf: Check map->record at the beginning of check_and_free_fields()
Date: Sat, 15 Mar 2025 23:09:30 +0800
Message-Id: <20250315150930.1511727-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAni19RldVnWsxPGg--.27761S4
X-Coremail-Antispam: 1UD129KBjvdXoWrKr4rXw4DZryxZrykGryUJrb_yoWfKrc_K3
	y0yF1kKrsxC3ya93yUGan3WryxJryxKFnFvrs0qrZrtFyYq3Wrt3y8ZF98ZFyDJwsrJrZx
	XasxtrZFgw1fXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxAYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	UQ6p9UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

When there are no special fields in the map value, there is no need to
invoke bpf_obj_free_fields(). Therefore, checking the validity of
map->record in advance.

After the change, the benchmark result of the per-cpu update case in
map_perf_test increased by 40% under a 16-CPU VM.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/hashtab.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index c308300fc72f6..877298133fdae 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -787,6 +787,9 @@ static int htab_lru_map_gen_lookup(struct bpf_map *map,
 static void check_and_free_fields(struct bpf_htab *htab,
 				  struct htab_elem *elem)
 {
+	if (IS_ERR_OR_NULL(htab->map.record))
+		return;
+
 	if (htab_is_percpu(htab)) {
 		void __percpu *pptr = htab_elem_get_ptr(elem, htab->map.key_size);
 		int cpu;
-- 
2.29.2


