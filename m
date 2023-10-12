Return-Path: <bpf+bounces-12014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CC97C67E6
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 10:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 198511C210E8
	for <lists+bpf@lfdr.de>; Thu, 12 Oct 2023 08:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C9B200A7;
	Thu, 12 Oct 2023 08:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZcbDPl0"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4105ED531;
	Thu, 12 Oct 2023 08:50:50 +0000 (UTC)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EA990;
	Thu, 12 Oct 2023 01:50:48 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50336768615so1041741e87.0;
        Thu, 12 Oct 2023 01:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697100646; x=1697705446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H7Ew5cyy5TcHIAfX5arzO/f3G0c42cv22Np1IDCLtnM=;
        b=IZcbDPl0QzL8FTO0k8DyTOgxVeXu28KvdKWQO5MbIEnwjCd6JaLL/CcDeuwRNHX3sU
         l8cpk0fVEEnmzd4phUMCQI2hYF1/aFdrQFKz3Q0tYDCzwYIkTlvKKqgVxWNo8BTJiZXK
         Qd6Yc/WzMBhR3x8yqOihnZdLUzdawYXWTTyN6h2B0glYR3lsU/JajKOB1yANURodZctD
         4m7QGb2fIHdwGyMM1D5HLqyWhCiLz9tTceo54GXK7c5cqZLQJjWZDtN7itw1gB+y16eA
         rKPqP80p1RVZEtKAisml6GwZWzRxEloJsLhVRI1usU6BEC76SbAyLiWrWFTt998p8/dX
         QdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697100646; x=1697705446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H7Ew5cyy5TcHIAfX5arzO/f3G0c42cv22Np1IDCLtnM=;
        b=Y4FT4Wl6KXE/Ft/98HvcR8AJtlFBgBmgy8pk/8gI7j9eEfunJfwmNPEoHyRxiP6Haf
         FedeSZdrL5xihxbY5jtNZSmTuJ0jg9jIdvFB2Eh108/Vla3KY6nZxXPt0ETjDFsOwCcj
         /Y6UdyxQZMRhj4EYxB3bcmiamWhLd2DBAJaK//eXCHl91aXPkqjQwVKZPYFtueD4mxLs
         YTWcC2iBXex8jaQhUReVv9XxIyHCQyrO+b+MOIJXU8g7vcFw0MzgHPGz3uvBdZllRQpa
         HXzID33rxWISrHR3iXvAy2E9/qsh58S0/+pReT/8W6dDfkVOwg4cnYXHYxZS3+kmvojG
         hAbQ==
X-Gm-Message-State: AOJu0YxeZuZwkQrTHG7NU0bqbdWYNoR3w2/o7JOzySs2jpRXIrisEKCb
	sq2I/pPF6rwYuIU1LlRa67P97MArLIYxhSBb
X-Google-Smtp-Source: AGHT+IFu4V3OnZ1i8c/mJhWQiXPmTz6qotaHCkZKTtw40maP9jD9t5G+2lvfQgEQCn5P6jpJ92e0Hg==
X-Received: by 2002:a05:6512:2811:b0:503:257a:7f5d with SMTP id cf17-20020a056512281100b00503257a7f5dmr26169853lfb.31.1697100645813;
        Thu, 12 Oct 2023 01:50:45 -0700 (PDT)
Received: from daandemeyer-fedora-PC1EV17T.thefacebook.com (2001-1c05-3310-3500-c958-bc94-72b4-497f.cable.dynamic.v6.ziggo.nl. [2001:1c05:3310:3500:c958:bc94:72b4:497f])
        by smtp.googlemail.com with ESMTPSA id ch1-20020a0564021bc100b0053e07fe8d98sm649089edb.79.2023.10.12.01.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 01:50:44 -0700 (PDT)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>,
	martin.lau@linux.dev,
	kernel-team@meta.com,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v1] Only run BPF cgroup unix sockaddr recvmsg() hooks on named sockets
Date: Thu, 12 Oct 2023 10:50:31 +0200
Message-ID: <20231012085033.219376-1-daan.j.demeyer@gmail.com>
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
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We should not run the recvmsg() hooks on unnamed sockets as we do
not run them on unnamed sockets in the other hooks either. We may
look into relaxing this later but for now let's make sure we are
consistent and not run the hooks on unnamed sockets anywhere.
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


