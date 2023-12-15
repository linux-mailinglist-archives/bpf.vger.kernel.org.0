Return-Path: <bpf+bounces-17972-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC10814455
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 10:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1BAA1C2295D
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 09:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7617117739;
	Fri, 15 Dec 2023 09:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UehA/93P"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C86E182CC
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 09:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2c9f84533beso3807711fa.1
        for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 01:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702631790; x=1703236590; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/YfRGdicfy9JBm6ObkuIGDYLb98Vp1LWePHqgOXLGuA=;
        b=UehA/93POJBis0iBOAHrSnxZcpDZ0fxAGu2Y9l9bEpH5XVr9Ocb5iLJySSXFwpLuaS
         IfeuMSZ7qQA4Cxc0x8rKbeAE9s1XCFwgBGlLebHDGtXFzo6RzvHLsGc7ur2Ia3bMWWMu
         ycMSlSU+ql/3k0XSlv6AZj+9dTK1WLvDI870ARcc6neE1MWPRI3e7fJuTILvsE0xYzBS
         MkFgP+ZaxATkCKZGwyN36dXGI/ctzrSkFGxQANBnbVElvz9uaCviHC54C8hMQrpu6eRr
         H2h23h9caFyuv7qEhsP8eFh8qclFuGMfA66nQV6a+A1rbfvXv6YzlIT2O43MsfONbr4+
         8yIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702631790; x=1703236590;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/YfRGdicfy9JBm6ObkuIGDYLb98Vp1LWePHqgOXLGuA=;
        b=ev5+NJ9P0XNdGOa9mjxCRCSITfvkjWLSVjKlSV9NA7KzIAT26K69S7ej/LDQsBj/Y3
         okC5AcN+lzydJMmcqU8hUZpeuM2Xa0CzYKT/vRFwk1JKI7yHiz42b2ojRLstTRRo8oIw
         iG6xGMEntQa1k95aBKXG8/OvILj0ZelFZ5vLr5WD7LrQCCh17wxY+7y5rr2wIgRdsykg
         Ry5LOzWzsL6b/M28Ud22OLj7kOn/3LEAJ1ooyruRURpYd5YaFMPG5m2ydhD0yd6CXDOA
         CZICqjS7amrtFuJqUFjaSxWxI81YUvEshotbbjj14hpWYqEWTW3agv3iiGXxcKJnjSsg
         b5+w==
X-Gm-Message-State: AOJu0YznZGw142mPFb0Xoc+0G3iZgbgRj711OvJeMgRVUd9E4cJLGdOU
	7c2kaCVBH87LaiGgieDIXJ4=
X-Google-Smtp-Source: AGHT+IGxNaY/hyk+giP7XHajrjGBnXJDFjqmr4V7fXYY2Ilepl65b/Ur+mgdhwt086ChVoinE/qHaQ==
X-Received: by 2002:a05:6512:10cf:b0:50e:1aac:ae47 with SMTP id k15-20020a05651210cf00b0050e1aacae47mr1088587lfg.63.1702631790177;
        Fri, 15 Dec 2023 01:16:30 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ti7-20020a170907c20700b00a1caa50feb3sm10415977ejc.40.2023.12.15.01.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 01:16:29 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 15 Dec 2023 10:16:27 +0100
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yhs@fb.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: [RFC] bpf: Issue with bpf_fentry_test7 call
Message-ID: <ZXwZa_eK7bWXjJk7@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hi,   
The bpf CI is broken due to clang emitting 2 functions for
bpf_fentry_test7:

  # cat available_filter_functions | grep bpf_fentry_test7
  bpf_fentry_test7
  bpf_fentry_test7.specialized.1

The tests attach to 'bpf_fentry_test7' while the function with
'.specialized.1' suffix is executed in bpf_prog_test_run_tracing.

It looks like clang optimalization that comes from passing 0
as argument and returning it directly in bpf_fentry_test7.

I'm not sure there's a way to disable this, so far I came
up with solution below that passes real pointer, but I think
that was not the original intention for the test.

We had issue with this function back in august:
  32337c0a2824 bpf: Prevent inlining of bpf_fentry_test7()

I'm not sure why it started to show now? was clang updated for CI?

I'll try to find out more, but any clang ideas are welcome ;-)

thanks,
jirka


---
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index c9fdcc5cdce1..33208eec9361 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -543,7 +543,7 @@ struct bpf_fentry_test_t {
 int noinline bpf_fentry_test7(struct bpf_fentry_test_t *arg)
 {
 	asm volatile ("");
-	return (long)arg;
+	return 0;
 }
 
 int noinline bpf_fentry_test8(struct bpf_fentry_test_t *arg)
@@ -668,7 +668,7 @@ int bpf_prog_test_run_tracing(struct bpf_prog *prog,
 		    bpf_fentry_test4((void *)7, 8, 9, 10) != 34 ||
 		    bpf_fentry_test5(11, (void *)12, 13, 14, 15) != 65 ||
 		    bpf_fentry_test6(16, (void *)17, 18, 19, (void *)20, 21) != 111 ||
-		    bpf_fentry_test7((struct bpf_fentry_test_t *)0) != 0 ||
+		    bpf_fentry_test7(&arg) != 0 ||
 		    bpf_fentry_test8(&arg) != 0 ||
 		    bpf_fentry_test9(&retval) != 0)
 			goto out;
diff --git a/tools/testing/selftests/bpf/progs/fentry_test.c b/tools/testing/selftests/bpf/progs/fentry_test.c
index 52a550d281d9..95c5c34ccaa8 100644
--- a/tools/testing/selftests/bpf/progs/fentry_test.c
+++ b/tools/testing/selftests/bpf/progs/fentry_test.c
@@ -64,7 +64,7 @@ __u64 test7_result = 0;
 SEC("fentry/bpf_fentry_test7")
 int BPF_PROG(test7, struct bpf_fentry_test_t *arg)
 {
-	if (!arg)
+	if (arg)
 		test7_result = 1;
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/fexit_test.c b/tools/testing/selftests/bpf/progs/fexit_test.c
index 8f1ccb7302e1..ffb30236ca02 100644
--- a/tools/testing/selftests/bpf/progs/fexit_test.c
+++ b/tools/testing/selftests/bpf/progs/fexit_test.c
@@ -65,7 +65,7 @@ __u64 test7_result = 0;
 SEC("fexit/bpf_fentry_test7")
 int BPF_PROG(test7, struct bpf_fentry_test_t *arg)
 {
-	if (!arg)
+	if (arg)
 		test7_result = 1;
 	return 0;
 }

