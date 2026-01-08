Return-Path: <bpf+bounces-78262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C18BD067D8
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 23:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38FF6305847A
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 22:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C9A33CEB4;
	Thu,  8 Jan 2026 22:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jCbnL6gW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB21322C73
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 22:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767913013; cv=none; b=CHybDaYBXKcZus8O6gx/CL0SX6qw1BAAZrXwR+f+J3MlpioVhb47Xc3GBbzGyC0XnO/KbcnrciKrNoEGsqTkSXnQFUHyYKbnqxxHHkZhSEuAlxKeNkybSbUVUv9YLkj/NkIyszovzX0kQzrP9r5CdRYXJimV21BWXOnzY6nfyjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767913013; c=relaxed/simple;
	bh=kuVmwolLprvgFQC5gK2CvP6uE4+/Xs3CDYIOcSnFIuI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sZ+g36/I2glhLyvuLike9DkbZ3p/LVWicr0WwRZMFRcEY/RlZ3uHwWPkQjitjHk7H7VQy7U3XXdb0wnoE6rz5K9gyIdwjZBvPoD7cRBrE9uSXKWWhd8PMrw1z4H0rQp/QowK9D2bmycjTJRpVVvLXvTkbctUUcbm/9OfIIFg0gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jCbnL6gW; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-122008d48e5so1761086c88.1
        for <bpf@vger.kernel.org>; Thu, 08 Jan 2026 14:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767913010; x=1768517810; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CuaylGKmhlV4n+kOnxwaacUMm3XMBF1qN/OxctemuKo=;
        b=jCbnL6gWyHuDCKcaPrAAtyioE9hZB9mzzsjjpJfXVpFFlBrH3VPv98CY0IeeWCkgbh
         EvJYr39s8LfREbVC9B+1hCJ1Nk3x0QzJE8MTaDC2CgWRlEt7bl7ZR79s43q9b4rh6wng
         rGzEnwApZXrWlU1X1LCVdSYB6mgBsnZ/MXkdIksl1iaF6MpWQ3hS9HAOuaZWwxJtdsGd
         JKbJwLGYY4iSDIS303QQGNUmQGuCGSyMVTTfGi99QxPWIR4gSzu3GxnflfeRGhb+ktS4
         5/7fxTD7ScJcD3U8zNoktpZGrp7Ypz5kcSpNc3UM5gMPRplLaFQC4nTS6Qw50/wYW7tP
         hHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767913010; x=1768517810;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CuaylGKmhlV4n+kOnxwaacUMm3XMBF1qN/OxctemuKo=;
        b=EJUxg1A6BFnAaZixxOE7YozlLr3xvkZrf37bDWIJeVEza1ZIUgg6ezVm9kWb/imzXu
         EAI+7p9eFHAYSWwtZqg8dqdM6upuLpdmBlGogHPXHlGx9iNhNncUUHH7SMfAnefdWsdq
         QajSTtTg02mxoumsrl4MFMjuFj2AROnumt1XR6LdVEXmnVcTFNNelzVj5cxXYbXkp6e0
         lOTuIqSiR1uZuWUwuGF/obtp2AKSL52XC4HR7nG3aQj2CXbfr9adIMD7YrLZm4ad8FIR
         hoYTAGOHywihjSQLgqoetjbI9BUvw07kdifYaY8aC669DJwbY1FBRL+Ghuq+zod2Pn4W
         Z6Bg==
X-Forwarded-Encrypted: i=1; AJvYcCWdGCiN/37ba6aI7N4RJMCtGyS7N2Xa4XLAns8Gp6R7h8FWMUY7lCRbDFPHJdMK/KLJz/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF1M8BvK3M5mC/ym3fWlJEU0Uu/efSj6RKsq+R/i1gefjfOo3X
	s/sZ/mR3tburIDNZAsaVEP1xsGPM33gQUGVG54by0oS/P2WCE5wc0UUi00oXhViAGqyoSsSH50x
	uj5Xt1dOrhaF7mQ==
X-Google-Smtp-Source: AGHT+IENQBlDEvxTyqSWqxJtIK7u6/aN3XKMd1H9vZCTl6QBchXevnwExPMON9th5RerMP1jT6OOwF5oFTEgqQ==
X-Received: from dlbcf27.prod.google.com ([2002:a05:7022:459b:b0:11d:cf87:f4ee])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:ff46:b0:11e:3e9:3e8c with SMTP id a92af1059eb24-121f8b9e460mr7435141c88.49.1767913010038;
 Thu, 08 Jan 2026 14:56:50 -0800 (PST)
Date: Thu,  8 Jan 2026 14:55:19 -0800
In-Reply-To: <20260108225523.3268383-1-wusamuel@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260108225523.3268383-1-wusamuel@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260108225523.3268383-3-wusamuel@google.com>
Subject: [PATCH bpf-next v2 2/4] bpf: Open coded BPF for wakeup_sources
From: Samuel Wu <wusamuel@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Samuel Wu <wusamuel@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add open coded BPF iterators for wakeup_sources, which opens up more
options for BPF programs that need to traverse through wakeup_sources.

Signed-off-by: Samuel Wu <wusamuel@google.com>
---
 kernel/bpf/helpers.c            |  3 +++
 kernel/bpf/wakeup_source_iter.c | 34 +++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 9eaa4185e0a7..ca34d7614c3a 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4518,6 +4518,9 @@ BTF_ID_FLAGS(func, bpf_iter_dmabuf_new, KF_ITER_NEW | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_iter_dmabuf_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_iter_dmabuf_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
 #endif
+BTF_ID_FLAGS(func, bpf_iter_wakeup_source_new, KF_ITER_NEW | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_iter_wakeup_source_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_iter_wakeup_source_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, __bpf_trap)
 BTF_ID_FLAGS(func, bpf_strcmp);
 BTF_ID_FLAGS(func, bpf_strcasecmp);
diff --git a/kernel/bpf/wakeup_source_iter.c b/kernel/bpf/wakeup_source_iter.c
index ab83d212a1f9..149baecfe436 100644
--- a/kernel/bpf/wakeup_source_iter.c
+++ b/kernel/bpf/wakeup_source_iter.c
@@ -90,6 +90,40 @@ static struct bpf_iter_reg bpf_wakeup_source_reg_info = {
 	.seq_info		= &wakeup_source_iter_seq_info,
 };
 
+struct bpf_iter_wakeup_source {
+	struct wakeup_source *ws;
+	int srcuidx;
+};
+
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc int bpf_iter_wakeup_source_new(struct bpf_iter_wakeup_source *it)
+{
+	it->srcuidx = wakeup_sources_read_lock();
+	it->ws = wakeup_sources_walk_start();
+
+	return 0;
+}
+
+__bpf_kfunc struct wakeup_source *bpf_iter_wakeup_source_next(struct bpf_iter_wakeup_source *it)
+{
+	struct wakeup_source *prev = it->ws;
+
+	if (!prev)
+		return NULL;
+
+	it->ws = wakeup_sources_walk_next(it->ws);
+
+	return prev;
+}
+
+__bpf_kfunc void bpf_iter_wakeup_source_destroy(struct bpf_iter_wakeup_source *it)
+{
+	wakeup_sources_read_unlock(it->srcuidx);
+}
+
+__bpf_kfunc_end_defs();
+
 DEFINE_BPF_ITER_FUNC(wakeup_source, struct bpf_iter_meta *meta,
 		     struct wakeup_source *wakeup_source)
 BTF_ID_LIST_SINGLE(bpf_wakeup_source_btf_id, struct, wakeup_source)
-- 
2.52.0.457.g6b5491de43-goog


