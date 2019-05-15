Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5D41F5D8
	for <lists+bpf@lfdr.de>; Wed, 15 May 2019 15:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbfEONsZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 May 2019 09:48:25 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52053 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727890AbfEONsZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 May 2019 09:48:25 -0400
Received: by mail-wm1-f67.google.com with SMTP id o189so124281wmb.1
        for <bpf@vger.kernel.org>; Wed, 15 May 2019 06:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kinvolk.io; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p5yzJN+uQCvOHSSRz2qO10uSVTsd9TOZD2wH8snlydI=;
        b=iMDh53PLA//kuvDf60EoF5DO6lg5ZOFCwCIEm72JxVyO2HvdX0hdLeE/BfiaT9mplr
         ICKoDR6mmjODIZ6bHtnZxksT56RhBAJU/9jN5ZetIHshOM1e4ttrczjlifK1UGJYxlZn
         PAM+x/7SXvHl/NrKuZqmda+p4PRbSQWgZbXEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p5yzJN+uQCvOHSSRz2qO10uSVTsd9TOZD2wH8snlydI=;
        b=H03fa4bx4ZN4CP8AeMsonM2bQ7H7vWVzkf3gQKtQgKmNpIki/E1zUGuZUT9gq/kyU2
         9LE/ZavNsLiFXQhBr/Or3wW/9/cojc8uRCW1eX4thBFKgDayF/LF2aP1XYmniPUv1UxK
         +6NVkTE2ZV2k75rOrqEqCLTRgh+KthoSQXz9MWhIEA2Xg/oIMlBRrKDuNSfTdk1n1zEj
         vwTJsSphhvusjBQV1DlrUsT/pTvEcZsdQx8bsX0ZAf1KsJBC3RfeQyXLNiXV7ftXY69A
         HAENmg0z5vcXFH/LavnSmJ7/sasBGq1EE2wsynR8ZjgVBd6EbGn0JDuwDuM1giEHjzdR
         pq2w==
X-Gm-Message-State: APjAAAVs/zIE+CoE1PcNSTI+CYJz9RJCZDNghu/whpXeAN90Fr77DN1z
        f/+raE3LcuT5Lt1LUA1clNvDJL9QCqVDlg==
X-Google-Smtp-Source: APXvYqzWjGrtCnZ493pnT5MtkPv074A0nEYcFLTFgf/9DkbA6WOseK1zVOlUxJOJDyZDwxQ8ZnP01w==
X-Received: by 2002:a7b:c549:: with SMTP id j9mr823322wmk.114.1557928103209;
        Wed, 15 May 2019 06:48:23 -0700 (PDT)
Received: from localhost.localdomain (ip5f5aea35.dynamic.kabel-deutschland.de. [95.90.234.53])
        by smtp.gmail.com with ESMTPSA id v5sm4498506wra.83.2019.05.15.06.48.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 06:48:22 -0700 (PDT)
From:   Krzesimir Nowak <krzesimir@kinvolk.io>
To:     bpf@vger.kernel.org
Cc:     iago@kinvolk.io, alban@kinvolk.io,
        Krzesimir Nowak <krzesimir@kinvolk.io>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrey Ignatov <rdna@fb.com>,
        Jiong Wang <jiong.wang@netronome.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf v1 1/3] selftests/bpf: Test correctness of narrow 32bit read on 64bit field
Date:   Wed, 15 May 2019 15:47:26 +0200
Message-Id: <20190515134731.12611-2-krzesimir@kinvolk.io>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190515134731.12611-1-krzesimir@kinvolk.io>
References: <20190515134731.12611-1-krzesimir@kinvolk.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Test the correctness of the 32bit narrow reads by reading both halves
of the 64 bit field and doing a binary or on them to see if we get the
original value.

This isn't really tested - the program is not being run, because
BPF_PROG_TYPE_PERF_EVENT is not supported by bpf_test_run_prog.

Signed-off-by: Krzesimir Nowak <krzesimir@kinvolk.io>
---
 tools/testing/selftests/bpf/verifier/var_off.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/testing/selftests/bpf/verifier/var_off.c b/tools/testing/selftests/bpf/verifier/var_off.c
index 8504ac937809..2668819dcc85 100644
--- a/tools/testing/selftests/bpf/verifier/var_off.c
+++ b/tools/testing/selftests/bpf/verifier/var_off.c
@@ -246,3 +246,18 @@
 	.result = ACCEPT,
 	.prog_type = BPF_PROG_TYPE_LWT_IN,
 },
+{
+	"32bit loads of a 64bit field (both least and most significant words)",
+	.insns = {
+	BPF_LDX_MEM(BPF_W, BPF_REG_4, BPF_REG_1, offsetof(struct bpf_perf_event_data, sample_period)),
+	BPF_LDX_MEM(BPF_W, BPF_REG_5, BPF_REG_1, offsetof(struct bpf_perf_event_data, sample_period) + 4),
+	BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, offsetof(struct bpf_perf_event_data, sample_period)),
+	BPF_ALU64_IMM(BPF_LSH, BPF_REG_4, 32),
+	BPF_ALU64_REG(BPF_OR, BPF_REG_4, BPF_REG_5),
+	BPF_ALU64_REG(BPF_XOR, BPF_REG_4, BPF_REG_6),
+	BPF_MOV64_REG(BPF_REG_0, BPF_REG_4),
+	BPF_EXIT_INSN(),
+	},
+	.result = ACCEPT,
+	.prog_type = BPF_PROG_TYPE_PERF_EVENT,
+},
-- 
2.20.1

