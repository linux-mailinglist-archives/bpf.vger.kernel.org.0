Return-Path: <bpf+bounces-43293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 033FF9B2E80
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 12:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6E75281829
	for <lists+bpf@lfdr.de>; Mon, 28 Oct 2024 11:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26861DFE07;
	Mon, 28 Oct 2024 11:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+AHA0EC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6EA1DFE01;
	Mon, 28 Oct 2024 11:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730113626; cv=none; b=Jy7ju3ncUUstJBN28pOseAiO7owJxGUz9F82/O6ZdkwfNjEobTg9/PEgJp194wHeoHprw8dM4OSGpesjj4a+fLyrWSiMv62/qIJ3DgKFz19gRDRY6Byj6+iKzKzGGJLveo407gVDs9je3Sz+iF4FXaV7VeVsQryM1q8UC1DOFQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730113626; c=relaxed/simple;
	bh=XBmnYsSBTTPrzwxBBYJMcNlST4Xeejiqpv4MDPTBvk0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T9eLHFl4tZnRzaBtbj1V9uM99MnxOYbO7Wn8qcEv1af28FfXlihj0/TZh68zsmgV+gaRpP6JmIxBXyj+vpB9UTzDHh6AIakE/pYaY9N15z3x2asoaGCIf+AmU0gE2Cj/tD50HzEhlenETReivPFV93yPzutf/8+KvDe7ifAP5vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+AHA0EC; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20ca388d242so35729195ad.2;
        Mon, 28 Oct 2024 04:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730113623; x=1730718423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NC5GVXGcuS1Kp7TK5CceZH6IPo60SK9yqzbyaAVCeVs=;
        b=f+AHA0ECXEilttliZCNzRAXUNhxQUFH16owIb5C1aUPzjcsyZoXty8qFSsZ+6PEk7d
         C8GiO5yeYTJS3mTQ8X/9qzN5FBJAblrug4D6Qpe0jpOXt7g34qv+VDJgRw31wQvBONvw
         AHo4OIpL7Pra+zjXPpLsog1pRuhqChW3rWXX6IHIZ0A8DNlSCqoerId8oG8unsTmO/gD
         viWZ+amxuHjQ/1cn5SYV07JLtvCLdIxs1YcZhmdeJcCrfAAHpjanzgRm4TjGdtpATsTG
         y2fw6B4FcmcLsZq5uN+Tm88U0PBIrlb4VuyylKl3YxSRWtyh5qDb49dJiriwYx2pxCr7
         Moxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730113623; x=1730718423;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NC5GVXGcuS1Kp7TK5CceZH6IPo60SK9yqzbyaAVCeVs=;
        b=NtHBrAW8JMlR1aOwyTPDHWNGDhMX5V0Y3xLsnuHCrnDmTG8D4W+NEKtFYovQN5fuIR
         CieTUnaLfMdHcu9tvtA08RtsiG5Z62UfIQlNOuoETJi4CtIW2P7wsucNRHF9VCC155nR
         95EInozB56phN/zyCj/CpuHMmtzBlEaF0N/I5lB4Y+7mhC657kR4Afeo2DduX4/0RKBh
         APwCzKSqW6oepadM3n/ji/Jr3MhCm5bS2Y74iukdS3/Pwa0w045EKwvVl0gEL2zNMDkZ
         hhsQsvCq9OvxowSfJMpTdCqh0t53hyKWrbcVXXLh1VzAMsgZzBCcQCCSnsGCN8rlXZmp
         2Ldg==
X-Forwarded-Encrypted: i=1; AJvYcCWeUVRbjElAqGxk8Bvv+J5Zs2HHhHzaeZMCdXaJU2CKOaHMsBLE2fnozAb0ckAjrj6baJm2/3k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2wBiDuI5oNSu/OEvvdd23CUuAPYQSGvgUiwiRAo2ije+4OYsu
	aqsuJ2d1rzh2DWRg2Bk1dX8y+rfUnJVNbgoFrqMZ+5DO/C0VRqFF
