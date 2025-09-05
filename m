Return-Path: <bpf+bounces-67535-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 847EDB44DEF
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 08:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D0293B1372
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 06:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B06296BB4;
	Fri,  5 Sep 2025 06:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IJTDOrtr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1E1163
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 06:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757053744; cv=none; b=c+/48iCFRbLddW3p+Zwo90fKHrKv3Yw/HZ5FQjNClarNBYkIVxzK/QT+Nc0fcdWftKNA6kdqDg45B53aLHu4TJOEcXH4eZ+VV+l2oLc1VVHhX8vO7gNq5PjvJc1CDtjJf3AxhmbTu9/E37uVgvyyTrxaoYrqzAIVh8kBXWXogIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757053744; c=relaxed/simple;
	bh=gfJRbikb0ekx2YTNx34O2c3XXHN3te3xpOC72g4USQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2egGSgWR/vOPOeZXP0D3HfmP76N9mSQ/CvdMRlO7sDOhOgGdQS/71IZSLmZZeSo/qE5Rt5F7jLvBEJ3/ECgnj53OkrJ0fBzG1IswNfd4K72049XZKlSRnHK4koy+mH4kfaMILobPItdAI1Jmaxd9sai0JL0Ym6ZI1xBoO60sAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IJTDOrtr; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24cca557085so85705ad.1
        for <bpf@vger.kernel.org>; Thu, 04 Sep 2025 23:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757053741; x=1757658541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5DLbuU053Lizo2FBLBClYJ/JWnxw3AQ5GhavFtXqqoE=;
        b=IJTDOrtrJ6MbxIi+YdSMc03ckPRMIVnrgvJCc6dJ6IP/iTcOEwJzP0cxDzv9577gUP
         pLB/aJqN2iYJCb5Sd+8ZVnsXTyuTLP/WjW95bKMvfiBnNGNPHlwbPyOvEkswhq6FbvGV
         VLmRjRuW2qcJc0+R6RH1+AQxwlwUdMWBwMQFzDIXAlN+UeYDifLncbC3j20IByjP4vOZ
         n4FRwPITrdYEdeaU8exEc+B9yepxn6KVcVtQWVppTpcylmCot/41fMbkeOzMGCDGGKqw
         lZlMRyFaKzMj3lMGZIfPratzbJhf/PR0IgxDxKBQU1fG8evSGnF4meF/wF68azwkEIpi
         VBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757053741; x=1757658541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5DLbuU053Lizo2FBLBClYJ/JWnxw3AQ5GhavFtXqqoE=;
        b=K9HuMnIVLczaTOyvjHnb6iOnil99vMIdE6G3d9fIYR0q3yu39Madwd85X+N36BR52+
         i/Xc0S3HGnwWBPdhg+XCstFsNnZ69r6UlnBY/2mYZrnUMycnzhwwOMyd+0QGczY3NQ7r
         P2jgP4pYTrVljdjonCtnbG9mPdPdEg2noYm+D/Jxe9nvm23CTiAOd2vSB46Sx2/8PxsS
         MKtbynEBbDXpGtdA1M4PvhYgUsmx80U+QBv04wwcIZdXTRNs8zKa7iw7mfpzKuqYRjhE
         XuOwuiyqRA/xoymFTgqmVaiuw9am8YxjPnFQscEJPcv6klS4weCIz0HUrtcfJ6uZZjub
         mTKQ==
X-Gm-Message-State: AOJu0YwJlui0xzcA7hoTNWyvLqOn9ne3JUwVUrQ8yg0JWWE9vhi76JOD
	cnrZJb0cqv+eVVis6rYvRqzzP0Pvg+jzx9NBSa7LllG+OhdXT4A3Yrkrf/WvI9e75r3bhhzQC31
	ST1BKuA==
