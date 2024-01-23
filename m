Return-Path: <bpf+bounces-20071-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5CE8389E9
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 10:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 903F2B224BE
	for <lists+bpf@lfdr.de>; Tue, 23 Jan 2024 09:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5046C5812B;
	Tue, 23 Jan 2024 09:04:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C749358116;
	Tue, 23 Jan 2024 09:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706000644; cv=none; b=Tic86pgEViSNjsVb2TySVGOWzY7kNn4ELbs+5nU6ZnjW/QN9s2Wx/dJG7Uo2W0WVTAHYBJf0joVD+Ja5O1fpQgRt9OdRzHl30QoApSWbWqtEOfvX+/mNG1SAKtWTht6Y6HL8G9QD0DccP4zSg3uhm5dOWJ+nUNhqdDV0Inf+ZV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706000644; c=relaxed/simple;
	bh=sPZPZpNxCGkjFUXcoESBmSmINqAhV9ErBwBK6gLZhc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RXt0eb015Omhl8nhgNHoV1p27zr04yHd0GWlAiN8R6Z9qQ3aboz8I+SF0JNPSHBJV2wZ9vBxLdin9gscR8Q9qyPnCAT6oCQ6/aQDsF04yr1wqwYj3dxiXFpf+mY1i0HAWFKda++P7LiwU80RU2GhEP1ZEvAr+eeoQfxzyEP9Ez0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxuvD5gK9lOxYEAA--.16509S3;
	Tue, 23 Jan 2024 17:03:53 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxLs_4gK9lWhMUAA--.24458S2;
	Tue, 23 Jan 2024 17:03:52 +0800 (CST)
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
Subject: [PATCH bpf-next v7 0/2] Skip callback tests if jit is disabled in test_verifier
Date: Tue, 23 Jan 2024 17:03:49 +0800
Message-ID: <20240123090351.2207-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxLs_4gK9lWhMUAA--.24458S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7ZFykWF4rtrWkuF1xCF1fXwc_yoW8Jw1kpa
	93GwnIgr1rJF1IqF13ArsFqFWSqr4kW3y5Jw17Xr95Ja15AFyxArWfKF10qas8KrWrXr4a
	y3WIvFyF9F10q3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Gb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj64x0Y40En7xvr7AKxVWUJVW8JwAv7VC0I7IY
	x2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4
	x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0n2-5UUUUU==

Thanks very much for the feedbacks from Eduard, John, Jiri, Daniel,
Hou Tao, Song Liu and Andrii.

v7:
  -- Add an explicit flag F_NEEDS_JIT_ENABLED for checking,
     thanks Andrii. 

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

Tiezhu Yang (2):
  selftests/bpf: Move is_jit_enabled() into testing_helpers
  selftests/bpf: Skip callback tests if jit is disabled in test_verifier

 tools/testing/selftests/bpf/test_progs.c       | 18 ------------------
 tools/testing/selftests/bpf/test_verifier.c    | 11 +++++++++++
 tools/testing/selftests/bpf/testing_helpers.c  | 18 ++++++++++++++++++
 tools/testing/selftests/bpf/testing_helpers.h  |  1 +
 .../selftests/bpf/verifier/bpf_loop_inline.c   |  6 ++++++
 5 files changed, 36 insertions(+), 18 deletions(-)

-- 
2.42.0


