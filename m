Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28586309FC6
	for <lists+bpf@lfdr.de>; Mon,  1 Feb 2021 01:51:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbhBAAvI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 31 Jan 2021 19:51:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:50562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229535AbhBAAvF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 31 Jan 2021 19:51:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA2DB64E09;
        Mon,  1 Feb 2021 00:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612140625;
        bh=n9WOVNWvNJFOXO4zxKxrK9hQlxtfjXq32Ff1qqZtjEU=;
        h=From:To:Cc:Subject:Date:From;
        b=t5FV4VkO4wCxwImcAaqbvrSFboHyIeG1DW49tlOp/t8NgsmbwMGOVrBsFwEGaC6mW
         wj4HdtTl6xnCCYCCh5xJ48HM1USA+Rs0NGAkwzQLRJDO9GWApoN+5o8aeKECejKb+F
         4494LILnW+Vrtl417zKH9sQo7lVM/byhz/atzfgMLBv+3dhPspdmp/NLV6kJWeVzmq
         K47J3gO1WkSoOv9TcTKHwrkBrMDXVQ8hBtJJ/H4jR/ixKtnnCyvo9shpFz+gW3YBtD
         7XFXFwZTozHVNjgIDPIbTEWF9iOxC4sc4fVkh81PVJX7tXJ5FPkKRWBuIUQnxL95Bw
         Mg6VZZJ4SvjjA==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next v3 0/2] BPF selftest helper script
Date:   Mon,  1 Feb 2021 00:50:16 +0000
Message-Id: <20210201005018.25808-1-kpsingh@kernel.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

# v2 -> v3

- Fixes to silence verbose commands
- Fixed output buffering without being teed out
- Fixed the clobbered error code of the script
- Other fixes suggested by Andrii

# v1 -> v2

- The script now compiles the kernel by default, and the -k option
  implies "keep the kernel"
- Pointer to the script in the docs.
- Some minor simplifications.

Allow developers and contributors to understand if their changes would
end up breaking the BPF CI and avoid the back and forth required for
fixing the test cases in the CI environment. The series also adds a
pointer in tools/testing/selftests/bpf/README.rst.


KP Singh (2):
  bpf: Helper script for running BPF presubmit tests
  bpf/selftests: Add a short note about run_in_vm.sh in README.rst

 tools/testing/selftests/bpf/README.rst   |  24 ++
 tools/testing/selftests/bpf/run_in_vm.sh | 356 +++++++++++++++++++++++
 2 files changed, 380 insertions(+)
 create mode 100755 tools/testing/selftests/bpf/run_in_vm.sh

-- 
2.30.0.365.g02bc693789-goog

