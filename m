Return-Path: <bpf+bounces-42989-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEA89AD92A
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 03:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD6F62831E3
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 01:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853DE4120B;
	Thu, 24 Oct 2024 01:23:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5341EB3D
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 01:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729733036; cv=none; b=Gs/p/ZNTetBwT25JAYMq2Q/DNlHheWTEP7AIjUpTRnQL/fu+TbOcz03e0kQffY598k+99JHLFB+x01Qr+Ngm6qrl0mFOj6yaMv/+2xXYHXaZSoxGkVYuHQhXhZEnEFsOFVTrzJITb2TwTDiVpLpUyrZNwx1Didnrb9odcpj6ghk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729733036; c=relaxed/simple;
	bh=dyjktZLe91SK9TTUBkXn0CkFxO9iqIVLpqzkJ6XLDVg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cYUC+p+ydG78U4PwR0Timxo9MHFGT1cRajkhallJqWPLpZYVusmjs7RYecMI1e0hej7rsQYZNK/X22Q2PQs5SeTBSS7oMR5q3yjqJVHWUEsaXgcs3Xx9vQjRuwW4GgMAKt9BRVHrWlwyLgl9TqwEr+mOWQvDNoEyU87+bAm+3dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XYp8N2T1Qz4f3lWD
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 09:23:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 97E411A06D7
	for <bpf@vger.kernel.org>; Thu, 24 Oct 2024 09:23:50 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgAXTMihoRln4mXLEw--.33103S6;
	Thu, 24 Oct 2024 09:23:50 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: bpf@vger.kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
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
Subject: [PATCH bpf v3 2/2] bpf: Check validity of link->type in bpf_link_show_fdinfo()
Date: Thu, 24 Oct 2024 09:35:58 +0800
Message-Id: <20241024013558.1135167-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20241024013558.1135167-1-houtao@huaweicloud.com>
References: <20241024013558.1135167-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAXTMihoRln4mXLEw--.33103S6
X-Coremail-Antispam: 1UD129KBjvJXoW7CF4kAF48Xw18uw1rZFWfAFb_yoW8XF4UpF
	WfGw1UWw4S9F429F13Jr4avryYgF4UG3W7Jr9rWw1FyF13ZFWkKF1jqFyfXF9xKFZ3Kr1f
	XryavFy3Xw17ZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFSdy
	UUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

If a newly-added link type doesn't invoke BPF_LINK_TYPE(), accessing
bpf_link_type_strs[link->type] may result in an out-of-bounds access.

To spot such missed invocations early in the future, checking the
validity of link->type in bpf_link_show_fdinfo() and emitting a warning
when such invocations are missed.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/syscall.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8cfa7183d2ef..9b6592c7e562 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3069,13 +3069,17 @@ static void bpf_link_show_fdinfo(struct seq_file *m, struct file *filp)
 {
 	const struct bpf_link *link = filp->private_data;
 	const struct bpf_prog *prog = link->prog;
+	enum bpf_link_type type = link->type;
 	char prog_tag[sizeof(prog->tag) * 2 + 1] = { };
 
-	seq_printf(m,
-		   "link_type:\t%s\n"
-		   "link_id:\t%u\n",
-		   bpf_link_type_strs[link->type],
-		   link->id);
+	if (type < ARRAY_SIZE(bpf_link_type_strs) && bpf_link_type_strs[type]) {
+		seq_printf(m, "link_type:\t%s\n", bpf_link_type_strs[type]);
+	} else {
+		WARN_ONCE(1, "missing BPF_LINK_TYPE(...) for link type %u\n", type);
+		seq_printf(m, "link_type:\t<%u>\n", type);
+	}
+	seq_printf(m, "link_id:\t%u\n", link->id);
+
 	if (prog) {
 		bin2hex(prog_tag, prog->tag, sizeof(prog->tag));
 		seq_printf(m,
-- 
2.29.2


