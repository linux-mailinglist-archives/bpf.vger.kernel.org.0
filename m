Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 230D78B571
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2019 12:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbfHMKX4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Aug 2019 06:23:56 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:40615 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728797AbfHMKXv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Aug 2019 06:23:51 -0400
Received: by mail-lf1-f47.google.com with SMTP id b17so76382549lff.7
        for <bpf@vger.kernel.org>; Tue, 13 Aug 2019 03:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mFrYdNufqJMBiXr6Fl+Xru3C6SYEreBVGiSnrc3weyc=;
        b=Y0RUcptj1nphOy9DUsYSiUGS5oC8t0JnfW7QiIiMtYxxcHAAIyv1N4Upb4ezqwLOrZ
         wuZg6ub802synfGnhYu7FTj6Q+z0l0UrajtxxBKWSW8G7D+qPTE7qJu0MjppbAHzzLYm
         0aOOHQIFsG4z6eviJ8yb8Cqdyw0y4/2IaU/kCNA0Qu0+tbdQv0fRSnCnCPEJJRJ6eat8
         WZgcxw37voDsQAoCE3tGerY8pE+0S3QnAax+CxfMuNScM6koos5vYuslETUmiTFak7pq
         p1gRy0yl2o4tUwFoqJ8fYbKrrGXdLOK5OILS8ajqrmb8qo+wJlZYxAc/vIIwa6vYzrYR
         bYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mFrYdNufqJMBiXr6Fl+Xru3C6SYEreBVGiSnrc3weyc=;
        b=Pibu9RFKyf24TxPU5HODyuumRAW7JrEGaExIavLD8tmr6uhSkx8fHsgO9GU8u/jmib
         +xUYbiOUJEfxD3Fg2sCyoyCpS98riX+pNGi/HPur1vpFkDQSbrNCELWyzfNpIhduNZsY
         xf8YoAKeJa6j1hPTtOsfarjcJAU96VN1wH3v4mYEcRjbxmICPz1e6zCHWU5Jji63aN8M
         tq0upd7U95SZOg3XeWUZnmr3o0VieoiJC5mSpvj5Fusw0LM5fvjHHrwa+m+ewkc7JaXd
         xodRjYpe4hFeCi3tjRmeqiaElW/Cnrw+JeD3nVIrNufSRI0F3GS4/Chdtt/zTBD4IOvt
         vnhQ==
X-Gm-Message-State: APjAAAVLK1p/PXs9vsWkIt7zRbOinIwwZ6pefGKDk6vORzClvffHgnnF
        DJ/8AAe8EiegklyYSGPbeHyX1g==
X-Google-Smtp-Source: APXvYqx5ubYdC+pwKtPbpWBtsKuHRSKAFyFuYvHkqHK34jLbYYqbtI1zkcH1ZbBt1JQOtwq91dYtuA==
X-Received: by 2002:a19:6041:: with SMTP id p1mr22325227lfk.6.1565691829914;
        Tue, 13 Aug 2019 03:23:49 -0700 (PDT)
Received: from localhost.localdomain (168-200-94-178.pool.ukrtel.net. [178.94.200.168])
        by smtp.gmail.com with ESMTPSA id e87sm24796942ljf.54.2019.08.13.03.23.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 03:23:49 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     magnus.karlsson@intel.com, bjorn.topel@intel.com
Cc:     davem@davemloft.net, hawk@kernel.org, john.fastabend@gmail.com,
        jakub.kicinski@netronome.com, daniel@iogearbox.net,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        xdp-newbies@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH bpf-next 3/3] samples: bpf: syscal_nrs: use mmap2 if defined
Date:   Tue, 13 Aug 2019 13:23:18 +0300
Message-Id: <20190813102318.5521-4-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190813102318.5521-1-ivan.khoronzhuk@linaro.org>
References: <20190813102318.5521-1-ivan.khoronzhuk@linaro.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

For arm32 xdp sockets mmap2 is preferred, so use it if it's defined.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/syscall_nrs.c  |  5 +++++
 samples/bpf/tracex5_kern.c | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/samples/bpf/syscall_nrs.c b/samples/bpf/syscall_nrs.c
index 516e255cbe8f..2dec94238350 100644
--- a/samples/bpf/syscall_nrs.c
+++ b/samples/bpf/syscall_nrs.c
@@ -9,5 +9,10 @@ void syscall_defines(void)
 	COMMENT("Linux system call numbers.");
 	SYSNR(__NR_write);
 	SYSNR(__NR_read);
+#ifdef __NR_mmap2
+	SYSNR(__NR_mmap2);
+#else
 	SYSNR(__NR_mmap);
+#endif
+
 }
diff --git a/samples/bpf/tracex5_kern.c b/samples/bpf/tracex5_kern.c
index f57f4e1ea1ec..300350ad299a 100644
--- a/samples/bpf/tracex5_kern.c
+++ b/samples/bpf/tracex5_kern.c
@@ -68,12 +68,23 @@ PROG(SYS__NR_read)(struct pt_regs *ctx)
 	return 0;
 }
 
+#ifdef __NR_mmap2
+PROG(SYS__NR_mmap2)(struct pt_regs *ctx)
+{
+	char fmt[] = "mmap2\n";
+
+	bpf_trace_printk(fmt, sizeof(fmt));
+	return 0;
+}
+#else
 PROG(SYS__NR_mmap)(struct pt_regs *ctx)
 {
 	char fmt[] = "mmap\n";
+
 	bpf_trace_printk(fmt, sizeof(fmt));
 	return 0;
 }
+#endif
 
 char _license[] SEC("license") = "GPL";
 u32 _version SEC("version") = LINUX_VERSION_CODE;
-- 
2.17.1

