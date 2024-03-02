Return-Path: <bpf+bounces-23212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD44B86EDA4
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 01:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6510E1F231B3
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 00:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9129C1C16;
	Sat,  2 Mar 2024 00:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="T1NvoCAM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED98EBE
	for <bpf@vger.kernel.org>; Sat,  2 Mar 2024 00:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709341052; cv=none; b=XqS418AW85UCEwfAtrRUAjo8l1mTZN/Pz6yMzCiBaURHySWU8oHwvcfW/GhZZUJGkPoCNfbudr1YxwzIjkZfdZUEjPy2UVkoF3SjXP8vwnJ6k3WcnpJewWvCQtfCuwHUXreUGU+s392SwhYCjO6vagmNU1MD0KyF4EKdfO3z1Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709341052; c=relaxed/simple;
	bh=5NeWRhfqhllmCD9mFMx/PgmwIdXK3vIcl4ByQ0zu5TU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uFT8QZQTa9OQs0UL3kd4MfGYcMAe/Jg/h9prG6nbRVCdu8a9YTTXhBg/7M/D0v7cZE5HghZNAD2t+NpgSfFy+NlV6zezpPMQlNANPC4S4y/KNTRVonHY3nFUEd9ItP4nDvGzAbLZP6nuPh5Nd/UcD9ZLjzzcs9FlAhpu06fa2fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=T1NvoCAM; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3566c0309fso370004766b.1
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 16:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1709341049; x=1709945849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XfkelKUHIIHCQK6GQkZSqQAl8iGPsieC5jUUCHXhVW0=;
        b=T1NvoCAMttmKhyE1F7y7Eq7lqUO1/dtKM2PWUxAxP2AkqEDhTQJ/kLpclmIRY1rXX4
         2DrR3Jd5/5w8Iyzo73Fdjgb6c7ZE+jvblkYmAy/pr4n4hALFoy8beCUUEKm98YjWHwG0
         Sf55qoers/6KUoLWls2Ojhl0cigdnW0S1ZXUMy7IBCxZR7idVJRDtIHHcKXr9N6jLIx5
         TFe7HLytSjP6gwTcVh+E0aoyrfdZWR3PwM0oEYSdY1DkDtkMjMcyO9IWzGbAnuWmYRlG
         HXzvcaOhI56vCNcgzd7bcKKP2FtwSZpctGWEuiaNRckWSmy9KQSmiBFWtDwQRCg2tHEn
         bAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709341049; x=1709945849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XfkelKUHIIHCQK6GQkZSqQAl8iGPsieC5jUUCHXhVW0=;
        b=kC0jYtuR4gB/w5nsZDYfG92r55h9mzFgJxrJWlgNebNR5PjfSiDIbPb5UThLD5GyES
         XAsbur0MH6bQzMRF+XPmQRx9nLmLfDDN3bAnS+53WnAd2M9ayTqlKjMa82EI2mvmwgaR
         IAS8JPPRR/PTJZqNYQ7nqfWpmCCriUPjCV95TN+vLbTfBCmFNG81d0T+dRaoFvFseblw
         HAmRVE6TPMcsmVdeiEV1iKxjS/KYEMMHOhSVF+hW/yR2d/zQIacl3FErNKF/eBB5cB8a
         jgFdkCtZ4PQKUppUhHXfwfWqv7CrinJiNkPWJ5Qkmdu5SJXjbLIoA29EHbMFIFJ+gNI3
         TIgg==
X-Forwarded-Encrypted: i=1; AJvYcCU9qjZ7dfY5xhXFrXteTbcwQDlC4QtEiFYPGR/1HJ+Cf692ugKNR1m9NZ+dEuN52cxcOvITVD7iJVmKrVAG8jTUHtfS
X-Gm-Message-State: AOJu0YzYDkweBdMPv6WHOGDaJUmGNl3KI6hWG2xmHeS1K2ExU1iJR6lX
	wVskWx/CMS3B1SKQppsEWtZ4sh5DHV1bpPSbNn8heefmEgtVHpCsoM2O9YyH7c4=
X-Google-Smtp-Source: AGHT+IHCSp7S1z3p2QExM8xCWQEwzBwSLu1JprvqTg2FQC64lmgA38holXeFo9lsrS/n5MuIyoc8Tg==
X-Received: by 2002:a17:906:a84c:b0:a44:9a5d:2be2 with SMTP id dx12-20020a170906a84c00b00a449a5d2be2mr2186969ejb.56.1709341048786;
        Fri, 01 Mar 2024 16:57:28 -0800 (PST)
Received: from fedora.fritz.box (aftr-82-135-80-35.dynamic.mnet-online.de. [82.135.80.35])
        by smtp.gmail.com with ESMTPSA id u22-20020a1709067d1600b00a3d2d81daafsm2215372ejo.172.2024.03.01.16.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 16:57:28 -0800 (PST)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] libbpf: Remove unneeded conversion to bool
Date: Sat,  2 Mar 2024 01:54:54 +0100
Message-ID: <20240302005453.305015-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes Coccinelle/coccicheck warning reported by boolconv.cocci.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index afd09571c482..2dda7a6c6f85 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1801,7 +1801,7 @@ static int set_kcfg_value_tri(struct extern_desc *ext, void *ext_val,
 				ext->name, value);
 			return -EINVAL;
 		}
-		*(bool *)ext_val = value == 'y' ? true : false;
+		*(bool *)ext_val = value == 'y';
 		break;
 	case KCFG_TRISTATE:
 		if (value == 'y')
-- 
2.44.0


