Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC0490AF9
	for <lists+bpf@lfdr.de>; Sat, 17 Aug 2019 00:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbfHPWcR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Aug 2019 18:32:17 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:47841 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727669AbfHPWcR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 16 Aug 2019 18:32:17 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 4EE24202D;
        Fri, 16 Aug 2019 18:32:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 16 Aug 2019 18:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=5Z3BJbMxGWyiINqbqOOYczIuMc
        3tJww1wzh6U+BsAYU=; b=r3r745fckMQlPvH1EanYTC0QQmkgVk8Vz9uLZPdV4k
        UfaaFYNKPbHXOEE/onwf4w/QJuVTbaLfFZ/Vmw/WsSGWGzh0wWP8MJmpOkJy5+Tm
        igkg760eNnQd/OzTpr7D7zwCoyg5+OPzjCDlO5gsEJgCd1oHu6nKPmvSkPooZ2Y1
        H2cyHkWtELnkv5y31XQZOw4A0OPGvy91VBSAE7uP21AQTQMoVZYgO0RQeCYWIEVM
        g9BPQCUwHlTx+9FaPBxuHOLADT/hW8DBFr/5iV/OtcpO6BDtj4qN/7zzkYRP2ZKW
        ll5wc7W7K9HkWKUB+BCgUIDEM38wKivUsnhQkY5+OPBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=5Z3BJbMxGWyiINqbq
        OOYczIuMc3tJww1wzh6U+BsAYU=; b=d2Y4LJVSzAgIjm6rFgH4x/KkeEPMWu72k
        PIMWfwG6IgZ/jgLDDPhI7rt6clqu3b9qSxSMD8BzXLBDntKZvWcRva5jVjHYPTVw
        0JKSAKTGmwb9DqSw244dv6amRxTZldutMmdA3aaBgVgvHkvYwvrr5rnDQ96u/l95
        IVCWo24uKyv9sJ/FDoZ5jB2zT+rooUADKmyTvPeFuQ2OGdIQEgeT5DM4/eS4/dYp
        O6J9ctWZiu9Y1X4QZVGqMVNiZnvTPIO+W7RwcoW+CAqr7nIlolOr4guEgjOC67pS
        ftF0mObcHVcfk9Mndr5Q6ErAE1p+hqfwWVhiGhdaJqhRyheycgeng==
X-ME-Sender: <xms:7y5XXXpBw4i6EMbtZABFi-G7b5QajtZi3KiROWEOqqOxjiA-AzCPXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudefgedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    fufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihu
    segugihuuhhurdighiiiqeenucfkphepudelledrvddtuddrieegrddufeeknecurfgrrh
    grmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiinecuvehluhhsthgvrhfu
    ihiivgeptd
X-ME-Proxy: <xmx:7y5XXQIF2e_AIiLEFqIVpl18ZqhaWGSVhbXiMERy4XiuOxSJSCZ-4w>
    <xmx:7y5XXfss3RHxROSmWARiiyd4_lpRMDpKmLr2iHBZcslX-4ydWHv6gw>
    <xmx:7y5XXVA8dVXbNmGA0adhMnONjBZmA8-82CJfKY51u7ta2xgpKqiGhQ>
    <xmx:8C5XXW0HAlie8cqJE2Vi3yMQC9U3nMqBazBrHv6tbbd4UWZpEZ1x7A>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [199.201.64.138])
        by mail.messagingengine.com (Postfix) with ESMTPA id EA6DC8005B;
        Fri, 16 Aug 2019 18:32:13 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, songliubraving@fb.com, yhs@fb.com,
        andriin@fb.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, ast@fb.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v3 bpf-next 0/4] tracing/probe: Add PERF_EVENT_IOC_QUERY_PROBE
Date:   Fri, 16 Aug 2019 15:31:45 -0700
Message-Id: <20190816223149.5714-1-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It's useful to know [uk]probe's nmissed and nhit stats. For example with
tracing tools, it's important to know when events may have been lost.
debugfs currently exposes a control file to get this information, but
it is not compatible with probes registered with the perf API.

While bpf programs may be able to manually count nhit, there is no way
to gather nmissed. In other words, it is currently not possible to
retrieve information about FD-based probes.

This patch adds a new ioctl that lets users query nmissed (as well as
nhit for completeness). We currently only add support for [uk]probes
but leave the possibility open for other probes like tracepoint.

v2 -> v3:
- Introduce bpf_link_type and associated getter to track underlying link
  types
- Add back size field in perf_event_query_probe for forward/backwards
  compat
- Remove NULL checks, fix typos

v1 -> v2:
- More descriptive cover letter
- Make API more generic and support uprobes as well
- Use casters/getters for libbpf instead of single getter
- Fix typos
- Remove size field from ioctl struct
- Split out libbpf.h sync to tools dir to separate commit

Daniel Xu (4):
  tracing/probe: Add PERF_EVENT_IOC_QUERY_PROBE ioctl
  libbpf: Add helpers to extract perf fd from bpf_link
  tracing/probe: Sync perf_event.h to tools
  tracing/probe: Add self test for PERF_EVENT_IOC_QUERY_PROBE

 include/linux/trace_events.h                  |  12 ++
 include/uapi/linux/perf_event.h               |  23 ++++
 kernel/events/core.c                          |  20 ++++
 kernel/trace/trace_kprobe.c                   |  24 ++++
 kernel/trace/trace_uprobe.c                   |  24 ++++
 tools/include/uapi/linux/perf_event.h         |  23 ++++
 tools/lib/bpf/libbpf.c                        |  21 ++++
 tools/lib/bpf/libbpf.h                        |  13 +++
 tools/lib/bpf/libbpf.map                      |   4 +
 .../selftests/bpf/prog_tests/attach_probe.c   | 106 ++++++++++++++++++
 10 files changed, 270 insertions(+)

-- 
2.20.1

