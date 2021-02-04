Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAA2D30FD30
	for <lists+bpf@lfdr.de>; Thu,  4 Feb 2021 20:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238067AbhBDTqb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Feb 2021 14:46:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:58570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236773AbhBDTq3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Feb 2021 14:46:29 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9013164F45;
        Thu,  4 Feb 2021 19:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612467948;
        bh=osV4HuY/FQXAgwCHkHiSLhNjhdmvEn0cF20mOPRQ51s=;
        h=From:To:Cc:Subject:Date:From;
        b=CVA64FPDp5msW0yKXzonqVSPWBPczlDEPEWDcMI6qqb8/eY3buWA7C9baAAxZT+2n
         a22uhXkYUCAQJF9TT6E8vsKIC6RKgYHFwhHMk3bVq5eJz///xZyq28PGfJvtkXdMlP
         tdFIrgmOuI+VXy2f3dubpcC73P84dtRxTphqOkAhs/9SfylOrOfjK9GnuYLCt23cSI
         cYcNXPTz5FGe7nvJO0P0f2DmOH+7LWPP2fEyup8RUPkGBEMlC89q3HXa8JIsiasrY6
         Z79lG1iJ5yI9WSo01jsq6486Xum8KO6MO79yFRZ6tTr1E8+cNX/GYECI5R4YL9ywbk
         DZ0biRV+hx1lA==
From:   KP Singh <kpsingh@kernel.org>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next v5 0/2] BPF selftest helper script
Date:   Thu,  4 Feb 2021 19:45:42 +0000
Message-Id: <20210204194544.3383814-1-kpsingh@kernel.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

# v4 -> v5

- Use %Y (modification time) instead of %W (creation time) of the local
  copy of the kernel config to check for newer upstream config.
- Rename the script to vmtest.sh

# v3 -> v4

- Fix logic for updating kernel config to not download the file
  if there are no upstream modifications and avoid extraneous
  kernel compilation as suggested by Andrii.
- This also removes the need for the -k flag.

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
fixing the test cases in the CI environment. The se


KP Singh (2):
  bpf: Helper script for running BPF presubmit tests
  bpf/selftests: Add a short note about vmtest.sh in README.rst

 tools/testing/selftests/bpf/README.rst |  24 ++
 tools/testing/selftests/bpf/vmtest.sh  | 368 +++++++++++++++++++++++++
 2 files changed, 392 insertions(+)
 create mode 100755 tools/testing/selftests/bpf/vmtest.sh

-- 
2.30.0.365.g02bc693789-goog

