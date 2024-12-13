Return-Path: <bpf+bounces-46954-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7F69F1A0D
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 00:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7599316B36A
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 23:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D491F4716;
	Fri, 13 Dec 2024 23:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="O90NrWUd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E87E1F03F2
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 23:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734132613; cv=none; b=aQ2v3MPJMoZHLSZsGnzdYrPUSsuXYVaJO4fmMAVaOo+fMmAofb72qBehWNfu8DS366FB/jhwIiTIGdH5fcodIsLgArYjFbxab4nq+6CoLtKgM5elKrM2SuxZKbQU773DQE5NEoNIhkiAdm/g5CK7prWdH5fgUUWc0nI3wI9P6eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734132613; c=relaxed/simple;
	bh=X+t8gDEwNbFCtVM95/5isGpSKd5GAziNVGIkVSSzfPg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qkOrhHaFRo9q7sOzQ/JJT2p05A9lI3cKntTDAwBhxlBH/WIQCpidfYE+Bdk9dyDg3oF3ZGaqljUl81CDZ673sBtHcOqjPMt6f+WaZNBh5/UPWce9j5slRKGOHboPW2A5MGDI5K5/zsVlEM0KcUFvL8y2nymmcQXoYX+5qCsIbfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=O90NrWUd; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b6ff72ba5aso81710585a.1
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 15:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734132611; x=1734737411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exqCsIoLkuY4OTkf+/hY3xBxRD9kSVmRMozwdnr8pz8=;
        b=O90NrWUd4Bnr8pX5fjseoTNFdwK+KJvnmyvPupOeSzTDY2osw7LwnZb+/MSHO58Idw
         l2meNhiaJ3qBlBG6g2UrF7ZVe3ilKU3j/PM9h6Cp4Miq07WhZW0FsE7yvLcAvBKzgeYU
         Lska9uXft6POELeMJ9agF1go82UslmttA6wbaaPHbUcsIJSDrpA35hi+x+keeeX7ZXiX
         UI2Ld4Ywd9JqD5L7DbOWxFNoarQO7NVW+SCwKVfVTWT1oYPhpRSv3JOYHcbxUfIpLZzL
         DtyT2euuaFXOlTzv9vR3IaHMPTHfEjtOem12q2k7X83TFRk2CKseB1BfJ1kMtPFLGyRt
         uMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734132611; x=1734737411;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exqCsIoLkuY4OTkf+/hY3xBxRD9kSVmRMozwdnr8pz8=;
        b=RGLoZkHl6JJV2YwWKmxA0VJv5o+xugcmRDiuJ/uR0FY0TU2BW9GiGSUvh52hHWUogL
         7iZVow7f/DlrzMYawr3Bhd49BWxFd9WHTIU0xgxb+C1g+D1HC8Rc9UoMijiAjHF9XcNH
         5ngEa5bJVCDqKvNYbxWsC3o4KSvKlOWMsGnRsxpcdPosLZcC4lC9Ywu6+lrOP+OUalFX
         U5D8myYvgmnm5iZBGzyWbo3/5ZlbcFk9fm7wanisauqdavtFdGZL1ePBExqvWBNtpNyf
         TmK/nxYd8YOLx2yONrELx4vYgNeigZukjtJW7ICZdLFEMqh3TF1yKbOsiR1xc8ok1H9m
         xbCQ==
X-Gm-Message-State: AOJu0YzfTCqns/VzZag77ngsp1kEvGLjIeLL5z2il8Po+2yozVjRPEnz
	vGC8RVM9ZvvsopKBDrzCe0cOfpoHFRDnJ2HbhDTg72ycuPEXJo3g8nbBKsh+vIl5rKk7yvn4yBt
	VHB4=
X-Gm-Gg: ASbGncvavKlYI1cs9xPXQCdTtEFxRDYFI2x54dFPOD0zNcN9D+SFWaqZ46PXOWk1i/P
	qRQs4ew7PR9uWdCWuJ+dCZ/epegkw/Yt349jQjYPuo3z7KxEZODtGzGr7MI2NnSdZIRK5NJqB2J
	PiA11989gCK87ylTGYlbZ0RlaRFkcc3eC5tp11qyOGiW3UxpRTzOmXIel9OfA5xlOs5GHJnrb3k
	PhLZyoipLTdIAlfYy9LKiiqAAJR8pd4o/ITRHrVwewKImcdFFvMxWGToQxDt+PC4n3Mq3nYk3Mk
