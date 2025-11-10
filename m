Return-Path: <bpf+bounces-74060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E3BC4677A
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 13:08:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86E363A6645
	for <lists+bpf@lfdr.de>; Mon, 10 Nov 2025 12:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206B830C376;
	Mon, 10 Nov 2025 12:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byzk09CR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5340306B00
	for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 12:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762776437; cv=none; b=ehF5aY2EonNLdbxA5YYSO8Y8Zu42hrRGCC7HiXmr+c584fFIlqb8xM4ygj2NMPwrSp8FtVSaDliBinZuiNqMskzNEF0Jt+c+HM5zrHbwH7jLAjR/BzxwAhil99uaAtgjr936COe793+M7ari/3j2Hq8ETuInX6omIjoFH0bDVrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762776437; c=relaxed/simple;
	bh=dRoo4cFVL7Ocw60j1tmLa3QBdesE2MYmaRPEaYNEQIE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ekEWk23h2M1WkpKWdvcgg8ZSfxbdiWl9S74np0rKsYlubFahxPzXAzc8rCNl/BxTPchHtAYsuAmctuANKqOQoCR7eVOEWvN5/aiDlhiptx3w1Vfz0WRdBoc4Cl6L6FZFe0yGf2qCS9Yoo8wmvcmL1G93TlMosk6DrIRDXXO+9eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=byzk09CR; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-7a9c64dfa6eso2232642b3a.3
        for <bpf@vger.kernel.org>; Mon, 10 Nov 2025 04:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762776435; x=1763381235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SMXINWsiwquzf7zva0iiicsqTWZLMP3VWQae5zvto4o=;
        b=byzk09CRsyKaHmwsNsemDhOjlGaf8dlZlNUBFq5qlPopUdrDa2hYUi4E2EzAPH1VWl
         1ZiXeRb/XVwJeXN4gvOONZbNZn1+s+EobhJwT4KGn1gOAZaxYWutVhk+m002kjyFUe0F
         EqR436iVkMPNJq9O5iXrtZlmHQZ0Mv+XL/w8JaN9t5JvMBoKRJMKxh++jn9KzNt1RuMo
         +tJeCdpTCJpGP7DvALG9QRmycfRcG7zIpPmv+lw8Wa2v/qxkvyDZYmkBTRaMw4PZ9853
         ulEjFDTvqk5DQw1VuzVLjIk/K0YExuIRoSS+f6kEq72edBTBQvzuXsFokh0+5fsVhIIN
         NSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762776435; x=1763381235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMXINWsiwquzf7zva0iiicsqTWZLMP3VWQae5zvto4o=;
        b=SUT8RZ6RcnlJzA1rB5fUcLRAAfgYtyojSDv1VUyJIdCeOJ+yJTYplsYSNKsDvNwTsY
         TdFDWIyRACuPUZ8+VbexQ7G7/o+k0u/IwZA0Ud+/lC8+tMsrQ4v3PpdvDsdb2n5yRb0+
         Wd5fCqSC3gxozTPTMspx2gu9WwAKZBfb2ITHXS6Zf8xSjpfMVJGm5CZ28M2r4DrjA0ir
         wPqF9uy70riFh60Lj2IZN52PNEFqbMaL0mxzFgoJKeMtlr7xS6AIbSc07XXuhUOhk+jh
         2586Yovy2rdQLv9DpxkyzMMCYn/dM5lJvPf9OjOqx/YRr6QTUAHsgSyZy56jVnsJK9IG
         oUFg==
X-Forwarded-Encrypted: i=1; AJvYcCWcjSLPLIiYESxWmgkzLe/QAx1RZh6J48UY9Gyb8ZO+3TpEsgzcJJHLXbIJFnpRqsZnf8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRRdZQgjeCTvqLXK1mWdzoQ4WbCYPz7wxmeD34N1ivbRQhV71K
	6OYW/C13D7SHKENSWuGXRSajTEQWq0GZocnlN52+QSGQbqwjEAUXqSTw
X-Gm-Gg: ASbGncskNSxl19eD59cuFLn4lFPnZuIunLXthLqAxW2zXB7VLPUB1O/U+UJbCwBvy5l
	Of825IUiIQruKOdOJ62ZIdgtZGlLj0o4TUUMjB5wzs/qHYXtHYfzTj6cMiiPhzK6UUnLOmJsOy/
	r7Y9xIg3ot5d0mkKIy3SIydu+PNZ8ZI1pQY5MVVqd9c+qjI0IcqGvkaWjReFk8WH6QoUbL7WIV/
	WsHyuk/eegZlUJRO03Xr8ZKaLMqoKLv2vv9tJZ2S1M+czT+f9AYggdrpsJBqjjB35kfFG75fSPn
	x6GbcM5CLeefoPLLHR50aCcKtTTkz2yYusajKyEMwXSkakt9TW5ALHdaOYvaVkcGrPEXJdPSMGZ
	zf56YjkQw/SDk/cAsndMEJerjfe5f3RhUrS2YwxwGzken8HgWfA8eopQuEiI1FLMFCjh4O4NQK8
	blhX45W9LiUUI=
X-Google-Smtp-Source: AGHT+IEhUhNrBR5qD3O1r2CNUoK+UFydKetEVVBjgOZbejdTK4keYOoTQYNPxN6cDLySB1fEFtkDNg==
X-Received: by 2002:a05:6a00:883:b0:7ab:f72e:8faa with SMTP id d2e1a72fcca58-7b226d88295mr11564067b3a.27.1762776435011;
        Mon, 10 Nov 2025 04:07:15 -0800 (PST)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0cc17b0c4sm11779739b3a.48.2025.11.10.04.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 04:07:14 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	song@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf] bpf: handle the return of ftrace_set_filter_ip in register_fentry
Date: Mon, 10 Nov 2025 20:07:05 +0800
Message-ID: <20251110120705.1553694-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The error that returned by ftrace_set_filter_ip() in register_fentry() is
not handled properly. Just fix it.

Fixes: 00963a2e75a8 ("bpf: Support bpf_trampoline on functions with IPMODIFY (e.g. livepatch)")
Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 kernel/bpf/trampoline.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 5949095e51c3..3610c6db15ee 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -220,7 +220,9 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
 	}
 
 	if (tr->func.ftrace_managed) {
-		ftrace_set_filter_ip(tr->fops, (unsigned long)ip, 0, 1);
+		ret = ftrace_set_filter_ip(tr->fops, (unsigned long)ip, 0, 1);
+		if (ret)
+			return ret;
 		ret = register_ftrace_direct(tr->fops, (long)new_addr);
 	} else {
 		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, NULL, new_addr);
-- 
2.51.2


