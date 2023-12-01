Return-Path: <bpf+bounces-16345-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D01A4800210
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 04:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5450FB20FAC
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 03:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487E86AA2;
	Fri,  1 Dec 2023 03:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXQKeXZw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1ADD12F;
	Thu, 30 Nov 2023 19:23:30 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3b845ba9ba9so54540b6e.3;
        Thu, 30 Nov 2023 19:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701401010; x=1702005810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1KKlbmNkIVtNCz66L83HhJjP14s5KgSvPUbznWB9zU=;
        b=TXQKeXZwtUYwDt2voxFtPLNZrHQmKWv1ZP+yaaeUNnEgcWKdxwEaqgq+DWrq8bpELf
         FNmmiOATEqJd/2JhN37Z5BVSDtCpwuNA8SDRMnYydlyPhqsfloiWjasgwpxzMm+y338Y
         m2qBm9GQ+74c68sv04L8jsRVuic5j40s+hGn416TLb71tqR0A1C1EZJgS9+HV6eeTn9w
         8i4HVte3LTZ/rXppbp3KKSVp8JNN63RXmeESmA1nzQjKO87xCX4aXShLwlGp3Kmcvt0s
         xptQaWQlcitGOqh//UTkXi5iWaWpIriHrJkQPCW3QOJPrzduR8jU5d51OmWwv5TJZ7js
         U9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701401010; x=1702005810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1KKlbmNkIVtNCz66L83HhJjP14s5KgSvPUbznWB9zU=;
        b=T+xM3jjcYIy5xiABNgmGW0A7eEBdqph++LCTUW0guYuHLTfp/mMH+9htv3b5Byzh5M
         nuNujNe0xJprFAbb55Ptj8m398IHC/TVtppxFh5tfrIySNnewBnd5n7AzJRUTR7SeeFL
         EeqRlrc+rwkofnt8c0NHWypYuK72R2XDziWoZ4ASh0c5qJ2UBhxhjTl3dPnPhkrq5fHN
         LOINKjLQMBcZN3Aj5XfhOAn98kiRuHfQ9tB4d1KBoaFOmIPdasYBs18OT5zRf3gsUadG
         k4h5fxYgWsC6PfMpNYsDxBhHitkzvkXk4wNG54ZVLdL3DJQgE8L0M97rKB6gF8gptdcZ
         QoxA==
X-Gm-Message-State: AOJu0YxHuUJGUJDuixNKik6HLtZhjQq9SfGl/JjVV+TeZx8Z7FMH/rF3
	8N5sROr4qKDvVYnPxyehbRUMYMYlyDXI4w==
X-Google-Smtp-Source: AGHT+IHB+hIZdR+CAmBMF6QJH7q+WA6JlZaX/UGBw/jxt811v4MWZVS0oTC0oKXX3qqksfVc5S70hA==
X-Received: by 2002:a05:6808:1b14:b0:3ad:c497:1336 with SMTP id bx20-20020a0568081b1400b003adc4971336mr1900545oib.16.1701401009938;
        Thu, 30 Nov 2023 19:23:29 -0800 (PST)
Received: from john.lan ([2605:59c8:148:ba10:1053:7b0:e3cc:7b48])
        by smtp.gmail.com with ESMTPSA id a13-20020a65640d000000b005c60cdb08f0sm1768136pgv.0.2023.11.30.19.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 19:23:28 -0800 (PST)
From: John Fastabend <john.fastabend@gmail.com>
To: kuniyu@amazon.com,
	edumazet@google.com,
	jakub@cloudflare.com
Cc: john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf 2/2] bpf: sockmap, test for unconnected af_unix sock
Date: Thu, 30 Nov 2023 19:23:16 -0800
Message-Id: <20231201032316.183845-3-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231201032316.183845-1-john.fastabend@gmail.com>
References: <20231201032316.183845-1-john.fastabend@gmail.com>
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
index f75f84d0b3d7..ad96f4422def 100644
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
+	if (!ASSERT_GT(stream, -1, "socket(AF_UNIX, SOCK_STREAM)"))
+		return;
+
+	dgram = xsocket(AF_UNIX, SOCK_DGRAM, 0);
+	if (!ASSERT_GT(dgram, -1, "socket(AF_UNIX, SOCK_DGRAM)")) {
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


