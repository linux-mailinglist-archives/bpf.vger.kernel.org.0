Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76FAB87F0F
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2019 18:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437079AbfHIQKt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Aug 2019 12:10:49 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:45500 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437054AbfHIQKt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Aug 2019 12:10:49 -0400
Received: by mail-pg1-f202.google.com with SMTP id 28so9500809pgm.12
        for <bpf@vger.kernel.org>; Fri, 09 Aug 2019 09:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zozR5939lKPKijWCEA8Kq+6lgaUz4pI7IwG97p6anoI=;
        b=uDd+3pS3kdOwCNXjCzjVY7gjWOgZu4xS+1w3J1HbUrh288Gou6qSIPKAEEC8hbTGWu
         gNDvtxLJ4d58G0fd8ok/tuYSvirYjXJ8kfgoynABAad02dAuZ5sd2YVZlvi4GwzTxGFf
         tkAMVCw1NDgosiDJO0si20tx8W0yK3rTpx4wEOzd2xkNOH4FZ9vT7ezcK8M9rBmnvu3Z
         hFVxzq9Op2W9CKKyd6T1IiPOfwgeOQ+4PtZ+mZ/JccWt63n67xLly4k3TEuoGDCvzp8O
         xjlgWuVi0rg2lVEH5nNYMOjJ/m8WrlBrRNne3yzpc1EizYVeh7MW6ObW1vgvwcImzRYD
         2iFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zozR5939lKPKijWCEA8Kq+6lgaUz4pI7IwG97p6anoI=;
        b=NLf7sD+ai7Sh8crQRIWAb35QM2vVhFKN6UHkMeppyZ1OqObp52ganCb//f8dME/YH6
         CTF7Bcp7b0mxIsYgqkgcV9RJB43RVeK5nfkALOrAPkMVXXA5tjAe89h51vLhKjaIJTXh
         FmVVyosfsWgSYjMYoh7KAKJWzyrPJeDEWXUDbsfafZi9FLoYDgsahRbn/i0x4w8qsLFZ
         s9qOJqSqQkrvkVY9IOzXS208q7oOq5ujZP5Fddjzkxf45ArySQUQPuYc2rM2EX9/gxB1
         sal9M0xThRWNFESRCPT7P0/+jf4K4QhmUQUPSQ1CGxSFW6qWZmfdysztUlOcJSGYOkS5
         oOvw==
X-Gm-Message-State: APjAAAU/hfiz5amY+iJ0RQnlpRTKSgoX49GNDQd4/3Da0zbLrWtbBxO9
        OCVAVdkVdZdNETN5xfGyUjoOyhc=
X-Google-Smtp-Source: APXvYqzG/D6qCm8/9ijnTCNRrJdNiqTvmg+mzM6tGiT0QbTrJaGHQMQo6O3oYj1P1acud/IKZu8udpo=
X-Received: by 2002:a63:3c5:: with SMTP id 188mr17701789pgd.394.1565367048184;
 Fri, 09 Aug 2019 09:10:48 -0700 (PDT)
Date:   Fri,  9 Aug 2019 09:10:37 -0700
In-Reply-To: <20190809161038.186678-1-sdf@google.com>
Message-Id: <20190809161038.186678-4-sdf@google.com>
Mime-Version: 1.0
References: <20190809161038.186678-1-sdf@google.com>
X-Mailer: git-send-email 2.23.0.rc1.153.gdeed80330f-goog
Subject: [PATCH bpf-next v2 3/4] bpf: sync bpf.h to tools/
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sync new sk storage clone flag.

Cc: Martin KaFai Lau <kafai@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Acked-by: Yonghong Song <yhs@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/include/uapi/linux/bpf.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 4393bd4b2419..0ef594ac3899 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -337,6 +337,9 @@ enum bpf_attach_type {
 #define BPF_F_RDONLY_PROG	(1U << 7)
 #define BPF_F_WRONLY_PROG	(1U << 8)
 
+/* Clone map from listener for newly accepted socket */
+#define BPF_F_CLONE		(1U << 9)
+
 /* flags for BPF_PROG_QUERY */
 #define BPF_F_QUERY_EFFECTIVE	(1U << 0)
 
-- 
2.23.0.rc1.153.gdeed80330f-goog

