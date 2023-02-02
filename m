Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86558687320
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 02:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjBBBm3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 20:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjBBBm2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 20:42:28 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F141477DD9
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 17:42:27 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id m2so390332plg.4
        for <bpf@vger.kernel.org>; Wed, 01 Feb 2023 17:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYjNCZTedk1AJoVE/LTBpwn60v8SrzPue4uHPDh5wcE=;
        b=iv03dHdBcW/AZOHUDlopVCkZMKFM5RQoGCY65iwL3v1XSSn6aFyN06IJDrI7/Y1dPh
         CaFdxSXVVjpIPBxknyOfU6wiAXoOpTQA7lbpm7JbzsU7X3rmtw9j/uDnDsZC8p37KAOl
         T/651l6xryaOqGzHBqD/t2tGccpWOjcNcUV+37GFHt59GhVhWtoCFFWYkEDTdq+EfD1B
         nVdqLRlenGwkWXLqu5fy40pZ2DGJG04NOPHli4XhXuvWujUoeJyQU9rSdmhiMvX2tS3i
         jVmpex4Sk2c0aoGC+RK06Pwp+M0a7xsu2yZ4brDKq+6NUq/LJ1nCbzhjhvPG43MnxO94
         5Pvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JYjNCZTedk1AJoVE/LTBpwn60v8SrzPue4uHPDh5wcE=;
        b=4ybO7OVjYH46apBFkoZCyzRbLU3agBVcxokNXGDSM8DY9B90AGhLTJCE3MVKP516Zj
         O33kG12ZTI8LQGGq55lqFXZ21l/1DY0oOEFF/7ezWsebwlBUnQvXLBzCZaAVintSQi5x
         0e2E2VvWKa/BllAK7DU8qL1PsY7ALJlMkBXRS+l/GwyW0vLd5HJlG7llza8hnLlSWV9K
         vLAYMfmXmijUaJmuVW7Ugq1rADqrfqwdA9CSBPIxad7dv00mdpZZDUuIImcdrdR4DkUg
         HlKn6ZDb0wDzwkjeTdGcgt/y4BIl1XAQvTzngCO6ICywdiFoU97b9RBoHKD9HyQril3T
         wiCg==
X-Gm-Message-State: AO0yUKUheWSMo69lqyLGB5NwlqDQTVCEIdRoIuzjoLAH15s9BJHJPb39
        /SMRISdygnG+Jml2lHahgS4=
X-Google-Smtp-Source: AK7set9JBuOshDn5GHDps2tnszs7MZJQNL/kb7SOm046DT8cAbZupwyNErHhHuomwxoErVIBH3XDkA==
X-Received: by 2002:a05:6a21:33aa:b0:bc:fe7e:cfd9 with SMTP id yy42-20020a056a2133aa00b000bcfe7ecfd9mr6068166pzb.18.1675302147552;
        Wed, 01 Feb 2023 17:42:27 -0800 (PST)
Received: from vultr.guest ([2001:19f0:7001:3f48:5400:4ff:fe4a:8c8b])
        by smtp.gmail.com with ESMTPSA id t191-20020a6381c8000000b004e8f7f23c4bsm6594205pgd.76.2023.02.01.17.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 17:42:27 -0800 (PST)
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
        Yafang Shao <laoar.shao@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH bpf-next 3/7] mm: vmalloc: introduce vsize()
Date:   Thu,  2 Feb 2023 01:41:54 +0000
Message-Id: <20230202014158.19616-4-laoar.shao@gmail.com>
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

Introduce a helper to report full size of underlying allocation of a
vmalloc'ed address.

Suggested-by: Uladzislau Rezki <urezki@gmail.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Uladzislau Rezki <urezki@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>
---
 include/linux/vmalloc.h |  1 +
 mm/vmalloc.c            | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 096d48a..7fbd390 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -297,4 +297,5 @@ struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 static inline bool vmalloc_dump_obj(void *object) { return false; }
 #endif
 
+size_t vsize(void *addr);
 #endif /* _LINUX_VMALLOC_H */
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index ca71de7..8499eba 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -4057,6 +4057,23 @@ bool vmalloc_dump_obj(void *object)
 }
 #endif
 
+/* Report full size of underlying allocation of a vmalloc'ed addr */
+size_t vsize(void *addr)
+{
+	struct vmap_area *va;
+	size_t va_size = 0;
+
+	if (!addr)
+		return 0;
+
+	spin_lock(&vmap_area_lock);
+	va = __find_vmap_area((unsigned long)addr, &vmap_area_root);
+	if (va && va->vm)
+		va_size = va->vm->size;
+	spin_unlock(&vmap_area_lock);
+	return va_size;
+}
+
 #ifdef CONFIG_PROC_FS
 static void *s_start(struct seq_file *m, loff_t *pos)
 	__acquires(&vmap_purge_lock)
-- 
1.8.3.1

