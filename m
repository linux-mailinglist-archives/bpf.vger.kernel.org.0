Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 608592F2950
	for <lists+bpf@lfdr.de>; Tue, 12 Jan 2021 08:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392149AbhALH4O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jan 2021 02:56:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:43448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731058AbhALH4N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jan 2021 02:56:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B8F3A22E01;
        Tue, 12 Jan 2021 07:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610438132;
        bh=LZYvjbPsUpI8ywXQfEviexBoHvtcOk359LQbsn7GNoc=;
        h=From:To:Cc:Subject:Date:From;
        b=vFLLgHottAmVuovMoLa/rT6ODDGxqCkItUFlcCGXly3E5TnlxWZXxE470DsePE0+8
         dY5dDIXz7xGXwdRb9I2gzN7wE5IOck5m86iJg5aeue3q9Uy+2kv4gql3aoy7oLMGZL
         KLoilQpZeT0af2DVomJmZAKB1BALjA/WlnEIwSsmtCIowatIorGUFbBjOjx8TsYrFP
         sy91XGioACZJe+YEFTjmnNxgfSYHZhMk/AKxv1TJcVt7/KHvvWhm0ozqW0K7bTpWNV
         3mjBGpeLNmg5FgXBMcueI4tkIe7qUYPKkUmMES601p+3JAEMvAhdxh+qce0PaiGggf
         x1wNX9fISQikw==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf v3 0/3] Fix local storage helper OOPs
Date:   Tue, 12 Jan 2021 07:55:22 +0000
Message-Id: <20210112075525.256820-1-kpsingh@kernel.org>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

# v2 -> v3

* Checking the return value of mkdtemp intead of errno
* Added Yonghong's Acks

It was noted in
https://lore.kernel.org/bpf/CACYkzJ55X8Tp2q4+EFf2hOM_Lysoim1xJY1YdA3k=T3woMW6mg@mail.gmail.com/T/#t
that the local storage helpers do not handle null owner pointers
correctly. This patch fixes the task and inode storage helpers with a
null check. In order to keep the check explicit, it's kept in the body
of the helpers similar to sk_storage and also fixes a minor typo in
bpf_inode_storage.c [I did not add a fixes and reported tag to the
patch that fixes the typo since it's a non-functional change].

The series also incorporates the example posted by Gilad into the
selftest. The selftest, without the fix reproduces the oops and the
subsequent patch fixes it.

KP Singh (3):
  bpf: update local storage test to check handling of null ptrs
  bpf: local storage helpers should check nullness of owner ptr passed
  bpf: Fix typo in bpf_inode_storage.c

 kernel/bpf/bpf_inode_storage.c                |  9 +-
 kernel/bpf/bpf_task_storage.c                 |  5 +-
 .../bpf/prog_tests/test_local_storage.c       | 96 +++++--------------
 .../selftests/bpf/progs/local_storage.c       | 62 ++++++------
 4 files changed, 71 insertions(+), 101 deletions(-)

-- 
2.30.0.284.gd98b1dd5eaa7-goog

