Return-Path: <bpf+bounces-11433-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD0117B9BDB
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 10:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id F10C21C20897
	for <lists+bpf@lfdr.de>; Thu,  5 Oct 2023 08:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69DD36AB0;
	Thu,  5 Oct 2023 08:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXIJD0SA"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3126E15C5
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 08:41:32 +0000 (UTC)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D6B900A
	for <bpf@vger.kernel.org>; Thu,  5 Oct 2023 01:41:30 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-578a62c088cso1464789a12.1
        for <bpf@vger.kernel.org>; Thu, 05 Oct 2023 01:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696495290; x=1697100090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+gUYWZ0VmKGY1G6Lk6iesjjcsvwl8c6Uz8Z3NtP5Y5Y=;
        b=cXIJD0SAoAELuC/s65rKki42uyQHcjQEodky6ghoEUTNJ6tXl+0pZlFkirIIwYs/4Z
         xhhUuEHFQuRutz03dKRVTj/TdhM4pIpxp+81NtHX4sPvPHmFznqj4mexMX6MT5UdAJbe
         lUI58J8/eHsBOj7KgCPJSjbo4xv59kHXRlXmoBzWTLjLtx3NEUpxt5BgsxkmR1TyBWhV
         ztAH5MIEY6UCCkw9YDiyHBefRRIedTddpgMxmNRr/D4sYd9Q34Ch30IyHbv2wKc4r/ye
         qeVdh1lvn4kyohF9w5mBFDO5XGMBQIbVHwHOf54r14DvhHdKv6By6zWxpj499AlMYcPK
         CmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696495290; x=1697100090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+gUYWZ0VmKGY1G6Lk6iesjjcsvwl8c6Uz8Z3NtP5Y5Y=;
        b=AA8O83FUxgF34xQZ3n9hh9yLhAHzrr9+5Eov803cO2lgwTVWEuZQfbNvAW+ubPJJBE
         9E+/a92RuSTA2u0u9EMgVNWPtIU3e1Mu8UYveuQbS8CkSPfoAH05NjnNouwplAlyWMze
         B/GJ/Mi6x0Rr9IbvId2j7RlhHVgo+sxvAqDlz8wcwlYjy+uSImJX6guEE4rszbSDQxDx
         JxDiKncUP5ilAkk26ggYxyqeisp0hpy9Tw3lbsQoOcW93NRR8QWA/5k6IR+eSYs+Cdv9
         qfX10ni+OP2M30u64HXcFYo+unijC/dKePTJG60iajCuzQXi2JEbkRHxEoUYvxSbt0UC
         MQ/A==
X-Gm-Message-State: AOJu0Yx5seNKfWtTRYRXVAP/dTFcXTML2fL0LEN5Iq1CJ/PkEZf+mvqf
	OX2m7EpwmpmIksnTu6jp58E=
X-Google-Smtp-Source: AGHT+IE8bH/khpho8xWR0F5Tahs50yxZJn72JCPCEb9gJot/m4z+08orWpu9W14D1xFgLzIC4JJtcA==
X-Received: by 2002:a17:90a:b785:b0:274:7db1:f50f with SMTP id m5-20020a17090ab78500b002747db1f50fmr3188893pjr.15.1696495289875;
        Thu, 05 Oct 2023 01:41:29 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac00:4fd4:5400:4ff:fe99:6afd])
        by smtp.gmail.com with ESMTPSA id z2-20020a17090a540200b0026b70d2a8a2sm982748pjh.29.2023.10.05.01.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 01:41:29 -0700 (PDT)
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
	Luis Gerhorst <gerhorst@cs.fau.de>
Subject: [PATCH bpf-next] bpf: Inherit system settings for CPU security mitigations
Date: Thu,  5 Oct 2023 08:41:23 +0000
Message-Id: <20231005084123.1338-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
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

Currently, there exists a system-wide setting related to CPU security
mitigations, denoted as 'mitigations='. When set to 'mitigations=off', it
deactivates all optional CPU mitigations. Therefore, if we implement a
system-wide 'mitigations=off' setting, it should inherently bypass Spectre
v1 and Spectre v4 in the BPF subsystem.

Please note that there is also a 'nospectre_v1' setting on x86 and ppc
architectures, though it is not currently exported. For the time being,
let's disregard it.

This idea emerged during our discussion about potential Spectre v1 attacks
with Luis[1].

[1]. https://lore.kernel.org/bpf/b4fc15f7-b204-767e-ebb9-fdb4233961fb@iogearbox.net/

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Cc: Luis Gerhorst <gerhorst@cs.fau.de>
---
 include/linux/bpf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a82efd34b741..61bde4520f5c 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2164,12 +2164,12 @@ static inline bool bpf_allow_uninit_stack(void)
 
 static inline bool bpf_bypass_spec_v1(void)
 {
-	return perfmon_capable();
+	return perfmon_capable() || cpu_mitigations_off();
 }
 
 static inline bool bpf_bypass_spec_v4(void)
 {
-	return perfmon_capable();
+	return perfmon_capable() || cpu_mitigations_off();
 }
 
 int bpf_map_new_fd(struct bpf_map *map, int flags);
-- 
2.30.1 (Apple Git-130)


