Return-Path: <bpf+bounces-11210-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6167B556B
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 16:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 5A590282C38
	for <lists+bpf@lfdr.de>; Mon,  2 Oct 2023 14:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856241A701;
	Mon,  2 Oct 2023 14:48:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176F319BCF
	for <bpf@vger.kernel.org>; Mon,  2 Oct 2023 14:48:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C2DC433C7;
	Mon,  2 Oct 2023 14:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696258086;
	bh=HHXocg/UqDLTpBTms/VMzX03y/J3TDNJKoUjdrxZ1l0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SxqRp350bCXrlLYTCXAC17UQCCmm51+C+6kQ9mkjWoxlB9MTfh5N0bCKg2/EnnjcT
	 f885QQtuJrMdAMYs/2pQiLF6l+SU2plFx76+tNDHdskSW6EbAUq9cvw2VIB9dYBVMx
	 5dQfl2E/QIlaUl93d9aSRNJpP5epZTeelI9WF5qvUxTm2WMzSsxx1La69ysKCKBIhr
	 78VGgPpD3mrWViQouPWR/BU+gxZaAHtgnQU+D8CebnD30jJCzB8lfZ1rEwrlUorFPm
	 8nzsS3U0yc5+hj7igp3Ym6oyiNOUYyghmqaWqB08Blj1GEmCen4MWqnRBT+TQ6gL6X
	 bD9xQdW5ANvgQ==
Date: Mon, 2 Oct 2023 16:48:01 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 0/3] selftests/hid: fix building for older kernels
Message-ID: <lhb7u2lg7fv2wx3kzrboftqcdtmbjvbzz7zssfn5mho72hcrvj@i53fzzis7b4q>
References: <20230908-kselftest-09-08-v2-0-0def978a4c1b@google.com>
 <CAFhGd8pEv32zp4RDsj_jeBjzP5hcsf4dP4Knueiw_UM8ZsqcKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFhGd8pEv32zp4RDsj_jeBjzP5hcsf4dP4Knueiw_UM8ZsqcKw@mail.gmail.com>

