Return-Path: <bpf+bounces-51918-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3EEA3B36C
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 09:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D79C43B5B2E
	for <lists+bpf@lfdr.de>; Wed, 19 Feb 2025 08:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB0F1C5F35;
	Wed, 19 Feb 2025 08:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ieu8OCIT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876A41C5F18;
	Wed, 19 Feb 2025 08:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739952836; cv=none; b=j1ep47QwzwWlOp04CIJBBzd2n29I9CfABp4VhbMAhCUWhNNu2fACJWhCQ3IHDUvLzIivoK0lxIvUCYDtAayWnAvGiU5BzfyZp8FgeN73/CZOQpwBhGF9Orb0tMJxFRUI/jf3C+XRGNhDGBbv3GjIZ2Qhf+G4OcY1QIvwTWrqsSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739952836; c=relaxed/simple;
	bh=Au+KCBJqekdGpRwI3IkgNe0bPEkGjiifi20opoicVf0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gFzRjnuOurcXtRYovfVW1A/BrHEIMCBcztBJV9zf6stLEH7huPVj2SiGS47woiurUVGhwfHFrSaxIT6hF0OyHZOTFYL9d9MRq114wp/ZWjAcBRytoMK9k6svzox/dSyKhT4t8irGJ7W1e80zVwvmenKUAiDnc5FONzeZZCe4TtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ieu8OCIT; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-221057b6ac4so67113195ad.2;
        Wed, 19 Feb 2025 00:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739952834; x=1740557634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7pqIhHMN1qsGlznDso4mbJdvUWGlbkeEORjaiUIYic=;
        b=Ieu8OCITdvVwAMkufkuPagpdr+7MQlOitRjdT5oCajh3g2ReMSGWAkBsJOaGxZs0kn
         1fPHrM3f1YdeaHeaRobuuBYGFjsfBSQv7CPEuktr8Pv5Dqe6bFJawU9/V2d8dcrEzq1x
         dhIv7MNvP+JlINARExnoh/Oh38J/HDMe2Z0o1/CSdApNMRJOu4PCkdJ5vc+4VMkt7uY3
         AFXaXkYd+HsL7cJq4O7QkZJdS62VWZJQ9+zvtun0D/sfQ4RzjFJEFYw22TnbhBOlUC7V
         fKCWkA/JNVqWFvyQGWi57gFrFGtfKrglFmXbtw7ismvg80Tff416YwTTBdGuq45NpgNc
         8r0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739952834; x=1740557634;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7pqIhHMN1qsGlznDso4mbJdvUWGlbkeEORjaiUIYic=;
        b=Jx56UKGi9qX+kTw7AzdRAUfJbXUwG/VUITIpJnbDrc5LdisweRTcO3juhk+BYG6F/p
         WFpRYwPGhBoz/5C4TftjgrRkTXt0MPdQdLYRdB0Ze2qh/nwW+0o543fp6xI43Qq7KSRc
         KDALzt1s9lVl6aqFsnhHNg8sJN3Qo+xsQHfdZmYbNZhRTLk3+N9wUeOem6jFg83lpNI+
         Voy2lh0NqdEnCl9BzBMAWWkcUW+WBUMgH29JArtXAaDN/89PtmFqlrvVC2GSaWScpyYV
         2UyP9EdAQ5rRdVv7cOhOpW2vNcm7KnZdEOHTlHRBLPken9xOUP1/D+xJL+yKEZca703K
         0xlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbtv5YCRs8DLZhYSukbp6NODATNP1ByW97ZwCICSw31JSZ1Jn99tZDOCQAMltRjf3BhhEW7T4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6zAoOX/Y97+lDeGiZGqzyeqZj1l6Xhip3Eb03XC9iTxejtgNO
	gmSw1QPqlhvhTnu7HktRNfwMUvOKi0caCnbm+G9BNjyOua3xzGTo
X-Gm-Gg: ASbGnctJAZ9iPTJ8XWMNjvRnsG4yhVwBQ7Mf4ugFklyBeRt1ASemgPNxAwg9oT3hp+9
	SE5CfWDkWRcoWjL092fLuv3puUoz1O7LuYFXCSnXHRDKx86bTXlBz83gCtG+WFoZXK0D0yudYOY
	IsbfIzOBtKhReiZVGeo0guJc6wx5X6mMmGSBvRikr2ywezFCiIy042C9JuhSKeANEN6KfVGx5kJ
	SBQpmq9hztw5WMTW9MhXX0sqNtLXDIrpqHlW7HgNAoKVnL84h1KealnadYes+C09nM/Au5eVx3Z
	2qIuuncEZAg2Ld/KPhq1EiEOeAh5OzdGZlhtQQZoZ1p2laoHCLHwyeDql2k09AU=
X-Google-Smtp-Source: AGHT+IGizn76tgUJO+HJHVbkirIeh7sUjN1D+NKX8sToDxBEDiYrNbdh1bsPAxgG1oyPJ65Bp9IABQ==
X-Received: by 2002:a05:6a00:1882:b0:730:957d:a80f with SMTP id d2e1a72fcca58-7326177625dmr28950736b3a.2.1739952833743;
        Wed, 19 Feb 2025 00:13:53 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-732642d908esm7774746b3a.159.2025.02.19.00.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 00:13:53 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	ykolal@fb.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: add rto max for bpf_setsockopt test
Date: Wed, 19 Feb 2025 16:13:32 +0800
Message-Id: <20250219081333.56378-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250219081333.56378-1-kerneljasonxing@gmail.com>
References: <20250219081333.56378-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test the TCP_RTO_MAX_MS optname in the existing setget_sockopt test.

Signed-off-by: Jason Xing <kerneljasonxing@gmail.com>
---
 tools/testing/selftests/bpf/progs/bpf_tracing_net.h | 1 +
 tools/testing/selftests/bpf/progs/setget_sockopt.c  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
index 59843b430f76..eb6ed1b7b2ef 100644
--- a/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
+++ b/tools/testing/selftests/bpf/progs/bpf_tracing_net.h
@@ -49,6 +49,7 @@
 #define TCP_SAVED_SYN		28
 #define TCP_CA_NAME_MAX		16
 #define TCP_NAGLE_OFF		1
+#define TCP_RTO_MAX_MS		44
 
 #define TCP_ECN_OK              1
 #define TCP_ECN_QUEUE_CWR       2
diff --git a/tools/testing/selftests/bpf/progs/setget_sockopt.c b/tools/testing/selftests/bpf/progs/setget_sockopt.c
index 6dd4318debbf..106fe430f41b 100644
--- a/tools/testing/selftests/bpf/progs/setget_sockopt.c
+++ b/tools/testing/selftests/bpf/progs/setget_sockopt.c
@@ -61,6 +61,7 @@ static const struct sockopt_test sol_tcp_tests[] = {
 	{ .opt = TCP_NOTSENT_LOWAT, .new = 1314, .expected = 1314, },
 	{ .opt = TCP_BPF_SOCK_OPS_CB_FLAGS, .new = BPF_SOCK_OPS_ALL_CB_FLAGS,
 	  .expected = BPF_SOCK_OPS_ALL_CB_FLAGS, },
+	{ .opt = TCP_RTO_MAX_MS, .new = 2000, .expected = 2000, },
 	{ .opt = 0, },
 };
 
-- 
2.43.5


