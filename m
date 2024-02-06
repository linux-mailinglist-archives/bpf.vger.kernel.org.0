Return-Path: <bpf+bounces-21293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 552BC84AFBD
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 09:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10439287C31
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 08:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C9D12BE8E;
	Tue,  6 Feb 2024 08:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUspYL0O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BAF12AACA
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 08:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707207322; cv=none; b=s7yIfJ9kWDrUzD+TNwLncW1L7SB7nmHggNO+jKwx4FqT+J9YB9V7G3D78I8jgYjLPPWL/PmiMJzEV0QYtoAB7wfkxJgnejraUADBzLlMFeHCyhSrKPfclzzU3YXpMtfLksbUDZ0CpjaNnXsF8tcBJpFH0NpA/FBX2aFJ9RzPGDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707207322; c=relaxed/simple;
	bh=yTw3iMbpiHkoMOAEjLkvxKwb0/tYyK2no14G78laVzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qHG3EsxHlou5fwo3n8FzyDWDRnuQYSvNWcjy71Ny6Z3X2NO4FdsAr6T3bhwxQ2fx7AX/ZXVANuq/Khq6Njvc4UVA033nBVy8fP3ij/evfPM8jOjpUm2ePNpa5utOUT+BmkPYEw7/YOI8KEXGgOJXL/ZtTKb7SFAFl1McaeXPwpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUspYL0O; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-595d24ad466so3304237eaf.0
        for <bpf@vger.kernel.org>; Tue, 06 Feb 2024 00:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707207320; x=1707812120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+y3dhJcZNIfgObUe6ZQKYjQoS0Kyd1B/l8QOAn5+S30=;
        b=WUspYL0OPkT39JaLCEXX0MMO6DEvv8d3VvO95fE1ZrgHLVbPg0oAouOM+Yp/Ug8pmY
         pogNcV5VC9CmP5sFh0My/na5ErSZder8T7F4j4l+V/t/qr+5w7ogpTpP6Cx1AhFpf17Z
         x4eyjKXdo5hYs7de8A0qDJUBAZrXSkELDIY35GBEdTumSETi2MJzknsIjqcZ/vxqmtTi
         WCBHWMYFu/FFv8At/QNJLC4jmbLh+0POjJWBMh68K8Fj5ima7LpIbNBQHkL9dujlr/Li
         u4H7xE+UK8q/dUza9VgNq2SE6oM92dE1C67xgn7vewct2YTffr5nQKwqzjrTXckZ9pot
         6VaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707207320; x=1707812120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+y3dhJcZNIfgObUe6ZQKYjQoS0Kyd1B/l8QOAn5+S30=;
        b=qdHl4NJBGMt+qdqJXuccA2bIyx+a2RDoszrvof9QucXGXcMrS0DYOKjciqwjHl0Xrj
         uQKQ4aqcxoDlEj8SGEmE1S/s3t/+gw/Jqd+FdxuS9GQahBPhzJ1NXA7mcjLodHbbTvEa
         F+YAdJS/jTCEzFtbEgtI2HG4SLviuLWHNiDdOCoMNRLYo1JtM+MNOTbhUDoGptRdURaM
         7MPrwwZxFkh9VK2KcsAhRcbBUcn6YXiIkzn55tUjYGh32lzi89XUdYr5S8cKuWRYNQ9S
         ytf/LmeB7BmpFYwlQyx2nSvrDCGvotoL3QjWuQ6mkC4xpS6MciKLgL+CJhywJfL0leoc
         X3kA==
X-Gm-Message-State: AOJu0Yyc82EKC+eLagw+whbxzRD3Xu3558qUa1KVLbsl6qk/oMN14UZL
	+x4BGwYWayZsSzmKss6uClDnLSfpCW3HyYct7amkmg4BmU7H5tAD
X-Google-Smtp-Source: AGHT+IHfXwI4Wyn2EETk/tpzhQdCv5JkPNi51ogk2cMn+LWheLgWxkCz1LKZNR4SCD9TS2HXaIgDrA==
X-Received: by 2002:a05:6358:714:b0:178:b97c:f087 with SMTP id e20-20020a056358071400b00178b97cf087mr1669667rwj.15.1707207320200;
        Tue, 06 Feb 2024 00:15:20 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWaDjS5pEFFxqp6vaxIA69gUTraJWP2/lZDjxZyru8ZpxMoa8bzAZAOgPMOkVNF7NA87JMoLjjqQhL2ETD4KWj1txn6vrhwG9ngUqn2ndrGSll6C/agWmztsISEe7fKQtOGKLgTPCNp/xuj+rvqI9NdXbYwnFUkPPmnAwX5BeHlKUTxMlnU6iLV/YWQjjLDRQ4tkfFi2TU5Ryl5Q1LOy5YaKUqTm102inX1JmpCU8Bua73ZNmHlB9pfbvO5wF3IBJOLClZ/o74vDt3/G/QMXGs14Ab4bQo0HHWiVsO1CPXfvEUxOWyqRh+m+REfsr+NNAZlhgWgNscy4291vxHeEsE5oNOVxghOb83NI5OpoP0th2Z1DfG6V5BzjyiSRJ8hZlUSXmjLQqBxsFGfjLe58VZ117xKfjT2ySsRn1SWs//hovKOnbC09Q==
Received: from localhost.localdomain ([39.144.105.129])
        by smtp.gmail.com with ESMTPSA id 3-20020a630c43000000b005d7c02994c4sm1381660pgm.60.2024.02.06.00.15.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Feb 2024 00:15:19 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	tj@kernel.org,
	void@manifault.com
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v6 bpf-next 3/5] selftests/bpf: Fix error checking for cpumask_success__load()
Date: Tue,  6 Feb 2024 16:14:14 +0800
Message-Id: <20240206081416.26242-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20240206081416.26242-1-laoar.shao@gmail.com>
References: <20240206081416.26242-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We should verify the return value of cpumask_success__load().

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Cc: David Vernet <void@manifault.com>
---
 tools/testing/selftests/bpf/prog_tests/cpumask.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/cpumask.c b/tools/testing/selftests/bpf/prog_tests/cpumask.c
index c2e886399e3c..ecf89df78109 100644
--- a/tools/testing/selftests/bpf/prog_tests/cpumask.c
+++ b/tools/testing/selftests/bpf/prog_tests/cpumask.c
@@ -27,7 +27,7 @@ static void verify_success(const char *prog_name)
 	struct bpf_program *prog;
 	struct bpf_link *link = NULL;
 	pid_t child_pid;
-	int status;
+	int status, err;
 
 	skel = cpumask_success__open();
 	if (!ASSERT_OK_PTR(skel, "cpumask_success__open"))
@@ -36,8 +36,8 @@ static void verify_success(const char *prog_name)
 	skel->bss->pid = getpid();
 	skel->bss->nr_cpus = libbpf_num_possible_cpus();
 
-	cpumask_success__load(skel);
-	if (!ASSERT_OK_PTR(skel, "cpumask_success__load"))
+	err = cpumask_success__load(skel);
+	if (!ASSERT_OK(err, "cpumask_success__load"))
 		goto cleanup;
 
 	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
-- 
2.39.1


