Return-Path: <bpf+bounces-54409-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEDFA69B89
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 22:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 595BC1772A0
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 21:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D756021CC5F;
	Wed, 19 Mar 2025 21:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lf+DZ4+w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0416721D3E3;
	Wed, 19 Mar 2025 21:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421258; cv=none; b=EdFgGX82jVXqWNpxRZcT+Fxt/EjhwIHCj5V7uN/RtoTrnJUSaRH+63VHxkhncevmxx1MVA49zaaFV2M6406BxlGiTTEAIwJYX0AVS1Oju1kduY1f0RdyOHdRJXff9KR2kHS+LacCDW4ulF5iLUY/d/0e3oe8sWh1FXd+abhglO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421258; c=relaxed/simple;
	bh=89/4mUJpr9aktknNh0PQoqcLMbO5zSd3Gu5eTVqHXXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pud10EO79GsoPAEP6nEumkvwHM3NtROOHawrPBz9aUzv/XdR2OPt9hefMBPCZZbSJvfdCmplprOA5xRVOCToZwAeCEgb2x5DWkJLrSjrbyvb84MwhR4P9+/57EciDu/IE+tQF6EcJyciBaNohTKioHSB1QLEQMvkfGnZlg6pTvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lf+DZ4+w; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-225477548e1so915125ad.0;
        Wed, 19 Mar 2025 14:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742421256; x=1743026056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7Vh09nD0sM/32Xv3BcGHrqGV2e/Cdvu6uqMumBsx/Y=;
        b=Lf+DZ4+wkzRif/I/tZOTeRTwgKboi2QkikMO6aZRlSUuqqf2jYe39LA7sjbp5qSQot
         2KlNMBlqxqShYtshr2f0jcSsma5CE4yJ2F/Sn//JkaDZCGcvtpLzJRykLpcBRuaeee26
         7df6aWcegF8plwaBg1kK15zCDRKkuZKl1jpuUDObdKG8QcEhGyyUcfvnuAHllqIzb8i7
         HK9aQDtDnUsEmmjrPBGvkQI9O10V3Tk+MtrwE4DOHHUSoYHuHSo+xHMiMLLg9gWg3nty
         1Yw+3ALVBgud0eLzAg6zOplDMKWNcdOYaVC8oEuq3hdm/8M7RILo/4qsub8FBBYEkW2/
         n3+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742421256; x=1743026056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q7Vh09nD0sM/32Xv3BcGHrqGV2e/Cdvu6uqMumBsx/Y=;
        b=NTUUby5m11N6hlCUqYsZYFDr8Z7OC5LycFd4PTRgd0NH/OdhE9UrcGa/Z3VVSIqcn/
         40Ie11VoCFIkGoDQwa13/nRPA7s07sungnzSw223IEirSxZlVJuYMLY/oI7jEcNrwiam
         9RCTNmHu+vvjCu+tlS+/PjFDhsYW8hiACYd3NqZnXKr4J/+7fQyiq4Jv1Sv8MBE9vaJc
         hnNVaigDbLQWILvebjae7HieHjINNRf7azDy2lq9kpNpQLsee38pKz1uhomYWrgKkudr
         /xfLsYjFm4/h2lE++zVIE1Y96i8g3segS6dEIKTk43m53nRPf0Yq3rQfmjiOiTwK+zEv
         ZmHw==
X-Gm-Message-State: AOJu0YyM4R72cnxJjakwjt8E7RnSOA4rLUuuoeQFeiy/cA9zo4Orp47J
	jvwfPRtGFC+dTKFZOjTR+kCqppU+uUbqiLbo7PC8H/dFI6Ip6HAUnQ5Ti+yBLcY=
X-Gm-Gg: ASbGncukp3JM3qkiwh0iF7aU6QPw0bhW3xAosTOi7kL/OCBHNewF7yRJilYjVEdok5n
	FpH+XsmywmrYRu8SpSEbrRSwpVEWEhBtbW+1hSPsFwm8Wzb8CbDHzI7vW6Txz6qDx9XsuyVuDHB
	WKRdDLQa8ZUusBHesczrGelC6r83KbwS7BSw5fhX0RhsuPBO4OBHVwkOCyWJK8LovF+imkttEkq
	+uND/4AzyEtCP6RBloP210MxX57NaHKUIPLIAgarMh0TylPGu8/0YaBLPFmOeWtMz7Be6YChwDi
	PgEqjZUq0JOfWJpPzqzCTWYe7ybDoFgT/c8Exnes8E3XFojfC9C5C45DLdvvNyM+b4lqvfBiuog
	k52xz7mi4zwquKhBw2sc=
X-Google-Smtp-Source: AGHT+IHMH58rimYFPQittMlW6vY4qxGMd/J9nQYfitscTC+ih6WzJ6VtOu6g2LG/lIppyBTOLifZVA==
X-Received: by 2002:aa7:888a:0:b0:72f:590f:2859 with SMTP id d2e1a72fcca58-7377a869447mr1250761b3a.13.1742421255969;
        Wed, 19 Mar 2025 14:54:15 -0700 (PDT)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737116b0e8asm12175596b3a.158.2025.03.19.14.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:54:15 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	kuba@kernel.org,
	edumazet@google.com,
	xiyou.wangcong@gmail.com,
	jhs@mojatatu.com,
	sinquersw@gmail.com,
	toke@redhat.com,
	juntong.deng@outlook.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v6 06/11] bpf: net_sched: Support updating bstats
Date: Wed, 19 Mar 2025 14:53:53 -0700
Message-ID: <20250319215358.2287371-7-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250319215358.2287371-1-ameryhung@gmail.com>
References: <20250319215358.2287371-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Amery Hung <amery.hung@bytedance.com>

Add a kfunc to update Qdisc bstats when an skb is dequeued. The kfunc is
only available in .dequeue programs.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 net/sched/bpf_qdisc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index 5f4ab4877535..5aff83d7d1d8 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -254,6 +254,15 @@ __bpf_kfunc void bpf_qdisc_reset_destroy_epilogue(struct Qdisc *sch)
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
@@ -264,6 +273,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_from_skb, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_qdisc_watchdog_schedule, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_qdisc_init_prologue, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_qdisc_reset_destroy_epilogue, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_qdisc_bstats_update, KF_TRUSTED_ARGS)
 BTF_KFUNCS_END(qdisc_kfunc_ids)
 
 BTF_SET_START(qdisc_common_kfunc_set)
@@ -279,6 +289,7 @@ BTF_SET_END(qdisc_enqueue_kfunc_set)
 
 BTF_SET_START(qdisc_dequeue_kfunc_set)
 BTF_ID(func, bpf_qdisc_watchdog_schedule)
+BTF_ID(func, bpf_qdisc_bstats_update)
 BTF_SET_END(qdisc_dequeue_kfunc_set)
 
 enum qdisc_ops_kf_flags {
-- 
2.47.1


