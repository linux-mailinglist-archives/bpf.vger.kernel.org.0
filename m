Return-Path: <bpf+bounces-62523-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F16AFB7EF
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 17:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86D3516E450
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 15:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98FB215073;
	Mon,  7 Jul 2025 15:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="Sch40BaE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1371A212B31
	for <bpf@vger.kernel.org>; Mon,  7 Jul 2025 15:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751903472; cv=none; b=FKG9fOVVS8med18v9900k/IBaAaXlsvmjqVZLcPvUNJQ4AawWtIvYmJWVS9pTQ0CRUVD4Hp8r/R24eWKIunTQijf6bXtZBpQe/tprJMbztD5w8DzBIYIVrMKgn6mPZYBugpwOt3qnHAxeSikVdlkIbQ9fGRWEfvC85NE702S9nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751903472; c=relaxed/simple;
	bh=P2TM48kjMxPSr7YwvwYsCNfh+euwlg0K2KRkqviR9cM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H8qG4aAqXxsWOfYDE2CqvinRxa20MSpN9RuZS3aOMILOR8dRREGv1LzOGHaYzeAFO6oH4cZDKuwlcM3WktidUIrhTNw/BrATyXa+2uHIQ9ceo0XcqIfiZRQBGOU8o9x/4jcjJ3tQpSHlRH0iJYFrOts2HIOvkFsUuCKHWyB29OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=Sch40BaE; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-235ef29524fso3974135ad.1
        for <bpf@vger.kernel.org>; Mon, 07 Jul 2025 08:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1751903469; x=1752508269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imTCW/X3yNchRElFuavT2VHyvLPxQFd7uC5iHjhIYP0=;
        b=Sch40BaEb0m2KjjqP4ADpF/x3U/tXXdK2akmCvI1DMvBhNZbiNijEt0r4UwHfFCjbG
         zvNZ8ZsFvpf+TZpvnBWzioe6vLTUh7dMdoT+scIVc2jnosfVRAf4ELRCBkOJiKJr4O2d
         dh/exuphSVbnmSloQtv/wkL1vJKSNTr3VDv/wEDKJdqxhVn7H3eH37X7ZOo2WBdJ4ItV
         Vb7+GQwfHQU4SBGEXtTwzqivuxsW9g9Ds/Po7F5QdDh9qKjiM9nGcxqvLoPEXSUd1bKr
         5QhPrQpkxcG1VaPINpaqIZF3EpLHK4xGjneF9Q6Jx03lPIupNa/7xhLDiI9NuwTL7Wjm
         Godg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751903469; x=1752508269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imTCW/X3yNchRElFuavT2VHyvLPxQFd7uC5iHjhIYP0=;
        b=rLxw86g7KbGusAelZiHLttqnsh0TEtn3Bg/lqIBb3KGuYmkUsrlCYz1eJ2SOsPC2Wj
         XqbgWZCGR7xg0YhQREWvaBEHhdGkXjLK3iyfJrGUGmiid0ZNqZQnXyE13kP5eFYheLch
         xkVOOcKrMDfQ76uwIOM+zKrrvVMzFEm6mzUFY3kP1AxpFjf1tSXv7ZwuQ87udUPrsAXV
         sv0kO9VVIU+tMlOQ4XsTHq8kLGnk9tt8VkpK/aa13/g0LEtol0Ngy98zFkyK0yI2XMha
         c4/lKOeDtQJXmHf/MNY6tQ3OXnKVr817mm0X6f+1tf9/rZikVN5dK5mKMwmRNDM1feUw
         wHlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNMZyK1fu+6T7DLWj9covxSJebKFqIBwoLBi3MsgpTscemeWClswM2AjjEshjbYvBpP/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+b87IqbEeVXXRhmslmDIw6xdcIeaG/6LR2cJq+8BpzzI3FFAh
	a8v57vosk2zVeMfwLwrxjI7nNNCtgvzOBDi/VtKAGSk8/qUQ7ZTgpYUCTN4Knh665RY=
X-Gm-Gg: ASbGnctmjXDMU7tc0isn6nBO4hss/CK9RUdzKNZs6WoVLFb/U4p9tGCLcoWisZxiQa0
	UPD6m0kVF90YO08PMrGkdvIuWLcG6C4LBJ6WPSq58JJDgWq92/bnHpmBrjBpPbVb5t8W048fdiD
	zZZmmqmwnPxwe68BpBmLvtW/kcqD1rs7kVATPaCpIn8erOfllbC8YcX9FjE3sLt1bmbeCCbSY3y
	EglkAvKTmQebMusLK3mBSb82M55+xUxR/X8FibiVRdtEByC/DhXjpv916seyUqDwON3dGyP336/
	n7V/Fn3e5pGSoNu7a0wtPidV9KuFR9JBKDalpPzTaJIEuiJcYv0=
X-Google-Smtp-Source: AGHT+IEKJQWYjeVFC45y9IaBfVRiscP79Th9ZakF0kjOzTliYluReOqGTKGsiqTBpr3rI+Ij32xa/g==
X-Received: by 2002:a17:902:d4c2:b0:234:9fee:afe0 with SMTP id d9443c01a7336-23c873f58e1mr70940865ad.14.1751903469237;
        Mon, 07 Jul 2025 08:51:09 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:e505:eb21:1277:21f5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8455eb3bsm95772065ad.115.2025.07.07.08.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 08:51:08 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Stanislav Fomichev <stfomichev@gmail.com>
Subject: [PATCH v4 bpf-next 01/12] bpf: tcp: Make mem flags configurable through bpf_iter_tcp_realloc_batch
Date: Mon,  7 Jul 2025 08:50:49 -0700
Message-ID: <20250707155102.672692-2-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250707155102.672692-1-jordan@jrife.io>
References: <20250707155102.672692-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare for the next patch which needs to be able to choose either
GFP_USER or GFP_NOWAIT for calls to bpf_iter_tcp_realloc_batch.

Signed-off-by: Jordan Rife <jordan@jrife.io>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/tcp_ipv4.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 6a14f9e6fef6..2e40af6aff37 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3048,12 +3048,12 @@ static void bpf_iter_tcp_put_batch(struct bpf_tcp_iter_state *iter)
 }
 
 static int bpf_iter_tcp_realloc_batch(struct bpf_tcp_iter_state *iter,
-				      unsigned int new_batch_sz)
+				      unsigned int new_batch_sz, gfp_t flags)
 {
 	struct sock **new_batch;
 
 	new_batch = kvmalloc(sizeof(*new_batch) * new_batch_sz,
-			     GFP_USER | __GFP_NOWARN);
+			     flags | __GFP_NOWARN);
 	if (!new_batch)
 		return -ENOMEM;
 
@@ -3165,7 +3165,8 @@ static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 		return sk;
 	}
 
-	if (!resized && !bpf_iter_tcp_realloc_batch(iter, expected * 3 / 2)) {
+	if (!resized && !bpf_iter_tcp_realloc_batch(iter, expected * 3 / 2,
+						    GFP_USER)) {
 		resized = true;
 		goto again;
 	}
@@ -3596,7 +3597,7 @@ static int bpf_iter_init_tcp(void *priv_data, struct bpf_iter_aux_info *aux)
 	if (err)
 		return err;
 
-	err = bpf_iter_tcp_realloc_batch(iter, INIT_BATCH_SZ);
+	err = bpf_iter_tcp_realloc_batch(iter, INIT_BATCH_SZ, GFP_USER);
 	if (err) {
 		bpf_iter_fini_seq_net(priv_data);
 		return err;
-- 
2.43.0


