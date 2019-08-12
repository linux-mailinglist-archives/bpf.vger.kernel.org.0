Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 800708A9B7
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2019 23:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfHLVvX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Aug 2019 17:51:23 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:36781 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbfHLVvX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Aug 2019 17:51:23 -0400
Received: by mail-pg1-f201.google.com with SMTP id y7so16282113pgq.3
        for <bpf@vger.kernel.org>; Mon, 12 Aug 2019 14:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=VzbGHvSiySq50YMMXV5wIRss5YK1rFgm4/UGnmN70Bc=;
        b=fAfaiSlH3IJrNJyZYLgYtoIVY8VZlqGfi5Z1XEd34Hclac8Tlt1XU022vSoo6lpHqW
         WT5ZYdOnF51c3AJ+HgQLgSxq1DFgNbpPZFxvoOpgOi8CLocNEf/zT6VX0F2CI56S+DGU
         emR9pGJLtKNGCGQGSx/vmN9VKkZcYZVXI6eXGk1DQEFDNeHCD/bdYD6Zet1y/2Gzi9uE
         yf/jN+kbTfyFtb4u9PsKcmr7JPvUHlj3Oa0vtajMh2hl9bXBiepZSxxAR7vIHlyXgTiy
         3qSQ1ycRcwY27pQbPVEKnAVbB3qlQm8NnHi8Ju6BN+Yoi5wFlqrTPtF5AwdB6r/eozZn
         AJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=VzbGHvSiySq50YMMXV5wIRss5YK1rFgm4/UGnmN70Bc=;
        b=J3m2NPLs+LbAIg1odBBfxQZv6lOWk3/jSbeOOfhFzRpzwuAWy5bv6W1skGb6EPiCdi
         0/y6IKmLwHs92JiiRLN+qpHEaGSIN2+aTMWXZjnXp0N8RXluhTxA5Kkst7brZvjVMvjw
         8M/ARye6JkfyOSNeuJqOi3W39KCny3pB7LRA3YDVb9vsZwjR5n9Edvtkd2ejfGf8fJMX
         94JX3p39z4hyKvgD0ByK01yjAwHJUAVmjNwmXAICsyRjReb8ZHoq9wTbXMOQGa6MdaQR
         rPAA/mAAqDzHlcVX54fhhF3BAMPKX97YwLV8dTgFb2qdvj5QCp9reZxzsYqdZXnyK6Ns
         VC1w==
X-Gm-Message-State: APjAAAUBjwDiPAG4ikfxXQze/5t+wI4AhIIuYj/Q4MqN/ONHAQDV7eiO
        7Gs1j/JbCSDgq6EbE4h7dXqdOR4k/r5migEtjyE=
X-Google-Smtp-Source: APXvYqxzQCyThBwBKrfD6856yni3bdzA7zdg2TImP8qBYmAZ8RHmc6ZzA/B5OR4SphKOBUyy2O28WZ+h0SMYwe93/kc=
X-Received: by 2002:a63:2685:: with SMTP id m127mr31628780pgm.6.1565646682512;
 Mon, 12 Aug 2019 14:51:22 -0700 (PDT)
Date:   Mon, 12 Aug 2019 14:50:34 -0700
Message-Id: <20190812215052.71840-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH 01/16] s390/boot: fix section name escaping
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     akpm@linux-foundation.org
Cc:     sedat.dilek@gmail.com, jpoimboe@redhat.com, yhs@fb.com,
        miguel.ojeda.sandonis@gmail.com,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Philipp Rudo <prudo@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

GCC unescapes escaped string section names while Clang does not. Because
__section uses the `#` stringification operator for the section name, it
doesn't need to be escaped.

This antipattern was found with:
$ grep -e __section\(\" -e __section__\(\" -r

Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/s390/boot/startup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/boot/startup.c b/arch/s390/boot/startup.c
index 7b0d05414618..26493c4ff04b 100644
--- a/arch/s390/boot/startup.c
+++ b/arch/s390/boot/startup.c
@@ -46,7 +46,7 @@ struct diag_ops __bootdata_preserved(diag_dma_ops) = {
 	.diag0c = _diag0c_dma,
 	.diag308_reset = _diag308_reset_dma
 };
-static struct diag210 _diag210_tmp_dma __section(".dma.data");
+static struct diag210 _diag210_tmp_dma __section(.dma.data);
 struct diag210 *__bootdata_preserved(__diag210_tmp_dma) = &_diag210_tmp_dma;
 void _swsusp_reset_dma(void);
 unsigned long __bootdata_preserved(__swsusp_reset_dma) = __pa(_swsusp_reset_dma);
-- 
2.23.0.rc1.153.gdeed80330f-goog

