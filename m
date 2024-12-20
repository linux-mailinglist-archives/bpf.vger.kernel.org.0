Return-Path: <bpf+bounces-47476-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C22869F9AD7
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 20:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D0007A4117
	for <lists+bpf@lfdr.de>; Fri, 20 Dec 2024 19:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1DA2288C6;
	Fri, 20 Dec 2024 19:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D252skAF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0AE227BB9;
	Fri, 20 Dec 2024 19:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734724599; cv=none; b=uT3lQDPa5k9pe1GENAeee+4Ih5gCCIXw50lGvs8kyCacXKfUQ3asYuTpCw6l51gCKQCpQftsvPRLaMYKbI9d9NsIZxt7Zb6crEOZynVXaV7HNj56RaqPWcxLQBuGqmzqw5jWTLl2QZM5xlCfZZjFTt4/SgiTID424HCsVWibDig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734724599; c=relaxed/simple;
	bh=bJ4fRTQDsJLP+TAqkbvy8ATF64cWWM0drr4CpUrcOHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pf68XJriguzfKFNo1vrjLb76P7mntfV5VAsuC05sf04uwGJpaqJ3ka/yVkpBRU6U47042pK8FGedVMzmHZs+C3i+4IV4vZypfiWSdl+v0U5V1kFUSf13ONNpMF3Z5REVHCH6CDVb07ik3LC5fbStapoFwM5eFmZ/ShU3kN20w3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D252skAF; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-728ea1e0bdbso2239767b3a.0;
        Fri, 20 Dec 2024 11:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734724597; x=1735329397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFyFpVy1vmyR3zXTCfx76JfAwKafHxDwBgzFEvy/ujc=;
        b=D252skAFeuHFRndOTfnS4K9ar+90Jk33B2xA3jwskFo8sGuig7EYu6RsCsbZbJyqyj
         nKXlrgTasGD8yWALYBkU3fOHYICnSnT5cfhDH6G1SIOC2pktapVHS8E5gvWeFjkTp7MY
         xSfxZDo3HnC/otgvWW5gI8YTVDrSeDF/KP12K2Q8FncKYgtmSqvwp60+EcVSSzgtJiZs
         LW0/ScewONv8iKO+l9Q/tZyAus26Nr0TOZaCVg7A/AgUmTF6mqFAH5wtJ07RuMl/qxSL
         1boqdOPTE3K4s/fcXIQHqCSm+lILNsT2ub8/qlvacY9g2Fh+oVH5+rWOk2hw84GIbAx8
         km9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734724597; x=1735329397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pFyFpVy1vmyR3zXTCfx76JfAwKafHxDwBgzFEvy/ujc=;
        b=TEiGOsJVYHuR1XNTSASO1v6xU3+HnFZD+ungQc4aqMH/AsN0fWd0a22yThX0UgYI+j
         7YCRj0gIM9phSBqlUX2oCclMa6iU4vb8dr8+VHE6RLcEbRQot6txpyQykuIEjvoABAIR
         Nxbn0XjCeeLMCYFDr85pArf+oRamQJZ9HQfrwPffIB7FZzbnVS1bMqOuu7/8NLNHNGxz
         loXLsgKc9E5LR1npHdkJPpofcnHDPXmCvAFgfAqzeV4c6RaXxO5cjMHWUgKIaTKi1wHA
         XwxRTMYEXXc84QSkvqWEWjgwzU77KbkQb2Vt/780amJWMS97lsa80KQM7m2SK+ewA+4d
         UYow==
X-Gm-Message-State: AOJu0YwEgV+XDzclXZE0hverxuMHtMFOgSz4hDIMZkJJu8ALhX8u781O
	CeEZbmbhF+VRWwXFf/wZrlQmjy4zFRRaFQ4os9k7ixIbN/oNLsB1Ev53Aw==
X-Gm-Gg: ASbGncthTmT9z+OFSrqwMsEaRffyrcI8HbVhsyEUdiVHQ58b8y/4GNk93OWPbpg6g5H
	TpqDnZ+ILUXrR26micMhjl/5TnBw1okMeSXtC4OWEtXS4tHC0t5cHBcSisi/DdrtF23mLuL7AVN
	QluzV0UrsZ6iBysLvS2OjhNYoEg9pqKpNr4UESKp/Ma0BSTg5kavrMFZ2s+ypBAaAKTqjOXc+bQ
	SjUpSDIY9+cXxYSJJj7JldZVAuVXOrpmLeHDCsSkXm3q2qRd5mZzcNHISfSWxcXQog6x20+SFPA
	yX4uyzw4HUSbiAdMnPVaAKviNQTXz1KP
X-Google-Smtp-Source: AGHT+IER6AZe7MjnhGMPynqqes2HIr6gfFCPX7hGgmJQ9JUs1nV8DmF7k11hW3eHKR8q9+3MfcLpVQ==
X-Received: by 2002:a05:6a21:900e:b0:1db:ec0f:5cf4 with SMTP id adf61e73a8af0-1e5e081c8bbmr7501500637.39.1734724597307;
        Fri, 20 Dec 2024 11:56:37 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842b17273dasm3240342a12.19.2024.12.20.11.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 11:56:37 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com,
	amery.hung@bytedance.com
Subject: [PATCH bpf-next v2 09/14] bpf: net_sched: Support updating bstats
Date: Fri, 20 Dec 2024 11:55:35 -0800
Message-ID: <20241220195619.2022866-10-amery.hung@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241220195619.2022866-1-amery.hung@gmail.com>
References: <20241220195619.2022866-1-amery.hung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amery Hung <amery.hung@bytedance.com>

Add a kfunc to update Qdisc bstats when an skb is dequeued. The kfunc is
only available in .dequeue programs.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 net/sched/bpf_qdisc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index bbe7aded6f24..39f01daed48a 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -210,6 +210,15 @@ __bpf_kfunc void bpf_qdisc_reset_destroy_epilogue(struct Qdisc *sch)
 	qdisc_watchdog_cancel(&q->watchdog);
 }
 
+/* bpf_qdisc_bstats_update - Update Qdisc basic statistics
+ * @sch: The qdisc from which an skb is dequeued.
+ * @skb: The skb to be dequeued.
+ */
+__bpf_kfunc void bpf_qdisc_bstats_update(struct Qdisc *sch, const struct sk_buff *skb)
+{
+	bstats_update(&sch->bstats, skb);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(qdisc_kfunc_ids)
@@ -220,6 +229,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_from_skb, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_qdisc_watchdog_schedule, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_qdisc_init_prologue, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_qdisc_reset_destroy_epilogue, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_qdisc_bstats_update, KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(qdisc_kfunc_ids)
 
 BTF_SET_START(qdisc_common_kfunc_set)
@@ -234,6 +244,7 @@ BTF_SET_END(qdisc_enqueue_kfunc_set)
 
 BTF_SET_START(qdisc_dequeue_kfunc_set)
 BTF_ID(func, bpf_qdisc_watchdog_schedule)
+BTF_ID(func, bpf_qdisc_bstats_update)
 BTF_SET_END(qdisc_dequeue_kfunc_set)
 
 static int bpf_qdisc_kfunc_filter(const struct bpf_prog *prog, u32 kfunc_id)
-- 
2.47.0


