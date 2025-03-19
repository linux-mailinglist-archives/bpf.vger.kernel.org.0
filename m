Return-Path: <bpf+bounces-54405-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04533A69B8B
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 22:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3581E7B3148
	for <lists+bpf@lfdr.de>; Wed, 19 Mar 2025 21:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870EF21CA00;
	Wed, 19 Mar 2025 21:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lErDvXak"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ACC21B90B;
	Wed, 19 Mar 2025 21:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742421253; cv=none; b=nvlTAuv4FwyQGNgw57h0Td3XCzwRJ8281iqV1gro+Za/WEeTK8hn8cyGOWAq4Hea9dmsKyCy2flzO42FDR0upQXugRqOkrxoJX0Y/0yFbF8ltklYkZanJLMK/XmPxRFfcX3LikBHN5onrbEc1VyOJ6qocSWEaF9cEA0feBUHIlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742421253; c=relaxed/simple;
	bh=MKY8DDHg1nLkWceCGBdbkxFs4pXbBDDZ21a5MpLI0LY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tSP9ERpY/AKZ1kq4NypCV2gQ1pKMmd8IIXIqu3WPzY8rGKH1GjoSLAbnmV94NYSc2aKpy+uQL5LgfDGUaVl7MoURxkdKz/6whXjd2CYEWrw8C5o7FGRKIAEm2TYg1g8O/3iXHs8068fwttFaxb2yUJY3RS8qIn6q3huYM9zZAzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lErDvXak; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22398e09e39so716875ad.3;
        Wed, 19 Mar 2025 14:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742421251; x=1743026051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dIlOPDqec1+k+Ika4W2J3cSnlzDPm3T0b07QKZ3Ghzk=;
        b=lErDvXakL3TeTAGAPFHeYxxfvPI2BdmcL9gKV1AWwDS1AObikCKgD0YafGHcZbsAHE
         875pOBjH6gMmzeuncBehME8TV8Sf04VSH9G8GGfYpgaLJaPIN6INys9NmXp6JKWZ8n4O
         TASuEW2YbBTEpVgo6w6tzTGHF/iIZIloo/8+iP07RmQDrjgXCxXw2wxGvaotNJo6ES69
         mxhNCnDrT30pf84Cok4RT4kqxAK4BH6NA1Ga5IyEXQMTWx7c8akukZAfghp/kHZ/b+d8
         JMI82f/4LGQFbGWOAqFs6LplKkfGALkhLsgHx5VYYrBBirVgXv+5bzU4jqlF1HD8wxYL
         xHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742421251; x=1743026051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dIlOPDqec1+k+Ika4W2J3cSnlzDPm3T0b07QKZ3Ghzk=;
        b=HTLjCUeKVYdKyvUM6RyGxeWBgGn0cYoSPMyiqd2+Tx73tq/isY2RiofnHnpgyuO42n
         Ep2I7tXLYaH9tZaPvPoozsGPg+S4Oy93Mri43CRP2+bQn+8MdawwHvxCnujH2+eiM3sw
         GV/2jxURNNlw/XKFOH09yS5CSrDHCyAi1byu9b61Qp/u2NDQ6FU5yOWABJBOHZKCnJjx
         Utc1EUrdEc2PeXqc3J3Ocbm8NrLI1FpFCGtV9gKkhLG5AekgF9YY8tPu+aLJv3mol2VJ
         g2Ag318b5rJrzbgulucUrX95QfFGLQEETXR5ReUtoBmqpS4yo2a35E9YoD9nGlF6Hf+v
         acew==
X-Gm-Message-State: AOJu0YzwyFAAIKWT6t6AECoDj73h1BBHD+uDHVhTh0IQG7YX0jJNDpfM
	wa5rgSeobz+E+Pcj/pYtgaMOPq/VJodO17OMmwksD1knokjuV03XbOUk1u6pbsg=
X-Gm-Gg: ASbGnctf1hknJPzkDvG17PWR9AdNhlAp3Oa5jomD7b+xylvY5+aw/Noey37WioEIEyb
	8wB803HheEDJvXbOpDwnP8KCmSFHZCRDYvyZMIBQ7RfVJbQQaKf2avlIqyawjKs0CiDYgPFh4T9
	vn0SBmPwk8wy3rxwIdvTGG2e2lyGiOupN3tk1eHUka19i0grh6JiaG4alu1UuYdIIzLXdNorlTV
	AiHmlYJj0d7YDTNbU1dPP2jSdN4ndEw6ftyuCocHwiu/20/AlRJQ4K5TFbk+n61+HsRMbCLzQvW
	/PWp/GgCnWFSQQ+13zmhBLT6H4/AQ0DSWg7ptA79bgPTIBJwkRzGgziPC0cMcBkePRzvtlXxQM5
	qxEgFACzTjkX1AgkCc8OgcrWeIao8bQ==
X-Google-Smtp-Source: AGHT+IHRX0z+uj0xHOydDCZhhYWAgsW3VCrsJryhFtiQxw0CDBgXU+EmbZ3/JrZ0V5lmMq8aDrhrwA==
X-Received: by 2002:aa7:888a:0:b0:72f:590f:2859 with SMTP id d2e1a72fcca58-7377a869447mr1250494b3a.13.1742421250613;
        Wed, 19 Mar 2025 14:54:10 -0700 (PDT)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737116b0e8asm12175596b3a.158.2025.03.19.14.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 14:54:10 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	kuba@kernel.org,
	edumazet@google.com,
	xiyou.wangcong@gmail.com,
	jhs@mojatatu.com,
	sinquersw@gmail.com,
	toke@redhat.com,
	juntong.deng@outlook.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v6 02/11] bpf: Prepare to reuse get_ctx_arg_idx
Date: Wed, 19 Mar 2025 14:53:49 -0700
Message-ID: <20250319215358.2287371-3-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250319215358.2287371-1-ameryhung@gmail.com>
References: <20250319215358.2287371-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Rename get_ctx_arg_idx to bpf_ctx_arg_idx, and allow others to call it.
No functional change.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
Acked-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/linux/btf.h | 1 +
 kernel/bpf/btf.c    | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index ebc0c0c9b944..b2983706292f 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -522,6 +522,7 @@ bool btf_param_match_suffix(const struct btf *btf,
 			    const char *suffix);
 int btf_ctx_arg_offset(const struct btf *btf, const struct btf_type *func_proto,
 		       u32 arg_no);
+u32 btf_ctx_arg_idx(struct btf *btf, const struct btf_type *func_proto, int off);
 
 struct bpf_verifier_log;
 
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 519e3f5e9c10..9a4920828c30 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6369,8 +6369,8 @@ static bool is_int_ptr(struct btf *btf, const struct btf_type *t)
 	return btf_type_is_int(t);
 }
 
-static u32 get_ctx_arg_idx(struct btf *btf, const struct btf_type *func_proto,
-			   int off)
+u32 btf_ctx_arg_idx(struct btf *btf, const struct btf_type *func_proto,
+		    int off)
 {
 	const struct btf_param *args;
 	const struct btf_type *t;
@@ -6649,7 +6649,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 			tname, off);
 		return false;
 	}
-	arg = get_ctx_arg_idx(btf, t, off);
+	arg = btf_ctx_arg_idx(btf, t, off);
 	args = (const struct btf_param *)(t + 1);
 	/* if (t == NULL) Fall back to default BPF prog with
 	 * MAX_BPF_FUNC_REG_ARGS u64 arguments.
-- 
2.47.1


