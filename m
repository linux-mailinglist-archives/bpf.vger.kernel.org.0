Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E574E062F
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2019 16:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729425AbfJVOSk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Oct 2019 10:18:40 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39261 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfJVOSk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Oct 2019 10:18:40 -0400
Received: by mail-wr1-f67.google.com with SMTP id a11so2201474wra.6
        for <bpf@vger.kernel.org>; Tue, 22 Oct 2019 07:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NtToSK8rJbeD7PBMEYCkRdUP5O0v+6Pk6qb5FPxPaHI=;
        b=fqT9mBFQ7+jTdNHtlR1Qw/BBvFcM3GuODdLq7FyGhBcksFS+dx4wN6OE4Agf/J5pjr
         Fqp4t0l1nA1ttnDxCXTJA04ZiKYTSZ511Y/EPDdJ1SKDk+DeL8zZCVl5se2HsOyZx3rp
         FIv0Drf//rLGRRN7NrKXb+hhW9J7rH+JkbKwc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NtToSK8rJbeD7PBMEYCkRdUP5O0v+6Pk6qb5FPxPaHI=;
        b=M+S2YMd00XJNW4/4JI2b5pyYY/qk1NMoxxtZ9EF1hThkQa3oNo3oJjXH/1CrFqNiAx
         2H5XRzgWGaR1AxI0ZqB6x+YnvhxuZSfPBAPmA4DRgv0pGLQMtD7Yk+EZi+0AeQtIPqFo
         w9ArKQFFAlywZpH57lcw6WpV2z8khadBeSkoC70bd3w2RMbSdk7Mbm55vJuiRpi7YnHq
         LYetHWxOEuq/JJOb3vC6tvWmL4dhaj/6Xc7lhgmlXpc8IG9aL1y69Nk4EeSMYw81P4FH
         QW2jo1cZp+KssJ9wlSyvqYq8kcSiZNX9Zj2BhH+AUq2WxnlUNKX4dT0XLFntPMba/lS5
         YKEQ==
X-Gm-Message-State: APjAAAXU2AnBUfeeq6N0NRMZgqs3dBiBwAXLTgnInO3qKHcMZaQd79me
        c+Dsema29/6E90Qf4MPRTCAOlQ==
X-Google-Smtp-Source: APXvYqwdty9Um7w4UJrNY05wfS63/GznTNrL1FldtQvvbiZP/oxW3Vf/cmZe+IB0wN0m4KhS6Xx6Dw==
X-Received: by 2002:adf:9486:: with SMTP id 6mr3604509wrr.28.1571753918818;
        Tue, 22 Oct 2019 07:18:38 -0700 (PDT)
Received: from kpsingh-kernel.localdomain ([2620:0:105f:fd00:7101:e21a:33a0:90d9])
        by smtp.gmail.com with ESMTPSA id l14sm2886585wrr.37.2019.10.22.07.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 07:18:37 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next] libbpf: Fix strncat bounds error in libbpf_prog_type_by_name
Date:   Tue, 22 Oct 2019 16:18:33 +0200
Message-Id: <20191022141833.5706-1-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: KP Singh <kpsingh@google.com>

On compiling samples with this change, one gets an error:

 error: ‘strncat’ specified bound 118 equals destination size
  [-Werror=stringop-truncation]

    strncat(dst, name + section_names[i].len,
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     sizeof(raw_tp_btf_name) - (dst - raw_tp_btf_name));
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

strncat requires the destination to have enough space for the
terminating null byte.

Fixes: f75a697e09137 ("libbpf: Auto-detect btf_id of BTF-based raw_tracepoint")
Signed-off-by: KP Singh <kpsingh@google.com>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 9364e66d755d..5fff3f15d705 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -4666,7 +4666,7 @@ int libbpf_prog_type_by_name(const char *name, enum bpf_prog_type *prog_type,
 			}
 			/* prepend "btf_trace_" prefix per kernel convention */
 			strncat(dst, name + section_names[i].len,
-				sizeof(raw_tp_btf_name) - (dst - raw_tp_btf_name));
+				sizeof(raw_tp_btf_name) - (dst - raw_tp_btf_name + 1));
 			ret = btf__find_by_name(btf, raw_tp_btf_name);
 			btf__free(btf);
 			if (ret <= 0) {
-- 
2.20.1

