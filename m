Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40EC68731F
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 02:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjBBBmY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 20:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjBBBmX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 20:42:23 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBD877526
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 17:42:22 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id j5so498699pjn.5
        for <bpf@vger.kernel.org>; Wed, 01 Feb 2023 17:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HRKKHzUPeYRgy9sp4sc6HU9jmgQ/kndp4UTR0lBuLfE=;
        b=XgJCNvo3Mxgtg5Cm1ISnzALszmieUGA5g+mJmIl1lai7/r9rTtYkS3lVzxT8o3lN9P
         M07KKCtnz0xTxGyblruhALIg8QtCdiv0QIEPRfGk63fKr+7soH35NVOt9nlCiG6uZMI1
         6C8k8MP6uMuCdf3W9QcjepEoOVtGmdI8Wp/s/Q9Z2mWDgX2AAC4YUXmgK4/NU1E5OFtY
         bm1PQVqxf9D4x3Wiski2pMGKHx1GH+/fEne7NjldfB6ly5ft+PiCb2uiJJ1G/VxOcJee
         wrj6uM4nSHqYrDuB9s+QK7xx9U+P75pCWOuCwgfEHRqrLxuxOo0FpP9kShHIcslp/3gK
         +WAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HRKKHzUPeYRgy9sp4sc6HU9jmgQ/kndp4UTR0lBuLfE=;
        b=tTThvvRnUmThnjpirb1CHPvpxPMb/BbqckNBqpuztUoSY7M0aDj5nioriqP/eFn9Yw
         FLEcLTRXUgEIE6AwZ0us+7nOnnNll3s+TZJ9RAFYOjidT3h1V89VIsoZvvyV2SkpCYNj
         mGLTN22Z//do+3YC/Oq/Wdp1keOVTL1U/WwI7UOBMyHaRClXg4XnmQwAyzwbxM4kYeJ3
         2wMBtL3Ym+P6UdmKkYCwjj8aiRQQ7DBByaWipo5hY1pBge0puijVDjTk7KGbxX7ZfHdI
         ROTWDS/CNZfyEqWydxIMHqhvdPn/9sda1EpFEdmfA7yxqyG4+YYJcVJWPceBFXnl/gDF
         2vYQ==
X-Gm-Message-State: AO0yUKVOVrxv4TU6Jn1RsxQ3DC59DixmgHp1bRopPWZXuP7DkNxlMhFO
        MMt/o52FSkFgve+/37Ye6Ag=
X-Google-Smtp-Source: AK7set9GF2+wbpIKssdijZ0MvTlGQkES0Y8qB6dhHwsPA23hO7kBC462w0w9sb2JVm95BPkSBvmTuQ==
X-Received: by 2002:a17:90a:1997:b0:230:3af9:177 with SMTP id 23-20020a17090a199700b002303af90177mr693628pji.8.1675302142358;
        Wed, 01 Feb 2023 17:42:22 -0800 (PST)
Received: from vultr.guest ([2001:19f0:7001:3f48:5400:4ff:fe4a:8c8b])
        by smtp.gmail.com with ESMTPSA id t191-20020a6381c8000000b004e8f7f23c4bsm6594205pgd.76.2023.02.01.17.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 17:42:22 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org,
        dennis@kernel.org, cl@linux.com, akpm@linux-foundation.org,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, vbabka@suse.cz,
        urezki@gmail.com
Cc:     linux-mm@kvack.org, bpf@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 2/7] mm: percpu: introduce percpu_size()
Date:   Thu,  2 Feb 2023 01:41:53 +0000
Message-Id: <20230202014158.19616-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230202014158.19616-1-laoar.shao@gmail.com>
References: <20230202014158.19616-1-laoar.shao@gmail.com>
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
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
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

