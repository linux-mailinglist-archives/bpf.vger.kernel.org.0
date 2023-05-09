Return-Path: <bpf+bounces-251-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA986FCA00
	for <lists+bpf@lfdr.de>; Tue,  9 May 2023 17:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 144201C20BBC
	for <lists+bpf@lfdr.de>; Tue,  9 May 2023 15:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8291800A;
	Tue,  9 May 2023 15:15:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1AF8BE2
	for <bpf@vger.kernel.org>; Tue,  9 May 2023 15:15:27 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FEB468C
	for <bpf@vger.kernel.org>; Tue,  9 May 2023 08:15:23 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64115e652eeso43341553b3a.0
        for <bpf@vger.kernel.org>; Tue, 09 May 2023 08:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683645323; x=1686237323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4qZUlY5CsYKT92Eew2Epw0Xry6nY6IQRdMJKEmH+Oo=;
        b=Pl8RUMaRC5dUmf6hxUbl+CqO8mvYpU6IJ4ltRAd5dQHvZzGGtgs9EIhdkSRDWSakv8
         iThPHznQlCJozhm3k87UXCaeYCFORRHEA8oJbKP+IIaH1A4FQ/bumxg5qf4gXPeOp8ii
         G6p0kWJjHyjBmCsu+mo4XsgU5Rumc0VZI4oX8n2b61xkEskD10Xj3fKGVFDdRbEoO+HQ
         Ds/1cqkghScjEl++PtJfrMCcgCYW1hgT7c52k7wSXyxfERt9zFrteS9wBctaI0sjvmDl
         JdVALmlUV9rCyd1pVHG458UU8X32VU13udxNvvvbiRAfJT1neog91o7ms66AgGS7O03I
         /odA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683645323; x=1686237323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4qZUlY5CsYKT92Eew2Epw0Xry6nY6IQRdMJKEmH+Oo=;
        b=GXpnR8RsuCnB8ANq+JSQwmlctsft3xXKolx3S/XAtUUpkLBpDoUfo5rtpbTRLONYXm
         WxOl4AwYF4Y/C3A4cduryb06wk/0rZnR2ya9zMA4fXL+2anc0xv1QhAK271LCIafRo4v
         6y4Dw0rjX31Db4Nb0hA4/E8SG0ETJzQNvKQn+VpRXJZlODDKeVqpH3CwwatobnTsFPw6
         MdLkosUSNjkAOdNEXF0egyFDgP7W+AeMOCYVbWI90ZEnz1tvLcqLvkAq7GIZLb2Ni8Ss
         txDnFWWAVvdHkhjmpmo8Rcm7n/DNMo46Gvvp5MZZXSRs6f9mkxPXUTN2PQ83e4IKmApK
         au/Q==
X-Gm-Message-State: AC+VfDzKXyWt5Ih/ymkDyGUjdr09oKAEjrysFlODIRSAd1aHSRbJAm17
	979I662sMglq2E3wAe34UY4=
X-Google-Smtp-Source: ACHHUZ4hj6XQqff0qDQe/Z5MBU15GtXPTuUaBhcKgEvi43Gwb+ox4Uu6qOcCy84P2dR11aAfzijVXQ==
X-Received: by 2002:a17:903:22c6:b0:1ac:939b:abdb with SMTP id y6-20020a17090322c600b001ac939babdbmr3352980plg.29.1683645323122;
        Tue, 09 May 2023 08:15:23 -0700 (PDT)
Received: from vultr.guest ([149.28.193.116])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902ee4c00b001aafc8cea5fsm1706349plo.148.2023.05.09.08.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 08:15:22 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kafai@fb.com,
	songliubraving@fb.com,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 1/2] bpf: Fix memleak due to fentry attach failure
Date: Tue,  9 May 2023 15:15:10 +0000
Message-Id: <20230509151511.3937-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230509151511.3937-1-laoar.shao@gmail.com>
References: <20230509151511.3937-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

If it fails to attach fentry, the allocated bpf trampoline image will be
left in the system. That can be verified by checking /proc/kallsyms.

This meamleak can be verified by a simple bpf program as follows,

  SEC("fentry/trap_init")
  int fentry_run()
  {
      return 0;
  }

It will fail to attach trap_init because this function is freed after
kernel init, and then we can find the trampoline image is left in the
system by checking /proc/kallsyms.
  $ tail /proc/kallsyms
  ffffffffc0613000 t bpf_trampoline_6442453466_1  [bpf]
  ffffffffc06c3000 t bpf_trampoline_6442453466_1  [bpf]

  $ bpftool btf dump file /sys/kernel/btf/vmlinux | grep "FUNC 'trap_init'"
  [2522] FUNC 'trap_init' type_id=119 linkage=static

  $ echo $((6442453466 & 0x7fffffff))
  2522

Note that there are two left bpf trampoline images, that is because the
libbpf will fallback to raw tracepoint if -EINVAL is returned.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/trampoline.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index ac021bc..7067cdf 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -251,6 +251,15 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
 	return tlinks;
 }
 
+static void bpf_tramp_image_free(struct bpf_tramp_image *im)
+{
+	bpf_image_ksym_del(&im->ksym);
+	bpf_jit_free_exec(im->image);
+	bpf_jit_uncharge_modmem(PAGE_SIZE);
+	percpu_ref_exit(&im->pcref);
+	kfree(im);
+}
+
 static void __bpf_tramp_image_put_deferred(struct work_struct *work)
 {
 	struct bpf_tramp_image *im;
@@ -438,7 +447,7 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 					  &tr->func.model, tr->flags, tlinks,
 					  tr->func.addr);
 	if (err < 0)
-		goto out;
+		goto out_free;
 
 	set_memory_rox((long)im->image, 1);
 
@@ -468,7 +477,7 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 	}
 #endif
 	if (err)
-		goto out;
+		goto out_free;
 
 	if (tr->cur_image)
 		bpf_tramp_image_put(tr->cur_image);
@@ -480,6 +489,10 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 		tr->flags = orig_flags;
 	kfree(tlinks);
 	return err;
+
+out_free:
+	bpf_tramp_image_free(im);
+	goto out;
 }
 
 static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(struct bpf_prog *prog)
-- 
1.8.3.1


