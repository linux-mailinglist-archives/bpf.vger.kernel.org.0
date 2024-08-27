Return-Path: <bpf+bounces-38119-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A7C95FE5F
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 03:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A8C11C21BAB
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 01:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E736C79DC;
	Tue, 27 Aug 2024 01:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XGzyspfO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6827BE5D
	for <bpf@vger.kernel.org>; Tue, 27 Aug 2024 01:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724722753; cv=none; b=j8gPofg24tmld1SWzefV5NBl/de9nosp4Psn+o08bG9NTbF50cahecqdSD5zTkFxOCDT/SbotnvwtZkefwOulauK99BdEdc5qArT7VmCXQWllvP5dUJ/5/j8FhTqohdRs6s0rZo2k/zqj3aFt8fSVNQTGTyXRFaH+bMKV+WC/zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724722753; c=relaxed/simple;
	bh=v3fq1KW4aEZUuFi/YTksAUajn0gmDL0v4Km51mhcyR0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lBhh/lLO5miJMgERZjzHZr78uFIWSj5+8f6E5MvfohkslBhnEqXpf+7J2T+ct81DPpbCSBSOt0WTkr/d2lmI3YD8Fb+YzCVa40HmSFwBJ7qXgbLQP/lCaPtloPloMe8kkgHntBTN/ZGmOlEdxGO5rU5w1Cx0ke06rdsoQ2nKxbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XGzyspfO; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5daa93677e1so3830213eaf.3
        for <bpf@vger.kernel.org>; Mon, 26 Aug 2024 18:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724722750; x=1725327550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+KCk/g2sbZA8Uv+3d3NhCpjCZnAuMknzU3OmgDY2yvs=;
        b=XGzyspfODawRUVYbEIXpW3x1P5nyEgd5KbzdHwRV23IrIwr+UXnA2hUsOtpjbWqvLk
         T9Vw7Z8/xgvYdWhSWftia68MHXpQyx+AWbWc1nrwwepLMvR4EoOFcj342PT2uLoA+jfz
         fI32v93MkuTrePr26CeIiUinLI6mtT7xf02CmaZUardxUKynxHjOaj7PhqY+rC2wKok6
         8QI5zVnfg9JSZclAq+oy6ER15hOlqdJbGkIxV+km2pDFvkJjkKY5+yt10c3UZQgVZZ02
         Plr4CwMmj1YrKk6lTAtWQGPGlsTbSCWvZ7wIQALfjedqRRUdjB2GzquqU1MXbrrrzIBg
         iOOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724722750; x=1725327550;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+KCk/g2sbZA8Uv+3d3NhCpjCZnAuMknzU3OmgDY2yvs=;
        b=mTMstJTynJeD8plDhT5NQsV3foBDpbWBqdHPCmiIDtcojDl9j5wZnhtLSIXTcyfqQ0
         mQSg8nOv3FfrfCB+Jk6OmaDf4hv8dOYiCTTyiopl4oAQEuEBSvwL4Hp5a0V6q3lbm41U
         7h8OBJckk5NGeBiVzuzXDRENrAWbh2JDPKb/1FOx7qFJXzHW6q0yVXKYg50W9NmOakUo
         3gdL56BVUc9D6ugTzMvbZK6mPKJi4Ar9ZEV5F2cuXp0neFv5D1/oyaf4ZytaFUj9rHN5
         bL3QA22YXFJcNabCPo8D43T6IqfIgTGK4CYzBH3mhn2TWX8gvNhgeIDUxLvY95RrYGfB
         YLOg==
X-Gm-Message-State: AOJu0YyAr5o5q5+wGPtrr+ABTODJJYZeTPnxr4m1CrMzSzE6XkTc7l9T
	0kXrpURoAUf/v/G45kYei1APtLdRtgsnGT6gEmh3CAYepk9che8uGH43LFy1MPaCskenVMClnrB
	j
X-Google-Smtp-Source: AGHT+IFzj5Egmx82UlqLtS8702oDW5B8Irx0HmVgprRpj1oJQaQZl9jXZPR44czyMdc7d4+JYt2MPQ==
X-Received: by 2002:a05:6358:3116:b0:1ac:f144:2b16 with SMTP id e5c5f4694b2df-1b5ec0e1f2fmr225096355d.26.1724722750417;
        Mon, 26 Aug 2024 18:39:10 -0700 (PDT)
Received: from n191-036-066.byted.org ([147.160.184.150])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454fe1c5711sm48263401cf.82.2024.08.26.18.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 18:39:09 -0700 (PDT)
From: zijianzhang@bytedance.com
To: bpf@vger.kernel.org
Cc: edumazet@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mykolal@fb.com,
	shuah@kernel.org,
	xiyou.wangcong@gmail.com,
	wangdongdong.6@bytedance.com,
	zhoufeng.zf@bytedance.com,
	Amery Hung <amery.hung@bytedance.com>
Subject: [PATCH bpf-next v2 0/2] prevent bpf_reserve_hdr_opt() from growing skb larger than MTU
Date: Tue, 27 Aug 2024 01:37:34 +0000
Message-Id: <20240827013736.2845596-1-zijianzhang@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amery Hung <amery.hung@bytedance.com>

This series prevents sockops users from accidentally causing packet
drops. This can happen when a BPF_SOCK_OPS_HDR_OPT_LEN_CB program
reserves different option lengths in tcp_sendmsg().

Initially, sockops BPF_SOCK_OPS_HDR_OPT_LEN_CB program will be called to
reserve a space in tcp_send_mss(), which will return the MSS for TSO.
Then, BPF_SOCK_OPS_HDR_OPT_LEN_CB will be called in __tcp_transmit_skb()
again to calculate the actual tcp_option_size and skb_push() the total
header size.

skb->gso_size is restored from TCP_SKB_CB(skb)->tcp_gso_size, which is
derived from tcp_send_mss() where we first call HDR_OPT_LEN. If the
reserved opt size is smaller than the actual header size, the len of the
skb can exceed the MTU. As a result, ip(6)_fragment will drop the
packet if skb->ignore_df is not set.

To prevent this accidental packet drop, we need to make sure the
second call to the BPF_SOCK_OPS_HDR_OPT_LEN_CB program reserves space
not more than the first time. Since this cannot be done during
verification time, we add a runtime sanity check to have
bpf_reserve_hdr_opt return an error instead of causing packet drops later.

We also add a selftests to verify the sanity check. If users accidentally
reserve a small size, bpf_reserve_hdr_opt() should return an appropriate
error value and no packet should be dropped.

Changelog:
  v1 -> v2:
    - I accidentally missed the eBPF prog file in the previous patch
    submission, sorry for the convenience.

Amery Hung (1):
  bpf: tcp: prevent bpf_reserve_hdr_opt() from growing skb larger than
    MTU

Zijian Zhang (1):
  bpf: selftests: reserve smaller tcp header options than the actual
    size

 include/net/tcp.h                             |  8 +++
 net/ipv4/tcp_input.c                          |  8 ---
 net/ipv4/tcp_output.c                         | 13 +++-
 .../bpf/prog_tests/tcp_hdr_options.c          | 51 +++++++++++++
 .../bpf/progs/test_reserve_tcp_hdr_options.c  | 71 +++++++++++++++++++
 5 files changed, 141 insertions(+), 10 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_reserve_tcp_hdr_options.c

-- 
2.20.1


