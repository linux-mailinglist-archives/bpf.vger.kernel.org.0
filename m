Return-Path: <bpf+bounces-1445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF35F716834
	for <lists+bpf@lfdr.de>; Tue, 30 May 2023 17:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DAD31C20C75
	for <lists+bpf@lfdr.de>; Tue, 30 May 2023 15:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2A027215;
	Tue, 30 May 2023 15:57:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA87917AD4
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 15:57:10 +0000 (UTC)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3767B11A;
	Tue, 30 May 2023 08:57:04 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-7770c1570a6so97069639f.2;
        Tue, 30 May 2023 08:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685462223; x=1688054223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+5ml+n3HD2eDlctb1SV+3KPtVS8DVTaTN+Q4XblTLM=;
        b=BbIhlwc5JmmbjB4ooGvpeucoVtRlFL7RpqDk/j5+Od+D1jrYEYDUGraUWFS2hrK2df
         jFvfYOlR4sjnzGEli6sasc/nPq7h09b61muTsjSK8KL7MQPGPYUisGXgFQy9OvfSOIyw
         s524kuij6XYWggPDS3PkNyZk8yB3s8Lu+08/jSQQJCCb90hpRkV6qL5BqR2sEaaf6hoU
         TURXOMbpwsBuGhHhprcQiK6AnIHWuUfFX1EaQeZDtJMno9GU/4RvltUT9OiPHrcPT2n3
         LDm2HOJfau9+3PVqeo/8qVzOJsxd1CeKMqFkrmagQrKBPZAWH/BfDRuqJGgt8zFfMz1Q
         pNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685462223; x=1688054223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y+5ml+n3HD2eDlctb1SV+3KPtVS8DVTaTN+Q4XblTLM=;
        b=M1kcLz8kvdVilXMxq8FL2w+dKiGuERJvgzdk4IcDnAz0tloT5IG7CP1RbA6MXNfLEL
         uX73MH94Uo3UvevKUNRdT4iTvr7PxVV+u+3l7PAl+Dfm8582nMeFE9PuaD8Lc2TGGks1
         Px1868SH6A4/KsnA7e19vBvuDrI+Ca3fT6K+GINbstf/r/dqf+PX4HK/065J0B2L+Jx3
         A3oyIs84YLR5xZYoM7+/edopA7JRo+nMeb2iSZPBR1Cr4SkJbLtvavlEJOeeSyhMuXb0
         wqBMuw9q0p+LPcqHTHE6ODoyvY78GyZeRKm9tUVtdFKIQnhXM2yPERl4yVLJn4OzpVSy
         5/8A==
X-Gm-Message-State: AC+VfDyeeEi0o9zPVl0EYVcXgRIZ4yLg8lif5nt9uHQvzHzRWS2MBKpg
	MPf1SKY5+kkX1op7AXzLU8o=
X-Google-Smtp-Source: ACHHUZ5QBWFzG3pzBNh8KYhdRtFNAjoXECGEfJVp83VzQNC6surICk6GmZRNMR8Pxw408LDeq+FChQ==
X-Received: by 2002:a6b:fe0a:0:b0:76c:8674:81e7 with SMTP id x10-20020a6bfe0a000000b0076c867481e7mr1407579ioh.21.1685462223458;
        Tue, 30 May 2023 08:57:03 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id 22-20020a5ea516000000b0076c569c7a48sm700293iog.39.2023.05.30.08.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 08:57:03 -0700 (PDT)
From: Azeem Shaikh <azeemshaikh38@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: linux-hardening@vger.kernel.org,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH] bpf: Replace all non-returning strlcpy with strscpy
Date: Tue, 30 May 2023 15:56:59 +0000
Message-ID: <20230530155659.309657-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().
No return values were used, so direct replacement is safe.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 kernel/bpf/preload/bpf_preload_kern.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/preload/bpf_preload_kern.c b/kernel/bpf/preload/bpf_preload_kern.c
index b56f9f3314fd..0c63bc2cd895 100644
--- a/kernel/bpf/preload/bpf_preload_kern.c
+++ b/kernel/bpf/preload/bpf_preload_kern.c
@@ -23,9 +23,9 @@ static void free_links_and_skel(void)
 
 static int preload(struct bpf_preload_info *obj)
 {
-	strlcpy(obj[0].link_name, "maps.debug", sizeof(obj[0].link_name));
+	strscpy(obj[0].link_name, "maps.debug", sizeof(obj[0].link_name));
 	obj[0].link = maps_link;
-	strlcpy(obj[1].link_name, "progs.debug", sizeof(obj[1].link_name));
+	strscpy(obj[1].link_name, "progs.debug", sizeof(obj[1].link_name));
 	obj[1].link = progs_link;
 	return 0;
 }


