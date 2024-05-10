Return-Path: <bpf+bounces-29511-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4848C2A59
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 21:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AE2AB2559C
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 19:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA36D45BEC;
	Fri, 10 May 2024 19:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y1OWehkv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0428481C6
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 19:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715368159; cv=none; b=qJWIZxXi4KRp8rp4o9AO50d2pYjycY/SkEZeAZTfV3RhS0GiQ5Hh2KUfP4iF0agpMss8bJiaO3vaLk8T0WJKn/tFph57v2QcbZ5rksXoY3K3NuoGgH45uccqKoK5YEKYxtt4fbCjKFpp/qvds+0ECQYF0HUv0qlHKh8Wr59xPYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715368159; c=relaxed/simple;
	bh=fztEEpR7m4/NRUlZ4kYE5tFwryhBZrOJRFgR39uDdHY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iTqqKErDD2+x3QpCupM9nnpOR+yRgtPjoJeIzJNBuOIYyWIzN7R/B42RyuHb+S8AyU8iyMWxlAWZEMAbie091UMD4OmAN6t8No/72V8dmcjptOE1f+jzcqqqmn04sg/vVBvZ3bIyVHPMxGk7H28go9xeKqYI9RFL1WrJ+Kai8nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y1OWehkv; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-43de409b742so26236881cf.2
        for <bpf@vger.kernel.org>; Fri, 10 May 2024 12:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715368157; x=1715972957; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kFCn2vdb1VKbwCPwkDokNVd/PgijRUXjHEsTGHgmtLI=;
        b=y1OWehkv5LcnQDTD0STyIjiznN6TtusgeeTxf8x84hSe9X1gsuUeU1lnCRJEHRZrjH
         dCYxI7EJgXwXeWsrSqhz2EyEXYk4NwXihTbOeG1A5OiHL+FnMIpua1VY5plQWFNASMnx
         5LaO8gJVNBqLV7iHa64vu5QtG1w/p4BpMvUgzmjtCBzbIT1PBqn9qN6IOQfnubKSnoQG
         fqa4dKOP3xSEJw/JHrnIRQBEjJWs7tfdZx94+RPnpb+fkFcWwgffZg8DjA10Q0vQBt3X
         d2INGTxsx25AOK6G6X8fd3b58ad+0Ki3/Kd1py9qahMMqAg3TPI9Q44PFcbyJQSrFH/E
         ekTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715368157; x=1715972957;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kFCn2vdb1VKbwCPwkDokNVd/PgijRUXjHEsTGHgmtLI=;
        b=p12CioFB758vQdCWTePOZtrPshvU1OlKjZzsYcLZe9dAO0Nfi6F/E/0BG8ZMmx9pnu
         Ym3neOeDsHV8Hc600k5RecA8yJMt5yEAPqefJRzvtUchkAFM0+D2ZtqfVpm5CYFXAAEP
         8H2LQM9RACqodSCbBFZrUpIdtW6VgXPDP6CWXUIhZplFc4uQdX/wFw6lUklfDTe+B4mY
         Zf5gy0ASIk4DmRYV67VRr/Iq3eyQtZrBBkqnBv0A9FM/IzoJczQvILBGMuVd3wPA8fWl
         jhxlujGYY5tD0mFUYOQfxjifyA+Qiz8TsoFGQv4Gtpy5wEuIcB2yztHoIhc+dmFlkXy5
         PxjQ==
X-Gm-Message-State: AOJu0YwlVnBL22n7ALZFIfLOHJreN+6zlIg15qZwBb0eupbx5igCr/x/
	vFyopEvEPjapQzOWSrJfCAcjbxJssZavis+Qqtv6EoBmHSm59fF3oFsIW40EckTFaN369hzYZPV
	PZzij+xU9VvwK+h7W5kyPJgiBtVbq5jTiy+3Q8s2Qev8LzP06UbKTIZ8Cz4wo+ZmkvfJdupzFqz
	WdmYHVun+c5utCdSvE3KTE+Zg=
