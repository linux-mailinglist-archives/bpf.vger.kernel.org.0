Return-Path: <bpf+bounces-57280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0416CAA7AB9
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 22:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A73E09815EE
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 20:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E74200112;
	Fri,  2 May 2025 20:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfD8cRtG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7336B1F4E48;
	Fri,  2 May 2025 20:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746216988; cv=none; b=krsQw5yzrrPlOHTMQqI6TpBlm2fjkwMk6+qSdQP9qWLZPeCVbJprvIVBLbG3RdPfmaXMedUSNnUa39yFJqjXUCH10LEYWGlta3tO1izu392OmCVwLQGwDBX8v8I1pgplFE8JScEJtavdnXMyuEethacqmbt+DHPmRwDD1D2gnuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746216988; c=relaxed/simple;
	bh=mx3eC8ta534+w5IvQAC/RI6rZI9V0x99os2K5CgyPFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PxG5+gYZm9SZTQrYlmh5S+6nGzom0orkXKQsBx6zDmmT5VcywxwstwsGM23hmSnwtBoX4jA7IvYHFV2nrnVPwbHZ4tGr+51aWJZLcV+g/HEJMOVJSrdDB86yqdw8/si9ASpdeQDv+G0sjDlgIq54msizmpKefIF/FsBcZdUnaOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KfD8cRtG; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-736bfa487c3so2419363b3a.1;
        Fri, 02 May 2025 13:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746216986; x=1746821786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LJc6UxIt2ePjgnBTAhbKzmmYXMNfTJKhg/U6k9Nru0w=;
        b=KfD8cRtGThvrbFeOqyKIyIr8O++C4T8byJqkrXHCk7SFwdXhu+WZUSzALO4IjtccRp
         oqMhREmZQBNGIyPcxaGfDd/T9E1TcRW5bjzh5JO6UQP0QJmXeuu047r0lJj+31WnkgEL
         CFHYkSnHH1vDGvCEiM9ikk1ONkTJ98w6BrnT7dXo1NSodt8/D6vKXgMbOX8qgMQz9TC4
         cLP7EQKm2whfvbb9u6TK5WlTlG01SmeOo2drYZkihSQoHrZJmBx7CxJgxWjKNaA4KVmA
         fopW7SZf0cKId67XfzgZUqNO+fNKA0as9/xYkwRWFDcp9zhdHF7hEurZ+LeI/ZyJysJI
         icvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746216986; x=1746821786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJc6UxIt2ePjgnBTAhbKzmmYXMNfTJKhg/U6k9Nru0w=;
        b=BbqaaYjL6k/iyQltsUXW/4N7N6+OhFGMKG/Yy85enOOSFswxyJB3Izg0lwcARP1OhJ
         +8LMUgogbYTHeXdwtwBHPVxREpICBJufS/xm0LY/7Z58cohfIPTR9Hqkz00mc/dO7StT
         RPxPmshEuSzpwX+VezmJSW4hV4LfXugNimWR27egn6NBMyoESXs5nrEZhp7YScIYNYpE
         30hZ/Pb9t1sRfPCY8kXPcBSzBJkH1wSsVDo4SZTW6taSFnprleE8DceiVUsuTExC+4bH
         Zn+hDf1scsBBjCAe73/IGcu9VfEVNW5bWFvdoQ9mt5Cfy7+AnPSWNWIwynv7Glpyiuqx
         s/0A==
X-Gm-Message-State: AOJu0Yyz2+Khrq0WHIhAfdc9NoMetHoZy6qe8+pLRaelZmLBZATpr9th
	Ab/Kq5Vk62JvQZ5Y8+kkZ5gPs7i6u/y+2U9NIkt9w8ZggXGOF4rtusNnfA==
X-Gm-Gg: ASbGncuCZMGLo8V0M7Y42YHTEqNxlUT5VYjZds7lx0L7bsHybmpPiR/DhAoREKcVPcT
	eSASZj9c4EuBJoEPlZ+ubB/iuCAYxbqo+zwORqPDRGy3GBRY1R61dXevARsQFejHZoVFkWaACm/
	OvzDhdiCzg6UyOlFS6hYHa7qlGAhvIk4LtIv8ebgbrv8h7YVbGm/8toU1+ZxKU3E5ueaU8V9Lev
	mNdG9KA9KS+9h9Y7+SL/nhXoJPy65p+fQ01EEElhtO9RB4wulbzTrtH7Y1mrX/UVE4wQo9b43aO
	3BN7aF0bV9UZmV8FV7mxVP0cOTWarLw=
X-Google-Smtp-Source: AGHT+IG/30QrZfnspbMQ+s4/HBAOUNlMqyBtYEOzkH4IJyvbx+YPNn3wGq38cHtf60/OUA7LPQbyqA==
X-Received: by 2002:a05:6a00:320c:b0:740:6468:4e9 with SMTP id d2e1a72fcca58-74064680667mr1449066b3a.17.1746216986455;
        Fri, 02 May 2025 13:16:26 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:7::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74059021e13sm2027600b3a.89.2025.05.02.13.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 13:16:26 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	xiyou.wangcong@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next/net v2 1/5] bpf: net_sched: Fix bpf qdisc init prologue when set as default qdisc
Date: Fri,  2 May 2025 13:16:20 -0700
Message-ID: <20250502201624.3663079-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502201624.3663079-1-ameryhung@gmail.com>
References: <20250502201624.3663079-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow .init to proceed if qdisc_lookup() returns NULL as it only happens
when called by qdisc_create_dflt() in mq/mqprio_init and the parent qdisc
has not been added to qdisc_hash yet. In qdisc_create(), the caller,
__tc_modify_qdisc(), would have made sure the parent qdisc already exist.

In addition, call qdisc_watchdog_init() whether .init succeeds or not to
prevent null-pointer dereference. In qdisc_create() and
qdisc_create_dflt(), if .init fails, .destroy will be called. As a
result, the destroy epilogue could call qdisc_watchdog_cancel() with an
uninitialized timer, causing null-pointer deference in hrtimer_cancel().

Fixes: c8240344956e ("bpf: net_sched: Support implementation of Qdisc_ops in bpf")
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 net/sched/bpf_qdisc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index 9f32b305636f..a8efc3ff2b7e 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -234,18 +234,20 @@ __bpf_kfunc int bpf_qdisc_init_prologue(struct Qdisc *sch,
 	struct net_device *dev = qdisc_dev(sch);
 	struct Qdisc *p;
 
+	qdisc_watchdog_init(&q->watchdog, sch);
+
 	if (sch->parent != TC_H_ROOT) {
+		/* If qdisc_lookup() returns NULL, it means .init is called by
+		 * qdisc_create_dflt() in mq/mqprio_init and the parent qdisc
+		 * has not been added to qdisc_hash yet.
+		 */
 		p = qdisc_lookup(dev, TC_H_MAJ(sch->parent));
-		if (!p)
-			return -ENOENT;
-
-		if (!(p->flags & TCQ_F_MQROOT)) {
+		if (p && !(p->flags & TCQ_F_MQROOT)) {
 			NL_SET_ERR_MSG(extack, "BPF qdisc only supported on root or mq");
 			return -EINVAL;
 		}
 	}
 
-	qdisc_watchdog_init(&q->watchdog, sch);
 	return 0;
 }
 
-- 
2.47.1


