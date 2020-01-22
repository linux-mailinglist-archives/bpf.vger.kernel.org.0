Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24328145D07
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2020 21:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgAVUXQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jan 2020 15:23:16 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:52223 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725827AbgAVUXQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 22 Jan 2020 15:23:16 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 6D2504C98;
        Wed, 22 Jan 2020 15:23:15 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 22 Jan 2020 15:23:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=iCREW/fk9MXtBc1CDyt5PE2Xmf
        HKzF0QFcyt+33Jfi0=; b=K3ZCUuGUgkv4kADpbYe++o4F4yI3RRljGusBAunDNK
        EtU51fWdraKt8OxNFwTCtlcePwjEQkolxJGLkbFNWB8lq8akPDaJIZsV7pYmD60o
        opGwHXMdDik5DSEU4nKrbLR++ULGPv1Ar3CXXi/K4+oH6Ru85dn3Fkl9qu+eADHN
        uBJJfWzC7HXGVK4Kz5+Ug3nhgx0IFv2ixyGQGPbGfr9pCeNaR67CCFpSKS9SIc0c
        whx53WDKga9SuNGfAjgG79oHEcfU6lwi0ramZ7TT5Zkis+wpqsQjMV823n7siTjJ
        UebwIdADO6Yekpq2Yqu3oCsq6NrwJq4zNqX5R7THTY7Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=iCREW/fk9MXtBc1CD
        yt5PE2XmfHKzF0QFcyt+33Jfi0=; b=E3TupMbrSibGT67HZDcrBQ3mU9qZZvjn0
        c7HZj2TIh4+WDQDYcm/gNGzjBfxEkdK6eLbjSZJkK7PUoy1ebMpf+MALQvFmPiLN
        azJKJAr1i7GtdB6dEvTr7W/i+lP85xPT5038pmioT8c9kI5atVln7dz6EBpL+xRv
        5/ZJ7+sJHTGDE/SWl8Mi4eJYfDK1yorAReY7YweOvbbNJ7QviosYBXjeU9lErayn
        +kdPPmNPInEtN1HCWqB9km6Aptu9C9wn/mExAbmj0yEiyxjHtUcp1pn7oog4HeLB
        E6aRxaD7MuX2URW/PmgoB/O80Ea29xRhuZx/acqBGSAoKf2BpcLBg==
X-ME-Sender: <xms:M68oXjSmvR7hNg523R54-Ov_6anjVYjvqIPoMFRmFD-PTvNoIL9x4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrvddtgddufeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    fufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihu
    segugihuuhhurdighiiiqeenucfkphepudelledrvddtuddrieegrddvnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhuuhdr
    giihii
X-ME-Proxy: <xmx:M68oXmrk8Cytp3i1k989SxTLuDt8zeXPcJ0Nu33koRHANeqt6pbtHQ>
    <xmx:M68oXte5QBggHn8VHoFvoqFpbjsUO1uj7vcHOUML8IVdfCGblWZoxA>
    <xmx:M68oXhiTI9L31a0SkR_Ikv9D5Tp3s6nWU1JZMzZ7JJFImEVrXbxq8A>
    <xmx:M68oXh_z46NSfhyNrt-gBKPn0oR-BkBjXp6jkLG0gwqlNNs95bJjPQ>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [199.201.64.2])
        by mail.messagingengine.com (Postfix) with ESMTPA id 602363280064;
        Wed, 22 Jan 2020 15:23:12 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        songliubraving@fb.com, yhs@fb.com, andriin@fb.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org
Subject: [PATCH v2 bpf-next 0/3] Add bpf_perf_prog_read_branches() helper
Date:   Wed, 22 Jan 2020 12:22:17 -0800
Message-Id: <20200122202220.21335-1-dxu@dxuuu.xyz>
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

Changes in v2:
- Change to a bpf helper instead of context access
- Avoid mentioning Intel specific things

Daniel Xu (3):
  bpf: Add bpf_perf_prog_read_branches() helper
  tools/bpf: Sync uapi header bpf.h
  selftests/bpf: add bpf_perf_prog_read_branches() selftest

 include/uapi/linux/bpf.h                      |  13 ++-
 kernel/trace/bpf_trace.c                      |  31 +++++
 tools/include/uapi/linux/bpf.h                |  13 ++-
 .../selftests/bpf/prog_tests/perf_branches.c  | 106 ++++++++++++++++++
 .../selftests/bpf/progs/test_perf_branches.c  |  39 +++++++
 5 files changed, 200 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/perf_branches.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_perf_branches.c

-- 
2.21.1

