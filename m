Return-Path: <bpf+bounces-50234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB02A24359
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 20:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CCFE1625BC
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 19:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5BE1F4E2F;
	Fri, 31 Jan 2025 19:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwfdTMZw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBD71F4735;
	Fri, 31 Jan 2025 19:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738351779; cv=none; b=r0EyHhvpGTbHYlgrreuNCjVhwQHblEUoiSHWJFryunD3qS5pf5PHBucm6welrqyEMNfpC9/eEd6QD8hcs5v8DHjCwwhRqVd3K5+lyFuDpMGGCs9u/7UJ4KIZ7UWonDZOTDXSpvUd3xIfgzDw76vSmBbVd1IabZIseJ5mvgaNIgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738351779; c=relaxed/simple;
	bh=+EeiWRNMuZIxJQgj0Fh2A4CN804Wmkb1hmHSFeK94s4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UdXpqjeUTVjprlHECxs0c48eQMs+EPkmm075LyFQQ+t1BJExEwE6kCmyuCtalBIIWxbC7UEB5MLVBP3Yus0yjCa8Fd0YQrUsvmj6WRkljpTv4heWyT779MAcR3Fnc19WsECoHsPF7nUwziYQ6Ozxj5rAfxp19yw5+V1KBOpFwCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwfdTMZw; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2f441791e40so3223625a91.3;
        Fri, 31 Jan 2025 11:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738351777; x=1738956577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VS8kdcfcBAOmk2prWNwmQUyDvDYcTk81Ub9yVHX/RSg=;
        b=iwfdTMZwDF4rrlKNmuFAuUF5GZMSwdTQdWnJfjmMiChphKEq5QyB/b+CZPW6mmUqmV
         h1tTPYHIF5YlGLoy79sa+7q7f63rvDL1doUA1TDsFvo3gVbcktzYoBi/SJYGi1lXRvcd
         Lhb96jwh1fMiATUd7fpPia45NYopQ6cvKwC++CICpKB+SVVCVQXEOBjWTE579CEOiCXZ
         wI6Q+BNNRGW+/OnP9OTcj8qSk2KlO8jkp2AIXnNnUUYAJR8dcNK+7Ov3ynQqB2JzsQhb
         EfIXlrS9DIMfQE0ZheylZNIuHBRex6PrEGgWBk2/LtoSVzBh4rtX4HI22FdOEEmT4L+Q
         e1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738351777; x=1738956577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VS8kdcfcBAOmk2prWNwmQUyDvDYcTk81Ub9yVHX/RSg=;
        b=qYsQeMUIXqO8PV//PMc1ZsJPlnkdVvK4775XPNLQyNoTqqs+ekJKUaSIaPhMtLfkOG
         S7E9xcJojOrCbgrotzdea+FvAy7EBy8CqB9hTld77S0aVUOlFpCNwJ0ZhINKfBlNB4G2
         e13AktDOv57LmZmOT94LhhlvAOFDXl9tLliTjGqp6OrMhJCFldlX/xOKFAWitNi5LdAb
         hlkHdzRvfGVc6ll8o4s3K9t3P5SYbvutMl8n17SOZGj10jRjX3BuwKOJm6b4fMpVfViA
         5mJNKOpMb/GodTq+T3E1JRKFmzBuVXjlZ0oCbyDSM4nwCWRJW6s6xxcPM7t4FK83B1iW
         ddmQ==
X-Gm-Message-State: AOJu0YyRbasnr6D2GY8hewICq0VJOV/4RgGvTuc+UVCqLvIWiPco8lp0
	LeDdA/m/1ym57AuJ46e4bIh0VxVGzWYhxcya9zwIJQMfrqu64NmF7I3e3TS7Qv8=
X-Gm-Gg: ASbGncvTzNptv8D9bGJW1sZd4HY6I+Mdilkqrh9rBpfDV7PyK+FPgMLqpqO7T7OgIx3
	gwnY7jZ+HfgxMxZDJg6lmS9EXGkzsHjWDqlzCU7rctc4w2bsWc1w8WtNDcwrqfTXDMQ/3odrcXi
	YeO/q3vojo2AuGYZ/gZi14aiAbd/LIBVu1MZpJzrpTHDQSDowdOj5VomiKJ9rMbB/QiPfjacluC
	muyk4waWNga0TgK5tqLY1M9a4JDM30xfM2ttH/NMLZl9LHvDV70DJb5ibxmJZVRKQGDelJMa4m+
	mKRixWhQhr8sa7dTBPLfSFH3cv1UdzMj6dMlXhiIv/icK4p+ZU7wEjSz9+kW/0dIIg==
X-Google-Smtp-Source: AGHT+IE1fNqXeyAqXFp+E9U3d3FHqcwhaSz0DfHlzQfmfYDuVsoUiglaU10iwKSfaWQSymOxnnxdRw==
X-Received: by 2002:a17:90b:2e8f:b0:2ee:f80c:687c with SMTP id 98e67ed59e1d1-2f83acafc21mr16858890a91.31.1738351777341;
        Fri, 31 Jan 2025 11:29:37 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f8489d3707sm4072471a91.23.2025.01.31.11.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 11:29:37 -0800 (PST)
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
	cong.wang@bytedance.com,
	jhs@mojatatu.com,
	sinquersw@gmail.com,
	toke@redhat.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com,
	ming.lei@redhat.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 13/18] bpf: net_sched: Support updating qstats
Date: Fri, 31 Jan 2025 11:28:52 -0800
Message-ID: <20250131192912.133796-14-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131192912.133796-1-ameryhung@gmail.com>
References: <20250131192912.133796-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amery Hung <amery.hung@bytedance.com>

Allow bpf qdisc programs to update Qdisc qstats directly with btf struct
access.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 net/sched/bpf_qdisc.c | 53 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 45 insertions(+), 8 deletions(-)

diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index 1f2819e41df8..2427343d8a10 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -36,6 +36,7 @@ bpf_qdisc_get_func_proto(enum bpf_func_id func_id,
 	}
 }
 
+BTF_ID_LIST_SINGLE(bpf_qdisc_ids, struct, Qdisc)
 BTF_ID_LIST_SINGLE(bpf_sk_buff_ids, struct, sk_buff)
 BTF_ID_LIST_SINGLE(bpf_sk_buff_ptr_ids, struct, bpf_sk_buff_ptr)
 
@@ -60,20 +61,37 @@ static bool bpf_qdisc_is_valid_access(int off, int size,
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
@@ -115,6 +133,25 @@ static int bpf_qdisc_btf_struct_access(struct bpf_verifier_log *log,
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
 BTF_ID_LIST(bpf_qdisc_init_prologue_ids)
 BTF_ID(func, bpf_qdisc_init_prologue)
 
-- 
2.47.1


