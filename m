Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D300C47EFD3
	for <lists+bpf@lfdr.de>; Fri, 24 Dec 2021 16:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353070AbhLXP31 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Dec 2021 10:29:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238876AbhLXP30 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Dec 2021 10:29:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEA2C061401
        for <bpf@vger.kernel.org>; Fri, 24 Dec 2021 07:29:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 337F962051
        for <bpf@vger.kernel.org>; Fri, 24 Dec 2021 15:29:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 035F7C36AE5;
        Fri, 24 Dec 2021 15:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640359764;
        bh=uthcZezSAEQwxl69j/pIBFh34+JCaoCY9XIgIxbV70Q=;
        h=From:To:Cc:Subject:Date:From;
        b=DdPm/zqxJrdsE5wSNxBW4voJqADdJIPoAa7nzGFgBWrhXEKVtYbiRddtrymmqQgYk
         IA05vbXynTyp0gsvxm4tSDgQ9K8tgpW3kjay5O2XbTSMOvbxvRbkl4WwArattSoEVf
         aHSXcNgrxfBkRzJq655hFwH6MFJEjRQIaeUq2bwZok5plwRYZaKERT/Vbm01101M8m
         kTKLcRUkmVfHnjP5R7GgBOOyuzlnbHjDmAMlc6Yftq13qtqZ5iqJ3YuAgwneoErzbl
         h3ghdT9BxcacleYJbh9HzisuQYgTdgzBwZZ8k3EZFN+E5MgAAECIYanybtwsVU1fIL
         cKl9TMed0u3qQ==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH v3 bpf-next 0/2] Sleepable local storage
Date:   Fri, 24 Dec 2021 15:29:14 +0000
Message-Id: <20211224152916.1550677-1-kpsingh@kernel.org>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Local storage is currently unusable in sleepable helpers. One of the
important use cases of local_storage is to attach security (or
performance) contextual information to kernel objects in LSM / tracing
programs to be used later in the life-cyle of the object.

Sometimes this context can only be gathered from sleepable programs
(because it needs accesing __user pointers or helpers like
bpf_ima_inode_hash). Allowing local storage to be used from sleepable
programs allows such context to be managed with the benefits of
local_storage.

# v2 -> v3

* Fixed some RCU issues pointed by Martin
* Added Martin's ack

# v1 -> v2

* Generalize RCU checks (will send a separate patch for updating
  non local storage code where this can be used).
* Add missing RCU lock checks from v1


KP Singh (2):
  bpf: Allow bpf_local_storage to be used by sleepable programs
  bpf/selftests: Update local storage selftest for sleepable programs

 include/linux/bpf_local_storage.h             |  5 ++
 kernel/bpf/bpf_inode_storage.c                |  6 ++-
 kernel/bpf/bpf_local_storage.c                | 50 ++++++++++++++-----
 kernel/bpf/bpf_task_storage.c                 |  6 ++-
 kernel/bpf/verifier.c                         |  3 ++
 net/core/bpf_sk_storage.c                     |  8 ++-
 .../bpf/prog_tests/test_local_storage.c       | 20 +++-----
 .../selftests/bpf/progs/local_storage.c       | 24 ++-------
 8 files changed, 73 insertions(+), 49 deletions(-)

-- 
2.34.1.448.ga2b2bfdf31-goog

