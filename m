Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 503864752EA
	for <lists+bpf@lfdr.de>; Wed, 15 Dec 2021 07:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbhLOGTa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Dec 2021 01:19:30 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:50066 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhLOGTa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Dec 2021 01:19:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F08FE6181D
        for <bpf@vger.kernel.org>; Wed, 15 Dec 2021 06:19:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DCA9C34600;
        Wed, 15 Dec 2021 06:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639549169;
        bh=mQIzmxaX53KbTnO0Ra2/yRuJeKKpasAGdEfX0QePZ3s=;
        h=From:To:Cc:Subject:Date:From;
        b=CvfhRhHJRmp2sFlB3wXS6pSDaRW3SpTbyw5Z6A9+cNNti+W1dzIMsbrX+GIlE/KQI
         LZjATWUWHrYIIH9wdGmaU6U6+1JOslg4u0XpAufxGN92xXj5DkVD2dF2zXm5JCCaRv
         3OG5AOjjg60Tr4SqMNl9Kkvm/x6nIVsyBzVa8ro8z4/+Clsih0kDUlnL4dWO8Dg3UE
         srYobD2agAFDluEjPKJTWE6LnnVDKXQ5MYMOkwcuPatLgzBLPvyWhWE/WtLgCQbX92
         8/jObmAQo92Gi551oQ7h2cWW9l5SWysjMKSoURv9HHx+mME0xDBxfqaY9fa8sScpqU
         WrQHfYsO3427Q==
From:   Jakub Kicinski <kuba@kernel.org>
To:     daniel@iogearbox.net, ast@kernel.org, andrii@kernel.org
Cc:     bpf@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH bpf-next v3 0/3] bpf: remove the cgroup -> bpf header dependecy
Date:   Tue, 14 Dec 2021 22:19:13 -0800
Message-Id: <20211215061916.715513-1-kuba@kernel.org>
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

v3:
Merge bpf-includes.h into bpf.h.
Remember to git format-patch after fixing build issues.

Jakub Kicinski (3):
  add includes masked by cgroup -> bpf dependency
  bpf: add header for enum bpf_cgroup_storage_type and bpf_link
  bpf: remove the cgroup -> bpf header dependecy

 arch/s390/mm/hugetlbpage.c       |  1 +
 include/linux/bpf-cgroup-types.h | 29 +++++++++++++++++++++++++++++
 include/linux/bpf-cgroup.h       | 12 ++----------
 include/linux/bpf.h              | 27 ++++++++++-----------------
 4 files changed, 42 insertions(+), 27 deletions(-)
 create mode 100644 include/linux/bpf-cgroup-types.h

-- 
2.31.1

