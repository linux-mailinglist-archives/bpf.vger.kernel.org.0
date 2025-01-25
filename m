Return-Path: <bpf+bounces-49794-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A571EA1C2D7
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 11:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 186CE3A950B
	for <lists+bpf@lfdr.de>; Sat, 25 Jan 2025 10:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812DF2080FB;
	Sat, 25 Jan 2025 10:59:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCF82080D4
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 10:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737802758; cv=none; b=OlUqK3WRTrnETNrAvJX8Ijv3+HKFcR+vuhNrTbSvmgg459gbpUK4LybB7Z+mkZK2L7vPEjcVX3/fPvsrAjqBtGi/9OSW3Ct4WkFSgJ+flrnyGdTvGBhYVmezak1Jmy3HrUbi/CqnSe8KuyoS7M2SXg4Cw/nYSgSe1ISuhk2XyZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737802758; c=relaxed/simple;
	bh=99ClpUZt2r4EXSI6aW510S9OEcZeGngG94zvvCIIgZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CujpcMS8b9NT+k8OF7y0vMSPJ1xcq4ISuHPBIq1Qu/TmbizoNO7feHHZ8Ruo39wDj6dkB6ME77LAGcg0touKVQyW4p68qeIebAavI9uQ8RSWLEEdg5DoQwUWznHp6Owx57NehifZBjBpvktNFe+QJvVRMeZHNtIjWN0yczg/Jb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YgBWH5CMVz4f3jqx
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 18:58:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 42A9B1A0A61
	for <bpf@vger.kernel.org>; Sat, 25 Jan 2025 18:59:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgBXul7zw5Rn79XHBw--.24605S11;
	Sat, 25 Jan 2025 18:59:07 +0800 (CST)
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
Subject: [PATCH bpf-next v2 07/20] bpf: Use map_extra to indicate the max data size of dynptrs in map key
Date: Sat, 25 Jan 2025 19:10:56 +0800
Message-Id: <20250125111109.732718-8-houtao@huaweicloud.com>
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
X-CM-TRANSID:gCh0CgBXul7zw5Rn79XHBw--.24605S11
X-Coremail-Antispam: 1UD129KBjvdXoWrtryDGF43KFWDGFW7Xw4fZrb_yoWfurg_uF
	W2vr109rZ8AFnrtF1qkw4rXr1Utr48XF1xJan3XrZrAF15Xas5XrsYvF98AF95Za1UXrW3
	CrsrZrZIvF13XjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbgxYFVCjjxCrM7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r126s
	0DM28IrcIa0xkI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xG
	Y2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14
	v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2
	WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkE
	bVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7
	AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_Wr
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x
	07UZTmfUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

For map with dynptr key support, it needs to use map_extra to specify
the maximum data length of these dynptrs. The implementation of the map
will check whether map_extra is smaller than the limitation imposed by
memory allocation during map creation. It may also use map_extra to
optimize the memory allocation for dynptr.

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 kernel/bpf/syscall.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 46b96d062d2db..79459b218109e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1438,6 +1438,7 @@ static int map_create(union bpf_attr *attr)
 
 	if (attr->map_type != BPF_MAP_TYPE_BLOOM_FILTER &&
 	    attr->map_type != BPF_MAP_TYPE_ARENA &&
+	    !(attr->map_flags & BPF_INT_F_DYNPTR_IN_KEY) &&
 	    attr->map_extra != 0) {
 		err = -EINVAL;
 		goto put_btf;
-- 
2.29.2


