Return-Path: <bpf+bounces-65718-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E75A3B27904
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 08:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F8C71885235
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 06:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46052BE7DA;
	Fri, 15 Aug 2025 06:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlF1HejB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF412BE7C6;
	Fri, 15 Aug 2025 06:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755238732; cv=none; b=iAps0kw/kMo1UZbo6VnRAOqSnwx4Kcojd2o71+pyRP4c5Hqr9RAchACWbNYYw14Opi+HfuTgzTnQetG3iwyZ5VEfwdAu7YwJo0C+S/+fCX5Kp9HuXl7Rc+LkBdrBkuDsCtSuh9b0/uxTSXQaDDzkzAz3xboYlOe7sW7j/w+DSSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755238732; c=relaxed/simple;
	bh=LJbi4L24gEu0az/1z7pD+rs3U13DbjUe1venRbLLgTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fpI89wRJcQ0IBMV7eDeNt+xTrE0IGW6EaZFXk7lxJQV0Wq41v6YaLxBUo3G12hIsoGGfbw6YxPqtV+dcpDyzMStGae60ebXEy3Zfhdzm2Pd1m/bOxAa48f3zk4vJuu9IFwlbm7MwA0PzbrPHkzMbP51rBrRK1Z01L7dJDJrBpdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TlF1HejB; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-76e2e8e54f8so1579367b3a.1;
        Thu, 14 Aug 2025 23:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755238730; x=1755843530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFjBsyPuuZBism1T3uUGuz3NQdntmw2nABEsJnLMNB4=;
        b=TlF1HejBsdQKoqyxUmBUoB4I4pEt2G3+nYUEL1piJh+9pm9zCNoeAFpuACet81y2m+
         7akhFXz93MFg1lGZShc5rKE7cj3HfUBaigQf6usrjhCCbkDTO+h/TpzO31ZBsDDvfDnx
         iIDRLcf3raQHAWbgWRr/FA6mNRnkuKay9AFAaEUrxg4Ku676ycIO3Kt8y5JLrSOX78H4
         QSFBkDu38pakY/QmLxKcGVKWReE/XoqodKmyLj3AGYRdOZMCv7pEb/xls26N5uRRkkHF
         +OWNBzaIHQqRTbQyE706AyAKPNq8YrgcYzExbkSMgfhaCR1FmCmNhuN5I91RLELZ+dTA
         ayXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755238730; x=1755843530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RFjBsyPuuZBism1T3uUGuz3NQdntmw2nABEsJnLMNB4=;
        b=cKwfJUZJ7w3UWs/lSzxgcDrrZir5EXzKYnv9xYW/UMRQXgCzX35Ys07+Eo/ws7CKQf
         eYCAf4Tak97nA3bNE+L0SYMsnq1Y+5FLsyPNe1koLeg7uOv5S+0qBDoFhJ4Jlrmix3ec
         e4WXjKHd9fhktVx3KGL1iIbEMC1bR83/QQUlpUHA42bOecbDLHc+0JRcaF6FRPnAx9rS
         wIDH3lAvhKJz84kkQuVPMSBakAssC56cAM8+WtHvmj+EqnUVSurp5tqP6R/WA7wnEOsh
         Z57sAzOT9uMqfKTybONZfcgjKaKAv4quDTxgVuiQrrB+MAx/sseVezVwZs9VnPBTMy17
         7gdg==
X-Forwarded-Encrypted: i=1; AJvYcCU4HVlyqu7Roh5VTi1ufNsBZnpIgKst71khkHTi0OTFnMWIM7zo84Bb2lUEuOICfBiCDqpPGx1MQWnGVLgg@vger.kernel.org, AJvYcCUlmCw1DeiNpzEW0YG8LhQb5mbzH/RE36GbVWq2qWPZ2AiHyIe0XtvB28e/1fm/QLgqYoM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Rpvs3TgbZUdff4DbCt050d9H/AEQjGXG2Iv6TEh78HqsMaKe
	U9o5dg0O6d/HO7Z8Qqxt41LSaWXwMQkPaDgdAk76CpTqQ9PdmjsR970A
X-Gm-Gg: ASbGnctBzmRTmBsYWpiZh7PtCdlaRH5XQhTkKSpRzQYTIJklkk+UlHk5ikOaeya9pbS
	qqXTuYKLXE/BaYwyK5K0L4DX089p86CH4et0LmKYE2vFkYRnwbg54xkooSEtAw7j78EWpc8+Af+
	Ttjj5Ryaf36ZjN0sCULqg2IZyAEAsxNnByBbxim5g9Uovc2nhHcLNU17qGIAM+ADG6yNmIqwmvu
	z3FEUYdqlfmrUvEO5zBxFEJ9yGy+YQv4Q/giuvmHPa7zVRK41qtKus+ks+L/nydVQ15gKv2dHgE
	SWcHyMj387/E1ahX1X4kiOk1HwG6POC/4H9/xKhlhAU7jVsfIkljhg0uj3RcoJ2LkGChnnDaPOE
	/Bj4hFEUPr6g0aFyx/d4=
X-Google-Smtp-Source: AGHT+IHGDVizASD9lmRNMdvyotuifXOUcouob918/gVKDUl8lbfI+jfgXSo9/j4zEPp6FtO0H17xDw==
X-Received: by 2002:a05:6a20:3947:b0:240:195a:8324 with SMTP id adf61e73a8af0-240d2d81728mr1606846637.2.1755238730153;
        Thu, 14 Aug 2025 23:18:50 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e4558ae7bsm408607b3a.95.2025.08.14.23.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 23:18:49 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 4/7] bpf: use rcu_migrate_* for bpf_iter_run_prog()
Date: Fri, 15 Aug 2025 14:18:21 +0800
Message-ID: <20250815061824.765906-5-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815061824.765906-1-dongml2@chinatelecom.cn>
References: <20250815061824.765906-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the migrate_disable/migrate_enable with
rcu_migrate_disable/rcu_migrate_enable in bpf_iter_run_prog to obtain
better performance when PREEMPT_RCU is not enabled.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 kernel/bpf/bpf_iter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 0cbcae727079..25feb93d44a9 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -706,11 +706,11 @@ int bpf_iter_run_prog(struct bpf_prog *prog, void *ctx)
 		rcu_read_unlock_trace();
 	} else {
 		rcu_read_lock();
-		migrate_disable();
+		rcu_migrate_disable();
 		old_run_ctx = bpf_set_run_ctx(&run_ctx);
 		ret = bpf_prog_run(prog, ctx);
 		bpf_reset_run_ctx(old_run_ctx);
-		migrate_enable();
+		rcu_migrate_enable();
 		rcu_read_unlock();
 	}
 
-- 
2.50.1