X-Gm-Gg: ASbGncuATGv/VEsgPEs0n7PgUutRCKDiUA0qSiBPtZ3mBfnE5bc1lFz6NJTX9pW+LxO
	OcZzICI7+lTd9RpdJYzrzCEmeTqFYI/l7iSG/QdBXvFUHZw3cTnad5Kysh9Kz2e5WJpl0b065KZ
	tirp2qxK8av7w7Oyklgl4GviVp52lLIb0YZy0HqDpbCE1cLSpXgwCiRzTQ7wm+8di0ispGEbjOn
	R2XqWIoQjxiZmnuTYuiZ91L8Swv4wPXnGF1nAJS6Em3Sh7bdQeqTLUvkdy0lTjIBlGh2PVgAxhT
	M0Z10FjexyzEhHmaXnvhEHtI6/8FlI+2qkyR84INF8JO5hqtUkxitqMWrpv92bV13dLxFQ3w4hF
	cXpvQjQUNaJEr7Th38yTHfbXcNveKlZaQnCG7myp4dtkzgLwCXpvblovduSvMBTeCZUpPNa8UeP
	J8wg==
X-Google-Smtp-Source: AGHT+IHq0pcP9NBh+zEw005wzTnkeBhaoCbBzKMYbKM1lCUrrZ4F3m+Xq9YCjYCYFtq6N/2/ucQ5Kw==
X-Received: by 2002:a17:902:c40a:b0:248:7b22:dfb4 with SMTP id d9443c01a7336-24cf5c4af0emr3502385ad.16.1757053740794;
        Thu, 04 Sep 2025 23:29:00 -0700 (PDT)
Received: from google.com (132.192.16.34.bc.googleusercontent.com. [34.16.192.132])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ce20ea7cbsm22252205ad.28.2025.09.04.23.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 23:29:00 -0700 (PDT)
Date: Fri, 5 Sep 2025 06:28:55 +0000
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>
Subject: Re: [PATCH bpf] bpf/helpers: Skip memcg accounting in
 __bpf_async_init()
Message-ID: <aLqDJ0v-pG855N4p@google.com>
References: <20250905061919.439648-1-yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905061919.439648-1-yepeilin@google.com>

Hi all,

On Fri, Sep 05, 2025 at 06:19:17AM +0000, Peilin Ye wrote:
> The above was reproduced on bpf-next (b338cf849ec8) by modifying
> ./tools/sched_ext/scx_flatcg.bpf.c to call bpf_timer_init() during
> ops.runnable(), and hacking [1] the memcg accounting code a bit to make
> it (much more likely to) raise an MEMCG_MAX event from a
> bpf_timer_init() call.

FWIW, below are changes I made to scx_flatcg.bpf.c to reproduce the
hardlockup.  Please let me know if there's more info that I can provide.

Thanks,
Peilin Ye

--- a/tools/sched_ext/scx_flatcg.bpf.c
+++ b/tools/sched_ext/scx_flatcg.bpf.c
@@ -504,8 +504,31 @@ static void update_active_weight_sums(struct cgroup *cgrp, bool runnable)
 		cgrp_refresh_hweight(cgrp, cgc);
 }

+struct __bpf_timer {
+	struct bpf_timer timer;
+};
+#define NUM_BPF_TIMERS	10
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, NUM_BPF_TIMERS);
+	__type(key, u32);
+	__type(value, struct __bpf_timer);
+} timer_map SEC(".maps");
+int count = 0;
+
 void BPF_STRUCT_OPS(fcg_runnable, struct task_struct *p, u64 enq_flags)
 {
+	if (count < NUM_BPF_TIMERS) {
+		struct bpf_timer *timer;
+		u32 key = count;
+
+		timer = bpf_map_lookup_elem(&timer_map, &key);
+		if (!timer)
+			return;
+		bpf_timer_init(timer, &timer_map, CLOCK_MONOTONIC);
+		count++;
+	}
+
 	struct cgroup *cgrp;

 	cgrp = __COMPAT_scx_bpf_task_cgroup(p);


