Return-Path: <bpf+bounces-12015-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD297C67E9
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 10:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA5BE2829DA
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 08:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041A62030E;
	Thu, 12 Oct 2023 08:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4s3xxP0"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47FC1D53E;
	Thu, 12 Oct 2023 08:52:31 +0000 (UTC)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DFF90;
	Thu, 12 Oct 2023 01:52:30 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9ada2e6e75fso120619666b.2;
        Thu, 12 Oct 2023 01:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697100748; x=1697705548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N/f10HhgbRXBNg36P2aU4hTAs0luHAE94PiWFoj//kI=;
        b=U4s3xxP09+aLpxGUHPxSXZh4is574ahiPFftSL9r1FANEHEgtBk8qgV2KX2eG6OL/i
         mlBe02eQRjQGuOmiM13cZ7G4FSAao76Uy16/yiflA/jm8OEDjxmBs00P8NfSmJ3KL9d6
         XAk5+2pph0QerbTN8PTXljHa4+tFEDdhL1M+PrKUgFMx+Wb1wMpXlQD1xSdmEfhGTPKi
         fhWIBAUYPnI7yjObwOkBh81GSM9O2d5UpJQxy8Tzfv2ROM9KafhcpKepV4zU9jbQQjf8
         RMtq/ewio1LAp8LD2iMkPexYz5TN12JqXkqxmgr8BQoX95cJ/y4TwViLMkVMUJphRT0O
         RjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697100748; x=1697705548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N/f10HhgbRXBNg36P2aU4hTAs0luHAE94PiWFoj//kI=;
        b=eFt3XchkSN8NU/Ni31O+4CEv3usdXUYMsp/v+apzWja2EkjR5BSDy5jX9VAFCf7aA4
         f7YAdPW/coLVbtMnKpKcXkB9HzYMb1U5kZOj7/IWQOa8ez2sCG0CRkUncKWnlFCm/8Ft
         KXN4cQbn2IJyV+87JnTY1/41zwGNjNQrINJ8K6YzsXC4Rpc2vt5aK7lCpER9EgWxbvma
         M1WwKt/aiN0716kyRxCKKKdCYoAS/OFD8GASnOV0ZMSfhrHyg+QxQsNv3UaUJkG2alOM
         waLzycKub6Y8rUco38OWX4I6n5nWzPVQBot0UHf1/X2B3X5hgUVPPZ5nYMkzm+oVcuul
         jGhw==
X-Gm-Message-State: AOJu0YyLbSWPnjnvc0etk3dlYdwSlri46zgJ2pOcTwWJiSUZhwO4kMfx
	wUpRBv5Eo1PJ1hpR2Pm8rP2fGeS62YkCzJIA
X-Google-Smtp-Source: AGHT+IEcB2qcYa9fFawrXQBvLv8YIkp4erGmUL9j7ytwkbjHrPpegsk8Uw5p0qugmMIp5r1G0gjQfw==
X-Received: by 2002:a17:906:2cf:b0:9ae:3d6b:9521 with SMTP id 15-20020a17090602cf00b009ae3d6b9521mr19236959ejk.56.1697100748249;
        Thu, 12 Oct 2023 01:52:28 -0700 (PDT)
Received: from daandemeyer-fedora-PC1EV17T.thefacebook.com (2001-1c05-3310-3500-c958-bc94-72b4-497f.cable.dynamic.v6.ziggo.nl. [2001:1c05:3310:3500:c958:bc94:72b4:497f])
        by smtp.googlemail.com with ESMTPSA id o23-20020a17090611d700b00991e2b5a27dsm10843312eja.37.2023.10.12.01.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 01:52:27 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v2] Only run BPF cgroup unix sockaddr recvmsg() hooks on named sockets
Date: Thu, 12 Oct 2023 10:52:13 +0200
Message-ID: <20231012085216.219918-1-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Changes since v1:

* Added missing Signed-off-by tag

We should not run the recvmsg() hooks on unnamed sockets as we do
not run them on unnamed sockets in the other hooks either. We may
look into relaxing this later but for now let's make sure we are
consistent and not run the hooks on unnamed sockets anywhere.

Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
---
 net/unix/af_unix.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index e10d07c76044..81fb8bddaff9 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2416,9 +2416,10 @@ int __unix_dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t size,
 	if (msg->msg_name) {
 		unix_copy_addr(msg, skb->sk);

-		BPF_CGROUP_RUN_PROG_UNIX_RECVMSG_LOCK(sk,
-						      msg->msg_name,
-						      &msg->msg_namelen);
+		if (msg->msg_namelen > 0)
+			BPF_CGROUP_RUN_PROG_UNIX_RECVMSG_LOCK(sk,
+							      msg->msg_name,
+							      &msg->msg_namelen);
 	}

 	if (size > skb->len - skip)
@@ -2773,9 +2774,10 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 					 state->msg->msg_name);
 			unix_copy_addr(state->msg, skb->sk);

-			BPF_CGROUP_RUN_PROG_UNIX_RECVMSG_LOCK(sk,
-							      state->msg->msg_name,
-							      &state->msg->msg_namelen);
+			if (state->msg->msg_namelen > 0)
+				BPF_CGROUP_RUN_PROG_UNIX_RECVMSG_LOCK(sk,
+								      state->msg->msg_name,
+								      &state->msg->msg_namelen);

 			sunaddr = NULL;
 		}
--
2.41.0


