Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6B230FD32
	for <lists+bpf@lfdr.de>; Thu,  4 Feb 2021 20:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238040AbhBDTqg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Feb 2021 14:46:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:58614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236773AbhBDTqc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Feb 2021 14:46:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA30D60235;
        Thu,  4 Feb 2021 19:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612467952;
        bh=k9Konr7Nk0H7t6e9uwG/7UU5ypIEKixGDCxu/sruMqY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N83NL+opTj67sQ0gfQa9le+ZxHSMOkhOhjd0IJAfwqq077nSIHmu11XgePmUEkFoe
         +NKwtS1saYhdSyk32q2xkby7fcoZKs+7RDFDbJNi9XvBf0Dj6yqvVGWGV/O05RaYFp
         e9LiiinRZlJUSqxhoAYp0YHLw3GArFKPvQOLsJEqK29jNyvhwVym3jkY3ui1aUmIX3
         SKHEd/9jY6FQdKoie3oFaZkrk257IOkvLtYe+Sj7cTBx5Le/N3yRE7GVYicK3uXzhC
         2RwPLAl2YhDV9G4xvKrE35rglAx5BRwutpSahf9LhQcuuPHJAwqWDjxwGzd/WcmuJg
         UP8fVcCClHSTA==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next v5 2/2] bpf/selftests: Add a short note about vmtest.sh in README.rst
Date:   Thu,  4 Feb 2021 19:45:44 +0000
Message-Id: <20210204194544.3383814-3-kpsingh@kernel.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
In-Reply-To: <20210204194544.3383814-1-kpsingh@kernel.org>
References: <20210204194544.3383814-1-kpsingh@kernel.org>
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
index ca064180d4d0..fd148b8410fa 100644
--- a/tools/testing/selftests/bpf/README.rst
+++ b/tools/testing/selftests/bpf/README.rst
@@ -6,6 +6,30 @@ General instructions on running selftests can be found in
 
 __ /Documentation/bpf/bpf_devel_QA.rst#q-how-to-run-bpf-selftests
 
+=========================
+Running Selftests in a VM
+=========================
+
+It's now possible to run the selftests using ``tools/testing/selftests/bpf/vmtest.sh``.
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
+  $ tools/testing/selftests/bpf/vmtest.sh -h
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