X-Google-Smtp-Source: AGHT+IHq1X9Osaq2l+2tjGe7AdiNaCtB4n4/lzINaZx0TA89RREj1vdGgXgen8nPjGcJeYeewvFSAw==
X-Received: by 2002:a17:902:d4c9:b0:20b:7e1e:7337 with SMTP id d9443c01a7336-210c689ab32mr122394515ad.13.1730113623150;
        Mon, 28 Oct 2024 04:07:03 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bc04bdb6sm48130905ad.255.2024.10.28.04.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 04:07:02 -0700 (PDT)
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
Subject: [PATCH net-next v3 10/14] net-timestamp: add basic support with tskey offset
Date: Mon, 28 Oct 2024 19:05:31 +0800
Message-Id: <20241028110535.82999-11-kerneljasonxing@gmail.com>
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

Use the offset to record the delta value between current socket key
and bpf socket key.

1. If there is only bpf feature running, the socket key is bpf socket
key and the offset is zero;
2. If there is only traditional feature running, and then bpf feature
is turned on, the socket key is still used by the former while the offset
is the delta between them;
3. if there is only bpf feature running, and then application uses it,
the socket key would be re-init for application and the offset is the
delta.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/sock.h |  1 +
 net/core/skbuff.c  | 15 ++++++++---
 net/core/sock.c    | 66 ++++++++++++++++++++++++++++++++++++++--------
 3 files changed, 68 insertions(+), 14 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 91398b20a4a3..41c6c6f78e55 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -469,6 +469,7 @@ struct sock {
 	unsigned long		sk_pacing_rate; /* bytes per second */
 	atomic_t		sk_zckey;
 	atomic_t		sk_tskey;
+	u32			sk_tskey_bpf_offset;
 	__cacheline_group_end(sock_write_tx);
 
 	__cacheline_group_begin(sock_read_tx);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 0b571306f7ea..d1739317b97d 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5641,9 +5641,10 @@ void timestamp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *args)
 }
 
 static void skb_tstamp_tx_output_bpf(struct sock *sk, int tstype,
+				     struct sk_buff *skb,
 				     struct skb_shared_hwtstamps *hwtstamps)
 {
-	u32 args[2] = {0, 0};
+	u32 args[3] = {0, 0, 0};
 	u32 tsflags, cb_flag;
 
 	tsflags = READ_ONCE(sk->sk_tsflags_bpf);
@@ -5672,7 +5673,15 @@ static void skb_tstamp_tx_output_bpf(struct sock *sk, int tstype,
 		args[1] = ts.tv_nsec;
 	}
 
-	timestamp_call_bpf(sk, cb_flag, 2, args);
+	if (tsflags & SOF_TIMESTAMPING_OPT_ID) {
+		args[2] = skb_shinfo(skb)->tskey;
+		if (sk_is_tcp(sk))
+			args[2] -= atomic_read(&sk->sk_tskey);
+		if (sk->sk_tskey_bpf_offset)
+			args[2] += sk->sk_tskey_bpf_offset;
+	}
+
+	timestamp_call_bpf(sk, cb_flag, 3, args);
 }
 
 void __skb_tstamp_tx(struct sk_buff *orig_skb,
@@ -5683,7 +5692,7 @@ void __skb_tstamp_tx(struct sk_buff *orig_skb,
 	if (!sk)
 		return;
 
-	skb_tstamp_tx_output_bpf(sk, tstype, hwtstamps);
+	skb_tstamp_tx_output_bpf(sk, tstype, orig_skb, hwtstamps);
 	skb_tstamp_tx_output(orig_skb, ack_skb, hwtstamps, sk, tstype);
 }
 EXPORT_SYMBOL_GPL(__skb_tstamp_tx);
diff --git a/net/core/sock.c b/net/core/sock.c
index 42c1aba0b3fe..914ec8046f86 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -891,6 +891,49 @@ static int sock_timestamping_bind_phc(struct sock *sk, int phc_index)
 	return 0;
 }
 
