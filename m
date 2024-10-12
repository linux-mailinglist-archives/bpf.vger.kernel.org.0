Return-Path: <bpf+bounces-41799-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D2899B0A2
	for <lists+bpf@lfdr.de>; Sat, 12 Oct 2024 06:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C05EF285446
	for <lists+bpf@lfdr.de>; Sat, 12 Oct 2024 04:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34B112C522;
	Sat, 12 Oct 2024 04:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUKmfZEG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6EDA41;
	Sat, 12 Oct 2024 04:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728706032; cv=none; b=fQISq5n6IglILDObQYkO3r9EDbnIH9whxsamDKhT/MfFKIDOJ1IY/rCAxakv737LpPt45IVCgY7HoX2eQTI/XRSVSCi7P1lnM4N4g0dzfDv1lMco8mQnaQkzEi6n82XGyk6kSDVTJjC3yxvvwEVy0dUD9nCelPG5Zsk44eCjbP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728706032; c=relaxed/simple;
	bh=3mR+esWzAtVtdfZr/yWT9xIPWWL2YtmTjDBcWlF0aJY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AtRINVFtw3FWbWbOwQ/HrfeI5bOLGjEoNyB4Bz2P75CkTdtPe1I6jSRLFxXQDhKHs1z1CZ6rLipWI0Z2/0LIfDC2PtQ4J9klR8sXxVrZE5Vm3L7U+8747ZzlF2t1HCWfq+o606d8eO25qbreimEPCogL4JDykAQTfthvOrVzlV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZUKmfZEG; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20b7259be6fso28621085ad.0;
        Fri, 11 Oct 2024 21:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728706030; x=1729310830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oRDW78W3vNOph0PBEFxQBqyMlXJV2fT4fp+c01EtsxA=;
        b=ZUKmfZEGGRjwtMXtq0YeVNhonksNfguNW3zpmc1KoOs4Jsv8cl5GqRijSgXv+IjdXN
         EY4W1QBbONMOakA0l7Q21XbHvDso9WCEAdMkN7IenBapOhM/d84SVraFzK790THGnCUH
         8U8VpIQFSLpHRLKn/WNbe5nO3B+bDZLt5MAm2nOeLybTuYSsGDiYY+pkBwiJOSHRzobP
         2QPxTWVbG5tcBAYTr9ETtyF8baY960EeJm+ckmrMnfckcaGA3sJ/MobTkKn+FvxbX/vn
         Ai7e2mjdbBSuE0bTXTP7qfh0zw7lJ919EqEdE04Mj5VkFy+f5yEzKtWWJGj5JAsQyO11
         ZQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728706030; x=1729310830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oRDW78W3vNOph0PBEFxQBqyMlXJV2fT4fp+c01EtsxA=;
        b=f4yYxfmzP+LFM2iytN8bGmNiLHeELumKJZmTF///Xu5rBQyxg6mXv7KbV6YBmk14xr
         RCdrhB3YLWMBy6gHDjcodri7VZDmuE6jIgXtg319r6f/P/pNfWrle8cIZcL6pB9dIfB6
         KgeqDkGb5Out7icYgyPxAg5R18KvK2A5Wdz/6zgIZTAsRQyBqeSszZXoRPkUR7X3rfO5
         9xPIBs2IJAI69INl2LdkzJv17QTYvk4DqutnlNPmh9Q18z/Tj24xI6SMsDILAYg6dtlm
         IIg+uFORV8X9S2Ilucub13n6Wptetc07FRJBjvfnZTp6Vej17fH8m+VD4kTSuJBllHPe
         4eGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXl0y4oXfiASEs9RhIlPY59h8kdHJ2MHaBTYmZ04SdsdyY51ABk4KS7XJ5U0lZxb0+HC7dVXI4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6D8KxDCsY3vGvCu7L2dbm3ipXRbhN4XVOYC1ToZsXlsp0nUE2
	ED0chsrnQXJ0R/3Yby6WEYPVF8hWUza+v8s7/kvviKPOT9nxjo9G
X-Google-Smtp-Source: AGHT+IGsunNmXPH6ajgdh5vJdT/YifQG5BM/cJwAIcSh720+aq4JKNF5IWUOSCFesz0UWY/PZJjlIw==
X-Received: by 2002:a17:902:f60b:b0:20c:b401:7489 with SMTP id d9443c01a7336-20cb40175f9mr36272395ad.24.1728706029807;
        Fri, 11 Oct 2024 21:07:09 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c21301dsm30939685ad.199.2024.10.11.21.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 21:07:09 -0700 (PDT)
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
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 02/12] net-timestamp: open gate for bpf_setsockopt
Date: Sat, 12 Oct 2024 12:06:41 +0800
Message-Id: <20241012040651.95616-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20241012040651.95616-1-kerneljasonxing@gmail.com>
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

