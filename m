Return-Path: <bpf+bounces-43289-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76ADC9B2E76
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 12:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DD981F2114D
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 11:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C9C1DF960;
	Mon, 28 Oct 2024 11:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQO8C8yD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF511D63C2;
	Mon, 28 Oct 2024 11:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730113604; cv=none; b=QkOg/VQymySRi76VjA+b7GB4ADbnc67fu3s6NFn9WOhISX5Gy5dYtEfKulwdGlcUeZCkZgZ+CSrsz7J4hG/zSoIE944cWoMaXEzxg4tJxryx6TS9I2AtgIsnze4W6mJnusBqM8qlCICF0/uEJAAHYzZZ5t4PVZL7WuzClktClVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730113604; c=relaxed/simple;
	bh=jSZyduiEaojae0Ui1uMVkgmozaMx8yHbh+MrDS/FCwI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kjbe83muabw0o5KA4xKxNq1pbvV3huGc1YFdTeeTZTId7LqTC4shL3QeOY30TZZw+WLHCzKGz9BI/EGU/KGIkGfWD01+0ijYIEhGa09TBhc//0ykSpffDw3wSSJt+JDVgbWbXEafQkayoKj6KboUVmbpPhlvUkYWK1GbwRrKkZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQO8C8yD; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7ea7e2ff5ceso2826470a12.2;
        Mon, 28 Oct 2024 04:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730113601; x=1730718401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2lvZp9BQ0jH1Q0pNlMCfDLNO2tabFVRH+VT4zsGqEo=;
        b=XQO8C8yDWQCDlwC/Bjjm2gIRD4dAZ8/f9KGakm5JAth7P8az5vLD2ATnkpEAiiDEUF
         3uMnIQFYjBqCAgdwBxbPL4Ratc9D0zwNepIWnc0DgUOGoAC7UjKACsuVdwzJmfStUlLd
         TNixwzLrKnIgwoVyTJ+1nXrzb2xSuQS9FpLlqswtElmhbum8THhC5lsxAO3hlYmjzyAj
         ZR7pL17ZhBMUFPN06j1SS4OOqYAFcgxgOZyFjqUzcgvlXXm4nm0GERMvlEahiPuL2VFw
         oN6cxcF9/QiInK7mce/p4f2C8Jx69ZmXs9Uf/8H+siW8fueASiYhWUZlgzZn7vka0si6
         8fGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730113601; x=1730718401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+2lvZp9BQ0jH1Q0pNlMCfDLNO2tabFVRH+VT4zsGqEo=;
        b=cPuGDQoeW3vzXA0J8IZnhrR5NGkLJtD9ZklqgEIqtRfO4kkGXvfeYMxJ1A/51BCtaQ
         jI9bVn7Mk2Ttw/uaZGWLtKj5vi3KS4fUx0oXFMTvT1eEfayrnbM5hKBJiaww0WQsHH01
         5R/sxJ74yJct/E6ThlH44OsUDuzpX3B/Qi2wlh1XLZdNt7Isw5JS2L6HDGQT7Zlk1ftR
         Qmf5tjd3e/NNOhXqSe4jemWM/DULJDjMEfEjO9yfdk9F3yxknA4OwTavnt/W093Usikq
         9TaSKemU0AhwCKFt5U3blG2x6f5Gex4FWF0OslwFGPtUsBIT+vX62ElsFqb2U3FuZuam
         yM+w==
X-Forwarded-Encrypted: i=1; AJvYcCXUvew4dghSBHjjD7lo0xVqs4aNQ+BgHLV31XO4QUcelUNHpicvux4tsh0l9FQRqmoy9jK7/w8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpbaEiD0AF2cL7UT9gwxywzEILV36NDGxXkatjwGK9sARvnmjz
	gDgS2JY2d9b6DpmTHIYsJyGrKfWHNHxCYvcXO8m6HczjVsS9RsKY
X-Google-Smtp-Source: AGHT+IGvZknUgZg1xEurGkZQWusHqdpyrPtQhOIKiuiWyHOcZpWZlBQTeUhHfMkthjQgrodESvotjg==
X-Received: by 2002:a05:6a20:e608:b0:1d9:18e2:e0aa with SMTP id adf61e73a8af0-1d9a855ef95mr9901147637.44.1730113601384;
        Mon, 28 Oct 2024 04:06:41 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc04bdb6sm48130905ad.255.2024.10.28.04.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 04:06:41 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemdebruijn.kernel@gmail.com,
	willemb@google.com,
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
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v3 06/14] net-timestamp: introduce TS_ACK_OPT_CB to generate tcp acked timestamp
Date: Mon, 28 Oct 2024 19:05:27 +0800
Message-Id: <20241028110535.82999-7-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241028110535.82999-1-kerneljasonxing@gmail.com>
References: <20241028110535.82999-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

When the last sent skb in each sendmsg() is acknowledged in TCP layer,
we can print timestamp by setting BPF_SOCK_OPS_TS_ACK_OPT_CB in
bpf program.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/uapi/linux/bpf.h       | 5 +++++
 net/core/skbuff.c              | 3 +++
 tools/include/uapi/linux/bpf.h | 5 +++++
 3 files changed, 13 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index b0032e173e65..6fc3bd12b650 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -7023,6 +7023,11 @@ enum {
 					 * feature is on. It indicates the
 					 * recorded timestamp.
 					 */
+	BPF_SOCK_OPS_TS_ACK_OPT_CB,	/* Called when all the skbs are
+					 * acknowledged when SO_TIMESTAMPING
+					 * feature is on. It indicates the
+					 * recorded timestamp.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index e29ab3e45213..8b2a79c0fe1c 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5657,6 +5657,9 @@ static void skb_tstamp_tx_output_bpf(struct sock *sk, int tstype,
 	case SCM_TSTAMP_SND:
 		cb_flag = BPF_SOCK_OPS_TS_SW_OPT_CB;
 		break;
+	case SCM_TSTAMP_ACK:
+		cb_flag = BPF_SOCK_OPS_TS_ACK_OPT_CB;
+		break;
 	default:
 		return;
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index b0032e173e65..6fc3bd12b650 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -7023,6 +7023,11 @@ enum {
 					 * feature is on. It indicates the
 					 * recorded timestamp.
 					 */
+	BPF_SOCK_OPS_TS_ACK_OPT_CB,	/* Called when all the skbs are
+					 * acknowledged when SO_TIMESTAMPING
+					 * feature is on. It indicates the
+					 * recorded timestamp.
+					 */
 };
 
 /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
-- 
2.37.3


