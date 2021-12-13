Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5E74738AB
	for <lists+bpf@lfdr.de>; Tue, 14 Dec 2021 00:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242642AbhLMXmi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Dec 2021 18:42:38 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57502 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238160AbhLMXmi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Dec 2021 18:42:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01B09612BE
        for <bpf@vger.kernel.org>; Mon, 13 Dec 2021 23:42:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30714C34600;
        Mon, 13 Dec 2021 23:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639438957;
        bh=QC5+QVqckS6I4EKuI+BBO2wH2u2C4TxsPzeejDhk3Fw=;
        h=From:To:Cc:Subject:Date:From;
        b=sAP3puD5/1hcdU6jzn+wc7QJHYqUp3uDUoi2EYrYCAfP80YB7YMI0B3qVu9DCtfVm
         V0YPmKuDbObNJDq24v1Qx7TNO17wtH7eDia9Z716Flscss0Yyic44UNjhS/pFDFUVC
         vlWY/wRL684RCLWYpEO/X0IkLqDDWakCBNUzNLrg75DGiH+psukiTOyeQMxaCMzhbG
         474T/fCBJkROi8/uYdUtBCu7AHVTNDskb8ex+Jh86MJezHDQblA+ojzrVRdRYfsk6o
         E235KNZAzc9Rb6BsL5vwdA4yA8Nb8iz4h2ejZxuPfJHHmKo5wHNShUng/0k5sB9uTm
         G3RmM7uLqzMOQ==
From:   Jakub Kicinski <kuba@kernel.org>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org
Cc:     bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH bpf-next 0/5] bpf: remove the cgroup -> bpf header dependecy
Date:   Mon, 13 Dec 2021 15:42:18 -0800
Message-Id: <20211213234223.356977-1-kuba@kernel.org>
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

As the stats show touching bpf.h is _very_ expensive. Recent 20+ patch
series from Jirka took 10 hours to build patch-by-patch on a 72 CPU VM.

Bulk of the objects get rebuilt because MM includes cgroup headers.
Luckily bpf-cgroup.h does not fundamentally depend on bpf.h so we
can break that dependency and reduce the number of objects.

With the patches applied touching bpf.h causes 5019 objects to be rebuilt
(17881 / 5019 = 3.56x). That's pretty much down to filter.h plus noise.

Jakub Kicinski (5):
  bpf: add header for enum bpf_cgroup_storage_type
  bpf: create a header for cgroup_storage_type()
  bpf: create a header for struct bpf_link
  bpf: remove the cgroup -> bpf header dependecy
  bpf: push down the bpf-link include

 include/linux/bpf-cgroup-storage.h | 17 +++++++++++++++++
 include/linux/bpf-cgroup-types.h   | 13 +++++++++++++
 include/linux/bpf-cgroup.h         | 13 +++----------
 include/linux/bpf-link.h           | 23 +++++++++++++++++++++++
 include/linux/bpf.h                | 19 ++-----------------
 kernel/bpf/bpf_iter.c              |  1 +
 kernel/bpf/helpers.c               |  1 +
 kernel/bpf/local_storage.c         |  1 +
 kernel/bpf/syscall.c               |  1 +
 net/core/dev.c                     |  1 +
 10 files changed, 63 insertions(+), 27 deletions(-)
 create mode 100644 include/linux/bpf-cgroup-storage.h
 create mode 100644 include/linux/bpf-cgroup-types.h
 create mode 100644 include/linux/bpf-link.h

-- 
2.31.1

