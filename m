Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F72B83DE3
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2019 01:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfHFXjq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Aug 2019 19:39:46 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:57517 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726431AbfHFXjp (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 6 Aug 2019 19:39:45 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 4254051B;
        Tue,  6 Aug 2019 19:39:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 06 Aug 2019 19:39:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=42HE4MAtRshZff6o01OwMbGuW7
        jigCMzpzABvCNUstE=; b=Z9gdqOwtRPPm+ApINL0zG92OK91zkT5uuSU4yXgMD2
        DKrHnzbltW+bMj4iQK/9/47wFbI2UhUOzjlITdOX1/ooxcRc/nWhtmaKI0Qrv0hx
        Rtfag8d6MgQJ/N/NLQP5zO130q5FeZkHCbzd7em1yc939lUDoKxsvttkl2j+ExqX
        jMnv5ZdTC/nUg+9cGvUNzADby6WYxQMkirjkGm7stKHI1DIDj5OzkTkXsjQM7Ofi
        GY0auMyrpUMmt4IVibPkCpwfW0OVwnaeK/O6d+zoQSz0ed2Je50U6VMWCZMfBrm1
        MiQ+m1jHLdjMokuKMF6Ag6orD8xUIkfBswnf0LsNSVwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=42HE4MAtRshZff6o0
        1OwMbGuW7jigCMzpzABvCNUstE=; b=Nb6y2lByVhyV+AmxtzV4DN6qos/xOqKLG
        tcWuRbG7knhyTSR/9WsV6XZXlf6VMk/BZvaXMl6L7XM4E19qE2NJB2lo8qeL+Xi8
        J6VJtfJeqYNsjxHOIc4fdLOK0XcYMnffpXrETMZ+84Jdx6FTphzvJzngJydekCmQ
        JCg4M0CV6YC97DVcXWL4xesTQQLUMWVA3FXBBQHCrdcYqqt6aBjDTY0uk+r79U9d
        w8zCdr+yYR6/aXsa1x7H7cxitEQ+e5M+opxZUazEGhflOes3rnruc/fCv32qFq02
        B3WyL5JLrOQRWYyXxwc4bIaEh8tIrMRBXHzGiJgbIoZSQY9IG3usg==
X-ME-Sender: <xms:vQ9KXfLs8oL7DdPR3L67S18Os19F7u0nFQ6asGB077wYEHxsB14IOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudduuddgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvf
    fufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihu
    segugihuuhhurdighiiiqeenucfkphepudelledrvddtuddrieegrddufeeknecurfgrrh
    grmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiiinecuvehluhhsthgvrhfu
    ihiivgeptd
X-ME-Proxy: <xmx:vQ9KXTQvcLsMWARU6Cmzpfe6d0aT_t4FhMoZrxeCOgATg3ABc0JSyA>
    <xmx:vQ9KXVgv8y8Eeb4_nBxOSZcW5K5hYuEIT3qAxisZ4-tHSZkb2icibA>
    <xmx:vQ9KXcp3KXAnKYz4Fqb_ONmQ9ocyT2VIRZVa19mVemMGyY8vsWFqOg>
    <xmx:vQ9KXWHSsMebNTBE3AjmNthxyepYYh8AOxPDQelleTWk73ZPp-NBPA>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [199.201.64.138])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2F04B80064;
        Tue,  6 Aug 2019 19:39:40 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     songliubraving@fb.com, yhs@fb.com, andriin@fb.com
Cc:     Daniel Xu <dxu@dxuuu.xyz>, bpf@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH 0/3] Add PERF_EVENT_IOC_QUERY_KPROBE ioctl
Date:   Tue,  6 Aug 2019 16:38:23 -0700
Message-Id: <20190806233826.2478-1-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It's useful to know kprobe's nmissed and nhit stats. For example with
tracing tools, it's important to know when events may have been lost.
There is currently no way to get that information from the perf API.
This patch adds a new ioctl that lets users query this information.

Daniel Xu (3):
  tracing/kprobe: Add PERF_EVENT_IOC_QUERY_KPROBE ioctl
  libbpf: Add helper to extract perf fd from bpf_link
  tracing/kprobe: Add self test for PERF_EVENT_IOC_QUERY_KPROBE

 include/linux/trace_events.h                  |  6 +++
 include/uapi/linux/perf_event.h               | 23 ++++++++++
 kernel/events/core.c                          | 11 +++++
 kernel/trace/trace_kprobe.c                   | 25 +++++++++++
 tools/include/uapi/linux/perf_event.h         | 23 ++++++++++
 tools/lib/bpf/libbpf.c                        | 13 ++++++
 tools/lib/bpf/libbpf.h                        |  1 +
 tools/lib/bpf/libbpf.map                      |  5 +++
 .../selftests/bpf/prog_tests/attach_probe.c   | 43 +++++++++++++++++++
 9 files changed, 150 insertions(+)

-- 
2.20.1

