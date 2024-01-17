Return-Path: <bpf+bounces-19724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E2B830438
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 12:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DA051C2172E
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 11:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A21E1DA4C;
	Wed, 17 Jan 2024 11:10:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2567C1DFCA;
	Wed, 17 Jan 2024 11:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705489812; cv=none; b=hUxedksBE5mpjuND9OxkZqbGp2N6jncxkZrP53JvW1+dtsBCgRojbezx2vafUPYt08YfUUNXlnRh8IpkEyeC4HJbx6CSSXDnsNh4gnlIOUPFroVbS4fbB5qymJ5KEXW0zhYOwB6F18n7I+Hrlp20xaMkVcZcFMTeuoQPtjVTFJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705489812; c=relaxed/simple;
	bh=97XFvg/ZvIno7ulGfllvk9ZIzkwOJB/SI/7Omc23lUM=;
	h=Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam; b=GJ5XwRzMjfPjJHmq6Sj6LaGZp27B9pRjofIbFBX9ruttq7M4cIxJAOGAv8plIPFkJ2IHBakXCUgPJz+/fv9uOxT0Jdtha+/ZrE2es7BEg7Glp6BDIBvcvib3nh1j6Nqt5b0asRl8sbLwMxuPLeH7jZbcuNkoOgNwx5ok96KqaU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8DxWPCKtadlZiYBAA--.5562S3;
	Wed, 17 Jan 2024 19:10:02 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Bx7c6Jtadl+1MGAA--.32440S2;
	Wed, 17 Jan 2024 19:10:01 +0800 (CST)
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
Subject: [PATCH bpf-next v5 0/3] Skip callback tests if jit is disabled in test_verifier
Date: Wed, 17 Jan 2024 19:09:57 +0800
Message-ID: <20240117111000.12763-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Bx7c6Jtadl+1MGAA--.32440S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrZr43CrykGw4rCw1xGr45Jwc_yoWkAwcEka
	y8tF95JrZ8ZFyYya47GFn8urZ8Ga1rWr1UtF45X3yUtrW7ZF45WF4kArZ8Za4kW3y5Ka42
	yrsxXryfJr4qqosvyTuYvTs0mTUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb7AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_JrI_Jryl8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27w
	Aqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE
	14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x
	0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1EksDUUUUU==

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
  selftests/bpf: Move is_jit_enabled() to testing_helpers
  libbpf: Move insn_is_pseudo_func() to libbpf_internal.h
  selftests/bpf: Skip callback tests if jit is disabled in 
    test_verifier

 tools/lib/bpf/libbpf.c                        |  5 -----
 tools/lib/bpf/libbpf_internal.h               |  5 +++++
 tools/testing/selftests/bpf/test_progs.c      | 18 -----------------
 tools/testing/selftests/bpf/test_verifier.c   | 20 ++++++++++++++++---
 tools/testing/selftests/bpf/testing_helpers.c | 18 +++++++++++++++++
 tools/testing/selftests/bpf/testing_helpers.h |  1 +
 6 files changed, 41 insertions(+), 26 deletions(-)

-- 
2.42.0


