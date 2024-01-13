Return-Path: <bpf+bounces-19510-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6F382CEB6
	for <lists+bpf@lfdr.de>; Sat, 13 Jan 2024 22:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCDCB2824A5
	for <lists+bpf@lfdr.de>; Sat, 13 Jan 2024 21:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C00A107B2;
	Sat, 13 Jan 2024 21:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gl++7MP1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39976ADE
	for <bpf@vger.kernel.org>; Sat, 13 Jan 2024 21:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3376f71fcbbso5403548f8f.1
        for <bpf@vger.kernel.org>; Sat, 13 Jan 2024 13:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705180206; x=1705785006; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7RK51WDM7u+gSOGV7ptfNFd/vQ/8LOZPL98dJB5f6Ic=;
        b=Gl++7MP1zYe+dJT/5hZZYEkNvky/jDBEhzWxydFMZZQPLWwFxPRdXduG3n37rKQe7g
         7cCuzqOx3Z4Wke3DRUvy1qt3AlnX1onJSSPHihqA8QKQnlJ2a/sYmcQlx6Pnf/TAWJ40
         Imc9bYUCCfvB79KZxkC0jr9T5eFptJH/lc7WaFp9eD+RH2VICVeo0pNhXOtt6FOK0JWP
         myS4u+HNdTx/PHDonYx2RJEkJPQjZZtRT7sWMWi691dNyf89bWlMo589uoZlf4opEaWb
         zeXmPNGDCv/oQ2fzbLSng0OLN98P1QrS2F29w1V8ebhFuywjPJpaOAXIZtvxQhTqTGFM
         Ib6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705180206; x=1705785006;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7RK51WDM7u+gSOGV7ptfNFd/vQ/8LOZPL98dJB5f6Ic=;
        b=TuFK65iW/ao5AL14c8lY2AfDrlnw6HdyESf7jBtsdQ0YeCbb7MRv0Jo5+RRykVGjwC
         MLp1WXLvSv/cSV7S4HQBt1VeOi/PlhY1dU8LwgFg7iGKWSFR7qRO03bj8J09HCQy1O4N
         bvQfUanPokmwkIZHKO6enuFcZizTNURddVGESGKKsC7KGRXevAaattVdbxRvGPv4oVs3
         v/G9f1UUqpHAUIWQc/K9RM8PayjLWjE9GMsiRvWd+NRnSEOeGYdHhAAIx8LMaH+EQity
         2SQZ9JDpYCnxVrjoX8f/eME01lC/vBVXfKsRGSGLXsVcwgFxfJmyiJHtplZkwsMuG20F
         XSZQ==
X-Gm-Message-State: AOJu0YzX0AlnoR8uFFcTLXXKs1JDRFVUyiOao+7iezEne9kQuo7rF3eb
	3XQL4qHnaRrzTDJgKcw0RAZ4bdtFwISGzBlwWtM0uDaW27I=
X-Google-Smtp-Source: AGHT+IHvDeMtHKZGnPJnMvhG3yadITk1XaSoIhrhYdevujy1EHr2j7w3Xf38tRzCgluycWQ8fgmoMPIDSL6VxdpM4ss=
X-Received: by 2002:a5d:4e8f:0:b0:336:d086:84ae with SMTP id
 e15-20020a5d4e8f000000b00336d08684aemr1300573wru.73.1705180205397; Sat, 13
 Jan 2024 13:10:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 13 Jan 2024 13:09:54 -0800
Message-ID: <CAADnVQJ_Xwk7xp-AybVC7dtSqRnbo1Lkw1Y+vQ+_w6UJTPvhKw@mail.gmail.com>
Subject: flaky tc_redirect/tc_redirect_dtime
To: Martin KaFai Lau <martin.lau@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Martin,

I remember you tried to fix tc_redirect/tc_redirect_dtime flakiness,
but it is still flaky.
Just running test_progs -t tc_redirect/tc_redirect_dtime
in a loop it will fail after 30-50 iterations in my VM and always with:

test_inet_dtime:PASS:setns src 0 nsec
(network_helpers.c:253: errno: Operation now in progress) Failed to
connect to server
close_netns:PASS:setns 0 nsec
test_inet_dtime:FAIL:connect_to_fd unexpected connect_to_fd: actual -1
< expected 0

I've added this hack:
+again:
        nstoken = open_netns(NS_SRC);
        if (!ASSERT_OK_PTR(nstoken, "setns src"))
                goto done;
@@ -573,6 +575,11 @@ static void test_inet_dtime(int family, int type,
const char *addr, __u16 port)
        if (!ASSERT_GE(client_fd, 0, "connect_to_fd"))
                goto done;

+       if (i++ < 1000 && 0) {
+               printf("XXXX %d\n", i);
+               close(client_fd);
+               goto again;
+       }

and realized that only the first connect can succeed.
The 2nd connect always fails.
So I suspect bpf prog sees first stray packet, acts on it,
but the actual connect request comes 2nd and it fails.

I tried to understand what's going on inside bpf prog,
but the test is too complicated.
Please take a look when you have a chance.

I also added:
@@ -857,7 +864,7 @@ static void test_tc_redirect_dtime(struct
netns_setup_result *setup_result)
                goto done;

        test_tcp_clear_dtime(skel);
-
+if (0) {
        test_tcp_dtime(skel, AF_INET, true);
        test_tcp_dtime(skel, AF_INET6, true);
        test_udp_dtime(skel, AF_INET, true);
@@ -878,7 +885,7 @@ static void test_tc_redirect_dtime(struct
netns_setup_result *setup_result)
        test_tcp_dtime(skel, AF_INET6, false);
        test_udp_dtime(skel, AF_INET, false);
        test_udp_dtime(skel, AF_INET6, false);
-
+}
to speed up a test a bit.

