Return-Path: <bpf+bounces-39679-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21930975E80
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 03:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D43481F23293
	for <lists+bpf@lfdr.de>; Thu, 12 Sep 2024 01:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1DE2BB09;
	Thu, 12 Sep 2024 01:28:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E108E2A1CA
	for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 01:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726104525; cv=none; b=JANpcjsQ08eIGhluMbLDnTNpIml6uVbgXtnyO5+sFAezVotV86t/4JV+3SMNaN/Tse/JKw/83IaQukec0VQgfEg31q9IsUWaoSn48okukrDJXeqZBcZ6DwAj7dd0yCCggEY4PqN26GzyHEcd/sFsV0J7re3tYmEj+X81DKmpos8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726104525; c=relaxed/simple;
	bh=/CIXCttOtx+IrQ/W22CA6QW6Ybk/FYVAYiHjpqoQnzk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q2p9isf11LF17xTSV1Me+khqx3HJWoC9RDFAC3uSPiF3ITSrVB9DLuoIUM53g4IV3QNcKLrcAqr9+AqgB2WIG4CFHk+S88WXSdOh6qu0W3U14f5aoOhFtuCw8xatcQ1HU3VrIm1cd2EdcvDNl9VDkAqhpLVDutquYaY224Gdd7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4X40FN0J3kz4f3jrs
	for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 09:28:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7CCB41A06D7
	for <bpf@vger.kernel.org>; Thu, 12 Sep 2024 09:28:39 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
	by APP4 (Coremail) with SMTP id gCh0CgCXysbFQ+JmOHBLBA--.63562S4;
	Thu, 12 Sep 2024 09:28:39 +0800 (CST)
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
	Stanislav Fomichev <sdf@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Amery Hung <amery.hung@bytedance.com>,
	Dave Marchevsky <davemarchevsky@fb.com>,
	houtao1@huawei.com,
	xukuohai@huawei.com
Subject: [PATCH bpf-next 0/2] Two tiny fixes for btf record
Date: Thu, 12 Sep 2024 09:28:43 +0800
Message-Id: <20240912012845.3458483-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXysbFQ+JmOHBLBA--.63562S4
X-Coremail-Antispam: 1UD129KBjvdXoWrJw4fZr48XFWfWF4UCFy3Arb_yoWxGFb_Ca
	9Yyry8Wa1DZF47Ga47AFZ3WryxKFWkJrn5JrWqgrZxXryrXan7GF1vv348urykua1qgFW5
	CFs5Zryftr12qjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxAYFVCjjxCrM7AC8VAFwI0_Xr0_Wr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
	WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
	6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	jIksgUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/

From: Hou Tao <houtao1@huawei.com>

Hi,

The tiny patch set aims to fix two problems found during the development
of supporting dynptr key in hash table. Patch #1 fixes the missed
btf_record_free() when map creation fails and patch #2 fixes the missed
kfree() when there is no special field in the passed btf.

Comments are always welcome.

Hou Tao (2):
  bpf: Call the missed btf_record_free() when map creation fails
  bpf: Call the missed kfree() when there is no special field in btf

 kernel/bpf/btf.c     |  4 +++-
 kernel/bpf/syscall.c | 19 ++++++++++++-------
 2 files changed, 15 insertions(+), 8 deletions(-)

-- 
2.29.2


