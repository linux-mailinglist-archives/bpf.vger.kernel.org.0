Return-Path: <bpf+bounces-2105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7351727CE8
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 12:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05E521C20943
	for <lists+bpf@lfdr.de>; Thu,  8 Jun 2023 10:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8646C14B;
	Thu,  8 Jun 2023 10:35:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3159C12D
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 10:35:43 +0000 (UTC)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D802738
	for <bpf@vger.kernel.org>; Thu,  8 Jun 2023 03:35:40 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-62b6af3822fso3889876d6.2
        for <bpf@vger.kernel.org>; Thu, 08 Jun 2023 03:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686220539; x=1688812539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4BDOzLCRV7y5M7RTGg7dFlMbt6JiPdaCVfbp9qQHRpE=;
        b=hYuLC4boh66CRtg8RpKRBxCKx+k/HXJtDV8nD4x77gizHnbd9VLxpv38jOPabQ2kb9
         MIgOpOeipqaVOKPKy7pLHZdM5Rf71f6GjKOENzJ5fGKmVEoXNT0u7IUAbGUfhvc6AYEo
         gVAPqMk8tX0Bl3twQHi3Jxycm+/3yJuMyH/GlnkLmHkVKDerf+gTHBD9K8AnXKzKInpo
         j0+WWizsc/8kBPgAwEC0jPuIIIVD6TMuX68xCBA0ue0Vq+j7Z0q9MCd/yFietCf2JUe8
         vddtWaZWOHL3CZlIWV2oaSmgR79Yty5aSQFN2tSbhhwKgaW+AG0c2SC19J1AUmI6Crk0
         G9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686220539; x=1688812539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4BDOzLCRV7y5M7RTGg7dFlMbt6JiPdaCVfbp9qQHRpE=;
        b=LWPJ2vPkvRcFwg+XPKwSGmJaZBWOGA8Cx0506qUSuKSRV+p4upJHLZE2CrkdXsgUkx
         m6NeYBKhhvDatOYN1sSLM8R4HcdLW4u2n7m3LbWoLxh8Bk9HnMq0ZkQ9wLI39pKyD7V4
         N44fjozyxD5BnGMbkBnFnt2aDhAYG3UUbKeX7wQdHn7B9pjwQ4FERYNpsA8Nqwej9efd
         mAM5Ffy7BTsHL5/lpS3dAA7zMMoR7EJDljPibgKoVC/GQWUCy7+aQ7V/4kcsX/Cnzpav
         4N6VMXaXSo7bWc5UAVhGf2nMNiBu2q7CC4BPzCINTDu0UjASGzrsTZowvQZuDBkbbmhw
         stUQ==
X-Gm-Message-State: AC+VfDwIUZZyhHpsuo0EqIFY1qMUAKb27OWTYErbv6pN3xaQIM3eVHRx
	zSBV0JpgUwcmn4MMNbzNFBQ=
X-Google-Smtp-Source: ACHHUZ4Dc0J1LAw6/DYIkVNmuAinarj9GSnx/HsMbNpYEkqMW7bxX3i2XftTnyUJQvPrtUXe60c77Q==
X-Received: by 2002:a05:6214:e8a:b0:626:2f1b:b41a with SMTP id hf10-20020a0562140e8a00b006262f1bb41amr1255312qvb.49.1686220539264;
        Thu, 08 Jun 2023 03:35:39 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:1000:2418:5400:4ff:fe77:b548])
        by smtp.gmail.com with ESMTPSA id p16-20020a0cf550000000b0062839fc6e36sm302714qvm.70.2023.06.08.03.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 03:35:38 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	quentin@isovalent.com
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 bpf-next 04/11] bpf: Protect probed address based on kptr_restrict setting
Date: Thu,  8 Jun 2023 10:35:16 +0000
Message-Id: <20230608103523.102267-5-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230608103523.102267-1-laoar.shao@gmail.com>
References: <20230608103523.102267-1-laoar.shao@gmail.com>
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

The probed address can be accessed by userspace through querying the task
file descriptor (fd). However, it is crucial to adhere to the kptr_restrict
setting and refrain from exposing the address if it is not permitted.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/trace/trace_kprobe.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 59cda19..6564541 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1551,7 +1551,10 @@ int bpf_get_kprobe_info(const struct perf_event *event, u32 *fd_type,
 	} else {
 		*symbol = NULL;
 		*probe_offset = 0;
-		*probe_addr = (unsigned long)tk->rp.kp.addr;
+		if (kptr_restrict != 2)
+			*probe_addr = (unsigned long)tk->rp.kp.addr;
+		else
+			*probe_addr = 0;
 	}
 	return 0;
 }
-- 
1.8.3.1


