Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C354414AAAA
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2020 20:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgA0Tk4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Jan 2020 14:40:56 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:33695 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725845AbgA0Tku (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 27 Jan 2020 14:40:50 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id BC3C46750;
        Mon, 27 Jan 2020 14:40:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 27 Jan 2020 14:40:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=QijxjuOhiTJlpH+pSCqyCrQ0Dt
        b85t6Huy4YLag+b5U=; b=QyHY+VtsOk5d3H4o6QrENWrA9kO/2fDYmItOSiwWbX
        1euLK9y8B5DLSZX6Vnq96oB6lrYxI5LJaZ9vdNFBO825FDDFTmj0FlTqQ3J1pihM
        8k1c1PIVRCDGM2gBGDzC024AbmTB5Y4k2MVf73CdE7WvHGCjdaLBNxv/B0/1fokr
        cPMU/pRniwL4P/bEqF/LhOg0TYxARxeJtoMXmAr8biyNBRz4VMDD37dqLekSbyzp
        zCCAA5puAq8oL2+Y0CC5p7JM5QRf51vmmAEvBwX0H8tiLMwNXaNm/FAa0R0hdI7b
        tjTmH7Tmv5dQYbghjcbTMU7c93SubVMpHIblTqcrcJFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=QijxjuOhiTJlpH+pS
        CqyCrQ0Dtb85t6Huy4YLag+b5U=; b=czzgxx2rJXWQ35zpQUkx5M+4kXepV6mVO
        FhHD74cj9NNdzCH3dQYwlw0zlKDpRAihfBtqpfSOQZGqVTjaErXk+1Xt83nXupJu
        oy097xaOYJVaz5THLPp1EI7rtzK1LeIESZIH0Ny5RYL7jfn9QG3M0QwFEplJTMNO
        FZh64Rkt4ZFnYfHUYBN3xoEnTvo8kZhl8J9/rdYS7G7X9D9erxXDWZl9/G4LYSCK
        bTn9imS3c4vY1XZDzCjkLwsFAtq1vXqC2+oWTkPu5fA6bzta/wyHqxwjDBDGDIx/
        Wu0u36wFVQwLapOaE9RLpc7wAFQw81kfvg3bYJX4JjzRyVrO7EM6w==
X-ME-Sender: <xms:wDwvXgujWrg_ae7r2f7ix1eXiGNnwGFix0bT004xqXbMTQGY2CFLcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrfedvgdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    fufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihu
    segugihuuhhurdighiiiqeenucfkphepudelledrvddtuddrieegrddufeelnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhu
    uhdrgiihii
X-ME-Proxy: <xmx:wDwvXnjAkcSOD4YnlJ7d4fOtVFHNRgQR97_jwgCEGokEBAX2oiFRxA>
    <xmx:wDwvXq3e1odTVfrBgm0YASMiY9c025wHWyau72u68LylKWggcJEmDw>
    <xmx:wDwvXrWwc-VuqLhCwx-X2y6HxzPCq-tbJUSbUJA2G2R6k3yt0OLtRw>
    <xmx:wTwvXhycLQZvFMs7FOwkMT9uZPN4ZbI41LyA8sA4Bl_LpjJdB_2F8g>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [199.201.64.139])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2AF9D328005A;
        Mon, 27 Jan 2020 14:40:47 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        songliubraving@fb.com, yhs@fb.com, andriin@fb.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org
Subject: [PATCH v7 bpf-next 0/2] Add bpf_read_branch_records() helper
Date:   Mon, 27 Jan 2020 11:40:29 -0800
Message-Id: <20200127194031.19122-1-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Branch records are a CPU feature that can be configured to record
certain branches that are taken during code execution. This data is
particularly interesting for profile guided optimizations. perf has had
branch record support for a while but the data collection can be a bit
coarse grained.

We (Facebook) have seen in experiments that associating metadata with
branch records can improve results (after postprocessing). We generally
use bpf_probe_read_*() to get metadata out of userspace. That's why bpf
support for branch records is useful.

Aside from this particular use case, having branch data available to bpf
progs can be useful to get stack traces out of userspace applications
that omit frame pointers.

Changes in v7:
- Const-ify and static-ify local var
- Documentation formatting

Changes in v6:
- Move #ifdef a little to avoid unused variable warnings on !x86
- Test negative condition in selftest (-EINVAL on improperly configured
  perf event)
- Skip positive condition selftest on setups that don't support branch
  records

Changes in v5:
- Rename bpf_perf_prog_read_branches() -> bpf_read_branch_records()
- Rename BPF_F_GET_BR_SIZE -> BPF_F_GET_BRANCH_RECORDS_SIZE
- Squash tools/ bpf.h sync into selftest commit

Changes in v4:
- Add BPF_F_GET_BR_SIZE flag
- Return -ENOENT on unsupported architectures
- Only accept initialized memory in helper
- Check buffer size is multiple of sizeof(struct perf_branch_entry)
- Use bpf skeleton in selftest
- Add commit messages
- Spelling and formatting

Changes in v3:
- Document filling unused buffer with zero
- Formatting fixes
- Rebase

Changes in v2:
- Change to a bpf helper instead of context access
- Avoid mentioning Intel specific things

Daniel Xu (2):
  bpf: Add bpf_read_branch_records() helper
  selftests/bpf: add bpf_read_branch_records() selftest

 include/uapi/linux/bpf.h                      |  25 ++-
 kernel/trace/bpf_trace.c                      |  41 ++++
 tools/include/uapi/linux/bpf.h                |  25 ++-
 .../selftests/bpf/prog_tests/perf_branches.c  | 182 ++++++++++++++++++
 .../selftests/bpf/progs/test_perf_branches.c  |  74 +++++++
 5 files changed, 345 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/perf_branches.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_perf_branches.c

-- 
2.21.1

