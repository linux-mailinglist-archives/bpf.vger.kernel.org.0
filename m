Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 943E1147315
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2020 22:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbgAWVXk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jan 2020 16:23:40 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:41041 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728765AbgAWVXj (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 23 Jan 2020 16:23:39 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 785E75F4B;
        Thu, 23 Jan 2020 16:23:38 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 23 Jan 2020 16:23:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=P9qYDjaalIojOyrJspA6Do0Z3K
        UXZSgzocMNFgoWdUg=; b=XjYqqzbbPIF4MJrNVCCX0UVqD0LDJ+azHGZx2x6Mpt
        qfHQm0rz36j16A7K5QJtF9BMADnEzTXAEa6Tpmr+pzgZB/mXfgi7RvQ8YXWI/2pO
        HsRKkBPVH0Q31LDk1dgiR46XI9EuI+SVbvPw1zn1BcT6bmC21AcalIWc5Zb6pMgm
        2NY5PxSxjacHXOwL64/x5PCpEy9O+3yN3ITMrH3te+5K3eSk4Jax+tOAqPvvKliy
        9bPgBtOJMObi+gGEpqS0XRtHb0fEkmYTwyGYf2/fKEMwnkpHyUjBeXlOzeiEZobn
        QS+jh2E5mkFUQYWzoBjere1X8DTolXynx8WhUGHH3DvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=P9qYDjaalIojOyrJs
        pA6Do0Z3KUXZSgzocMNFgoWdUg=; b=HvVl6qdS5APVwXY3SOPPjKBKfiSzl0y5I
        bAeH1Q4LE610BhILw/+/MynnDhIU7N8eexHwF3IOUPJFL0RKokHK9BJEnSSC4HLW
        sgui44EI1Nv9fYko7D1S3R6P+vuhCTk8ONBjNolUCvQb4/skzWWw6lPKMoYklJBo
        WefOls0QXLjcGyeYGzEeZyhjUcT+PybjMgAtFuNHA9UJXe8BNPjIMbhcdwJberPc
        8PD+7fXxBZKOmlsaF3EpFsLYySwHvlMk+fZnN4uFQQhfgiSVItuO1Yz+i9+7eQJo
        vWou7Wrj6HkOBqvO+n9RN8SiEPXMS4dIinbxawNtmWpZQDRjYYaEw==
X-ME-Sender: <xms:2Q4qXhc90CsYEtzIFeQpCQXB-WYOARlhEJBN46pXxN1DZTiGcJzeOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrvddvgdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephffvuf
    ffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhes
    ugiguhhuuhdrgiihiieqnecukfhppeduleelrddvtddurdeigedrudefheenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhu
    rdighiii
X-ME-Proxy: <xmx:2Q4qXiS4BQmOIFc620RZ-gSVTYlrzr6A_MAeor5VFJ7-I-nQhESVCw>
    <xmx:2Q4qXonjK-eGebcwV_aED6-Dt-SZV8--MMm-fTQiKlwyXN4DvbqPlg>
    <xmx:2Q4qXuY3sRJiG596KN2bHrZEN4np8M4kA8xN7EJwnx1pO5EGevYa1w>
    <xmx:2g4qXh-qJNWTV3PRjeH90cUXWT37j0hfSWiuMt_EqurMEUwnRzo2XQ>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [199.201.64.135])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3D3133060AA8;
        Thu, 23 Jan 2020 16:23:36 -0500 (EST)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        songliubraving@fb.com, yhs@fb.com, andriin@fb.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org
Subject: [PATCH v3 bpf-next 0/3] Add bpf_perf_prog_read_branches() helper
Date:   Thu, 23 Jan 2020 13:23:09 -0800
Message-Id: <20200123212312.3963-1-dxu@dxuuu.xyz>
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

 include/uapi/linux/bpf.h                      |  15 ++-
 kernel/trace/bpf_trace.c                      |  31 +++++
 tools/include/uapi/linux/bpf.h                |  15 ++-
 .../selftests/bpf/prog_tests/perf_branches.c  | 106 ++++++++++++++++++
 .../selftests/bpf/progs/test_perf_branches.c  |  39 +++++++
 5 files changed, 204 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/perf_branches.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_perf_branches.c

-- 
2.21.1

