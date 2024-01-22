Return-Path: <bpf+bounces-19994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 320F2835C1F
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 08:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C541FB27389
	for <lists+bpf@lfdr.de>; Mon, 22 Jan 2024 07:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F66717C80;
	Mon, 22 Jan 2024 07:57:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF1018C27;
	Mon, 22 Jan 2024 07:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705910233; cv=none; b=coG3QyO9Hu5kKmIbsUgHi03gAHLsEzTTWjHQQyr0bd2NT9rcyV2eIe2MSHPkC14nHuBkeY+c0Bxgc7VD2YIdrZuqAgF2liAwm7SDqgEK+gJgEQvTShrbE0kjNELDx5G7pIEToxm/LDrf0dMnQenUPEfZWNZB8xSndyqG8WcBRdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705910233; c=relaxed/simple;
	bh=WA/X95R+Vkf2GHRRbOCdzWMOPdqCWoEuI7R2KJTzBOo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p7b9FJoYTasZ1RQZuHMVJRSGPgUSNelwAou39bXAn4OTZAhm9sdfmIUMOIDT0SEu+bOJgYJwwwbUsbH7lD/2lJjVZcYb0DBwrMfoltmDB29nRKFetKvUAb3eDrVy99FSo2EKPop7qT5rjdNJxf5wENCyXpL2ArAjFL/k1bBgPT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxmfDOH65lhm0DAA--.14298S3;
	Mon, 22 Jan 2024 15:57:02 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Cxf8_NH65lKSIRAA--.13989S2;
	Mon, 22 Jan 2024 15:57:01 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Hou Tao <houtao@huaweicloud.com>,
	Song Liu <song@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v6 0/3] Skip callback tests if jit is disabled in test_verifier
Date: Mon, 22 Jan 2024 15:56:57 +0800
Message-ID: <20240122075700.7120-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Cxf8_NH65lKSIRAA--.13989S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7JF4DuF1xuFykAry7tFWkGrX_yoWkZrcEka
	yUtas5Jr4UAFy5AFy7GF1DuFZ8Ww4fWryUtF45XrW7tr17ZF45WFWkursYva4kWFW5GasF
	yFsxWFZ3Jrs8tosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbIxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7
	AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r
	1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8aZ
	X5UUUUU==

v6:
  -- Copy insn_is_pseudo_func() into testing_helpers,
     thanks Andrii.

v5:
  -- Reuse is_ldimm64_insn() and insn_is_pseudo_func(),
     thanks Song Liu.

v4:
  -- Move the not-allowed-checking into "if (expected_ret ...)"
     block, thanks Hou Tao.
  -- Do some small changes to avoid checkpatch warning
     about "line length exceeds 100 columns".

v3:
  -- Rebase on the latest bpf-next tree.
  -- Address the review comments by Hou Tao,
     remove the second argument "0" of open(),
     check only once whether jit is disabled,
     check fd_prog, saved_errno and jit_disabled to skip.

Tiezhu Yang (3):
  selftests/bpf: Move is_jit_enabled() into testing_helpers
  selftests/bpf: Copy insn_is_pseudo_func() into testing_helpers
  selftests/bpf: Skip callback tests if jit is disabled in test_verifier

 tools/testing/selftests/bpf/test_progs.c      | 18 ------------------
 tools/testing/selftests/bpf/test_verifier.c   | 13 +++++++++++++
 tools/testing/selftests/bpf/testing_helpers.c | 18 ++++++++++++++++++
 tools/testing/selftests/bpf/testing_helpers.h | 11 +++++++++++
 4 files changed, 42 insertions(+), 18 deletions(-)

-- 
2.42.0


