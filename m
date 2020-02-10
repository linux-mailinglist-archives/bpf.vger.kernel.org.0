Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2553E158413
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2020 21:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgBJUIH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Feb 2020 15:08:07 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:45719 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726563AbgBJUIH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 10 Feb 2020 15:08:07 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 5B818811F;
        Mon, 10 Feb 2020 15:08:06 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 10 Feb 2020 15:08:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=q5VJh/Vyf2ihGo3OwwNy/8SCn+
        sSTd6JIm/ZjFp4V/c=; b=hJ2zzU+m0IewdtFJFe4CCAssyCIAOOt7dOTXutWnCS
        Y3HrIl7utaU4FMc60N8XjOQdYzHSPWkferFiaJ2/zHRsQFCnxSgxYJzuf5gcOo5V
        O0baJBXQkGNVsS693PdCmamaCsZovYo41ir7zYZRXZkIa58samRjaMEYURS37mfn
        I6QeBw0K7p7nAbLDqV0zdtgkLvBX2+TMzLEna1G3lPf57As2fA4LOcddm6MhG9O2
        5cbw24BFHVqv8dSM5oKKyQz+z9Woh1rppddq83BAVYTgW7vtQfsjnVjXEd2MuQny
        of0uox1JAgVEW/7K2SvAx2LMatktijkFL+Ne+uPUn44w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=q5VJh/Vyf2ihGo3Ow
        wNy/8SCn+sSTd6JIm/ZjFp4V/c=; b=tKzgzXwiEDrzQ5vgml4l/a7e3eW6HMQnO
        9OosDCKajOygpqZcs9ei1sjr1yQAoFBv0msqjucTSBUqlJFEoMTLzvf9DfC89Q3K
        fGPNTiIhFTj6xMZh2X/RlnVqhbXPuIbhYYnGGH1Oz/5QfkFCZdMFWKKNsei62fw6
        1qwdkY1JEVWqWpaM2GObaNYWOUZemrxT95U0xHlJL/0VlChIl3p4/DdyE2KydoQV
        fne9VOdAK5qJpx+ah22QKGvblrAybXxjnvlUjsUvOWPKJkwiC3JOTPQlp39ywKUi
        26+w9s3NsyV3Ii1y8alWvK3KlW+vW8c2hNS38XcTrMRw4Etk0PWLg==
X-ME-Sender: <xms:JbhBXrw2ndZyDtIomVrSd-33cKe_FoFQq92s_n1VLZaDW3MkwFqV-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedriedugdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    fufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihu
    segugihuuhhurdighiiiqeenucfkphepudelledrvddtuddrieegrddufeeknecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhu
    uhdrgiihii
X-ME-Proxy: <xmx:JbhBXuKd0kk9qG-qgoDMTjOAuCOGPkMEMjUbpvu1Kghg-SavHStbTw>
    <xmx:JbhBXmQl5p5WWKKgyJxo_2mf_T2Kyy_DCDS777vDb99Js2SgWHUGVA>
    <xmx:JbhBXsghnJjZHXXwf6ElHRpn-3ZC-zxc0hVjK4vw_lH5z5n5WSf30A>
    <xmx:JrhBXkp64ntxubnGsvjKlU0ZcJUS9cURsjDzP8FKobcXdkUqdLQ8bQ>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [199.201.64.138])
        by mail.messagingengine.com (Postfix) with ESMTPA id BD8123060272;
        Mon, 10 Feb 2020 15:08:03 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        songliubraving@fb.com, yhs@fb.com, andriin@fb.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org
Subject: [PATCH v7 bpf-next RESEND 0/2] Add bpf_read_branch_records() helper
Date:   Mon, 10 Feb 2020 12:07:35 -0800
Message-Id: <20200210200737.13866-1-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Resend now that merge window is open again.

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

