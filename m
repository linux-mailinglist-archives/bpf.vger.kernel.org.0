Return-Path: <bpf+bounces-45059-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CF39D0768
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 02:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 491B21F229FF
	for <lists+bpf@lfdr.de>; Mon, 18 Nov 2024 01:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E460F1DFD1;
	Mon, 18 Nov 2024 01:13:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A43314F90
	for <bpf@vger.kernel.org>; Mon, 18 Nov 2024 01:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731892437; cv=none; b=su64oyMmg+vzhTnd4W33jyKHNKKsZML3YFYYBBJTCebT6Fm05qSqVp0P/KLxMYb8aemLgpc7/4Av+1x+PQTN1mLHo+FSrh1lfQXeN5mXNCxJpPltMDlxV4hMfpPxW/hDS/0jXXh9bRzv9LrFydmZv/M3tLlZzyxDYQC3GLo6YLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731892437; c=relaxed/simple;
	bh=ux9RPWoDbSeBk2aKBY7zdhgp2sZTekAnpbGIKfOcY/A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f0EADbhPxKHhOfNWL0Ap/EK/LBW1y34ZIZHXOfP+16FGx12gN/wUcg4tLX/cTAxJ5cxk6EYM2TFz9ekpr9lSnlzOrSW/aNp2K8Ye6piGDX20EmIFwIFu7sjePxOjhtJRMj5m4GdN40ucJoqX2q/ZD3uA06VJwwSpDl7epyKsjFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Xs8Lh62NHz4f3lfR
	for <bpf@vger.kernel.org>; Mon, 18 Nov 2024 08:55:40 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2D0891A0568
	for <bpf@vger.kernel.org>; Mon, 18 Nov 2024 08:56:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgCXc4eckDpn2G5fCA--.44635S6;
	Mon, 18 Nov 2024 08:55:59 +0800 (CST)
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
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf-next 02/10] bpf: Remove unnecessary kfree(im_node) in lpm_trie_update_elem
Date: Mon, 18 Nov 2024 09:08:00 +0800
Message-Id: <20241118010808.2243555-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20241118010808.2243555-1-houtao@huaweicloud.com>
References: <20241118010808.2243555-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXc4eckDpn2G5fCA--.44635S6
X-Coremail-Antispam: 1UD129KBjvkXoW8ZFW3Ary7Ar15Kw4fCr17p5X_CFWfpF4xKa
	s0yw4Fqw1Uua1vqrs5ur98G34xGw42g3WkKa93tFy5K3s3Ww18ua4YgF45XFWSyrs8AF1Y
	qrZYyw1ru3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy29KBj
	DU0xBIdaVrnRJUUUP2b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxK
	x2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXwA204
	8vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7
	M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr
	0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl
	6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x
	IIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_
	Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GF
	v_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0I385UU
	UUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

There is no need to call kfree(im_node) when updating element fails,
because im_node must be NULL. Remove the unnecessary kfree() for
im_node.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/lpm_trie.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/bpf/lpm_trie.c b/kernel/bpf/lpm_trie.c
index 73fd593d3745..c6f036e3044b 100644
--- a/kernel/bpf/lpm_trie.c
+++ b/kernel/bpf/lpm_trie.c
@@ -431,9 +431,7 @@ static long trie_update_elem(struct bpf_map *map,
 	if (ret) {
 		if (new_node)
 			trie->n_entries--;
-
 		kfree(new_node);
-		kfree(im_node);
 	}
 
 	spin_unlock_irqrestore(&trie->lock, irq_flags);
-- 
2.29.2


