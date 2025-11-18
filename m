Return-Path: <bpf+bounces-74830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DA8C66BDD
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 01:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9DBE44E5C2E
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 00:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9313009FA;
	Tue, 18 Nov 2025 00:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="mWINoDV4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686C52F7ACB
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 00:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763427197; cv=none; b=BY+5WVJ4TpMSuen3KMuiMgLtcbrJIofathHNIl2CNq9LiW3YSyVO3Gxo6XltycvygLl1fxAPXG8IgD0EXjtK0s6paqHr/5wVPmy1wlSN/q8BljVdQAhgjfPInj5fukn/9FcdgQ2l+SaghSjpWCdKHD/6Cc9xBSOWrktHfDN0Fxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763427197; c=relaxed/simple;
	bh=jt9WKX1uERfxJ/zhVyFnKQ1xA4vxy7qQ/dPEiwgeuVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XprGeqx6foXqPAMmR5/NoPSHdFkl219FIwdlYUUN/ZpOUkSwGtvg7jTSNJWBmor1Kw4mEZXCy/YLhjvgC519SfFigREQNp9e9wkeSS9zrG17kJfUqV0EEiVTZQYlpvtiL4tx+snbePrRdaMr3AFwAwZdfGdCDyXfJgkmZXfE3dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=mWINoDV4; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7baa5787440so157429b3a.0
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 16:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1763427194; x=1764031994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hcuRUUrpMUmurCMk/WunQ3qmMdUvqKgEyZujMl9eoWo=;
        b=mWINoDV4/q2iMKSqN5qBthWtyldxqxOWW7gj26v6qPhjgVTbqA5I77gYytFDfuz1OU
         mlh0r3oyDkWOF+gAwpqonTt7zOeYIfN7Tp27xKbCwUrXgW6ztz//4BDxev5KD7AUFm6+
         oej0mxpX5asOaa6gj10NgPCt5Gur53rxRZ7EQLi4UpNmpMeYvTOzT6rPfn3MHWs6aNa6
         qqXvEhoR0FWgThUpXqHzr98Jrn+1comvaGglxM3oJW5tMHQLnvCg9qP6v6O/LjTnND+Z
         NMehJDhtnCOayDTJzQuE8svVMtaUofZxQGbraT9aSFKS425HtbfbCJVtma1qY0tWLPsg
         QIUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763427194; x=1764031994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hcuRUUrpMUmurCMk/WunQ3qmMdUvqKgEyZujMl9eoWo=;
        b=TBoRSMvJvdFWItUYRd5F2fB3HwlcV58FJa162q1CJN+hVBuwIDNoSmGq/QuEJqSM+V
         iuY7tKwhdyIkBYJI2zlW6N4xWa4lnvzhW5Lmw3rGX7O/rIxsr3tMZKDYwtVVMpTS9e/7
         UwK55/v2fqPa94z1OzbpqO4S36NhL3pSbCNXzK0jM5IhUTK9NRh7pHom+EI10S/O9CEE
         AOrs7OkGZsNwYLvAPX9dBSNfuLU+oP6hJMWyjBZ5uK0SMSzEaGs2mFr5nr4RyvQy5sqg
         F0SEj+9X5Ex8UjHNyNjD5D/3VKDSGUy5VWgL8Yo7Ym8nJjSU33yqpVY1w8Xv/KCTxa91
         sHyg==
X-Gm-Message-State: AOJu0YyfmhwTASbaOAHXrrko3HranxQ4ByBPcHDGXLjr7iMP2mF3dnil
	jhpLUTyMQWwfgg5+Fhv9J4wmcjBabJxDpSxoU0yJUKQv9nc2cWXFsqGR8CwwAtL1JVybojQX1bQ
	Y1vlo
X-Gm-Gg: ASbGncs+FnUdVs7k9Nj8v9guSIR0apiPiiOIXHMPJ2dQWRUlLSKACMJ4UNbRB5nP9Vs
	IaX+ULThPR2c9N0TFb10cvFQEIpTbnyXdAwYVh3o1yLrph/mauQKc7ILZom/hOITdGVLNkIF9b5
	LCDjnUJX9KDbJ9jYkrosXjpLoAQf/Kx2bcvge3AWJ42bzA+VhDLc9Yp6Ia/LLBZ/xmZxsVCjcqQ
	2Hfx0jFfMWJ+jFsXiccQYSKKaj6DsFD2s7kzJp+9mmzMOF0gyfsckllAuITXlw/FS0o4naxS+N9
	feaYeNK7tfDXHK95U6LDrcO4wOca0AfFeKKj1h+xn4Wco/nUHwhfVPug8l5o5QnY38imGh7jCnk
	DSENuo6ivVp/vmHy/jiMosbqa6xq3h+kzkGVl5l/ZMEzFnsJM4CpHHrNLLuEeijWO
X-Google-Smtp-Source: AGHT+IHKa0TQpIk3ZCC102SD0uVPqHW4J3CaGovuSZooSd+82JPVtQAFEykilK1Fg8MDDO7aWQzABg==
X-Received: by 2002:a05:7022:b92:b0:119:e55a:95a3 with SMTP id a92af1059eb24-11c796a9cc6mr281075c88.5.1763427194062;
        Mon, 17 Nov 2025 16:53:14 -0800 (PST)
Received: from t14.. ([2001:5a8:47ec:d700:ef59:f68f:7ffe:54f2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a49d9ead79sm67568555eec.1.2025.11.17.16.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 16:53:13 -0800 (PST)
From: Jordan Rife <jordan@jrife.io>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	linux-arm-kernel@lists.infradead.org,
	linux-s390@vger.kernel.org,
	x86@kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>
Subject: [RFC PATCH bpf-next 2/7] bpf: Enable BPF_LINK_UPDATE for freplace links
Date: Mon, 17 Nov 2025 16:52:54 -0800
Message-ID: <20251118005305.27058-3-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118005305.27058-1-jordan@jrife.io>
References: <20251118005305.27058-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement program update logic for freplace links.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 kernel/bpf/trampoline.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 010bcba0db65..0b6a5433dd42 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -614,6 +614,21 @@ static int __bpf_trampoline_update_prog(struct bpf_tramp_link *link,
 					struct bpf_prog *new_prog,
 					struct bpf_trampoline *tr)
 {
+	enum bpf_tramp_prog_type kind;
+	int err = 0;
+
+	kind = bpf_attach_type_to_tramp(link->link.prog);
+	if (kind == BPF_TRAMP_REPLACE) {
+		WARN_ON_ONCE(!tr->extension_prog);
+		err = bpf_arch_text_poke(tr->func.addr, BPF_MOD_JUMP,
+					 tr->extension_prog->bpf_func,
+					 new_prog->bpf_func);
+		if (err)
+			return err;
+		tr->extension_prog = new_prog;
+		return 0;
+	}
+
 	return -ENOTSUPP;
 }
 
-- 
2.43.0


