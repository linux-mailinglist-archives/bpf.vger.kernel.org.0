Return-Path: <bpf+bounces-6982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAEC976FF16
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 12:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64DC9282492
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 10:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCB7AD47;
	Fri,  4 Aug 2023 10:57:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AC8AD3C
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 10:57:53 +0000 (UTC)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433D34C02
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 03:57:38 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1bc0d39b52cso13347985ad.2
        for <bpf@vger.kernel.org>; Fri, 04 Aug 2023 03:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691146657; x=1691751457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XS4CfR7sbVJSeYvNGPYQWpoR/Kdz1smh358cnKQ1/Rg=;
        b=qCTYIgnUIihWxqytpwWbJDXDrVcn1vKiwiimvDysKG8rXqUr1Ypu7854tijIMFw66T
         ppIxsnVTGueDDnLL9mYFQoXeSn2WIMql/1ReOM1EJr0y6T44EE463pMXj2ZwsK3AhSDC
         Ml/M1fFQWm0dvX26qFzvnVfg0rAvFzHMbVqBaQbbtmBTIn8mp3UfAN/GzrP1WYtOgdmf
         2rnnBlw85eU6iB+vqdJrJ5Rk0BPesQhrFlP8Wazo02dQmKwxbxwqSfs4/HzXjX4wdUX/
         3J8QhCiryHEa+yRrdYIesE+0EpjxewQgVZL9wnqry5YjCpViY0W6T4MhSQ2quJKNbTqy
         bJhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691146657; x=1691751457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XS4CfR7sbVJSeYvNGPYQWpoR/Kdz1smh358cnKQ1/Rg=;
        b=B3wVupS1aucsIzoQqfBwwpavNBF9UiTSHIMiGwyyPqenbBl2O8JIx3w9VlJhv2lI6O
         2I7sAvImyYGHx3TbKRhKjAM9lUAzx6MQ+18Ixmb8e9/05Ok0Ris+HQS756WhKNpv40T3
         UOHamk80F0c3AFgFIR9/SFoDjgK5zDiiiZGTEMzuFI0auO191Ue/jqXBOR0u/aDl8pO8
         RqwxHlm/NKYd1GZuKfAk4oNpIVoC3mHtEzfjfSMUMCE5L3sEP97KVXt6TGUqCM7X7v3p
         9/vjEgULywt3HPxkF49e7vo+rlizQT9SS/bTFpIDXyk7wSvZfvJqTe9Y8CWIPXdxZy/w
         oOCA==
X-Gm-Message-State: AOJu0YzzG5TeK94y6Z0W6uNUItKTFp0WGGcaRIu21g2oeqHWn7y3+ZIi
	hevRPQN8jcisiIx87pULMCo=
X-Google-Smtp-Source: AGHT+IGLnvXCwqaXs1yPr4FZBovhpQUoqSdcjRFrITNRbGtTcMh3wGQlhxeJJjAFFNQV/pXn4Kxy6w==
X-Received: by 2002:a17:902:bd07:b0:1b1:9218:6bf9 with SMTP id p7-20020a170902bd0700b001b192186bf9mr1032382pls.43.1691146657574;
        Fri, 04 Aug 2023 03:57:37 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:c27:5400:4ff:fe87:9943])
        by smtp.gmail.com with ESMTPSA id q19-20020a170902bd9300b001b850c9d7b3sm1457691pls.249.2023.08.04.03.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 03:57:37 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v4 bpf-next 1/2] bpf: Fix uninitialized symbol in bpf_perf_link_fill_kprobe()
Date: Fri,  4 Aug 2023 10:57:31 +0000
Message-Id: <20230804105732.3768-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230804105732.3768-1-laoar.shao@gmail.com>
References: <20230804105732.3768-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The patch 1b715e1b0ec5: "bpf: Support ->fill_link_info for
perf_event" from Jul 9, 2023, leads to the following Smatch static
checker warning:

    kernel/bpf/syscall.c:3416 bpf_perf_link_fill_kprobe()
    error: uninitialized symbol 'type'.

That can happens when uname is NULL. So fix it by verifying the uname
when we really need to fill it.

Fixes: 1b715e1b0ec5 ("bpf: Support ->fill_link_info for perf_event")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/bpf/85697a7e-f897-4f74-8b43-82721bebc462@kili.mountain/
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/syscall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 7f4e8c3..166390f 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3378,14 +3378,14 @@ static int bpf_perf_link_fill_common(const struct perf_event *event,
 
 	if (!ulen ^ !uname)
 		return -EINVAL;
-	if (!uname)
-		return 0;
 
 	err = bpf_get_perf_event_info(event, &prog_id, fd_type, &buf,
 				      probe_offset, probe_addr);
 	if (err)
 		return err;
 
+	if (!uname)
+		return 0;
 	if (buf) {
 		len = strlen(buf);
 		err = bpf_copy_to_user(uname, buf, ulen, len);
-- 
1.8.3.1