On Sep 26 2023, Justin Stitt wrote:
> Hey all,
> 
> Gentle ping on this patch. Looking to get this patch and [1] slated
> for 6.7 wherein we can start getting cleaner kselftests builds.
> 
> I do not think I am able to successfully run the hid/bpf selftests due
> to my kernel version being too low (and an inability to upgrade it as
> I'm on a corp rolling release). I'd appreciate some insight on how to
> get the tests running or if someone could actually build+run the tests
> with this patch applied.

I wanted to apply this series today, but it failed my own CI now with
the enums being already defined:
https://gitlab.freedesktop.org/bentiss/hid/-/jobs/49754306

I'll probably squash the following patch in 1/3, would you mind giving
it a test?

---
From 37feca6c0e84705ad65e621643206c287b63bb0a Mon Sep 17 00:00:00 2001
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Mon, 2 Oct 2023 15:37:18 +0200
Subject: [PATCH] fix selftests/hid: ensure we can compile the tests on kernels
 pre-6.3

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 .../selftests/hid/progs/hid_bpf_helpers.h     | 30 ++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
index ab3b18ba48c4..feed5a991e05 100644
--- a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
+++ b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
@@ -5,16 +5,44 @@
 #ifndef __HID_BPF_HELPERS_H
 #define __HID_BPF_HELPERS_H
 
-/* "undefine" structs in vmlinux.h, because we "override" them below */
+/* "undefine" structs and enums in vmlinux.h, because we "override" them below */
 #define hid_bpf_ctx hid_bpf_ctx___not_used
 #define hid_report_type hid_report_type___not_used
 #define hid_class_request hid_class_request___not_used
 #define hid_bpf_attach_flags hid_bpf_attach_flags___not_used
+#define HID_INPUT_REPORT         HID_INPUT_REPORT___not_used
+#define HID_OUTPUT_REPORT        HID_OUTPUT_REPORT___not_used
+#define HID_FEATURE_REPORT       HID_FEATURE_REPORT___not_used
+#define HID_REPORT_TYPES         HID_REPORT_TYPES___not_used
+#define HID_REQ_GET_REPORT       HID_REQ_GET_REPORT___not_used
+#define HID_REQ_GET_IDLE         HID_REQ_GET_IDLE___not_used
+#define HID_REQ_GET_PROTOCOL     HID_REQ_GET_PROTOCOL___not_used
+#define HID_REQ_SET_REPORT       HID_REQ_SET_REPORT___not_used
+#define HID_REQ_SET_IDLE         HID_REQ_SET_IDLE___not_used
+#define HID_REQ_SET_PROTOCOL     HID_REQ_SET_PROTOCOL___not_used
+#define HID_BPF_FLAG_NONE        HID_BPF_FLAG_NONE___not_used
+#define HID_BPF_FLAG_INSERT_HEAD HID_BPF_FLAG_INSERT_HEAD·___not_used
+#define HID_BPF_FLAG_MAX         HID_BPF_FLAG_MAX___not_used
+
 #include "vmlinux.h"
+
 #undef hid_bpf_ctx
 #undef hid_report_type
 #undef hid_class_request
 #undef hid_bpf_attach_flags
+#undef HID_INPUT_REPORT
+#undef HID_OUTPUT_REPORT
+#undef HID_FEATURE_REPORT
+#undef HID_REPORT_TYPES
+#undef HID_REQ_GET_REPORT
+#undef HID_REQ_GET_IDLE
+#undef HID_REQ_GET_PROTOCOL
+#undef HID_REQ_SET_REPORT
+#undef HID_REQ_SET_IDLE
+#undef HID_REQ_SET_PROTOCOL
+#undef HID_BPF_FLAG_NONE
+#undef HID_BPF_FLAG_INSERT_HEAD
+#undef HID_BPF_FLAG_MAX
 
 #include <bpf/bpf_helpers.h>
 #include <bpf/bpf_tracing.h>
-- 
2.41.0
---

Cheers,
Benjamin

> 
> On Sat, Sep 9, 2023 at 7:22 AM Justin Stitt <justinstitt@google.com> wrote:
> >
> > Hi, I am sending this series on behalf of myself and Benjamin Tissoires. There
> > existed an initial n=3 patch series which was later expanded to n=4 and
> > is now back to n=3 with some fixes added in and rebased against
> > mainline.
> >
> > This patch series aims to ensure that the hid/bpf selftests can be built
> > without errors.
> >
> > Here's Benjamin's initial cover letter for context:
> > |  These fixes have been triggered by [0]:
> > |  basically, if you do not recompile the kernel first, and are
> > |  running on an old kernel, vmlinux.h doesn't have the required
> > |  symbols and the compilation fails.
> > |
> > |  The tests will fail if you run them on that very same machine,
> > |  of course, but the binary should compile.
> > |
> > |  And while I was sorting out why it was failing, I realized I
> > |  could do a couple of improvements on the Makefile.
> > |
> > |  [0] https://lore.kernel.org/linux-input/56ba8125-2c6f-a9c9-d498-0ca1c153dcb2@redhat.com/T/#t
> >
> > Changes from v1 -> v2:
> > - roll Justin's fix into patch 1/3
> > - add __attribute__((preserve_access_index)) (thanks Eduard)
> > - rebased onto mainline (2dde18cd1d8fac735875f2e4987f11817cc0bc2c)
> > - Link to v1: https://lore.kernel.org/all/20230825-wip-selftests-v1-0-c862769020a8@kernel.org/
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1698
> > Link: https://github.com/ClangBuiltLinux/continuous-integration2/issues/61
> > ---
> > Benjamin Tissoires (3):
> >       selftests/hid: ensure we can compile the tests on kernels pre-6.3
> >       selftests/hid: do not manually call headers_install
> >       selftests/hid: force using our compiled libbpf headers
> >
> >  tools/testing/selftests/hid/Makefile               | 10 ++---
> >  tools/testing/selftests/hid/progs/hid.c            |  3 --
> >  .../testing/selftests/hid/progs/hid_bpf_helpers.h  | 49 ++++++++++++++++++++++
> >  3 files changed, 53 insertions(+), 9 deletions(-)
> > ---
> > base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
> > change-id: 20230908-kselftest-09-08-56d7f4a8d5c4
> >
> > Best regards,
> > --
> > Justin Stitt <justinstitt@google.com>
> >
> 
> [1]: https://lore.kernel.org/all/20230912-kselftest-param_test-c-v1-1-80a6cffc7374@google.com/
> 
> Thanks
> Justin

