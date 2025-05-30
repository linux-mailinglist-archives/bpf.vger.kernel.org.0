Return-Path: <bpf+bounces-59378-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CAA0AC970D
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 23:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 694EE4A77BE
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 21:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC2E62836B0;
	Fri, 30 May 2025 21:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="Pb6f1J9D"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2153227AC30
	for <bpf@vger.kernel.org>; Fri, 30 May 2025 21:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748640679; cv=none; b=nzvJd8ns/s+pAcECQqiucOing6lU0g4tsyqyIfnOl8aizlpWBoe2XXZae95a7zZQpg4bQRn5+ROwXs9B+WcC2khf9LmMBEDI1JCT/qdsEH/LkMghshIllAqO/cpj8mvEguwF8i0CFVNFv75oYSGrE4nCJB/U3YnMc/Szb+K9tTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748640679; c=relaxed/simple;
	bh=P2TM48kjMxPSr7YwvwYsCNfh+euwlg0K2KRkqviR9cM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kOclEYesL28u5/K6SXhlAVM+bdC0RM9+OSeZYFtzdCudH+s17VO5D+Kuf7+RK31zhTpo+f5iUgJccPSI+YXBygDaBSGnGIzucAfUU1qEaPz9tcNmJ9mweOcnmgu8lAl/lKgHBi/3ZyeuY6wwlApmCwtrH1wCrevcx2TeQPGVxTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=Pb6f1J9D; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b2ed1bc24fcso131976a12.0
        for <bpf@vger.kernel.org>; Fri, 30 May 2025 14:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1748640677; x=1749245477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imTCW/X3yNchRElFuavT2VHyvLPxQFd7uC5iHjhIYP0=;
        b=Pb6f1J9DrRZp+E2U3Adml0QNBo2Ng8fDzyFTAq4e+/F046+G5EZGw85Od47604x1Yf
         cgkAZa9FWzYQv15z6CxW4pEOc0gAlQi2xd+QIqANwvqPA5I3agUSICHWKh+pJOa7qSCC
         mXPqJSa3KWrAA2FZFk6M/VCkDxEuEOQYh0YdH/uGM9QnMLbbe73nUGz7brU4nEUHPlER
         iKQYEOTm8vAGzNoa/7DUbvbJixYu41neXJKdo5CmcVr3D8MMmWFN4hYGgueQsjolKTw0
         RMAaOggoDRiXw4C5cIriT3CwIeY7MTCLDsVAQ0TDt5vKGHGbBqpNncBCSq5E9fn8EXEG
         n3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748640677; x=1749245477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imTCW/X3yNchRElFuavT2VHyvLPxQFd7uC5iHjhIYP0=;
        b=MGWn2+abGZ+CRu29yNhhVoeNtW28cmqp/mTGbMqMDts3kdUw24797E6WmNIoeMWvyt
         kW+deStLSQ8/f1dLUc1RhM7LhjHoA4/rCJMsIh5Q6yqVolwzA1kUlaJBxasrlgYdxjh7
         MYCtDCs/YXzANgUy/Zs4wcX271y0Hg3kcuPw6l8qCJb8maXlAwC1wqXvAV/T1hdPSxlh
         SMts5cI2ECUfuSg2At7D6k2VyA/dj3dq+zud0vdgaPa4sIehI0JFpq03zG/w8/JHNOSr
         10CypRpZiukubx/yvllwZBDc3Mc6SUzcz3mcE3G6/oXvfOwPHKrsZYmn92gSnprMuff9
         QP5A==
X-Forwarded-Encrypted: i=1; AJvYcCWE6xCtmQtCWnZ3a+cXkYYbBEF+cTH2YS8wyFZdyaaCWRX0+AKs2wjAHYJNEF1p+VLtjZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJY35ROQEGvYPeATM2vJt/BH9frP7SR3QtAdHzugaD7W/FWMax
	C23cYRZ2LL+b+N+HtaW7u8GI/IlvvNtTQhXqKCPELC0isA9/39M+16sNl6XiX9Z+Du8=
X-Gm-Gg: ASbGncth4zq6ABgRDCOUEme4qQ4kIeRhV9hXjC/8mO0Rw8A5TeIAyMg6UwHa5xWW/Dn
	Aodft5hdxs77MpqLoHMAUy5uOTgS6Tt/OFWlMQPBcwymNQ1uqn1hHTq18YG0KFlCXOR7meHGd42
	SdyUjFTKirwS5tYhF2eWgNVesj37cJHgudOrzAx7o1z34q71vgLAqN6b7UEs+uBxaLj/t+GSfXW
	fTwkJrMPF0TunByhd95TAavhrTYLH1gmtZW0wwNwti0Q4yx4q7A+UU0r6EnnJR3mNhkMczug/lh
	MAw+8uXF/pZgy93GFU8gU7lPkE8sDYQQLu+nuB0v
X-Google-Smtp-Source: AGHT+IFhjU9YgCkKX/W7AlHjSgNtaoHVqxi7E0v23gqepaBq+8zMR/9FQcqI9m81n6pHLdIvvWbjSw==
X-Received: by 2002:a05:6a00:3a21:b0:730:9a85:c931 with SMTP id d2e1a72fcca58-747c0efa956mr2096680b3a.7.1748640677098;
        Fri, 30 May 2025 14:31:17 -0700 (PDT)
Received: from t14.. ([2607:fb91:20c7:44b2:2a24:2057:271e:f269])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afed4399sm3496763b3a.77.2025.05.30.14.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 14:31:16 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v2 bpf-next 01/12] bpf: tcp: Make mem flags configurable through bpf_iter_tcp_realloc_batch
Date: Fri, 30 May 2025 14:30:43 -0700
Message-ID: <20250530213059.3156216-2-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250530213059.3156216-1-jordan@jrife.io>
References: <20250530213059.3156216-1-jordan@jrife.io>
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


