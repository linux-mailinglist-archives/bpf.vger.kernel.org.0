Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54BEC96BB3
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2019 23:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730650AbfHTVtC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Aug 2019 17:49:02 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:34211 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730273AbfHTVtB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 20 Aug 2019 17:49:01 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 625E621BB;
        Tue, 20 Aug 2019 17:49:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 20 Aug 2019 17:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=a/sXuKrYtYLnT+5uNbpd3uKPLS
        r1XkxMB37mi6euXos=; b=JVrgCXfLj2pfz30stslGJwBLmnyUJAz+La78uysin4
        D7+vTZIyVxnHO9Ci5tsBisaDBQ33XyXEvTbTDYGO+MoDZ8p0WGyeK5H0Y6bSluhm
        Q9qQKDwDdMw12Zp67qLpDcZVoUelgjJzPvhMBOMivWJD4TB48EDtYAdvMN4Ln3Av
        0MaHd531Ks8pj5ufBgbeUjbTV/a1Fr2SPEKJ+R8rdlsEH7Lsy8Yz953Edc84Z8yK
        a6um41gCdffk1AvgsM5e57R0u0yAfGV8wdshgmTTSt0aFBmgDuxB5IwcS1IYyx9F
        MFFs6xwry3s/w8+Iu3wCiL4C8nuyGT+WfefZx1HlQVCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=a/sXuKrYtYLnT+5uN
        bpd3uKPLSr1XkxMB37mi6euXos=; b=i+zyOlFsrJBVHmSMf9PEJcjKbN4B7fPKe
        eKB9Dr891rzZQATIvVbuKgUWM0dmhWEECCQNOhPubQ780BgHTdGqlBguGDE1Gjcl
        bKaq8GacDD8Cmiy1jO/CmAKYIYJbwJEbNMA3ha//ifKYBWuvGgZMo2TDcT2w4JB/
        s4apWGoP50xmHThA8nu/mva4A2R/tLeZ8l6y6vy0oOHnp+ZrFPjtA31crYg1OpCN
        w7ZY0s+q7zD+aUzn6KkBYqL3DKzYsj8mfJJwes9+RjE4ihCFV4ov2YUluMFH6+fZ
        66MXm6goRweraDJB40OlLi1FfnBQYxJH+RT/2gi8n6GxQhFAz1iQA==
X-ME-Sender: <xms:y2pcXRjamW5IWP4AexKJBQr5a9JRTWZpejWi7U7EdQUHCg4t_WiZVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudegvddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    fufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihu
    segugihuuhhurdighiiiqeenucfkphepudelledrvddtuddrieegrddvnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiinecuvehluhhsthgvrhfuihii
    vgeptd
X-ME-Proxy: <xmx:y2pcXWx1BnGZG7lVsTaI1c0XyoRfLvvxNykeagfL1zv1eAAYbmAGlw>
    <xmx:y2pcXZ82lAJh4QdeCDTrGy1-H01MsQl94DChJtRF_ouCofFn3jJvoQ>
    <xmx:y2pcXeKxYMSjl6m3jvuTp2KihNnrk-x5rlogp8ZXMlvFc1SvCe7s4A>
    <xmx:zGpcXQSqnUmxJpInDyaXRxgBNiApeJDo8zgPX1U_dFq_SUeBPF7j-g>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [199.201.64.2])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6376780062;
        Tue, 20 Aug 2019 17:48:57 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     bpf@vger.kernel.org, songliubraving@fb.com, yhs@fb.com,
        andriin@fb.com, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, ast@fb.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v4 bpf-next 0/4] tracing/probe: Add PERF_EVENT_IOC_QUERY_PROBE
Date:   Tue, 20 Aug 2019 14:48:15 -0700
Message-Id: <20190820214819.16154-1-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.21.0
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

v3 -> v4:
- Make kernel code set size field on ioctl arg
- Update selftests to check size field
- Remove unnecessary function stubs

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

 include/linux/trace_events.h                  |   2 +
 include/uapi/linux/perf_event.h               |  23 ++++
 kernel/events/core.c                          |  20 +++
 kernel/trace/trace_kprobe.c                   |  25 ++++
 kernel/trace/trace_uprobe.c                   |  25 ++++
 tools/include/uapi/linux/perf_event.h         |  23 ++++
 tools/lib/bpf/libbpf.c                        |  21 ++++
 tools/lib/bpf/libbpf.h                        |  13 ++
 tools/lib/bpf/libbpf.map                      |   3 +
 .../selftests/bpf/prog_tests/attach_probe.c   | 115 ++++++++++++++++++
 10 files changed, 270 insertions(+)

-- 
2.21.0

