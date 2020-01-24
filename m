Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 774C7149000
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2020 22:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727306AbgAXVRV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jan 2020 16:17:21 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:57303 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725765AbgAXVRV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 24 Jan 2020 16:17:21 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 2999C6DD5;
        Fri, 24 Jan 2020 16:17:20 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 24 Jan 2020 16:17:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=2yZpLnjkYKiLbhzMXMoZBXj5Eb
        //kZPHeDc+rQSoN2o=; b=a/UCmknwvjyY2L2/ogiELy5HyeuoT1x8HybshTVHAh
        I38CeZgO0rrnXyr1eAjaMjZx81imBMzt+gkBW9ft8P6sATiQ3z8ph5sNsTL8l2c3
        +zGfZp4KVtdOPOaK+Dn6dijnNHHQLgkUBkMf3iEjSHoNYL6wQS4EJL6Cf6rNJDnn
        oNv2o6rhYmzLmp4uDfFkH1m2co8KW/Ew5r5j1Frg1LbRHCvz3NGa3+VQ0T/6x+Pt
        FvPh3Ta8RvOJ4fsGhB3s14D643juYbh5WEzc1iX7VZ2BmFRDu+gQ6njj75myeU4p
        WPx4obizVC8/l6379ypzqYBgQL2CWjrludHn4SRNw/Mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=2yZpLnjkYKiLbhzMX
        MoZBXj5Eb//kZPHeDc+rQSoN2o=; b=ot3R/rVkPCkrwh5YRAxPWSob3b9ADgxaG
        k9OL9Cj1dEOiiSVcHY9kflUGm38xlLTG0HpEewV9z3c45vc18Gb2HdNN0Xo388Rt
        BxZ2GkpQzl7juOmEL+p4+CZ+gwSOBtb1Pa/JM8z074Gi8KVbdP/Wc1woXfh8y8tT
        zQaVquPV0EP6nfroWnAdTTjJpYxWrA7oRRtlG8HXKZpukL08piVDUqYP6y7ckmVN
        RPnJmJneNrsVHoLZGWxZkS1Om3R5VQhWUU5AALOSXV6eHQYScpK6QO6NpO/jw8rT
        DGKJ7keQ/YhRYt+CPsWG4bcFqMChh5qywoXBnHYVVOrP0uHB445lg==
X-ME-Sender: <xms:314rXgRLXxou0pkafzmYRud4NZrMqFL9f_MPvu26-Oyw22U7WInJnA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrvdehgdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephffvuf
    ffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhes
    ugiguhhuuhdrgiihiieqnecukfhppeduleelrddvtddurdeigedrgeenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdig
    hiii
X-ME-Proxy: <xmx:314rXvQkijrc73YmAD3bMbelu_9kmdWjWQJ6LUpr3SB6564AvXxpww>
    <xmx:314rXrfMmtWFYVildvQst8fEsU34hmpCHVj4dA66tsvxRi5QW0eCyw>
    <xmx:314rXrdGSX5dn0sfmUMDKSW_PLtaMXEqIQGW9wfBuAn2738za8Gwyw>
    <xmx:4F4rXqn7x3mIdAUtZy8ORV8b2VrAuiQFgH7N1o54WBiq9FNlqiizaw>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (prnvpn05.thefacebook.com [199.201.64.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id EBC583062B10;
        Fri, 24 Jan 2020 16:17:17 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        songliubraving@fb.com, yhs@fb.com, andriin@fb.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org
Subject: [PATCH v4 bpf-next 0/3] Add bpf_perf_prog_read_branches() helper
Date:   Fri, 24 Jan 2020 13:17:02 -0800
Message-Id: <20200124211705.24759-1-dxu@dxuuu.xyz>
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

Daniel Xu (3):
  bpf: Add bpf_perf_prog_read_branches() helper
  tools/bpf: Sync uapi header bpf.h
  selftests/bpf: add bpf_perf_prog_read_branches() selftest

 include/uapi/linux/bpf.h                      |  25 +++-
 kernel/trace/bpf_trace.c                      |  41 +++++++
 tools/include/uapi/linux/bpf.h                |  25 +++-
 .../selftests/bpf/prog_tests/perf_branches.c  | 112 ++++++++++++++++++
 .../selftests/bpf/progs/test_perf_branches.c  |  74 ++++++++++++
 5 files changed, 275 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/perf_branches.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_perf_branches.c

-- 
2.21.1

