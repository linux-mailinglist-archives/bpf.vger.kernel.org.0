Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF283011C6
	for <lists+bpf@lfdr.de>; Sat, 23 Jan 2021 01:45:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726306AbhAWApb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jan 2021 19:45:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:53274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726123AbhAWAp3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jan 2021 19:45:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D381F235DD;
        Sat, 23 Jan 2021 00:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611362689;
        bh=SrKWB2EB1qgoE7MDQKKWpoE6/pjVg9PFryQQEFZ34eA=;
        h=From:To:Cc:Subject:Date:From;
        b=UGFF6a7OjRuaNdcBmDKFZM7ps+vp+6JiSd9L20wZDEWVnqNQki9ihPQ494YL8MpML
         xEa/kjL/T7Aq75nXILe320y5f6dRszw54lLeAlOtWEXCXW7GrYw60Mq9u4+qUqNSIk
         uC6Aqf27QxpAeJKbWQVf1k87xSgsV9aP7+5aFfy0Ay7CUCEMNzwi1kKVzVGQ9Ig/2U
         KoUV1g90Q30CnQDJ8qU8WGVDET0rOE7iDcuDFdaMovrZHyDySoOudpTdnMoUoHXrgR
         yuTaglhqGImdziQv+zoQFlKLX74dGHme+4O16bkOWeaNraBfaC9jhQqNG0rz5ywROa
         gI/AaEYMkEzLQ==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next v2 0/2] BPF selftest helper script
Date:   Sat, 23 Jan 2021 00:44:43 +0000
Message-Id: <20210123004445.299149-1-kpsingh@kernel.org>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

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

 tools/testing/selftests/bpf/README.rst   |  23 ++
 tools/testing/selftests/bpf/run_in_vm.sh | 353 +++++++++++++++++++++++
 2 files changed, 376 insertions(+)
 create mode 100755 tools/testing/selftests/bpf/run_in_vm.sh

-- 
2.30.0.280.ga3ce27912f-goog

