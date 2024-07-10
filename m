Return-Path: <bpf+bounces-34368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 535CC92CD69
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 10:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF7801F247BD
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 08:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1541411ED;
	Wed, 10 Jul 2024 08:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infogain-com.20230601.gappssmtp.com header.i=@infogain-com.20230601.gappssmtp.com header.b="CxiB+YLI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C84113C80C
	for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 08:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720601235; cv=none; b=CH6YLkjBn8cQEbpYI1KHAsljuj0cSgQ1BkwHzx37+K0wthecWjGcBA5pJbDINc3Hsj2hSYKoWZHwkfB6ojxugJcmyYfcCsDZZqUthhLqwHFjxM0MDyEw4e2JIOhB3uViCpM63/gu+rt7jrjJDdZiZOd8DcgMXfrkbuwF+S/ZbEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720601235; c=relaxed/simple;
	bh=h7wPKwl9gyLl5ae6rikweGiUuq0RojGxlMGVvH0VlDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TScjketdEqBFSqrzK//8pNocVORLdDaKckYS4ojDDL83pIy5PunQNd0BhjebetAFYWUCXkd0NsTWpvTGbeJWjLzdimAipCKFwjVmZY7rwQKrlhJX9y4574OQUIoztmCW5vEUwReDMOqLPK54M96DKyE0BVxnSTBOR7SaSpKWb9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=infogain.com; spf=fail smtp.mailfrom=infogain.com; dkim=pass (2048-bit key) header.d=infogain-com.20230601.gappssmtp.com header.i=@infogain-com.20230601.gappssmtp.com header.b=CxiB+YLI; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=infogain.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=infogain.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa6b3so3431380a12.1
        for <bpf@vger.kernel.org>; Wed, 10 Jul 2024 01:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=infogain-com.20230601.gappssmtp.com; s=20230601; t=1720601230; x=1721206030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X8FqtNzO0keF9wcj5E753g+Uz3zdkp3wogKQchcCmCQ=;
        b=CxiB+YLIldaAXdQ9zsqasj3fWMS1rCjBKhjWez8aQ7+KTANOp5b1kmgPmQLyMJ9Cq1
         VJksRj2FaQxPq5iQES1BubkcH8TG8w6kquoVLYruhxGng5t5NOGq9S/HmoyqzSWV/LYD
         h8HIwdL20ctBRmgm4vZ0Jii4eCanC2C5kShnlZp0jhXBTZlCbjVJVqbQvZWnBoDrS9Xr
         Z4hkUijyQG6gE41VXENYLjhUxUS/mM/iXYFAAsTwSMkClO3z4d//7U8DrDuxddxwne8o
         5U+tGlSwYZ+P3YAJh+fYG/YediM3PN25k0ZY7zwXa6wGhLOzoKyGUm7YX9/P+1Sujys2
         uyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720601230; x=1721206030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X8FqtNzO0keF9wcj5E753g+Uz3zdkp3wogKQchcCmCQ=;
        b=PxTPzFoGU7O89BHe7pOJSlS0LU3anF/v9HhxDnTHnM8gfsX2Up/ExCzSEDJWF4JDsr
         ExnJ0kHY52/gvi0OZ2PDlVHbq4JrdVunM6+TuJI+eO00xZpNo79DfHv1iH+WPpm6eH1n
         Veo7lltrR7zSTg4ic0OHJwFf+c8NZx+esARWH44NhIl0e2zDoidxOWsiZkgPN84GvRpO
         naaDg8Nr51gvbfxJLIohII0NLkJ3gidQGhVmqVKWFdvVowmSZYZp0gwGxqkwWS+rflfA
         RlLRIgjNqcrpk3srTg3b58Q47KKfBdGCv27SbIUZLlVTkmE2LMBNOaQyjf24OGzD+Ap+
         UbTg==
X-Forwarded-Encrypted: i=1; AJvYcCV+nrzSOs9ZAzrFxHIQt5Mcg4q4uRiEGxuaN0q1fqzagaCxF2ddRMz5kcUt07Alc59lNVAOOnCt2Gcv6oy72u0/9gpX
X-Gm-Message-State: AOJu0YxDD/z7Gqzv6+KBbXptO3GzjPA6zUH+p0KZC+rGwNb0cTh40exG
	Wvx6cbBUjQTBjwSDTBRZWwW27z2Z+cwLhgllAB+y6SR+nFSakVMe4JLusN2DqG2Wo0GHNe6bOtc
	F
