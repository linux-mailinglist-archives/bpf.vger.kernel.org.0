Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E94C428B14F
	for <lists+bpf@lfdr.de>; Mon, 12 Oct 2020 11:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbgJLJT7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Oct 2020 05:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729201AbgJLJT5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Oct 2020 05:19:57 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C72BC0613D1
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2020 02:19:55 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id c22so22252244ejx.0
        for <bpf@vger.kernel.org>; Mon, 12 Oct 2020 02:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aB+F+LSfyZ6/dCTwKyQPt5hR5XIkYtzIf7awe/NipxE=;
        b=CbKK+gRvc5v/iI/hT1XnCe2gT1iPQqtKxcpeQ41tF5kfGLK8b/Dr2YAebJKojI6/HT
         rFs4DD8eMc+LSWr190vq5r8PzdviFYrKXtOM6T2YVd1ualqEeohRgJo2sSIUolHT2g+W
         2bFOU+zjyqSG+hjrBoptoIEU4gFLRYBMPlAKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aB+F+LSfyZ6/dCTwKyQPt5hR5XIkYtzIf7awe/NipxE=;
        b=uH/tw809ia1euE6FcJgjFo+l8Ij9NH/ZpXZSN3Ssi5nZG9pUpZi21a8YqmcRKFNhcQ
         KcZosT8701tU6mSHltdGB2WlMf31x3pnWESrIHSq8wVOZ2HCpEgS6osLLlEaHcKFwUBg
         xcyJyt7N3vKkRLjvxyh8j5xFm06+wotJdbSH6T1BinEOjm2JHZeQ/aG24s9wf+rNV/hv
         EDm9UR5WRq4At5/uzKHWXVAHsnsmTwZHFavcYbj8OnFl8m5tB1zSXweEcu35VChdqwIy
         MRcYoXeks5WuuIc4QPZC1iVSiLnDWnW3/+3FaBN/zsn4rwExSvo4rEz8ikYi4LAoBWob
         iocg==
X-Gm-Message-State: AOAM533C3+nofYT4OLetmcT2DmttMEdA9jrGRgO5xmF70Lb64th2Sd6M
        vLDbWC9spIK0RW0QsDopO6/gmw==
X-Google-Smtp-Source: ABdhPJx5XFsHT27Sb+fbFnWQZZXJQ6H7gYYZAkdJY19fb6/Z4DDcglvpr773N2/AJurdT8ugzMOygQ==
X-Received: by 2002:a17:906:4e06:: with SMTP id z6mr28296939eju.370.1602494393813;
        Mon, 12 Oct 2020 02:19:53 -0700 (PDT)
Received: from antares.fritz.box (p200300c1c70304000403afa763d01b3d.dip0.t-ipconnect.de. [2003:c1:c703:400:403:afa7:63d0:1b3d])
        by smtp.gmail.com with ESMTPSA id q12sm10396834edj.19.2020.10.12.02.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 02:19:53 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>
Cc:     kernel-team@cloudflare.com, kernel test robot <lkp@intel.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf] bpf: sockmap: add locking annotations to iterator
Date:   Mon, 12 Oct 2020 11:18:50 +0200
Message-Id: <20201012091850.67452-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The sparse checker currently outputs the following warnings:

    include/linux/rcupdate.h:632:9: sparse: sparse: context imbalance in 'sock_hash_seq_start' - wrong count at exit
    include/linux/rcupdate.h:632:9: sparse: sparse: context imbalance in 'sock_map_seq_start' - wrong count at exit

Add the necessary __acquires and __release annotations to make the
iterator locking schema palatable to sparse. Also add __must_hold
for good measure.

The kernel codebase uses both __acquires(rcu) and __acquires(RCU).
I couldn't find any guidance which one is preferred, so I used
what is easier to type out.

Fixes: 0365351524d7 ("net: Allow iterating sockmap and sockhash")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 net/core/sock_map.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index df09c39a4dd2..203900a6ca5f 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -745,6 +745,7 @@ static void *sock_map_seq_lookup_elem(struct sock_map_seq_info *info)
 }
 
 static void *sock_map_seq_start(struct seq_file *seq, loff_t *pos)
+	__acquires(rcu)
 {
 	struct sock_map_seq_info *info = seq->private;
 
@@ -757,6 +758,7 @@ static void *sock_map_seq_start(struct seq_file *seq, loff_t *pos)
 }
 
 static void *sock_map_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+	__must_hold(rcu)
 {
 	struct sock_map_seq_info *info = seq->private;
 
@@ -767,6 +769,7 @@ static void *sock_map_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 }
 
 static int sock_map_seq_show(struct seq_file *seq, void *v)
+	__must_hold(rcu)
 {
 	struct sock_map_seq_info *info = seq->private;
 	struct bpf_iter__sockmap ctx = {};
@@ -789,6 +792,7 @@ static int sock_map_seq_show(struct seq_file *seq, void *v)
 }
 
 static void sock_map_seq_stop(struct seq_file *seq, void *v)
+	__releases(rcu)
 {
 	if (!v)
 		(void)sock_map_seq_show(seq, NULL);
@@ -1353,6 +1357,7 @@ static void *sock_hash_seq_find_next(struct sock_hash_seq_info *info,
 }
 
 static void *sock_hash_seq_start(struct seq_file *seq, loff_t *pos)
+	__acquires(rcu)
 {
 	struct sock_hash_seq_info *info = seq->private;
 
@@ -1365,6 +1370,7 @@ static void *sock_hash_seq_start(struct seq_file *seq, loff_t *pos)
 }
 
 static void *sock_hash_seq_next(struct seq_file *seq, void *v, loff_t *pos)
+	__must_hold(rcu)
 {
 	struct sock_hash_seq_info *info = seq->private;
 
@@ -1373,6 +1379,7 @@ static void *sock_hash_seq_next(struct seq_file *seq, void *v, loff_t *pos)
 }
 
 static int sock_hash_seq_show(struct seq_file *seq, void *v)
+	__must_hold(rcu)
 {
 	struct sock_hash_seq_info *info = seq->private;
 	struct bpf_iter__sockmap ctx = {};
@@ -1396,6 +1403,7 @@ static int sock_hash_seq_show(struct seq_file *seq, void *v)
 }
 
 static void sock_hash_seq_stop(struct seq_file *seq, void *v)
+	__releases(rcu)
 {
 	if (!v)
 		(void)sock_hash_seq_show(seq, NULL);
-- 
2.25.1

