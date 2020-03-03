Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A508177862
	for <lists+bpf@lfdr.de>; Tue,  3 Mar 2020 15:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbgCCOKH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Mar 2020 09:10:07 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35823 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729581AbgCCOKG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Mar 2020 09:10:06 -0500
Received: by mail-wr1-f65.google.com with SMTP id r7so4542117wro.2
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2020 06:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mGFNfxmSybPpi8Hxmqj4rozq0S6s0SBGDpgeol/ec0I=;
        b=VYjDCqBAbxSTav8zxv1sG9jECNZkU1Dym5p9TwusiD/iRF1iUnhNinGL/PoZGdrGDI
         5gk4yUPNEvlwA4ckubT6gKxT2wz8MggXD1BrU6DOvKb9DhzuPCuoMVMwoPKeF6IRAAfN
         uj5G/oQUMKrjpGuVWEOyfaZVYxUIyg8QN62lI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mGFNfxmSybPpi8Hxmqj4rozq0S6s0SBGDpgeol/ec0I=;
        b=ClQPlClz+pKzkwaGxAPOSEb8V9fdkEDp0KqRWRNEG9vUiX5DkGnIIoalmfk0JIL7J/
         TJtfE0HALZmWKqBZ23bVLhx98n5+d+g9BFaRWw1dQG/jMjPMsa2DCNpbMy9V4rp6oiIj
         M06q8mH361EUmGW0ykj+fzSKIfqyrKMvcjioRRuIQb8U2CfMX6bc/g/a7yZq2c8mtvmR
         0Wc6dOht85IxBkinQALkbloQDmf+AGF/Cx2OL9HyZcDUjr1ufTXl45uccgfyu9eyRWMe
         tngXqBTiEEGzgfe7kFil1OSP2sbQ4QB/XssY4k/C6JFr+WJ2tsLDSuTLrkxySMDwQyG1
         N/qg==
X-Gm-Message-State: ANhLgQ3XbWF7dz2MPeZ9O3PqyrXIwlq/EQr5S/IMjFYCj2nplaWideWr
        EKz32bQf95jwHdZ/pCS3AcmLDQ==
X-Google-Smtp-Source: ADFU+vtVfcuYABDMhFlSg1yG4SAV6zEXwauaAh/uYewZFENHVXS1M4zs+X78HrkaPQkWLwCeG/1wYQ==
X-Received: by 2002:adf:94a3:: with SMTP id 32mr6123482wrr.276.1583244604871;
        Tue, 03 Mar 2020 06:10:04 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2a00:79e1:abc:308:2811:c80d:9375:bf8a])
        by smtp.gmail.com with ESMTPSA id h20sm11746823wrc.47.2020.03.03.06.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 06:10:04 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next 5/7] tools/libbpf: Add support for BPF_MODIFY_RETURN
Date:   Tue,  3 Mar 2020 15:09:48 +0100
Message-Id: <20200303140950.6355-6-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303140950.6355-1-kpsingh@chromium.org>
References: <20200303140950.6355-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Signed-off-by: KP Singh <kpsingh@google.com>
---
 tools/lib/bpf/libbpf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index f8c4042e5855..223be01dc466 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6288,6 +6288,10 @@ static const struct bpf_sec_def section_defs[] = {
 		.expected_attach_type = BPF_TRACE_FENTRY,
 		.is_attach_btf = true,
 		.attach_fn = attach_trace),
+	SEC_DEF("fmod_ret/", TRACING,
+		.expected_attach_type = BPF_MODIFY_RETURN,
+		.is_attach_btf = true,
+		.attach_fn = attach_trace),
 	SEC_DEF("fexit/", TRACING,
 		.expected_attach_type = BPF_TRACE_FEXIT,
 		.is_attach_btf = true,
-- 
2.20.1

