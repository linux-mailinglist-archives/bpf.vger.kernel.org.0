Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9E18469F48
	for <lists+bpf@lfdr.de>; Mon,  6 Dec 2021 16:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385606AbhLFPrA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Dec 2021 10:47:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388100AbhLFPcT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Dec 2021 10:32:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54271C07E5EF
        for <bpf@vger.kernel.org>; Mon,  6 Dec 2021 07:19:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA29C61333
        for <bpf@vger.kernel.org>; Mon,  6 Dec 2021 15:19:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188CEC341C5;
        Mon,  6 Dec 2021 15:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638803954;
        bh=NkFh14f9GKhNQpaRdlpQj8PNwTqBu9qk1GpGaedda3Q=;
        h=From:To:Cc:Subject:Date:From;
        b=ZHKBy9jkNisy4eOsNDNl537feJo2LRM6G3+ZSpZcMha1896+KbPJMlm4hvs/7Vl8q
         pVWesBfpYV/SNn5ddY8rDH1bt1NcAPdZm0CUnZUDaloTYzcDavQr2THkr0iQFO6oAM
         smSquVOFdsrZ9ggQBWfo35kjWwSFkhVjm3S0oU7PRIt9jcW2OJbwM9GI1t0Fg3ovkS
         LUjTG8eDj0IYiwVeqYTcGM8fNs5RTGlxE7vxI206dp5XAKvcBK4xIn9SZT85y/J/AK
         +HGE9RQvM/LHn+xU5TVlfhSLkYRVJYGYCHjcH6ctgkSktXGYJKPadenOAslIeQYWJB
         flx9wamwVinvg==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH v2 bpf-next 0/2] Sleepable local storage
Date:   Mon,  6 Dec 2021 15:19:07 +0000
Message-Id: <20211206151909.951258-1-kpsingh@kernel.org>
X-Mailer: git-send-email 2.34.1.400.ga245620fadb-goog
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

# v1 -> v2

* Generalize RCU checks (will send a separate patch for updating
  non local storage code where this can be used).
* Add missing RCU lock checks from v1

KP Singh (2):
  bpf: Allow bpf_local_storage to be used by sleepable programs
  bpf/selftests: Update local storage selftest for sleepable programs

 include/linux/bpf_local_storage.h             |  5 ++
 kernel/bpf/bpf_inode_storage.c                |  9 +++-
 kernel/bpf/bpf_local_storage.c                | 51 ++++++++++++++-----
 kernel/bpf/bpf_task_storage.c                 |  9 +++-
 kernel/bpf/verifier.c                         |  3 ++
 net/core/bpf_sk_storage.c                     |  8 ++-
 .../bpf/prog_tests/test_local_storage.c       | 20 +++-----
 .../selftests/bpf/progs/local_storage.c       | 24 ++-------
 8 files changed, 77 insertions(+), 52 deletions(-)

-- 
2.34.1.400.ga245620fadb-goog

