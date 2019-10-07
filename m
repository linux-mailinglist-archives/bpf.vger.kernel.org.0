Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30CECCEA75
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2019 19:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbfJGRUn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Oct 2019 13:20:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49284 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728897AbfJGRUm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Oct 2019 13:20:42 -0400
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2D12FC08C320
        for <bpf@vger.kernel.org>; Mon,  7 Oct 2019 17:20:42 +0000 (UTC)
Received: by mail-lj1-f199.google.com with SMTP id j10so3709676lja.21
        for <bpf@vger.kernel.org>; Mon, 07 Oct 2019 10:20:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=WmLV2gFYsf8IxZJGPNJMAzm3JcKmbZ5Ig72cy5rVt5w=;
        b=bL65fZRh0uCI/pBbI0hX/YGUgVN8NagSJpKvygduK99TJsn63psqqXmKfPZSTc5FPq
         LhSPVd8vLmng3/sEuZU287pw8mzKNlQJknMSPnDARgMNlvnFKZo8wDNqLVddDRakmYLy
         zJEDlK+UX4cPUdDDLmVFlJ8CBz0vRv6Oqe/xRiO9BfXKWM2nJeI2kdKHr8gvQttKaswI
         ceDAQgt29gW7OmsLK1kCa1guY6mKdMCl+9cB2HAa/6nBIpg83m4xRV66usHyFFwFZfTK
         dpnNSKuFIqi1wVZQrqsBPKpJVvXKw8eMiRWrnweXFTdxfzRjhV9X7huV7RwZ8ZrcJ7tm
         iGMA==
X-Gm-Message-State: APjAAAXYKLHS4k5IqvO/5ECil0lo9yZENMIvGcgwPdt/XRoai4rJK7rJ
        IWqLDil4RgEtYNa2/0IealbwELtNHgj8mn+fIrC3TlWPbmO0JbETo/E0ZSnUUsF5G2N5RbyDqtA
        yPlcjzXpaYWYX
X-Received: by 2002:ac2:5586:: with SMTP id v6mr17178761lfg.180.1570468840440;
        Mon, 07 Oct 2019 10:20:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw0nUrGWGR43gYif8JagE5Xd0KXKJ/h62uK47CQTRsq5Q9C1Zge1RFCjXSMZ7xhgl4s8LN5Rg==
X-Received: by 2002:ac2:5586:: with SMTP id v6mr17178745lfg.180.1570468840264;
        Mon, 07 Oct 2019 10:20:40 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (borgediget.toke.dk. [85.204.121.218])
        by smtp.gmail.com with ESMTPSA id h3sm3342879ljf.12.2019.10.07.10.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 10:20:39 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 62F94180640; Mon,  7 Oct 2019 19:20:38 +0200 (CEST)
Subject: [PATCH bpf-next v3 3/5] tools: Update bpf.h header for program chain
 calls
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Marek Majkowski <marek@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Mon, 07 Oct 2019 19:20:38 +0200
Message-ID: <157046883832.2092443.8264002991767644164.stgit@alrua-x1>
In-Reply-To: <157046883502.2092443.146052429591277809.stgit@alrua-x1>
References: <157046883502.2092443.146052429591277809.stgit@alrua-x1>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

This updates the bpf.h UAPI header in tools/ to add the bpf chain
call-related definitions.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/include/uapi/linux/bpf.h |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 77c6be96d676..b03c23963af8 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -107,6 +107,9 @@ enum bpf_cmd {
 	BPF_MAP_LOOKUP_AND_DELETE_ELEM,
 	BPF_MAP_FREEZE,
 	BPF_BTF_GET_NEXT_ID,
+	BPF_PROG_CHAIN_ADD,
+	BPF_PROG_CHAIN_DEL,
+	BPF_PROG_CHAIN_GET,
 };
 
 enum bpf_map_type {
@@ -288,6 +291,12 @@ enum bpf_attach_type {
 /* The verifier internal test flag. Behavior is undefined */
 #define BPF_F_TEST_STATE_FREQ	(1U << 3)
 
+/* Whether to enable chain call logic at program execution. If set, the program
+ * execution logic will check for and jump to chain call programs configured
+ * with the BPF_PROG_CHAIN_* commands to the bpf syscall.
+ */
+#define BPF_F_CHAIN_CALLS	(1U << 4)
+
 /* When BPF ldimm64's insn[0].src_reg != 0 then this can have
  * two extensions:
  *
@@ -510,6 +519,13 @@ union bpf_attr {
 		__u64		probe_offset;	/* output: probe_offset */
 		__u64		probe_addr;	/* output: probe_addr */
 	} task_fd_query;
+
+	struct { /* anonymous struct used by BPF_PROG_CHAIN_* commands */
+		__u32		prev_prog_fd;
+		__u32		next_prog_fd;
+		__u32		retcode;
+		__u32		next_prog_id;   /* output: prog_id */
+	};
 } __attribute__((aligned(8)));
 
 /* The description below is an attempt at providing documentation to eBPF

