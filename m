Return-Path: <bpf+bounces-41217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3725C9943A5
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 11:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68A0E1C20F90
	for <lists+bpf@lfdr.de>; Tue,  8 Oct 2024 09:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FEB1C2DCB;
	Tue,  8 Oct 2024 09:05:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4B61C1AB8
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 09:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728378313; cv=none; b=PREyk57nrLcPIoHJVzDe+dfSLNYZueeueFDtjJlNDYoAPMtxPRlsQdo/X9/Za61/cMgnwWAQY2hC2H8CoCjW0Ze0O1ycZaZxoSLtbhm5pInMhG1OpiLM3GAgrJ0SyoqVHo91r7dFbvAXmjwVoeiVPPPfc1N3f9T6UKTwh2wS1y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728378313; c=relaxed/simple;
	bh=fBKAuFfKFhWQx+oYNlggM3JHv0wdtY9wWS1rwjHoRU8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BgDsmOV/ybImMY4IQNljd+Jl+/GW69S0G3z01nLLdpzlUwEU+474JgUIc6Fi1TojR4O+eh4dE0E0WJaroeyVAcmFiEzD2y68LNSPwASP9/piilvtz87kPUdKw2fzuj7wpeCKi57QC7f1XFyyHMCsRImbW31Jo78i40Z5lpqZTuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XN98864w5z4f3jsx
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 17:04:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 8D8DF1A06D7
	for <bpf@vger.kernel.org>; Tue,  8 Oct 2024 17:05:08 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP3 (Coremail) with SMTP id _Ch0CgB3yobB9QRnm_6TDQ--.2069S6;
	Tue, 08 Oct 2024 17:05:08 +0800 (CST)
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
	Yafang Shao <laoar.shao@gmail.com>,
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf 2/7] bpf: Preserve param->string when parsing mount options
Date: Tue,  8 Oct 2024 17:17:13 +0800
Message-Id: <20241008091718.3797027-3-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20241008091718.3797027-1-houtao@huaweicloud.com>
References: <20241008091718.3797027-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgB3yobB9QRnm_6TDQ--.2069S6
X-Coremail-Antispam: 1UD129KBjvJXoW7uw1kXrW5uF4xuF1UWr1Utrb_yoW8CrWrpF
	WrCa4UC3y8tF4UAr40qF4kWrWYv3WIkFW8Ka1kAr1SyF13tr92gF9rAw1agr1fJ3y8C3yY
	vr4Yyw1I9a1UC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPIb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx
	0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWU
	JVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxV
	WUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07UC
	ZXrUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

In bpf_parse_param(), keep the value of param->string intact so it can
be freed later. Otherwise, the kmalloc area pointed to by param->string
will be leaked as shown below:

unreferenced object 0xffff888118c46d20 (size 8):
  comm "new_name", pid 12109, jiffies 4295580214
  hex dump (first 8 bytes):
    61 6e 79 00 38 c9 5c 7e                          any.8.\~
  backtrace (crc e1b7f876):
    [<00000000c6848ac7>] kmemleak_alloc+0x4b/0x80
    [<00000000de9f7d00>] __kmalloc_node_track_caller_noprof+0x36e/0x4a0
    [<000000003e29b886>] memdup_user+0x32/0xa0
    [<0000000007248326>] strndup_user+0x46/0x60
    [<0000000035b3dd29>] __x64_sys_fsconfig+0x368/0x3d0
    [<0000000018657927>] x64_sys_call+0xff/0x9f0
    [<00000000c0cabc95>] do_syscall_64+0x3b/0xc0
    [<000000002f331597>] entry_SYSCALL_64_after_hwframe+0x4b/0x53

Fixes: 6c1752e0b6ca ("bpf: Support symbolic BPF FS delegation mount options")
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/inode.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
index d8fc5eba529d..9aaf5124648b 100644
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -880,7 +880,7 @@ static int bpf_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		const struct btf_type *enum_t;
 		const char *enum_pfx;
 		u64 *delegate_msk, msk = 0;
-		char *p;
+		char *p, *str;
 		int val;
 
 		/* ignore errors, fallback to hex */
@@ -911,7 +911,8 @@ static int bpf_parse_param(struct fs_context *fc, struct fs_parameter *param)
 			return -EINVAL;
 		}
 
-		while ((p = strsep(&param->string, ":"))) {
+		str = param->string;
+		while ((p = strsep(&str, ":"))) {
 			if (strcmp(p, "any") == 0) {
 				msk |= ~0ULL;
 			} else if (find_btf_enum_const(info.btf, enum_t, enum_pfx, p, &val)) {
-- 
2.29.2