X-Google-Smtp-Source: AGHT+IFqvlvYAgR9+7n3+qrB+K1Srlz/ymb4LAXStQHUni+k2szT1ZtVttNYjvEzFIrscNdurr7uxRV/FQ==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a05:6e02:552:b0:36c:f57:acfa with SMTP id
 e9e14a558f8ab-36cc14e8c6amr390695ab.5.1715367775298; Fri, 10 May 2024
 12:02:55 -0700 (PDT)
Date: Fri, 10 May 2024 14:02:21 -0500
In-Reply-To: <20240510190246.3247730-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510190246.3247730-1-jrife@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510190246.3247730-5-jrife@google.com>
Subject: [PATCH v1 bpf-next 04/17] selftests/bpf: Handle ATTACH_REJECT test cases
From: Jordan Rife <jrife@google.com>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Geliang Tang <tanggeliang@kylinos.cn>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In preparation to move test cases from bpf/test_sock_addr.c that expect
ATTACH_REJECT, this patch adds BPF_SKEL_FUNCS_RAW to generate load and
destroy functions that use bpf_prog_attach() to control the attach_type.

The normal load functions use bpf_program__attach_cgroup which does not
have the same degree of control over the attach type, as
bpf_program_attach_fd() calls bpf_link_create() with the attach type
extracted from prog using bpf_program__expected_attach_type(). It is
currently not possible to modify the attach type before
bpf_program__attach_cgroup() is called, since
bpf_program__set_expected_attach_type() has no effect after the program
is loaded.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 .../selftests/bpf/prog_tests/sock_addr.c      | 35 ++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_addr.c b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
index 3033641fd7567..53440458f365e 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_addr.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_addr.c
@@ -367,6 +367,38 @@ struct sock_addr_test {
 	} expected_result;
 };
 
+#define BPF_SKEL_FUNCS_RAW(skel_name, prog_name) \
+static void *prog_name##_load_raw(int cgroup_fd, \
+				  enum bpf_attach_type attach_type, \
+				  bool expect_reject) \
+{ \
+	struct skel_name *skel = skel_name##__open(); \
+	int prog_fd = -1; \
+	if (!ASSERT_OK_PTR(skel, "skel_open")) \
+		goto cleanup; \
+	if (!ASSERT_OK(skel_name##__load(skel), "load")) \
+		goto cleanup; \
+	prog_fd = bpf_program__fd(skel->progs.prog_name); \
+	if (!ASSERT_GT(prog_fd, 0, "prog_fd")) \
+		goto cleanup; \
+	if (bpf_prog_attach(prog_fd, cgroup_fd, attach_type, \
+			      BPF_F_ALLOW_OVERRIDE), "bpf_prog_attach") { \
+		ASSERT_TRUE(expect_reject, "unexpected rejection"); \
+		goto cleanup; \
+	} \
+	if (!ASSERT_FALSE(expect_reject, "expected rejection")) \
+		goto cleanup; \
+cleanup: \
+	if (prog_fd > 0) \
+		bpf_prog_detach(cgroup_fd, attach_type); \
+	skel_name##__destroy(skel); \
+	return NULL; \
+} \
+static void prog_name##_destroy_raw(void *progfd) \
+{ \
+	/* No-op. *_load_raw does all cleanup. */ \
+} \
+
 #define BPF_SKEL_FUNCS(skel_name, prog_name) \
 static void *prog_name##_load(int cgroup_fd, \
 			      enum bpf_attach_type attach_type, \
@@ -1342,7 +1374,8 @@ void test_sock_addr(void)
 			continue;
 
 		skel = test->loadfn(cgroup_fd, test->attach_type,
-				    test->expected_result == LOAD_REJECT);
+				    test->expected_result == LOAD_REJECT ||
+					test->expected_result == ATTACH_REJECT);
 		if (!skel)
 			continue;
 
-- 
2.45.0.118.g7fe29c98d7-goog