X-Google-Smtp-Source: AGHT+IFuVw53kf5KJm2tlhyO0sC/jRbJo31a1h3ervkGuYBYOrwF7JQYUZyHDLWOXwdlUWZj3VYpxA==
X-Received: by 2002:a05:6402:1a2f:b0:57c:71ca:f651 with SMTP id 4fb4d7f45d1cf-594bb67f240mr3758414a12.20.1720601230017;
        Wed, 10 Jul 2024 01:47:10 -0700 (PDT)
Received: from michal-Latitude-5420.. ([88.220.73.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bd45a16esm1967497a12.75.2024.07.10.01.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 01:47:09 -0700 (PDT)
From: Michal Switala <michal.switala@infogain.com>
To: revest@google.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Michal Switala <michal.switala@infogain.com>,
	syzbot+cca39e6e84a367a7e6f6@syzkaller.appspotmail.com
Subject: [PATCH] bpf: Ensure BPF programs testing skb context initialization
Date: Wed, 10 Jul 2024 10:46:33 +0200
Message-ID: <20240710084633.2229015-1-michal.switala@infogain.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit addresses an issue where a netdevice was found to be uninitialized.
To mitigate this case, the change ensures that BPF programs designed to test
skb context initialization thoroughly verify the availability of a fully
initialized context before execution.The root cause of a NULL ctx stems from
the initialization process in bpf_ctx_init(). This function returns NULL if
the user initializes the bpf_attr variables ctx_in and ctx_out with invalid
pointers or sets them to NULL. These variables are directly controlled by user
input, and if both are NULL, the context cannot be initialized, resulting in a
NULL ctx.

Reported-by: syzbot+cca39e6e84a367a7e6f6@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=cca39e6e84a367a7e6f6
Link: https://lore.kernel.org/all/000000000000b95d41061cbf302a@google.com/
Signed-off-by: Michal Switala <michal.switala@infogain.com>
---
 net/bpf/test_run.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 36ae54f57bf5..8b2efcee059f 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -970,7 +970,7 @@ static struct proto bpf_dummy_proto = {
 int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 			  union bpf_attr __user *uattr)
 {
-	bool is_l2 = false, is_direct_pkt_access = false;
+	bool is_l2 = false, is_direct_pkt_access = false, ctx_needed = false;
 	struct net *net = current->nsproxy->net_ns;
 	struct net_device *dev = net->loopback_dev;
 	u32 size = kattr->test.data_size_in;
@@ -998,6 +998,34 @@ int bpf_prog_test_run_skb(struct bpf_prog *prog, const union bpf_attr *kattr,
 		return PTR_ERR(ctx);
 	}
 
+	switch (prog->type) {
+	case BPF_PROG_TYPE_SOCKET_FILTER:
+	case BPF_PROG_TYPE_SCHED_CLS:
+	case BPF_PROG_TYPE_SCHED_ACT:
+	case BPF_PROG_TYPE_XDP:
+	case BPF_PROG_TYPE_CGROUP_SKB:
+	case BPF_PROG_TYPE_CGROUP_SOCK:
+	case BPF_PROG_TYPE_SOCK_OPS:
+	case BPF_PROG_TYPE_SK_SKB:
+	case BPF_PROG_TYPE_SK_MSG:
+	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
+	case BPF_PROG_TYPE_LWT_SEG6LOCAL:
+	case BPF_PROG_TYPE_SK_REUSEPORT:
+	case BPF_PROG_TYPE_NETFILTER:
+	case BPF_PROG_TYPE_LWT_IN:
+	case BPF_PROG_TYPE_LWT_OUT:
+	case BPF_PROG_TYPE_LWT_XMIT:
+		ctx_needed = true;
+		break;
+	default:
+		break;
+	}
+
+	if (!ctx && ctx_needed) {
+		kfree(data);
+		return -EINVAL;
+	}
+
 	switch (prog->type) {
 	case BPF_PROG_TYPE_SCHED_CLS:
 	case BPF_PROG_TYPE_SCHED_ACT:
-- 
2.43.0


