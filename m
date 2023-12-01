Return-Path: <bpf+bounces-16410-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 317AB80122B
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 19:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62C251C20F7C
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 18:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827414E621;
	Fri,  1 Dec 2023 18:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rbw/fuWn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CCADF;
	Fri,  1 Dec 2023 10:02:10 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6cdd13c586fso2207540b3a.0;
        Fri, 01 Dec 2023 10:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701453730; x=1702058530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nro0EszP1rhH59gXkDCgGwx5cVROlNqWjcCjSot6oJI=;
        b=Rbw/fuWnnBKy5zlnYq4CuZxbjyAqInzYliFLDBfHTmx/cfSUAodZLpGzVQzW8tLXlw
         mmwHT307BEBRVKdj8hfshXL/G7OvbF84HxMDZGoysa4b6RLcS1WtsHebMF0dDaTUSqpL
         fCFYD7GhBJ3mpBRA0rvt/7z0I9Bgn7netqYZPL8BADkLiWnsT8ZVpKMWR54Y/nRglmmg
         W1K16vjzId6xT17BD9x/GwuFp1gR/A9Op42XVYOeO0SPIhxWjdlvw3rW+fM9xt+Vxkz7
         SGSFFniWYgDZ9bkcSLuf6neB3klfNd2u7o6XWdcFfyqcZ3uUQQJR4vLcyEnPV7GQ9R5J
         V2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701453730; x=1702058530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nro0EszP1rhH59gXkDCgGwx5cVROlNqWjcCjSot6oJI=;
        b=A+/C19TXD8Oorl/4Xo7bUiZem1nN+ALQJdidoW6zKtJhEdL2LPlojhLJIUkt5C37J7
         PwVBlxAnqZV3baEA/EoCvTZfy6IzagGso0u+HBPfVbjZjUO1exUmtdm4vQLHH5X3lJEN
         jbM5SNL91nEtZv0L0bhL0vI/lirkU9AOzEYM7/bfQe7RfEdPVDCE22Pmt194fQx43Zia
         3laU0zoJB56hM60whMoyq+64zYtGY/NriKRAhBbfF3fgkmIHrSd0tymw33jCrCioftxi
         LDjJdmX0M4/XrJ6UiY3LgBd1OzmnJuq69ojw8MGQJbDyZ8uQINg4+tPDS++1JhsFJVE9
         /Qpw==
X-Gm-Message-State: AOJu0YxG8QLLe6Ooy62it10kpk8mlGt1yy/xzoiOTpOzCyz5B8IyiLRY
	cp2K9XdK/fJcr2kwgprCO6c=
X-Google-Smtp-Source: AGHT+IEhT+9mBnEj1djlx5Sg3lcL9l5JUcs2cb43+VMeXCzjYqYkuoIjzv7IlCeF5noKlye1fgyrfA==
X-Received: by 2002:a05:6a00:35c7:b0:6cb:4c60:7398 with SMTP id dc7-20020a056a0035c700b006cb4c607398mr24448415pfb.13.1701453729529;
        Fri, 01 Dec 2023 10:02:09 -0800 (PST)
Received: from john.lan ([2605:59c8:148:ba10:7a9a:8993:d50f:aaa4])
        by smtp.gmail.com with ESMTPSA id l11-20020a635b4b000000b005b6c1972c99sm3362493pgm.7.2023.12.01.10.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 10:01:57 -0800 (PST)
From: John Fastabend <john.fastabend@gmail.com>
To: martin.lau@kernel.org,
	edumazet@google.com,
	jakub@cloudflare.com
Cc: john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf v2 2/2] bpf: sockmap, test for unconnected af_unix sock
Date: Fri,  1 Dec 2023 10:01:39 -0800
Message-Id: <20231201180139.328529-3-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231201180139.328529-1-john.fastabend@gmail.com>
References: <20231201180139.328529-1-john.fastabend@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add test to sockmap_basic to ensure af_unix sockets that are not connected
can not be added to the map. Ensure we keep DGRAM sockets working however
as these will not be connected typically.

Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
index f75f84d0b3d7..7c2241fae19a 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
@@ -524,6 +524,37 @@ static void test_sockmap_skb_verdict_peek(void)
 	test_sockmap_pass_prog__destroy(pass);
 }
 
+static void test_sockmap_unconnected_unix(void)
+{
+	int err, map, stream = 0, dgram = 0, zero = 0;
+	struct test_sockmap_pass_prog *skel;
+
+	skel = test_sockmap_pass_prog__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "open_and_load"))
+		return;
+
+	map = bpf_map__fd(skel->maps.sock_map_rx);
+
+	stream = xsocket(AF_UNIX, SOCK_STREAM, 0);
+	if (stream < 0)
+		return;
+
+	dgram = xsocket(AF_UNIX, SOCK_DGRAM, 0);
+	if (dgram < 0) {
+		close(stream);
+		return;
+	}
+
+	err = bpf_map_update_elem(map, &zero, &stream, BPF_ANY);
+	ASSERT_ERR(err, "bpf_map_update_elem(stream)");
+
+	err = bpf_map_update_elem(map, &zero, &dgram, BPF_ANY);
+	ASSERT_OK(err, "bpf_map_update_elem(dgram)");
+
+	close(stream);
+	close(dgram);
+}
+
 void test_sockmap_basic(void)
 {
 	if (test__start_subtest("sockmap create_update_free"))
@@ -566,4 +597,7 @@ void test_sockmap_basic(void)
 		test_sockmap_skb_verdict_fionread(false);
 	if (test__start_subtest("sockmap skb_verdict msg_f_peek"))
 		test_sockmap_skb_verdict_peek();
+
+	if (test__start_subtest("sockmap unconnected af_unix"))
+		test_sockmap_unconnected_unix();
 }
-- 
2.33.0


