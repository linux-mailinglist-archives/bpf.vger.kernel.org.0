Return-Path: <bpf+bounces-34570-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A658E92EB1B
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 16:58:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6F521C214E9
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 14:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427C016A382;
	Thu, 11 Jul 2024 14:58:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107FA12C549
	for <bpf@vger.kernel.org>; Thu, 11 Jul 2024 14:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720709925; cv=none; b=TqiY3c2z4yUXpQJKcoYpaHb0wlN81vwQWheQ190fEiU5VgHDeUQJgtNSR4zzSYD1SNqe7NcvKOv1ZfntQ5iXF4SQVr8XXyjZTeqJC+cCF2UoRTCorynZA++d8ds0fXgrlvdDVjypQmfWg1kJGeiRclObg4p1hlphRVvtm4rbIMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720709925; c=relaxed/simple;
	bh=gYjGiTQZastOo2QbpPKV6Xo1fSsJNDT/3oRfuIrqCVQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bA2jDeSFc9ovBRFQMvYWrULdRkQVTzmVCdhVYsSE0uWe3AXaf+urE2rAvR+7kzrIEgNQLh3RtHDlOF+OP9NJj2W+JmAyUJW1YcV6J/UH9pCMHOkhEac2e8zCIY6u12BMRugvG7PSFzVZpJiH3rJ7aZZvikMG+g4HdhMQf9GjIu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WKdC26GdCz4f3mJK
	for <bpf@vger.kernel.org>; Thu, 11 Jul 2024 22:58:22 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id C5EAE1A0170
	for <bpf@vger.kernel.org>; Thu, 11 Jul 2024 22:58:35 +0800 (CST)
Received: from huawei.com (unknown [7.197.88.80])
	by APP2 (Coremail) with SMTP id Syh0CgBXC4EQ849m425BBw--.32411S2;
	Thu, 11 Jul 2024 22:58:33 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	hffilwlqm@gmail.com
Subject: [PATCH bpf v4 0/2] bpf: Fix null-pointer-deref in resolve_prog_type()
Date: Thu, 11 Jul 2024 22:58:17 +0800
Message-Id: <20240711145819.254178-1-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBXC4EQ849m425BBw--.32411S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJry8GrWxuFW3Cw47uF13twb_yoW8Ww1rpF
	sa9F1Fgr4kC3yfJa1xC3WUurW5JF4xXry5Gr17J34SvrW5ZrW8GFyrWFZ09Fn8WFZ8J3yF
	g3WfJrn7W3WUZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
	c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
	026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
	0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
	vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
	jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Hi,

This patchset is going to fix null-pointer-deref in resolve_prog_type()
for BPF_PROG_TYPE_EXT.

`prog->aux->dst_prog` in resolve_prog_type() is assigned by
`attach_prog_fd`, and would be NULL if `attach_prog_fd` is not
provided. Loading EXT prog with bpf_dynptr_from_skb() kfunc call
in this way will lead to null-pointer-deref.

In last version we fix it by forcing `attach_prog_fd` non-empty
at load time, which leads to libbpf_probe_prog_types() api broken.
Currently, we fix it by just adding null check for EXT prog in
resolve_prog_type() as the old way did.

For the sake of safety, we compared the full test logs of selftest
before and after applying these changes, and the results show that
the two test logs were consistent.

Best regards,
Tengda

Change list:
v4:
 - Fix by add null check in resolve_prog_type() which can avoid 
   libbpf_probe_prog_types api breaking.

v3:
 - Add a small selftest for the BPF CI, and split 1-patch into
   3-patch series as recommended by Daniel.
   https://lore.kernel.org/all/d16b4f29-8966-464f-b530-35e39fda3f46@huaweicloud.com/

v2:
 - Fix libbpf_probe_prog_types test failure reported by CI by
   adapting libbpf code. (thanks for jirka's reminder)

v1: https://lore.kernel.org/all/20240620060701.1465291-1-wutengda@huaweicloud.com/

Tengda Wu (2):
  bpf: Fix null pointer dereference in resolve_prog_type() for
    BPF_PROG_TYPE_EXT
  selftests/bpf: Test for null-pointer-deref bugfix in
    resolve_prog_type()

 include/linux/bpf_verifier.h                 |  2 +-
 tools/testing/selftests/bpf/verifier/calls.c | 13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

-- 
2.34.1


