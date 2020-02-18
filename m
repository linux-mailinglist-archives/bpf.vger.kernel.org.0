Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDD67161F31
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2020 04:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgBRDFE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Feb 2020 22:05:04 -0500
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:35153 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726283AbgBRDFB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 17 Feb 2020 22:05:01 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 8A4F2689;
        Mon, 17 Feb 2020 22:04:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 17 Feb 2020 22:04:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=58BXXdeAkUtD9tu7+KN6VDGLHb
        VpXPw6ckoICOGQz6E=; b=lAJQO9V+pi/Qy5JOkdUUzGOtDjpUeHG3XZ7kozmEt+
        csRgry5Ht8v+7o+tNDcH6lhR7E3Fp5meYxh/hDL5kFK9K+zRQNn0S5t3+aP4pVsL
        PTQIWIbAuks89HkX3N8cykFlQLGm5Cp+LdvF8yC7H77YXcAlcnGnl/AvGpACITC2
        u8TKQPVmPxX5Ez2+TbJvIhacem3byBMXqIhc4qxPxuKIPTHrOvtPvvTy04zzjkKS
        TBZ61Q9N9ZwoAR7vqIYerninAx39ROSHz3x40BHCcCMYlf8NSsZBp2Ozu8GHG9la
        1F9T6q+Yt6k+s1WTZTJJDLAnPCLEZmnXFu2Y7TAf1kyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=58BXXdeAkUtD9tu7+
        KN6VDGLHbVpXPw6ckoICOGQz6E=; b=MLHc+mf7xKzrG2D5pih234I8UcnG/1ZoV
        3hRvUbOpG59hsocUKxZkRvfZaHj/PNt/lbMU5saPazVNbpXwFAzrdtk5p5hgOozK
        jbmq4oO7eG+KoYFrZ65atY6miE0/XWa8kvYhsOo826zqASJ+ZzJBC5dU8+Np6IYb
        /ycd0cn34wHC0U0fMKR4hFnm0D/xPOFWYYd5IbOyEA2nak6EWX5VqmEBEmvK+Yrs
        enkfmt+EwI97Dpem2kWjWAeg3qa5B4ncIY1jrcZQ4wnlMs5VMSyhgHvB7OEw2K8b
        Pnrq84psbOqTxCnepmXnSS05JrVlDujb5yrVpRLmPNi5bdwoXuSTQ==
X-ME-Sender: <xms:T1RLXjGSGZORjExlD4LfUMq49hMlbBMB4VYV-jDStyUB0LJ0PqBN4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeejgdehfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephffvuf
    ffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhes
    ugiguhhuuhdrgiihiieqnecukfhppeduieefrdduudegrddufedtrddunecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdr
    giihii
X-ME-Proxy: <xmx:T1RLXkcYK26RV3N93bIkX87fYDp8xm1WPJ87HxfjBHL15mUzZT6Ncg>
    <xmx:T1RLXgvgzdZ9JfMkE0GFHQRsT7Sx0r4BFzUl2cCBGEEh9mJ2rvwzYg>
    <xmx:T1RLXjXKHAOQmPCqicKt1DImDl8NtoMa5aw6-4O1-Ma3B7B4V0nObw>
    <xmx:WFRLXq8euUKQICINIrvBNvXYwdfqxT5R_iCpJ_z8vGGklEyN4YAnKCwmMtE>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [163.114.130.1])
        by mail.messagingengine.com (Postfix) with ESMTPA id C05283060BE4;
        Mon, 17 Feb 2020 22:04:46 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        songliubraving@fb.com, yhs@fb.com, andriin@fb.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org
Subject: [PATCH v8 bpf-next 0/2] Add bpf_read_branch_records() helper
Date:   Mon, 17 Feb 2020 19:04:30 -0800
Message-Id: <20200218030432.4600-1-dxu@dxuuu.xyz>
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

Changes in v8:
- Use globals instead of perf buffer
- Call test_perf_branches__detach() before destroying skeleton
- Fix typo in docs

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
 kernel/trace/bpf_trace.c                      |  41 +++++
 tools/include/uapi/linux/bpf.h                |  25 ++-
 .../selftests/bpf/prog_tests/perf_branches.c  | 169 ++++++++++++++++++
 .../selftests/bpf/progs/test_perf_branches.c  |  50 ++++++
 5 files changed, 308 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/perf_branches.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_perf_branches.c

-- 
2.21.1

