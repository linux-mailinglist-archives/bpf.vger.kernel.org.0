Return-Path: <bpf+bounces-11455-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF317BA35B
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 17:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 3532E2822B3
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 15:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5B230F9D;
	Thu,  5 Oct 2023 15:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2co4MVX"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA08230CF1
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 15:55:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24067C433C7;
	Thu,  5 Oct 2023 15:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696521354;
	bh=SIPC1Mp73EwXkbAN9/gPbN2F1Z6TDFvdzsTQ4ZY03dQ=;
	h=From:Subject:Date:To:Cc:From;
	b=K2co4MVXsX0raEVNhAq0awY8LcG3w5yI3l/wZnyZGfRLAvT80ZDEBcvv6YITvjYcr
	 00kAgKOtuXE/ux1hJ1BBKx9eXlkkwRHxsVeCFhPSvjhincMHBw/95lUk+VJO3Wh1hm
	 PFzrTDj4pxS6Dx1UyPC85fCLY3uuHXdhiu4/kUY8x2GhLResTjE59krrYYyzlJBCoN
	 KNanDzJjsDlXScvlil9vp5+ItLR5weKcbmZb6xfRgaYgeREFfUHZQkg3LHNE4WWLe1
	 sBEdBd1IhduYAJKbkhu6lInk437bomEoTvufvi1DArLKLwMoYFT3a9DlUfQgLC5EfS
	 WyHUqIYNgh6+A==
From: Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH v3 0/3] selftests/hid: assorted fixes
Date: Thu, 05 Oct 2023 17:55:31 +0200
Message-Id: <20230825-wip-selftests-v3-0-639963c54109@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHPcHmUC/3WNyw6CMBBFf4V07ZgyWF4r/8OwKDhAY1PIDKKG8
 O9W9i7PSe49mxJiR6LqZFNMqxM3hQjZKVHdaMNA4O6RFWrMdIkGXm4GId8vJItAZQujsTW5uaC
 Km9YKQcs2dGNchaf3Uc5MvXsfkVsTeXSyTPw5mmv6s//u1xQ0dGWORV5p1La8PogD+fPEg2r2f
 f8CxcY7E8AAAAA=
To: Jiri Kosina <jikos@kernel.org>, 
 Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, Justin Stitt <justinstitt@google.com>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Eduard Zingerman <eddyz87@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696521351; l=2800;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=SIPC1Mp73EwXkbAN9/gPbN2F1Z6TDFvdzsTQ4ZY03dQ=;
 b=zaZ5m2UhLY7gtQNNTXMahtti4JXH9dKv4AZSJBR7TtloTNTI+kYJC5Wfua8smGDoNT4eHkXk0
 y/Wwat3hT3lD9/tB8vwSij82GRiVd266JJsMbZ0kNt6qUmmNC8U4Ijx
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

And this is the last(?) revision of this series which should now compile
with or without CONFIG_HID_BPF set.

I had to do changes because [1] was failing

Nick, I kept your Tested-by, even if I made small changes in 1/3. Feel
free to shout if you don't want me to keep it.

Eduard, You helped us a lot in the review of v1 but never sent your
Reviewed-by or Acked-by. Do you want me to add one?

Cheers,
Benjamin

[1] https://gitlab.freedesktop.org/bentiss/hid/-/jobs/49754306

For reference, the v2 cover letter:

| Hi, I am sending this series on behalf of myself and Benjamin Tissoires. There
| existed an initial n=3 patch series which was later expanded to n=4 and
| is now back to n=3 with some fixes added in and rebased against
| mainline.
|
| This patch series aims to ensure that the hid/bpf selftests can be built
| without errors.
|
| Here's Benjamin's initial cover letter for context:
| |  These fixes have been triggered by [0]:
| |  basically, if you do not recompile the kernel first, and are
| |  running on an old kernel, vmlinux.h doesn't have the required
| |  symbols and the compilation fails.
| |
| |  The tests will fail if you run them on that very same machine,
| |  of course, but the binary should compile.
| |
| |  And while I was sorting out why it was failing, I realized I
| |  could do a couple of improvements on the Makefile.
| |
| |  [0] https://lore.kernel.org/linux-input/56ba8125-2c6f-a9c9-d498-0ca1c153dcb2@redhat.com/T/#t

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
Changes in v3:
- Also overwrite all of the enum symbols in patch 1/3
- Link to v2: https://lore.kernel.org/r/20230908-kselftest-09-08-v2-0-0def978a4c1b@google.com

Changes in v2:
- roll Justin's fix into patch 1/3
- add __attribute__((preserve_access_index)) (thanks Eduard)
- rebased onto mainline (2dde18cd1d8fac735875f2e4987f11817cc0bc2c)
- Link to v1: https://lore.kernel.org/r/20230825-wip-selftests-v1-0-c862769020a8@kernel.org

Link: https://github.com/ClangBuiltLinux/linux/issues/1698
Link: https://github.com/ClangBuiltLinux/continuous-integration2/issues/61

---
Benjamin Tissoires (3):
      selftests/hid: ensure we can compile the tests on kernels pre-6.3
      selftests/hid: do not manually call headers_install
      selftests/hid: force using our compiled libbpf headers

 tools/testing/selftests/hid/Makefile               | 10 ++-
 tools/testing/selftests/hid/progs/hid.c            |  3 -
 .../testing/selftests/hid/progs/hid_bpf_helpers.h  | 77 ++++++++++++++++++++++
 3 files changed, 81 insertions(+), 9 deletions(-)
---
base-commit: 29aa98d0fe013e2ab62aae4266231b7fb05d47a2
change-id: 20230825-wip-selftests-9a7502b56542

Best regards,
-- 
Benjamin Tissoires <bentiss@kernel.org>


