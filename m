Return-Path: <bpf+bounces-78454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 867B4D0D340
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 09:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36378304C6FF
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 08:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C622C3259;
	Sat, 10 Jan 2026 08:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QF+nyUKQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C4A2EA151
	for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 08:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768033564; cv=none; b=c0dNzuawCccGLfU5jkIMgtKlUo2pS8phDuGEA/Esxd+aQ3TTLgcFFdy0RiHWlGuQdLdwXJ9HcT8xl6Smy0g87ZbQ54y4gFSWIixG2tQoSmCS7Cm8v1xvaKKo+2kTS3HjJpcAhuCwx8uQ/1oHNHe4gqokL8oMBOi4kMiCOm9Ogbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768033564; c=relaxed/simple;
	bh=RBrjhm4+4Jiaj85vSZsjK0QkF6TyPfp4BVqBMhLxtnU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aDo8UbVbL04tdo+0HeZuPDFevlzWY6On7lMYTqpJnP1NSF8lqu7Y+4F75cdakqCoXDpImwwzwsCs8zWag8vbO2t66ObAxbe3pDFD1Ex+elzitvKPiLTrj/gK3kvnCOOoxhN0lcvv0cVvxsUMKlytbedd777FDKUat4BlFwQQowc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QF+nyUKQ; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ae26a77b76so5281389eec.0
        for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 00:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768033559; x=1768638359; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o0bY835EK0LGkX/hoGkquZtOPtlX0pdafRbSWsGphjk=;
        b=QF+nyUKQrIbExsjKfBgUjZSEwsMhREbdW0a7sCgC7nd6QC93K/0iFf5GKjS4VozPkB
         CAv/Zq/7pzlO2lZUMGamcsEbpJcmRlN6Mj6ZCO7CgDr+lN1NHlAtdQmUjMc0GDqbuXA+
         RdQ03dBwCMPInuHkh02LbvOMzeDAGYBlTetpv536LmGCK/ZqVQWo30knZUgChRDLnJ1F
         ReNZCabvGvsRpNGze8WA1pjfgdhvjZaPRZYKVPmQxRDFGDtw8TEgDW37fQWuIkIl3/qe
         L/I9Ho3hkDUMPrr+1uloF3w7IMjd5kNuOI6byGWsUtV3GLAaV0hnOEH2Ay8mMlIcUNZs
         blxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768033559; x=1768638359;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o0bY835EK0LGkX/hoGkquZtOPtlX0pdafRbSWsGphjk=;
        b=qyUp9XgN27GPK5fVG+VSr1Qz9hnxtkDmwZiu2HfiSqN/GtIbwx8Qd3ie6anXAndmdf
         NPFa0vpaXlmi3+/pNZbO5HgMYoytM8W9NOXOT+X6zHH4QLHSiSJpqZ8NmyOawLZA76tq
         3KbxgTDAxWKOSR/S+roiZOGu+vOpEG4jtO3rei3y06H+ioF+8BqMHRMVRSxGeKqncnD6
         clhxVMojY0lfbELOBsIxw0qXynGWCaMxB1tnNY9+z1jKpv3AAnXQDbSO1O0kda9/uVeC
         Df/sNXK9tXKEj4IMvtbRApPuxMu16g4oUAdxJYgfaXS3LlfaA+w1Q8/PYPM6asoBq9KT
         gR+w==
X-Gm-Message-State: AOJu0Yz8BXJ7B3mbRHQucje5fMMJZwcj6yOau1Jql4a1Q3fRcU4vpAcH
	y0S4wEVCzJf4BJQ8iJXEOV2JjItznWXaYtKqLvvaKL0IVfPfSVeO24UXDS4FPPF2u9KQm0gVnCY
	Z3k1Hxnr4seFQSkiKHaLHaYrbZIHB19f+1CaTouQun1IvLTI+RYRMEskNVxwIuUItiuGGbI+VKp
	9qry45u8C7SeYnUm2zuLMpEyCMI0FeffXkpdTQN2ZaZ70OB3MSHFcgUNGs4fKATEWB
X-Google-Smtp-Source: AGHT+IEdcJWR4YOxzDo/NKDA6fPe/N9NLHlDvsILubDvbMVZVeq/7iKvCaYf/wOLOjsHjs6CFpc094XqH7BWVgqvs10=
X-Received: from dlbeq5.prod.google.com ([2002:a05:7022:2605:b0:123:171f:e390])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:6b8d:b0:119:e569:f60b with SMTP id a92af1059eb24-121f8afc1e3mr10377485c88.4.1768033558494;
 Sat, 10 Jan 2026 00:25:58 -0800 (PST)
Date: Sat, 10 Jan 2026 08:25:51 +0000
In-Reply-To: <20260110082548.113748-6-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260110082548.113748-6-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1442; i=samitolvanen@google.com;
 h=from:subject; bh=RBrjhm4+4Jiaj85vSZsjK0QkF6TyPfp4BVqBMhLxtnU=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDJlJvHw3K1dx39tx5gGXQc6c3c9Od9Tr+kysmbamaJ3lu
 +OHy2tXdpSyMIhxMciKKbK0fF29dfd3p9RXn4skYOawMoEMYeDiFICJrORi+B9wLjq9j2VB6Snt
 CFHv8MMnUnlrPz8R2tXscdh1UdCBIDVGht9T7p4KeRv9//iENDZbY4lz3/fI3Zna++Zv7qKZBXx 9b3kA
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260110082548.113748-8-samitolvanen@google.com>
Subject: [PATCH bpf-next v5 2/4] bpf: net_sched: Use the correct destructor
 kfunc type
From: Sami Tolvanen <samitolvanen@google.com>
To: bpf@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Viktor Malik <vmalik@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

With CONFIG_CFI enabled, the kernel strictly enforces that indirect
function calls use a function pointer type that matches the
target function. As bpf_kfree_skb() signature differs from the
btf_dtor_kfunc_t pointer type used for the destructor calls in
bpf_obj_free_fields(), add a stub function with the correct type to
fix the type mismatch.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 net/sched/bpf_qdisc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index b9771788b9b3..098ca02aed89 100644
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
2.52.0.457.g6b5491de43-goog