For now, we support bpf_setsockopt only TX timestamps flags. Users
can use something like this in bpf program to turn on the feature:

flags = SOF_TIMESTAMPING_TX_SCHED;
bpf_setsockopt(skops, SOL_SOCKET, SO_TIMESTAMPING, &flags, sizeof(flags));

Later, I will support each Tx flags one by one based on this.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/sock.h |  2 ++
 net/core/filter.c  | 27 +++++++++++++++++++++++++++
 net/core/sock.c    | 35 ++++++++++++++++++++++++-----------
 3 files changed, 53 insertions(+), 11 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 8cf278c957b3..66ecd78f1dfe 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2890,6 +2890,8 @@ void sock_def_readable(struct sock *sk);
 
 int sock_bindtoindex(struct sock *sk, int ifindex, bool lock_sk);
 void sock_set_timestamp(struct sock *sk, int optname, bool valbool);
+int sock_get_timestamping(struct so_timestamping *timestamping,
+			  sockptr_t optval, unsigned int optlen);
 int sock_set_timestamping(struct sock *sk, int optname,
 			  struct so_timestamping timestamping);
 
diff --git a/net/core/filter.c b/net/core/filter.c
index bd0d08bf76bb..996426095bd9 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5204,10 +5204,30 @@ static const struct bpf_func_proto bpf_get_socket_uid_proto = {
 	.arg1_type      = ARG_PTR_TO_CTX,
 };
 
+static int bpf_sock_set_timestamping(struct sock *sk,
+				     struct so_timestamping *timestamping)
+{
+	u32 flags = timestamping->flags;
+
+	if (flags & ~SOF_TIMESTAMPING_MASK)
+		return -EINVAL;
+
+	if (!(flags & (SOF_TIMESTAMPING_TX_SCHED | SOF_TIMESTAMPING_TX_SOFTWARE |
+	      SOF_TIMESTAMPING_TX_ACK)))
+		return -EINVAL;
+
+	WRITE_ONCE(sk->sk_tsflags[BPFPROG_TS_REQUESTOR], flags);
+
+	return 0;
+}
+
 static int sol_socket_sockopt(struct sock *sk, int optname,
 			      char *optval, int *optlen,
 			      bool getopt)
 {
+	struct so_timestamping ts;
+	int ret = 0;
+
 	switch (optname) {
 	case SO_REUSEADDR:
 	case SO_SNDBUF:
@@ -5225,6 +5245,13 @@ static int sol_socket_sockopt(struct sock *sk, int optname,
 		break;
 	case SO_BINDTODEVICE:
 		break;
+	case SO_TIMESTAMPING_NEW:
+	case SO_TIMESTAMPING_OLD:
+		ret = sock_get_timestamping(&ts, KERNEL_SOCKPTR(optval),
+					    *optlen);
+		if (!ret)
+			ret = bpf_sock_set_timestamping(sk, &ts);
+		return ret;
 	default:
 		return -EINVAL;
 	}
diff --git a/net/core/sock.c b/net/core/sock.c
index 52c8c5a5ba27..a6e0d51a5f72 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -894,6 +894,27 @@ static int sock_timestamping_bind_phc(struct sock *sk, int phc_index)
 	return 0;
 }
 
+int sock_get_timestamping(struct so_timestamping *timestamping,
+			  sockptr_t optval, unsigned int optlen)
+{
+	int val;
+
+	if (copy_from_sockptr(&val, optval, sizeof(val)))
+		return -EFAULT;
+
+	if (optlen == sizeof(*timestamping)) {
+		if (copy_from_sockptr(timestamping, optval,
+				      sizeof(*timestamping))) {
+			return -EFAULT;
+		}
+	} else {
+		memset(timestamping, 0, sizeof(*timestamping));
+		timestamping->flags = val;
+	}
+
+	return 0;
+}
+
 int sock_set_timestamping(struct sock *sk, int optname,
 			  struct so_timestamping timestamping)
 {
@@ -1402,17 +1423,9 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 
 	case SO_TIMESTAMPING_NEW:
 	case SO_TIMESTAMPING_OLD:
-		if (optlen == sizeof(timestamping)) {
-			if (copy_from_sockptr(&timestamping, optval,
-					      sizeof(timestamping))) {
-				ret = -EFAULT;
-				break;
-			}
-		} else {
-			memset(&timestamping, 0, sizeof(timestamping));
-			timestamping.flags = val;
-		}
-		ret = sock_set_timestamping(sk, optname, timestamping);
+		ret = sock_get_timestamping(&timestamping, optval, optlen);
+		if (!ret)
+			ret = sock_set_timestamping(sk, optname, timestamping);
 		break;
 
 	case SO_RCVLOWAT:
-- 
2.37.3


