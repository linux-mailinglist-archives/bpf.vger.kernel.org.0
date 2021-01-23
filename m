Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0953011C8
	for <lists+bpf@lfdr.de>; Sat, 23 Jan 2021 01:45:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbhAWApg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Jan 2021 19:45:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:53296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbhAWApc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jan 2021 19:45:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E91AF23B6B;
        Sat, 23 Jan 2021 00:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611362692;
        bh=uchHNpd6lA5CRVAMUZZVF0ENVwZfUFgo18//cWQ8Wh8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ChsqSzO00sI1YI5o81J2wm5DXnsv4aLeUNPAHNZflPhmWDGwpY2RcRvRgraSxaUak
         osQAd1C95M4Kj5l4NWh9+2c5awle3pwq1gJICk5cuDXYFM4AMdnZWr9h5pjb/CG+8v
         OiRy3ivZmG+dDbRb3BRn2fw2sXklKHzFQCPP4vZTqs55GtPDNuPJpdZIPNQ8mG+2xt
         KduTivj72OJW/Zx4/yfRm72H7f248QVRj5EuQ8rdPQz39jltlQ6HT3Rby2RKDQPkdt
         Hm3JutM1qX3MY+MoADwwM3waxEqd5YMD7HpXjzS5oJ3DYP3UMuwF/o35jeTdCdhvx2
         YU3jLmMrvSUdA==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next v2 2/2] bpf/selftests: Add a short note about run_in_vm.sh in README.rst
Date:   Sat, 23 Jan 2021 00:44:45 +0000
Message-Id: <20210123004445.299149-3-kpsingh@kernel.org>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210123004445.299149-1-kpsingh@kernel.org>
References: <20210123004445.299149-1-kpsingh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a short note to make contributors aware of the existence of the
script. The documentation does not intentionally document all the
options of the script to avoid mentioning it in two places (it's
available in the usage / help message of the script).

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 tools/testing/selftests/bpf/README.rst | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selftests/bpf/README.rst
index ca064180d4d0..a0dac65b6b01 100644
--- a/tools/testing/selftests/bpf/README.rst
+++ b/tools/testing/selftests/bpf/README.rst
@@ -6,6 +6,29 @@ General instructions on running selftests can be found in
 
 __ /Documentation/bpf/bpf_devel_QA.rst#q-how-to-run-bpf-selftests
 
+=========================
+Running Selftests in a VM
+=========================
+
+It's now possible to run the selftests using ``tools/testing/selftests/bpf/run_in_vm.sh``.
+The script tries to ensure that the tests are run with the same environment as they
+would be run post-submit in the CI used by the Maintainers.
+
+This script downloads a suitable Kconfig and VM userspace image from the system used by
+the CI. It builds the kernel (without overwriting your existing Kconfig), recompiles the
+bpf selftests, runs them (by default ``tools/testing/selftests/bpf/test_progs``) and
+saves the resulting output (by default in ``~/.bpf_selftests``).
+
+For more information on about using the script, run:
+
+.. code-block:: console
+
+	$ tools/testing/selftests/bpf/run_in_vm.sh -h
+
+.. note:: The script does not yet update pahole and LLVM, so these will still need to be
+          manually updated.
+
+.. note:: The script currently only supports x86_64.
 
 Additional information about selftest failures are
 documented here.
-- 
2.30.0.280.ga3ce27912f-goog

