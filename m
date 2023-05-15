Return-Path: <bpf+bounces-515-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B8A702DA0
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 15:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 187821C20A3D
	for <lists+bpf@lfdr.de>; Mon, 15 May 2023 13:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1E0C8F5;
	Mon, 15 May 2023 13:09:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9E7C8EC
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 13:09:23 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF11A2D61
	for <bpf@vger.kernel.org>; Mon, 15 May 2023 06:09:02 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1aaf70676b6so90655935ad.3
        for <bpf@vger.kernel.org>; Mon, 15 May 2023 06:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684156140; x=1686748140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7lJXeGdmmXQ6fZ/+VqhCkbCDOtoN1rzSWwemISQpoA=;
        b=UTGf3mAVK3minW+Q9Cy02OrkGezP8IBv9H2NupFnarj9t8QZYDJeYB1xeF6MprzKzm
         9Bass1p4KzxWBirWxeCCpBKSVQwoUR+c1u1jEGK0yoKM26jBRA/LA3bkIS1E+kt2v2Y5
         el7ZUd9uEMD+Lvj7/l8IVxHCR6/9eoW2Xl6eX4Ueq7h97i3yAJTOscxob7La2gOxjk9d
         60YotAjRbdTfHS7myoodTxFcCBQLI1JkU8CqI5VKyTydKt40IArvIH5T6LJuqnswHFZw
         7vZFNB7MWtCjsoljAxpjoNfZxJKv1Pf9dNdVy8w3kwaAJWImqVIfNEx9LC7x/v9+YoEF
         4MNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684156140; x=1686748140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7lJXeGdmmXQ6fZ/+VqhCkbCDOtoN1rzSWwemISQpoA=;
        b=L2hnHycq9M+aAf6pCu70aPUzBaIMu4NY3Dp09qkuRDCBZBvRvP4U/T6AtvuMrjjz5C
         DIQtEc0+aQs0ZK20dOWxZZZ/dighv61ePl9XSPUSNz3bN68WucMfMaKcm2bttmyPt9hB
         uQRQvVX270jh+L30JadhvnAM2RJ048/41JHh+itf7iYduYHsKHEvT32/8W+CotgSkaj/
         j0drcZSJxp4GctFNlNFgkCmMZhkx1pMHbM9niJf5b9PfnTRtgyvkT3gJzm5Kn6yrGBam
         GOIRfAKz5W16p+e/95Cyb6gHHBl46EYVh7Pofiw78MTsVxPn6Ntfm8b4iIog5MEJ4ZW6
         IigQ==
X-Gm-Message-State: AC+VfDxANKOfoFMh0JKVSsSdUYmqg+8Cgrch3j5suB/4Rs+bQv7I/2ET
	KFqZy/Y3fiYYx55+4ij0STkFE6g2ubbByfSwkHM=
X-Google-Smtp-Source: ACHHUZ6EZNlE4Du5N3Y72WmKvuiRmzbXsGULqnTizIwyb/L+YgoR7ll0VG9n8yUkHJQxTrOSWtMnmw==
X-Received: by 2002:a17:902:c946:b0:1a5:22a:165c with SMTP id i6-20020a170902c94600b001a5022a165cmr43716275pla.0.1684156140372;
        Mon, 15 May 2023 06:09:00 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:991:5400:4ff:fe70:1e06])
        by smtp.gmail.com with ESMTPSA id h5-20020a170902748500b001ac2a73dbf2sm13458723pll.291.2023.05.15.06.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 06:08:59 -0700 (PDT)
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
	Yafang Shao <laoar.shao@gmail.com>,
	Song Liu <song@kernel.org>,
	Jiri Olsa <olsajiri@gmail.com>
Subject: [PATCH bpf-next v2 1/3] bpf: Fix memleak due to fentry attach failure
Date: Mon, 15 May 2023 13:08:47 +0000
Message-Id: <20230515130849.57502-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230515130849.57502-1-laoar.shao@gmail.com>
References: <20230515130849.57502-1-laoar.shao@gmail.com>
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

Fixes: e21aa341785c ("bpf: Fix fexit trampoline.")
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Song Liu <song@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>
---
 kernel/bpf/trampoline.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index ac021bc..2a3849c 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -251,11 +251,8 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
 	return tlinks;
 }
 
-static void __bpf_tramp_image_put_deferred(struct work_struct *work)
+static void bpf_tramp_image_free(struct bpf_tramp_image *im)
 {
-	struct bpf_tramp_image *im;
-
-	im = container_of(work, struct bpf_tramp_image, work);
 	bpf_image_ksym_del(&im->ksym);
 	bpf_jit_free_exec(im->image);
 	bpf_jit_uncharge_modmem(PAGE_SIZE);
@@ -263,6 +260,14 @@ static void __bpf_tramp_image_put_deferred(struct work_struct *work)
 	kfree_rcu(im, rcu);
 }
 
+static void __bpf_tramp_image_put_deferred(struct work_struct *work)
+{
+	struct bpf_tramp_image *im;
+
+	im = container_of(work, struct bpf_tramp_image, work);
+	bpf_tramp_image_free(im);
+}
+
 /* callback, fexit step 3 or fentry step 2 */
 static void __bpf_tramp_image_put_rcu(struct rcu_head *rcu)
 {
@@ -438,7 +443,7 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 					  &tr->func.model, tr->flags, tlinks,
 					  tr->func.addr);
 	if (err < 0)
-		goto out;
+		goto out_free;
 
 	set_memory_rox((long)im->image, 1);
 
@@ -468,7 +473,7 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 	}
 #endif
 	if (err)
-		goto out;
+		goto out_free;
 
 	if (tr->cur_image)
 		bpf_tramp_image_put(tr->cur_image);
@@ -480,6 +485,10 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
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


