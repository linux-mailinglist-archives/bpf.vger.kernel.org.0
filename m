Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814D34750F9
	for <lists+bpf@lfdr.de>; Wed, 15 Dec 2021 03:31:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbhLOCbw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Dec 2021 21:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235446AbhLOCbv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Dec 2021 21:31:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A527AC061574
        for <bpf@vger.kernel.org>; Tue, 14 Dec 2021 18:31:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 592ABB81C53
        for <bpf@vger.kernel.org>; Wed, 15 Dec 2021 02:31:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFCACC34600;
        Wed, 15 Dec 2021 02:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639535509;
        bh=qQZ58uqiiflLyK14ieCNsXegd6xSqUcPwXM02cfZupg=;
        h=From:To:Cc:Subject:Date:From;
        b=XMaDKBBh+OBuqmlRV9qjJ2MHmkAg8OAsIUXBnaOpdWrcHGL28dxAAGJb2gK3fJ1lk
         7w5/9iIGKZM0vOIO/4cNCUuQCJ202DHH+YfH6fVek0NwZKsdtPDSWFMmAHsZdEI0fN
         vvpeyQpLb+oK9jazedUyttBapNZlWli0Bx6V+jL+UFZK2TSQkaLRa1zYNUYE4W7ZC8
         QEbpGMR/7p6r8y6PFCYjSSteJu5WfTtrG9hABguIt9WXrgxamRP/+CvtZcqnhMXvA5
         v3PbCQ2fki517lFo7QjpBhgVnUEQnhf3OlxdLFr3+6w0/MKj46a2GchTUxnMIGA3LV
         ZkZSGtkk0yNow==
From:   Jakub Kicinski <kuba@kernel.org>
To:     daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org
Cc:     bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH bpf-next v2 0/4] bpf: remove the cgroup -> bpf header dependecy
Date:   Tue, 14 Dec 2021 18:31:22 -0800
Message-Id: <20211215023126.659200-1-kuba@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Changes to bpf.h tend to clog up our build systems. The netdev/bpf
build bot does incremental builds to save time (reusing the build
directory to only rebuild changed objects).

This is the rough breakdown of how many objects needs to be rebuilt
based on file touched:

kernel.h      40633
bpf.h         17881
bpf-cgroup.h  17875
skbuff.h      10696
bpf-netns.h    7604
netdevice.h    7452
filter.h       5003
tcp.h          4048
sock.h         4959

As the stats show touching bpf.h is _very_ expensive.

Bulk of the objects get rebuilt because MM includes cgroup headers.
Luckily bpf-cgroup.h does not fundamentally depend on bpf.h so we
can break that dependency and reduce the number of objects.

With the patches applied touching bpf.h causes 5019 objects to be rebuilt
(17881 / 5019 = 3.56x). That's pretty much down to filter.h plus noise.

v2:
Try to make the new headers wider in scope. Collapse bpf-link and
bpf-cgroup-types into one header, which may serve as "BPF kernel
API" header in the future if needed. Rename bpf-cgroup-storage.h
to bpf-inlines.h.

Add a fix for the s390 build issue.

Jakub Kicinski (4):
  bpf: add header for enum bpf_cgroup_storage_type and bpf_link
  bpf: create a header for inline helpers
  add includes masked by cgroup -> bpf dependency
  bpf: remove the cgroup -> bpf header dependecy

 arch/s390/mm/hugetlbpage.c       |  1 +
 include/linux/bpf-cgroup-types.h | 29 +++++++++++++++++++++++++++++
 include/linux/bpf-cgroup.h       | 13 +++----------
 include/linux/bpf-inlines.h      | 17 +++++++++++++++++
 include/linux/bpf.h              | 18 +-----------------
 kernel/bpf/helpers.c             |  1 +
 kernel/bpf/local_storage.c       |  1 +
 7 files changed, 53 insertions(+), 27 deletions(-)
 create mode 100644 include/linux/bpf-cgroup-types.h
 create mode 100644 include/linux/bpf-inlines.h

-- 
2.31.1

