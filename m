Return-Path: <bpf+bounces-19499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4C882C867
	for <lists+bpf@lfdr.de>; Sat, 13 Jan 2024 01:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E628B22F5E
	for <lists+bpf@lfdr.de>; Sat, 13 Jan 2024 00:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F402A107AA;
	Sat, 13 Jan 2024 00:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tys6gv/h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C3EF4F9;
	Sat, 13 Jan 2024 00:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6e0a64d9449so544862a34.2;
        Fri, 12 Jan 2024 16:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705105982; x=1705710782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lHteaZbYIt3DkRc+UM6Ay3q+ahKAfTLz4hpmurqAk4U=;
        b=Tys6gv/hjNDHkqtbHe1l9sMfB9UF1tlBA6bULWfpcnQy/euB7WAHWcJSy2A+wrKQ40
         MRCwLm9JnI5lUmRCcO/+RxpcIXrrhsI0tEp+NbQprZAEcflt8CMHEA7jOqLnYFH5O3oP
         auIL/cUaS7EzizyYN6SN46UjscJ32odaDGMZKxbOT3hAmSmPnE6jqmRcjwK4Af+KNBJO
         NGF3hSB0lAAK/TMFDGwOcjFHNqYra0RkXjzybHoh0+7RuPJN0bbrrU8bCGJEpaMuYql9
         Ompch0Q2ZottkXPjoBfCtxqSTL8HPhnQJUeQUbbWNbNPaTBIp53HyV3zgbIvFvJd3r5o
         ydVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705105982; x=1705710782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lHteaZbYIt3DkRc+UM6Ay3q+ahKAfTLz4hpmurqAk4U=;
        b=qVo/voOrCYNAByMkDHVTNOZ+B1Ie7PxwUYKze8EUwCZAC3fLHq0MzGzSnfI+T7eRz+
         6A8rDGxxyPj9p/DKOhIqBC8nbc/iMZYj77rFviyHcenBk6K/vGHAvhd89iklj6tZ786Z
         HPa5/ch0Fr11zllWLoituOxMyGyi9k3dl3Gn1FeQukthz7UHnz3WjGoIf7HcZxz4kkvT
         vsdFV33rZuon2U/JlxI6n06mJyh0WGlEB6NYOjY/FKg+g375PtecAwVdvNyQF4PwNd0q
         B5uhmLs22aqbMeJ6oGC/rbxKLZruk9AzsAvGKDO+JR4LCRmpyFpZX7h2PZRdxSrvjfFk
         enZA==
X-Gm-Message-State: AOJu0YyATx2/Wix2QKfWk4ujDgPAHNPs9DbEunFQchtsW9iNNWppM8Wl
	8xbfAmZzJJ7HFZsBUPQOQcINGTcuikE=
X-Google-Smtp-Source: AGHT+IEOWlIikG/Ni5c2xjpWA+JEh9Cm1fBM4ylF2YonpxilKHs6oY8ayaNBH9tXPQ+ccT10lx6CoQ==
X-Received: by 2002:a05:6830:128a:b0:6db:fee1:f4a8 with SMTP id z10-20020a056830128a00b006dbfee1f4a8mr2795203otp.2.1705105982143;
        Fri, 12 Jan 2024 16:33:02 -0800 (PST)
Received: from john.. ([98.97.116.126])
        by smtp.gmail.com with ESMTPSA id x8-20020aa79a48000000b006d9b35b2602sm3707914pfj.3.2024.01.12.16.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 16:33:01 -0800 (PST)
From: John Fastabend <john.fastabend@gmail.com>
To: netdev@vger.kernel.org,
	eadavis@qq.com,
	kuba@kernel.org
Cc: john.fastabend@gmail.com,
	bpf@vger.kernel.org,
	borisp@nvidia.com
Subject: [PATCH net v2 1/2] net: tls, fix WARNIING in __sk_msg_free
Date: Fri, 12 Jan 2024 16:32:57 -0800
Message-Id: <20240113003258.67899-2-john.fastabend@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240113003258.67899-1-john.fastabend@gmail.com>
References: <20240113003258.67899-1-john.fastabend@gmail.com>
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
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
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


