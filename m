Return-Path: <bpf+bounces-5066-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4E6754E90
	for <lists+bpf@lfdr.de>; Sun, 16 Jul 2023 14:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0E671C20974
	for <lists+bpf@lfdr.de>; Sun, 16 Jul 2023 12:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCE8748C;
	Sun, 16 Jul 2023 12:11:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103D26FDF
	for <bpf@vger.kernel.org>; Sun, 16 Jul 2023 12:11:00 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA85C1B1
	for <bpf@vger.kernel.org>; Sun, 16 Jul 2023 05:10:58 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-668709767b1so2545241b3a.2
        for <bpf@vger.kernel.org>; Sun, 16 Jul 2023 05:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689509458; x=1692101458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVcrh+W1YEVuCLWLeHuOrfFeTxRRYwnxDB44DTk9zfc=;
        b=NXtxtBfLx9y09g83zaZYri1t/KBXF599BjSV6585puzfuHgcDQQz/6G6D+tsV09LO1
         8AhF9OdSchqNHtEH5a6S9ekSqZj1IGvW5/NamfqZaGFTtpm2IMEMRRyZ/AFV3v764cwK
         xmA11CKymuqWJuWgJndM2DGIae9noz5ia2iEAV4Ne8ytCGlgtK/J+9MY27rkWmSi8UvO
         Oi9aBE4LCHlUCXg64DLQ4u9y8BXh6Qjpc9Ygek3iNVS31u6JAWnnZmY93aVJvRFsiMN+
         H2B4dZge8/EzHeFmq0mC84RADa+ohV3ORQskazqzyY4KQn/HBYqhilfrYmOX+YQ/InUg
         ru8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689509458; x=1692101458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cVcrh+W1YEVuCLWLeHuOrfFeTxRRYwnxDB44DTk9zfc=;
        b=ayI/82vVCIk5s+dnEMinuWzhGcSeuY+V3Gf+2W7pfVoDhp2+16Hmmj3YN4KWV8RWNo
         v/1hFcCxcY3OidgiPi4LLIuxr8eOIrdGTUFbGPOUO47P1yez9iU9IQiN9/xn4Y7ZCX4k
         HmLDQbYE/M2r37yV4/CehHYBa9g2Ut9NMUiXk7i5Yf19svHv24cAl6jKRiJWCS1WyhKn
         Np1v4KDKBscBpRpbkESWQxGG0tp3ml1tKmK5b1LEKtFW/62p6VmiLI3nPHZGuISjrKMI
         L5KtbmhfI+BkGEcF8y8Cvzjt348b+qnvS5yYTRFHYakjXc5BMVWaAylo/Qw4CHGgZcbW
         VJUA==
X-Gm-Message-State: ABy/qLY4173XywMMM8AZjNPsr9RYKNMmpjYYR0UvVWgrHZKdGRzdkGKH
	b6FesZZvMj9eZENwK/hspyE=
X-Google-Smtp-Source: APBJJlEwikrUkIg79BOxZyhgRtJQZf+j5XPDAhWYbUjkQidjED5wW7VG80XWMFGosgIkVY+DOU0UMQ==
X-Received: by 2002:a05:6a00:1787:b0:675:8f71:28f1 with SMTP id s7-20020a056a00178700b006758f7128f1mr11263820pfg.30.1689509458179;
        Sun, 16 Jul 2023 05:10:58 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:697:5400:4ff:fe82:495b])
        by smtp.gmail.com with ESMTPSA id u8-20020a62ed08000000b0062cf75a9e6bsm10128730pfh.131.2023.07.16.05.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jul 2023 05:10:57 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	quentin@isovalent.com
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [RFC PATCH bpf-next 1/4] bpf: Add __bpf_iter_attach_cgroup()
Date: Sun, 16 Jul 2023 12:10:43 +0000
Message-Id: <20230716121046.17110-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230716121046.17110-1-laoar.shao@gmail.com>
References: <20230716121046.17110-1-laoar.shao@gmail.com>
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

This is a preparation for the followup patch. No functional change.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/cgroup_iter.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/cgroup_iter.c b/kernel/bpf/cgroup_iter.c
index 810378f04fbc..619c13c30e87 100644
--- a/kernel/bpf/cgroup_iter.c
+++ b/kernel/bpf/cgroup_iter.c
@@ -191,21 +191,14 @@ static const struct bpf_iter_seq_info cgroup_iter_seq_info = {
 	.seq_priv_size		= sizeof(struct cgroup_iter_priv),
 };
 
-static int bpf_iter_attach_cgroup(struct bpf_prog *prog,
-				  union bpf_iter_link_info *linfo,
-				  struct bpf_iter_aux_info *aux)
+static int __bpf_iter_attach_cgroup(struct bpf_prog *prog,
+				    union bpf_iter_link_info *linfo,
+				    struct bpf_iter_aux_info *aux)
 {
 	int fd = linfo->cgroup.cgroup_fd;
 	u64 id = linfo->cgroup.cgroup_id;
-	int order = linfo->cgroup.order;
 	struct cgroup *cgrp;
 
-	if (order != BPF_CGROUP_ITER_DESCENDANTS_PRE &&
-	    order != BPF_CGROUP_ITER_DESCENDANTS_POST &&
-	    order != BPF_CGROUP_ITER_ANCESTORS_UP &&
-	    order != BPF_CGROUP_ITER_SELF_ONLY)
-		return -EINVAL;
-
 	if (fd && id)
 		return -EINVAL;
 
@@ -220,10 +213,25 @@ static int bpf_iter_attach_cgroup(struct bpf_prog *prog,
 		return PTR_ERR(cgrp);
 
 	aux->cgroup.start = cgrp;
-	aux->cgroup.order = order;
 	return 0;
 }
 
+static int bpf_iter_attach_cgroup(struct bpf_prog *prog,
+				  union bpf_iter_link_info *linfo,
+				  struct bpf_iter_aux_info *aux)
+{
+	int order = linfo->cgroup.order;
+
+	if (order != BPF_CGROUP_ITER_DESCENDANTS_PRE &&
+	    order != BPF_CGROUP_ITER_DESCENDANTS_POST &&
+	    order != BPF_CGROUP_ITER_ANCESTORS_UP &&
+	    order != BPF_CGROUP_ITER_SELF_ONLY)
+		return -EINVAL;
+
+	aux->cgroup.order = order;
+	return __bpf_iter_attach_cgroup(prog, linfo, aux);
+}
+
 static void bpf_iter_detach_cgroup(struct bpf_iter_aux_info *aux)
 {
 	cgroup_put(aux->cgroup.start);
-- 
2.39.3


