Return-Path: <bpf+bounces-49786-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 602C5A1C2D0
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 11:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2A593A6525
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 10:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FD3207DFB;
	Sat, 25 Jan 2025 10:59:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B66C1DC19D
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 10:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737802754; cv=none; b=XYBHAJXCgdsf4eDyi0W7+i8iX5UBgthXXTDnDM8pdiQOFyX1T02aiHa6/DSWOyFIUWS30uYsTSfJMMkyOBFfhgQQUrt02GIqnB3ezob0Jbb5ZxrzUSmawUvO1WqoK2X9MzL1cfIo6neQBGLUGbuyMgI62ZDkfQLT3HSMIAawMmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737802754; c=relaxed/simple;
	bh=EGX5BvmmgVOUQWWhsdbJLPHqALmXW3Kc73mKu9bt030=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r2qog8yZQb+djAo2DebO8hwUjunsvcoJadxsk6IsMaGnLG/cOB17H+yhjoJROcmwtO659yIegMKjXdzH3j7hCadMCE0rfb9XbZ2WYzQZl8g31xCX+li2XSeQLVILOuOUvp+9Al7YK7SmxKONS/A6lh0kIEJ2MqUEFPZDJZ4pUvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YgBWC0sxJz4f3kvh
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 18:58:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 24F731A1325
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 18:59:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBXul7zw5Rn79XHBw--.24605S14;
	Sat, 25 Jan 2025 18:59:08 +0800 (CST)
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
	Dan Carpenter <dan.carpenter@linaro.org>,
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf-next v2 10/20] bpf: Introduce bpf_dynptr_user
Date: Sat, 25 Jan 2025 19:10:59 +0800
Message-Id: <20250125111109.732718-11-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20250125111109.732718-1-houtao@huaweicloud.com>
References: <20250125111109.732718-1-houtao@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXul7zw5Rn79XHBw--.24605S14
X-Coremail-Antispam: 1UD129KBjvJXoW7tr4xGF1rJF17tFWfXFyDAwb_yoW8AFyfpF
	95GrWxurW8XFW7AryDJa1Ivr4ruF4rur17K3yq934YkFZrXas7Zws7KasIkF95t3y5ur4x
	JryxKrW5WryrAr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPvb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuY
	vjxUF9NVUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

For bpf map with dynptr key support, the userspace application will use
bpf_dynptr_user to represent the bpf_dynptr in the map key and pass it
to bpf syscall. The bpf syscall will copy from bpf_dynptr_user to
construct a corresponding bpf_dynptr_kern object when the map key is an
input argument, and copy to bpf_dynptr_user from a bpf_dynptr_kern
object when the map key is an output argument.

For now the size of bpf_dynptr_user must be the same as bpf_dynptr, but
the last u32 field is not used, so make it a reserved field.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 include/uapi/linux/bpf.h       | 6 ++++++
 tools/include/uapi/linux/bpf.h | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 2acf9b3363717..7d96685513c55 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7335,6 +7335,12 @@ struct bpf_dynptr {
 	__u64 __opaque[2];
 } __attribute__((aligned(8)));
 
+struct bpf_dynptr_user {
+	__bpf_md_ptr(void *, data);
+	__u32 size;
+	__u32 reserved;
+} __attribute__((aligned(8)));
+
 struct bpf_list_head {
 	__u64 __opaque[2];
 } __attribute__((aligned(8)));
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 2acf9b3363717..7d96685513c55 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7335,6 +7335,12 @@ struct bpf_dynptr {
 	__u64 __opaque[2];
 } __attribute__((aligned(8)));
 
+struct bpf_dynptr_user {
+	__bpf_md_ptr(void *, data);
+	__u32 size;
+	__u32 reserved;
+} __attribute__((aligned(8)));
+
 struct bpf_list_head {
 	__u64 __opaque[2];
 } __attribute__((aligned(8)));
-- 
2.29.2


