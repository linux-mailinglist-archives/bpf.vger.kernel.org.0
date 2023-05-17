Return-Path: <bpf+bounces-750-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7332706549
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 12:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE5821C20F27
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 10:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A8B168AA;
	Wed, 17 May 2023 10:31:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDAF168C5
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 10:31:40 +0000 (UTC)
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46AA524C
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 03:31:32 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-4361225a745so149752137.2
        for <bpf@vger.kernel.org>; Wed, 17 May 2023 03:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684319491; x=1686911491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0SCSj3nmzeRLmTAaSPOQONEtSITFN21WiSekl/6TEk=;
        b=Jz2OFZyvvnYn6d4MRKIMxY6353p17B6AObu1h/+wLxT3Gzo9ktuKE1i2DF77KZf15C
         D0PRzwTQlHuaff1QYh2V2R0snT5tovQWcUDyiPzhaemKhs0S90BqOxpmdIFJqOhMxEdJ
         fzvBAmmq7AaJP7ziWxWPAG2djn1f936ZEIVwYj9O+p7BCBCnuWlLd7BWkDf8G4x7MVm7
         Li37tlbJHBfyOstQhJJm14fa/Go5GjOLNA1h573VetEqWTHLooT2Eils4EZ+R6MzXdnZ
         +0sKePzA2vw2n7L9r74H2n26Q80VwQcz1Bqd4i9zGmBCxWtLLaYLjo9PrYupfskEfGkx
         6dpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684319491; x=1686911491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O0SCSj3nmzeRLmTAaSPOQONEtSITFN21WiSekl/6TEk=;
        b=GXtVQirWtv45VbXDF+yUTpqRWq/zDX1XmusqzMDbs3nLXlYFS6hoB4iqd+8k/oEWwj
         8JVQNqxs8B+sP/mpF1+P0/M/2LNR0IcXwRBWFTPnPY4ettZKnzjldgSmcyld1xJdUu8r
         ThrMAq/3xMvy7WOS3WKpO7OEyFQgIuhqYlXU7ZEA5wv8deC7w67sgMcKX3gheL+yKcLZ
         WvM8HsakcHrm8T9tNIrBJgqD0jDCPChYmVhw4nPAAKkQQ98CtwKMLDLbkpd0q4OvjOEu
         583VIzvlpE8uJg0ce5GlCzVLZ2I/Dw9CuvI8d2z0fZnzVvImDkGY5vrXtR0kZqzGFZ1H
         DziA==
X-Gm-Message-State: AC+VfDyzNNXzya8o6x2ScUcC9uFdbm4ECxCTehIVpzyYW0qfGGdBxEtf
	3gGSMY934GiNAwNmQJ1iFYg=
X-Google-Smtp-Source: ACHHUZ4IYA/abYPTgiSDk7hNfPRtTXIboKuXCw+YJ/BGyxXJG/G0ge+9QZKnf2aFSQRmbrPIp0vb0w==
X-Received: by 2002:a05:6102:e52:b0:425:e0ab:6fc with SMTP id p18-20020a0561020e5200b00425e0ab06fcmr15247931vst.35.1684319491686;
        Wed, 17 May 2023 03:31:31 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:9002:140f:5400:4ff:fe70:c0fd])
        by smtp.gmail.com with ESMTPSA id t25-20020a9f3899000000b0076d52359f2asm5343651uaf.31.2023.05.17.03.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 03:31:31 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: quentin@isovalent.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v2 1/2] bpf: Show target_{obj,btf}_id in tracing link fdinfo
Date: Wed, 17 May 2023 10:31:25 +0000
Message-Id: <20230517103126.68372-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230517103126.68372-1-laoar.shao@gmail.com>
References: <20230517103126.68372-1-laoar.shao@gmail.com>
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

The target_btf_id can help us understand which kernel function is
linked by a tracing prog. The target_btf_id and target_obj_id have
already been exposed to userspace, so we just need to show them.

The result as follows,

$ cat /proc/10673/fdinfo/10
pos:    0
flags:  02000000
mnt_id: 15
ino:    2094
link_type:      tracing
link_id:        2
prog_tag:       a04f5eef06a7f555
prog_id:        13
attach_type:    24
target_obj_id:  1
target_btf_id:  13964

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Song Liu <song@kernel.org>
---
 kernel/bpf/syscall.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 909c112..b262108 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2968,10 +2968,17 @@ static void bpf_tracing_link_show_fdinfo(const struct bpf_link *link,
 {
 	struct bpf_tracing_link *tr_link =
 		container_of(link, struct bpf_tracing_link, link.link);
+	u32 target_btf_id, target_obj_id;
 
+	bpf_trampoline_unpack_key(tr_link->trampoline->key,
+				  &target_obj_id, &target_btf_id);
 	seq_printf(seq,
-		   "attach_type:\t%d\n",
-		   tr_link->attach_type);
+		   "attach_type:\t%d\n"
+		   "target_obj_id:\t%u\n"
+		   "target_btf_id:\t%u\n",
+		   tr_link->attach_type,
+		   target_obj_id,
+		   target_btf_id);
 }
 
 static int bpf_tracing_link_fill_link_info(const struct bpf_link *link,
-- 
1.8.3.1


