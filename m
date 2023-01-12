Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47AC667A2B
	for <lists+bpf@lfdr.de>; Thu, 12 Jan 2023 17:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbjALQBL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Jan 2023 11:01:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234146AbjALQAn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Jan 2023 11:00:43 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E5A625C
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 07:53:36 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id z12so16745106qtv.5
        for <bpf@vger.kernel.org>; Thu, 12 Jan 2023 07:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0GttG9cGo2fGw7Ie6+QYs6E6KpCITpSOtaS4vLsszc8=;
        b=Cs86hcYwXW1kyT1Ar3qnL76ZCbnEz0PuLFPljmDEP02SjXoY1Z3RjcF2o1cZcrfit5
         QsRJZD+pHkF5Lp65YJU8iZVYq4d7OoijI3kadHA/0fI4edzur6B4RGyBR3E4vF662I/j
         wNEecnuesci1bDHq9WwQtoP5yUf7oWgsfjkZY6J0nUR1rgflYRRAS4sWd2NT04xkGNd1
         biHCt1RQu1AIGF++m/rRURQXtxdvBzCNjbZDBLpYJd7CRbWoeaX/X1UlYq/ECAWaQ3II
         //PX23Rf28b9O8k3iB6GI8CVbc4v8x/BmlLTWUreFOpaZbasteZ4LBpLbnySid+akRmc
         d17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0GttG9cGo2fGw7Ie6+QYs6E6KpCITpSOtaS4vLsszc8=;
        b=uji2i+H0XuWauqeu8gnwFLHfy0MrUUV+hoZm6VP8BJ5mgJNhGgI7bE2/YzwqRxwCQe
         VPZ02dyom8jH7iWMJ0KDKKW5TNWs+6GmJc/sNoHcVLF+WyaSqcGBNuVf823qyB2W8iry
         2HT05CSQdoXlbBXSUeFbh28pTMCMMArKVuIKyWEc2CD1gbZrjY6S9eII36B/4wJjC+bG
         TkUu0EC3VNtT5x5ebf9+hgIFLpTV2kXWDGA04dUcOSijtr+ZVCjwegb4k3JfKaOdRmi9
         tYsr76FN1FaPrTDd2yEytI4k6bEJ3tG5WEcjHP5sy7rpyxMWXHCeimFR0GMcjKuyiNBz
         xmVg==
X-Gm-Message-State: AFqh2kr1sLHe39hNFw2p9/AczT85QPPKqdG3RQiU8NFcbcQJrBQ1cErh
        240ah/ClId2CN/gHdHFghOg=
X-Google-Smtp-Source: AMrXdXujjvIkIMxOnezoY+bqzXiyRl7Otg+3lH6xNrFMGBGSGIg4NYiYb1pdv7pwlHe5tHHIls2pwQ==
X-Received: by 2002:ac8:7409:0:b0:3b1:691f:3d7a with SMTP id p9-20020ac87409000000b003b1691f3d7amr5867423qtq.68.1673538815891;
        Thu, 12 Jan 2023 07:53:35 -0800 (PST)
Received: from vultr.guest ([173.199.122.241])
        by smtp.gmail.com with ESMTPSA id l17-20020ac848d1000000b003ab43dabfb1sm9280836qtr.55.2023.01.12.07.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 07:53:35 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     42.hyeyoo@gmail.com, vbabka@suse.cz, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, tj@kernel.org, dennis@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, roman.gushchin@linux.dev
Cc:     linux-mm@kvack.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next v2 02/11] mm: percpu: introduce percpu_size()
Date:   Thu, 12 Jan 2023 15:53:17 +0000
Message-Id: <20230112155326.26902-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230112155326.26902-1-laoar.shao@gmail.com>
References: <20230112155326.26902-1-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Introduce a new helper percpu_size() to report full size of underlying
allocation of a percpu address.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/percpu.h |  1 +
 mm/percpu.c            | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/linux/percpu.h b/include/linux/percpu.h
index 1338ea2..7be4234 100644
--- a/include/linux/percpu.h
+++ b/include/linux/percpu.h
@@ -137,5 +137,6 @@ extern int __init pcpu_page_first_chunk(size_t reserved_size,
 						__alignof__(type))
 
 extern unsigned long pcpu_nr_pages(void);
+extern size_t percpu_size(void __percpu *ptr);
 
 #endif /* __LINUX_PERCPU_H */
diff --git a/mm/percpu.c b/mm/percpu.c
index acd78da..5580688 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -2302,6 +2302,41 @@ void free_percpu(void __percpu *ptr)
 }
 EXPORT_SYMBOL_GPL(free_percpu);
 
+/**
+ * percpu_size - report full size of underlying allocation of percpu addr
+ * @ptr: pointer to percpu area
+ *
+ * CONTEXT:
+ * Can be called from atomic context.
+ */
+size_t percpu_size(void __percpu *ptr)
+{
+	int bit_off, bits, end, off, size;
+	struct pcpu_chunk *chunk;
+	unsigned long flags;
+	void *addr;
+
+	if (!ptr)
+		return 0;
+
+	addr = __pcpu_ptr_to_addr(ptr);
+
+	spin_lock_irqsave(&pcpu_lock, flags);
+	chunk = pcpu_chunk_addr_search(addr);
+	off = addr - chunk->base_addr;
+	bit_off = off / PCPU_MIN_ALLOC_SIZE;
+
+	/* find end index */
+	end = find_next_bit(chunk->bound_map, pcpu_chunk_map_bits(chunk),
+			    bit_off + 1);
+	spin_unlock_irqrestore(&pcpu_lock, flags);
+
+	bits = end - bit_off;
+	size = bits * PCPU_MIN_ALLOC_SIZE;
+
+	return pcpu_obj_full_size(size);
+}
+
 bool __is_kernel_percpu_address(unsigned long addr, unsigned long *can_addr)
 {
 #ifdef CONFIG_SMP
-- 
1.8.3.1

