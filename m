Return-Path: <bpf+bounces-64560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F17BB142F6
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 22:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 577777A2952
	for <lists+bpf@lfdr.de>; Mon, 28 Jul 2025 20:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303D527990A;
	Mon, 28 Jul 2025 20:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v7vC3+tD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F68A27A928
	for <bpf@vger.kernel.org>; Mon, 28 Jul 2025 20:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753734428; cv=none; b=X0yO7/s0vz37FacA8VIVA+gS/u4OqyPFdhiXSXBODaGKgWVSKe+hp5kpF9+RlQ9trpmp7f27Upe9pUb3om9CCmWvM/YG+BYOK0sAKyHM03dmK2LIZ9nzjpifSZttStQcKG3FzNAJcsFhjV0s0fZNM3Cl5j+Qo/q6jmcFw5IUqe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753734428; c=relaxed/simple;
	bh=ktAlH1M1bwslpXGeLgOgITzIdzrVmjtd8hLrz38oqVA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U/6m3wrHOTWw31ywIgSnZEnlBpQZCl9EByd/p+q04bYTpjEckOMXPIhLEttYnFrlvuY9ijD7kgzNMFIGtsBku/FB3JQCmwQ+HqTixCcZOUREYypGUrWEWy5yZtqoXt/VORkXPDg5qEIJNhv0mRFlBrnmAJK2qDfabnVNHeCmols=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v7vC3+tD; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b2c36d3f884so3530020a12.2
        for <bpf@vger.kernel.org>; Mon, 28 Jul 2025 13:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753734425; x=1754339225; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=I15NAgyj4G+O2vviAcC/bqIuOaat3gPUhwCYB7reS1M=;
        b=v7vC3+tDqjWKK7n9f+ZYR6n8z2rv4hMWeWWn5cqALBpWIeyDFnqAEXTED1TLHLh+hQ
         dt/YYsiFJNTzA3RKPixhgBCItLX7LYSavlArkkY8c8zUKAlr9OtetWwfIh7cFm1AzM3A
         zP5GAigWR8bdA0xxGg2t4dVgMN0HATpnLOfO9/3WWq5o3XDydDb6f9piO2WWqp0PO6DF
         kHe5v8tB5nSdtIqBefnT1AmUV0nOAz3D+S0rxexrY0vYUnQHcsoer5DpaRbq4BQGOFb6
         2H/UxvyfluH70/GNci8m7ySKt2oqDZ5VXFbMEq4Flr+bezQwAuiupdmYn39HwGxTNXQk
         ESfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753734425; x=1754339225;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I15NAgyj4G+O2vviAcC/bqIuOaat3gPUhwCYB7reS1M=;
        b=NPKFkZMhBDvkKsDo8Zmd2/fGzrdkomPNlmfyhZf3AAw0NqRW+Lh4SJOk5C1RA4tb75
         amYNUTBe8Co5bBzyfAnlSVJa56bQbFxFGfOoS/shzmfrTEJzNqVldxXeSRUEgpvA5LTJ
         IJ7TqJ+V86T+ggQHZfRpV67PenqSJYNHG8uEWvse+SgT6Q2UwsWSiNmHVRrKwYYSmcCF
         GHaynslESto5eAjcXosAJEK6PPGuRLpjQ0XZ+hskCsmy7/t0FEpkWF98W9CD1qZJ79Ve
         cjvPfK7wZE1Qj0Jhs3kXoAJ5DiP7VQwB08fA+E7ZzkR+wQwt9AX2v42/Kg8UkvNn0Ag/
         3Thg==
X-Gm-Message-State: AOJu0YxcXmPz0nqzERmDBoMrAUTKOPwvbHWcAOK2oKGVOVBt3+9Mwn96
	sdQkzyhBjQAIHG6P5dPkUbWCrDgnHiM9kdL1u7/6J1GoNwKFx3vS3uKQ6Xazb7bxmd399EYNm7a
	A+cTJbW5qhHm/N/ZJQa8hcXv/Ykg/Bq3MwXWfD1jwCrPLVsLytqy/Mpv1lIPR2SD3jCdLEx1dgA
	5YgSLBnBvkpttGyGhgiFyuv9j0oBRgJnnBTxSwUQeoDPil8CLMOdN8CZ93sDTqMo/d
X-Google-Smtp-Source: AGHT+IE9oi+ffPcXx6AWpN5iqCz37jlrkj8cFjHkHGI/j9wSGEXIJvDh1Xjdzq2liHFVloQZS+o9kxScpZhIDXhx+WI=
X-Received: from pflc4.prod.google.com ([2002:a05:6a00:ac4:b0:747:af58:72ca])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:a49:b0:23d:798b:d290 with SMTP id adf61e73a8af0-23d798bd3e6mr16913294637.29.1753734425520;
 Mon, 28 Jul 2025 13:27:05 -0700 (PDT)
Date: Mon, 28 Jul 2025 20:26:59 +0000
In-Reply-To: <20250728202656.559071-6-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250728202656.559071-6-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1397; i=samitolvanen@google.com;
 h=from:subject; bh=ktAlH1M1bwslpXGeLgOgITzIdzrVmjtd8hLrz38oqVA=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDBntd4Ukn0y/9qCzwGzzswmJXyTyGp7qBx66Ism8R+D7X
 6+HLkk/O0pZGMS4GGTFFFlavq7euvu7U+qrz0USMHNYmUCGMHBxCsBEAiYyMjxi9JgdvK3x4tZb
 ++ZNeqSj+437kfkqzf8NColvf7v+XL+a4b/3WlNt3vIFcjNKeFktr7Xaf9Gf/k7nunm5ROKrrVO cOHgB
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250728202656.559071-8-samitolvanen@google.com>
Subject: [PATCH bpf-next v3 2/4] bpf: net_sched: Use the correct destructor
 kfunc type
From: Sami Tolvanen <samitolvanen@google.com>
To: bpf@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

With CONFIG_CFI_CLANG enabled, the kernel strictly enforces that
indirect function calls use a function pointer type that matches
the target function. As bpf_kfree_skb() signature differs from the
btf_dtor_kfunc_t pointer type used for the destructor calls in
bpf_obj_free_fields(), add a stub function with the correct type to
fix the type mismatch.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 net/sched/bpf_qdisc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index adcb618a2bfc..e9bea9890777 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -202,6 +202,12 @@ __bpf_kfunc void bpf_kfree_skb(struct sk_buff *skb)
 	kfree_skb(skb);
 }
 
+__bpf_kfunc void bpf_kfree_skb_dtor(void *skb)
+{
+	bpf_kfree_skb(skb);
+}
+CFI_NOSEAL(bpf_kfree_skb_dtor);
+
 /* bpf_qdisc_skb_drop - Drop an skb by adding it to a deferred free list.
  * @skb: The skb whose reference to be released and dropped.
  * @to_free_list: The list of skbs to be dropped.
@@ -449,7 +455,7 @@ static struct bpf_struct_ops bpf_Qdisc_ops = {
 	.owner = THIS_MODULE,
 };
 
-BTF_ID_LIST_SINGLE(bpf_sk_buff_dtor_ids, func, bpf_kfree_skb)
+BTF_ID_LIST_SINGLE(bpf_sk_buff_dtor_ids, func, bpf_kfree_skb_dtor)
 
 static int __init bpf_qdisc_kfunc_init(void)
 {
-- 
2.50.1.552.g942d659e1b-goog


