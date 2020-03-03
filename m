Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E609176979
	for <lists+bpf@lfdr.de>; Tue,  3 Mar 2020 01:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgCCAut (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 Mar 2020 19:50:49 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39459 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbgCCAut (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 Mar 2020 19:50:49 -0500
Received: by mail-pg1-f194.google.com with SMTP id s2so667376pgv.6
        for <bpf@vger.kernel.org>; Mon, 02 Mar 2020 16:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.washington.edu; s=goo201206;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3qpNU4bvUiCHpvV7L6ZFkbr2aibmMm2XkgbkHKRq+RA=;
        b=i097SGazMzapQTbCmTCM1ihtZ7VsNJyWAVTlS8VzybpMHYpv79RVK82V42IbyWrCUQ
         /tWCyPUdhgc0fc4N6KisDXZdp4zqC1yrrqNBihRtGLThZoy2n9BA0gQ6HgaSxGxwYFCT
         LSnKaekYmM6v7TZ8b+zNPpzMrf7wVn5V8ZWmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3qpNU4bvUiCHpvV7L6ZFkbr2aibmMm2XkgbkHKRq+RA=;
        b=XYiNZ72kqeKroS0PXu55J4OLyD/dvCcZZQ0o5p5NFGlOes4SHzHXDzezjTBxodcFtN
         QL6IM7MLh6Uk0i23khYbUbdphhMAYj8KCSPrVE9Tt0fpvMlF4sjMucDXIpQ23G/PDVql
         2LQLYFMIK/PmAZtNe4q9+Jo2O1RCJULxS9DQOCK3Hal6PSEV801YqpEqTDnWsxcKMGKV
         2Mmg5JaKXfOrTs2NTs84MNveokeBfg9jN7w2GvQmqM28ZQdYBQ4avITLlmj8sP994iBz
         guY1UpIHmreqYuA955+Yh/MHJK+Sivb/Yq1jQSBG1/R0BtpWvoAHBrRto9eagQ3i0y8I
         BCdg==
X-Gm-Message-State: ANhLgQ1+WSS4R7N8R9qndUB/FosgT+i+cpXTJWvLrd/aWPXy8Tzb7Bnq
        Kd0kSq05q56YK3MT38IVr3PitQ0/56i03w==
X-Google-Smtp-Source: ADFU+vsXNe4K0+HOCq044vz+4uavRlyW2t0lhW22ri/T6Yt6Dpe1MJwDY4NJT+/vEPOYLh45lbXXsQ==
X-Received: by 2002:a63:c507:: with SMTP id f7mr1508127pgd.278.1583196648102;
        Mon, 02 Mar 2020 16:50:48 -0800 (PST)
Received: from ryzen.cs.washington.edu ([2607:4000:200:11:b5cd:49c6:f4f6:8295])
        by smtp.gmail.com with ESMTPSA id c15sm357529pja.30.2020.03.02.16.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 16:50:47 -0800 (PST)
From:   Luke Nelson <lukenels@cs.washington.edu>
X-Google-Original-From: Luke Nelson <luke.r.nels@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Luke Nelson <luke.r.nels@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>,
        Xi Wang <xi.wang@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH bpf-next v4 4/4] MAINTAINERS: Add entry for RV32G BPF JIT
Date:   Mon,  2 Mar 2020 16:50:35 -0800
Message-Id: <20200303005035.13814-5-luke.r.nels@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303005035.13814-1-luke.r.nels@gmail.com>
References: <20200303005035.13814-1-luke.r.nels@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Cc: Björn Töpel <bjorn.topel@gmail.com>
Signed-off-by: Xi Wang <xi.wang@gmail.com>
Signed-off-by: Luke Nelson <luke.r.nels@gmail.com>
---
 MAINTAINERS | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8f27f40d22bb..fdd8b99f18db 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3213,11 +3213,20 @@ L:	bpf@vger.kernel.org
 S:	Maintained
 F:	arch/powerpc/net/
 
-BPF JIT for RISC-V (RV64G)
+BPF JIT for 32-bit RISC-V (RV32G)
+M:	Luke Nelson <luke.r.nels@gmail.com>
+M:	Xi Wang <xi.wang@gmail.com>
+L:	bpf@vger.kernel.org
+S:	Maintained
+F:	arch/riscv/net/
+X:	arch/riscv/net/bpf_jit_comp.c
+
+BPF JIT for 64-bit RISC-V (RV64G)
 M:	Björn Töpel <bjorn.topel@gmail.com>
-L:	netdev@vger.kernel.org
+L:	bpf@vger.kernel.org
 S:	Maintained
 F:	arch/riscv/net/
+X:	arch/riscv/net/bpf_jit_comp32.c
 
 BPF JIT for S390
 M:	Ilya Leoshkevich <iii@linux.ibm.com>
-- 
2.20.1

