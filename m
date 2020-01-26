Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57EB2149DD6
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2020 00:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgAZXgM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 26 Jan 2020 18:36:12 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:46723 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726382AbgAZXgM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 26 Jan 2020 18:36:12 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 844192028;
        Sun, 26 Jan 2020 18:36:11 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 26 Jan 2020 18:36:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=gzIA9O+pxyDsNKLMQlvexsQ6Ei
        4tub5y6swRC3raVQs=; b=KmMxSdarVilbjvQ+c97SB0jZNeKf7rOFHlzU+7SWLO
        SFPqCEhP/Yw8JdmKqa988mWQV/GzfjxaQ9EXf+dovGCsVWWwzzdO92mTeMG8bMev
        8hbplyj+2MvYo0tnoLokdQnldwE47aLr2V/nmx3Tzst/I63gkPIJdzOo/U3PG6gE
        xb2h7HD8kSLz0xhLQFUC3bjrQz79FSZaJIrDuZRimwdcjeH6d5vAU1/8J1MQm7kq
        RP1cBG9JIy3c+tTWZVkQBTqSgxOMgr3Q43+T5rrGnO15GNmN4S4QhzHZfWmXQeHd
        MhGaynuTWh6J0id3Epazw5bU8DdNmqtGxI8CfuQjhkXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=gzIA9O+pxyDsNKLMQ
        lvexsQ6Ei4tub5y6swRC3raVQs=; b=bdmNVAVFqU5fJaT47L5yP76hCxpL44yUr
        Vt4vr+4Dw8+eWdGKczcFts/PofNCh/FTOa2zMk3/TxiZyxPhcCT9mUvsl9SZhEuK
        1f2QJMMTmaG05FgNSD8B82/0YNuqQULF4zdJn3X21UR4ZyPBWf8ikyUewbVg9qGy
        4GYDYVJBc/AjKe38g7kvijOmy9a0VNyH7kYhkV/yUESKijZEcqKZeI+W2AIAlufC
        60jBfUhIy9di6DZZlKJEfu4aZmasB24NdW2sXh0xV1bISAevZcHxFLWa0pITG8ma
        DW0xYygwIeCRZVtiED/uA4jr9kgeGbRWJr2zgd3AyWwGFMWp48ztg==
X-ME-Sender: <xms:aiIuXjGyWIagbeG6y9ND3irR_tSKp3C2NfzDX_rCYepB4h2K3CtPVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrfedugdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephffvuf
    ffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhes
    ugiguhhuuhdrgiihiieqnecukfhppeduleelrddvtddurdeigedrfeenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdig
    hiii
X-ME-Proxy: <xmx:aiIuXp-XnILqYUPa4POKzYchk5_0cVvszX3dbfhV5QEMJm4VDMFB5Q>
    <xmx:aiIuXlJgS6e7cEE8AXbgmgED1N1mnd70B5eNiPJ_abDQ_LaT78jA6A>
    <xmx:aiIuXka3tw-eXGFfpEGbfJq7bQVeUzuADMUXfVmZN9HhR1YazNP4OA>
    <xmx:ayIuXrm68wSsEsZBKH9fTMHd4fkFYgVjaQ60xZCMB6VwVi08U6d77A>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (prn-fbagreements-ext.thefacebook.com [199.201.64.3])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8305A3068AEA;
        Sun, 26 Jan 2020 18:36:09 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        songliubraving@fb.com, yhs@fb.com, andriin@fb.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org
Subject: [PATCH v6 bpf-next 0/2] Add bpf_read_branch_records() helper
Date:   Sun, 26 Jan 2020 15:35:52 -0800
Message-Id: <20200126233554.20061-1-dxu@dxuuu.xyz>
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