X-Google-Smtp-Source: AGHT+IHabF5pqAFjUWYISSxmqI352ucWV5AJ52EofqpegSXFLtjrENmjqVDxwaeJ37QzD1+hNQ84fA==
X-Received: by 2002:a05:620a:28cc:b0:7b6:6ffc:e972 with SMTP id af79cd13be357-7b6fbec7990mr742243185a.5.1734132611374;
        Fri, 13 Dec 2024 15:30:11 -0800 (PST)
Received: from n36-183-057.byted.org ([130.44.215.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b7047d4a20sm25805085a.39.2024.12.13.15.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 15:30:11 -0800 (PST)
From: Amery Hung <amery.hung@bytedance.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com
Subject: [PATCH bpf-next v1 09/13] bpf: net_sched: Support updating qstats
Date: Fri, 13 Dec 2024 23:29:54 +0000
Message-Id: <20241213232958.2388301-10-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241213232958.2388301-1-amery.hung@bytedance.com>
References: <20241213232958.2388301-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow bpf qdisc programs to update Qdisc qstats directly with btf struct
access.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 net/sched/bpf_qdisc.c | 53 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 45 insertions(+), 8 deletions(-)

diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index b5ac3b9923fb..3901f855effc 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -57,6 +57,7 @@ bpf_qdisc_get_func_proto(enum bpf_func_id func_id,
 	}
 }
 
+BTF_ID_LIST_SINGLE(bpf_qdisc_ids, struct, Qdisc)
 BTF_ID_LIST_SINGLE(bpf_sk_buff_ids, struct, sk_buff)
 BTF_ID_LIST_SINGLE(bpf_sk_buff_ptr_ids, struct, bpf_sk_buff_ptr)
 
@@ -81,20 +82,37 @@ static bool bpf_qdisc_is_valid_access(int off, int size,
 	return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
 }
 
-static int bpf_qdisc_btf_struct_access(struct bpf_verifier_log *log,
-					const struct bpf_reg_state *reg,
-					int off, int size)
+static int bpf_qdisc_qdisc_access(struct bpf_verifier_log *log,
+				  const struct bpf_reg_state *reg,
+				  int off, int size)
 {
-	const struct btf_type *t, *skbt;
 	size_t end;
 
-	skbt = btf_type_by_id(reg->btf, bpf_sk_buff_ids[0]);
-	t = btf_type_by_id(reg->btf, reg->btf_id);
-	if (t != skbt) {
-		bpf_log(log, "only read is supported\n");
+	switch (off) {
+	case offsetof(struct Qdisc, qstats) ... offsetofend(struct Qdisc, qstats) - 1:
+		end = offsetofend(struct Qdisc, qstats);
+		break;
+	default:
+		bpf_log(log, "no write support to Qdisc at off %d\n", off);
+		return -EACCES;
+	}
+
+	if (off + size > end) {
+		bpf_log(log,
+			"write access at off %d with size %d beyond the member of Qdisc ended at %zu\n",
+			off, size, end);
 		return -EACCES;
 	}
 
+	return 0;
+}
+
+static int bpf_qdisc_sk_buff_access(struct bpf_verifier_log *log,
+				    const struct bpf_reg_state *reg,
+				    int off, int size)
+{
+	size_t end;
+
 	switch (off) {
 	case offsetof(struct sk_buff, tstamp):
 		end = offsetofend(struct sk_buff, tstamp);
@@ -136,6 +154,25 @@ static int bpf_qdisc_btf_struct_access(struct bpf_verifier_log *log,
 	return 0;
 }
 
+static int bpf_qdisc_btf_struct_access(struct bpf_verifier_log *log,
+				       const struct bpf_reg_state *reg,
+				       int off, int size)
+{
+	const struct btf_type *t, *skbt, *qdisct;
+
+	skbt = btf_type_by_id(reg->btf, bpf_sk_buff_ids[0]);
+	qdisct = btf_type_by_id(reg->btf, bpf_qdisc_ids[0]);
+	t = btf_type_by_id(reg->btf, reg->btf_id);
+
+	if (t == skbt)
+		return bpf_qdisc_sk_buff_access(log, reg, off, size);
+	else if (t == qdisct)
+		return bpf_qdisc_qdisc_access(log, reg, off, size);
+
+	bpf_log(log, "only read is supported\n");
+	return -EACCES;
+}
+
 __bpf_kfunc_start_defs();
 
 /* bpf_skb_get_hash - Get the flow hash of an skb.
-- 
2.20.1


