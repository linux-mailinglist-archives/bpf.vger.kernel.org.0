Return-Path: <bpf+bounces-35100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A53FF937B80
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 19:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 687C9283248
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 17:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DFC1474A9;
	Fri, 19 Jul 2024 17:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvbhNCQD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD82146A85;
	Fri, 19 Jul 2024 17:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721409685; cv=none; b=pkaUKro7LZmDN+rysuGbZ4Dy3yQ225oqTvROxbmCiL9/MtBscw03mbOZPs0cg/vb5Z4+A/1/4Qktl3onCbxQT36Wp9tmQ/g2cEC9XtsKaDeXsJN/3FeQRnGv5AymZn0eiYzkyFRxgoiSWDLG7HuvzsJAYVr/Pst1pbWBggtq1gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721409685; c=relaxed/simple;
	bh=GcPbDg8dGPpvW3qKI6MgYWhbdTG4qTHFxQ7VdGvdbZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hUzplkVst0pOsxyGacADg8W6DOFSF9OMcD7H/Si6y++BBxu0Ztk0DGDa90QBw45CNNRk9mHlAJz5c5OLDkA+HAXtOc03vCAiOyy2fj/mSXiv6PDZE4bvZ6logLvx/QLVlg5njTIhBg8BAH3qlYXTARdBG65cu2PP6sqge3WWylg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvbhNCQD; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-79ef93865afso106959485a.1;
        Fri, 19 Jul 2024 10:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721409683; x=1722014483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/3/xMbadZR6ipB99nJ7HjWra8CWfz07I6ua6elRBn7o=;
        b=JvbhNCQD6jfV/tO1WwWsGNyrHoP/N55Bix5WdXwrBGuwMY44Oi0oflbuYH0eihqiO+
         mSu0AhdR6bmPYXurC4Hd8p0KyGrcOV2Ycj/34xn91TR5Vxq930VVpPd+V/Say74PChzk
         zqhj7YMFakRr7XkuCdDeb+ATm0FoTcwB0ZrI/uvHddK+fFKLmVA7VH8lcuuXWTJlqkwx
         PeQt1vMOL2jx9TURtBpIqoHzp3iSlyAyYYAG52k+Nas+MqbdooVBvA/+xw2sV4XiGiE+
         BUs9LWb242QzBjgYxXqeo9afGzD0CMHGCWR5uNP3kW+IEH6t6y0s1Meu4b4+9vFXobgF
         NsaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721409683; x=1722014483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/3/xMbadZR6ipB99nJ7HjWra8CWfz07I6ua6elRBn7o=;
        b=WbfL4tt02rxKL2ftIwRjUKrtc6FFhspQul9lWhm1R3NDUpy2CtTUFxAGcBIsoZ8BZi
         FSq1XXz5UyP/l/UryADWOAGhpSqHnAvPk1OYFFt3qPjKzEuo/Cf/dzfsX3oY1wT5sZ+v
         F/KRc1mlvrVt+73yyS/O58sEmrVpmfzudzW/FK3465G1G/OPWhmgJ9vUFk3UASkNVo6B
         bg0mK/H+5O6U7/ynglQOraOx8DaBZ3kAlwSXJJPt+MJ78zr45GCSMk0zjaQm5EHn86KS
         UVjujTs2vQ5KyH/BFbIf8/mJdhHmU07lx9mmZJye0h+mKDUjSgSAT8Lmy0V8wvoHOzfJ
         MBoA==
X-Forwarded-Encrypted: i=1; AJvYcCXoojE5rCkQtx0niU9cEh9uzKYAgMzrAfb6lqWa7J5b827bJELYTZ1jBggAUqioHKdSl2xM25o3Hi4hCWn8E1BN/VEylKBy6E2cx9sLZ58VaNwf+grnLoiEAGhs
X-Gm-Message-State: AOJu0YzQAfcE2cTshCKNyr4kDX+zbseJsB9FFYWFLXl3xPf1DlpewVKZ
	ONOn6gqsjbsagocAetchsuZtPcalboVCOFgZDI6MfADF32gAzVg5
X-Google-Smtp-Source: AGHT+IFeYODdlJTJQuieFvm41hhcW7y+RmebwKsxXtILe9qa55t1jiNZPIbRJRpCS2XEZxiFmrs69w==
X-Received: by 2002:a05:620a:4108:b0:79c:103b:af44 with SMTP id af79cd13be357-7a187501438mr1068244185a.65.1721409682694;
        Fri, 19 Jul 2024 10:21:22 -0700 (PDT)
Received: from n36-183-057.byted.org ([130.44.212.91])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a19905eb1dsm109706485a.89.2024.07.19.10.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 10:21:22 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: ameryhung@gmail.com
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	martin.lau@kernel.org,
	netdev@vger.kernel.org,
	sdf@google.com,
	sinquersw@gmail.com,
	toke@redhat.com,
	xiyou.wangcong@gmail.com,
	yangpeihao@sjtu.edu.cn,
	yepeilin.cs@gmail.com,
	donald.hunter@gmail.com
Subject: [OFFLIST RFC 4/4] selftests/bpf: Test bpf_kptr_xchg stashing into local kptr
Date: Fri, 19 Jul 2024 17:21:19 +0000
Message-Id: <20240719172119.3199738-4-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240719172119.3199738-1-amery.hung@bytedance.com>
References: <20240714175130.4051012-1-amery.hung@bytedance.com>
 <20240719172119.3199738-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Marchevsky <davemarchevsky@fb.com>

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 .../selftests/bpf/progs/local_kptr_stash.c    | 21 +++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/local_kptr_stash.c b/tools/testing/selftests/bpf/progs/local_kptr_stash.c
index 75043ffc5dad..8532abcae5c0 100644
--- a/tools/testing/selftests/bpf/progs/local_kptr_stash.c
+++ b/tools/testing/selftests/bpf/progs/local_kptr_stash.c
@@ -11,6 +11,7 @@
 struct node_data {
 	long key;
 	long data;
+	struct prog_test_ref_kfunc __kptr *stashed_in_node;
 	struct bpf_rb_node node;
 };
 
@@ -85,17 +86,33 @@ static bool less(struct bpf_rb_node *a, const struct bpf_rb_node *b)
 
 static int create_and_stash(int idx, int val)
 {
+	struct prog_test_ref_kfunc *inner;
 	struct map_value *mapval;
 	struct node_data *res;
+	unsigned long dummy;
 
 	mapval = bpf_map_lookup_elem(&some_nodes, &idx);
 	if (!mapval)
 		return 1;
 
+	dummy = 0;
+	inner = bpf_kfunc_call_test_acquire(&dummy);
+	if (!inner)
+		return 2;
+
 	res = bpf_obj_new(typeof(*res));
-	if (!res)
-		return 1;
+	if (!res) {
+		bpf_kfunc_call_test_release(inner);
+		return 3;
+	}
 	res->key = val;
+	inner = bpf_kptr_xchg(&res->stashed_in_node, inner);
+	if (inner) {
+		/* Should never happen, we just obj_new'd res */
+		bpf_kfunc_call_test_release(inner);
+		bpf_obj_drop(res);
+		return 4;
+	}
 
 	res = bpf_kptr_xchg(&mapval->node, res);
 	if (res)
-- 
2.20.1


