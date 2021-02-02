Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC3830CE9F
	for <lists+bpf@lfdr.de>; Tue,  2 Feb 2021 23:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbhBBWQt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Feb 2021 17:16:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:34502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233382AbhBBWQq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Feb 2021 17:16:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E34CA64F93;
        Tue,  2 Feb 2021 22:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612304165;
        bh=p07brJnYF/aAoAxaFoUpXky3LTt0oZtOY0Z3uYvab9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E0P4lgvkLqkxyydeYv7HJvzMD81S7Xz9qhXB1AD/C+vPhxUkddXjQbApfDSGSCCB6
         vo+H/AF7YoORPsk2+0L+wPqNsuykO+nZhq6HoY9+eA/zJghNElR58+g0jSCC/yoUuG
         c+pwIOINN2SSCEn4WVZMvgolTpWpqq75SKYLIxEu4qnUHrVieV/aIxTqzqvzU/mLCm
         MhshNpud1TC9a+BKUH68MR/mf16FAG7F25RXl9obMvfBX4ydaVf64s1UgvrPW1hGFQ
         /PjUo5QB6N2gkZy0MEwlRNBb8xy7gvllyvYbb5EgveNsVGxODL/cmvy8oXhE2UG2ov
         /zyrBk1PtaCmw==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next v4 2/2] bpf/selftests: Add a short note about run_in_vm.sh in README.rst
Date:   Tue,  2 Feb 2021 22:15:57 +0000
Message-Id: <20210202221557.2039173-3-kpsingh@kernel.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
In-Reply-To: <20210202221557.2039173-1-kpsingh@kernel.org>
References: <20210202221557.2039173-1-kpsingh@kernel.org>
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
 tools/testing/selftests/bpf/README.rst | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/bpf/README.rst b/tools/testing/selftests/bpf/README.rst
index ca064180d4d0..80ddcce8df02 100644
--- a/tools/testing/selftests/bpf/README.rst
+++ b/tools/testing/selftests/bpf/README.rst
@@ -6,6 +6,30 @@ General instructions on running selftests can be found in
 
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
+  $ tools/testing/selftests/bpf/run_in_vm.sh -h
+
+.. note:: The script uses pahole and clang based on host environment setting.
+          If you want to change pahole and llvm, you can change `PATH` environment
+          variable in the beginning of script.
+
+.. note:: The script currently only supports x86_64.
 
 Additional information about selftest failures are
 documented here.
-- 
2.30.0.365.g02bc693789-goog

