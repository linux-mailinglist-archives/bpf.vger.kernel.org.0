Return-Path: <bpf+bounces-12128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA71C7C8086
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 10:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6E56B20A60
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 08:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5046FC0;
	Fri, 13 Oct 2023 08:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AiEN6hU5"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B23C6AC2
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 08:39:37 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF8891
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 01:39:33 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-690fe10b6a4so1479985b3a.3
        for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 01:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697186372; x=1697791172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xX7NrARHBe9xPkDw3pmqIgre2mGamAMStwHAFk0gk+8=;
        b=AiEN6hU5epUP0tngfPIYicWZ210C1C4wiDwbuaBGoi4tBmg/xe1X7ITsZeQEhlzANc
         /7P7dcCKcP5jtQl4F0Hrun1xHhrobi7w3Qw+d5tSmc/RKDlEC76ewntsrMsFn0sd0ox8
         eM2imcjodQ5prHinD3wiR7+0+j94c6FxqG+SAsyAXRJJzY6TcaVxf1v9QP0i0T2oOk4l
         4iRVRV32ukefZoy+6usas/yt4nTqoKwUpHHCNXh47jDdRbfalL+jiMFUzlW7E4jqCb+M
         uj1w73hu6g4uCFknYS/DErxltTLdCeGrHWa0HzxDxWavcXDTRxEBLt12sZZzzgKmT2Bv
         B3uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697186372; x=1697791172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xX7NrARHBe9xPkDw3pmqIgre2mGamAMStwHAFk0gk+8=;
        b=rsJv15fe/pwrq8Ld/50cjv0WHF7g19qv/q7Uf9Y3psSb/+iKpv9S+1rTKbub1YTXI6
         7do6cDgr+60ZFQn2p8mDhx8fOuCRQZXxABA4qMIqVo8yTL5IJf7lyXVobAsNGi72MJPu
         MuKALOIiLdoXHEDDudR+/KL8MhSu8TqabS3gTs/Gh3jYH75zoF/pMLqm4TytI827LSB0
         UMSLl0yI9CtqIpx2Dzx1jYjeZaddw6zN1EwVxkfKb+xt9ivJRBIVYbkFGMxx7xt6ZmP/
         ulW2CVJq3buoDNgPdDMpKTciBV2dTLjFTJ3eP6xDTU1SLfdcnKgWEQ5X+GESIDi17s5E
         Ox4g==
X-Gm-Message-State: AOJu0YxAYfwe/qYpeG664pA6dozpCygzSHQmdXfhXi86VQ1mr059WJ+P
	quOqlI9KWjMC8LEjA/fiXr4co1S85C2+zO9w
X-Google-Smtp-Source: AGHT+IG2x9tETWqfaFACL2c7yQUF5Aw0cDoSkSbt80140kIF+AmamzpBugWZ6LTfVOe2+g/yUJjJIA==
X-Received: by 2002:a05:6a20:4292:b0:157:1b5:61ce with SMTP id o18-20020a056a20429200b0015701b561cemr32367921pzj.4.1697186372573;
        Fri, 13 Oct 2023 01:39:32 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:3b2:5400:4ff:fe9b:d21b])
        by smtp.gmail.com with ESMTPSA id e7-20020a170902b78700b001c735421215sm3305921pls.216.2023.10.13.01.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 01:39:32 -0700 (PDT)
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
	Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH bpf-next] bpf: Avoid unnecessary audit log for CPU security mitigations
Date: Fri, 13 Oct 2023 08:39:16 +0000
Message-Id: <20231013083916.4199-1-laoar.shao@gmail.com>
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

Check cpu_mitigations_off() first to avoid calling capable() if it is off. 
This can avoid unnecessary audit log.

Fixes: bc5bc309db45 ("bpf: Inherit system settings for CPU security mitigations")
Link: https://lore.kernel.org/bpf/CAEf4Bza6UVUWqcWQ-66weZ-nMDr+TFU3Mtq=dumZFD-pSqU7Ow@mail.gmail.com/
Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/bpf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 61bde45..f0891ba 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2164,12 +2164,12 @@ static inline bool bpf_allow_uninit_stack(void)
 
 static inline bool bpf_bypass_spec_v1(void)
 {
-	return perfmon_capable() || cpu_mitigations_off();
+	return cpu_mitigations_off() || perfmon_capable();
 }
 
 static inline bool bpf_bypass_spec_v4(void)
 {
-	return perfmon_capable() || cpu_mitigations_off();
+	return cpu_mitigations_off() || perfmon_capable();
 }
 
 int bpf_map_new_fd(struct bpf_map *map, int flags);
-- 
1.8.3.1


