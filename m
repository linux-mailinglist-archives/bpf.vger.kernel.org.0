Return-Path: <bpf+bounces-19344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1219982A3C0
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 23:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4FAD1F21B06
	for <lists+bpf@lfdr.de>; Wed, 10 Jan 2024 22:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BD34F8A0;
	Wed, 10 Jan 2024 22:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDTPFCJS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17544F881;
	Wed, 10 Jan 2024 22:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d4a980fdedso41415795ad.1;
        Wed, 10 Jan 2024 14:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704924089; x=1705528889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twPV4Qpu6bkGv+A13sRVdLLCnNw5osSpmpxOd4tw13w=;
        b=EDTPFCJS3ssARX9hfzbj+4eI9rWKq+nPe/nG8oEHkIwJNXP3gxsqysC+LfOCbkB37y
         M0F3Ub9ibOg8FwRKmIqzu8GpsrTlv9qqA5CVqiEjPh+YSUvN3BcCTAxxCkh7PMd4Jh3M
         sMQICydQTTdXLacR+6vamJLNxgUi5Iv0DvsQJ+ExINA9fE6pOhVXJD6xLbjMruh2jFgk
         KZw64VmiLUr6hz8t8gKxnvhJlQOR4h2c8aAUYBqpKhGD3ruRmYg3dtveEenc+4ALwcC3
         KF81hkmPq3i/y+XRVhkuH+HSY+VY+ZnlLm0DrJjSTwZIfl310f02JlYLRVtQlRMk7XRy
         5QLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704924089; x=1705528889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=twPV4Qpu6bkGv+A13sRVdLLCnNw5osSpmpxOd4tw13w=;
        b=YceLHcyjFWvkeTufb9NXQ2bAHqfQgMdItltQNnhLxeRmDiy01JzVXoWnZ8vpLeyXuj
         gBxHEhGLtbnJPBNSX4kSY/JiRzwaEmugRybXgbZ+XwEyYj5xLBLuiP0Y2F5WyX/RmbTB
         alNorojD4igj+qWqg3W6DXrw/azMf6ny/QxWVpXqQNqMl6nnSPJxJmhudHOf8puA0o70
         D02/gVjA3NrapoLF16J55n8edS/s176cVMQ5534+On9/GWcQ2vDjFDcEOtdJOWnnV7P3
         0wDrVYfZkhilmyvgpvxgGD9jxOpJ4goqmnbmBDaePuIeWOrx73kpCH6qphaDLe/rDPjm
         k8cw==
X-Gm-Message-State: AOJu0Ywi7Dhba1SMcbiUwBIcY5rtFNjy55Ot8W8JbWsEWsC+n4/6oqpU
	0r3IrBTQbEJ3ddFMfNh3BmITa5GZN7Y=
X-Google-Smtp-Source: AGHT+IFfv8OifM8nvSGGyiTPnfpwYhm6tGIpgXXhQccczsMgBt5FCGrNN1FjuuJBPpk7EDx9RlPDxQ==
X-Received: by 2002:a17:902:f542:b0:1d4:cd56:a5 with SMTP id h2-20020a170902f54200b001d4cd5600a5mr150921plf.53.1704924089501;
        Wed, 10 Jan 2024 14:01:29 -0800 (PST)
Received: from john.. ([98.97.116.12])
        by smtp.gmail.com with ESMTPSA id jk5-20020a170903330500b001d05433d402sm4130130plb.148.2024.01.10.14.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 14:01:27 -0800 (PST)
From: John Fastabend <john.fastabend@gmail.com>
To: netdev@vger.kernel.org,
	eadavis@qq.com,
	kuba@kernel.org
Cc: john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	borisp@nvidia.com
Subject: [PATCH net 1/2] net: tls, fix WARNIING in __sk_msg_free
Date: Wed, 10 Jan 2024 14:01:23 -0800
Message-Id: <20240110220124.452746-2-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240110220124.452746-1-john.fastabend@gmail.com>
References: <20240110220124.452746-1-john.fastabend@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A splice with MSG_SPLICE_PAGES will cause tls code to use the
tls_sw_sendmsg_splice path in the TLS sendmsg code to move the user
provided pages from the msg into the msg_pl. This will loop over the
msg until msg_pl is full, checked by sk_msg_full(msg_pl). The user
can also set the MORE flag to hint stack to delay sending until receiving
more pages and ideally a full buffer.

If the user adds more pages to the msg than can fit in the msg_pl
scatterlist (MAX_MSG_FRAGS) we should ignore the MORE flag and send
the buffer anyways.

What actually happens though is we abort the msg to msg_pl scatterlist
setup and then because we forget to set 'full record' indicating we
can no longer consume data without a send we fallthrough to the 'continue'
path which will check if msg_data_left(msg) has more bytes to send and
then attempts to fit them in the already full msg_pl. Then next
iteration of sender doing send will encounter a full msg_pl and throw
the warning in the syzbot report.

To fix simply check if we have a full_record in splice code path and
if not send the msg regardless of MORE flag.

Reported-and-tested-by: syzbot+f2977222e0e95cec15c8@syzkaller.appspotmail.com
Reported-by: Edward Adam Davis <eadavis@qq.com>
Fixes: fe1e81d4f73b ("tls/sw: Support MSG_SPLICE_PAGES")
Signed-off-by: John Fastabend <john.fastabend@gmail.com>
---
 net/tls/tls_sw.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index e37b4d2e2acd..31e8a94dfc11 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1052,7 +1052,11 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 			if (ret < 0)
 				goto send_end;
 			tls_ctx->pending_open_record_frags = true;
-			if (full_record || eor || sk_msg_full(msg_pl))
+
+			if (sk_msg_full(msg_pl))
+				full_record = true;
+
+			if (full_record || eor)
 				goto copied;
 			continue;
 		}
-- 
2.33.0


