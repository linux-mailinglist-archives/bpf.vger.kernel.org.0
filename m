Return-Path: <bpf+bounces-50227-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F94DA2434E
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 20:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD5563A86D5
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 19:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43341F3FF0;
	Fri, 31 Jan 2025 19:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8Ofc1j3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A151F3D55;
	Fri, 31 Jan 2025 19:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738351770; cv=none; b=HATi4OYON3LYGpnGAKn1CjP3HBiLrerxtxvSiy1Q/hRYDCz1Rqv++duDmPWg7Nam2cp1bV5LrMSwjXziqnafdI4ooOMF1vne5o6s20EYmi2UjL6cZ2jT6SqtobQ6IsLUrsXmiHlfi+Sq8DUUi3i3Yx1zBn2ptlUcRY/ZPBkP6W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738351770; c=relaxed/simple;
	bh=eB27qpGeHbnL+g+H5i6dwyeK5gEdO4WsfdSVSblw4mA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=caz2dg5ViFtvUh6OZlIExp8q1dyojSL8Q3XVz3FCXaU7Fxoqac0fUDt6yMFejOV7imuQ9VzmfXQk1A3j0SJGzku3huQBvqUo8YIy6LWZOEAoqXMJbVV9j+bLBjdgHBlPgal3tkJ08GHA3glHgE+iCFBNvFY+BlfqGgfH8OtPlOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8Ofc1j3; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2efb17478adso3986916a91.1;
        Fri, 31 Jan 2025 11:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738351768; x=1738956568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bqaa0Rde68BkHu0sINbJqayYMFBgLoQtb5xV4LwmnQE=;
        b=N8Ofc1j3YPYVV5dx8UkQYNWEEJa+Pl2xYNgZLHTRPTxjYK9r4ObLBdilL6llZw+Ofw
         VtFADOUhde8R+2LtBdO9QfL8mMMSSaHVRxGcEpjyKHgNPpHxZ0pOL41jigpIWvlLGwhH
         x5FjNEaS6dVxX367kd8hkHtlxcKGJGORq35XrbTrvVedBWnTDoYSv6rXDFc8+3+mskMB
         VyuK1T20hzeaNpH5zqeA4oY5s6SFYPp/6vVrhe6g5IQHWfSAaaMY0FxTMjxrhJ7+k+Pb
         g6fXXRTykJMU71zLVmJTIBU7uE/D2ULUF0v2sqPt/hcxG+OaN9ZgSZNPvvjBoscBmwIf
         zg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738351768; x=1738956568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bqaa0Rde68BkHu0sINbJqayYMFBgLoQtb5xV4LwmnQE=;
        b=auiYjSJSKN4Z+xAuNSgxEPJ8XkD9NzxrPyNHdoaMXu/+Io0BFkElZ+k+0cqWtPDtdB
         KahwmFzkie7DgGNZsXV8TZ169gSHtY4JbBDnkuEqoevwiTP4TKu6dU2v2N27heYeQUnE
         kh8/o9zB5EdwiXNQCo8NSHhN5Uia0ANM7XgXEUdLuoUUlCK1v2KA06oiDyb0orZmvRiT
         b7geEu2q5p8d5qKFYahG/V6e3X5+SThGO5phhcxEm1xgybMhDkQ0vGdC4w86RQRAS+7g
         /+NulM9yuLwY+J7Np2b/forSo5wt5CWesiTmCPzWyACDfegpfVfDi3du9VazzNeWn1XQ
         QOTQ==
X-Gm-Message-State: AOJu0YzOMJwVNagY+7/rkvce8jpntcQQ8ntn1Eor5uRK7qlWhAE4M5kS
	g9lkDDC0eAROHsj+ZItHg7nZEz2KKVEKkWC+WexvZyU0kH/Vom65/Nzhn7N2GfQ=
X-Gm-Gg: ASbGncupySc7FBbqZoS0rOCOD6MQ8zqdPobLHqIzdFfQkUNh16l34WJQ8tI4VRCa9Ek
	iWaL5lrNTUbYz7FIzTSUQaxUnYGn4MDYnBKYNXBjR3YMZ8EW5vNyDWPsTnqZRDT/dwAEx09UJwr
	07sXzf3wi8uP/VB2Z31zMVz5iA5X+mE8UBbXEtf3j4kEb6mrzfLR1PcHml2w5lGCB3A2swF4f7/
	QcETFjSek5eHK7Qg6BJH6a6ssb1OK/Vw8fKQF26cmG5evCXTnBLVy63W5bVws1kCp4FjAPJOrCY
	23CSh2ojFI4LR+FdK32y4Djcy64+EPxeYxIyWL+GWcC9GuD14jA3iKMoxXOVXG+d4g==
X-Google-Smtp-Source: AGHT+IGVenGNd/dfn6AvA05UbGO7TXBtSAlcuE855ntas1bUVivwV4lFPxVwe/xRfi4J2tQy7I/iUg==
X-Received: by 2002:a17:90b:53c8:b0:2ee:8430:b847 with SMTP id 98e67ed59e1d1-2f83abb34f2mr17396071a91.6.1738351767958;
        Fri, 31 Jan 2025 11:29:27 -0800 (PST)
Received: from localhost.localdomain (c-76-146-13-146.hsd1.wa.comcast.net. [76.146.13.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f8489d3707sm4072471a91.23.2025.01.31.11.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 11:29:27 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	kuba@kernel.org,
	edumazet@google.com,
	xiyou.wangcong@gmail.com,
	cong.wang@bytedance.com,
	jhs@mojatatu.com,
	sinquersw@gmail.com,
	toke@redhat.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com,
	ming.lei@redhat.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 06/18] bpf: Prepare to reuse get_ctx_arg_idx
Date: Fri, 31 Jan 2025 11:28:45 -0800
Message-ID: <20250131192912.133796-7-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250131192912.133796-1-ameryhung@gmail.com>
References: <20250131192912.133796-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename get_ctx_arg_idx to bpf_ctx_arg_idx, and allow others to call it.
No functional change.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 include/linux/btf.h | 1 +
 kernel/bpf/btf.c    | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 2a08a2b55592..ce057c6b3947 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -519,6 +519,7 @@ bool btf_param_match_suffix(const struct btf *btf,
 			    const char *suffix);
 int btf_ctx_arg_offset(const struct btf *btf, const struct btf_type *func_proto,
 		       u32 arg_no);
+u32 btf_ctx_arg_idx(struct btf *btf, const struct btf_type *func_proto, int off);
 
 struct bpf_verifier_log;
 
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index fd3470fbd144..ca5779f6961b 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6370,8 +6370,8 @@ static bool is_int_ptr(struct btf *btf, const struct btf_type *t)
 	return btf_type_is_int(t);
 }
 
-static u32 get_ctx_arg_idx(struct btf *btf, const struct btf_type *func_proto,
-			   int off)
+u32 btf_ctx_arg_idx(struct btf *btf, const struct btf_type *func_proto,
+		    int off)
 {
 	const struct btf_param *args;
 	const struct btf_type *t;
@@ -6549,7 +6549,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 			tname, off);
 		return false;
 	}
-	arg = get_ctx_arg_idx(btf, t, off);
+	arg = btf_ctx_arg_idx(btf, t, off);
 	args = (const struct btf_param *)(t + 1);
 	/* if (t == NULL) Fall back to default BPF prog with
 	 * MAX_BPF_FUNC_REG_ARGS u64 arguments.
-- 
2.47.1


