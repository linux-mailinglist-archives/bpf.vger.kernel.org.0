Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933362CD52E
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 13:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388207AbgLCMJj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 07:09:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388077AbgLCMJj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Dec 2020 07:09:39 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7649C061A4E
        for <bpf@vger.kernel.org>; Thu,  3 Dec 2020 04:08:58 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id u8so1171073wrq.6
        for <bpf@vger.kernel.org>; Thu, 03 Dec 2020 04:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=nWnhV2L36jl8Q2KQ48DfmO4+zFQ9NK25B8o4zxmFHTU=;
        b=CxjBqchGiISIeMXgdc8TuT103CM5diiFGOQO78yeW11SH5o7HYBmKkWKoRRwkjbdQk
         MEE7YC0xvc7zw5NAV2RkJmAaP6Jr3jdga8bAjllM8i2ZKxpdg+DRvgdf4sXT+s/2HqRP
         H7XtpjMSAkfcnTGpPFF0kU1N7+EMFd8N7V9f4tejWbkUp/Sy1vy9Bp7MmIpRIMXjgShN
         iB/KUqH8YE0TZQZFfkiimAC5qCgQ3qLUDOQ3iVH/SSoy8PXYfqJoBYvtNojCkcSY8PYc
         AS/UdgOigttdvB/N1gSXbKPJGXhiIYrxKscHrIg1RhzY3oKXNLcxda0Hjnpf0jcBthpq
         I4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=nWnhV2L36jl8Q2KQ48DfmO4+zFQ9NK25B8o4zxmFHTU=;
        b=KPGqT3GRz+VwWmhwOn2Bmj8ofZzzDSiP4YDbL/2zdsQsxUQ51yvQblHE+BAmKbtVEg
         Mshtl8/6grGea3r0nU9gHopYE+22cxUCrGB40A8UB7Ciu4Y2Ap+KoA+1Uxljj49mGoBp
         4i3gui0Rz8JU+bLkb7do8U81R/5cd/KJlTGIGRZpcqvFWn8BazUOSiXeg9ATOFTfl1yo
         WQ37FMAUZ1LDmzjDionVvsp5pwEuFfz826SELEvtAEi/Dq7032lXXk3lZ8FFHVv7BsED
         6Beop4qfFdeF12s9KonsSuClzCQL/sL44+jvqPbqIAHcIF+rw1PkLozjY4ZqkmXYN4RD
         MirA==
X-Gm-Message-State: AOAM5328YKccDzFoRLBcqJWKEY8qrsAhT8L7k8rrPyVkiimsC+WZo6dU
        R3xNBWFd6srKzdmMexxrW7mpZgGX5NaFgiegFMXFimbdDbx6KwTCUKNuH+K0CeEHgEAS8UDSoH9
        GSeoVhnqSuC5kwW9TyK2DhC3XYfP6ZaXU3CCbajLCzPrF0Dua4ubUiS7di3mXCh8=
X-Google-Smtp-Source: ABdhPJwWFNl4s0ki9ODJ5mmINtSjGhbTT2wgDva5LjbGNkLDaeP7l2jIh0IvFqE9V96y0llq+H6SNNdONZWENA==
Sender: "jackmanb via sendgmr" <jackmanb@beeg.c.googlers.com>
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a1c:791a:: with SMTP id
 l26mr998488wme.1.1606997336622; Thu, 03 Dec 2020 04:08:56 -0800 (PST)
Date:   Thu,  3 Dec 2020 12:08:50 +0000
Message-Id: <20201203120850.859170-1-jackmanb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH bpf-next] bpf: Fix cold build of test_progs-no_alu32
From:   Brendan Jackman <jackmanb@google.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This object lives inside the trunner output dir,
i.e. tools/testing/selftests/bpf/no_alu32/btf_data.o

At some point it gets copied into the parent directory during another
part of the build, but that doesn't happen when building
test_progs-no_alu32 from clean.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 tools/testing/selftests/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 894192c319fb..371b022d932c 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -378,7 +378,7 @@ $(OUTPUT)/$(TRUNNER_BINARY): $(TRUNNER_TEST_OBJS)			\
 			     | $(TRUNNER_BINARY)-extras
 	$$(call msg,BINARY,,$$@)
 	$(Q)$$(CC) $$(CFLAGS) $$(filter %.a %.o,$$^) $$(LDLIBS) -o $$@
-	$(Q)$(RESOLVE_BTFIDS) --no-fail --btf btf_data.o $$@
+	$(Q)$(RESOLVE_BTFIDS) --no-fail --btf $(TRUNNER_OUTPUT)/btf_data.o $$@
 
 endef
 

base-commit: 97306be45fbe7a02461c3c2a57e666cf662b1aaf
-- 
2.29.2.454.gaff20da3a2-goog

