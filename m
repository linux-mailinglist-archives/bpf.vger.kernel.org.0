Return-Path: <bpf+bounces-10313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 234CD7A4F20
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 18:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1A69282D8B
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 16:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7841F615;
	Mon, 18 Sep 2023 16:34:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BA8262A9
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 16:34:08 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BBA9EED
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 09:33:55 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id ffacd0b85a97d-31aeef88a55so4224807f8f.2
        for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 09:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695054834; x=1695659634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r3Naoc4gG2mkQtePsEFFN2S+1KQG8MR2mniab1JfQY8=;
        b=jZ35HKH/bxUEogN4Cdt1CmdUHJ4OpBmAcy3ZA8SKuLVzpQc7Wdq1kBRPaOqa8MH7jZ
         HqkktHqGIZ8mCQsSNbOQxo4OBJj+OsWcyBulpeqztCMqsthb3VUJWSrMPf9YyePR9/YP
         8hyHZqSMn//PBm3+cgKRhs/a7O8tPhtsO7+0sQfUWAlhUuhbkB+KRBZmaVT9v8+A1tIq
         07F5ZbGq2Fu5XgFc6H5o7Syqh7hApDYzS55YrIT7a0iISfIIe6OvwJdpX4sdV6F28z9I
         bKD45TxsDZkjdarfs71d82TC8vpkM3ckURYRvJPnATzlAl0ol7J8EKRbH5eAO0rBqg7R
         wUfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695054834; x=1695659634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r3Naoc4gG2mkQtePsEFFN2S+1KQG8MR2mniab1JfQY8=;
        b=rmhBLNwzpYC+dZJhMUoCo942/ltc1OwnGuSX4P21/0tyyF1AI+ETLNmAz9YXiLYWHM
         GgZHTDNYV5IaG+sERFvtwJHug4jLuMHfsNmyNGYyTd2rDtfJGO4wqflWQqC5Pz1BtdYL
         w7P/Uojt3kk/Tnv0HJWNJ+je1VzyRlwyfojYMVFQL2VNQlL1H6MUEPuMWEuL7dRKmM7Q
         hniAXxQ7efffBtEFJ0uW6701Ib5mD9O0LLbkqCFq8dSyubxLBsdCbxEBcS1XaRkMnVPs
         yg9GNXUtglk5S9xhO1S2D/RfQttdP2v5FiZKJ+BNhY5xuMJD4pDPLvaFjC/Dd0h4qi5f
         /8qA==
X-Gm-Message-State: AOJu0YxAQrsSHm0prR9Y8hRrwZgbTo8Dh4bHvFHHeUTLHhRGRDKQkxw4
	Xxu5xyAURpH+S7O6T5YUZVkO9V1Va2dc7g==
X-Google-Smtp-Source: AGHT+IHCbsvkotmWKbRUe2jnayZm2q5L0JeKRmRUv8GpP0/5wv6mAv5LIYkmThpoBoP2Ad0uSd/WXw==
X-Received: by 2002:a17:906:cc9:b0:9a1:af6f:e373 with SMTP id l9-20020a1709060cc900b009a1af6fe373mr7925959ejh.42.1695047958765;
        Mon, 18 Sep 2023 07:39:18 -0700 (PDT)
Received: from localhost (vpn-253-124.epfl.ch. [128.179.253.124])
        by smtp.gmail.com with ESMTPSA id v15-20020a17090606cf00b009829d2e892csm6660350ejb.15.2023.09.18.07.39.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 07:39:18 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Matthieu Baerts <matthieu.baerts@tessares.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	David Vernet <void@manifault.com>,
	Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH bpf-next v1 2/3] bpf: Fix bpf_throw warning on 32-bit arch
Date: Mon, 18 Sep 2023 16:39:13 +0200
Message-ID: <20230918143914.292526-3-memxor@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230918143914.292526-1-memxor@gmail.com>
References: <20230918143914.292526-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1155; i=memxor@gmail.com; h=from:subject; bh=ZOTWQIcL62XArqSGkyZTul7LUdFIfys+cfEYyQUk+J0=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBlCGDZNFkPeR7f1jtQEtzuoZ6FDD6EEp2fT9oP7 fA8CdQa9qiJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZQhg2QAKCRBM4MiGSL8R yrk0D/0fQJ9uVcnSnINXcKuy1/VPmpM/LQJJaFyZvH+A0P5TwzD2sJplIkKaUnCO755SLNI0bqF Xc4jJ0v0GgfikWt3eimeT9K/CvM4UHFOPle7MDUc+VwQs4r/T7MPpy0J5S9p0Nui/ckqGr5hLsg /h3j0x1wc0JMPeMT6qXCWTiqmtwiWYuue7af7zBuN4m68wc8XMQNAZbbRu1cBYcFmjecWL1x00T UGDYAtcm0gRhzRXptMHRz9HyzFcgJ/YTNNo1BhtTMgdY68J+WDpV3YH3ezmkR8JTbmAVgGhlMke XdUY0aQXNKCBAxJjOL+ELdJD3tx0hTabasfDJHLA5EuD3GEiuetm4zuZS21bAtISroUPAOSm6Ef MEDI2aXPsLZ/Rj8sXw0EFaRswOWLGecmpvk8YOWpnDP+n9GqZvFZZy4DbE+Ri3NiaXBqeppOPUy B3mz9d7/kpmoX9PkqxH5hjQfmYUAG9Hg1//CRQ29W8hUKh+184D8yfj2OdizIocn8CdQWJm6YQA IkS3UKiVHFSctHbkoqzK+vq4Z/IJQy2zdZcpMw8rWyg507Im/fLrUqHvE0RscjhpTRDTnjx54Cb NcZMHPzhN5NK1QpaW3Co8Sfx0FfcUQRRapup84xcr5G59/oOgb+avAShQ9+A6l6Js3/VIjlBYv2 2lgbz7sC3iUM3mA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 32-bit architectures, the pointer width is 32-bit, while we try to
cast from a u64 down to it, the compiler complains on mismatch in
integer size. Fix this by first casting to long which should match
the pointer width on targets supported by Linux.

Fixes: ec5290a178b7 ("bpf: Prevent KASAN false positive with bpf_throw")
Reported-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 7ff2a42f1996..dd1c69ee3375 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2488,7 +2488,7 @@ __bpf_kfunc void bpf_throw(u64 cookie)
 	 * deeper stack depths than ctx.sp as we do not return from bpf_throw,
 	 * which skips compiler generated instrumentation to do the same.
 	 */
-	kasan_unpoison_task_stack_below((void *)ctx.sp);
+	kasan_unpoison_task_stack_below((void *)(long)ctx.sp);
 	ctx.aux->bpf_exception_cb(cookie, ctx.sp, ctx.bp);
 	WARN(1, "A call to BPF exception callback should never return\n");
 }
-- 
2.41.0