+/* Used to track the tskey for bpf extension
+ *
+ * @sk_tskey: bpf extension can use it only when no application uses.
+ *            Application can use it directly regardless of bpf extension.
+ *
+ * There are three strategies:
+ * 1) If we've already set through setsockopt() and here we're going to set
+ *    OPT_ID for bpf use, we will not re-initialize the @sk_tskey and will
+ *    keep the record of delta between the current "key" and previous key.
+ * 2) If we've already set through bpf_setsockopt() and here we're going to
+ *    set for application use, we will record the delta first and then
+ *    override/initialize the @sk_tskey.
+ * 3) other cases, which means only either of them takes effect, so initialize
+ *    everything simplely.
+ */
+static long int sock_calculate_tskey_offset(struct sock *sk, int val, int bpf_type)
+{
+	u32 tskey;
+
+	if (sk_is_tcp(sk)) {
+		if ((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN))
+			return -EINVAL;
+
+		if (val & SOF_TIMESTAMPING_OPT_ID_TCP)
+			tskey = tcp_sk(sk)->write_seq;
+		else
+			tskey = tcp_sk(sk)->snd_una;
+	} else {
+		tskey = 0;
+	}
+
+	if (bpf_type && (sk->sk_tsflags & SOF_TIMESTAMPING_OPT_ID)) {
+		sk->sk_tskey_bpf_offset = tskey - atomic_read(&sk->sk_tskey);
+		return 0;
+	} else if (!bpf_type && (sk->sk_tsflags_bpf & SOF_TIMESTAMPING_OPT_ID)) {
+		sk->sk_tskey_bpf_offset = atomic_read(&sk->sk_tskey) - tskey;
+	} else {
+		sk->sk_tskey_bpf_offset = 0;
+	}
+
+	return tskey;
+}
+
 int sock_set_tskey(struct sock *sk, int val, int bpf_type)
 {
 	u32 tsflags = bpf_type ? sk->sk_tsflags_bpf : sk->sk_tsflags;
@@ -901,17 +944,13 @@ int sock_set_tskey(struct sock *sk, int val, int bpf_type)
 
 	if (val & SOF_TIMESTAMPING_OPT_ID &&
 	    !(tsflags & SOF_TIMESTAMPING_OPT_ID)) {
-		if (sk_is_tcp(sk)) {
-			if ((1 << sk->sk_state) &
-			    (TCPF_CLOSE | TCPF_LISTEN))
-				return -EINVAL;
-			if (val & SOF_TIMESTAMPING_OPT_ID_TCP)
-				atomic_set(&sk->sk_tskey, tcp_sk(sk)->write_seq);
-			else
-				atomic_set(&sk->sk_tskey, tcp_sk(sk)->snd_una);
-		} else {
-			atomic_set(&sk->sk_tskey, 0);
-		}
+		long int ret;
+
+		ret = sock_calculate_tskey_offset(sk, val, bpf_type);
+		if (ret <= 0)
+			return ret;
+
+		atomic_set(&sk->sk_tskey, ret);
 	}
 
 	return 0;
@@ -956,10 +995,15 @@ static int sock_set_timestamping_bpf(struct sock *sk,
 				     struct so_timestamping timestamping)
 {
 	u32 flags = timestamping.flags;
+	int ret;
 
 	if (flags & ~SOF_TIMESTAMPING_BPF_SUPPPORTED_MASK)
 		return -EINVAL;
 
+	ret = sock_set_tskey(sk, flags, 1);
+	if (ret)
+		return ret;
+
 	WRITE_ONCE(sk->sk_tsflags_bpf, flags);
 
 	return 0;
-- 
2.37.3


