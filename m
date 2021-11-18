Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB71945591B
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 11:33:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245333AbhKRKgw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Nov 2021 05:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245619AbhKRKgn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Nov 2021 05:36:43 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC8AC061764
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 02:33:43 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 137so1291231wma.1
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 02:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rZJn2yys8DcTAzYwQDSGPoDW37F/570yrxTfXh7kbsc=;
        b=j4Wu6KWzKYfAlYvq2HS1I/TeKC8AAa6xsTmh/G6sIlISKHIi3zcS/VT87Fb8dfWOFh
         mGaM3N1bGpEJ7c916ANWKgIeBDSDLCiGb6IKWDlyAtQhXVsY8Z+rjpFaSqCc5ZliNv+B
         sthyb66VCxH2V0DQePenA6GGCoaZllSZUwugA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rZJn2yys8DcTAzYwQDSGPoDW37F/570yrxTfXh7kbsc=;
        b=apRxK3T/7ALfOMwIQ0DFwsMW+j25VQEtc25cdw+p7Z17eb+1ykEh7aEjH0nZ0+xCFG
         OrLTnREYbjyjDPAfZXYkuI5a4Mr+zYXhYEe7BDUukfRKHSN0neV9Nm9lu0bhMuJITE7F
         cMds4anSgtrvCox7lBxEgtPWS7YVn3axYE3dttbHWajhnpk23YYM5qgNcb3kgGnpBK0R
         oOYL4PLa6GupLuAnqy/m+ShAOB9BAnPjV0rOx0/1QXTMf8/uRP4QSZ+NwjW2h3fL7nHr
         lYmLQYXhv5JC6vBBIEDxvLGrwTN+LCRRC5DEWgn5cnRe3TFG1iWHMF9KtMi3zV4otGvr
         TZ1g==
X-Gm-Message-State: AOAM532z2RF31ihGGCxhYQdCa7kie5ZeSOzpn4wxTOVJRjhsQ5tfWvPZ
        ghRvcJQ2Au7sJeMdpHHWZ2OTe9eotf6OgA==
X-Google-Smtp-Source: ABdhPJzEsJWXGbz1Yv47x3W5We/ddCiXHLTj/MjqS/zki0onTjpbbxJOqCPuhAQQbo/bE3PHXyoF6Q==
X-Received: by 2002:a05:600c:1d97:: with SMTP id p23mr8650388wms.186.1637231621534;
        Thu, 18 Nov 2021 02:33:41 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:61:302:58e0:dffc:78e8:484])
        by smtp.gmail.com with ESMTPSA id h15sm10097484wmq.32.2021.11.18.02.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 02:33:41 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, kpsingh@kernel.org, jackmanb@google.com,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next] libbpf: Add ability to clear per-program load flags
Date:   Thu, 18 Nov 2021 11:33:35 +0100
Message-Id: <20211118103335.1208372-1-revest@chromium.org>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Recently, bpf_program__flags and bpf_program__set_extra_flags were
introduced to the libbpf API but they only allow adding load flags.

We have a use-case where we construct a skeleton with a sleepable
program and if it fails to load then we want to make it non-sleepable by
clearing BPF_F_SLEEPABLE.

Signed-off-by: Florent Revest <revest@chromium.org>
---
 tools/lib/bpf/libbpf.c   | 9 +++++++++
 tools/lib/bpf/libbpf.h   | 1 +
 tools/lib/bpf/libbpf.map | 1 +
 3 files changed, 11 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index de7e09a6b5ec..dcb7fced5fd2 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8305,6 +8305,15 @@ int bpf_program__set_extra_flags(struct bpf_program *prog, __u32 extra_flags)
 	return 0;
 }
 
+int bpf_program__clear_flags(struct bpf_program *prog, __u32 flags)
+{
+	if (prog->obj->loaded)
+		return libbpf_err(-EBUSY);
+
+	prog->prog_flags &= ~flags;
+	return 0;
+}
+
 #define SEC_DEF(sec_pfx, ptype, atype, flags, ...) {			    \
 	.sec = sec_pfx,							    \
 	.prog_type = BPF_PROG_TYPE_##ptype,				    \
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 4ec69f224342..08f108e49841 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -495,6 +495,7 @@ bpf_program__set_expected_attach_type(struct bpf_program *prog,
 
 LIBBPF_API __u32 bpf_program__flags(const struct bpf_program *prog);
 LIBBPF_API int bpf_program__set_extra_flags(struct bpf_program *prog, __u32 extra_flags);
+LIBBPF_API int bpf_program__clear_flags(struct bpf_program *prog, __u32 flags);
 
 LIBBPF_API int
 bpf_program__set_attach_target(struct bpf_program *prog, int attach_prog_fd,
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 6a59514a48cf..eeff700240dc 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -401,6 +401,7 @@ LIBBPF_0.6.0 {
 		bpf_program__insn_cnt;
 		bpf_program__insns;
 		bpf_program__set_extra_flags;
+		bpf_program__clear_flags;
 		btf__add_btf;
 		btf__add_decl_tag;
 		btf__add_type_tag;
-- 
2.34.0.rc2.393.gf8c9666880-goog

