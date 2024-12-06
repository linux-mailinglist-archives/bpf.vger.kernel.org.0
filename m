Return-Path: <bpf+bounces-46237-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEF59E653C
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 05:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5755281B42
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 04:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE3A1922F2;
	Fri,  6 Dec 2024 04:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igo/75KH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09C8175BF
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 04:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733457805; cv=none; b=QhwXa4rB3wST2UL8KnAXBCRM6emVmTChJR4NeTfXooirpBMkJGSiZIsQnpsxQU3naFGpatX0j1WEKGDF4z/mOtiEq7R5cw0+AgmurV37Q9MSqWhfyKSAAIFKUUUP4Ff/dQTjsW6IKFVGU8jbTEnAuJML2izqbytTeMfjB2Uedqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733457805; c=relaxed/simple;
	bh=r1KowAKctczQluWB0mdDrzCt/FnJuRFhfzCi+lZDnH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZYYcKL3TbuhHfv9EHFpsSbSIQsjGwDETT30cWzs/IolhscgEVXL3I3cnCwB2C99U8sqo4xGPhvKhOOvggKn8zuJN1bwS/t2ASNqOvruXPz18S42qp6q1gzwG5hd/qf1LLLLomG2cvEDKjr/fJm3AiXaTai3sZs13IaJ0N8akKLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igo/75KH; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7fc41b4c78bso1116510a12.3
        for <bpf@vger.kernel.org>; Thu, 05 Dec 2024 20:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733457803; x=1734062603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FDrC/1pqvR84xIDZ/2q8UvvBuSdnDf//V2V025p18Fg=;
        b=igo/75KHW2cPU/AOe7IhpOpKE9kMEYBvbpEjAX5XY7+xMUM0J6lVotnHqh/809r7Je
         GpbyJXEWlC0D54pTpKUFLEKj4Wl3fp3WwtePHXbjQTIa3EqVOwp+H+28b1aUGdXW4f4r
         wkPPhydufh63z8xvGhieFlM7I6pk+6ZwNOmcOf55/d5g2ygkGKlcFtAF55lRWPq2MlAw
         H6XTZgQrom0N7VER0DmdlqVaT6bsMBGAuzGuxCPE8fzak3gcn1iEN6qt+/OlzwzOkyzC
         GGBBtvCJ4I4IwFfo/r/au9T74Ppqg9ONDzuO0st+9pVJOr+PxaePqpXeQ53EAysEG8IZ
         7izQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733457803; x=1734062603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FDrC/1pqvR84xIDZ/2q8UvvBuSdnDf//V2V025p18Fg=;
        b=hA1waZYtQGCcWcWdFWcXkvw93cUjx5h22S5hPcUkcC6U5x1p61tygWFVBY7acKqY6L
         hIyrPFzBkFlNFxluJe9in9UW6j/dzkwmNGGZSEps3iT61U2OiNbrOfvcn7v9yBZuz05G
         9hDFzMiHh2EGZl/IyB80xi1t80I4CCSf/EM40IzbSNeUAP5CwO9zkDWZPvGF9uPnuxDh
         /1w3ThD1J5eBadV9Z4Yg4wDytxG/+RY0EdpILOo460lpLg0wDU6mtpEEWOUudgZ4jL3S
         6JjP2IXnsc7FBtCeDD2mG2c068MSJUqKzZv0ZvRRJzA521KTs5kHk0FrxJQUhXBaWJjC
         GXrA==
X-Gm-Message-State: AOJu0YyfZMsfXiLS9aXaldCCZ0P3SUkxbXZqE2UX6A1Ch2zJYIQjljq9
	T2ybCjdu3rh0EiNtaNpwMVE30ifbAXlxaFF2iN6BN+1T4uAfs/4bpYSavA==
X-Gm-Gg: ASbGncuSjMF9iV1+SX/L+Tex4Dne39OFwBqEgxK6yTsetmVCF6t2v5WZgNrx3KOwEg+
	JOMM7C/p3TZqPcut9Ng2kr3+K1PdSn0wALMdYAz6W9pIcyQ+UP/k+8W7wLZR03/ASFX/nIf3mgz
	yfXONs71MCDiWTFkmYlV28kL5kC82fDirQHbkpXwP5cn+5QXjUI5BUIC76CBZuIww1SNJUuH6Bk
	dA1H15Dt1PJy9sAz5W1CCh8O1Q8yBtWr8+dSpGU97kFjg==
X-Google-Smtp-Source: AGHT+IHDx/oG0HI7ZHLZ2LPQ9DfGMR4k8mipe5ketE9WiRjrYQ4zbOmt7L/E7lZWwRFJpr44iCkasw==
X-Received: by 2002:a17:90b:2b4d:b0:2ee:e158:125b with SMTP id 98e67ed59e1d1-2ef6aadb89bmr2452739a91.26.1733457802567;
        Thu, 05 Dec 2024 20:03:22 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef26ff97ffsm4101846a91.10.2024.12.05.20.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 20:03:21 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	mejedi@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf 0/4] bpf: track changes_pkt_data property for global functions
Date: Thu,  5 Dec 2024 20:03:03 -0800
Message-ID: <20241206040307.568065-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Nick Zavaritsky reported [0] a bug in verifier, where the following
unsafe program is not rejected:

    __attribute__((__noinline__))
    long skb_pull_data(struct __sk_buff *sk, __u32 len)
    {
        return bpf_skb_pull_data(sk, len);
    }

    SEC("tc")
    int test_invalidate_checks(struct __sk_buff *sk)
    {
        int *p = (void *)(long)sk->data;
        if ((void *)(p + 1) > (void *)(long)sk->data_end) return TCX_DROP;
        skb_pull_data(sk, 0);
        /* not safe, p is invalid after bpf_skb_pull_data call */
        *p = 42;
        return TCX_PASS;
    }

This happens because verifier does not track package invalidation
effect of global sub-programs.

This patch-set fixes the issue by modifying check_cfg() to compute
whether or not each sub-program calls (directly or indirectly)
helper invalidating packet pointers.

[0] https://lore.kernel.org/bpf/0498CA22-5779-4767-9C0C-A9515CEA711F@gmail.com/

Eduard Zingerman (4):
  bpf: add find_containing_subprog() utility function
  bpf: refactor bpf_helper_changes_pkt_data to use helper number
  bpf: track changes_pkt_data property for global functions
  selftests/bpf: test for changing packet data from global functions

 include/linux/bpf_verifier.h                  |  1 +
 include/linux/filter.h                        |  2 +-
 kernel/bpf/core.c                             |  2 +-
 kernel/bpf/verifier.c                         | 62 ++++++++++++++++--
 net/core/filter.c                             | 63 +++++++++----------
 .../selftests/bpf/progs/verifier_sock.c       | 28 +++++++++
 6 files changed, 115 insertions(+), 43 deletions(-)

-- 
2.47.0


