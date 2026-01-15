Return-Path: <bpf+bounces-79027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09202D242D0
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 12:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D40F30CDB40
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 11:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876E33793DF;
	Thu, 15 Jan 2026 11:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VquaUTE4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E92376BC4
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 11:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768476268; cv=none; b=TNX69oVPbxesz4UYtmoFVoydRQ7obiFaz/qFRr2YzaBGU6zucC+cQngb9LTfbPEgeldEbkHtw5pkbBz+9C8QoE4mdbtrR0GpR87uSVMTb88E3H8HRwSBDWVeJzZ/ndmey5gUkCiKUQxGsgV6MV16C3LADvyZ2I9ZPzhpgOp7UVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768476268; c=relaxed/simple;
	bh=pPH6IGYSvT73W3XnsSk5F+V+bv692q4Zq0EDWpqk/mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7x/PQyFzGpYXA3qMPvzfLEWacCGP2Tdl60G/eqa8/VKG8zbY9ZQ1oXGzjAmObDZKHQfcuyBdujRFG1ezVYQ7qp3hwqvWuSAbXCFHVZ4tXSppTGaZccg+hfPupDRsVcaEYE8bv6JiyeDrVnbF/wVe6Jbm1r+Xy8XlrB4lyI7ctg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VquaUTE4; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-c525de78ebaso325256a12.3
        for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 03:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768476266; x=1769081066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGHQu6mG6lMqPEadRM+ZfBOS3CsIq7QGGssQ90tpvv4=;
        b=VquaUTE47cNMtH4R99nUyNiRvm8ZKI7W4drvLXdZFG1L/XDQlnBCg0qvO7a2TkECck
         yyiA45+r1PBV5xDBt7YeSrMkItoYG9h3MnD5gLsmAeHsnPeWA86Zu+r8d19CECgfWPX4
         1PPISCtSNMTFT+qgixpiEYCFD5tlWA0l+3QVPjdplGV8nyxZxZzxB1kJr4wP16vptClt
         /0N0dikQp438pYIsrDvYXpRfNlltek2QNilk3ecn4QAiA4f40CYJ4amotlr4CFAcZ4nd
         xyQexb8MAWb7tCUCm7+twFzmpgI0osN6iRTz5ec1xuB4iekjbNGj8VLh0jB8hFLhr1j5
         ACBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768476266; x=1769081066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BGHQu6mG6lMqPEadRM+ZfBOS3CsIq7QGGssQ90tpvv4=;
        b=SWXyOkt5uQ9YHpYWt1PsKh3xwQMXS8qoeL8u9sCXqFtStCHqZjJ6lBU1HofwrWqsZR
         U2ZIDNHvLLiyFij/XcJuHixQSAdoiD28FcpEFmlOc78O/okb4g8dox3RW9MAqgVipf+k
         hxf+ZvR3v6AwwwP8xJ4rkXI2SlIezmSSx+CcbwttbiKfzkhQq4VbyvR/S9UHYm2LZMdq
         IvgCyusD8gd8lUkA916qpDiP9fw2roAwL9NgURnDlChbveIyJgKqmfvsIgldbClf30ea
         q1dtpu3EBkX3NhZ37eIyXT341YXEY++LeHvV92McDUiTUQnWn0EMfqmFNBvO8zlnR9e4
         hCzw==
X-Forwarded-Encrypted: i=1; AJvYcCXpSn/MlM2OHkXuBj/3hM16f1WDPa/VPKhrmQQkZLX5EmqlCk8Th9FlgmKXzSMKSZ8RMWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV7bWhHHoJ3bwvUlamGT1fIjHK66oZLW4jp+HXAMyCxUqdG5cD
	RTdke19ZYmo3JIgPjQvq0oq578t3O7E71PsArirul+WaLAhnml3s48z/
X-Gm-Gg: AY/fxX5ZRGmIPO854y3EUugMJq94Y6iZB1fQ0Aw1zsSYYUTsCSoTvd4HeVsscYb0grB
	2LZw9hMJ9xderFaQAl4jbrhANzuHScYAoj0RiI3Sf1MHc3RNxSlf0wg1LBX5Pv8xJPF+mgJd8L7
	mXCNt75C0VK8CWyRgJEAGZMEWZMrr0pz4vei+BEwN06C0SSDTrPrR4s2anhMRai50SLCMDE+SrZ
	wbKGeTTbrYTe4JA23A/2vXlw3h0qGL8GgiLb5miixMQLYEpSoRVZRBjfuNNq8+kMVR5J3qo8dqx
	liTLCQmapEGAwpYJ6umccZHCBR7vRGuoWp6jObCtL6CbF2JeHfuLNdc09DAxZoLQ2yB6U8hY6Sm
	ocxJi7btO1yZfo6S+kGTwS9GOdfOqlQNyUrVfSmQR3aKmD7gZo4xTSb0mnPwXW4dzFo+QdSwS5Z
	+zODYRZqE=
X-Received: by 2002:a17:903:1585:b0:2a0:9b4f:5ebd with SMTP id d9443c01a7336-2a599da5d92mr57640525ad.15.1768476266136;
        Thu, 15 Jan 2026 03:24:26 -0800 (PST)
Received: from 7940hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3ba03f9sm248523225ad.0.2026.01.15.03.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 03:24:25 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	jiang.biao@linux.dev,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v10 09/12] bpftool: add fsession support
Date: Thu, 15 Jan 2026 19:22:43 +0800
Message-ID: <20260115112246.221082-10-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115112246.221082-1-dongml2@chinatelecom.cn>
References: <20260115112246.221082-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add BPF_TRACE_FSESSION to bpftool.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 tools/bpf/bpftool/common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index e8daf963ecef..8bfcff9e2f63 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -1191,6 +1191,7 @@ const char *bpf_attach_type_input_str(enum bpf_attach_type t)
 	case BPF_TRACE_FENTRY:			return "fentry";
 	case BPF_TRACE_FEXIT:			return "fexit";
 	case BPF_MODIFY_RETURN:			return "mod_ret";
+	case BPF_TRACE_FSESSION:		return "fsession";
 	case BPF_SK_REUSEPORT_SELECT:		return "sk_skb_reuseport_select";
 	case BPF_SK_REUSEPORT_SELECT_OR_MIGRATE:	return "sk_skb_reuseport_select_or_migrate";
 	default:	return libbpf_bpf_attach_type_str(t);
-- 
2.52.0


